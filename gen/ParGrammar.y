-- -*- haskell -*- File generated by the BNF Converter (bnfc 2.9.4).

-- Parser definition for use with Happy
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module ParGrammar
  ( happyError
  , myLexer
  , pProgram
  ) where

import Prelude

import qualified AbsGrammar
import LexGrammar

}

%name pProgram_internal Program
-- no lexer declaration
%monad { Err } { (>>=) } { return }
%tokentype {Token}
%token
  '!'        { PT _ (TS _ 1)  }
  '!='       { PT _ (TS _ 2)  }
  '%'        { PT _ (TS _ 3)  }
  '&'        { PT _ (TS _ 4)  }
  '&&'       { PT _ (TS _ 5)  }
  '('        { PT _ (TS _ 6)  }
  ')'        { PT _ (TS _ 7)  }
  '*'        { PT _ (TS _ 8)  }
  '+'        { PT _ (TS _ 9)  }
  ','        { PT _ (TS _ 10) }
  '-'        { PT _ (TS _ 11) }
  '/'        { PT _ (TS _ 12) }
  ';'        { PT _ (TS _ 13) }
  '<'        { PT _ (TS _ 14) }
  '<='       { PT _ (TS _ 15) }
  '='        { PT _ (TS _ 16) }
  '=='       { PT _ (TS _ 17) }
  '>'        { PT _ (TS _ 18) }
  '>='       { PT _ (TS _ 19) }
  'bool'     { PT _ (TS _ 20) }
  'break'    { PT _ (TS _ 21) }
  'continue' { PT _ (TS _ 22) }
  'else'     { PT _ (TS _ 23) }
  'false'    { PT _ (TS _ 24) }
  'if'       { PT _ (TS _ 25) }
  'int'      { PT _ (TS _ 26) }
  'print'    { PT _ (TS _ 27) }
  'return'   { PT _ (TS _ 28) }
  'string'   { PT _ (TS _ 29) }
  'true'     { PT _ (TS _ 30) }
  'void'     { PT _ (TS _ 31) }
  'while'    { PT _ (TS _ 32) }
  '{'        { PT _ (TS _ 33) }
  '||'       { PT _ (TS _ 34) }
  '}'        { PT _ (TS _ 35) }
  L_Ident    { PT _ (TV _)    }
  L_integ    { PT _ (TI _)    }
  L_quoted   { PT _ (TL _)    }

%%

