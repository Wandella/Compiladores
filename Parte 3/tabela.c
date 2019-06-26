#include <string.h>
#include <stdio.h>
#include "tabela.h"

#define NMax 10 /* numero maximo de niveis */

int escopo[10];
int nivel;  /* guarda o nivel atual */
int L;      /* indice do ultimo elemento da Tabela de Simbolos */

void iniciaListaNO()
{
	L = 1;    /* Considera-se que a primeira posicao da tabela eh a de indice 1. */
	nivel = 1;           /* O primeiro nivel eh o 1 */
	escopo[nivel] = L;   /* escopo[1] contem o indice do primeiro elemento */
}

/************  Funcao que define os erros provaveis de ocorrer **********/

void Erro(int num){
	switch (num) {
		case 1: printf("\nERRO: Tabela de Simbolos cheia\n"); exit(1); break;
		case 2: printf("\nERRO: Item nao foi encontrado\n"); exit(2); break;
		case 3: printf("\nERRO: Item ja foi inserido\n"); exit(3); break;
		default: printf("\nOUTRO ERRO QUALQUER");
	}
}


/******************* Funcao de entrada num bloco ********************/

 void Entrada_Bloco(){printf("\n\n\nBLOCO = %d",nivel+1);
	nivel++;
	if (nivel > NMax) Erro(1);
	else escopo[nivel] = L;
}

/******************** Funcao de saida de um bloco ***********************/

 void Saida_Bloco(){printf("\n\n\nBLOCO = %d",nivel-1);
	escopo[nivel] = L;
	nivel--;
}

/****************  Funcao que pesquisa item na tabela*******************/
/* Pesquisa o simbolo "X" e retorna o indice da Tabela de simbolos onde ele se encontra */

int Recupera_Entrada(char* X)
{
	int K; /* percorre a lista */
	K = L;

	while (K > 1){
        	K--;
        	if( !strcmp(X, tabela_simbolos[K].nome ) ) return K;		// X foi encontrado
	}
    	Erro(2);
	return 0;
}

/***************  Funcao que instala o item na tabela*****************/
/* Instala o simbolo "X" com os atributos na Tabela de Simbolos */

 void Instala(char* X, int tipoVariavel)
{
	int tipoBoolean = 1;
	//alterações para salvar a variavel na tabela
	simbolo_t atribut;
	strcpy(atribut.nome,X);
	atribut.tipo = tipoVariavel;
	atribut.nivel = nivel;
	/*switch(tipoVariavel){//Identifica e retorna os tipos encontrados
			case INTEGER: 
				atribut.valor_inteiro = atoi(X);
				//printf("\n\nATOI = %d",atoi(X));
				break;
			case BOOLEAN: 
				if(strcmp("false",X))  tipoBoolean = 0;
				atribut.valor_boolean = tipoBoolean;
				//printf("\n\TIPBOOLEAN = %d",tipoBoolean);
				break;
			case CHAR: 
				atribut.valor_char = atoi(X);
				//printf("\n\nATOI = %d",atoi(X));
				break;
			default: printf("\nFALTA NOIS\n");break;
		}*/

	int K;
	K = L;
	
	while (K > escopo[nivel]) {
        K--;
        if( !strcmp(X, tabela_simbolos[K].nome) ) {	// X ja pertence a tabela
			Erro(3);
			return;
		}
	}

	tabela_simbolos[L] = atribut;
	L++;
//printf("\n\n\nINSTALA = %s %d\n",atribut.nome,L);
}

/******  Funcao que imprime alguns atributos da tabela de simbolos***********/

void Imprime_Tabela()
{
	int i;
	char nomeTipo[10];
	int valor;

	printf("\n\nTabela de Simbolos:\n");
	printf("===================\n\n");
	printf("INDICE\t\tTIPO\t\tNOME\t\tNIVEL\n");
	printf("======\t\t====\t\t====\t\t====\n");

	for (i = 1; i < L ; i++ )
	{
		switch(tabela_simbolos[i].tipo){//Identifica e retorna os tipos encontrados
			case INTEGER: 
				strcpy(nomeTipo,"integer");
				//valor = tabela_simbolos[i].valor_inteiro;
				break;
			case BOOLEAN: 
				strcpy(nomeTipo,"boolean");
				//valor = tabela_simbolos[i].valor_boolean;
				break;
			case CHAR: 
				strcpy(nomeTipo,"char");
				//valor = tabela_simbolos[i].valor_char;
				break;
			default: strcpy(nomeTipo,"tipo_definido");break;
		}
		printf("%d\t\t%s\t\t%s\t\t%d\n", i, nomeTipo, tabela_simbolos[i].nome, tabela_simbolos[i].nivel);
	}
}
