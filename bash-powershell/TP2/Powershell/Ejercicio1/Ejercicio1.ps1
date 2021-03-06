# Nombre Del Script: Ejercicio1.ps1
# Trabajo Práctico Nro.: 2
# Ejercicio Nro: 2 POWERSHELL
# Entrega: Primera Entrega
# Integrantes: APELLIDOS, Nombres, DNI    
#    Famiglietti, Cristian, 29824170
#    Famiglietti, Damian, 32123414
#    Leitao Pinheiro, Agustin Jose, 33788181
#    Castillo, Florencia, 32980931
#    Romero, Cristian, 34297484

<#
.SYNOPSIS
    Ejercicio 1 del trabajo practico Nº2 Powershell
.EXAMPLE
    .\Ejercicio1.ps1 [Directorio_Archivos][Directorio_Backup]
.DESCRIPTION
    Este script realiza un backup en formato .zip de los archivos que estan en el directorio pasado por parametro.
#>

param($origen, $destino) #Parametros recibidos por el script.
$nombre_script = $MyInvocation.MyCommand.Name

if( ($origen -like "") -or ($destino -like "")  )
{ 
    echo "Error: Cantidad De Parametros Invalida"
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
    exit(1)
}
if( (Test-Path -pathType "container" $origen) -eq 0)
{
    echo "Error: El parametro $origen no es un directorio o no existe."
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    exit(1)    
}
if( (Test-Path -pathType "container" $destino) -eq 0)
{
    echo "Error: El parametro $destino no es un directorio o no existe."
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    exit(1)    
}

Add-Type -As System.IO.Compression.FileSystem
[System.IO.Compression.CompressionLevel]$Compression = "Optimal"
$fecha= Get-Date -format "yyyyMMdd"
$destino= $destino.trimEnd("\")
$destino_final = "$destino" + "\$fecha.zip"
if( (Test-Path $destino_final) -eq 0 )
{
    [System.IO.Compression.ZipFile]::CreateFromDirectory( $origen,$destino_final)
    echo "Backup Realizado. Guardado en $destino_final"
}
else
{
    echo "Error: El archivo $destino_final ya existe."
    exit(1)
}

$cont=0
Get-ChildItem -Path $destino -recurse  | where {$_.attributes -eq "archive" -and $_.Extension -eq ".zip" } | foreach { $cont++ }
if ( $cont -gt 3 )
{
    $res = Get-ChildItem -Path $destino -recurse  | where {$_.attributes -eq "archive" -and $_.Extension -eq ".zip"} | Sort-Object CreationTime -Descending | Select-Object -last 1
    remove-item $res.fullname
}
