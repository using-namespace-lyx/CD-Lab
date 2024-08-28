%{
#include<stdio.h>
#include<stdlib.h>
int count=0;
FILE *op;
%}

%%

"//".* { count++;}

"/*"([^*]|\*+[^*/])*"*/" { printf("\n%s\n",yytext);
count++;
				for(int i=0;i<yyleng;i++)
				{
					if(yytext[i]=='\n')
						count++;
				}
				}
.|\n  { fprintf(op,"%s", yytext);}

%%

int yywrap()
{
return 1;
}

int main()
{
	FILE * ip=fopen("input.c","r");
	op=fopen("output.txt","w");
	
	yyin=ip;
	yylex();
	printf("\nCount:%d\n",count);
	fclose(ip);
	fclose(op);
	return 0;
}

