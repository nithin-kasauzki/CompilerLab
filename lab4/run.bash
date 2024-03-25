yacc -d yacc.y
lex lex.l
gcc y.tab.c lex.yy.c -w
./a.out 