import re
import os

dir = "examples/"

ifilename = input("Enter filename: ")
extention = ifilename.split(".")

if extention[1] != "cpp":
    raise RuntimeError("Filename must be cpp")

input_path = os.path.join(dir, f"{ifilename}")

with open(input_path, "r") as f:
    text = f.read()


def parse(code, output_file):
    keywords = [
        "int", "float", "char", "double", "void", "bool", "short", "long", "signed", "unsigned", "string",
        "if", "else", "while", "for", "do", "switch", "case", "break", "continue", "return", "goto",
        "cout", "cin", "using", "namespace", "include", "sizeof", "struct", "class", "public", "private",
        "protected", "virtual", "static", "const", "new", "delete", "this", "try", "catch", "throw",
        "true", "false", "default", "typedef", "template", "inline", "friend", "extern", "enum",
        "register", "operator", "mutable", "volatile", "nullptr", "main", "and", "or", "not",
        "std"
    ]

    regexes = [
        ('single_line_comment', r"//.*"),
        ('multi_line_comment', r"/\*[\s\S]*?\*/"),
        ('string', r"\"(\\.|[^\"\\])*\""),
        ('char_literal', r"'(\\.|[^'\\])'"),
        ('operator', r"""(
            \+\+ | -- | -> | \+= | -= | \*= | /= | %= | &= | \|= | \^= | <<= | >>= | == | != | <= | >= |
            && | \|\| | << | >> | ~ | ! | \+ | - | \* | / | % | & | \| | \^ | = | < | > | \? | : | \.\* | \.
        )"""),
        ('identifier', r"[A-Za-z_][A-Za-z0-9_]*"),
        ('number', r"\d+(\.\d*)?"),
        ('separator', r"[{}();,\[\]]"),
        ('newline', r'\n')
    ]

    exp = '|'.join('(?P<%s>%s)' % pair for pair in regexes)

    line = 0
    with open(output_file, 'w') as out:
        for mo in re.finditer(exp, code):
            kind = mo.lastgroup
            value = mo.group()
            if kind == "identifier" and value in keywords:
                kind = "Keyword"
            elif kind == "number":
                if '.' in value:
                    kind = "float"
                    value = float(value)
                else:
                    kind = "integer"
                    value = int(value)
            if kind == "single_line_comment" or kind == "multi_line_comment":
                continue

            if kind == 'newline':
                line += 1
                continue

            out.write(f"Line: {line}, Token: {value} ----> {kind}\n")

output_filename = f"outputs/output_tokens_{extention[0]}.txt"
parse(text, output_filename)
print(f"Tokenized output written to {output_filename}")
