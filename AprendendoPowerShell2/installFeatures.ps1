function Install-Windows-FeatureInServers () {
    param(
        [String[]] $computers,
        [String] $featureName
    )

    $jobScriptBlock = {
        param(
            [String] $computerName,
            [String] $featureName
        )
        Install-WindowsFeature -ComputerName $computerName -Name $featureName
    }
    
    $computers | ForEach-Object {
        Start-Job -Name "JOB_$" -ScriptBlock $jobScriptBlock -ArgumentList ($_, $featureName)
    }
}


# Exemple w/comments 
function Install-WindowsFeatureInServers {
    param (
        [String[]] $computers,
        [String] $featureName
    )
    
}

# ScriptBlock a ser execultasdo por cada Job!
# Note que com o PowerShell, podemos guardar uma variável de ScripBlock
# com depedências de parâmetros, como fazemos a seguir;
$jobScriptBlock = {
    param(
        [String] $computerName,
        [String] $featureName
    )
}
# Chamada ao cmdlet do módulo Remote Server Administration Tools (RSAT)
Install-WindowsFeatureInServers -ComputerName $computerName -Name $featureName

$computers | ForEach-Object {
    #Iniciamos o Job com a função $jobScriptBlock passando por argumento
    # a variável de interação representando um computador e o nome da Feature
    Start-Job -Name -ScriptBlock $jobScriptBlock -ArgumentList ($_, $featureName)
}
