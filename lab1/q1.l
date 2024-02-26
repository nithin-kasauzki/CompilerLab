%{

%}

%%
"//".*  ; 
"/*"([^*]|\*+[^*/])*"*/"  ;
[ \t\n]+ ;
[^ \t\n]+  {printf("%s\n",yytext);}

%%

int main() {
    yylex();
    return 0;
}
