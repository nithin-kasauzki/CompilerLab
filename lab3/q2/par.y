%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();

void yyerror(const char*);

#define YYSTYPE YYSTYPE
#define YYDEBUG 1

typedef struct {
    char* str;
} YYSTYPE;

%}

%token WHILE LPAREN RPAREN ID

%%

statement : WHILE LPAREN ID RPAREN statement
        | ID
        ;


%%

void yyerror(const char *s) {
    printf("Error!\n");
    exit(0);
}

int main() {
    
    yyparse();
    printf("\nParsing successful\n");

    return 0;
}
