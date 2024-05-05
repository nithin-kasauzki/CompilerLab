%{
#include "y.tab.h"
extern YYSTYPE yylval;
%}


%%

[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[-+*/=] { return yytext[0]; }
[a-zA-Z] { yylval = *yytext; return LETTER; }
"if" { return IF; }
"else" { return ELSE; }
";" { return SEMICOLON; }
"(" { return LPAREN; }
")" { return RPAREN; }
. { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
