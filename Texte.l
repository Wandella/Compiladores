%{

/*codigo colocado aqui aparece no arquivo gerado pelo flex*/

%}

/* This tells flex to read only one input file */

%option noyywrap

/* definicoes regulares */

/*Espaços em branco, tabulação e quebra de linha*/
delim [ \t\n] 

ws {delim}+

/*Número inteiro positivo: qualquer sequencia de um ou mais dígitos, precedidos ou não do símbolo +*/

digito [0-9]

int {digito}+

numP \+?{int}

/*Número inteiro negativo: qualquer sequencia de um ou mais dígitos, precedidos ou não do símbolo -*/
numN \-{int}

/*Número decimal: qualquer sequencia de um ou mais dígitos seguida de um ponto (.) e de outra sequencia de um ou mais dígitos.*/
numD \-?{digito}+\.{digito}+

/*Placa: três letras maiúsculas seguidas de um hífen (mesmo caractere dos números negativos) e de 4 dígitos.*/
placa [A-Z][A-Z][A-Z]\-{digito}{digito}{digito}{digito}

/*Palavra: qualquer sequencia de uma ou mais letras maiúsculas ou minúsculas (sem caractere especial ou letras acentuadas).*/
palavra [a-zA-Z]+

/*Telefone: 4 dígitos seguidos de um hífen (mesmo caractere dos números negativos) e de mais 4 dígitos.*/
telefone {digito}{digito}{digito}{digito}\-{digito}{digito}{digito}{digito}

/*Nome próprio: três ou quatro palavras, tendo necessariamente e exatamente um espaço em branco entre cada par dessas palavras. Um espaço ao final não é necessário.*/

nomeP {palavra}[ ]{palavra}[ ]{palavra}([ ]{palavra})?

%%
{ws} {/*nenhuma acao e nenhum retorno*/} /*Espaços em branco, tabulação e quebra de linha devem ser ignorados.*/

{numP} {printf("Foi encontrado um numero inteiro positivo. LEXEMA: %s\n",yytext);}
{numN} {printf("Foi encontrado um numero inteiro negativo. LEXEMA: %s\n",yytext);}
{numD} {printf("Foi encontrado um numero com parte decimal. LEXEMA: %s\n",yytext);}
{placa} {printf("Foi encontrado uma placa. LEXEMA: %s\n",yytext);}
{palavra} {printf("Foi encontrado uma palavra. LEXEMA: %s\n",yytext);}
{telefone} {printf("Foi encontrado um telefone. LEXEMA: %s\n",yytext);}
{nomeP} {printf("Foi encontrado um nome proprio. LEXEMA: %s\n",yytext);}

%%

int main(void)
{
/* Call the lexer, then quit. */
yylex();

return 0;
}
