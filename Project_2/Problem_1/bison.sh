yacc -d example1.y
lex example1.l
cc lex.yy.c y.tab.c -o project2_example1 
