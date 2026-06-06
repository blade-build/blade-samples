# Notepad++'s Boost.Regex glue for Scintilla (header-only boost, in ./boost).
# Mirrors boostregex/nppSpecifics.mak: adds BoostRegExSearch + UTF8DocumentIterator
# to Scintilla with -DSCI_OWNREGEX -DBOOST_REGEX_STANDALONE, boost on the include
# path, and _SILENCE_ALL_CXX17_DEPRECATION_WARNINGS for the boost headers.

cc_library(
    name = 'boost_regex',
    srcs = [
        'BoostRegExSearch.cxx',
        'UTF8DocumentIterator.cxx',
    ],
    # Only the local glue headers are "ours"; boost/ is 3rd-party on the include
    # path (do NOT declare it as hdrs -- boost's internal headers like
    # abi_suffix.hpp #error if included standalone, which the HDRS check does).
    hdrs = glob(['*.h']),
    incs = [
        '.',                      # for boost/...
        '../scintilla/include',
        '../scintilla/src',
    ],
    defs = [
        'SCI_OWNREGEX',
        'BOOST_REGEX_STANDALONE',
        '_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS',
    ],
    deps = ['//scintilla:scintilla'],
    visibility = ['PUBLIC'],
)
