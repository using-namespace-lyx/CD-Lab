%{
#include<stdio.h>
#include<stdlib.h>
int key=0,id=0,op=0;
%}

%%
"int"|"float"|"char"|"double"|"if"|"else"|"for"|"while" { key++;}

[a-zA-Z_][a-zA-Z_0-9]* { id++;}

[-+*/] {op++;}

[><=] {op++;}

"<="|">="|"=="|"!=" {op++;}

[\n\t ] { }

. { }

%%

int yywrap()
{
return 1;
}

int main()
{
yylex();
printf("\nKey:%d\nId:%d\nOp:%d\n",key,id,op);
return 0;
}
