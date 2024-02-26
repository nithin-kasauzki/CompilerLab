#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure to represent a symbol in the symbol table
struct Symbol {
    char name[50];
    char datatype[20];
    int offset;
    int size;
    char scope[20];
    struct Symbol* next;
};

// Function to insert a symbol into the symbol table
void insertSymbol(struct Symbol** table, char* name, char* datatype, int offset, int size, char* scope) {
    struct Symbol* newSymbol = (struct Symbol*)malloc(sizeof(struct Symbol));
    strcpy(newSymbol->name, name);
    strcpy(newSymbol->datatype, datatype);
    newSymbol->offset = offset;
    newSymbol->size = size;
    strcpy(newSymbol->scope, scope);
    newSymbol->next = *table;
    *table = newSymbol;
}

// Function to display the symbol table
void displaySymbolTable(struct Symbol* table) {
    printf("Symbol Table:\n");
    printf("%-15s%-15s%-10s%-10s%-15s\n", "Name", "Datatype", "Offset", "Size", "Scope");
    printf("---------------------------------------------------\n");
    while (table != NULL) {
        printf("%-15s%-15s%-10d%-10d%-15s\n", table->name, table->datatype, table->offset, table->size, table->scope);
        table = table->next;
    }
}

int main() {
    struct Symbol* symbolTable = NULL;

    // Example: Inserting symbols into the symbol table
    insertSymbol(&symbolTable, "variable1", "int", 0, 4, "global");
    insertSymbol(&symbolTable, "variable2", "float", 4, 4, "function1");
    insertSymbol(&symbolTable, "variable3", "char", 8, 1, "function2");

    // Display the symbol table
    displaySymbolTable(symbolTable);

    return 0;
}
