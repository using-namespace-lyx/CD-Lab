%{
#include<stdio.h>
#include<stdlib.h>
int words=0,chars=0,spaces=0,lines=0;
%}

%%
[a-zA-Z]+ { words++; chars+=yyleng;}
[ ]       { spaces++; chars++;}
\n        { lines++; chars++;}
.         {chars++; }
%%

int yywrap()
{
return 1;
}

int main()
{
yylex();
printf("\nWords:%d\nChars:%d\nSpaces:%d\nLines:%d",words,chars,spaces,lines);
return 0;
}

