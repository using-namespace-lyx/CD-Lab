%{
#include "y.tab.h"
#include<string.h>
%}

%%
[a-zA-Z]+ { yylval.exp=strdup(yytext);
		return ID;
		}

[0-9]+ { yylval.exp=strdup(yytext);
	return NUM;}
	
[-+*/] { return yytext[0];}

[()=] { return yytext[0];}

[\n]+ { return '\n';}

[\t ] ;

. ;

%%

int yywrap()
{
return 1;
}


