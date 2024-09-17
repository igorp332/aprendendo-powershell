function Get-FileSHA1() {
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = "FullName",
            Mandatory = $true
        )]
       [string] $filePath
    )


    begin {
        $sha1 = New-Object System.Security.Cryptography.SHA1Managed
        $prettyHashSB = New-Object System.Text.StringBuilder
    }
    
    process {
        
        $fileContent = Get-Content $filePath
        $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)


        $hash = $sha1.ComputeHash($fileBytes)
        
        foreach ($byte in $hash) {
            $hexaNotation = $byte.ToString("X2")
            $prettyHashSB.Append($hexaNotation) > $null
        }

        $prettyHashSB.ToString()
        
        $prettyHashSB.Clear() > $null
        
    }
    
    end {
        $sha1.Dispose()
    }

}
  
$arquivo = "C:\Users\igorp\OneDrive\Área de Trabalho\File.SHA.ps1"
$hashDoArquivo = Get-FileSHA1 $arquivo
        
Write-Host "O hash do arquvivo $arquivo é $hashDoArquivo" -BackgroundColor Red -ForegroundColor Yellow



#Função para obtermos o hash 256 do arquivo localizado em $filePath
function Get-FileSHA256($filePath) {
    
    $fileContent = Get-Content $filePath
    $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)

    $sha1 = New-Object System.Security.Cryptography.SHA256Managed

   
    $hash = $sha1.ComputeHash($fileBytes)

    $prettyHashSB = New-Object System.Text.StringBuilder

    foreach ($byte in $hash) {
        $hexaNotation - $byte.ToString("X2")
        $prettyHashSB.Append($hexaNotation) > $null
    }

    $prettyHashSB.ToString()

}
function Get-FileSHA385() {}
function Get-FileSHA512() {}    