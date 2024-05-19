-- File generated by the BNF Converter (bnfc 2.9.4).

-- Templates for pattern matching on abstract syntax

{-# OPTIONS_GHC -fno-warn-unused-matches #-}

module SkelGrammar where

import Prelude (($), Either(..), String, (++), Show, show)
import qualified AbsGrammar

type Err = Either String
type Result = Err String

failure :: Show a => a -> Result
failure x = Left $ "Undefined case: " ++ show x

transIdent :: AbsGrammar.Ident -> Result
transIdent x = case x of
  AbsGrammar.Ident string -> failure x

transProgram :: Show a => AbsGrammar.Program' a -> Result
transProgram x = case x of
  AbsGrammar.Prog _ decls -> failure x

transDecl :: Show a => AbsGrammar.Decl' a -> Result
transDecl x = case x of
  AbsGrammar.VarDecl _ type_ ident -> failure x
  AbsGrammar.VarDeclAss _ type_ ident expr -> failure x
  AbsGrammar.FnDecl _ type_ ident args block -> failure x

transArg :: Show a => AbsGrammar.Arg' a -> Result
transArg x = case x of
  AbsGrammar.ValArg _ type_ ident -> failure x
  AbsGrammar.RefArg _ type_ ident -> failure x

transBlock :: Show a => AbsGrammar.Block' a -> Result
transBlock x = case x of
  AbsGrammar.Blk _ decls stmts -> failure x

transStmt :: Show a => AbsGrammar.Stmt' a -> Result
transStmt x = case x of
  AbsGrammar.Empty _ -> failure x
  AbsGrammar.BStmt _ block -> failure x
  AbsGrammar.Ass _ ident expr -> failure x
  AbsGrammar.Ret _ expr -> failure x
  AbsGrammar.VRet _ -> failure x
  AbsGrammar.Cond _ expr block -> failure x
  AbsGrammar.CondElse _ expr block1 block2 -> failure x
  AbsGrammar.While _ expr stmt -> failure x
  AbsGrammar.Break _ -> failure x
  AbsGrammar.Continue _ -> failure x
  AbsGrammar.SExp _ expr -> failure x
  AbsGrammar.Print _ expr -> failure x

transType :: Show a => AbsGrammar.Type' a -> Result
transType x = case x of
  AbsGrammar.Int _ -> failure x
  AbsGrammar.Str _ -> failure x
  AbsGrammar.Bool _ -> failure x
  AbsGrammar.Void _ -> failure x

transExpr :: Show a => AbsGrammar.Expr' a -> Result
transExpr x = case x of
  AbsGrammar.EVar _ ident -> failure x
  AbsGrammar.ELitInt _ integer -> failure x
  AbsGrammar.ELitTrue _ -> failure x
  AbsGrammar.ELitFalse _ -> failure x
  AbsGrammar.EApp _ ident exprs -> failure x
  AbsGrammar.EString _ string -> failure x
  AbsGrammar.Neg _ expr -> failure x
  AbsGrammar.Not _ expr -> failure x
  AbsGrammar.EMul _ expr1 mulop expr2 -> failure x
  AbsGrammar.EAdd _ expr1 addop expr2 -> failure x
  AbsGrammar.ERel _ expr1 relop expr2 -> failure x
  AbsGrammar.EAnd _ expr1 expr2 -> failure x
  AbsGrammar.EOr _ expr1 expr2 -> failure x

transAddOp :: Show a => AbsGrammar.AddOp' a -> Result
transAddOp x = case x of
  AbsGrammar.Plus _ -> failure x
  AbsGrammar.Minus _ -> failure x

transMulOp :: Show a => AbsGrammar.MulOp' a -> Result
transMulOp x = case x of
  AbsGrammar.Times _ -> failure x
  AbsGrammar.Div _ -> failure x
  AbsGrammar.Mod _ -> failure x

transRelOp :: Show a => AbsGrammar.RelOp' a -> Result
transRelOp x = case x of
  AbsGrammar.LTH _ -> failure x
  AbsGrammar.LE _ -> failure x
  AbsGrammar.GTH _ -> failure x
  AbsGrammar.GE _ -> failure x
  AbsGrammar.EQU _ -> failure x
  AbsGrammar.NE _ -> failure x
