module TypeCheck where

import AbsGrammar
import ErrM
import Control.Monad.Except
import Control.Monad.Reader 
import Control.Monad.Trans.Except

import qualified Data.Map as Map
import Control.Monad.RWS (Any(Any))
import Control.Exception (handle)
import Foreign.C (throwErrno)
import Language.Haskell.TH (valD)

getT :: Type -> VarT
getT (Bool _) = BoolT
getT (Int _)  = IntT
getT (Str _)  = StringT
getT (Void _) = VoidT

data TypeT = BoolT | IntT | StringT | VoidT deriving Eq 
type ArgsT = [TypeT]
type RetT = TypeT
type VarT = TypeT
type FunT = (ArgsT, RetT)

type FunId = Ident
type VarId = Ident

type TC = (ReaderT Env (ExceptT TCError IO))

data TCError 
    = VarDeclErr 
    | VarDeclAssErr
    | FnDeclErr
    | WrongMainErr
    | MissingMainErr

instance Show TCError where
    show VarDeclErr = "VarDeclErr"
    show VarDeclAssErr = "VarDeclAssErr"
    show FnDeclErr = "FnDeclErr"
    show WrongMainErr = "WrongMainErr"
    show MissingMainErr = "MissingMainErr"

data Env = Env {
    blockNum :: Int,
    varEnv :: Map.Map VarId (VarT, Int)
} 

insertVar :: Env -> VarT -> VarId -> Env
insertVar (Env cB vE) vT vId = Env cB (Map.insert vId (vT, cB) vE)

-- insertFun :: Env -> FunT-> FunId -> Env
-- insertFun (Env cB fE vE) fT fId  = Env cB (Map.insert fId (fT, cB) fE) vE


argToDecl :: Arg -> Decl
argToDecl (ValArg a t id) = VarDecl a t id
argToDecl (RefArg a t id) = VarDecl a t id

handleStmt :: Stmt -> TC (Maybe VarT)
handleStmt (Empty _) = return Nothing
handleStmt (BStmt _ block) = return Nothing
handleStmt (Ass _ vId expr) = return Nothing
handleStmt (Ret _ expr) = return Nothing
handleStmt (VRet _) = return Nothing
handleStmt (Cond _ expr block) = return Nothing
handleStmt (CondElse _ expr block block') = return Nothing
handleStmt (While _ expr block) = return Nothing
handleStmt (Break _) = return Nothing
handleStmt (Continue _) = return Nothing
handleStmt (SExp _ expr) = return Nothing
handleStmt (Print _ expr) = return Nothing

handleBlock :: Block -> TC (Maybe RetT)
handleBlock (Blk _ stmt) = do
    

    stmtAll <- mapM handleStmt stmt
    if 

    if null ssRet
        then return Nothing
        else if and $ map (== head ssRet) (tail ssRet)
            then return $ head ssRet
            else throwError VagueBlockT


handleDecl :: Decl -> TC Env
handleDecl (VarDecl _ vT vId) = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> return (insertVar env (getT vT) vId)
        Just (vT', fNum) -> if blockNum env == fNum
            then throwError VarDeclErr
            else return (insertVar env (getT vT) vId)    

handleDecl (VarDeclAss _ vT vId expr) = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> return (insertVar env (getT vT) vId)
        Just (vT', fNum) -> if blockNum env == fNum
            then throwError VarDeclAssErr
            else return (insertVar env (getT vT) vId)             

handleDecl (FnDecl _ fT fId args block) = do
    env <- ask
    Env num e <- case Map.lookup fId (varEnv env) of
        Nothing -> return (insertVar env (getT fT) fId)
        Just (fT', fNum) -> if blockNum env == fNum
            then throwError FnDeclErr
            else return (insertVar env (getT fT) fId) 
    let funEnv = Env (num+1) e
    funEnv <- local (const funEnv) (handleDecls (map argToDecl args))

    return (Env num e)

handleDecls :: [Decl] -> TC Env
handleDecls [] = ask
handleDecls (x: xs) = do
    env <- handleDecl x
    local (const env) (handleDecls xs)

evalProgram :: [Decl] -> TC ()
evalProgram d = do
    env <- handleDecls d
    case Map.lookup (Ident "main") (varEnv env) of 
        Just (fT, _) -> unless (fT == IntT) $ throwError WrongMainErr
        Nothing -> throwError MissingMainErr

typeCheck :: Program -> ExceptT TCError IO ()
typeCheck (Prog _ d) = runReaderT (evalProgram d) (Env 0 Map.empty)
