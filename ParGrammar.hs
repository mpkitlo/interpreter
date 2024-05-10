{-# OPTIONS_GHC -w #-}
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
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 ((AbsGrammar.BNFC'Position, AbsGrammar.Ident))
	| HappyAbsSyn5 ((AbsGrammar.BNFC'Position, Integer))
	| HappyAbsSyn6 ((AbsGrammar.BNFC'Position, String))
	| HappyAbsSyn7 ((AbsGrammar.BNFC'Position, AbsGrammar.Program))
	| HappyAbsSyn8 ((AbsGrammar.BNFC'Position, [AbsGrammar.Decl]))
	| HappyAbsSyn9 ((AbsGrammar.BNFC'Position, AbsGrammar.Decl))
	| HappyAbsSyn10 ((AbsGrammar.BNFC'Position, AbsGrammar.Arg))
	| HappyAbsSyn11 ((AbsGrammar.BNFC'Position, [AbsGrammar.Arg]))
	| HappyAbsSyn12 ((AbsGrammar.BNFC'Position, AbsGrammar.Block))
	| HappyAbsSyn13 ((AbsGrammar.BNFC'Position, [AbsGrammar.Stmt]))
	| HappyAbsSyn14 ((AbsGrammar.BNFC'Position, AbsGrammar.Stmt))
	| HappyAbsSyn15 ((AbsGrammar.BNFC'Position, AbsGrammar.Type))
	| HappyAbsSyn16 ((AbsGrammar.BNFC'Position, AbsGrammar.Expr))
	| HappyAbsSyn23 ((AbsGrammar.BNFC'Position, [AbsGrammar.Expr]))
	| HappyAbsSyn24 ((AbsGrammar.BNFC'Position, AbsGrammar.AddOp))
	| HappyAbsSyn25 ((AbsGrammar.BNFC'Position, AbsGrammar.MulOp))
	| HappyAbsSyn26 ((AbsGrammar.BNFC'Position, AbsGrammar.RelOp))

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,321) ([0,0,8192,328,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10500,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,18,0,0,0,0,0,0,0,1024,41,0,0,0,0,0,16896,8,28737,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1090,0,0,0,1280,0,0,0,49188,14,0,0,0,0,8,0,32768,0,0,0,512,2048,898,0,33824,4096,1796,0,2048,8192,3592,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,4,0,0,0,1,0,1,0,0,0,0,0,0,0,4,0,0,0,1,0,0,42000,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,2112,8193,3592,0,4224,16386,7184,0,0,0,0,0,16896,8,28737,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,528,4160,28,0,0,0,0,0,0,0,0,0,4228,33280,224,0,0,0,0,0,0,0,0,0,0,0,0,0,2112,8193,3592,0,0,1,0,0,16384,0,0,0,0,0,0,0,4096,34,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10306,65392,115,0,0,0,0,0,256,4,0,0,0,0,0,0,0,0,0,0,0,0,256,0,4224,56330,7423,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,4,0,0,16384,1288,2080,14,0,16,0,0,0,0,0,0,0,2114,16640,112,0,0,0,0,0,8456,1024,449,0,0,1,0,0,0,0,0,0,2112,8193,3592,0,4224,16386,7184,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,33,49412,1,0,256,0,0,0,8,0,0,0,16,0,0,0,0,0,0,0,64,0,0,0,0,0,2,0,0,0,0,0,0,0,8,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,128,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram_internal","Ident","Integer","String","Program","ListDecl","Decl","Arg","ListArg","Block","ListStmt","Stmt","Type","Expr6","Expr5","Expr4","Expr3","Expr2","Expr1","Expr","ListExpr","AddOp","MulOp","RelOp","'!'","'!='","'%'","'&'","'&&'","'('","')'","'*'","'+'","','","'-'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'boolean'","'break'","'continue'","'else'","'false'","'if'","'int'","'print'","'return'","'string'","'true'","'void'","'while'","'{'","'||'","'}'","L_Ident","L_integ","L_quoted","%eof"]
        bit_start = st * 65
        bit_end = (st + 1) * 65
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..64]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (46) = happyShift action_7
action_0 (52) = happyShift action_8
action_0 (55) = happyShift action_9
action_0 (57) = happyShift action_10
action_0 (7) = happyGoto action_3
action_0 (8) = happyGoto action_4
action_0 (9) = happyGoto action_5
action_0 (15) = happyGoto action_6
action_0 _ = happyReduce_5

action_1 (62) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (65) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_4

action_5 (46) = happyShift action_7
action_5 (52) = happyShift action_8
action_5 (55) = happyShift action_9
action_5 (57) = happyShift action_10
action_5 (8) = happyGoto action_12
action_5 (9) = happyGoto action_5
action_5 (15) = happyGoto action_6
action_5 _ = happyReduce_5

action_6 (62) = happyShift action_2
action_6 (4) = happyGoto action_11
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_33

action_8 _ = happyReduce_31

action_9 _ = happyReduce_32

action_10 _ = happyReduce_34

action_11 (32) = happyShift action_13
action_11 (39) = happyShift action_14
action_11 (42) = happyShift action_15
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_6

action_13 (46) = happyShift action_7
action_13 (52) = happyShift action_8
action_13 (55) = happyShift action_9
action_13 (57) = happyShift action_10
action_13 (10) = happyGoto action_33
action_13 (11) = happyGoto action_34
action_13 (15) = happyGoto action_35
action_13 _ = happyReduce_12

action_14 _ = happyReduce_7

action_15 (27) = happyShift action_26
action_15 (32) = happyShift action_27
action_15 (37) = happyShift action_28
action_15 (50) = happyShift action_29
action_15 (56) = happyShift action_30
action_15 (62) = happyShift action_2
action_15 (63) = happyShift action_31
action_15 (64) = happyShift action_32
action_15 (4) = happyGoto action_16
action_15 (5) = happyGoto action_17
action_15 (6) = happyGoto action_18
action_15 (16) = happyGoto action_19
action_15 (17) = happyGoto action_20
action_15 (18) = happyGoto action_21
action_15 (19) = happyGoto action_22
action_15 (20) = happyGoto action_23
action_15 (21) = happyGoto action_24
action_15 (22) = happyGoto action_25
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (32) = happyShift action_60
action_16 _ = happyReduce_35

action_17 _ = happyReduce_36

action_18 _ = happyReduce_40

action_19 _ = happyReduce_44

action_20 _ = happyReduce_46

action_21 (29) = happyShift action_57
action_21 (34) = happyShift action_58
action_21 (38) = happyShift action_59
action_21 (25) = happyGoto action_56
action_21 _ = happyReduce_48

action_22 (35) = happyShift action_54
action_22 (37) = happyShift action_55
action_22 (24) = happyGoto action_53
action_22 _ = happyReduce_50

action_23 (28) = happyShift action_46
action_23 (31) = happyShift action_47
action_23 (40) = happyShift action_48
action_23 (41) = happyShift action_49
action_23 (43) = happyShift action_50
action_23 (44) = happyShift action_51
action_23 (45) = happyShift action_52
action_23 (26) = happyGoto action_45
action_23 _ = happyReduce_52

action_24 (60) = happyShift action_44
action_24 _ = happyReduce_54

action_25 (39) = happyShift action_43
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (32) = happyShift action_27
action_26 (50) = happyShift action_29
action_26 (56) = happyShift action_30
action_26 (62) = happyShift action_2
action_26 (63) = happyShift action_31
action_26 (64) = happyShift action_32
action_26 (4) = happyGoto action_16
action_26 (5) = happyGoto action_17
action_26 (6) = happyGoto action_18
action_26 (16) = happyGoto action_42
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (27) = happyShift action_26
action_27 (32) = happyShift action_27
action_27 (37) = happyShift action_28
action_27 (50) = happyShift action_29
action_27 (56) = happyShift action_30
action_27 (62) = happyShift action_2
action_27 (63) = happyShift action_31
action_27 (64) = happyShift action_32
action_27 (4) = happyGoto action_16
action_27 (5) = happyGoto action_17
action_27 (6) = happyGoto action_18
action_27 (16) = happyGoto action_19
action_27 (17) = happyGoto action_20
action_27 (18) = happyGoto action_21
action_27 (19) = happyGoto action_22
action_27 (20) = happyGoto action_23
action_27 (21) = happyGoto action_24
action_27 (22) = happyGoto action_41
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (32) = happyShift action_27
action_28 (50) = happyShift action_29
action_28 (56) = happyShift action_30
action_28 (62) = happyShift action_2
action_28 (63) = happyShift action_31
action_28 (64) = happyShift action_32
action_28 (4) = happyGoto action_16
action_28 (5) = happyGoto action_17
action_28 (6) = happyGoto action_18
action_28 (16) = happyGoto action_40
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_38

action_30 _ = happyReduce_37

action_31 _ = happyReduce_2

action_32 _ = happyReduce_3

action_33 (36) = happyShift action_39
action_33 _ = happyReduce_13

action_34 (33) = happyShift action_38
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (30) = happyShift action_37
action_35 (62) = happyShift action_2
action_35 (4) = happyGoto action_36
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_10

action_37 (62) = happyShift action_2
action_37 (4) = happyGoto action_72
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (59) = happyShift action_71
action_38 (12) = happyGoto action_70
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (46) = happyShift action_7
action_39 (52) = happyShift action_8
action_39 (55) = happyShift action_9
action_39 (57) = happyShift action_10
action_39 (10) = happyGoto action_33
action_39 (11) = happyGoto action_69
action_39 (15) = happyGoto action_35
action_39 _ = happyReduce_12

action_40 _ = happyReduce_42

action_41 (33) = happyShift action_68
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_43

action_43 _ = happyReduce_8

action_44 (27) = happyShift action_26
action_44 (32) = happyShift action_27
action_44 (37) = happyShift action_28
action_44 (50) = happyShift action_29
action_44 (56) = happyShift action_30
action_44 (62) = happyShift action_2
action_44 (63) = happyShift action_31
action_44 (64) = happyShift action_32
action_44 (4) = happyGoto action_16
action_44 (5) = happyGoto action_17
action_44 (6) = happyGoto action_18
action_44 (16) = happyGoto action_19
action_44 (17) = happyGoto action_20
action_44 (18) = happyGoto action_21
action_44 (19) = happyGoto action_22
action_44 (20) = happyGoto action_23
action_44 (21) = happyGoto action_24
action_44 (22) = happyGoto action_67
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (27) = happyShift action_26
action_45 (32) = happyShift action_27
action_45 (37) = happyShift action_28
action_45 (50) = happyShift action_29
action_45 (56) = happyShift action_30
action_45 (62) = happyShift action_2
action_45 (63) = happyShift action_31
action_45 (64) = happyShift action_32
action_45 (4) = happyGoto action_16
action_45 (5) = happyGoto action_17
action_45 (6) = happyGoto action_18
action_45 (16) = happyGoto action_19
action_45 (17) = happyGoto action_20
action_45 (18) = happyGoto action_21
action_45 (19) = happyGoto action_66
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_68

action_47 (27) = happyShift action_26
action_47 (32) = happyShift action_27
action_47 (37) = happyShift action_28
action_47 (50) = happyShift action_29
action_47 (56) = happyShift action_30
action_47 (62) = happyShift action_2
action_47 (63) = happyShift action_31
action_47 (64) = happyShift action_32
action_47 (4) = happyGoto action_16
action_47 (5) = happyGoto action_17
action_47 (6) = happyGoto action_18
action_47 (16) = happyGoto action_19
action_47 (17) = happyGoto action_20
action_47 (18) = happyGoto action_21
action_47 (19) = happyGoto action_22
action_47 (20) = happyGoto action_23
action_47 (21) = happyGoto action_65
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_63

action_49 _ = happyReduce_64

action_50 _ = happyReduce_67

action_51 _ = happyReduce_65

action_52 _ = happyReduce_66

action_53 (27) = happyShift action_26
action_53 (32) = happyShift action_27
action_53 (37) = happyShift action_28
action_53 (50) = happyShift action_29
action_53 (56) = happyShift action_30
action_53 (62) = happyShift action_2
action_53 (63) = happyShift action_31
action_53 (64) = happyShift action_32
action_53 (4) = happyGoto action_16
action_53 (5) = happyGoto action_17
action_53 (6) = happyGoto action_18
action_53 (16) = happyGoto action_19
action_53 (17) = happyGoto action_20
action_53 (18) = happyGoto action_64
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_58

action_55 _ = happyReduce_59

action_56 (27) = happyShift action_26
action_56 (32) = happyShift action_27
action_56 (37) = happyShift action_28
action_56 (50) = happyShift action_29
action_56 (56) = happyShift action_30
action_56 (62) = happyShift action_2
action_56 (63) = happyShift action_31
action_56 (64) = happyShift action_32
action_56 (4) = happyGoto action_16
action_56 (5) = happyGoto action_17
action_56 (6) = happyGoto action_18
action_56 (16) = happyGoto action_19
action_56 (17) = happyGoto action_63
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_62

action_58 _ = happyReduce_60

action_59 _ = happyReduce_61

action_60 (27) = happyShift action_26
action_60 (32) = happyShift action_27
action_60 (37) = happyShift action_28
action_60 (50) = happyShift action_29
action_60 (56) = happyShift action_30
action_60 (62) = happyShift action_2
action_60 (63) = happyShift action_31
action_60 (64) = happyShift action_32
action_60 (4) = happyGoto action_16
action_60 (5) = happyGoto action_17
action_60 (6) = happyGoto action_18
action_60 (16) = happyGoto action_19
action_60 (17) = happyGoto action_20
action_60 (18) = happyGoto action_21
action_60 (19) = happyGoto action_22
action_60 (20) = happyGoto action_23
action_60 (21) = happyGoto action_24
action_60 (22) = happyGoto action_61
action_60 (23) = happyGoto action_62
action_60 _ = happyReduce_55

action_61 (36) = happyShift action_87
action_61 _ = happyReduce_56

action_62 (33) = happyShift action_86
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_45

action_64 (29) = happyShift action_57
action_64 (34) = happyShift action_58
action_64 (38) = happyShift action_59
action_64 (25) = happyGoto action_56
action_64 _ = happyReduce_47

action_65 _ = happyReduce_51

action_66 (35) = happyShift action_54
action_66 (37) = happyShift action_55
action_66 (24) = happyGoto action_53
action_66 _ = happyReduce_49

action_67 _ = happyReduce_53

action_68 _ = happyReduce_41

action_69 _ = happyReduce_14

action_70 _ = happyReduce_9

action_71 (27) = happyShift action_26
action_71 (32) = happyShift action_27
action_71 (37) = happyShift action_28
action_71 (39) = happyShift action_79
action_71 (46) = happyShift action_7
action_71 (47) = happyShift action_80
action_71 (48) = happyShift action_81
action_71 (50) = happyShift action_29
action_71 (51) = happyShift action_82
action_71 (52) = happyShift action_8
action_71 (53) = happyShift action_83
action_71 (54) = happyShift action_84
action_71 (55) = happyShift action_9
action_71 (56) = happyShift action_30
action_71 (57) = happyShift action_10
action_71 (58) = happyShift action_85
action_71 (59) = happyShift action_71
action_71 (62) = happyShift action_2
action_71 (63) = happyShift action_31
action_71 (64) = happyShift action_32
action_71 (4) = happyGoto action_73
action_71 (5) = happyGoto action_17
action_71 (6) = happyGoto action_18
action_71 (9) = happyGoto action_74
action_71 (12) = happyGoto action_75
action_71 (13) = happyGoto action_76
action_71 (14) = happyGoto action_77
action_71 (15) = happyGoto action_6
action_71 (16) = happyGoto action_19
action_71 (17) = happyGoto action_20
action_71 (18) = happyGoto action_21
action_71 (19) = happyGoto action_22
action_71 (20) = happyGoto action_23
action_71 (21) = happyGoto action_24
action_71 (22) = happyGoto action_78
action_71 _ = happyReduce_16

action_72 _ = happyReduce_11

action_73 (32) = happyShift action_60
action_73 (42) = happyShift action_97
action_73 _ = happyReduce_35

action_74 _ = happyReduce_20

action_75 _ = happyReduce_19

action_76 (61) = happyShift action_96
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (27) = happyShift action_26
action_77 (32) = happyShift action_27
action_77 (37) = happyShift action_28
action_77 (39) = happyShift action_79
action_77 (46) = happyShift action_7
action_77 (47) = happyShift action_80
action_77 (48) = happyShift action_81
action_77 (50) = happyShift action_29
action_77 (51) = happyShift action_82
action_77 (52) = happyShift action_8
action_77 (53) = happyShift action_83
action_77 (54) = happyShift action_84
action_77 (55) = happyShift action_9
action_77 (56) = happyShift action_30
action_77 (57) = happyShift action_10
action_77 (58) = happyShift action_85
action_77 (59) = happyShift action_71
action_77 (62) = happyShift action_2
action_77 (63) = happyShift action_31
action_77 (64) = happyShift action_32
action_77 (4) = happyGoto action_73
action_77 (5) = happyGoto action_17
action_77 (6) = happyGoto action_18
action_77 (9) = happyGoto action_74
action_77 (12) = happyGoto action_75
action_77 (13) = happyGoto action_95
action_77 (14) = happyGoto action_77
action_77 (15) = happyGoto action_6
action_77 (16) = happyGoto action_19
action_77 (17) = happyGoto action_20
action_77 (18) = happyGoto action_21
action_77 (19) = happyGoto action_22
action_77 (20) = happyGoto action_23
action_77 (21) = happyGoto action_24
action_77 (22) = happyGoto action_78
action_77 _ = happyReduce_16

action_78 (39) = happyShift action_94
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_18

action_80 _ = happyReduce_27

action_81 _ = happyReduce_28

action_82 (32) = happyShift action_93
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (32) = happyShift action_92
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (27) = happyShift action_26
action_84 (32) = happyShift action_27
action_84 (37) = happyShift action_28
action_84 (39) = happyShift action_91
action_84 (50) = happyShift action_29
action_84 (56) = happyShift action_30
action_84 (62) = happyShift action_2
action_84 (63) = happyShift action_31
action_84 (64) = happyShift action_32
action_84 (4) = happyGoto action_16
action_84 (5) = happyGoto action_17
action_84 (6) = happyGoto action_18
action_84 (16) = happyGoto action_19
action_84 (17) = happyGoto action_20
action_84 (18) = happyGoto action_21
action_84 (19) = happyGoto action_22
action_84 (20) = happyGoto action_23
action_84 (21) = happyGoto action_24
action_84 (22) = happyGoto action_90
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (32) = happyShift action_89
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_39

action_87 (27) = happyShift action_26
action_87 (32) = happyShift action_27
action_87 (37) = happyShift action_28
action_87 (50) = happyShift action_29
action_87 (56) = happyShift action_30
action_87 (62) = happyShift action_2
action_87 (63) = happyShift action_31
action_87 (64) = happyShift action_32
action_87 (4) = happyGoto action_16
action_87 (5) = happyGoto action_17
action_87 (6) = happyGoto action_18
action_87 (16) = happyGoto action_19
action_87 (17) = happyGoto action_20
action_87 (18) = happyGoto action_21
action_87 (19) = happyGoto action_22
action_87 (20) = happyGoto action_23
action_87 (21) = happyGoto action_24
action_87 (22) = happyGoto action_61
action_87 (23) = happyGoto action_88
action_87 _ = happyReduce_55

action_88 _ = happyReduce_57

action_89 (27) = happyShift action_26
action_89 (32) = happyShift action_27
action_89 (37) = happyShift action_28
action_89 (50) = happyShift action_29
action_89 (56) = happyShift action_30
action_89 (62) = happyShift action_2
action_89 (63) = happyShift action_31
action_89 (64) = happyShift action_32
action_89 (4) = happyGoto action_16
action_89 (5) = happyGoto action_17
action_89 (6) = happyGoto action_18
action_89 (16) = happyGoto action_19
action_89 (17) = happyGoto action_20
action_89 (18) = happyGoto action_21
action_89 (19) = happyGoto action_22
action_89 (20) = happyGoto action_23
action_89 (21) = happyGoto action_24
action_89 (22) = happyGoto action_102
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (39) = happyShift action_101
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_23

action_92 (27) = happyShift action_26
action_92 (32) = happyShift action_27
action_92 (37) = happyShift action_28
action_92 (50) = happyShift action_29
action_92 (56) = happyShift action_30
action_92 (62) = happyShift action_2
action_92 (63) = happyShift action_31
action_92 (64) = happyShift action_32
action_92 (4) = happyGoto action_16
action_92 (5) = happyGoto action_17
action_92 (6) = happyGoto action_18
action_92 (16) = happyGoto action_19
action_92 (17) = happyGoto action_20
action_92 (18) = happyGoto action_21
action_92 (19) = happyGoto action_22
action_92 (20) = happyGoto action_23
action_92 (21) = happyGoto action_24
action_92 (22) = happyGoto action_100
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (27) = happyShift action_26
action_93 (32) = happyShift action_27
action_93 (37) = happyShift action_28
action_93 (50) = happyShift action_29
action_93 (56) = happyShift action_30
action_93 (62) = happyShift action_2
action_93 (63) = happyShift action_31
action_93 (64) = happyShift action_32
action_93 (4) = happyGoto action_16
action_93 (5) = happyGoto action_17
action_93 (6) = happyGoto action_18
action_93 (16) = happyGoto action_19
action_93 (17) = happyGoto action_20
action_93 (18) = happyGoto action_21
action_93 (19) = happyGoto action_22
action_93 (20) = happyGoto action_23
action_93 (21) = happyGoto action_24
action_93 (22) = happyGoto action_99
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_29

action_95 _ = happyReduce_17

action_96 _ = happyReduce_15

action_97 (27) = happyShift action_26
action_97 (32) = happyShift action_27
action_97 (37) = happyShift action_28
action_97 (50) = happyShift action_29
action_97 (56) = happyShift action_30
action_97 (62) = happyShift action_2
action_97 (63) = happyShift action_31
action_97 (64) = happyShift action_32
action_97 (4) = happyGoto action_16
action_97 (5) = happyGoto action_17
action_97 (6) = happyGoto action_18
action_97 (16) = happyGoto action_19
action_97 (17) = happyGoto action_20
action_97 (18) = happyGoto action_21
action_97 (19) = happyGoto action_22
action_97 (20) = happyGoto action_23
action_97 (21) = happyGoto action_24
action_97 (22) = happyGoto action_98
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (39) = happyShift action_106
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (33) = happyShift action_105
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (33) = happyShift action_104
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_22

action_102 (33) = happyShift action_103
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (59) = happyShift action_71
action_103 (12) = happyGoto action_108
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_30

action_105 (59) = happyShift action_71
action_105 (12) = happyGoto action_107
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_21

action_107 (49) = happyShift action_109
action_107 _ = happyReduce_24

action_108 _ = happyReduce_26

action_109 (59) = happyShift action_71
action_109 (12) = happyGoto action_110
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_25

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn4
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Ident (tokenText happy_var_1))
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn5
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), (read (tokenText happy_var_1)) :: Integer)
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), ((\(PT _ (TL s)) -> s) happy_var_1))
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 ((fst happy_var_1, AbsGrammar.Prog (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_0  8 happyReduction_5
happyReduction_5  =  HappyAbsSyn8
		 ((AbsGrammar.BNFC'NoPosition, [])
	)

happyReduce_6 = happySpecReduce_2  8 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_2))
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  9 happyReduction_7
happyReduction_7 _
	(HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn9
		 ((fst happy_var_1, AbsGrammar.VarDecl (fst happy_var_1) (snd happy_var_1) (snd happy_var_2))
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 5 9 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 ((fst happy_var_1, AbsGrammar.VarDeclAss (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_4))
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 6 9 happyReduction_9
happyReduction_9 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 ((fst happy_var_1, AbsGrammar.FnDecl (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_4) (snd happy_var_6))
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_2  10 happyReduction_10
happyReduction_10 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn10
		 ((fst happy_var_1, AbsGrammar.ValArg (fst happy_var_1) (snd happy_var_1) (snd happy_var_2))
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  10 happyReduction_11
happyReduction_11 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn10
		 ((fst happy_var_1, AbsGrammar.RefArg (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_0  11 happyReduction_12
happyReduction_12  =  HappyAbsSyn11
		 ((AbsGrammar.BNFC'NoPosition, [])
	)

happyReduce_13 = happySpecReduce_1  11 happyReduction_13
happyReduction_13 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  11 happyReduction_14
happyReduction_14 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  12 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn13  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn12
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Blk (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_0  13 happyReduction_16
happyReduction_16  =  HappyAbsSyn13
		 ((AbsGrammar.BNFC'NoPosition, [])
	)

happyReduce_17 = happySpecReduce_2  13 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_2))
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  14 happyReduction_18
happyReduction_18 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Empty (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  14 happyReduction_19
happyReduction_19 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 ((fst happy_var_1, AbsGrammar.BStmt (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  14 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn14
		 ((fst happy_var_1, AbsGrammar.DStmt (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happyReduce 4 14 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((fst happy_var_1, AbsGrammar.Ass (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_3  14 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Ret (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  14 happyReduction_23
happyReduction_23 _
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.VRet (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happyReduce 5 14 happyReduction_24
happyReduction_24 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Cond (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5))
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 7 14 happyReduction_25
happyReduction_25 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.CondElse (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5) (snd happy_var_7))
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 5 14 happyReduction_26
happyReduction_26 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.While (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5))
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_1  14 happyReduction_27
happyReduction_27 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Break (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  14 happyReduction_28
happyReduction_28 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Continue (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  14 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn14
		 ((fst happy_var_1, AbsGrammar.SExp (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happyReduce 4 14 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Print (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3))
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_1  15 happyReduction_31
happyReduction_31 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Int (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  15 happyReduction_32
happyReduction_32 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Str (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  15 happyReduction_33
happyReduction_33 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Bool (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  15 happyReduction_34
happyReduction_34 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Void (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  16 happyReduction_35
happyReduction_35 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EVar (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  16 happyReduction_36
happyReduction_36 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.ELitInt (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  16 happyReduction_37
happyReduction_37 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.ELitTrue (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  16 happyReduction_38
happyReduction_38 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.ELitFalse (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happyReduce 4 16 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EApp (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_1  16 happyReduction_40
happyReduction_40 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EString (fst happy_var_1) (snd happy_var_1))
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  16 happyReduction_41
happyReduction_41 _
	(HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), (snd happy_var_2))
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  17 happyReduction_42
happyReduction_42 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Neg (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  17 happyReduction_43
happyReduction_43 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Not (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  17 happyReduction_44
happyReduction_44 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  18 happyReduction_45
happyReduction_45 (HappyAbsSyn16  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EMul (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  18 happyReduction_46
happyReduction_46 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  19 happyReduction_47
happyReduction_47 (HappyAbsSyn16  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EAdd (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  19 happyReduction_48
happyReduction_48 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  20 happyReduction_49
happyReduction_49 (HappyAbsSyn16  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.ERel (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  20 happyReduction_50
happyReduction_50 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  21 happyReduction_51
happyReduction_51 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EAnd (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  21 happyReduction_52
happyReduction_52 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  22 happyReduction_53
happyReduction_53 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, AbsGrammar.EOr (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  22 happyReduction_54
happyReduction_54 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((fst happy_var_1, (snd happy_var_1))
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_0  23 happyReduction_55
happyReduction_55  =  HappyAbsSyn23
		 ((AbsGrammar.BNFC'NoPosition, [])
	)

happyReduce_56 = happySpecReduce_1  23 happyReduction_56
happyReduction_56 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn23
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  23 happyReduction_57
happyReduction_57 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn23
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  24 happyReduction_58
happyReduction_58 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn24
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Plus (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  24 happyReduction_59
happyReduction_59 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn24
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Minus (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  25 happyReduction_60
happyReduction_60 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn25
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Times (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  25 happyReduction_61
happyReduction_61 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn25
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Div (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  25 happyReduction_62
happyReduction_62 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn25
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.Mod (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  26 happyReduction_63
happyReduction_63 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.LTH (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  26 happyReduction_64
happyReduction_64 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.LE (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  26 happyReduction_65
happyReduction_65 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.GTH (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  26 happyReduction_66
happyReduction_66 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.GE (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  26 happyReduction_67
happyReduction_67 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.EQU (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  26 happyReduction_68
happyReduction_68 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn26
		 ((uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1), AbsGrammar.NE (uncurry AbsGrammar.BNFC'Position (tokenLineCol happy_var_1)))
	)
happyReduction_68 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 65 65 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 27;
	PT _ (TS _ 2) -> cont 28;
	PT _ (TS _ 3) -> cont 29;
	PT _ (TS _ 4) -> cont 30;
	PT _ (TS _ 5) -> cont 31;
	PT _ (TS _ 6) -> cont 32;
	PT _ (TS _ 7) -> cont 33;
	PT _ (TS _ 8) -> cont 34;
	PT _ (TS _ 9) -> cont 35;
	PT _ (TS _ 10) -> cont 36;
	PT _ (TS _ 11) -> cont 37;
	PT _ (TS _ 12) -> cont 38;
	PT _ (TS _ 13) -> cont 39;
	PT _ (TS _ 14) -> cont 40;
	PT _ (TS _ 15) -> cont 41;
	PT _ (TS _ 16) -> cont 42;
	PT _ (TS _ 17) -> cont 43;
	PT _ (TS _ 18) -> cont 44;
	PT _ (TS _ 19) -> cont 45;
	PT _ (TS _ 20) -> cont 46;
	PT _ (TS _ 21) -> cont 47;
	PT _ (TS _ 22) -> cont 48;
	PT _ (TS _ 23) -> cont 49;
	PT _ (TS _ 24) -> cont 50;
	PT _ (TS _ 25) -> cont 51;
	PT _ (TS _ 26) -> cont 52;
	PT _ (TS _ 27) -> cont 53;
	PT _ (TS _ 28) -> cont 54;
	PT _ (TS _ 29) -> cont 55;
	PT _ (TS _ 30) -> cont 56;
	PT _ (TS _ 31) -> cont 57;
	PT _ (TS _ 32) -> cont 58;
	PT _ (TS _ 33) -> cont 59;
	PT _ (TS _ 34) -> cont 60;
	PT _ (TS _ 35) -> cont 61;
	PT _ (TV _) -> cont 62;
	PT _ (TI _) -> cont 63;
	PT _ (TL _) -> cont 64;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 65 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = ((>>=))
happyReturn :: () => a -> Err a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
