%{
    #include <stdio.h>
    #include <string.h>
    int line = 1;
    char filename[100];
    char ofilename[100]; 
     FILE *inputfile, *outputfile;


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

^#include[ \t]*<[^>]+>     { fprintf(outputfile, "Line %d: %s \t ---> Header\n", line, yytext); }
^#include[ \t]*\"[^\"]+\"  { fprintf(outputfile, "Line %d: %s \t ---> Header\n", line, yytext); }

^#define[ ]* { fprintf(outputfile,"Line %d: %s \t ---> Pre-process Directives\n", line, yytext); }


int|float|char|double|void|bool|short|long|signed|unsigned|string { fprintf(outputfile,"Line %d: %s \t ---> Type\n", line, yytext); }


if|else|while|for|do|switch|case|break|continue|return|goto|cout|cin|using|namespace|include|sizeof|struct|class|public|private|protected|virtual|static|const|new|delete|this|try|catch|throw|true|false|default|typedef|template|inline|friend|extern|enum|register|operator|mutable|volatile|nullptr|main|and|or|not { fprintf(outputfile,"Line %d: %s \t ---> Keyword\n", line, yytext); }


"++"|"--"|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"<<="|">>="|"&&"|"||" { fprintf(outputfile,"Line %d: %s \t ---> Compound Operator\n", line, yytext); }


"<<"|">>"|"<="|">="|"+"|"-"|"*"|"/"|"="|"<"|">"|"=="|"!="|"%"|"!"|"&"|"|"|"^"|"~" { fprintf(outputfile,"Line %d: %s \t ---> Operator\n", line, yytext); }



[{}();,\[\]]  { fprintf(outputfile,"Line %d: %s \t ---> Separator\n", line, yytext); }

[0-9]+\.[0-9]+ { fprintf(outputfile,"Line %d: %s \t ---> Float\n", line, yytext); }

[0-9]+      { fprintf(outputfile,"Line %d: %s \t ---> Integer\n", line, yytext); }

'(\\.|[^\\'])' { fprintf(outputfile,"Line %d: %s \t ---> Char Literal\n", line, yytext); }

\".*\" { fprintf(outputfile,"Line %d: %s \t ---> String Literal\n", line, yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { fprintf(outputfile,"Line %d: %s \t ---> Identifier\n", line, yytext); }

\n          { line++; }
[ \t]+      {  }
.           { }

%%

yywrap() {}

int main()
{
    printf("Enter cpp file name: ");
    scanf("%99s", filename);

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

    strcpy(ofilename, filename);
    char *dot = strrchr(ofilename, '.'); // returns a pointer to the end of last occurence of '.'
    *dot = '\0';
    strcat(ofilename, "_tokens.txt");

    inputfile = fopen(filename, "r");
    outputfile = fopen(ofilename, "w");
    if (!inputfile || !outputfile)
    {
        printf("Could not open file\n");
        return 1;
    }



    yyin = inputfile;
    yylex();
    fclose(inputfile);
    fclose(outputfile);
}
