# 7zFM.exe -- the 7-Zip GUI file manager (Bundles/Fm). Win32 GUI subsystem.
# C++ in //CPP:cpp_7zfm, C codecs in //C:lzma_c, asm in //Asm/x86:opt_asm.

windows_resources(
    name = 'fm_res',
    rc_files = ['resource.rc'],
)

cc_binary(
    name = '7zFM',
    srcs = ['StdAfx.cpp'],
    extra_linkflags = [
        '/SUBSYSTEM:WINDOWS',
        'oleaut32.lib', 'ole32.lib', 'user32.lib', 'advapi32.lib',
        'shell32.lib', 'gdi32.lib', 'comdlg32.lib', 'comctl32.lib',
        'uxtheme.lib', 'htmlhelp.lib', 'gdiplus.lib', 'mpr.lib',
    ],
    deps = [
        '//CPP:cpp_7zfm',
        '//C:lzma_c',
        '//Asm/x86:opt_asm',
        ':fm_res',
    ],
)
