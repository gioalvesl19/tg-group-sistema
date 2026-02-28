$f = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$s = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
$s = $s.Replace("`r`n", "`n").Replace("`r", "`n")

$closeChar = [string][char]0x2715
$checkChar = [string][char]0x2705
$svgTrash  = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>'
$svgCircle = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="8"/></svg>'

# ── 1. U+2715 in deleteTag red button → SVG trash ───────────────────────────
# Context: style="color:var(--red);">[CLOSE]</button>
$s = $s.Replace('style="color:var(--red);">' + $closeChar + '</button>',
  'style="color:var(--red);">' + $svgTrash + '</button>')

# Any remaining close char in btn-icon context
$s = [regex]::Replace($s,
  '(class="btn-icon"[^>]*>)' + [regex]::Escape($closeChar) + '(</button>)',
  '$1' + $svgTrash + '$2')

# ── 2. U+2705 in toggleUserActive false branch → SVG circle (activate) ───────
# Context: ...SVG_CHECK...':[CHECK]'}
# Replace the check char in the inactive (false) branch
$s = $s.Replace("':'" + $checkChar + "'}", "':'" + $svgCircle + "'}")

# ── 3. Verify form focus fixes were applied ──────────────────────────────────
# Stage-input focus (from fix_remaining.ps1)
if ($s -match 'stage-input:focus.*rgba\(201,146') {
  $s = [regex]::Replace($s,
    '(\.stage-input:focus \{ border-color: )rgba\(201,146,26,\.45\)',
    '$1rgba(255,255,255,0.20)')
}

# ── 4. Write ─────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($f, $s, [System.Text.UTF8Encoding]::new($false))
Write-Host 'Final emoji cleanup done!'
