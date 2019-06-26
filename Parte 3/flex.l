%{
#include "y.tab.h"
%}

/* This tells flex to read only one input file */

%option noyywrap

/* definicoes regulares */

/*Espaços em branco, tabulação e quebra de linha*/
/*novo*/
quebra \n
/*retirou o \n*/
delim [ \t]
ws {delim}+

/*novo*/
sinalIgual =

/*palavras reservadas*/
begin begin
boolean boolean
char char
do do
else else
end end
false false
endif endif
endwhile endwhile
exit exit
if if
integer integer
procedure procedure
program program
reference reference
repeat repeat
read read
return return
then then
true true
type type
until until
value value
write write
while while
not not

/*identificador*/
identificador [a-zA-Z_][a-zA-Z_0-9]*

/*comentarios*/
inicioComentario \/\*
fimComentario \*\/
ascii [\\0-~ ]
comentario {inicioComentario}{ascii}*{fimComentario}

/*constante*/
digito [0-9]
constante \-?{digito}+

/*operadores*/
menorIgual <=
maiorIgual >=
diferente {not}=
exponencial \*\*
op [\|\&\<\>\+\-\*\/]|{diferente}|{not}|{menorIgual}|{maiorIgual}|{exponencial}

/*atribuicao*/
atribuicao :=

abreParenteses \(
fechaParenteses \)
pontoVirgula ;
doisPontos :
virgula ,

%%
{quebra} {extern int lineno; lineno++; printf("\n%d-",lineno); }
{ws} {printf("%s",yytext);/*nenhuma acao e nenhum retorno*/} /*Espaços em branco, tabulação e quebra de linha devem ser ignorados.*/

{comentario} {printf("%s",yytext);}

{sinalIgual} {printf("%s",yytext); return SINAL_IGUAL;}

{begin} {printf("%s",yytext); return BEGIN_;}
{boolean} {printf("%s",yytext); yylval.tipoVariavel = BOOLEAN; return BOOLEAN;}
{char} {printf("%s",yytext); yylval.tipoVariavel = CHAR; return CHAR;}
{do} {printf("%s",yytext); return DO;}
{else} {printf("%s",yytext); return ELSE;}
{end} {printf("%s",yytext); return END;}
{false} {printf("%s",yytext); return FALSE_;}
{endif} {printf("%s",yytext); return ENDIF;}
{endwhile} {printf("%s",yytext); return ENDWHILE;}
{exit} {printf("%s",yytext); return EXIT;}
{if} {printf("%s",yytext); return IF;}
{integer} {printf("%s",yytext); yylval.tipoVariavel = INTEGER; return INTEGER;}
{procedure} {printf("%s",yytext); return PROCEDURE;}
{program} {printf("%s",yytext); return PROGRAM_;}
{reference} {printf("%s",yytext); return REFERENCE;}
{repeat} {printf("%s",yytext); return REPEAT;}
{read} {printf("%s",yytext); return READ;}
{return} {printf("%s",yytext); return RETURN;}
{then} {printf("%s",yytext); return THEN;}
{true} {printf("%s",yytext); return TRUE_;}
{type} {printf("%s",yytext); return TYPE;}
{until} {printf("%s",yytext); return UNTIL;}
{value} {printf("%s",yytext); return VALUE;}
{write} {printf("%s",yytext); return WRITE;}
{while} {printf("%s",yytext); return WHILE;}
{not} {printf("%s",yytext); return NOT;}

{op} {printf("%s",yytext); yylval.operador = atoi(yytext); return OPERADOR;}

{identificador} {sscanf(yytext, "%s", &yylval.text); printf("%s",yytext); return IDENTIFICADOR;}

{constante} {printf("%s",yytext); yylval.integer = atoi(yytext); return CONSTANTE;}

{atribuicao} {printf("%s",yytext); return ATRIBUICAO;}
{abreParenteses} {printf("%s",yytext); return ABRE_PARENTESES;}
{fechaParenteses} {printf("%s",yytext); return FECHA_PARENTESES;}
{pontoVirgula} {printf("%s",yytext); return PONTO_VIRGULA;}
{doisPontos} {printf("%s",yytext); return DOIS_PONTOS;}
{virgula} {printf("%s",yytext); return VIRGULA;}


. {extern int lineno, qtdErros; printf("### Erro LEXICO próximo a linha %d# \n", lineno);return yytext[0]; qtdErros++;exit(1);}

<<EOF>> {extern int lineno, qtdErros; if(qtdErros==0) printf(" Programa sintaticamente correto!\n"); Imprime_Tabela(); exit(0);}

%%

