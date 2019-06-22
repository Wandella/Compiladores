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
%token <abre_parenteses> ABRE_PARENTESES
%token <fecha_parenteses> FECHA_PARENTESES
%token <igual> IGUAL

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

block: BEGIN_ lista_comandos M0 END;

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

def_de_tipo: TYPE nome_do_tipo M0 IGUAL M1 definicao_de_tipo;

nome_do_tipo: IDENTIFICADOR;

definicao_de_tipo: ABRE_PARENTESES limites FECHA_PARENTESES tipo;

limites: inteiro DOIS_PONTOS inteiro;

tipo_definido: IDENTIFICADOR;

decl_de_proc: proc_cab proc_corpo;

proc_cab: tipo_retornado PROCEDURE M0 nome_do_proc espec_de_parametros;

proc_corpo: DOIS_PONTOS declaracoes M0 bloco emit_return
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

lista_comandos: {printf("COM");}comando 
	| {printf("LC");}lista_comandos PONTO_VIRGULA M0 comando;


lista_ids: IDENTIFICADOR 
	| lista_ids VIRGULA IDENTIFICADOR;

vazio: /*vazio*/;

espec_de_parametros: ABRE_PARENTESES lista_de_parametros FECHA_PARENTESES
	| vazio;

comando: comando_atribuicao
	|comando_while
	|comando_repeat
	|comando_if
	|comando_read
	|comando_write
	|comando_return
	|comando_exit
	|chamada_de_procedimento
	|rotulo DOIS_PONTOS comando;

comando_atribuicao: variavel ATRIBUICAO expr;

comando_while: WHILE  M0 expr DO M0 lista_de_comandos ENDWHILE;

comando_repeat: REPEAT M0 lista_de_comandos UNTIL M0 expr;

comando_if: IF expr THEN M0 lista_de_comandos ENDIF
	| IF expr THEN M0 lista_de_comandos M1
	ELSE M0 lista_de_comandos ENDIF;

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
	| {printf("EXPR-O1");}CONSTANTE OPERADOR expr{printf("EXPR-O2");}
	| CONSTANTE {printf("EXPR-C");}
	| variavel {printf("EXPR-V");}; /*ainda falta*/



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
