%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
%}

/* Sección de definición de patrones */
DIGITO   [0-9]
LETRA    [a-zA-Z]
SIMBOLO  [+\-*\/=]
ESPACIOS [ \t\n]+
IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
NUMERO   {DIGITO}+ 
COMENTARIO    "//".*
DELIMITADOR [(){}:\[\],]  
TIPO_DATO   "entero"|"decimal"|"palabra"
PALABRA_RESERVADA  ("inicio"|"fin"|"definir"|"calcular"|"mostrar"|"fin_caso"|"nulo"|"caso"|"defecto")
COMILLA   \"

/* Sección de reglas de tokenización */
%%
\r    { /* Ignorar retornos de carro */ }
{PALABRA_RESERVADA} { printf("TOKEN PALABRA RESERVADA: %s\n", yytext); }
{TIPO_DATO} { printf("TOKEN TIPO DE DATO: %s\n", yytext); }
{IDENTIFICADOR} { printf("TOKEN IDENTIFICADOR: %s\n", yytext); }
{NUMERO} { printf("TOKEN NUMERO: %s\n", yytext); }
{SIMBOLO} { printf("TOKEN OPERADOR: %s\n", yytext); }
{DELIMITADOR} { printf("TOKEN DELIMITADOR: %s\n", yytext); }
{COMENTARIO} { /* ignorar comentarios */ }
{ESPACIOS} { /* ignorar espacios */ }
{COMILLA} { printf("TOKEN COMILLA: %s\n", yytext); }
. { printf("TOKEN DESCONOCIDO: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

void iniciar_analizador() {
    yylex();
}
