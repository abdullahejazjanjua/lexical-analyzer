%{
    /* Definition section */
   
%}

%%
    /* Rules section */
[a-zA-Z0-9]   { printf("valid\n"); }    

\n {return 0;}
%%
yywrap() {}

int main() 
{
    printf("Enter string: ");
    yylex(); 
}
