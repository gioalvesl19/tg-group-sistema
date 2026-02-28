# apply_fierce_glass.ps1 — Fierce/Web3 Translucent Glass Design System
$path = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$src = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
$src = $src.Replace("`r`n", "`n").Replace("`r", "`n")
function n([string]$s) { return $s.Replace("`r`n", "`n").Replace("`r", "`n") }

# ─────────────────────────────────────────────────────────────────────────────
# 1. Replace :root — new Fierce glass tokens
# ─────────────────────────────────────────────────────────────────────────────
$newRoot = n(@'
:root {
  --sidebar-w: 260px; --topbar-h: 60px;
  --bg: #0F1115; --bg-secondary: #16181D;
  --bg-glass: rgba(28,30,36,0.55); --bg-glass-strong: rgba(28,30,36,0.72);
  --card: rgba(30,32,40,0.55);
  --border: rgba(255,255,255,0.08); --border-subtle: rgba(255,255,255,0.06);
  --text: rgba(255,255,255,0.92); --text-2: rgba(255,255,255,0.60); --text-3: rgba(255,255,255,0.40);
  --sidebar-bg: rgba(20,22,28,0.75); --sidebar-border: rgba(255,255,255,0.05);
  --sidebar-text: rgba(255,255,255,0.45); --sidebar-active-bg: rgba(255,255,255,0.08);
  --primary: #c9921a; --primary-dark: #a07012; --primary-light: #e8c347;
  --accent-purple: #7C3AED; --accent-pink: #EC4899; --accent-blue: #3B82F6; --accent-cyan: #06B6D4;
  --blue: #3B82F6; --amber: #e8b84a; --red: #e84a6b;
  --green: #22C55E; --purple: #7C3AED; --teal: #06B6D4;
  --blur-sm: 8px; --blur-md: 16px; --blur-lg: 24px; --blur-xl: 40px;
  --shadow-sm: 0 4px 12px rgba(0,0,0,0.35);
  --shadow: 0 10px 30px rgba(0,0,0,0.45);
  --shadow-lg: 0 20px 60px rgba(0,0,0,0.60);
  --radius: 16px; --radius-sm: 8px;
}
'@)

$src = [regex]::Replace($src, '(?s):root\s*\{[^}]+\}', $newRoot)

# ─────────────────────────────────────────────────────────────────────────────
# 2. Body — 3-layer background (dark base + purple glow + cyan glow)
# ─────────────────────────────────────────────────────────────────────────────
$src = [regex]::Replace($src,
  "body \{ font-family: '[^']+', sans-serif; background: [^;]+; color: var\(--text\); font-size: 14px; line-height: 1\.5; \}",
  "body { font-family: 'Inter', 'DM Sans', sans-serif; background: radial-gradient(circle at 80% 8%, rgba(124,58,237,0.14) 0%, transparent 50%), radial-gradient(circle at 15% 88%, rgba(6,182,212,0.09) 0%, transparent 45%), #0F1115; color: var(--text); font-size: 14px; line-height: 1.5; }")

# ─────────────────────────────────────────────────────────────────────────────
# 3. .card — Glass Level 2
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.card { background: rgba(28,27,33,.78); backdrop-filter: blur(28px); -webkit-backdrop-filter: blur(28px); border-radius: var(--radius); padding: 20px; border: 1px solid rgba(255,255,255,.09); box-shadow: var(--shadow), inset 0 1px 0 rgba(255,255,255,.06); }',
  '.card { background: rgba(30,32,40,0.55); backdrop-filter: blur(20px) saturate(140%); -webkit-backdrop-filter: blur(20px) saturate(140%); border-radius: var(--radius); padding: 20px; border: 1px solid rgba(255,255,255,0.08); box-shadow: 0 10px 30px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.06); }')

# ─────────────────────────────────────────────────────────────────────────────
# 4. .kpi-card — Glass Level 2
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.kpi-card { background: rgba(28,27,33,.78); backdrop-filter: blur(28px); -webkit-backdrop-filter: blur(28px); border-radius: var(--radius); padding: 18px; border: 1px solid rgba(255,255,255,.09); box-shadow: var(--shadow), inset 0 1px 0 rgba(255,255,255,.06); transition: all .2s; }',
  '.kpi-card { background: rgba(30,32,40,0.55); backdrop-filter: blur(20px) saturate(140%); -webkit-backdrop-filter: blur(20px) saturate(140%); border-radius: var(--radius); padding: 18px; border: 1px solid rgba(255,255,255,0.08); box-shadow: 0 10px 30px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.06); transition: all .2s; }')

