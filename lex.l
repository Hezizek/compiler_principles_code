%{

#include<iostream>
#include"yacc.tab.hh"

%}

%%


"("			return '(';
")"			return ')';
";"			return ';';
"+"			return '+';
"-"			return '-';
"*"			return '*';
"/"			return '/';


[0-9]+			return yy::parser::token::TOKEN_CONST;
[0-9]+\.[0-9]*		return yy::parser::token::TOKEN_CONST;

[a-zA-Z]+[0-9a-zA-Z]*	return yy::parser::token::TOKEN_ID;


[ \r\n\t]		{;}

.			{std::cout<<"find unkown char "<<YYText()<<std::endl;}

%%

