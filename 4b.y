%{
#include<stdio.h>
#include<stdlib.h>
int depth=0;
int yyerror();
int yylex();
%}

%token IF TYPE OP ID NUM
%left '+' '-'
%left '*' '/'

%%

SS : S1 ';' SS {$$=$3;}
   | I SS { $$=$1>$2?$1:$2;
   		if($$>depth)
   		{ depth=$$;}
   	}
   | {$$=0;}
   ;
   
I : IF '(' COND ')' BODY { $$=$5+1;}
  ;
  
BODY : S1 ';'  { $$=0;}
     | '{' SS '}' { $$=$2;}
     | I { $$=$1;}
     | ';' { $$ =0;}
     ;
     
S1 : A | D | E
   ;
   
A : ID '=' E
  ;
  
D : TYPE ID | TYPE A
  ;
  
E : E '+' E | E '-' E | E '*' E | E '/' E | T
  ;

T : ID | NUM
  ;

COND : E OP E
     ;
%%

int yyerror()
{
printf("\nError");
exit(1);
}

int main()
{
yyparse();
printf("\nNo of nesting:%d\n",depth);
return 0;
}
