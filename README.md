# Flex Bison Grammar Project Template

This is an example project to help you run flex-bison with VisualStudio on Windows.
Using this project you can:
- start your own programming language by expanding MyFlexBisonProject
- run MyFlexConsole project for simple examples you want to test out
- skip that annoying command line visit for compiling .l and .y files and just press Build to 
- debug code in visual studio (put a breakpoint in the bison code and inspect the variables in that rule)
- use what you learned about lex but program in c++ (no more c!)
- explore with the power of a reentrant parser in bison - make a ParseState class and retain your current compiling context
- make your very own testing module for your language (see SPEL)

For reference, you can check out my first attempt ever at writing a programming language here:

[SPEL](https://github.com/firststef/SPEL)

### Installation

No need, flex and bison binaries are already provided

### Future improvements

If anybody wants, I can migrate the simple module for testing from the other project.

\++ ?

### Note

Note: usually if you simply run the flex and bison commands it should generally work line with yacc on linux (meaning some things that work in c are allowed).
Because I added
```
lexer.l
%option outfile="lexer.cpp" header-file="lexer.hpp"

parser.y
%output  "parser.cpp"
%defines "parser.hpp"
```
the code now behaves more like c++ and requires int yylex(void); to be defined in parser.y - most of the bison feature options are oriented towards c++.

### Collaborations

If you see anything that can be improved, please open a PR

### License

You can do anything you want with it, of course