# apply_neutral_premium.ps1
# Fix: Remove purple/blue/gold tints -> neutral gray glass
# Fix: Replace all emoji icons with clean SVG icons
# Improve: Premium clean neutral aesthetic

$path = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$src = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
$src = $src.Replace("`r`n", "`n").Replace("`r", "`n")
function n([string]$s) { return $s.Replace("`r`n", "`n").Replace("`r", "`n") }

# ─────────────────────────────────────────────────────────────────────────────
# SVG ICON DEFINITIONS (clean Feather-style, 13px)
# ─────────────────────────────────────────────────────────────────────────────
$svgTrash  = '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>'
$svgEdit   = '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>'
$svgClose  = '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>'
$svgGear   = '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.66a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>'
$svgWarn   = '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>'
$svgSearch = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>'
$svgDrag   = '<svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor" opacity=".45"><circle cx="9" cy="5" r="1.5"/><circle cx="9" cy="12" r="1.5"/><circle cx="9" cy="19" r="1.5"/><circle cx="15" cy="5" r="1.5"/><circle cx="15" cy="12" r="1.5"/><circle cx="15" cy="19" r="1.5"/></svg>'

# ─────────────────────────────────────────────────────────────────────────────
# 1. EMOJI REPLACEMENTS — SMP surrogates (edit, delete, search)
# ─────────────────────────────────────────────────────────────────────────────
# Edit button (surrogate pair with title="Editar")
$src = [regex]::Replace($src,
  '(title="Editar">)[\uD800-\uDBFF][\uDC00-\uDFFF][\uFE0F\u200D]*(</button>)',
  '$1' + $svgEdit + '$2')

# Delete buttons (surrogate pair with onclick="delete...")
$src = [regex]::Replace($src,
  '(onclick="[^"]*[Dd]elete[^"]*"[^>]*>)[\uD800-\uDBFF][\uDC00-\uDFFF][\uFE0F\u200D]*(</button>)',
  '$1' + $svgTrash + '$2')

# Search placeholder (surrogate pair + " Buscar...")
$src = [regex]::Replace($src,
  '[\uD800-\uDBFF][\uDC00-\uDFFF][\uFE0F]? Buscar\.\.\.',
  'Buscar...')

# ─────────────────────────────────────────────────────────────────────────────
# 2. EMOJI REPLACEMENTS — BMP symbols
# ─────────────────────────────────────────────────────────────────────────────
$closeChar  = [char]0x2715  # ✕ close
$gearChar   = [char]0x2699  # ⚙ gear
$warnChar   = [char]0x26A0  # ⚠ warning
$pencilChar = [char]0x270F  # ✏ pencil
$arrowChar  = [char]0x2192  # → right arrow
$feChar     = [char]0xFE0F  # variation selector

# Close buttons: class="btn-icon">✕</button>
$src = $src.Replace('class="btn-icon">' + $closeChar + '</button>',
  'class="btn-icon">' + $svgClose + '</button>')

# Also with variation selector
$src = $src.Replace('class="btn-icon">' + $closeChar + $feChar + '</button>',
  'class="btn-icon">' + $svgClose + '</button>')

# Gear in "Colunas" button
$src = $src.Replace($gearChar + ' Colunas', $svgGear + ' Colunas')
$src = $src.Replace($gearChar + $feChar + ' Colunas', $svgGear + ' Colunas')

# Warning in warn-box
$src = $src.Replace('class="warn-box">' + $warnChar,
  'class="warn-box">' + $svgWarn)
$src = $src.Replace('class="warn-box">' + $warnChar + $feChar,
  'class="warn-box">' + $svgWarn)
# Also inside innerHTML template strings
$src = $src.Replace('">' + $warnChar + $feChar + ' Requer', '">' + $svgWarn + ' Requer')
$src = $src.Replace('">' + $warnChar + ' Requer', '">' + $svgWarn + ' Requer')

# Drag handle in stage-input (cursor:grab context)
$src = $src.Replace('cursor:grab;font-size:16px;">' + $gearChar,
  'cursor:grab;font-size:16px;">' + $svgDrag)
$src = $src.Replace('cursor:grab;font-size:16px;">' + $pencilChar,
  'cursor:grab;font-size:16px;">' + $svgDrag)

# Remaining BMP pencil (if any edit icon fallback)
$src = $src.Replace('title="Editar">' + $pencilChar + $feChar + '</button>',
  'title="Editar">' + $svgEdit + '</button>')
