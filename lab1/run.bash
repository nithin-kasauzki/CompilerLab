lex q1.l
gcc lex.yy.c -o task1 -ll
./task1 < input.c  # Replace input.c with your C file

echo "------\n\n"

lex q2.l
gcc lex.yy.c -o task2 -ll
./task2 < input.c

echo "---------\n\n"
lex q3.l
gcc lex.yy.c -o task3 -ll
./task3 < input.c
