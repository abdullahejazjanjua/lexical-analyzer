%{
    /* Definition section */
   
%}

%%
    /* Rules section */
[a-zA-Z]+   { printf("valid"); }          
%%
yywrap() {}

int main() 
{
    printf("Enter string: ");
    yylex(); 
}
