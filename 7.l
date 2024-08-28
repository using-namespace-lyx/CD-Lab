%{
#include "y.tab.h"
%}

%%
"int"|"float"|"char"|"double"|"void" { return TYPE;}
"return" { return RETURN;}
[a-zA-Z]+ { return ID;}
[0-9]+ {return NUM;}
[\n\t ] { }
. { return yytext[0];}
%%

int yywrap()
{
return 1;
}