$src = $src.Replace(
  '.kpi-card:hover { box-shadow: var(--shadow-lg), inset 0 1px 0 rgba(255,255,255,.1); transform: translateY(-2px); border-color: rgba(201,146,26,.25); }',
  '.kpi-card:hover { background: rgba(40,42,50,0.65); backdrop-filter: blur(24px) saturate(160%); -webkit-backdrop-filter: blur(24px) saturate(160%); box-shadow: 0 20px 60px rgba(0,0,0,0.60), inset 0 1px 0 rgba(255,255,255,0.10); transform: translateY(-2px); border-color: rgba(124,58,237,0.30); }')

# ─────────────────────────────────────────────────────────────────────────────
# 5. .modal — Glass elevated (blur-xl)
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.modal { background: rgba(20,19,25,.88); backdrop-filter: blur(28px); -webkit-backdrop-filter: blur(28px); border-radius: 16px; width: 100%; max-width: 680px; max-height: 92vh; display: flex; flex-direction: column; box-shadow: 0 20px 60px rgba(0,0,0,.5); border: 1px solid rgba(255,255,255,.1); }',
  '.modal { background: rgba(20,22,28,0.88); backdrop-filter: blur(40px) saturate(160%); -webkit-backdrop-filter: blur(40px) saturate(160%); border-radius: 20px; width: 100%; max-width: 680px; max-height: 92vh; display: flex; flex-direction: column; box-shadow: 0 20px 60px rgba(0,0,0,0.60); border: 1px solid rgba(255,255,255,0.10); }')

# ─────────────────────────────────────────────────────────────────────────────
# 6. .drawer — Glass elevated (blur-xl)
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.drawer { position: fixed; right: 0; top: 0; height: 100vh; width: 440px; background: rgba(20,19,25,.88); backdrop-filter: blur(28px); -webkit-backdrop-filter: blur(28px); z-index: 901; box-shadow: -8px 0 40px rgba(0,0,0,.4); border-left: 1px solid rgba(255,255,255,.09); display: flex; flex-direction: column; }',
  '.drawer { position: fixed; right: 0; top: 0; height: 100vh; width: 440px; background: rgba(20,22,28,0.88); backdrop-filter: blur(40px) saturate(160%); -webkit-backdrop-filter: blur(40px) saturate(160%); z-index: 901; box-shadow: -8px 0 40px rgba(0,0,0,0.50); border-left: 1px solid rgba(255,255,255,0.08); display: flex; flex-direction: column; }')

# ─────────────────────────────────────────────────────────────────────────────
# 7. #topbar — Glass Level 1
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '#topbar { background: rgba(17,16,19,.75); backdrop-filter: blur(24px); -webkit-backdrop-filter: blur(24px); border-bottom: 1px solid rgba(255,255,255,.07); padding: 0 24px; height: var(--topbar-h); display: flex; align-items: center; gap: 12px; position: sticky; top: 0; z-index: 50; }',
  '#topbar { background: rgba(15,17,21,0.82); backdrop-filter: blur(20px) saturate(140%); -webkit-backdrop-filter: blur(20px) saturate(140%); border-bottom: 1px solid rgba(255,255,255,0.06); padding: 0 24px; height: var(--topbar-h); display: flex; align-items: center; gap: 12px; position: sticky; top: 0; z-index: 50; }')

# ─────────────────────────────────────────────────────────────────────────────
# 8. .kanban-card — Glass Level 2
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.kanban-card { background: rgba(28,27,33,.82); backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px); border-radius: 9px; padding: 12px; margin-bottom: 7px; border: 1px solid rgba(255,255,255,.08); cursor: grab; transition: all .15s; box-shadow: var(--shadow-sm); }',
  '.kanban-card { background: rgba(30,32,40,0.60); backdrop-filter: blur(16px) saturate(140%); -webkit-backdrop-filter: blur(16px) saturate(140%); border-radius: 12px; padding: 12px; margin-bottom: 7px; border: 1px solid rgba(255,255,255,0.07); cursor: grab; transition: all .15s; box-shadow: 0 4px 12px rgba(0,0,0,0.35); }')

# ─────────────────────────────────────────────────────────────────────────────
# 9. .toast — Glass Level 3
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.toast { background: rgba(30,28,36,.9); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); color: var(--text); padding: 12px 18px; border-radius: var(--radius-sm); font-size: 13px; font-weight: 500; box-shadow: var(--shadow-lg); animation: slideIn .3s ease; max-width: 320px; border: 1px solid rgba(255,255,255,.12); }',
  '.toast { background: rgba(28,30,36,0.90); backdrop-filter: blur(20px) saturate(140%); -webkit-backdrop-filter: blur(20px) saturate(140%); color: var(--text); padding: 12px 18px; border-radius: var(--radius-sm); font-size: 13px; font-weight: 500; box-shadow: 0 10px 30px rgba(0,0,0,0.45); animation: slideIn .3s ease; max-width: 320px; border: 1px solid rgba(255,255,255,0.10); }')

