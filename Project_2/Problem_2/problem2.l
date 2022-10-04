%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%%

#define									return DEFINE;
#include								return INCLUDE;
int									return INT;
void									return VOID;
if									return IF;
for									return FOR;
[a-zA-Z_][a-zA-Z_0-9]*			yylval.string=strdup(yytext); 	return ID;
"="|"+="								return ASSIGN_OP;
"++"									return INC_OP;
"+"|"-"									return ADD_OP;
"*"|"/"									return MUL_OP;
"&&"|"||"								return LOGIC_OP;
"!="|"=="|"<"|">"|"<="|">="						return REL_OP;
[0-9]+	 				yylval.number=atoi(yytext);	return NUM;
"["|"]"|"{"|"}"|"("|")"|";"|","						return yytext[0];
\n 		                 	   	 			{yylineno ++;}
\/\/.*|\/\*.*\*\/							/* ignore commnets */
[ \t]+   		               					/* ignore whitespace */
%%


