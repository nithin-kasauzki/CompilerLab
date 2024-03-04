%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token WHILE LPAREN RPAREN LBRACE RBRACE ID NUM EQ NEQ LT GT LTE GTE

%left EQ NEQ LT GT LTE GTE

%%
// Rest of your grammar

int yylex();
void yyerror(const char *s);

int main() {
    yyparse();
    return 0;
}

int yywrap() {
    return 1;
}
