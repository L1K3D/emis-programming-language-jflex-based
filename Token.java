public class Token {
    String tipo;
    String lexema;
    int linha;
    int coluna;

    public Token(String tipo, String lexema, int linha, int coluna) {
        this.tipo = tipo;
        this.lexema = lexema;
        this.linha = linha;
        this.coluna = coluna;
    }

    @Override
    public String toString() {
        return tipo + " '" + lexema + "' (" + linha + ":" + coluna + ")";
    }
}