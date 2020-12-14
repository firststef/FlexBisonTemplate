#define YY_NO_UNISTD_H 1
#include <cstdio>
#include "parser.hpp"
#include "lexer.hpp"

using FILE = std::FILE;

//DOCS: Parse a string with a provided context
//Note: Make sure ParseState is initialized (previous errors have been cleared)
void s_compile(ParseState* parseState, const char* source){
	yyscan_t scanner;

	if (yylex_init_extra(parseState, &scanner))
	{
		parseState->hasError = 1;
		parseState->errorMessage = "Internal error: Lexer failed to initialize.";
		return;
	}

	YY_BUFFER_STATE state = yy_scan_string(source, scanner);

	bool parsingFailed = yyparse(parseState, scanner) > 0;

	if(parseState->hasError == 0 && parsingFailed)
	{
		parseState->hasError = 1;
		parseState->errorMessage = "Internal error: Parsing failed.";
		parseState->errorLine = -1;
		parseState->errorColumn = -1;
	}

	yy_delete_buffer(state, scanner);
	yylex_destroy(scanner);
}

//DOCS: Parse a string with a provided context
//Note: Make sure ParseState is initialized (previous errors have been cleared)
void f_compile(ParseState* parseState, FILE* source) {
	yyscan_t scanner;

	if (yylex_init_extra(parseState, &scanner))
	{
		parseState->hasError = 1;
		parseState->errorMessage = "Internal error: Lexer failed to initialize.";
		return;
	}

	yyset_in(source, scanner);
	bool parsingFailed = yyparse(parseState, scanner) > 0;

	if (parseState->hasError == 0 && parsingFailed)
	{
		parseState->hasError = 1;
		parseState->errorMessage = "Internal error: Parsing failed.";
		parseState->errorLine = -1;
		parseState->errorColumn = -1;
	}
	
	yylex_destroy(scanner);
}

int main(int argc, char** argv){
	if (argc > 1) {
		FILE* f = fopen(argv[1], "r");

		ParseState parse_state;
		f_compile(&parse_state, f);
	}
	else
	{
		printf("No source file input.");
	}
	
	return 0;
}
