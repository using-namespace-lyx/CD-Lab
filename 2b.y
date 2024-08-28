%{
#include<stdio.h>
#include<stdlib.h>

int yyerror();
int yylex();

%}

%token NUM

%left '+' '-'
%left '*' '/' 

%%

S : E { printf("\nResult:%d\n",$$);}
  ;
  
E : E '+' E { $$=$1+$3;}
  | E '-' E { $$=$1-$3;}
  | E '*' E { $$=$1*$3;}
  | E '/' E { $$=$1/$3;}
  | '(' E ')' { $$=$2;}
  | NUM     { $$=$1;}
  ;
  
%%

int yyerror(){
printf("\nInvalid");
exit(1);
}

int main()
{
yyparse();
return 0;
}
