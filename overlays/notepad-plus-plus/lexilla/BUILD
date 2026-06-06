# libLexilla: Scintilla's lexer library (static). Mirrors lexilla/src/lexilla.mak:
# src/Lexilla.cxx + lexlib/*.cxx + lexers/*.cxx, with include/ lexlib/ and
# scintilla/include on the header path.

cc_library(
    name = 'lexilla',
    srcs = glob([
        'src/Lexilla.cxx',
        'lexlib/*.cxx',
        'lexers/*.cxx',
    ]),
    hdrs = glob([
        'include/*.h',
        'lexlib/*.h',
    ]),
    incs = [
        'include',
        'lexlib',
        '../scintilla/include',
    ],
    visibility = ['PUBLIC'],
)
