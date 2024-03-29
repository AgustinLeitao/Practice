# Nombre Del Script: Ejercicio3.ps1
# Trabajo Práctico Nro.: 1
# Ejercicio Nro: 3 POWERSHELL
# Entrega: Primera Entrega
# Integrantes: APELLIDOS, Nombres, DNI    
#    Famiglietti, Cristian, 29824170
#    Famiglietti, Damian, 32123414
#    Leitao Pinheiro, Agustin Jose, 33788181
#    Castillo, Florencia, 32980931
#    Romero, Cristian, 34297484

<#
.SYNOPSIS 
    Ejercicio 3 del trabajo practico Nº1 Powershell
.EXAMPLE
    .\Ejercicio3.ps1 [Directorio]
.DESCRIPTION
    Este script muestra en formato tabla la cantidad de veces que se se encuentra cada archivo, del directorio pasado por parametro, en dicha estructura de directorio.
#>

param($directorio)
$nombre_script = $MyInvocation.MyCommand.Name

if( ($directorio -like "")  )
{ 
    echo "Error: Cantidad De Parametros Invalida"
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
    exit(1)
}
if( (Test-Path -pathType "container" $directorio) -eq 0)
{
    echo "Error: El parametro $directorio no es un directorio o no existe."
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    exit(1)    
}

$cont = 0
get-childitem -recurse $directorio | where {$_.attributes -eq "archive"} | foreach { $cont++ } # Cuenta los archivos de un cierto directorio que cumplen con el filtro
if($cont -eq 0)
{
    echo("Error: No hay ningun archivo en el directorio $directorio");
    exit(1);
}

$res = get-childitem -recurse $directorio | where {$_.attributes -eq "archive"}
$ele = @{}

foreach ($var in $res)
{  
    $ele[$var.basename]++
}

$ele | format-table

#EOF