@ECHO OFF
echo Buscando servico "ByeBank Interface Service" no servidor SRV01
sc \\SRV01 query "ByeBank Interface Service" | find /i "state" | find /i "running"

IF %ERRORELEVEL% NEQ 0 (
        echo Ops, servico nao sendo executado no servidor!
) ELSE (
        echo Parando servico...
        sc \\SRV01 stop "ByeBank Interface Service" > NUL
        echo Iniciando servico...
        sec \\ SRV01 start "ByeBank Interface Service" > NUL
        echo Servico Reiniciado com sucesso!
)