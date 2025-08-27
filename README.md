# Emis Programming Language – Lexical Analyzer Project

## 📘 Overview

**Emis** is a custom-designed programming language developed for academic purposes, with a focus on lexical analysis using [JFlex](https://www.jflex.de). The language is tailored to support educational scripting, emphasizing clarity, simplicity, and extensibility. This project implements a complete lexical analyzer for Emis, capable of recognizing reserved keywords, identifiers, literals, operators, and structural symbols, while handling complex constructs such as nested comments and multiline strings.

---

## 🎯 Objectives

- Define the lexical structure of the Emis language
- Implement a lexer using JFlex that:
  - Recognizes and classifies tokens
  - Tracks line and column positions
  - Handles lexical errors gracefully
  - Supports stateful parsing for special constructs
- Provide a test suite and analysis report comparing expected vs. actual outputs

---

## 🧠 Language Specification

### 🔹 Reserved Keywords
- `inicio`, `fim`, `se`, `senao`, `enquanto`, `para`, `retorna`, `funcao`, `var`, `imprime`

### 🔹 Identifiers
- Case-sensitive
- Must begin with a letter or underscore
- May contain alphanumeric characters and underscores
- Maximum length: 32 characters

### 🔹 Numeric Literals
- **Integers:** decimal (`42`), hexadecimal (`0x2A`), binary (`0b101010`), octal (`0o52`)
- **Floats:** standard (`3.14`), scientific notation (`1.2e3`)

### 🔹 Strings
- Single-line: `'text'`, `"text"`
- Multiline: `"""text"""` with escape support (`\n`, `\t`, etc.)

### 🔹 Operators
| Type         | Symbols                         |
|--------------|----------------------------------|
| Arithmetic   | `+`, `-`, `*`, `/`, `%`          |
| Relational   | `==`, `!=`, `<`, `>`, `<=`, `>=` |
| Logical      | `&&`, `||`, `!`                  |
| Assignment   | `=`, `+=`, `-=`, `*=`, `/=`      |

### 🔹 Symbols
- Parentheses: `(`, `)`
- Braces: `{`, `}`
- Comma: `,`
- Semicolon: `;`

### 🔹 Comments
- Line: `// comment`
- Block: `/* comment */` with support for nested blocks

---

## ⚙️ Lexer Implementation (JFlex)

### 🔸 Features
- Token recognition with type, lexeme, line, and column
- Stateful parsing for:
  - Multiline strings (`""" ... """`)
  - Nested block comments (`/* ... /* ... */ ... */`)
- Error handling with descriptive messages
- Ignoring whitespace and formatting characters

### 🔸 Token Output Format
Each token is printed as:

<TOKEN_TYPE> '<LEXEME>' (LINE:COLUMN)

Example:

VAR 'var' (2:0) IDENT 'aluno' (2:4) NUM_INT '42' (2:12)

---
## 🧪 Testing

### 🔸 Test Suite
- `teste.emis`: contains valid and invalid Emis code
- Covers:
  - Reserved keywords
  - Identifiers and literals
  - Operators and symbols
  - Multiline strings and nested comments
  - Lexical errors

### 🔸 Execution

```bash
javac Token.java LexerEmis.java TesteLexer.java
java TesteLexer

🔸 Sample Input

inicio
var aluno = 42
funcao soma(a, b) {
    retorna a + b
}
"""Texto
multilinha
com escape \n"""
imprime "Resultado"
fim

🔸 Sample Output
INICIO 'inicio' (0:0)
VAR 'var' (1:0)
IDENT 'aluno' (1:4)
OP_ATRIB '=' (1:10)
NUM_INT '42' (1:12)
...

📚 Academic Context
This project was developed as part of a university-level course on compiler construction and formal language theory. It demonstrates practical application of lexical analysis principles using JFlex, and serves as a foundation for future parser and interpreter development.

🧩 File Structure

emis-programming-language/
├── LexerEmis.jflex       # JFlex specification file
├── LexerEmis.java        # Generated lexer
├── Token.java            # Token class definition
├── TesteLexer.java       # Lexer runner
├── teste.emis            # Sample input file
└── README.md             # Project documentation

📄 License
This project is intended for educational use and is distributed under an academic fair-use policy.