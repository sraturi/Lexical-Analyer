%{
#include <iostream>
#include <cstdlib>
using namespace std;
#define SINGLE_CHARACTER    2
#define INTEGER             3
#define HEX_INTEGER         4
#define STRING              5
#define T_ID                6
#define WHITESPACE          7
%}

%%
  /*
    Pattern definitions for all tokens 
  */
('[^\\']')|('\\(n|t|r|v|f|a|b|\\|\'|\")')	{return SINGLE_CHARACTER;}
[0-9]+ 		            {return INTEGER;}
0(x|X)[a-fA-F0-9]+    {return HEX_INTEGER;}
\"(([^\\\n"]*)|((\\[bnrtvfab\\'\"])*))*\" {return STRING;}
[a-zA-Z\_][a-zA-Z\_0-9]*                  {return T_ID; }
[\t\r\a\v\b\n\ ]+                         {return WHITESPACE; }
.                                         {cerr<< 1; return -1;}
%%

int main () {
  int token;
  string lexeme;
  string tokenList [10] = {"","","SINGLE_CHARACTER","INTEGER","HEX_INTEGER","STRING","T_ID","WHITESPACE"};
  while ((token = yylex())) {
    if (token > 0) {
      lexeme.assign(yytext);

      	string x = "\n";
      for(int i =0; i<lexeme.length();i++){
      	if(lexeme[i]=='\n'){
      	lexeme.replace(i,x.length(),"\\n");
      	}
      }



	cout << tokenList[token]<< " "<< lexeme<< endl;
    }else {
      if (token < 0) {
		exit(EXIT_FAILURE);
      }
    }
  }
  exit(EXIT_SUCCESS);
}
