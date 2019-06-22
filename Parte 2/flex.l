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
maiorIgual \>\=
diferente {not}\=
exponencial \*\*
op [\|\&\<\>\=\+\-\*\/]|{diferente}|{not}|{menorIgual}|{maiorIgual}|{exponencial}

/*atribuicao*/
atribuicao :=
/*novo*/
igual =

abreParenteses \(
fechaParenteses \)
pontoVirgula ;
doisPontos :
virgula ,

%%
{quebra} {extern int lineno; lineno++; printf("\n%d-",lineno); }
{ws} {printf("Q");/*nenhuma acao e nenhum retorno*/} /*Espaços em branco, tabulação e quebra de linha devem ser ignorados.*/

{comentario} {printf("<COMENT,'%s'>\n",yytext);}

{begin} {printf("<BEGIN,'%s'>\n",yytext); return BEGIN_;}
{boolean} {printf("<BOOLEAN,'%s'>\n",yytext); return BOOLEAN;}
{char} {printf("<CHAR,'%s'>\n",yytext); return CHAR;}
{do} {printf("<DO,'%s'>\n",yytext); return DO;}
{else} {printf("<ELSE,'%s'>\n",yytext); return ELSE;}
{end} {printf("<END,'%s'>\n",yytext); return END;}
{false} {printf("<FALSE,'%s'>\n",yytext); return FALSE_;}
{endif} {printf("<ENDIF,'%s'>\n",yytext); return ENDIF;}
{endwhile} {printf("<ENDWHILE,'%s'>\n",yytext); return ENDWHILE;}
{exit} {printf("<EXIT,'%s'>\n",yytext); return EXIT;}
{if} {printf("<IF,'%s'>\n",yytext); return IF;}
{integer} {printf("<INTEGER,'%s'>\n",yytext); return INTEGER;}
{procedure} {printf("<PROCEDURE,'%s'>\n",yytext); return PROCEDURE;}
{program} {printf("<PROGRAM,'%s'>\n",yytext); return PROGRAM_;}
{reference} {printf("<REFERENCE,'%s'>\n",yytext); return REFERENCE;}
{repeat} {printf("<REPEAT,'%s'>\n",yytext); return REPEAT;}
{read} {printf("<READ,'%s'>\n",yytext); return READ;}
{return} {printf("<RETURN,'%s'>\n",yytext); return RETURN;}
{then} {printf("<THEN,'%s'>\n",yytext); return THEN;}
{true} {printf("<TRUE,'%s'>\n",yytext); return TRUE_;}
{type} {printf("<TYPE,'%s'>\n",yytext); return TYPE;}
{until} {printf("<UNTIL,'%s'>\n",yytext); return UNTIL;}
{value} {printf("<VALUE,'%s'>\n",yytext); return VALUE;}
{write} {printf("<WRITE,'%s'>\n",yytext); return WRITE;}
{while} {printf("<WHILE,'%s'>\n",yytext); return WHILE;}
{not} {printf("<NOT,'%s'>\n",yytext); return NOT;}

{op} {printf("<OP,'%s'>\n",yytext); return OPERADOR;}

{igual} {printf("<IGUAL,'%s'>\n",yytext); return IGUAL;}

{identificador} {printf("<ID,'%s'>\n",yytext); return IDENTIFICADOR;}

{constante} {sscanf(yytext,"%d",&yylval.integer); printf("<CONST,'%d'>",yylval.integer); return CONSTANTE;}

{atribuicao} {printf("<ATRIBUICAO,'%s'>\n",yytext); return ATRIBUICAO;}
{abreParenteses} {printf("<ABRE_PARENTESES,'%s'>\n",yytext); return ABRE_PARENTESES;}
{fechaParenteses} {printf("<FECHA_PARENTESES,'%s'>\n",yytext); return FECHA_PARENTESES;}
{pontoVirgula} {printf("<PONTO_VIRGULA,'%s'>\n",yytext); return PONTO_VIRGULA;}
{doisPontos} {printf("<DOIS_PONTOS,'%s'>\n",yytext); return DOIS_PONTOS;}
{virgula} {printf("<VIRGULA,'%s'>\n",yytext); return VIRGULA;}


. {printf("*");return yytext[0];  extern int qtdErro; qtdErro++;}

%%

