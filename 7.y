%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
int yyerror();
%}

%token ID NUM TYPE RETURN

%%

S : F
  ;
  
F : TYPE ID '(' PARAMLIST ')' '{' SS R '}'
  ;
  
PARAMLIST : TYPE ID
          | PARAMLIST ',' TYPE ID
          | 
          ;

SS : S1 ';' SS
    | 
    ;

S1 : D | A | E
   ;
   
D : TYPE ID
  | TYPE A
  ;
  
A : ID '=' E
  ;
  
E : E '+' E | E '-' E | E '*' E | E '/' E | NUM | ID
  ;
  
R : RETURN ID ';' | RETURN NUM ';' | RETURN ';'

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
