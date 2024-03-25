%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
extern int yyparse();


void yyerror(const char *s);
%}

%token IF ELSE IDENTIFIER NUMBER EQ

%%

program:
    | program statement ;

statement:
    IF '(' condition ')' '{' statements '}' ELSE '{' statements '}' { printf("Recognized IF-ELSE \n"); }
    | IF '(' condition ')' '{' statements '}' { printf("Recognized IF \n"); }
    ;

condition:
    IDENTIFIER EQ NUMBER
    | NUMBER
    ;

statements:
    
    | statement statements
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {

    yyparse();
    printf("Parse Success ");
    return 0;
}
