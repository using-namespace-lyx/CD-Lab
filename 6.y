%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
int yyerror();

typedef char* string;

struct{
string op1;
string op2;
string res;
char op;
}code[100];

int idx=-1;
string addToTable(string, string,char);
void tac();
void quad();
// extern FILE* ip;
%}

%union{
char* exp;
}

%token<exp> ID NUM
%type<exp> EXP

%right '='
%left '+' '-'
%left '*' '/'


%%

STMTS : STMTS STMT
      |
      ;
      
STMT  : EXP '\n'
      ;
      
EXP   : EXP '+' EXP { $$=addToTable($1,$3,'+');}
      | EXP '-' EXP { $$=addToTable($1,$3,'-');}
      | EXP '*' EXP { $$=addToTable($1,$3,'*');}
      | EXP '/' EXP { $$=addToTable($1,$3,'/');}
      | ID '=' EXP { $$=addToTable($1,$3,'=');}
      | '(' EXP ')' { $$=$2;}
      | ID { $$=$1;}
      | NUM { $$=$1;}
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
printf("\nTAC\n");
tac();
printf("\nQuad\n");
quad();
return 0;
}

string addToTable(string op1,string op2, char op)
{
idx++;
if(op=='=')
{
code[idx].res=op1;
code[idx].op1=op2;
code[idx].op=op;
code[idx].op2="NULL";
return code[idx].res;
}
code[idx].op1=op1;
code[idx].op2=op2;
code[idx].op=op;

string res=malloc(3);
sprintf(res,"@%c",'A'+idx);
code[idx].res=res;

return res;
}

void tac()
{
for(int i=0;i<=idx;i++)
{
if(code[i].op=='=')
{
printf ("%s = %s",code[i].res,code[i].op1);
}
else
{
printf("%s = %s %c %s \n",code[i].res,code[i].op1,code[i].op,code[i].op2);
}
}
}

void quad()
{
for(int i=0;i<=idx;i++)
{
printf("%s\t%s\t %c\t %s \n",code[i].res,code[i].op1,code[i].op,code[i].op2);
}
}




