# 7lzma: the standalone LZMA encode/decode console tool (C/Util/Lzma/LzmaUtil.c).
# Mirrors C/Util/Lzma/makefile (minus the optional asm decoder).

cc_binary(
    name = '7lzma',
    srcs = ['LzmaUtil.c'],
    incs = ['../..'],   # the LZMA SDK C headers live in C/
    deps = [
        '//C:lzma_c',
        '//C:7zfile',          # File_* used by LzmaUtil.c
        '//Asm/x86:opt_asm',   # GetMatchesSpecN_2 (LzFindMt in lzma_c references it)
    ],
)
