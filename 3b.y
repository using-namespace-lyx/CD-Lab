%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
int yyerror();

int count=0;

%}

%token TYPE FOR ID NUM OP
%left '+' '-'
%left '*' '/'

%%

S : F
  ;
  
F : FOR '(' DA ';' COND ';' S1 ')' BODY {count++;}
  ;
  
DA : D | A
   ;
   
D : TYPE ID | TYPE A
  ;
  
A : ID '=' E
  ;

E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;  

COND : T OP T
     ;

T : NUM | ID
  ;
  
BODY : S1 ';' | '{' SS '}' | F | ';'
     ;
     
S1 : E | D | A
   ;
   
SS : S1 ';' SS | F SS |
   ;
   
%%

int yyerror()
{
printf("errror");
exit(1);
}

int main()
{
yyparse();
printf("\nCount:%d",count);
}
  
