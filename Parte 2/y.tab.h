/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEGER = 258,
    CONSTANTE = 259,
    OPERADOR = 260,
    PROGRAM_ = 261,
    IDENTIFICADOR = 262,
    PONTO_VIRGULA = 263,
    BEGIN_ = 264,
    ATRIBUICAO = 265,
    END = 266,
    DOIS_PONTOS = 267,
    VIRGULA = 268,
    BOOLEAN = 269,
    CHAR = 270,
    DO = 271,
    ELSE = 272,
    FALSE_ = 273,
    ENDIF = 274,
    ENDWHILE = 275,
    EXIT = 276,
    IF = 277,
    PROCEDURE = 278,
    REFERENCE = 279,
    REPEAT = 280,
    RETURN = 281,
    READ = 282,
    THEN = 283,
    TRUE_ = 284,
    TYPE = 285,
    UNTIL = 286,
    VALUE = 287,
    WRITE = 288,
    WHILE = 289,
    NOT = 290,
    ABRE_PARENTESES = 291,
    FECHA_PARENTESES = 292,
    UMINUS = 293
  };
#endif
/* Tokens.  */
#define INTEGER 258
#define CONSTANTE 259
#define OPERADOR 260
#define PROGRAM_ 261
#define IDENTIFICADOR 262
#define PONTO_VIRGULA 263
#define BEGIN_ 264
#define ATRIBUICAO 265
#define END 266
#define DOIS_PONTOS 267
#define VIRGULA 268
#define BOOLEAN 269
#define CHAR 270
#define DO 271
#define ELSE 272
#define FALSE_ 273
#define ENDIF 274
#define ENDWHILE 275
#define EXIT 276
#define IF 277
#define PROCEDURE 278
#define REFERENCE 279
#define REPEAT 280
#define RETURN 281
#define READ 282
#define THEN 283
#define TRUE_ 284
#define TYPE 285
#define UNTIL 286
#define VALUE 287
#define WRITE 288
#define WHILE 289
#define NOT 290
#define ABRE_PARENTESES 291
#define FECHA_PARENTESES 292
#define UMINUS 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 4 "y1.y" /* yacc.c:1909  */

 double real;
 int integer;
 

#line 136 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
