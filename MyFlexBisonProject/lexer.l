%{
#include "parser.hpp"

void update_loc(yyscan_t scanner);
#define YY_USER_ACTION update_loc(yyscanner);

int lineno;
int column;
#define YY_USER_INIT lineno = 1; column = 1;

void push_stack_context(yyscan_t scanner);
#define PUSH_STACK_CONTEXT push_stack_context(yyscanner);
%}

%option yylineno reentrant noyywrap nounistd bison-bridge bison-locations
%option outfile="lexer.cpp" header-file="lexer.hpp"
%option extra-type="struct ParseState *"

 /* DEFINITIONS HERE */

%%

 /* RULES HERE */

 /* Example: */
Hello   { return HELLO; }
World   { return WORLD; }
[ \t]   ;
\n      {return 0;}
.       {return yytext[0];}

%%

 /* SUBROUTINES HERE */
 /* DOCS: update_loc corrects error (token) positions */
void update_loc(yyscan_t scanner) {
	
	struct yyguts_t * yyg = (struct yyguts_t*)scanner;

	yylloc->first_line = lineno;
	yylloc->first_column = column;

	{char * s; for (s = yytext; *s != '\0'; s++) {
		if (*s == '\n') {
			lineno++;
			column = 1;
		}
		else {
			column++;
		}
	}}

	yylloc->last_line = lineno;
	yylloc->last_column = column - 1;

	static std::string saved_token;
	saved_token = yytext;
	yylloc->last_token = saved_token.c_str();
}