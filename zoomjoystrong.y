%{
/*
*
*Logan Jaglowski
*March 16, 2020
*CIS 343
*
*This file contains the grammar for the parsing process. It checks to make sure
*users are inputting tokens in the correct order.
*
*/
	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* msg);

	int yylex();
%}

/*
*Declaring tokens in the program, as well as the token types
*/
%union {int i; float f;}
%start zoomjoystrong

%token END_STATEMENT
%token END
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

/*
* Defines what statements are allowed for the language, this is the grammar itself.
*/
zoomjoystrong:          drawing end_program;
drawing:                shape
		|	shape drawing 
;

shape:		draw_line
		|		draw_point
		|		draw_circle
		|		draw_rectangle
		|               set_the_color
		|		end_program
;

draw_line:		LINE INT INT INT INT END_STATEMENT            	{check_line($2, $3, $4, $5);};

draw_circle:		CIRCLE INT INT INT END_STATEMENT    		{check_circle($2, $3, $4);};

draw_point:		POINT INT INT END_STATEMENT       		{check_point($2, $3);};

draw_rectangle:		RECTANGLE INT INT INT INT END_STATEMENT		{check_rectangle($2, $3, $4, $5);};

set_the_color:          SET_COLOR INT INT INT END_STATEMENT             {check_color($2, $3, $4);};

end_program:            END                                             {finish(); return 0;};

%%


/*
* The program is set up, parses the user's inputs, and finishes with this main method
*
* @param argc is the number of arguments passed
* @param argv are the arguments being passed
* @returns the status of the method
*/
int main(int argc, char** argv){
	setup();
	yyparse();
	return 0;
}

/*
* The program checks to see whether a circle is valid or not based off of user input
*
* @param x is the x value at which the center of the circle exists
* @param y is the y value at which the center of the circle exists
* @param r is the radius of the circle
* @returns the status of the method
*/
int check_circle(int x, int y, int r) {
	if (x - r >= 0 && x + r <= WIDTH && y - r >= 0 && y + r <= HEIGHT) {
		circle(x, y, r);
	} else {
		yyerror("Out of bounds circle.\n");
	}
}

/*
* The program checks to see whether a point is valid or not based off of user input
*
* @param x is the x value at which the point exists
* @param y is the y value at which the point exists
* @returns the status of the method
*/
int check_point(int x, int y) {
	if (x >= 0 && x <= WIDTH && y >= 0 && y <= HEIGHT) {
		point(x, y);
	} else {
		yyerror("Out of bounds point.\n");
	}
}

/*
* The program checks to see whether a rectangle is valid or not based off of user input
*
* @param x is the x value at which the start of the rectangle exists
* @param y is the y value at which the start of the rectangle exists
* @param w is the width of the rectangle
* @param h is the height of the triangle
* @returns the status of the method
*/
int check_rectangle(int x, int y, int w, int h) {
	if (x >= 0 && x <= WIDTH && y >= 0 && y <= HEIGHT
		&& x + w <= WIDTH && x + w >= 0 && y + h <= HEIGHT
			&& y + h >= 0) {
		rectangle(x, y, w, h);
	} else {
		yyerror("Out of bounds rectangle.\n");
	}
}

/*
* The program checks to see whether a circle is valid or not based off of user input
*
* @param x is the x value at which the starting point exists
* @param y is the y value at which the starting point exists
* @param u is the x value at which the ending point exists
* @param v is the y value at which the ending point exists
* @returns the status of the method
*/
int check_line(int x, int y, int u, int v) {
	if (x >= 0 && x <= WIDTH && y >= 0 && y <= HEIGHT
		&& u <= WIDTH && u >= 0 &&  v <= HEIGHT
			&& v >= 0) {
		line(x, y, u, v);
	} else {
		yyerror("Out of bounds line.\n");
	}
}

/*
* The program checks to see whether a circle is valid or not based off of user input
*
* @param r is the value for how much red exists in the color
* @param g is the value for how much green exists in the color
* @param b is the value for how much blue exists in the color
* @returns the status of the method
*/
int check_color(int r, int g, int b) {
	if (r >= 0 && r <= 255 && g >= 0 && g <= 255
		 && b >= 0 && b <= 255) {
		set_color(r, g, b);
	} else {
		yyerror("Invalid color.\n");
	}
}

/*
* The program displays error messages to the user
*
* @param msg is the message going to be displayed to the user
* @returns the status of the method
*/
int yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
	return 0;
}



