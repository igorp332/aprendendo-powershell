# Função para obtermos o hash do arquivo localizado em $filePath.
function Get-FileSHA1 {
    # Bloco de parâmetros. Aqui utilizamos o atributo Parameter
    # para adornar características ao argumento $filePath.
    param(
        [Parameter(
            # A propriedade ValueFromPipeline indica que este valor
            # pode ser preenchido pelo pipeline.
            ValueFromPipeline = $true,
            # A propriedade ValueFromPipelineByPropertyName indica
            # que o PowerShell pode enviar a esta função apenas  o
            # valor da propriedade indicada, ao  invés  do  objeto
            # inteiro.
            ValueFromPipelineByPropertyName = "FullName",
            # Usando a propriedade Mandatory, indicamos  que  este
            # argumento é obrigatório.
            Mandatory = $true
        )]
        [String] $filePath
    )

    # Bloco de início, onde carregaremos os recursos utilizados
    # por todos os itens recebidos pelo pipeline!
    begin {
        $sha1 = New-Object System.Security.Cryptography.SHA1Managed
        $prettyHashSB = New-Object System.Text.StringBuilder
    }

    # Bloco de processamento. Aqui serão executados os comandos
    # a seguir para todos os itens de nosso pipeline.
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

    # Bloco de fim, onde devemos liberar os recursos criados
    # durante a execução de nossa função.
    # No caso, precisamos invocar o método Dispose do objeto
    # IDisposable SHA1Managed.
    end {
        $sha1.Dispose()
    }
}



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