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

%token IF LPAREN RPAREN ELSE ID

%%
program : statement;

statement : if_statement
        | ID
        ;

if_statement : IF LPAREN ID RPAREN statement 
        | IF LPAREN ID RPAREN statement ELSE statement
        ;


%%

void yyerror(const char *s) {
    printf("Failed!\n");
    exit(0);
}

int main() {
   
    yyparse();
    printf("\nParsing Success\n");
    return 0;
}