$src = $src.Replace('title="Editar">' + $pencilChar + '</button>',
  'title="Editar">' + $svgEdit + '</button>')

# Arrow → in CRM history / misc
$src = $src.Replace($arrowChar, '&rarr;')

# Clean up any remaining FE0F variation selectors
$src = $src.Replace([char]0xFE0F, '')

# ─────────────────────────────────────────────────────────────────────────────
# 3. BODY BACKGROUND — Pure neutral dark, no colored glow
# ─────────────────────────────────────────────────────────────────────────────
$src = [regex]::Replace($src,
  "body \{ font-family: '[^']+', sans-serif; background: [^;]+; color: var\(--text\); font-size: 14px; line-height: 1\.5; \}",
  "body { font-family: 'Inter', 'DM Sans', sans-serif; background: radial-gradient(ellipse at 60% 0%, rgba(255,255,255,0.028) 0%, transparent 55%), #0C0C10; color: var(--text); font-size: 14px; line-height: 1.5; }")

# ─────────────────────────────────────────────────────────────────────────────
# 4. LOGIN SCREEN — Remove purple dark, neutral background
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '#loginScreen { position: fixed; inset: 0; background: radial-gradient(ellipse at 40% 55%, #130f1e 0%, #0a0810 50%, #060509 100%); z-index: 9999; display: flex; align-items: center; justify-content: center; overflow: hidden; }',
  '#loginScreen { position: fixed; inset: 0; background: #0A0A0E; z-index: 9999; display: flex; align-items: center; justify-content: center; overflow: hidden; }')

# Login glow-1 → very subtle neutral ambient at center
$src = $src.Replace(
  '.login-bg-glow-1 { width: 620px; height: 620px; background: radial-gradient(circle, rgba(124,58,237,0.24) 0%, transparent 65%); top: 38%; left: 42%; transform: translate(-50%,-50%); }',
  '.login-bg-glow-1 { width: 800px; height: 800px; background: radial-gradient(circle, rgba(255,255,255,0.025) 0%, transparent 60%); top: 50%; left: 50%; transform: translate(-50%,-50%); }')

# Login glow-2 → hide
$src = $src.Replace(
  '.login-bg-glow-2 { width: 400px; height: 400px; background: radial-gradient(circle, rgba(6,182,212,0.16) 0%, transparent 60%); bottom: 8%; right: 6%; }',
  '.login-bg-glow-2 { display: none; }')

# ─────────────────────────────────────────────────────────────────────────────
# 5. GLASS SURFACES — Neutral dark gray (remove blue tint)
#    rgba(36,38,46) has B=46>>R=36 → distinctly blue-tinted
#    New: rgba(34,34,40) has B=40, R=G=34 → nearly neutral
# ─────────────────────────────────────────────────────────────────────────────
# Global replace of blue-tinted rgba → neutral gray
$src = $src.Replace('rgba(36,38,46,0.55)', 'rgba(34,34,40,0.70)')
$src = $src.Replace('rgba(36,38,46,0.60)', 'rgba(34,34,40,0.74)')
$src = $src.Replace('rgba(36,38,46,0.75)', 'rgba(26,26,32,0.90)')
$src = $src.Replace('rgba(36,38,46,0.90)', 'rgba(26,26,32,0.94)')

# Sidebar + topbar → very dark neutral (nearly black)
$src = $src.Replace('rgba(22,24,29,0.85)', 'rgba(16,16,20,0.96)')

# ─────────────────────────────────────────────────────────────────────────────
# 6. Update :root tokens to match new neutral values
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '--bg-glass: rgba(36,38,46,0.55); --bg-glass-strong: rgba(36,38,46,0.75);',
  '--bg-glass: rgba(34,34,40,0.70); --bg-glass-strong: rgba(26,26,32,0.90);')
$src = $src.Replace(
  '--bg-sidebar: rgba(22,24,29,0.85);',
  '--bg-sidebar: rgba(16,16,20,0.96);')
$src = $src.Replace(
  '--sidebar-bg: rgba(22,24,29,0.85); --sidebar-border: rgba(255,255,255,0.05);',
  '--sidebar-bg: rgba(16,16,20,0.96); --sidebar-border: rgba(255,255,255,0.06);')
$src = $src.Replace(
  '--card: rgba(36,38,46,0.55);',
  '--card: rgba(34,34,40,0.70);')
