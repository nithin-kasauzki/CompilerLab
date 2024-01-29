%{
#include<stdio.h>
#include<string.h>
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
    
    extern FILE *yyin, *yyout;
         
    /* open the input file
        in read mode */
    yyin=fopen("input.txt", "r");
    yylex();
    printf("No of lines=%d\n",lines);
    printf("No of characters=%d",characters);
    return 0;
}
