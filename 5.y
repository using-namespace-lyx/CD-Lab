%{
#include<stdio.h>
#include<stdlib.h>
int count=0;
int yylex();
int yyerror();
%}

%token TYPE ID NUM

%%

D : TYPE LIST ';'
  ;
  
LIST : V	   {count++;}
     | LIST ',' V  {count++;}
     ;
     
V : ID
  | ID '[' NUM ']'
  ;
  
%%

int yyerror()
{
printf("\nError\n");
exit(1);
}

int main()
{
yyparse();
printf("\nCount:%d\n",count);
return 0;
}
