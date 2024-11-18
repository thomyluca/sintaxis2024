%{

    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"

    void showError();
    int yylex();

%}

digito ([0-9])+
letra [a-zA-Z]
numero {digito}+
identificador {letra}({letra}|{digito})*
cadena      \"[^\"\n]*\"
argumento "args["{numero}"]"


%%

"inicio"                  return INICIO;
"fin"                     return FIN;
"definir"                 return DEFINIR;
"calcular"                return CALCULAR;
"mostrar"                 return MOSTRAR;
"entero"                  return ENTERO;
"decimal"                 return DECIMAL;
"analizar"                return ANALIZAR;
"fin_caso"                return FIN_CASO;
"palabra"                 return PALABRA;
"caso"                    return CASO;
"defecto"                 return DEFECTO;

{identificador}         {yylval.id = strdup(yytext); return ID;} 
{numero}                {yylval.numero = atoi(yytext); return NUMERO;}
{cadena}                {yylval.cadena = strdup(yytext); return CADENA;}
{argumento}             return ARGUMENTO;
"("                     return PAR_IZQUIERDO;
")"                     return PAR_DERECHO;
"{"                     return LLAVE_IZQUIERDA;
"}"                     return LLAVE_DERECHA;
"["                     return COR_IZQUIERDO;
"]"                     return COR_DERECHO;
";"                     return PUNTOYCOMA;
"+"                     return OP_SUMA;
"-"                     return OP_RESTA;
"*"                     return OP_PRODUCTO;
"/"                     return OP_DIVISION;
":"                     return DOS_PUNTOS;
"="                     return ASIGNACION;
[ \t\n]                 ;
.                       {showError();}

%%

int yywrap() {
    return 1;
}

void showError(char* other){
    printf("Error Lexico... \"%s\" \n", other);
}
