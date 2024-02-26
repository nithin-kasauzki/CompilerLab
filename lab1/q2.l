%{
/* Lex code for recognizing keywords, identifiers, and numeric data in C language */
%}

DIGIT   [0-9]
LETTER  [a-zA-Z]

%%

"//".*  ; 
"/*"([^*]|\*+[^*/])*"*/"  ;

int|float|char|if|else|while|for|return|include|switch|void|main|long|continue|break   { printf("\nKEYWORD: %s", yytext); }


{LETTER}({LETTER}|{DIGIT})*              { 
                                            if (strlen(yytext) <= 32) {
                                                printf("\nIDENTIFIER: %s", yytext);
                                            } else {
                                                printf("\nError: Identifier too lengthy");
                                            }
                                         }


{DIGIT}+(\.{DIGIT}+)?                    { printf("\nNUMERIC: %s", yytext); }

. ;
%%

int main() {
    yylex();
    return 0;
}
