%{

#include<stdio.h>
#include<stdlib.h>

int yylex();
int yyerror();

typedef char* string;

struct
{
	string op1;
	string op2;
	string res;
	char op;
}code[100];

int idx=-1;

string addToTable(string,string,char);
void assem();

%}

%union {

char *exp;
}

%token <exp> ID NUM
%type <exp> EXP

%right '='
%left '+' '-'
%left '*' '/'

%%

STMTS: STMTS STMT
     |
     ;
     
STMT: EXP '\n'
     ;
     
EXP : EXP '+' EXP  { $$= addToTable($1,$3,'+');}
    | EXP '-' EXP  { $$= addToTable($1,$3,'-');}
    | EXP '*' EXP  { $$= addToTable($1,$3,'*');}
    | EXP '/' EXP  { $$= addToTable($1,$3,'/');}
    | ID  {$$=$1;}
    | NUM {$$=$1;}
    ;
    
%%

int yyerror()
{
printf("\nInvalid\n");
exit(1);
}

int main()
{
yyparse();

assem();

return 0;
}

string addToTable(string op1,string op2,char op)
{
	idx++;
	
	string res=malloc(3);
	sprintf(res,"@%c",idx+'A');
	code[idx].op1=op1;
	code[idx].op2=op2;
	code[idx].op=op;
	code[idx].res=res;
	return res;
}

void assem()
{
	for(int i=0;i<=idx;i++)
	{
		string instr;
		switch(code[i].op)
		{
			case '+' : instr="ADD"; break;
			case '-' : instr="SUB"; break;
			case '*' : instr="MUL"; break;
			case '/' : instr="DIV"; break;
		}
		
		printf("-------------------------------------------------------------------------");
		printf("\nLOAD R1, %s",code[i].op1);
		printf("\nLOAD R2, %s",code[i].op2);
		printf("\n%s R3,R1,R2", instr);
		printf("\n STR %s, R3\n", code[i].res);
		printf("--------------------------------------------------------------------------");
	}
}
		



