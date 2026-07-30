$content = [System.IO.File]::ReadAllText("assets/index-ClG9q0mi.js")
[regex]::Matches($content, '"([^"\\]{15,300})"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -match '[a-zA-Z]{5,}' } | Select-Object -Unique | Set-Content -Path "extracted.txt" -Encoding UTF8
