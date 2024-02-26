%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *msg);

int result;

%}

%union {
    int num;
    char* id;
}

%token <num> NUM
%token <id> ID
%token EOL

%left '+' '-'
%left '*' '/'
%left AND OR
%left '=' '<' '>'
%left UMINUS

%%

program:
    /* empty */
    | program statement EOL
    ;

statement:
    expression     { printf("Result: %d\n", $1); }
    ;

expression:
    NUM            { $$ = $1; }
    | ID           { /* lookup variable value and assign to $$ */ }
    | expression '+' expression   { $$ = $1 + $3; }
    | expression '-' expression   { $$ = $1 - $3; }
    | expression '*' expression   { $$ = $1 * $3; }
    | expression '/' expression   { $$ = $1 / $3; }
    | expression AND expression   { $$ = $1 && $3; }
    | expression OR expression    { $$ = $1 || $3; }
    | expression '=' expression   { $$ = ($1 == $3) ? 1 : 0; }
    | expression '<' expression   { $$ = ($1 < $3) ? 1 : 0; }
    | expression '>' expression   { $$ = ($1 > $3) ? 1 : 0; }
    | '-' expression %prec UMINUS { $$ = -$2; }
    | '(' expression ')'          { $$ = $2; }
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}
