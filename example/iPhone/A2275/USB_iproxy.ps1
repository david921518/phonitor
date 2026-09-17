$iproxy = "C:\MyTool\libimobile-suite\iproxy.exe"
$ports  = 47984, 47989, 47990, 48010

$procs = foreach ($port in $ports) {
    Start-Process -FilePath $iproxy `
        -ArgumentList $port, $port `
        -WindowStyle Hidden `
        -PassThru
}

$procs | Select-Object Id, ProcessName, StartTime
