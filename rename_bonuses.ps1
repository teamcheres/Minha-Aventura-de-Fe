$dir = "entregaveis-png"
$items = Get-ChildItem -Path $dir

$map = @{
    "Alfabeto" = "alfabeto-biblico.png"
    "AMOR DE DEUS" = "amor-de-deus.png"
    "ANTIGO TESTAMENTO" = "antigo-testamento.png"
    "APRENDENDO A ORAR" = "aprendendo-a-orar.png"
    "Aprendendo com Alegria" = "aprendendo-com-alegria.png"
    "Atividade ABC" = "atividade-abc-biblica.png"
    "Aventuras" = "aventuras-biblicas.png"
    "COLORINDO" = "colorindo-com-proposito.png"
    "Complete os nomes" = "complete-os-nomes-dos-animais.png"
    "PASSATEMPO" = "passatempo-biblico.png"
}

foreach ($item in $items) {
    foreach ($key in $map.Keys) {
        if ($item.Name -like "*$key*") {
            $newName = $map[$key]
            $target = Join-Path $dir $newName
            Copy-Item -Path $item.FullName -Destination $target -Force
            Write-Host "Copiado $($item.Name) -> $newName"
        }
    }
}
