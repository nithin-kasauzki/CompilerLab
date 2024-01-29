%{
/* Lex code for recognizing keywords, identifiers, and numeric data in C language */
%}

DIGIT   [0-9]
LETTER  [a-zA-Z]

%%


int|float|char|if|else|while|for|return   { printf("\nKEYWORD: %s\n", yytext); }


{LETTER}({LETTER}|{DIGIT})*              { 
                                            if (strlen(yytext) <= 32) {
                                                printf("\nIDENTIFIER: %s\n", yytext);
                                            } else {
                                                printf("\nError: Identifier too lengthy\n");
                                            }
                                         }


{DIGIT}+(\.{DIGIT}+)?                    { printf("\nNUMERIC: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
