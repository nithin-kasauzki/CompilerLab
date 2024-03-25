%{
#include "y.tab.h" 
%}
%%
"==" {return EQ;}
"if" { return IF; }
"else" { return ELSE; }
[0-9]+ { return NUMBER; }
[a-zA-Z][a-zA-Z0-9]* { return IDENTIFIER; }
[\n\t ]+  { return yytext[0]; } 
%%
int yywrap() { return 1;
}
