%{
int lines=0;
int characters=0;
%}

%%
\n  {lines++;}
.   {characters++;}
end return 0;
%%

int yywrap(){return 1;}
int main()
{
    yylex();
    printf("No of lines=%d",lines);
    printf("No of characters=%d",characters);
    return 0;
}