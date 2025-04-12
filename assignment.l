%{
    #include <stdio.h>
    char filename[100];
    int line = 1;
%}

%%


"//".*      {}

"/*"        {  
           
              int c;
              while((c = input()) != 0) {
                if(c == '\n') line++;
                if(c == '*' && (c = input()) == '/') break;
                if(c == 0) break;
              }
            }

^#include[ ]*<[a-zA-Z]+> { printf("Line %d: %s \t ---> Header\n", line, yytext); }
^#define[ ]*<[a-zA-Z]+> { printf("Line %d: %s \t ---> Pre-process Directives\n", line, yytext); }
^"using namespace"[ a-zA-Z]+  { printf("Line %d: %s \t ---> namespace\n", line, yytext); }


int|float|char|double|void|bool { printf("Line %d: %s \t ---> Type\n", line, yytext); }
if|else|while|for|return { printf("Line %d: %s \t ---> Keyword\n", line, yytext); }

"+"|"-"|"*"|"/"|"="|"<"|">"|"=="|"<="|">=" { printf("Line %d: %s \t ---> Operator\n", line, yytext); }

[{}();,\[\]]  { printf("Line %d: %s \t ---> Separator\n", line, yytext); }

[0-9]+\.[0-9]+ { printf("Line %d: %s \t ---> Float\n", line, yytext); }
[0-9]+      { printf("Line %d: %s \t ---> Integer\n", line, yytext); }

'(\\.|[^\\'])' { printf("Line %d: %s \t ---> Char Literal\n", line, yytext); }
\".*\" { printf("Line %d: %s \t ---> String Literal\n", line, yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("Line %d: %s \t ---> Identifier\n", line, yytext); }

\n          { line++; }
[ \t]+      {  }
.           { }

%%

yywrap() {}

int main()
{
    printf("Enter cpp file name: ");
    scanf("%s", filename);

    for (int i = 0; i < 100; i++)
    {
        if (filename[i] == '.')
        {
            if (filename[i + 1] == 'c' && filename[i + 2] == 'p' && filename[i + 3] == 'p')
            {
                
            }
            else
            {
                printf("file extention must be .cpp\n");
                return 1;
            }
        }
    }

    FILE *file;
    file = fopen(filename, "r");
    if (!file)
    {
        printf("Could not open file\n");
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);
}