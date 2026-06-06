# blade-samples

[![regress](https://github.com/blade-build/blade-samples/actions/workflows/regress.yml/badge.svg)](https://github.com/blade-build/blade-samples/actions/workflows/regress.yml)

Regression samples that build **real third-party C/C++ projects with
[blade](https://github.com/blade-build/blade-build)** on Windows (MSVC) — used
to catch regressions in blade's MSVC toolchain, `gen_rule`, DLL export handling,
etc. against non-trivial real-world code.

## We do **not** re-host upstream source

Each sample pins an upstream repository at a specific commit. The regression
script clones that commit and **overlays** our `BUILD` / `BLADE_ROOT` files (kept
under [`overlays/`](overlays/)) on top — nothing from the upstream projects is
copied into this repo. So there are no third-party-license redistribution
obligations here; only our own build files live in this tree.

| sample | upstream | license | what it exercises |
|---|---|---|---|
| putty   | [github/putty](https://github.com/github/putty) | MIT | C, `gen_rule` (runs `licence.pl`), Win32 console + GUI |
| 7zip    | [ip7z/7zip](https://github.com/ip7z/7zip) | LGPL + BSD + unRAR | C + C++ + MASM (`.asm`), shared-lib split, `link_all_symbols`, codec self-registration |
| notepad-plus-plus | [notepad-plus-plus/notepad-plus-plus](https://github.com/notepad-plus-plus/notepad-plus-plus) | GPLv3 | large C++ GUI, `windows_resources`, embedded manifest, Scintilla/Lexilla/Boost.Regex |

The pinned commits live in [`samples.json`](samples.json); bump a `sha` to track
a newer upstream.

## Run

```powershell
# all samples (release), using a sibling blade-build clone for `python <src> build`
pwsh scripts/regress.ps1

# one sample, debug profile, explicit blade src
pwsh scripts/regress.ps1 -Only 7zip -BuildProfile debug -BladeSrc C:\path\to\blade-build\src
```

The script, per sample: hard-checks-out the pinned SHA into `work/<name>`, runs
any `prebuild` (e.g. a version-header generator), overlays our build files, then
runs `blade build <targets>`.

### Prerequisites

- A `blade-build` checkout (default: a sibling `..\blade-build\blade-build\src`).
- MSVC build tools + Windows SDK (blade's `msvc_config` auto-detects them).
- `git`, Python 3, and a `python` on `PATH`.
- **putty** additionally needs **`perl` on `PATH`** (its `gen_rule` runs `licence.pl`).
