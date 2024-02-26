#!/bin/bash
#bash run.sh or ./run.sh
lex lex.l

yacc -d yacc.y

gcc lex.yy.c y.tab.c symbol_table.c -o parser

./parser
