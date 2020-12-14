%{
#include <stdio.h>
#include "parser.hpp"
%}
%option noyywrap
%option outfile="lexer.cpp" header-file="lexer.hpp"
%%
[0-9]+ {yylval=atoi(yytext); return SMB;}
[ \t] ;
\n {return 0;}
. {return yytext[0];}
%%