# ─────────────────────────────────────────────────────────────────────────────
# 10. #sidebar — Glass Level 1
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '#sidebar { width: var(--sidebar-w); background: rgba(13,12,17,.88); backdrop-filter: blur(24px); -webkit-backdrop-filter: blur(24px); position: fixed; top: 0; left: 0; height: 100vh; display: flex; flex-direction: column; z-index: 100; overflow-y: auto; border-right: 1px solid rgba(255,255,255,.06); }',
  '#sidebar { width: var(--sidebar-w); background: rgba(20,22,28,0.75); backdrop-filter: blur(20px) saturate(140%); -webkit-backdrop-filter: blur(20px) saturate(140%); position: fixed; top: 0; left: 0; height: 100vh; display: flex; flex-direction: column; z-index: 100; overflow-y: auto; border-right: 1px solid rgba(255,255,255,0.05); }')

# ─────────────────────────────────────────────────────────────────────────────
# 11. Login glows — Purple + Cyan (Fierce neon style)
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '.login-bg-glow-1 { width: 540px; height: 540px; background: radial-gradient(circle, rgba(201,146,26,.2) 0%, transparent 70%); top: 35%; left: 35%; transform: translate(-50%,-50%); }',
  '.login-bg-glow-1 { width: 620px; height: 620px; background: radial-gradient(circle, rgba(124,58,237,0.24) 0%, transparent 65%); top: 38%; left: 42%; transform: translate(-50%,-50%); }')

$src = $src.Replace(
  '.login-bg-glow-2 { width: 320px; height: 320px; background: radial-gradient(circle, rgba(74,144,232,.1) 0%, transparent 70%); bottom: 10%; right: 12%; }',
  '.login-bg-glow-2 { width: 400px; height: 400px; background: radial-gradient(circle, rgba(6,182,212,0.16) 0%, transparent 60%); bottom: 8%; right: 6%; }')

# ─────────────────────────────────────────────────────────────────────────────
# 12. Login screen background — deeper purple-dark for Fierce feel
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  '#loginScreen { position: fixed; inset: 0; background: radial-gradient(ellipse at 38% 62%, #1e1828 0%, #0d0b12 45%, #070610 100%); z-index: 9999; display: flex; align-items: center; justify-content: center; overflow: hidden; }',
  '#loginScreen { position: fixed; inset: 0; background: radial-gradient(ellipse at 40% 55%, #130f1e 0%, #0a0810 50%, #060509 100%); z-index: 9999; display: flex; align-items: center; justify-content: center; overflow: hidden; }')

# ─────────────────────────────────────────────────────────────────────────────
# 13. Google Fonts — add Inter
# ─────────────────────────────────────────────────────────────────────────────
$src = $src.Replace(
  'https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap',
  'https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap')

# ─────────────────────────────────────────────────────────────────────────────
# 14. Inject .glass + .glass-strong utility classes + accent gradient
# ─────────────────────────────────────────────────────────────────────────────
$glassUtils = n(@'
/* ── Fierce Glass Utilities ── */
.glass {
  background: rgba(30,32,40,0.55);
  backdrop-filter: blur(20px) saturate(140%);
  -webkit-backdrop-filter: blur(20px) saturate(140%);
  border: 1px solid rgba(255,255,255,0.08);
  box-shadow: 0 10px 30px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.06);
  border-radius: 16px;
}
.glass-strong {
  background: rgba(28,30,36,0.72);
  backdrop-filter: blur(24px) saturate(160%);
  -webkit-backdrop-filter: blur(24px) saturate(160%);
  border: 1px solid rgba(255,255,255,0.10);
  box-shadow: 0 20px 60px rgba(0,0,0,0.60), inset 0 1px 0 rgba(255,255,255,0.08);
  border-radius: 16px;
}
.accent-gradient {
  background: linear-gradient(90deg, #7C3AED, #EC4899, #3B82F6, #06B6D4);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.accent-glow { box-shadow: 0 0 24px rgba(124,58,237,0.35), 0 0 48px rgba(6,182,212,0.15); }
'@)

$src = [regex]::Replace($src, '(</style>)', $glassUtils + '$1')

# ─────────────────────────────────────────────────────────────────────────────
# 15. Write UTF-8 no BOM
# ─────────────────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($path, $src, [System.Text.UTF8Encoding]::new($false))
Write-Host "OK - Fierce Glass Design System applied!"
