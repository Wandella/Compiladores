%{
#include <stdio.h>
%}
%union {
 double real;
 int integer;
 }

%token <integer> INTEGER
%token <constante> CONSTANTE
%token <operador> OPERADOR
%token <proxOp> PROX_OPERADOR

%token <program> PROGRAM_
%token <identificador> IDENTIFICADOR
%token <pronto_virgula> PONTO_VIRGULA
%token <begin> BEGIN_
%token <atribuicao> ATRIBUICAO
%token <end> END
%token <doisPontos> DOIS_PONTOS
%token <virgula> VIRGULA

%token <boolean> BOOLEAN
%token <char> CHAR
%token <do> DO
%token <else> ELSE
%token <false_> FALSE_
%token <endif> ENDIF
%token <endwhile> ENDWHILE
%token <exit> EXIT
%token <if> IF
%token <procedure> PROCEDURE
%token <reference> REFERENCE
%token <repeat> REPEAT
%token <return> RETURN
%token <read> READ
%token <then> THEN
%token <true_> TRUE_
%token <type> TYPE
%token <until> UNTIL
%token <value> VALUE
%token <write> WRITE
%token <while> WHILE
%token <not> NOT
%token <samuel> SAMUEL

%token <abre_parenteses> ABRE_PARENTESES
%token <fecha_parenteses> FECHA_PARENTESES

//%type <program> programa;
//%token <''> M0;
//%left '-'
//%left '*' '/'
%nonassoc UMINUS
%%
lines: /* nothing */ {printf("n");}
 | {printf("LL");} lines line {printf("LL");}
 ;
line: {printf("q");} | 
 | programa
 | error  {yyerror();}
 ;

programa: PROGRAM_ {printf("0");} M2 {printf("0");} declaracoes {printf("0");} M0 {printf("0");} block 
	| /**/ {printf("0");};

block: {printf(" BLOCO0 ");} BEGIN_ {printf(" BLOCO1 ");} lista_comandos {printf(" BLOCO2 ");} M0 END {printf(" BLOCO3 ");};

declaracoes: declaracoes M0 declaracao PONTO_VIRGULA
	| vazio {printf("1");};

declaracao: decl_de_var 
	| def_de_tipo
	| decl_de_proc;

decl_de_var: tipo DOIS_PONTOS lista_ids;

tipo: INTEGER 
	| BOOLEAN 
	| CHAR 
	| tipo_definido ;

M0: vazio;
M1: vazio;
M2: vazio;

def_de_tipo: TYPE nome_do_tipo M0 SAMUEL M1 definicao_de_tipo;

nome_do_tipo: IDENTIFICADOR;

definicao_de_tipo: ABRE_PARENTESES limites FECHA_PARENTESES tipo;

limites: inteiro DOIS_PONTOS inteiro;

tipo_definido: IDENTIFICADOR;

decl_de_proc: proc_cab proc_corpo;

proc_cab: tipo_retornado PROCEDURE M0 nome_do_proc espec_de_parametros;

proc_corpo: DOIS_PONTOS declaracoes M0 block emit_return
	| emit_return;

emit_return: vazio ;

lista_de_parametros: parametro
	| lista_de_parametros VIRGULA parametro;

tipo_retornado: INTEGER 
	| BOOLEAN 
	| CHAR 
	| vazio;

parametro: modo tipo DOIS_PONTOS IDENTIFICADOR;

modo: VALUE
	| REFERENCE;

nome_do_proc: IDENTIFICADOR;

lista_comandos: {printf(" LISTA_COMANDOS1_1 ");}comando {printf(" LISTA_COMANDOS1_2 ");} 
	| {printf(" LISTA_COMANDOS2_0 ");} lista_comandos {printf(" LISTA_COMANDOS2_1 ");} PONTO_VIRGULA M0 {printf(" LISTA_COMANDOS2_2 ");} comando {printf(" LISTA_COMANDOS2_3 ");};


lista_ids: IDENTIFICADOR 
	| lista_ids VIRGULA IDENTIFICADOR;

vazio: /*vazio*/;

espec_de_parametros: ABRE_PARENTESES lista_de_parametros FECHA_PARENTESES
	| vazio;

comando: {printf(" COMANDO_A ");}comando_atribuicao
	|{printf(" COMANDO_WH ");}comando_while
	|{printf(" COMANDO_R ");}comando_repeat
	|{printf(" COMANDO_IF ");}comando_if
	|{printf(" COMANDO_REA ");}comando_read
	|{printf(" COMANDO_WR ");}comando_write
	|{printf(" COMANDO_RET ");}comando_return
	|{printf(" COMANDO_EX ");}comando_exit
	|{printf(" COMANDO_PR ");}chamada_de_proc
	|{printf(" COMANDO_ROT ");}rotulo DOIS_PONTOS comando;

comando_atribuicao: variavel ATRIBUICAO expr;

comando_while: {printf("A0");} WHILE {printf("A1");} M0 expr {printf("A2");} DO {printf("A3");} M0 lista_comandos {printf("A4");} ENDWHILE {printf("A5");};

comando_repeat: REPEAT M0 lista_comandos UNTIL M0 expr;

comando_if: IF expr THEN M0 lista_comandos ENDIF
	| IF expr THEN M0 lista_comandos M1
	ELSE M0 lista_comandos ENDIF;

comando_read: READ variavel;

comando_write: WRITE expr;

comando_return: RETURN expr;

comando_exit: EXIT identificador;

rotulo: identificador;
	
variavel: identificador
	| chamada_ou_indexacao;

chamada_ou_indexacao: indices FECHA_PARENTESES;

chamada_de_proc: identificador
	| chamada_ou_indexacao;

indices: variavel2 ABRE_PARENTESES expr
	| indices VIRGULA expr;

variavel2: identificador;


expr: 	  expr {printf("EXPR");}
	| M0 expr
	| {printf("EXPR-O1");}PROX_OPERADOR OPERADOR expr{printf("EXPR-O2");}
	| CONSTANTE {printf("EXPR-C");}
	| variavel {printf("EXPR-V");}
	| ABRE_PARENTESES expr FECHA_PARENTESES; /*ainda falta*/

constante: int_ou_char
	| booleano;

int_ou_char: inteiro
	| CONSTANTE;

inteiro: CONSTANTE;

booleano: TRUE_
	| FALSE_;

identificador: IDENTIFICADOR;


%%
int lineno = 0;
main(){
yyparse();
}
yyerror(s)
char *s;
{
printf("calc: %s", s);
printf("line %d\n", lineno);
}
