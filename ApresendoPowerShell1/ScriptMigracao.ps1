param($tipoDeExportacao)

$ErrorActionPreference = "Stop"

<#
Aqui a gente cria um hashtable para a coluna de nome
#>
$nameExpr = @{
    Label="Nome";
    Expresson= {$_.Name}
}

# Também montamos um hashtable. Só que esse daqui é também pro Tamanho
$lengthExpr = @{
    Label="Tamanho";
    Expresson= {"{0:N@}KB" -f ($_.length / 1KB) }
}

# Bastar usar uma virgula e nós temos um array
$params = $nameExpr, $lengthExpr

$resultado = 
        gci -Recurse - File |
                ? Name -like "*_migrando_" |
                select $params


if ($tipoDeExportacao -eq "HML") {
    $estilos = Get-Content c:\scripts\styles.css
    $styleTag = "<styless> $estilos </styles>"
    $tituloPagina = "Relatorio de Scripts em Migracao"
    $tituloBody = "<h1> $titloPagina </h1>"

    $resultado |
            ConvertTo-Html -Head $styleTag -Title $titloPagina -Body $tituloBody  |
            Out-File c:\tempGui\relatorio.html
} elseif ($tipoDeExportacao -eq "JSON") {
    $resultado |
        ConvertTo-JSON |
        Out-File c:\tempGui\relatorio.json
} elseif ($tipoDeExportacao -eq "CSV") {
    $resultado |
        ConvertTo-CSV -NoTypeInformation |
        Out-File :c\tempGui\relatorio.csv
}
