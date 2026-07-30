$jsFiles = Get-ChildItem -Path "assets" -Filter "*.js"
$images = @()

foreach ($f in $jsFiles) {
    $content = Get-Content $f.FullName -Raw
    $matches = [regex]::Matches($content, '["'']([^"''\s]+\.(?:webp|png|jpeg|jpg|svg))["'']', 'IgnoreCase')
    foreach ($m in $matches) {
        $img = $m.Groups[1].Value
        if (-not ($img.StartsWith("http"))) {
            $images += $img
        }
    }
}

$uniqueImages = $images | Select-Object -Unique
Write-Host "Encontradas $($uniqueImages.Count) imagens referenciadas:"

foreach ($img in $uniqueImages) {
    $cleanImg = $img.TrimStart('/')
    if ($cleanImg.StartsWith("@/")) {
        $cleanImg = $cleanImg.Substring(2)
    }
    
    $url = "https://arcalivros.vercel.app/" + $cleanImg
    $outPath = Join-Path (Get-Location) $cleanImg

    $dir = [System.IO.Path]::GetDirectoryName($outPath)
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    try {
        Invoke-WebRequest -Uri $url -OutFile $outPath -ErrorAction Stop
        Write-Host "Baixado: $cleanImg"
    } catch {
        Write-Host "Falha ao baixar $cleanImg : $_"
    }
}
