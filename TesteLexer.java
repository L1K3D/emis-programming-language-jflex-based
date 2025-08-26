import java.io.*;

public class TesteLexer {
    public static void main(String[] args) throws IOException {
        FileReader reader = new FileReader("teste.emis");
        LexerEmis lexer = new LexerEmis(reader);
        Token token;

        while ((token = lexer.yylex()) != null) {
            System.out.println(token);
        }
    }
}