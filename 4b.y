%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int count=0;

%}

%token ID NUM IF

%%

S : I
  ;
  
I : IF '(' E ')' BODY {count++;}
  ;
  
E : T OP T | T
  ;
  
T : ID | NUM
  ;
  
OP : '=''='|'>''='|'!''='|'>'|'<'
   ;
   
BODY : I
     | E;
     | '{' SS '}'
     | ';'
     ;
     
SS : E ';' SS 
   | I SS
   |
   ;
  
%%

void yyerror()
{
printf("Error");
}

int main()
{
yyparse();
printf("\nCount:%d",count);
return 0;
}



