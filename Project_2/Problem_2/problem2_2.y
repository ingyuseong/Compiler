%{ 
#include <stdio.h> 
#include <string.h> 
#include "y.tab.h"
#include <stdlib.h>

char * recover_filename(FILE * f) {
  int fd;
  char fd_path[255];
  char * filename = malloc(255);
  ssize_t n;

  fd = fileno(f);
  sprintf(fd_path, "/proc/self/fd/%d", fd);
  n = readlink(fd_path, filename, 255);
  if (n < 0)
      return NULL;
  filename[n] = '\0';

  for (int i = 0; filename[i] != '\0'; i++)
  {
    if (filename[i] == '/')
    {
      filename+=i;
      i = 0;
    }
  }

  return ++filename;
}

void yyerror (char const *msg)
{
  extern FILE *yyin;
  extern int yylineno;
  extern char* yytext;
  fprintf(stderr,"%s:%d: error: %s \'%s\' token\n", recover_filename(yyin), yylineno, msg, yytext);
}

int yywrap() {
  return 1; 
}

main() {
  yyparse();
}
%} 

%token DEFINE INCLUDE INT VOID IF FOR ASSIGN_OP INC_OP ADD_OP MUL_OP LOGIC_OP REL_OP

%union
{
  int number;
  const char *string;
}

%token <number> NUM
%token <string> ID

%type <string> function_define_start

%% 
goal: /* empty */ 
    | goal stmt 
    ;
stmt: 
    stmt stmt 
    | function_define_start '{' stmt '}' { printf("fuction %s define matched\n", $1); } 
    | for_stmt_start '{' stmt '}' { printf("for statement matched\n"); } 
    | IF '(' compare_stmt LOGIC_OP compare_stmt ')' { printf("if statement matched\n"); } 
    | assignment_stmt 
    | declaration_stmt 
    | define_stmt 
    | error ';' 
    ;
function_define_start: 
    VOID ID '(' INT ID '[' ']' '[' ID ']' ',' INT ID '[' ']' '[' ID ']' ',' INT ID '[' ']' '[' ID ']' ')'  
    { $$ = $2; } 
    ;
for_stmt_start: 
    FOR '(' ID ASSIGN_OP NUM ';' ID REL_OP ID ';' ID INC_OP ')' 
    | FOR '(' ID ASSIGN_OP NUM ';' ID REL_OP ID ';' ID ASSIGN_OP NUM ')' 
    ;
assignment_stmt: 
    ID '[' index ']' '[' index ']' ASSIGN_OP expr ';'
    { printf("assignment statement matched\n"); } 
    ;
declaration_stmt: 
    INT ID ',' ID ',' ID ';'
    { printf("declaration statement matched\n"); } 
    ;
define_stmt: 
    DEFINE ID NUM 
    { printf("define statement matched\n"); } 
    ;
compare_stmt: 
    term REL_OP term 
    ;
expr: 
    expr ADD_OP term
    | expr MUL_OP term
    | term
    ;
term: 
    ID '[' index ']' '[' index ']'
    | NUM
    ;
index: 
    ID ADD_OP NUM
    | ID
    ;

%%
