%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// Declaración de la función iniciar_analizador
void iniciar_analizador();
%}


%union {
    int num;
    char* str;
}

%token <str> INICIO FIN DEFINIR MOSTRAR CASO FIN_CASO DEFECTO
%token <num> ENTERO DECIMAL NULO
%token <str> IDENTIFICADOR
%token <num> NUMERO
%token MAS MENOS MULT DIV IGUAL
%token PARENTESIS_IZQ PARENTESIS_DER

%%

// Las reglas de gramática permanecen sin cambios
Programa:
    INICIO Instrucciones FIN
    {
        printf("Programa válido.\n");
    }
    ;

Instrucciones:
    Instruccion Instrucciones
    |
    /* vacía */
    ;

Instruccion:
    DefinicionVariable
    | Mostrar
    | Expresion
    ;

DefinicionVariable:
    DEFINIR IDENTIFICADOR IGUAL Expresion
    {
        printf("Definición de variable: %s\n", $2);
    }
    ;

Mostrar:
    MOSTRAR Expresion
    {
        printf("Mostrar: expresión evaluada.\n");
    }
    ;

Expresion:
    Expresion MAS Termino
    | Expresion MENOS Termino
    | Termino
    ;

Termino:
    Termino MULT Factor
    | Termino DIV Factor
    | Factor
    ;

Factor:
    NUMERO
    | IDENTIFICADOR
    | PARENTESIS_IZQ Expresion PARENTESIS_DER
    ;

%% 

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("No se puede abrir el archivo");
            return 1;
        }
    }
    iniciar_analizador(); // Llamada a la función de Flex
    yyparse();
    fclose(yyin);
    return 0;
}
