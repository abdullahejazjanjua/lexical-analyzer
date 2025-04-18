# C++ Lexical Analyzer

A robust lexical analyzer built with Flex for tokenizing and analyzing C++ source code.

## Overview

This lexical analyzer scans C++ source files and identifies various language elements like keywords, operators, identifiers, and literals. It creates a detailed token list that can be used for syntax analysis, code inspection, or educational purposes.

## Features

- **Complete C++ Syntax Support**:
  - Processes standard C++ constructs and syntax elements
  - Handles modern C++ keywords and operators
  - Recognizes all primitive types and complex declarations

- **Comprehensive Token Classification**:
  - Keywords, identifiers, and types
  - Operators (arithmetic, logical, bitwise, compound)
  - Literals (integer, floating-point, character, string)
  - Separators and special symbols
  - Preprocessor directives

- **Comment Handling**:
  - Single-line comments (`//`)
  - Multi-line comments (`/* */`) with proper line counting

- **Detailed Token Tracking**:
  - Line number for each token
  - Token value
  - Token classification

## Usage

1. Compile the lexical analyzer:
   ```
   flex filename.l
   gcc lex.yy.c -o output
   ```

2. Run the analyzer:
   ```
   ./output
   ```

3. When prompted, enter the name of your C++ file (must have `.cpp` extension)

4. The analyzer will create an output file with the same name as your input file, but with a `_tokens.txt` suffix
