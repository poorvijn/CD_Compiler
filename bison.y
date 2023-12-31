%{
#include <stdio.h>
#include<stdlib.h>
extern FILE* yyin;
%}

%token COMMA IDENTIFIER UNION STRUCT STATIC CONST INT FLOAT CHAR DOUBLE BOOL RETURN IF ELSE WHILE EQ NEQ LT GT LTEQ GTEQ PLUS MINUS MULT DIV ASSIGN SEMICOLON LPAREN RPAREN LBRACE RBRACE STRING_CONSTANT STRING_CHARACTER
%token INTEGER_CONSTANT FLOAT_CONSTANT ESCAPE_SEQUENCE
%%
program: struct_declaration { printf("Successful compilation"); exit(0) };
| union_declaration { printf("Successful compilation"); exit(0) };
struct_declaration: STRUCT identifier LBRACE member_list RBRACE SEMICOLON
|   STRUCT identifier SEMICOLON
                  ;

member_list: member_declaration
          | member_list member_declaration
          ;

member_declaration: STATIC type identifier ASSIGN expression SEMICOLON
                  | CONST type identifier ASSIGN expression SEMICOLON
                  | type identifier ASSIGN expression SEMICOLON
                  | type identifier SEMICOLON
                  | function_declaration
                  | union_declaration
                  | struct_declaration
                  ;
function_declaration: type identifier LPAREN parameter_list RPAREN LBRACE declarations statements RBRACE
                    ;
declarations: declaration
            | declarations declaration
            | /*empty*/
            ;

declaration: type identifier SEMICOLON
            |  type identifier ASSIGN expression SEMICOLON
           ;
parameter_list: parameter
              | parameter_list COMMA parameter
              | /*empty*/
              ;

parameter: type identifier
         ;

statements: statement 
          | statements statement
          | /*empty*/
          ;

statement: expression SEMICOLON
         | if_statement
         | while_statement
         | return_statement
         | block
         ;
if_statement: IF LPAREN condition RPAREN statement ELSE statement
            ;

while_statement: WHILE LPAREN condition RPAREN statement
               ;

return_statement: RETURN expression SEMICOLON
               ;

block: LBRACE statements RBRACE
     ;

condition: expression relational_operator expression
         ;

relational_operator: EQ
                   | NEQ
                   | LT
                   | GT
                   | LTEQ
                   | GTEQ
                   ;

type: INT
    | FLOAT
    | CHAR
    | DOUBLE
    | BOOL
    | identifier
    ;

expression: term
          | expression PLUS term 
          | expression MINUS term
          | assignment_statement
          ;

assignment_statement: identifier ASSIGN expression
          | type identifier ASSIGN expression 

identifier: IDENTIFIER 
          ;

union_declaration: UNION identifier LBRACE member_list RBRACE SEMICOLON 
                  ;

term: factor
    | term MULT factor
    | term DIV factor
    ;

factor: identifier
      | LPAREN expression RPAREN
      | constant
      ;

constant: integer_constant
        | float_constant
        | STRING_CONSTANT
        ;

integer_constant: INTEGER_CONSTANT
                | MINUS INTEGER_CONSTANT
                ;

float_constant: FLOAT_CONSTANT
              | MINUS FLOAT_CONSTANT
            ;
%%

int yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(0);
}

int main() {
    yyin=fopen("input_invalid.cpp","r");
    yyparse();
    return 0;
}