%{
#include <stdio.h>
%}
DIGIT [0-9]
RESERVED (int|void|if|for)
ID [a-zA-Z][a-zA-Z0-9_]*
COMMENT [/]{2}[^\n]*|[\/][\*][^\n]*[\*][\/]

%%

#define|#include {
        for(int i=0; yytext[i]!='\0'; i++)
        {
            yytext[i] = yytext[i] - 32;
        }
        printf("%s ", yytext + 1);
        }

{RESERVED} {
        for(int i=0; yytext[i]!='\0'; i++)
        {
            yytext[i] = yytext[i] - 32;
        }
        printf("%s ", yytext);
        }

"="|"+=" {
        printf("ASSIGN_OP ");
        }

"++"    {
        printf("INC_OP ");
        }

"+"|"-" {
        printf("ADD_OP ");
        }

"*"|"/" {
        printf("MUL_OP ");
        }

"&&"    {
        printf("LOGIC_OP ");
        }

"!="|"=="|"<"|">"|"<="|">=" {
        printf("REL_OP ");
        }

{ID}    printf("ID ");


{DIGIT}+ {
         printf("NUM ");
         }

{COMMENT} {
        printf("comment ");
        }

\[|\]|\(|\)|;|\,|\{|\} {
        printf("%s ", yytext);
        }

[ \t]+  {
        }

%%

