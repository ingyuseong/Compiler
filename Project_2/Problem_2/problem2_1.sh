yacc -d problem2_2.y
lex problem2.l
cc lex.yy.c y.tab.c -o project2_problem2 
