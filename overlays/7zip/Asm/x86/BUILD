# x64 MASM optimized routines, assembled by ml64 via blade's 'as' rule.
# Currently just LzFindOpt.asm (provides GetMatchesSpecN_2, the multithread
# match-finder hot loop) -- the C LzFindOpt.c is an asm-only stub on x64.
# incs=['.'] so `include 7zAsm.asm` resolves.

cc_library(
    name = 'opt_asm',
    srcs = ['LzFindOpt.asm'],
    hdrs = [],
    incs = ['.'],
    visibility = ['PUBLIC'],
)
