%%

%public
%class LexerEmis
%unicode
%line
%column
%type Token

%x STRING_MULTILINHA
%x COMENTARIO

%{
  StringBuilder stringBuffer;
  int nivelComentario = 0;
%}

%%

// Palavras reservadas
"inicio"     { return new Token("INICIO", yytext(), yyline, yycolumn); }
"fim"        { return new Token("FIM", yytext(), yyline, yycolumn); }
"se"         { return new Token("SE", yytext(), yyline, yycolumn); }
"senao"      { return new Token("SENAO", yytext(), yyline, yycolumn); }
"enquanto"   { return new Token("ENQUANTO", yytext(), yyline, yycolumn); }
"para"       { return new Token("PARA", yytext(), yyline, yycolumn); }
"retorna"    { return new Token("RETORNA", yytext(), yyline, yycolumn); }
"funcao"     { return new Token("FUNCAO", yytext(), yyline, yycolumn); }
"var"        { return new Token("VAR", yytext(), yyline, yycolumn); }
"imprime"    { return new Token("IMPRIME", yytext(), yyline, yycolumn); }

// Identificadores
[a-zA-Z_][a-zA-Z0-9_]{0,31}  { return new Token("IDENT", yytext(), yyline, yycolumn); }

// Literais numéricos
0x[0-9a-fA-F]+               { return new Token("NUM_HEX", yytext(), yyline, yycolumn); }
0b[01]+                      { return new Token("NUM_BIN", yytext(), yyline, yycolumn); }
0o[0-7]+                     { return new Token("NUM_OCT", yytext(), yyline, yycolumn); }
[0-9]+\.[0-9]+([eE][+-]?[0-9]+)? { return new Token("NUM_FLOAT", yytext(), yyline, yycolumn); }
[0-9]+                       { return new Token("NUM_INT", yytext(), yyline, yycolumn); }

// Strings simples
\"([^\"\\]|\\.)*\"           { return new Token("STRING", yytext(), yyline, yycolumn); }
\'([^\'\\]|\\.)*\'           { return new Token("STRING", yytext(), yyline, yycolumn); }

// Strings multilinha
\"\"\"                      { yybegin(STRING_MULTILINHA); stringBuffer = new StringBuilder(); }

<STRING_MULTILINHA>{
  \"\"\"                    { yybegin(YYINITIAL); return new Token("STRING_MULTILINHA", stringBuffer.toString(), yyline, yycolumn); }
  .|\n                     { stringBuffer.append(yytext()); }
}

// Operadores
"=="                        { return new Token("OP_IGUAL", yytext(), yyline, yycolumn); }
"!="                        { return new Token("OP_DIF", yytext(), yyline, yycolumn); }
"<="                        { return new Token("OP_MENOR_IGUAL", yytext(), yyline, yycolumn); }
">="                        { return new Token("OP_MAIOR_IGUAL", yytext(), yyline, yycolumn); }
"<"                         { return new Token("OP_MENOR", yytext(), yyline, yycolumn); }
">"                         { return new Token("OP_MAIOR", yytext(), yyline, yycolumn); }
"+"                         { return new Token("OP_SOMA", yytext(), yyline, yycolumn); }
"-"                         { return new Token("OP_SUB", yytext(), yyline, yycolumn); }
"*"                         { return new Token("OP_MULT", yytext(), yyline, yycolumn); }
"/"                         { return new Token("OP_DIV", yytext(), yyline, yycolumn); }
"="                         { return new Token("OP_ATRIB", yytext(), yyline, yycolumn); }
"("                         { return new Token("ABRE_PAREN", yytext(), yyline, yycolumn); }
")"                         { return new Token("FECHA_PAREN", yytext(), yyline, yycolumn); }
"{"                         { return new Token("ABRE_CHAVE", yytext(), yyline, yycolumn); }
"}"                         { return new Token("FECHA_CHAVE", yytext(), yyline, yycolumn); }
","                         { return new Token("VIRGULA", yytext(), yyline, yycolumn); }
";"                         { return new Token("PONTO_VIRGULA", yytext(), yyline, yycolumn); }

// Comentários
"//".*                      { /* ignora comentário de linha */ }
"/*"                        { yybegin(COMENTARIO); nivelComentario = 1; }

<COMENTARIO>{
  "/*"                     { nivelComentario++; }
  "*/"                     { nivelComentario--; if (nivelComentario == 0) yybegin(YYINITIAL); }
  .|\n                     { /* ignora conteúdo */ }
}

// Espaços e quebras de linha
[ \t\r]+                   { /* ignora espaços */ }
\n                         { /* ignora quebra de linha */ }

// Tratamento de erro léxico
.|\n   { System.err.println("Erro léxico na linha " + yyline + ", coluna " + yycolumn + ": '" + yytext() + "'"); }