Ident :: { (AbsGrammar.BNFC'Position, AbsGrammar.Ident) }
Ident  : L_Ident { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Ident (tokenText $1)) }

Integer :: { (AbsGrammar.BNFC'Position, Integer) }
Integer  : L_integ  { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), (read (tokenText $1)) :: Integer) }

String  :: { (AbsGrammar.BNFC'Position, String) }
String   : L_quoted { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), ((\(PT _ (TL s)) -> s) $1)) }

Program :: { (AbsGrammar.BNFC'Position, AbsGrammar.Program) }
Program : ListDecl { (fst $1, AbsGrammar.Prog (fst $1) (snd $1)) }

ListDecl :: { (AbsGrammar.BNFC'Position, [AbsGrammar.Decl]) }
ListDecl
  : {- empty -} { (AbsGrammar.BNFC'NoPosition, []) }
  | Decl ListDecl { (fst $1, (:) (snd $1) (snd $2)) }

Decl :: { (AbsGrammar.BNFC'Position, AbsGrammar.Decl) }
Decl
  : Type Ident ';' { (fst $1, AbsGrammar.VarDecl (fst $1) (snd $1) (snd $2)) }
  | Type Ident '=' Expr ';' { (fst $1, AbsGrammar.VarDeclAss (fst $1) (snd $1) (snd $2) (snd $4)) }
  | Type Ident '(' ListArg ')' Block { (fst $1, AbsGrammar.FnDecl (fst $1) (snd $1) (snd $2) (snd $4) (snd $6)) }

Arg :: { (AbsGrammar.BNFC'Position, AbsGrammar.Arg) }
Arg
  : Type Ident { (fst $1, AbsGrammar.ValArg (fst $1) (snd $1) (snd $2)) }
  | Type '&' Ident { (fst $1, AbsGrammar.RefArg (fst $1) (snd $1) (snd $3)) }

ListArg :: { (AbsGrammar.BNFC'Position, [AbsGrammar.Arg]) }
ListArg
  : {- empty -} { (AbsGrammar.BNFC'NoPosition, []) }
  | Arg { (fst $1, (:[]) (snd $1)) }
  | Arg ',' ListArg { (fst $1, (:) (snd $1) (snd $3)) }

Block :: { (AbsGrammar.BNFC'Position, AbsGrammar.Block) }
Block
  : '{' ListDecl ListStmt '}' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Blk (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $2) (snd $3)) }

ListStmt :: { (AbsGrammar.BNFC'Position, [AbsGrammar.Stmt]) }
ListStmt
  : {- empty -} { (AbsGrammar.BNFC'NoPosition, []) }
  | Stmt ListStmt { (fst $1, (:) (snd $1) (snd $2)) }

Stmt :: { (AbsGrammar.BNFC'Position, AbsGrammar.Stmt) }
Stmt
  : ';' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Empty (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | Block { (fst $1, AbsGrammar.BStmt (fst $1) (snd $1)) }
  | Ident '=' Expr ';' { (fst $1, AbsGrammar.Ass (fst $1) (snd $1) (snd $3)) }
  | 'return' Expr ';' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Ret (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $2)) }
  | 'return' ';' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.VRet (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'if' '(' Expr ')' Block { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Cond (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $3) (snd $5)) }
  | 'if' '(' Expr ')' Block 'else' Block { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.CondElse (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $3) (snd $5) (snd $7)) }
  | 'while' '(' Expr ')' Block { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.While (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $3) (snd $5)) }
  | 'break' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Break (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'continue' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Continue (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | Expr ';' { (fst $1, AbsGrammar.SExp (fst $1) (snd $1)) }
  | 'print' '(' Expr ')' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Print (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $3)) }

Type :: { (AbsGrammar.BNFC'Position, AbsGrammar.Type) }
Type
  : 'int' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Int (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'string' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Str (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'bool' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Bool (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'void' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Void (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }

Expr6 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr6
  : Ident { (fst $1, AbsGrammar.EVar (fst $1) (snd $1)) }
  | Integer { (fst $1, AbsGrammar.ELitInt (fst $1) (snd $1)) }
  | 'true' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.ELitTrue (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | 'false' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.ELitFalse (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | Ident '(' ListExpr ')' { (fst $1, AbsGrammar.EApp (fst $1) (snd $1) (snd $3)) }
  | String { (fst $1, AbsGrammar.EString (fst $1) (snd $1)) }
  | '(' Expr ')' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), (snd $2)) }

Expr5 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr5
  : '-' Expr6 { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Neg (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $2)) }
  | '!' Expr6 { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Not (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1)) (snd $2)) }
  | Expr6 { (fst $1, (snd $1)) }

Expr4 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr4
  : Expr4 MulOp Expr5 { (fst $1, AbsGrammar.EMul (fst $1) (snd $1) (snd $2) (snd $3)) }
  | Expr5 { (fst $1, (snd $1)) }

Expr3 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr3
  : Expr3 AddOp Expr4 { (fst $1, AbsGrammar.EAdd (fst $1) (snd $1) (snd $2) (snd $3)) }
  | Expr4 { (fst $1, (snd $1)) }

Expr2 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr2
  : Expr2 RelOp Expr3 { (fst $1, AbsGrammar.ERel (fst $1) (snd $1) (snd $2) (snd $3)) }
  | Expr3 { (fst $1, (snd $1)) }

Expr1 :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr1
  : Expr2 '&&' Expr1 { (fst $1, AbsGrammar.EAnd (fst $1) (snd $1) (snd $3)) }
  | Expr2 { (fst $1, (snd $1)) }

Expr :: { (AbsGrammar.BNFC'Position, AbsGrammar.Expr) }
Expr
  : Expr1 '||' Expr { (fst $1, AbsGrammar.EOr (fst $1) (snd $1) (snd $3)) }
  | Expr1 { (fst $1, (snd $1)) }

ListExpr :: { (AbsGrammar.BNFC'Position, [AbsGrammar.Expr]) }
ListExpr
  : {- empty -} { (AbsGrammar.BNFC'NoPosition, []) }
  | Expr { (fst $1, (:[]) (snd $1)) }
  | Expr ',' ListExpr { (fst $1, (:) (snd $1) (snd $3)) }

AddOp :: { (AbsGrammar.BNFC'Position, AbsGrammar.AddOp) }
AddOp
  : '+' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Plus (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '-' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Minus (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }

MulOp :: { (AbsGrammar.BNFC'Position, AbsGrammar.MulOp) }
MulOp
  : '*' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Times (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '/' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Div (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '%' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.Mod (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }

RelOp :: { (AbsGrammar.BNFC'Position, AbsGrammar.RelOp) }
RelOp
  : '<' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.LTH (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '<=' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.LE (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '>' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.GTH (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '>=' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.GE (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '==' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.EQU (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }
  | '!=' { (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1), AbsGrammar.NE (uncurry AbsGrammar.BNFC'Position (tokenLineCol $1))) }

{

type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens

-- Entrypoints

pProgram :: [Token] -> Err AbsGrammar.Program
pProgram = fmap snd . pProgram_internal
}

