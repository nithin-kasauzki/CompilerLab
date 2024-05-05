%{
#include "y.tab.h"
#include <stdio.h>
#include <ctype.h>
char addtotable(char,char,char);
int yylex();
extern int yyparse();

int yyerror(const char *s);

%}

%token NUMBER LETTER IF ELSE SEMICOLON LPAREN RPAREN
%left '+' '-'
%left '*' '/'

%%

program: statement_list { printf("Parsed successfully\n"); }
       ;

statement_list: statement_list statement
              | statement
              ;

statement: exp SEMICOLON { printf("Statement: %d\n", $1); }
         | if_statement
         ;

if_statement: IF LPAREN exp RPAREN statement ELSE statement
            | IF LPAREN exp RPAREN statement
            ;

exp: exp '+' exp { $$ = $1 + $3; }
   | exp '-' exp { $$ = $1 - $3; }
   | exp '*' exp { $$ = $1 * $3; }
   | exp '/' exp { $$ = $1 / $3; }
   | LETTER { $$ = $1; }
   | NUMBER { $$ = $1; }
   | '(' exp ')' { $$ = $2; }
   ;

%%

int main() {
    //printf("Enter the program: \n");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Parser error: %s\n", s);
    return 0;
}
