$jsFiles = Get-ChildItem -Path "assets" -Filter "*.js"
$images = @()

foreach ($f in $jsFiles) {
    $content = Get-Content $f.FullName -Raw
    $matches = [regex]::Matches($content, '["'']([^"''\s]+\.(?:webp|png|jpeg|jpg|svg))["'']', 'IgnoreCase')
    foreach ($m in $matches) {
        $img = $m.Groups[1].Value
        $images += $img
    }
}

$uniqueImages = $images | Select-Object -Unique
Write-Host "AUDIT IMAGES REPORT"
Write-Host "Total images found: $($uniqueImages.Count)"

foreach ($img in $uniqueImages) {
    if ($img.StartsWith("http://") -or $img.StartsWith("https://")) {
        Write-Host "URL remota: $img"
        continue
    }
    
    $cleanImg = $img.TrimStart('/')
    if ($cleanImg.StartsWith("@/")) {
        $cleanImg = $cleanImg.Substring(2)
    }
    
    $localPath = Join-Path (Get-Location) $cleanImg
    $exists = Test-Path $localPath
    
    if (-not $exists) {
        Write-Host "MISSING: $cleanImg -> downloading from https://arcalivros.vercel.app/$cleanImg"
        $dir = [System.IO.Path]::GetDirectoryName($localPath)
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
        try {
            Invoke-WebRequest -Uri "https://arcalivros.vercel.app/$cleanImg" -OutFile $localPath -ErrorAction Stop
            Write-Host "-> DOWNLOADED: $cleanImg"
        } catch {
            Write-Host "-> ERROR downloading $cleanImg : $_"
        }
    } else {
        Write-Host "OK: $cleanImg"
    }
}
