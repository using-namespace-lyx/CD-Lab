%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yyerror();
int yylex();

int idx=-1;

typedef char* string;

struct{
string op1;
string op2;
string res;
char op;
}code[100];

string addToTable(string,string,char);
void assembly();

// extern FILE* ip;

%}

%union{
char* exp;
}

%token <exp> ID NUM
%type <exp> EXP

%right '='
%left '+' '-'
%left '*' '/'

%%

STMTS : STMTS STMT
      | 
      ;
      
STMT  : EXP '\n'
      ;
      
EXP   : EXP '+' EXP {$$=addToTable($1,$3,'+');}
      | EXP '-' EXP {$$=addToTable($1,$3,'-');}
      | EXP '*' EXP {$$=addToTable($1,$3,'*');}
      | EXP '/' EXP {$$=addToTable($1,$3,'/');}
      | ID '=' EXP { $$=addToTable($1,$3,'=');}
      | '(' EXP ')' { $$=$2;}
      | ID {$$=$1;}
      | NUM { 
    $$ = malloc(strlen($1) + 2);  // Allocate space for $1 + 1 character for '#' + 1 for '\0'
    sprintf($$, "#%s", $1);      
}
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
printf("\nAssembly\n");
assembly();
}

string addToTable(string op1,string op2,char op)
{
idx++;
if(op=='=')
{
code[idx].res=op1;
code[idx].op1=op2;
code[idx].op2="NULL";
code[idx].op=op;
return code[idx].res;
}
code[idx].op1=op1;
code[idx].op2=op2;
code[idx].op=op;
string res=malloc(3);
sprintf(res,"@%c",idx+'A');
code[idx].res=res;
return res;
}

void assembly()
{
string opp;
for(int i=0;i<=idx;i++)
{
switch(code[i].op)
{
case '+':
	opp="ADD";
	break;
case '-':
	opp="SUB";
	break;
	
case '*':
	opp="MUL";
	break;

case '/':
	opp="DIV";
	break;
	


}
if(code[i].op=='=')
{
printf("\nLD R4,%s",code[i].op1);
printf("\nST %s,R4",code[i].res);
continue;
}

printf("\nLD R1,%s",code[i].op1);
printf("\nLD R2,%s",code[i].op2);
printf("\n%s R3,R1,R2",opp);
printf("\nST %s,R3",code[i].res);
}
}





            
