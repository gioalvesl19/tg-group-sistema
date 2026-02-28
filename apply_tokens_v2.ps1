# apply_tokens_v2.ps1 — Design tokens v2 (refined rgba + full token set)
$path = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$src = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
$src = $src.Replace("`r`n", "`n").Replace("`r", "`n")
function n([string]$s) { return $s.Replace("`r`n", "`n").Replace("`r", "`n") }
$nl = [char]10

# ─────────────────────────────────────────────────────────────────────────────
# 1. :root — complete refined token set
# ─────────────────────────────────────────────────────────────────────────────
$newRoot = n(@'
:root {
  --sidebar-w: 260px; --topbar-h: 60px;
  /* ── Backgrounds ── */
  --bg: #0F1115; --bg-primary: #0F1115; --bg-secondary: #16181D;
  --bg-glass: rgba(36,38,46,0.55); --bg-glass-strong: rgba(36,38,46,0.75);
  --bg-sidebar: rgba(22,24,29,0.85);
  --card: rgba(36,38,46,0.55);
  /* ── Borders ── */
  --border: rgba(255,255,255,0.08); --border-primary: rgba(255,255,255,0.08);
  --border-secondary: rgba(255,255,255,0.05); --border-subtle: rgba(255,255,255,0.05);
  /* ── Text ── */
  --text: rgba(255,255,255,0.92); --text-primary: rgba(255,255,255,0.92);
  --text-2: rgba(255,255,255,0.65); --text-secondary: rgba(255,255,255,0.65);
  --text-3: rgba(255,255,255,0.40); --text-muted: rgba(255,255,255,0.40);
  /* ── Sidebar ── */
  --sidebar-bg: rgba(22,24,29,0.85); --sidebar-border: rgba(255,255,255,0.05);
  --sidebar-text: rgba(255,255,255,0.45); --sidebar-active-bg: rgba(255,255,255,0.08);
  /* ── Brand (TG GROUP gold) ── */
  --primary: #c9921a; --primary-dark: #a07012; --primary-light: #e8c347;
  /* ── Accent palette ── */
  --accent-purple: #7C3AED; --accent-pink: #EC4899; --accent-blue: #3B82F6; --accent-cyan: #06B6D4;
  /* ── Status ── */
  --success: #22C55E; --success-soft: rgba(34,197,94,0.15);
  --blue: #3B82F6; --amber: #e8b84a; --red: #e84a6b;
  --green: #22C55E; --purple: #7C3AED; --teal: #06B6D4;
  /* ── Buttons ── */
  --button-glass: rgba(255,255,255,0.08); --button-glass-hover: rgba(255,255,255,0.12);
  --button-accent: #7C3AED;
  /* ── Chart ── */
  --chart-grid: rgba(255,255,255,0.06);
  /* ── Glow ── */
  --glow-purple: rgba(124,58,237,0.25); --glow-blue: rgba(59,130,246,0.25);
  /* ── Gray scale ── */
  --gray-900: #0F1115; --gray-800: #16181D; --gray-700: #1E2028;
  --gray-600: #2A2D36; --gray-500: #3A3D46; --gray-400: #6B7280; --gray-300: #9CA3AF;
  /* ── Blur tokens ── */
  --blur-sm: 8px; --blur-md: 16px; --blur-lg: 24px; --blur-xl: 40px;
  /* ── Shadows ── */
  --shadow-sm: 0 4px 12px rgba(0,0,0,0.35);
  --shadow: 0 10px 30px rgba(0,0,0,0.45);
  --shadow-lg: 0 20px 60px rgba(0,0,0,0.60);
  /* ── Radius ── */
  --radius: 16px; --radius-sm: 8px;
}
'@)

$src = [regex]::Replace($src, '(?s):root\s*\{[^}]+\}', $newRoot)

# ─────────────────────────────────────────────────────────────────────────────
# 2. Components → update rgba to new --bg-glass / --bg-glass-strong / --bg-sidebar
# ─────────────────────────────────────────────────────────────────────────────

# .card  (30,32,40 → 36,38,46)
$src = $src.Replace(
  '.card { background: rgba(30,32,40,0.55);',
  '.card { background: rgba(36,38,46,0.55);')

# .kpi-card  (30,32,40 → 36,38,46)
$src = $src.Replace(
  '.kpi-card { background: rgba(30,32,40,0.55);',
  '.kpi-card { background: rgba(36,38,46,0.55);')

# .kpi-card:hover  → glass-strong (36,38,46,0.75)
$src = $src.Replace(
  '.kpi-card:hover { background: rgba(40,42,50,0.65);',
  '.kpi-card:hover { background: rgba(36,38,46,0.75);')

# .modal  → glass-strong (36,38,46,0.75)
$src = $src.Replace(
  '.modal { background: rgba(20,22,28,0.88);',
  '.modal { background: rgba(36,38,46,0.75);')

# .drawer  → glass-strong (36,38,46,0.75)
$src = $src.Replace(
  'background: rgba(20,22,28,0.88); backdrop-filter: blur(40px)',
  'background: rgba(36,38,46,0.75); backdrop-filter: blur(40px)')

# #topbar  → bg-sidebar (22,24,29,0.85)
$src = $src.Replace(
  '#topbar { background: rgba(15,17,21,0.82);',
  '#topbar { background: rgba(22,24,29,0.85);')

# .kanban-card  (30,32,40 → 36,38,46)
$src = $src.Replace(
  '.kanban-card { background: rgba(30,32,40,0.60);',
  '.kanban-card { background: rgba(36,38,46,0.60);')

# .toast  (28,30,36 → 36,38,46)
$src = $src.Replace(
  '.toast { background: rgba(28,30,36,0.90);',
  '.toast { background: rgba(36,38,46,0.90);')

# #sidebar  → bg-sidebar (22,24,29,0.85)
$src = $src.Replace(
  '#sidebar { width: var(--sidebar-w); background: rgba(20,22,28,0.75);',
  '#sidebar { width: var(--sidebar-w); background: rgba(22,24,29,0.85);')

# ─────────────────────────────────────────────────────────────────────────────
# 3. Update .glass / .glass-strong utility classes
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  ".glass {${nl}  background: rgba(30,32,40,0.55);",
  ".glass {${nl}  background: rgba(36,38,46,0.55);")

$src = $src.Replace(
  ".glass-strong {${nl}  background: rgba(28,30,36,0.72);",
  ".glass-strong {${nl}  background: rgba(36,38,46,0.75);")

# ─────────────────────────────────────────────────────────────────────────────
# 4. Write UTF-8 no BOM
# ─────────────────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($path, $src, [System.Text.UTF8Encoding]::new($false))
Write-Host "OK - Design tokens v2 applied!"
