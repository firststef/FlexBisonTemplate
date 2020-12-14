%{
#include <stdio.h>
void yyerror(const char* s);
int yylex(void);
%}
%start s
%token SMB
%output  "parser.cpp"
%defines "parser.hpp"
%%
s : e  {$$=$1;  printf("regula s->e\n valoarea expresiei:%d\n",$$);}
  ;
e : e '+' e   {$$=$1+$3;printf("regula e->(e+e)\n"); }
  | e '*' e   {$$=$1*$3; printf("regula e->(e*e)\n"); }
  | SMB {$$=$1; printf("regula e->%d\n",$1); }
  ;
  
%%
void yyerror(const char* s) {
 printf("error:%s\n",s);
}

int main(){
 yyparse();
}
