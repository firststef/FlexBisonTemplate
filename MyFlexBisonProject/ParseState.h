#pragma once
#include <string>

struct ParseState
{
	int hasError = 0;

	int errorLine = 1;
	int errorColumn = 1;
	std::string errorMessage;
	std::string errorToken;
};
