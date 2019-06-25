%{
#include <stdio.h>
#include "tabela.h"

int tipoVariaveis; //fica salvo o valor correspondente do tipo, de acordo com a definição do próprio YACC => INTEGER | BOOLEAN | CHAR


//analise semantica
void verificaVariavelAlocada(char *identificador){
	int nivel;
	nivel = Recupera_Entrada(identificador);
	if(nivel==0) exit(3);
}

void verificaTipo(){

}

void verificaOverflow(){}

void verificaParametros(){}

%}
%union {
 double real;
 int integer;
 char text[20]; /*FALTA DEFINIR TAMANHO MAX DE IDENTIFICADORES*/
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
%token <sinalIgual> SINAL_IGUAL

%token <abre_parenteses> ABRE_PARENTESES
%token <fecha_parenteses> FECHA_PARENTESES

//%type <program> programa;
//%token <''> M0;
//%left '-'
//%left '*' '/'
%nonassoc UMINUS
%%
linhas: /*vazio*/
 	| linhas linha;

linha: 
	| programa
	| error{yyerror();exit(2);};

programa: PROGRAM_{Entrada_Bloco();/*abre bloco*/} M2 declaracoes M0 block;

block: BEGIN_ lista_comandos M0 END{Saida_Bloco(); /*fecha bloco*/};

declaracoes: declaracoes M0 declaracao PONTO_VIRGULA
	| vazio;

declaracao: decl_de_var
	| def_de_tipo
	| decl_de_proc;

decl_de_var: tipo DOIS_PONTOS lista_ids;

tipo: INTEGER{tipoVariaveis = INTEGER;}
	| BOOLEAN{tipoVariaveis = BOOLEAN;}
	| CHAR{tipoVariaveis = CHAR;}
	| tipo_definido ;

M0: vazio;
M1: vazio;
M2: vazio;

def_de_tipo: TYPE nome_do_tipo M0 SINAL_IGUAL M1 definicao_de_tipo;

nome_do_tipo: IDENTIFICADOR;

definicao_de_tipo: ABRE_PARENTESES limites FECHA_PARENTESES tipo;

limites: inteiro DOIS_PONTOS inteiro;

tipo_definido: IDENTIFICADOR;

decl_de_proc: proc_cab proc_corpo;

proc_cab: tipo_retornado PROCEDURE M0 nome_do_proc espec_de_parametros;

proc_corpo: DOIS_PONTOS {Entrada_Bloco();/*abre bloco*/}declaracoes M0 block emit_return
	| emit_return;

emit_return: vazio ;

lista_de_parametros: parametro
	| lista_de_parametros VIRGULA parametro;

tipo_retornado: INTEGER
	| BOOLEAN
	| CHAR
	| vazio;

parametro: modo tipo DOIS_PONTOS IDENTIFICADOR{Instala(yylval.text, tipoVariaveis);};

modo: VALUE
	| REFERENCE;

nome_do_proc: IDENTIFICADOR;

lista_comandos: comando
	|lista_comandos PONTO_VIRGULA M0 comando;


lista_ids: lista_ids VIRGULA IDENTIFICADOR{printf("%s",yylval.text);Instala(yylval.text, tipoVariaveis);}
	|IDENTIFICADOR{Instala(yylval.text, tipoVariaveis);};

vazio: /*vazio*/;

espec_de_parametros: ABRE_PARENTESES lista_de_parametros FECHA_PARENTESES
	|vazio;

comando: comando_atribuicao
	|comando_while
	|comando_repeat
	|comando_if
	|comando_read
	|comando_write
	|comando_return
	|comando_exit
	|chamada_de_proc
	|rotulo DOIS_PONTOS comando;

comando_atribuicao: variavel ATRIBUICAO expr;

comando_while: WHILE M0 expr DO M0 lista_comandos ENDWHILE;

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


expr: expr OPERADOR M0 expr
	|expr
	|variavel
	|constante
	|ABRE_PARENTESES expr FECHA_PARENTESES; /*ainda falta*/

constante: int_ou_char
	| booleano;

int_ou_char: inteiro
	| CONSTANTE;

inteiro: CONSTANTE;

booleano: TRUE_
	| FALSE_;

identificador: IDENTIFICADOR{verificaVariavelAlocada(yylval.text);};


%%
extern YYSTYPE yylval; //pra pegar os atributos do token lido
int lineno = 1;
int qtdErros = 0;
main(){
	iniciaListaNO(); //inicializa a lista da tabela de simbolos
	printf("\n%d-",lineno); //inicia a primeira linha do codigo a ser mostrado
	yyparse(); //chamada do lex

}

/*printa o erro sintatico*/
yyerror(s)
char *s;
{ //chamado quando ha erros
//printf("************************* ERRO DE SINTAXE: %s", s);
printf("\n************************* ERRO Sintático próximo a linha %d\n", lineno);

}
