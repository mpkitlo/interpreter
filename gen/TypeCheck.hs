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
    funNum :: Int,
    varEnv :: Map.Map VarId (VarT, Int)
} 

insertVar :: Env -> VarT -> VarId -> Env
insertVar (Env cB vE) vT vId = Env cB (Map.insert vId (vT, cB) vE)

-- insertFun :: Env -> FunT-> FunId -> Env
-- insertFun (Env cB fE vE) fT fId  = Env cB (Map.insert fId (fT, cB) fE) vE

handleDecl :: Decl -> TC Env
handleDecl (VarDecl _ vT vId) = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> return (insertVar env (getT vT) vId)
        Just (vT', fNum) -> if funNum env == fNum
            then throwError VarDeclErr
            else return (insertVar env (getT vT) vId)    

handleDecl (VarDeclAss _ vT vId expr) = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> return (insertVar env (getT vT) vId)
        Just (vT', fNum) -> if funNum env == fNum
            then throwError VarDeclAssErr
            else return (insertVar env (getT vT) vId) 

handleDecl (FnDecl _ fT fId args block) = do
    env <- ask
    Env num e <- case Map.lookup fId (varEnv env) of
        Nothing -> return (insertVar env (getT fT) fId)
        Just (fT', fNum) -> if funNum env == fNum
            then throwError FnDeclErr
            else return (insertVar env (getT fT) fId) 
    let funEnv = Env (num+1) e
    
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
