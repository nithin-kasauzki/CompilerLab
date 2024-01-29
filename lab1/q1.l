%{
/* Lex code for ignoring redundant spaces, tabs, new lines, 
single line
and multiline comments */
%}

%%

[ \t\n] ;


\/\/.* ;


\/\*([^*]|\*+[^*/])*\*+\/ ;
