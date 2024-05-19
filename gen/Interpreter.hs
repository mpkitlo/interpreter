module Interpreter where

import Control.Monad.Except

import AbsGrammar
import ErrM

import qualified Data.Map as Map
import Data.Maybe
import Control.Monad.Reader
import Control.Monad.State

type Loc = Int

type FunId = Ident
type VarId = Ident

type FunEnv = Map.Map FunId Fn
type VarEnv = Map.Map VarId Loc

type IP = ReaderT Env (StateT Store (ExceptT RTError IO))

data RTError
    = DivideByZeroEx
    | BadRefException
    | MissingRetStmt FunId

data Value = 
    BoolV Bool
    | IntV Integer
    | StringV String
    | VoidV 
    | BreakV
    | ContinueV

instance Show Value where
    show (BoolV v) = show v
    show (IntV v) = show v
    show (StringV v) = v
    show VoidV = error "Cant Print Void"
    show _ = ""

data Store = Store {
    store :: Map.Map Loc Value,
    freeLoc :: Loc
}

data FunArg = Val Value | Ref Loc
data FunArgPassType = RefPass | ValPass
data Fn = Fn [FunArgPassType] ([FunArg] -> IP Value)

data Env = Env {
    varEnv :: VarEnv,
    funEnv :: FunEnv
}

storeVar :: Type -> Store -> (Loc, Store)
storeVar (Int _) (Store s l) = (l, Store (Map.insert l (IntV 0) s) (l+1))
storeVar (Str _) (Store s l) = (l, Store (Map.insert l (StringV "") s) (l+1))
storeVar (Bool _) (Store s l) = (l, Store (Map.insert l (BoolV False) s) (l+1))

storeVarV :: Type -> Value -> Store -> (Loc, Store)
storeVarV (Int _) (IntV v) (Store s l) = (l, Store (Map.insert l (IntV v) s) (l+1))
storeVarV (Str _) (StringV v) (Store s l) = (l, Store (Map.insert l (StringV v) s) (l+1))
storeVarV (Bool _) (BoolV v) (Store s l) = (l, Store (Map.insert l (BoolV v) s) (l+1))

insertLocVal :: Loc -> Value -> Store -> Store
insertLocVal l v (Store s freeL) = Store (Map.insert l v s) freeL

insertVar :: VarId -> Loc -> Env -> Env
insertVar vId l (Env vE fE) = Env (Map.insert vId l vE) fE

insertFun :: FunId -> Fn -> Env -> Env
insertFun fId f (Env vE fE) = Env vE (Map.insert fId f fE)

evalFunV :: FunId -> [Expr] -> IP Value
evalFunV fId args = do 
    env <- ask
    let Fn passTypes fun = fromJust $ Map.lookup fId (funEnv env)
    args <- mapM getFArgFromExpr (zip args passTypes)
    fun args

getFArgFromExpr :: (Expr, FunArgPassType) -> IP FunArg
getFArgFromExpr (EVar _ vId, RefPass) = do
    env <- ask
    return $ Ref $ fromJust $ Map.lookup vId (varEnv env)
-- getFArgFromExpr (_, RefPass) = throwError BadRefException
getFArgFromExpr (e, ValPass) = do
    eV <- handleExpr e
    return $ Val eV


handleArg :: Arg -> FunArg -> IP Env
handleArg (RefArg _ vT vId) (Ref l) = do
    asks (insertVar vId l)
handleArg (ValArg _ vT vId) (Val v) = do
    env <- ask
    st <- get
    let (l, newStore) = storeVar vT st
    put $ insertLocVal l v newStore
    return $ insertVar vId l env

handleArgs :: [Arg] -> [FunArg] -> IP Env
handleArgs [] [] = ask
handleArgs (a : as) (f : fs) = do
    env <- handleArg a f
    local (const env) (handleArgs as fs)

handleDecl :: Decl -> IP Env
handleDecl (VarDecl _ vT vId) = do
    env <- ask 
    st <- get
    let (l, newStore) = storeVar vT st
    put newStore
    return $ insertVar vId l env
handleDecl (VarDeclAss _ vT vId expr) = do
    e <- handleExpr expr
    env <- ask 
    st <- get
    let (l, newStore) = storeVarV vT e st
    put newStore
    return $ insertVar vId l env
handleDecl (FnDecl _ fT fId args blk) = do
    env <- ask
    let fun argsL = do
        let fEnv = insertFun fId (Fn (map getFArgsPassTypeFromArg args) fun) env
        envFunArgs <- local (const fEnv) $ handleArgs args argsL
        retV <- local (const envFunArgs) $ evalBlockV blk
        case (fromMaybe VoidV retV, fT) of
            (ret, _) -> return ret
    return $ insertFun fId (Fn (map getFArgsPassTypeFromArg args) fun) env

handleExpr:: Expr -> IP Value
handleExpr (EVar _ vId) = do
    env <- ask 
    (Store s l) <- get
    return $ fromJust $ Map.lookup (fromJust (Map.lookup vId (varEnv env))) s
