%{
#include<stdio.h>
#include<stdlib.h>

int pf=0,nf=0,ni=0,pi=0;

%}

num [0-9]+
posint \+?{num}
negint -{num}
posfr (\+?{num}\/\+?{num})|(-{num}\/-{num})
negfr (-{num}\/\+?{num})|(\+?{num}\/-{num})

%%
{posint}  { pi++; }
{negint}  { ni++; }
{posfr}   { pf++; }
{negfr}   { nf++; }
[ \t] ;
[\n]      { return 0; }
%%

int yywrap()
{
return 1;
}

int main()
{
yylex();
printf("\nPI:%d\nPF:%d\nNI:%d\nNF:%d\n",pi,pf,ni,nf);
return 0;
}

