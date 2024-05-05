yacc -d yacc.y
lex lex.l
gcc y.tab.c lex.yy.c -ll -ly -w
./a.out <input.c