%{
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<iostream>
#include"lex.yy.hh"

extern yyFlexLexer lexer;
#define	yylex(x) (lexer.yylex())

class tree_node
{
public:
	virtual std::string compile()=0;

	std::string temp_variable_name;
	tree_node()
	{
		static int temp_variable_id=0;
		char buf[20];
		std::sprintf(buf,"temp_%d",temp_variable_id++);
		temp_variable_name=std::string(buf);
	}
};

%}

%union{
	class tree_node *t_node;
}

%type <t_node> expr star

%start star

%left	'+' '-' 
%left	'*' '/'
%left	'(' ')'

%token	TOKEN_CONST TOKEN_ID


%%

star	:	expr	';'
		{
			std::cout<<$1->compile()<<std::endl;
			delete $1;
			return 0;
		}
	;
expr	:	expr	'+'	expr
		{
			class add_tree_node:public tree_node
			{
			private:
				tree_node *left,*right;
			public:
				virtual std::string compile()
				{
					return left->compile()+right->compile()+"+\t"+left->temp_variable_name+"\t"+right->temp_variable_name+"\t"+this->temp_variable_name+"\n";
				}
				add_tree_node(tree_node *my_left,tree_node *my_right)
				{
					left=my_left;
					right=my_right;
				}
				~add_tree_node()
				{
					delete left;
					delete right;
				}
			};
			$$=new add_tree_node($1,$3);
		}	
	|	expr	'-'	expr
		{
			class sub_tree_node:public tree_node
			{
			private:
				tree_node *left,*right;
			public:
				virtual std::string compile()
				{
					return left->compile()+right->compile()+"-\t"+left->temp_variable_name+"\t"+right->temp_variable_name+"\t"+this->temp_variable_name+"\n";
				}
				sub_tree_node(tree_node *my_left,tree_node *my_right)
				{
					left=my_left;
					right=my_right;
				}
				~sub_tree_node()
				{
					delete left;
					delete right;
				}
			};
			$$=new sub_tree_node($1,$3);
		}	
	|	expr	'*'	expr
		{
			class mul_tree_node:public tree_node
			{
			private:
				tree_node *left,*right;
			public:
				virtual std::string compile()
				{
					return left->compile()+right->compile()+"*\t"+left->temp_variable_name+"\t"+right->temp_variable_name+"\t"+this->temp_variable_name+"\n";
				}
				mul_tree_node(tree_node *my_left,tree_node *my_right)
				{
					left=my_left;
					right=my_right;
				}
				~mul_tree_node()
				{
					delete left;
					delete right;
				}
			};
			$$=new mul_tree_node($1,$3);
		}	
	|	expr	'/'	expr
		{
			class div_tree_node:public tree_node
			{
			private:
				tree_node *left,*right;
			public:
				virtual std::string compile()
				{
					return left->compile()+right->compile()+"/\t"+left->temp_variable_name+"\t"+right->temp_variable_name+"\t"+this->temp_variable_name+"\n";
				}
				div_tree_node(tree_node *my_left,tree_node *my_right)
				{
					left=my_left;
					right=my_right;
				}
				~div_tree_node()
				{
					delete left;
					delete right;
				}
			};
			$$=new div_tree_node($1,$3);
		}	
	|	'('	expr	')'
		{
			$$=$2;
		}	
	|	TOKEN_CONST
		{
			class const_tree_node:public tree_node
			{
			public:
				virtual std::string compile()
				{
					return "";
				}
				const_tree_node(std::string my_value)
				{
					temp_variable_name=my_value;
				}
			};
			$$=new const_tree_node(lexer.YYText());
		}
	|	TOKEN_ID
		{
			class id_tree_node:public tree_node
			{
			public:
				virtual std::string compile()
				{
					return "";
				}
				id_tree_node(std::string my_name)
				{
					temp_variable_name=my_name;
				}
			};
			$$=new id_tree_node(lexer.YYText());
		}
	;
%%