handleExpr (ELitInt _ v) = return $ IntV v
handleExpr (ELitTrue _) = return $ BoolV True
handleExpr (ELitFalse _) = return $ BoolV False
handleExpr (EApp _ fId args) = evalFunV fId args
handleExpr (EString _ s) = return $ StringV s
handleExpr (Neg _ expr) = do 
    (IntV v) <- handleExpr expr
    return $ IntV (-v)
handleExpr (Not _ expr) = do 
    (BoolV b) <- handleExpr expr
    return $ BoolV (not b)
handleExpr (EMul _ expr1 op expr2) = do
    (IntV v) <- handleExpr expr1
    (IntV v') <- handleExpr expr2
    case op of 
        (Times _)-> return $ IntV (v * v')
        (Mod _) -> if v' == 0
                then throwError DivideByZeroEx
                else return $ IntV (v `mod` v')
        (Div _) -> if v' == 0
                then throwError DivideByZeroEx
                else return $ IntV (v `div` v')
handleExpr (EAdd _ expr1 op expr2) = do
    (IntV v) <- handleExpr expr1
    (IntV v') <- handleExpr expr2
    case op of 
        (Plus _)-> return $ IntV (v + v')
        (Minus _) -> return $ IntV (v - v')
handleExpr (ERel _ expr1 op expr2) = do
    (IntV v) <- handleExpr expr1
    (IntV v') <- handleExpr expr2
    case op of
        (LTH _) -> return $ BoolV (v < v')
        (LE _)-> return $ BoolV (v <= v')
        (GTH _)-> return $ BoolV (v > v')
        (GE _)-> return $ BoolV (v >= v')
        (EQU _) -> return $ BoolV (v == v')
        (NE _) -> return $ BoolV (v /= v')
handleExpr (EAnd _ expr1 expr2) = do
    (BoolV b) <- handleExpr expr1
    (BoolV b') <- handleExpr expr2
    return $ BoolV (b && b')
handleExpr (EOr _ expr1 expr2) = do
    (BoolV b) <- handleExpr expr1
    (BoolV b') <- handleExpr expr2
    return $ BoolV (b || b')

handleStmt :: Stmt -> IP (Maybe Value)
handleStmt (Empty _) = return Nothing
handleStmt (BStmt _  b) = do
    env <- ask 
    local (const env)(handleBlock b)
handleStmt (Ass _ vId expr) = do
    eV <- handleExpr expr
    env <- ask 
    st <- get
    let Just l = Map.lookup vId (varEnv env)
    put $ Store (Map.insert l eV (store st)) (freeLoc st)
    return Nothing 
handleStmt (Ret _ expr) = do 
    rV <- handleExpr expr 
    return $ Just rV
handleStmt (VRet _) = return $ Just VoidV
handleStmt (Cond _ expr blk) = do 
    (BoolV b) <- handleExpr expr
    if b 
        then handleBlock blk
        else return Nothing
handleStmt (CondElse _ expr blk1 blk2) = do 
    (BoolV b) <- handleExpr expr
    if b 
        then handleBlock blk1
        else handleBlock blk2
handleStmt s@(While _ expr (Blk _ decls (x : xs))) = do 
    (BoolV b) <- handleExpr expr
    if b 
        then do
            res <- handleStmt x
            case res of
                Just BreakV -> return Nothing
                Just v -> return $ Just v
                _ -> handleStmts xs
        else return Nothing
handleStmt (Break _) = return $ Just BreakV
handleStmt (Continue _) = return $ Just ContinueV
handleStmt (SExp _ expr) = handleExpr expr >> return Nothing
handleStmt (Print _ e) = performPrint e >> return Nothing

handleBlock :: Block -> IP (Maybe Value)
handleBlock (Blk _ decls stmts) = do
    env <- handleDecls decls
    local (const env) (handleStmts stmts)

performPrint :: Expr -> IP ()
performPrint e = do 
    eV <- handleExpr e 
    liftIO $ putStrLn $ show eV
    return ()

handleStmts :: [Stmt] -> IP (Maybe Value)
handleStmts stmts = do
    foldM foldStmts Nothing stmts

foldStmts :: Maybe Value -> Stmt -> IP (Maybe Value)
foldStmts Nothing stmt = handleStmt stmt
foldStmts (Just sV) _ = return (Just sV)

evalBlockV :: Block -> IP (Maybe Value)
evalBlockV (Blk _ decl stmt) = do
    env <- handleDecls decl
    local (const env) (handleStmts stmt)

getFArgsPassTypeFromArg :: Arg -> FunArgPassType
getFArgsPassTypeFromArg (RefArg _ _ _) = RefPass
getFArgsPassTypeFromArg (ValArg _ _ _) = ValPass

handleDecls :: [Decl] -> IP Env
handleDecls [] = ask
handleDecls (x: xs) = do
    env <- handleDecl x
    local (const env) (handleDecls xs)

evalProgram :: [Decl] -> IP Value
evalProgram decls = do
    env <- handleDecls decls
    local (const env) (evalFunV (Ident "main") [])

interpret :: Program -> ExceptT RTError IO Value
interpret (Prog _ ds) = do
    (ret, s) <- runStateT (runReaderT (evalProgram ds) (Env Map.empty Map.empty)) (Store Map.empty 0)
    return ret