%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
int yyerror();

%}

%%
S : A B
  ;
  
A : 'a' A 'b'
  |
  ;
  
B : 'b' B 'c'
  |
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
 printf("\nValid\n");
 return 0;
 }
