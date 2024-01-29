%{
/* Lex code for recognizing operators in C language */
%}

%%

\+                                      { printf("add-OPERATOR: +\n"); }
\-                                      { printf("subtraction-OPERATOR: -\n"); }
\*                                      { printf("multiplication-OPERATOR: *\n"); }
\/                                      { printf("division-OPERATOR: /\n"); }
\%                                      { printf("modulo-OPERATOR: %%\n"); }
\=\=                                    { printf("equality-OPERATOR: ==\n"); }
\!\=                                    { printf("not equal-OPERATOR: !=\n"); }
\<                                      { printf("lessthan-OPERATOR: <\n"); }
\>                                      { printf("greater than-OPERATOR: >\n"); }
\&\&                                    { printf("and-OPERATOR: &&\n"); }
\|\|                                    { printf("or-OPERATOR: ||\n"); }

%%

int main() {
    yylex();
    return 0;
}
