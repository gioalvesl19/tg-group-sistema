$f = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$s = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
$s = $s.Replace("`r`n", "`n").Replace("`r", "`n")

$svgCheck = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>'
$svgMinus = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"/></svg>'

# ── 1. Fix toggleUserActive button emoji → check/minus SVG ──────────────────
# Pattern: ${u.active?'[SMP]':'[BMP]'}</button>
$s = [regex]::Replace($s,
  "(>)\`$\{u\.active\?')[\uD800-\uDBFF][\uDC00-\uDFFF](':[^']*')\}(</button>)",
  ('$1${u.active?''' + "'" + $svgCheck + "'" + ':' + "'" + $svgMinus + "'" + '}$3'))

# Fallback: replace any remaining SMP in button context
$s = [regex]::Replace($s,
  "('\?')[\uD800-\uDBFF][\uDC00-\uDFFF](':')",
  ("'" + $svgCheck + "'" + "':'"))

# ── 2. Fix login-pill-input focus — actual box-shadow value is .12 not .2 ───
$s = $s.Replace(
  '.login-pill-input:focus { background: rgba(255,255,255,.13); border-color: rgba(201,146,26,.55); box-shadow: 0 0 0 3px rgba(201,146,26,.12); }',
  '.login-pill-input:focus { background: rgba(255,255,255,.13); border-color: rgba(255,255,255,0.28); box-shadow: 0 0 0 3px rgba(255,255,255,0.06); }')

# ── 3. Fix stage-input focus — remove gold ───────────────────────────────────
$s = $s.Replace(
  '.stage-input:focus { border-color: rgba(201,146,26,.45); background: var(--card); }',
  '.stage-input:focus { border-color: rgba(255,255,255,0.20); background: var(--card); }')

# ── 4. Final BMP cleanup — any remaining U+26A0 U+270F U+2699 in HTML ────────
$gearChar   = [string][char]0x2699
$warnChar   = [string][char]0x26A0
$pencilChar = [string][char]0x270F

# Remove any isolated BMP symbols left in HTML (not inside SVG viewBox etc.)
# Only target them when inside simple button/span/div HTML tags
$s = [regex]::Replace($s, '(?<=class="[^"]*btn[^"]*">)' + [regex]::Escape($gearChar) + '(?=</)', ' ')
$s = [regex]::Replace($s, '(?<=<span[^>]+>)' + [regex]::Escape($gearChar) + '(?=</span>)', ' ')

# ── 5. Write ─────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($f, $s, [System.Text.UTF8Encoding]::new($false))
Write-Host 'Remaining fixes applied!'