$src = $src.Replace(
  '--bg: #0F1115; --bg-primary: #0F1115;',
  '--bg: #0C0C10; --bg-primary: #0C0C10;')

# ─────────────────────────────────────────────────────────────────────────────
# 7. BADGE-PURPLE — Remove purple, use neutral subtle
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.badge-purple { background: rgba(191,148,255,.15); color: #bf94ff; }',
  '.badge-purple { background: rgba(255,255,255,.07); color: rgba(255,255,255,.72); }')

# ─────────────────────────────────────────────────────────────────────────────
# 8. FORM INPUT FOCUS — Remove gold border, use neutral white
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.form-input:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(201,146,26,.2); }',
  '.form-input:focus, .form-select:focus { border-color: rgba(255,255,255,0.25); box-shadow: 0 0 0 3px rgba(255,255,255,0.05); }')

# Login pill input focus — remove gold
$src = $src.Replace(
  'border-color: rgba(201,146,26,.55); box-shadow: 0 0 0 3px rgba(201,146,26,.2)',
  'border-color: rgba(255,255,255,0.30); box-shadow: 0 0 0 3px rgba(255,255,255,0.06)')

# ─────────────────────────────────────────────────────────────────────────────
# 9. BTN-ICON improvements — better sizing and hover for SVG icons
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.btn-icon { background: none; border: none; cursor: pointer; padding: 6px; border-radius: var(--radius-sm); color: var(--text-2); transition: all .15s; display:inline-flex;align-items:center;justify-content:center; }',
  '.btn-icon { background: none; border: none; cursor: pointer; padding: 7px; border-radius: 8px; color: var(--text-2); transition: all .15s; display:inline-flex;align-items:center;justify-content:center; line-height:1; }')

# ─────────────────────────────────────────────────────────────────────────────
# 10. SEARCH INPUT ICON — add SVG before topbar search input
# ─────────────────────────────────────────────────────────────────────────────
# Update the topbar search input placeholder to not show icon
$src = $src.Replace(
  'placeholder="Buscar..." id="globalSearch"',
  'placeholder="Buscar..." id="globalSearch" autocomplete="off"')

# ─────────────────────────────────────────────────────────────────────────────
# 11. GLASS UTILITY CLASSES — update to neutral
# ─────────────────────────────────────────────────────────────────────────────
$nl = [char]10
$src = $src.Replace(".glass {${nl}  background: rgba(36,38,46,0.55);",
  ".glass {${nl}  background: rgba(34,34,40,0.70);")
$src = $src.Replace(".glass-strong {${nl}  background: rgba(36,38,46,0.75);",
  ".glass-strong {${nl}  background: rgba(26,26,32,0.90);")

# ─────────────────────────────────────────────────────────────────────────────
# 12. PREMIUM TYPOGRAPHY REFINEMENTS
# ─────────────────────────────────────────────────────────────────────────────
# Sidebar section labels → cleaner (already using text-3 variable)
# Topbar title → ensure font-weight uses Inter

# Update sidebar section headers to be more subtle and spaced
$src = $src.Replace(
  '.sidebar-section { font-size: 10px; font-weight: 700; color: var(--text-3); letter-spacing: 1.2px; text-transform: uppercase; padding: 20px 18px 8px; }',
  '.sidebar-section { font-size: 9.5px; font-weight: 600; color: var(--text-3); letter-spacing: 1.5px; text-transform: uppercase; padding: 22px 18px 8px; opacity: 0.7; }')

# ─────────────────────────────────────────────────────────────────────────────
# 13. TOPBAR SEARCH INPUT — clean neutral glass
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '#searchInput, .search-input { background: rgba(255,255,255,.06); border: 1px solid rgba(255,255,255,.08); border-radius: 8px; padding: 7px 12px; color: var(--text); font-size: 13px; width: 200px; font-family: inherit; outline: none; }',
  '#searchInput, .search-input { background: rgba(255,255,255,.04); border: 1px solid rgba(255,255,255,.06); border-radius: 10px; padding: 7px 12px 7px 34px; color: var(--text); font-size: 13px; width: 200px; font-family: inherit; outline: none; transition: all .2s; }')

# ─────────────────────────────────────────────────────────────────────────────
# 14. WRITE — UTF-8 no BOM
# ─────────────────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($path, $src, [System.Text.UTF8Encoding]::new($false))
Write-Host "OK - Neutral premium applied + emojis replaced!"
