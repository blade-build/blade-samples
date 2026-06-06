<#
.SYNOPSIS
  Regression: build real third-party projects with blade by overlaying our
  BUILD/BLADE_ROOT files onto a pinned upstream checkout.

.DESCRIPTION
  For each sample in samples.json:
    1. Clone (or reuse) the upstream repo under work/<name> and hard-checkout
       the pinned SHA, restored to a pristine tree.
    2. Run any prebuild commands (e.g. generate a version header).
    3. Copy overlays/<name>/* over the checkout.
    4. Run `blade build <targets> -p <profile>`.
  We never re-host upstream source -- only our overlay files live in this repo.

.PARAMETER BladeSrc
  Path to blade's `src` dir (invoked as `python <BladeSrc> build ...`).
  Defaults to a sibling clone: ..\blade-build\blade-build\src.

.PARAMETER BuildProfile
  Build profile (release|debug). Default: release.

.PARAMETER Only
  Optional sample name to build just one (e.g. -Only putty).
#>
[CmdletBinding()]
param(
  [string]$BladeSrc = (Join-Path $PSScriptRoot '..\..\blade-build\blade-build\src'),
  [string]$BuildProfile = 'release',
  [string]$Only = ''
)

$ErrorActionPreference = 'Stop'
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$work = Join-Path $repoRoot 'work'
New-Item -ItemType Directory -Force $work | Out-Null
$blade = (Resolve-Path $BladeSrc).Path
$manifest = Get-Content (Join-Path $repoRoot 'samples.json') -Raw | ConvertFrom-Json

$results = @()
foreach ($s in $manifest.samples) {
  if ($Only -and $s.name -ne $Only) { continue }
  Write-Host "`n===== $($s.name) @ $($s.sha.Substring(0,12)) =====" -ForegroundColor Cyan
  $dir = Join-Path $work $s.name

  # 1. pristine checkout at the pinned SHA
  if (-not (Test-Path (Join-Path $dir '.git'))) {
    git clone --quiet $s.repo $dir
  }
  git -C $dir fetch --quiet origin $s.sha 2>$null
  git -C $dir -c advice.detachedHead=false checkout --quiet --force $s.sha
  git -C $dir reset --hard --quiet $s.sha
  git -C $dir clean -fdq

  # 2. prebuild (generated prerequisites)
  foreach ($cmd in $s.prebuild) {
    Write-Host "  prebuild: $cmd"
    Push-Location $dir; try { cmd /c $cmd | Out-Null } finally { Pop-Location }
  }

  # 3. overlay our BUILD/BLADE_ROOT files
  $ov = Join-Path $repoRoot "overlays\$($s.name)"
  Copy-Item -Recurse -Force (Join-Path $ov '*') $dir

  # 4. build
  Push-Location $dir
  try {
    $targets = $s.targets -join ' '
    Write-Host "  blade build $targets -p $BuildProfile"
    & python $blade build @($s.targets) -p $BuildProfile 2>&1 | Tee-Object -Variable out | Out-Null
    $ok = ($out -match 'Build success').Count -gt 0 -and $LASTEXITCODE -eq 0
  } finally { Pop-Location }

  $results += [pscustomobject]@{ Sample = $s.name; Result = ($ok ? 'PASS' : 'FAIL') }
  if (-not $ok) { ($out | Select-Object -Last 8) | ForEach-Object { Write-Host "    $_" } }
}

Write-Host "`n===== summary =====" -ForegroundColor Cyan
$results | ForEach-Object { Write-Host ("  {0,-20} {1}" -f $_.Sample, $_.Result) }
if ($results.Result -contains 'FAIL') { exit 1 }
