module TypeCheck where

import AbsGrammar
import ErrM
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.Trans.Except

import qualified Data.Map as Map

getT :: Type -> TypeT
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
    | VarNotDeclared
    | FunNotDeclared
    | WrongFunArgs
    | OperationError
    | ReturnError
    | IfCondError
    | WhileCondError
    | AndError
    | OrError
    | NotInLoop
    | PrintError
    | IfReturnVague 

instance Show TCError where
    show VarDeclErr = "VarDeclErr"
    show VarDeclAssErr = "VarDeclAssErr"
    show FnDeclErr = "FnDeclErr"
    show WrongMainErr = "WrongMainErr"
    show MissingMainErr = "MissingMainErr"
    show VarNotDeclared = "VarNotDeclared"
    show FunNotDeclared = "FunNotDeclared"
    show WrongFunArgs = "WrongFunArgs"
    show OperationError = "OperationError"
    show ReturnError = "ReturnError"
    show IfCondError = "IfCondError"
    show WhileCondError = "WhileCondError"
    show AndError = "AndError"
    show OrError = "OrError"
    show NotInLoop = "NotInLoop"
    show PrintError = "PrintError"
    show IfReturnVague = "IfReturnVague"

data Env = Env {
    blockNum :: Int,
    inLoop :: Bool,
    varEnv :: Map.Map VarId (VarT, Int),
    funEnv :: Map.Map FunId (FunT, Int)
}

insertVar :: Env -> VarT -> VarId -> Env
insertVar (Env cB iL vE fE) vT vId = Env cB iL (Map.insert vId (vT, cB) vE) fE

insertFun :: Env -> FunT-> FunId -> Env
insertFun (Env cB iL vE fE) fT fId  = Env cB iL vE (Map.insert fId (fT, cB) fE)

argToDecl :: Arg -> Decl
argToDecl (ValArg a t id) = VarDecl a t id
argToDecl (RefArg a t id) = VarDecl a t id

handleStmt :: Stmt -> TC (Maybe VarT)
handleStmt (Empty _) = return Nothing
handleStmt (BStmt _ block) = handleBlock block
handleStmt (Ass _ vId expr) = do
    t <- getVar vId
    t' <- handleExpresion expr
    if t == t'
        then return Nothing
        else throwError OperationError
handleStmt (Ret _ expr) = do
    t <- handleExpresion expr 
    if t == VoidT
        then throwError ReturnError
        else return (Just t)
handleStmt (VRet _) = return (Just VoidT)
handleStmt (Cond _ expr block) = do
    t <- handleExpresion expr
    if t == BoolT
        then handleBlock block
        else throwError IfCondError
