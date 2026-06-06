# LZMA SDK C core (the C objects needed by 7zz; asm versions omitted).

cc_library(
    name = 'lzma_c',
    srcs = [
        '7zBuf2.c',
        '7zCrc.c',
        '7zStream.c',
        'Aes.c',
        # C (intrinsics) versions of the asm-optimized routines — the
        # USE_C_AES / USE_C_SHA path, so no external assembler (ml64) is needed.
        'AesOpt.c',
        'Sha1Opt.c',
        'Sha256Opt.c',
        'Alloc.c',
        'Bcj2.c',
        'Bcj2Enc.c',
        'Blake2s.c',
        'Bra.c',
        'Bra86.c',
        'BraIA64.c',
        'BwtSort.c',
        'CpuArch.c',
        'Delta.c',
        'DllSecur.c',
        'HuffEnc.c',
        'LzFind.c',
        'LzFindMt.c',
        'Lzma2Dec.c',
        'Lzma2DecMt.c',
        'Lzma2Enc.c',
        'LzmaDec.c',
        'LzmaEnc.c',
        'Md5.c',
        'MtCoder.c',
        'MtDec.c',
        'Ppmd7.c',
        'Ppmd7Dec.c',
        'Ppmd7Enc.c',
        'Ppmd7aDec.c',
        'Ppmd8.c',
        'Ppmd8Dec.c',
        'Ppmd8Enc.c',
        'Sha1.c',
        'Sha256.c',
        'Sha3.c',
        'Sha512.c',
        'Sha512Opt.c',
        'Sort.c',
        'SwapBytes.c',
        'Threads.c',
        'Xxh64.c',
        'Xz.c',
        'XzCrc64.c',
        'XzDec.c',
        'XzEnc.c',
        'XzIn.c',
        'ZstdDec.c',
    ],
    hdrs = glob(['*.h']),
    incs = ['.'],
    # Force the pure-C CRC path (default selects CrcUpdateT12 from 7zCrcOpt.asm,
    # which we don't build); =1 uses the C single-table CrcUpdateGT1.
    defs = ['Z7_CRC_NUM_TABLES=1', 'Z7_CRC64_NUM_TABLES=1'],
    # Force all objects in: the codecs have intra-lib refs resolved only by a
    # later object (e.g. LzFindMt -> GetMatchesSpecN_2 in LzFindOpt) that
    # on-demand .lib pulling misses, plus the same self-registration pattern.
    link_all_symbols = True,
    visibility = ['PUBLIC'],
)

# 7zFile.c -- the C SDK's file I/O helpers (File_*, FileSeqInStream /
# FileOutStream vtables). Not part of the codec, so kept out of lzma_c; tools
# like 7lzma that do file I/O via the C API depend on it.
cc_library(
    name = '7zfile',
    srcs = ['7zFile.c'],
    hdrs = [],
    incs = ['.'],
    visibility = ['PUBLIC'],
)
