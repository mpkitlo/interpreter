module TypeCheck where

import AbsGrammar
import ErrM
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.Trans.Except

import qualified Data.Map as Map
import Data.Maybe

getT :: Type -> TypeT
getT (Bool _) = BoolT
getT (Int _)  = IntT
getT (Str _)  = StringT
getT (Void _) = VoidT

data TypeT = BoolT | IntT | StringT | VoidT deriving Eq
instance Show TypeT where
    show BoolT = "bool"
    show IntT = "int"
    show StringT = "string"
    show VoidT = "void"

type ArgsT = [TypeT]
type RetT = TypeT
type VarT = TypeT
type FunT = (ArgsT, RetT)

type FunId = Ident
type VarId = Ident

type TC = (ReaderT Env (ExceptT TCErr IO))

data TCErr
    = DeclRepeatErr String VarId
    | WrongMainTypeErr TypeT
    | MissingMainErr
    | ObjNotDeclaredErr String VarId
    | WrongFunArgsErr FunId ArgsT ArgsT
    | OperationErr VarT VarT
    | NotBoolCondErr String
    | NotInLoopErr String
    | PrintErr
    | VagueBlockRetErr
    | WrongReturnErr

instance Show TCErr where
    show (DeclRepeatErr str (Ident i)) = "Repeated " ++ str ++ " " ++ i ++ " declaration"
    show (WrongMainTypeErr t) = "Main return type expected: " ++ show IntT ++ " got: " ++ show t
    show MissingMainErr = "Main function missing"
    show (ObjNotDeclaredErr str (Ident i))= str ++ " " ++ i ++ " is not declared"
    show (WrongFunArgsErr (Ident i) args args') = "Function " ++ i ++ " expected args: " ++ show args ++ " got: " ++ show args'
    show (OperationErr t t') = "Wrong type expected: " ++ show t ++ " got: " ++ show t' 
    show (NotBoolCondErr str) = str ++ " condition has to be bool"
    show (NotInLoopErr str)= "Can use " ++ str ++ " only inside while"
    show PrintErr = "Can't print void"
    show VagueBlockRetErr = "vague return type in block"
    show WrongReturnErr = "Different return type then declared"

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
argToDecl (ValArg a t aId) = VarDecl a t aId
argToDecl (RefArg a t aId) = VarDecl a t aId

handleStmt :: Stmt -> TC (Maybe VarT)
handleStmt (Empty _) = return Nothing
handleStmt (BStmt _ block) = handleBlock block
handleStmt (Ass _ vId expr) = do
    t <- getVar vId
    t' <- handleExpresion expr
    if t == t'
        then return Nothing
        else throwError $ OperationErr t t'
handleStmt (Ret _ expr) = do
    t <- handleExpresion expr
    if t == VoidT
        then throwError WrongReturnErr
        else return (Just t)
handleStmt (VRet _) = return (Just VoidT)
handleStmt (Cond _ expr blk) = do
    t <- handleExpresion expr
    if t == BoolT
        then handleBlock blk
        else throwError $ NotBoolCondErr "if"
handleStmt (CondElse _ expr blk blk') = do
    t <- handleExpresion expr
    if t == BoolT
        then do
            t' <- handleBlock blk
            t'' <- handleBlock blk'
            case (t', t'') of
                (_, Nothing) -> return t'
                (Nothing, _) -> return t''
                (_, _) ->
                    if t' == t''
                        then return t'
                        else throwError VagueBlockRetErr
        else throwError $ NotBoolCondErr "if"
handleStmt (While _ expr stmt) = do
    t <- handleExpresion expr
    if t == BoolT
        then do 
            Env num _ vE fE  <- ask 
            local (const (Env num True vE fE )) (handleStmt stmt)
        else throwError $ NotBoolCondErr "while"
handleStmt (Break _) = do
    env <- ask
    if inLoop env
        then return Nothing
        else throwError $ NotInLoopErr "break"
handleStmt (Continue _) = do
    env <- ask
    if inLoop env
        then return Nothing
        else throwError $ NotInLoopErr "continue"
handleStmt (SExp _ expr) = handleExpresion expr >> return Nothing
handleStmt (Print _ expr) = do
    t <- handleExpresion expr
    if t == VoidT
        then throwError PrintErr
        else return Nothing

getVar :: VarId -> TC VarT
getVar vId = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> throwError $ ObjNotDeclaredErr "Variable" vId
        Just (vT, _) -> return vT

getFun :: FunId -> TC FunT
getFun fId = do
    env <- ask
    case Map.lookup fId (funEnv env) of
        Nothing -> throwError $ ObjNotDeclaredErr "Function" fId
        Just (fT, _) -> return fT

getAppFun :: FunId -> [Expr] -> TC VarT
getAppFun fId args = do
    (args', ret) <- getFun fId
    args'' <- mapM handleExpresion args
    if args' == args''
        then return ret
        else throwError $ WrongFunArgsErr fId args' args''

getArgType :: Arg -> Type
getArgType (ValArg _ t _) = t
getArgType (RefArg _ t _) = t

checkExprType :: Expr -> VarT -> TC ()
checkExprType expr expT = do
    t <- handleExpresion expr
    unless (t == expT) (throwError(OperationErr expT t))

handleExpresion :: Expr -> TC VarT
handleExpresion (EVar _ vId) = getVar vId
handleExpresion (ELitInt _ _) = return IntT
handleExpresion (ELitTrue _) = return BoolT
handleExpresion (ELitFalse _) = return BoolT
handleExpresion (EApp _ fId args) = getAppFun fId args
handleExpresion (EString _ _) = return StringT
handleExpresion (Neg _ expr) = checkExprType expr IntT >> return IntT
handleExpresion (Not _ expr) = checkExprType expr BoolT >> return BoolT
handleExpresion (EMul _ expr1 _ expr2) = checkExprType expr1 IntT >> checkExprType expr2 IntT >> return IntT
handleExpresion (EAdd _ expr1 _ expr2) = checkExprType expr1 IntT >> checkExprType expr2 IntT >> return IntT
handleExpresion (ERel _ expr1 _ expr2) = checkExprType expr1 IntT >> checkExprType expr2 IntT >> return BoolT
handleExpresion (EAnd _ expr1 expr2) = checkExprType expr1 BoolT >> checkExprType expr2 BoolT >> return BoolT
handleExpresion (EOr _ expr1 expr2)= checkExprType expr1 BoolT >> checkExprType expr2 BoolT >> return BoolT

handleBlock :: Block -> TC (Maybe RetT)
handleBlock (Blk _ decls stmts) = do
    env <- handleDecls decls
    statementRet <- local (const env) (mapM handleStmt stmts)
    let filteredRet = filter isJust statementRet
    if null filteredRet
        then return Nothing
        else if all (== head filteredRet) (tail filteredRet)
            then return $ head filteredRet
            else throwError WrongReturnErr 


handleDecl :: Decl -> TC Env
handleDecl (VarDecl _ vT vId) = do
    env <- ask
    case Map.lookup vId (varEnv env) of
        Nothing -> return (insertVar env (getT vT) vId)
        Just (_, fNum) -> if blockNum env == fNum
            then throwError $ DeclRepeatErr "Variable" vId
            else return (insertVar env (getT vT) vId)

handleDecl (VarDeclAss _ vT vId expr) = do
    env <- ask
    t <- handleExpresion expr
    if t /= getT vT then throwError $ OperationErr t (getT vT)
    else
        case Map.lookup vId (varEnv env) of
            Nothing -> return (insertVar env (getT vT) vId)
            Just (_, fNum) -> if blockNum env == fNum
                then throwError $ DeclRepeatErr "Variable" vId
                else return (insertVar env (getT vT) vId)

handleDecl (FnDecl _ fT fId args block) = do
    env <- ask
    Env num iL vE fE <- case Map.lookup fId (funEnv env) of
        Nothing -> return (insertFun env (map (getT . getArgType) args , getT fT) fId)
        Just (_, fNum) -> if blockNum env == fNum
            then throwError $ DeclRepeatErr "Function" fId
            else return (insertVar env (getT fT) fId)
    let funEnv = Env (num+1) iL vE fE
    funEnv' <- local (const funEnv) $ handleDecls (map argToDecl args)
    blockT <- local (const funEnv') $ handleBlock block
    if getT fT == fromMaybe VoidT blockT
        then return (Env num iL vE fE)
        else throwError WrongReturnErr

handleDecls :: [Decl] -> TC Env
handleDecls [] = ask
handleDecls (x: xs) = do
    env <- handleDecl x
    local (const env) (handleDecls xs)

evalProgram :: [Decl] -> TC ()
evalProgram d = do
    env <- handleDecls d
    case Map.lookup (Ident "main") (funEnv env) of
        Just ((_, ret), _) -> unless (ret == IntT) $ throwError $ WrongMainTypeErr ret
        Nothing -> throwError MissingMainErr

typeCheck :: Program -> ExceptT TCErr IO ()
typeCheck (Prog _ d) = runReaderT (evalProgram d) (Env 0 False Map.empty Map.empty)
