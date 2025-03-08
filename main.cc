#include<iostream>
#include"lex.yy.hh"
#include"yacc.tab.hh"

yyFlexLexer lexer;

void yy::parser::error(const std::string& msg)
{

}
int yyFlexLexer::yywrap()
{
	return 0;
}
int main()
{
	yy::parser p;
	p.parse();
	return 0;
}

