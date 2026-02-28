$f = 'C:\Users\alves\OneDrive\Desktop\teste sistema claude\index.html'
$s = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
$s = $s.Replace("`r`n", "`n").Replace("`r", "`n")

$svgCheck = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>'
$svgMinus = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"/></svg>'

# Find the exact SMP pair in the toggleUserActive context and replace
# The context is: ?'[SMP_HIGH][SMP_LOW]':'[BMP]'}
# Use a MatchEvaluator to replace
$pattern = [regex]'(?\u2019[^?]*?\u2019[\uD800-\uDBFF][\uDC00-\uDFFF][\uFE0F]?)|[\uD800-\uDBFF][\uDC00-\uDFFF][\uFE0F]?'

# Simpler: just replace any remaining SMP surrogate pair (there's only 1 left)
# with the check SVG since it appears in the "active" branch
$result = [regex]::Replace($s, "[\uD800-\uDBFF][\uDC00-\uDFFF]", $svgCheck)

[System.IO.File]::WriteAllText($f, $result, [System.Text.UTF8Encoding]::new($false))
Write-Host 'Toggle emoji replaced!'
