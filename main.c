#include <stdio.h>
#include <stdlib.h>

// Declaramos la función yylex que Flex generará
extern int yylex();

// Definimos la variable externa para la entrada
extern FILE *yyin;

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_de_entrada>\n", argv[0]);
        exit(1);
    }

    // Abrimos el archivo que contiene el código de entrada
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("No se pudo abrir el archivo");
        exit(1);
    }

    // Procesamos el archivo con el scanner generado por Flex
    int token;
    while (token = yylex()) {
        // Flex ya imprime cada token, pero podrías agregar más procesamiento aquí si lo necesitas
    }

    // Cerramos el archivo al terminar
    fclose(yyin);
    return 0;
}