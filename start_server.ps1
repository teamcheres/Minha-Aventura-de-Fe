$prefix = "http://localhost:8090/"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
try {
    $listener.Start()
    Write-Host "Servidor rodando em $prefix"
} catch {
    Write-Host "Erro ao iniciar listener: $_"
    exit 1
}

$root = "c:\Users\Andrea Cheres\Desktop\arcalivros.vercel.app"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $rawUrl = [System.Uri]::UnescapeDataString($request.Url.AbsolutePath)

    # Return empty response for tracking API calls
    if ($rawUrl -like "*api/meta*" -or $rawUrl -like "*fbevents*" -or $rawUrl -like "*clarity*") {
        $response.ContentType = "application/json; charset=utf-8"
        $bytes = [System.Text.Encoding]::UTF8.GetBytes('{"status":"disabled"}')
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
        $response.OutputStream.Close()
        continue
    }

    if ($rawUrl -eq "/") {
        $filePath = Join-Path $root "home.htm"
    } elseif ($rawUrl -eq "/oferta" -or $rawUrl -eq "/checkout") {
        $filePath = Join-Path $root "index.htm"
    } else {
        $cleanPath = $rawUrl.TrimStart('/')
        $filePath = Join-Path $root $cleanPath
        if (-not (Test-Path $filePath)) {
            $filePath = Join-Path $root "home.htm"
        }
    }

    if (Test-Path $filePath) {
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        switch ($ext) {
            ".html" { $response.ContentType = "text/html; charset=utf-8" }
            ".htm"  { $response.ContentType = "text/html; charset=utf-8" }
            ".js"   { $response.ContentType = "application/javascript; charset=utf-8" }
            ".css"  { $response.ContentType = "text/css; charset=utf-8" }
            ".png"  { $response.ContentType = "image/png" }
            ".jpg"  { $response.ContentType = "image/jpeg" }
            ".jpeg" { $response.ContentType = "image/jpeg" }
            ".webp" { $response.ContentType = "image/webp" }
            ".svg"  { $response.ContentType = "image/svg+xml" }
            default { $response.ContentType = "application/octet-stream" }
        }
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $response.StatusCode = 404
    }
    $response.OutputStream.Close()
}
