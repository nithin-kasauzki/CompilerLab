%{

%}

%%
"//".*  ; 
"/*"([^*]|\*+[^*/])*"*/"  ;
[ \t\n]+ ;
[^ \t\n]+  {printf("%s",yytext);}

%%

int main() {
    yylex();
    return 0;
}
