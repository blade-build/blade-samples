# 7zz.exe — the standalone 7-Zip console (Alone2 bundle). Console subsystem.
# Real sources live in //CPP:cpp_7zip and //C:lzma_c; main() is in
# 7zip/UI/Console/Main.cpp (pulled from the cpp_7zip lib by the CRT entry).
# Asm-optimized codecs are omitted (pure-C fallbacks used).

windows_resources(
    name = 'alone2_res',
    rc_files = ['resource.rc'],
)

cc_binary(
    name = '7zz',
    srcs = ['StdAfx.cpp'],
    defs = ['Z7_PROG_VARIANT_Z'],
    extra_linkflags = [
        '/SUBSYSTEM:CONSOLE',
        'oleaut32.lib', 'ole32.lib', 'user32.lib', 'advapi32.lib', 'shell32.lib',
    ],
    deps = [
        '//CPP:cpp_7zip',
        '//C:lzma_c',
        '//Asm/x86:opt_asm',  # GetMatchesSpecN_2 (ml64-assembled LzFindOpt.asm)
        ':alone2_res',
    ],
)
