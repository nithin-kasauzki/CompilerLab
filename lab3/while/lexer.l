%{
#include "parser.tab.h"
%}

%%

"while"     { return WHILE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
"=="        { return EQ; }
"!="        { return NEQ; }
"<"         { return LT; }
">"         { return GT; }
"<="        { return LTE; }
">="        { return GTE; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return ID; }
[0-9]+      { yylval.ival = atoi(yytext); return NUM; }
[ \t\n]     ;  /* Skip whitespaces */

.           { printf("Error: Invalid character %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
