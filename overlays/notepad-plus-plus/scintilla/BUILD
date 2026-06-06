# libScintilla (static): Scintilla core + Win32 platform layer.
# Mirrors scintilla/win32/scintilla.mak COMPONENT_OBJS + SRC_OBJS (the static
# lib variant, i.e. everything except ScintillaDLL.cxx which is for the DLL).
# Built with Boost.Regex PCRE support (SCI_OWNREGEX) instead of std::regex;
# the actual boost glue is //boostregex:boost_regex.

cc_library(
    name = 'scintilla',
    srcs = glob(
        ['src/*.cxx', 'win32/*.cxx'],
        exclude = ['win32/ScintillaDLL.cxx'],
    ),
    hdrs = glob(['include/*.h', 'src/*.h', 'win32/*.h']),
    incs = ['include', 'src'],
    defs = ['SCI_OWNREGEX', 'BOOST_REGEX_STANDALONE'],
    visibility = ['PUBLIC'],
)
