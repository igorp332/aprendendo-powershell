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
    #Vamos, antes de tudo, objter o conteúdo deste arquivo
    # e objetar a cadeia de bytes que representa seu conteúdo
    $fileContent = Get-Content $filePath
    $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)

    # Não vamos reiventar a roda! O .NET já possui
    # implemetado uma classe que executa o algoritimo de 
    #hash para nós!
    $sha1 = New-Object System.Security.Cryptography.SHA256Managed

    # Com uma istância de objeto SHA256Managed e os bytes
    # de nosso arquivo, basta operar usando o método 
    # ComputeHash
    $hash = $sha1.ComputeHash($fileBytes)

    # Para facilitar o trabalho de concatenação de strings
    # de uma forma mais performática, devemos usar o
    # StringBuilder.
    $prettyHashSB = New-Object System.Text.StringBuilder

    # Com nosso Hashi calculado e uma instância do 
    # StringBuikder, bata obtermos a notação hexadecimal
    # com o argumento X2 ao método Byte::ToString(string)
    foreach ($byte in $hash) {
        $hexaNotation - $byte.ToString("X2")
        $prettyHashSB.Append($hexaNotation) > $null
    }

    # usando uma expressão de valor livre, enviamos seu
    # resultado ao pipeline
    $prettyHashSB.ToString()

}
function Get-FileSHA385() {}
function Get-FileSHA512() {}    