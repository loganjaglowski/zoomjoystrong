%{
/*
*
*Logan Jaglowski
*March 16, 2020
*CIS 343
*
*This file the lexer of the language. It accepts and denies user input based on the rules below.
*
*/
	#include <stdlib.h>
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
	
	void yyerror(char *);
%}

%option noyywrap

%%
;			{return END_STATEMENT;}
point			{return POINT;}
line			{return LINE;}
circle			{return CIRCLE;}
rectangle		{return RECTANGLE;}
set_color               {return SET_COLOR;}
\-?[0-9]+               {yylval.i = atoi(yytext); return INT;}
\-?[0-9]*[.][0-9]+$     {yylval.f = atof(yytext); return FLOAT;}
<<EOF>>                 {return END;}
(end|End)               {return END;}
[ \t\s\n\r]	;
.			{yyerror("invalid character. not recognized by lexer.");}
%%

