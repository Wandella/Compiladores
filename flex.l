%{

/*codigo colocado aqui aparece no arquivo gerado pelo flex*/

%}

/* This tells flex to read only one input file */

%option noyywrap

/* definicoes regulares */

/*Espaços em branco, tabulação e quebra de linha*/
delim [ \t\n] 
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

abreParenteses \(
fechaParenteses \)
pontoVirgula ;
doisPontos :

%%
{ws} {/*nenhuma acao e nenhum retorno*/} /*Espaços em branco, tabulação e quebra de linha devem ser ignorados.*/

{comentario} {printf("<COMENT,'%s'>\n",yytext);}

{begin} {printf("<BEGIN,'%s'>\n",yytext);}
{boolean} {printf("<BOOLEAN,'%s'>\n",yytext);}
{char} {printf("<CHAR,'%s'>\n",yytext);}
{do} {printf("<DO,'%s'>\n",yytext);}
{else} {printf("<ELSE,'%s'>\n",yytext);}
{end} {printf("<END,'%s'>\n",yytext);}
{false} {printf("<FALSE,'%s'>\n",yytext);}
{endif} {printf("<ENDIF,'%s'>\n",yytext);}
{endwhile} {printf("<ENDWHILE,'%s'>\n",yytext);}
{exit} {printf("<EXIT,'%s'>\n",yytext);}
{if} {printf("<IF,'%s'>\n",yytext);}
{integer} {printf("<INTEGER,'%s'>\n",yytext);}
{procedure} {printf("<PROCEDURE,'%s'>\n",yytext);}
{program} {printf("<PROGRAM,'%s'>\n",yytext);}
{reference} {printf("<REFERENCE,'%s'>\n",yytext);}
{repeat} {printf("<REPEAT,'%s'>\n",yytext);}
{read} {printf("<READ,'%s'>\n",yytext);}
{return} {printf("<RETURN,'%s'>\n",yytext);}
{then} {printf("<THEN,'%s'>\n",yytext);}
{true} {printf("<TRUE,'%s'>\n",yytext);}
{type} {printf("<TYPE,'%s'>\n",yytext);}
{until} {printf("<UNTIL,'%s'>\n",yytext);}
{value} {printf("<VALUE,'%s'>\n",yytext);}
{write} {printf("<WRITE,'%s'>\n",yytext);}
{while} {printf("<WHILE,'%s'>\n",yytext);}
{not} {printf("<NOT,'%s'>\n",yytext);}

{op} {printf("<OP,'%s'>\n",yytext);}

{identificador} {printf("<ID,'%s'>\n",yytext);}

{constante} {printf("<CONST,'%s'>\n",yytext);}

{atribuicao} {printf("<ATRIBUICAO,'%s'>\n",yytext);}
{abreParenteses} {printf("<ABRE_PARENTESES,'%s'>\n",yytext);}
{fechaParenteses} {printf("<FECHA_PARENTESES,'%s'>\n",yytext);}
{pontoVirgula} {printf("<PONTO_VIRGULA,'%s'>\n",yytext);}
{doisPontos} {printf("<DOIS_PONTOS,'%s'>\n",yytext);}

. {printf("<ERRO,'%s'>\n",yytext); }



%%

int main(void)
{
/* Call the lexer, then quit. */
yylex();

return 0;
}
