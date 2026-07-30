$chunks = @(
  "Home-CC2Is4hr.js",
  "button-CDxHtBL3.js",
  "input-lpl5Q-rk.js",
  "products-vQmH53uM.js",
  "sparkles-Bsnovqd-.js",
  "Oferta-BvXpSuaQ.js",
  "accordion-B5C3vGLP.js",
  "index-TatddyaZ.js",
  "circle-check-BgGLt3Py.js",
  "carousel-PC9daehr.js",
  "ViewPage-DvBeGbwG.js",
  "ViewPage-BJxbsBGp.css",
  "BonusGrid-f8KfUtAS.js",
  "index-ghQi_28l.js",
  "Ofertas-DthddbCq.js",
  "Checkout-DMgEfz-p.js",
  "OrderSummary-Cr7KQ2zF.js",
  "heicPreview-_LIU7JtD.js",
  "teams-Bss0HUGN.js",
  "TeamSelector-BfWRSzd-.js",
  "Checkouts-BaG-LObS.js",
  "Success-DicJlyEx.js",
  "message-circle-DkwgiDbx.js",
  "Failure-B30Q_ord.js",
  "Pending-Ru-qDPHa.js",
  "HomeCopa-DK-2r-81.js",
  "HomeVideoCopa-Cb6-6BP6.js",
  "HomeVideoNacional-By-f2vc4.js",
  "HomeVideoFutebol-Qz9qyccw.js",
  "OfertaVideoNacional-DJX5Dtnl.js",
  "OfertaVideoFutebol-DRe7hEMj.js",
  "HomeVideoCopaMundo-Cnv0l25d.js",
  "OfertaVideoCopaMundo-_yJKVUQ0.js",
  "OfertaKit5Livros-B-xb3ElY.js",
  "Produtos-CkZAbamA.js"
)

foreach ($c in $chunks) {
    $url = "https://arcalivros.vercel.app/assets/" + $c
    $out = "assets/" + $c
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -ErrorAction Stop
        Write-Host "Baixado: $c"
    } catch {
        Write-Host "Falha ao baixar $c : $_"
    }
}
