$srcDir = "C:\Users\Andrea Cheres\.gemini\antigravity\brain\d03e62ee-d0f1-4a6b-9aa8-c1a59591e690\.user_uploaded"
$dstDir = "entregaveis-png"

if (-not (Test-Path $dstDir)) {
    New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
}

Copy-Item "$srcDir\media__1785371826214.png" "$dstDir\alfabeto-biblico.png" -Force
Copy-Item "$srcDir\media__1785371826256.png" "$dstDir\atividade-abc-biblica.png" -Force
Copy-Item "$srcDir\media__1785371826300.png" "$dstDir\aventuras-biblicas.png" -Force
Copy-Item "$srcDir\media__1785371826306.png" "$dstDir\colorindo-com-proposito.png" -Force
Copy-Item "$srcDir\media__1785371826408.png" "$dstDir\passatempo-biblico.png" -Force

Write-Host "Todas as 5 imagens copiadas com sucesso para entregaveis-png!"
