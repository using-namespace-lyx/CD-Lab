%{
#include<stdio.h>
#include<stdlib.h>

int yyerror();
int yylex();
int depth=0;
%}

%token FOR TYPE OP ID NUM
%left '+' '-'
%left '*' '/'

%%

SS : S1 ';' SS { $$=$3;}
   | F SS { $$=$1>$2?$1:$2;
   	if($$>depth)
   	{
   	  depth=$$;
   	}
   	}
   | { $$=0;}
   ;
   
F : FOR '(' DA ';' COND ';' E ')' BODY {$$=$9+1;}
  ;
  
BODY : S1 ';'  { $$=0;}
     | '{' SS '}'{ $$ = $2;}
     | F {$$=$1;}
     | ';' {$$=0;}
     ;

DA : D | A
   ;
   
D : TYPE ID | TYPE A
  ;
  
A : ID '=' E 
  ;
  
E : E '+' E | E '-' E | E '*' E | E '/' E | E '+' '+' | '+' '+' E | '-' '-' E | E '-' '-' | T
  ;
  
T : ID | NUM
  ;
  
COND : T OP T
     ;
     
S1 : A | D | E
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
if(depth>=3)
{
printf("\nNo of nesting levels: %d",depth);
}
else
printf("\n INvalid with %d levels of max nesting",depth);
return 0;
}
