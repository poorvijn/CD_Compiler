%{
#include "bison.tab.h"
%}
digit [0-9]
letter [a-zA-Z]

%%
","             { return COMMA; }
"union"         { return UNION; }
"struct"        { return STRUCT; }
"static"        { return STATIC; }
"const"         { return CONST; }
"int"           { return INT; }
"float"         { return FLOAT; }
"char"          { return CHAR; }
"double"        { return DOUBLE; }
"bool"          { return BOOL; }
"return"        { return RETURN; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[0-9][0-9]*[.][0-9][0-9]* { return FLOAT_CONSTANT; }
[0-9][0-9]*    { return INTEGER_CONSTANT; }
"=="            { return EQ; }
"!="            { return NEQ; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LTEQ; }
">="            { return GTEQ; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"="             { return ASSIGN; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"            { return LBRACE; }
"}"             { return RBRACE; }
"\""            { return STRING_CONSTANT; }
'[^"\\]+'       { return STRING_CHARACTER; }
"\\"            { return ESCAPE_SEQUENCE; }
.               { /* ignore other characters */ }

%%

int yywrap() {}