lex lex.l
yacc -d par.y
gcc y.tab.c lex.yy.c -o parser 
./parser < input.c