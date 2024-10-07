%{
#include "y.tab.h"
%}

%%
"if" {return IF;}
"int"|"float"|"double"|"char" {return TYPE;}
">"|"<"|">="|"<="|"!="|"==" { return OP;}
[a-zA-Z]+ { return ID;}
[0-9]+ { return NUM;}
[\n\t ] { }
. { return yytext[0];}

%%

int yywrap()
{
return 1;
}
