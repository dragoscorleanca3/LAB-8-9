%{
#include <stdio.h>
#include <stdlib.h>

#define YYDEBUG 1
%}

%token array
%token char
%token const
%token while
%token else
%token int
%token if
%token input
%token output
%token string
%token program
%token not
%token IDENTIFIER
%token CONSTANT
%token PLUS
%token MINUS
%token ASTERISK
%token DIVIDE
%token ASSIGN
%token L
%token G
%token LE
%token GE
%token AMPERSAND
%token BAR
%token AND
%token OR
%token SPACE
%token LEFT_CURLY_BRACKETS
%token RIGHT_CURLY_BRACKETS
%token LEFT_BRACKETS
%token RIGHT_BRACKETS
%token SEMI_COLON
%token LEFT_PARANTHESIS
%token RIGHT_PARANTHESIS

%start program

%%

program ::= decllist ";" cmpdstmt "."
decllist ::= declaration | declaration ";" decllist
declaration ::= IDENTIFIER ":" type
type1 ::="char" | "int"
arraydecl ::= type1 "[" nr "]"
type  ::= type1|arraydecl
cmpdstmt ::= "BEGIN" stmtlist "END"
stmtlist ::= stmt | stmt ";" stmtlist
stmt ::= simplstmt | structstmt
simplstmt ::= assignstmt | iostmt
assignstmt ::= IDENTIFIER "=" expression
expression ::= expression "+" term | term
term ::= term "*" factor | factor
factor ::= "(" expression ")" | IDENTIFIER
iostmt ::= "READ" | "WRITE" "(" IDENTIFIER ")"
structstmt ::= cmpdstmt | ifstmt | whilestmt
ifstmt ::= "IF" condition "THEN" stmt ["ELSE" stmt]
whilestmt ::= "WHILE" condition "DO" stmt
cmpdcondition ::= condition | condition “&&” cmpdcondition | condition “||” cmpdcondition
condition ::= expression RELATION expression | “not” expression RELATION expression
RELATION ::= "<" | "<=" | “==" | ">=" | ">"
%%

yyerror(char *s)
{
  printf("%s\n", s);
}

extern FILE *yyin;

main(int argc, char **argv)
{
  if (argc > 1)
    yyin = fopen(argv[1], "r");
  if ( (argc > 2) && ( !strcmp(argv[2], "-d") ) )
    yydebug = 1;
  if ( !yyparse() )
    fprintf(stderr,"\t No errors!:) \n");
}
