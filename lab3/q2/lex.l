%{
#include "y.tab.h"
%}

%%
"while"            { printf("WHILE detected\n"); return WHILE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[a-zA-Z][a-zA-Z0-9]*    { return ID; }
[ \n\t]         ;
.               ;

%%

int yywrap() {
    return 1;
    //[a-zA-Z][a-zA-Z0-9]*    { printf("%s\n",yytext);return ID; }
}
