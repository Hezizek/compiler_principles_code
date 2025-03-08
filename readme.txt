本目录下一个lex文件，一个yacc文件，一个C++语言文件

		lex.l
		yacc.y
		main.cc

利用bison命令,根据yacc.y文件，使用-L C++参数，生成C++语言文件（yacc.tab.cc），使用-d参数，生成头yacc.tab.hh。
在头文件yacc.tab.hh中包含各个token的常数定义，在lex生成的程序中需要引用为各个token定义的常数。
	
		bison  -d -L C++ -r all yacc.y
	
利用flex命令，根据lex文件，使用-+参数，生成C++语言文件，文件名为lex.yy.cc。
使用--header-file=lex.yy.hh参数，生成头lex.yy.hh。
	
		flex -+ --header-file=lex.yy.hh lex.l

利用g++命令，把yacc.tab.cc文件，lex.yy.cc文件和main.cc，编译链接生成a.out文件

		g++ lex.yy.cc  yacc.tab.cc  main.cc

运行a.out,观看一下执行结果
