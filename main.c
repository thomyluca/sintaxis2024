#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    // Verificar si se han pasado suficientes argumentos
    if (argc < 4) {
        printf("Error: Se necesitan 3 argumentos para un triángulo (figura, base, altura)\n");
        return 1;
    }

    // El primer argumento es la figura
    char *figura = argv[1];

    // Comparar la figura con "triangulo"
    if (strcmp(figura, "triangulo") == 0) {
        // Convertir los argumentos de cadena a números
        double base = atof(argv[2]); // Convertir el segundo argumento a número
        double altura = atof(argv[3]); // Convertir el tercer argumento a número

        // Calcular el área
        double area = (base * altura) / 2;

        // Mostrar el resultado
        printf("Área del triángulo: %.2f\n", area);
    } else {
        // Manejar el caso de figura no reconocida
        printf("Figura no reconocida\n");
    }

    return 0;
}