handleStmt (CondElse _ expr block block') = do
    t <- handleExpresion expr
    if t == BoolT
        then do
            t' <- handleBlock block
            t'' <- handleBlock block'
            case (t', t'') of
                (Nothing, _) -> return t''
                (_, Nothing) -> return t'
                (_, _) -> 
                    if t' == t''
                        then return t'
                        else throwError IfReturnVague
        else throwError IfCondError
handleStmt (While _ expr block) = do 
    t <- handleExpresion expr
    if t == BoolT
        then handleBlock block
        else throwError WhileCondError
    
handleStmt (Break _) = do
    env <- ask 
    if inLoop env 
        then return Nothing
        else throwError NotInLoop
handleStmt (Continue _) = do
    env <- ask 
    if inLoop env 
        then return Nothing
        else throwError NotInLoop
handleStmt (SExp _ expr) = handleExpresion expr >> return Nothing 
handleStmt (Print _ expr) = do 
    t <- handleExpresion expr
    if t == VoidT
        then throwError PrintError
        else return Nothing 

getVar :: VarId -> TC VarT
getVar vId = do
    env <- ask 
    case Map.lookup vId (varEnv env) of 
        Nothing -> throwError VarNotDeclared
        Just (vT, block) -> return vT

getFun :: FunId -> TC FunT
getFun fId = do
    env <- ask 
    case Map.lookup fId (funEnv env) of 
        Nothing -> throwError VarNotDeclared
        Just (fT, block) -> return fT
    
getAppFun :: FunId -> [Expr] -> TC VarT
getAppFun fId args = do 
    (args', ret) <- getFun fId
    args'' <- mapM handleExpresion args
    if args' == args''
        then return ret
        else throwError WrongFunArgs

getArgType :: Arg -> Type
getArgType (ValArg _ t id) = t 
getArgType (RefArg _ t id) = t 


handleExpresion :: Expr -> TC VarT
handleExpresion (EVar _ vId) = getVar vId
handleExpresion (ELitInt _ _) = return IntT
handleExpresion (ELitTrue _) = return BoolT
handleExpresion (ELitFalse _) = return BoolT
handleExpresion (EApp _ fId args) = getAppFun fId args
handleExpresion (EString _ string) = return StringT
handleExpresion (Neg _ expr) = do
    t <- handleExpresion expr
    if t == IntT
        then return IntT
        else throwError OperationError
handleExpresion (Not _ expr) = do
    t <- handleExpresion expr
    if t == BoolT
        then return BoolT
        else throwError OperationError
handleExpresion (EMul _ expr1 _ expr2) = do
    t <- handleExpresion expr1
    t' <- handleExpresion expr2
    if t == IntT && t' == IntT
        then return IntT
        else throwError OperationError
handleExpresion (EAdd _ expr1 _ expr2) = do
    t <- handleExpresion expr1
    t' <- handleExpresion expr2
    if t == IntT && t' == IntT
        then return IntT
        else throwError OperationError
handleExpresion (ERel _ expr1 _ expr2) = do
    t <- handleExpresion expr1
    t' <- handleExpresion expr2
    if t == VoidT || t' == VoidT
        then throwError OperationError
        else
            if t == t'
                then return BoolT
                else throwError OperationError
handleExpresion (EAnd _ expr1 expr2) = do
    t' <- handleExpresion expr1
    t'' <- handleExpresion expr2
    case (t', t'') of 
        (BoolT, BoolT) -> return BoolT
        (_, _) -> throwError AndError
handleExpresion (EOr _ expr1 expr2)= do
    t' <- handleExpresion expr1
    t'' <- handleExpresion expr2
    case (t', t'') of 
        (BoolT, BoolT) -> return BoolT
        (_, _) -> throwError OrError

handleBlock :: Block -> TC (Maybe RetT)
handleBlock (Blk _ decls stmts) = do
    env <- handleDecls decls
    statementRet <- local (const env) (mapM handleStmt stmts)
    return Nothing

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
    Env num iL vE fE <- case Map.lookup fId (funEnv env) of
        Nothing -> return (insertFun env (map (getT . getArgType) args , getT fT) fId)
        Just (fT', fNum) -> if blockNum env == fNum
            then throwError FnDeclErr
            else return (insertVar env (getT fT) fId)
    let funEnv = Env (num+1) iL vE fE
    funEnv <- local (const funEnv) (handleDecls (map argToDecl args))
    blockT <- local (const funEnv) $ handleBlock block
    return (Env num iL vE fE)

handleDecls :: [Decl] -> TC Env
handleDecls [] = ask
handleDecls (x: xs) = do
    env <- handleDecl x
    local (const env) (handleDecls xs)

evalProgram :: [Decl] -> TC ()
evalProgram d = do
    env <- handleDecls d
    case Map.lookup (Ident "main") (funEnv env) of
        Just ((fT, ret), _) -> unless (ret == IntT) $ throwError WrongMainErr
        Nothing -> throwError MissingMainErr

typeCheck :: Program -> ExceptT TCError IO ()
typeCheck (Prog _ d) = runReaderT (evalProgram d) (Env 0 False Map.empty Map.empty)
