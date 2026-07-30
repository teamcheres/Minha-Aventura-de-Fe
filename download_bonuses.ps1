$bonusImgs = @(
  "Alfabeto bíblico.png",
  "AMOR DE DEUS.png",
  "ANTIGO TESTAMENTO.png",
  "APRENDENDO A ORAR.png",
  "Aprendendo com Alegria.png",
  "Atividade ABC bíblica.png",
  "Aventuras bíblica.png",
  "COLORINDO com propósito.png",
  "Complete os nomes dos animais.png",
  "PASSATEMPO BÍBLICO.png"
)

if (-not (Test-Path "entregaveis-png")) {
    New-Item -ItemType Directory -Path "entregaveis-png" -Force | Out-Null
}

foreach ($b in $bonusImgs) {
    $encoded = [System.Uri]::EscapeDataString($b)
    $url = "https://arcalivros.vercel.app/entregaveis-png/" + $encoded
    $out = "entregaveis-png/" + $b
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -ErrorAction Stop
        Write-Host "Baixado bônus: $b"
    } catch {
        Write-Host "Falha ao baixar $b : $_"
    }
}
