%{
#include <stdio.h>
#include <stdlib.h>

// Definimos que Flex usará un archivo de entrada
FILE *yyin;
%}

/* Sección de definición de patrones */
DIGITO      [0-9]
LETRA       [a-zA-Z]
SIMBOLO     [+\-*/=]
ESPACIOS    [ \t\n]+
IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO})*
NUMERO      {DIGITO}+
COMENTARIO  "//".*
DELIMITADOR [(){}:]
TIPO_DATO   "entero"|"decimal"|"palabra"
PALABRA_RESERVADA "inicio"|"fin"|"definir"|"calcular"|"mostrar"|"fin_caso"|"nulo"|"caso"|"defecto"

/* Sección de reglas de tokenización */
%%
{ESPACIOS}           {/* ignorar espacios */}
{NUMERO}             { printf("TOKEN NUMERO: %s\n", yytext); }
{IDENTIFICADOR}      { printf("TOKEN IDENTIFICADOR: %s\n", yytext); }
{SIMBOLO}            { printf("TOKEN OPERADOR: %s\n", yytext); }
{COMENTARIO}         {/* ignorar comentarios */}
{DELIMITADOR}        { printf("TOKEN DELIMITADOR: %s\n", yytext); }
{TIPO_DATO}          { printf("TOKEN TIPO DE DATO: %s\n", yytext); }
{PALABRA_RESERVADA}  { printf("TOKEN PALABRA RESERVADA: %s\n", yytext); }
.                    { printf("TOKEN DESCONOCIDO: %s\n", yytext); }
%%

/* Función principal */
int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_de_entrada>\n", argv[0]);
        exit(1);
    }

    // Abrimos el archivo de entrada
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("No se pudo abrir el archivo");
        exit(1);
    }

    // Procesamos el archivo con yylex
    yylex();

    // Cerramos el archivo al terminar
    fclose(yyin);
    return 0;
}
