%{
int yylex();

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE* yyin;

#define YYERROR_VERBOSE 1
%}

%token INICIO FIN MOSTRAR CALCULAR ANALIZAR FIN_CASO CASO ENTERO DECIMAL DEFINIR ASIGNACION NULO DEFECTO PALABRA ARGUMENTO 
%token PUNTOYCOMA DOS_PUNTOS OP_DIVISION OP_PRODUCTO OP_RESTA OP_SUMA LLAVE_DERECHA LLAVE_IZQUIERDA PAR_DERECHO PAR_IZQUIERDO COR_IZQUIERDO COR_DERECHO
%token <id> ID
%token <numero> NUMERO
%token <cadena> CADENA

%union{
    char* id;
    char* cadena;
    int numero;
}

%%

programa:
    INICIO sentencias FIN
;

sentencias:
    sentencia 
    | sentencias sentencia
;

sentencia:
    sentencia_analizar
    | sentencia_mostrar PUNTOYCOMA
    | sentencia_definir PUNTOYCOMA
    | sentencia_calcular PUNTOYCOMA
;

sentencia_analizar:
    ANALIZAR ID LLAVE_IZQUIERDA sentencias_caso LLAVE_DERECHA
;

sentencias_caso: 
    lista_casos sentencia_defecto
    | lista_casos
;

lista_casos:
    caso
    | caso lista_casos
;

caso:
    CASO CADENA DOS_PUNTOS sentencias FIN_CASO
;

sentencia_defecto:
    DEFECTO DOS_PUNTOS sentencias FIN_CASO
;

sentencia_calcular:
    CALCULAR ID ASIGNACION expresion
;

expresion:
    termino
    | expresion OP_SUMA termino
    | expresion OP_RESTA termino
;

termino:
    primaria
    | termino OP_PRODUCTO primaria
    | termino OP_DIVISION primaria
;

primaria:
    ID
    | NUMERO
    | PAR_IZQUIERDO expresion PAR_DERECHO
;

sentencia_definir:
    DEFINIR ID DOS_PUNTOS tipo ASIGNACION tipo_definicion
;

tipo_definicion:
    expresion
    | ARGUMENTO

tipo:
    ENTERO
    | DECIMAL
    | PALABRA
;

sentencia_mostrar:
    MOSTRAR CADENA
    | MOSTRAR ID
;

%%

int yyerror(char *s){
    printf("Error Sintactico %s \n", s);
}

int main(int argc, char** argv) {
    if(argc < 2){
        printf("NUMERO INCORRECTO DE PARAMETROS");
        exit(1);
    }

    yyin = fopen(argv[1],"r");
    if(!yyin) {
        printf("No se pudo abrir el archivo");
        exit(1);
    }

    if(yyparse() == 0){
        printf("El codigo fue compilado exitosamente :)");
    }
    
    return 0;
}