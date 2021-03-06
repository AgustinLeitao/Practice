# Nombre Del Script: Ejercicio2.ps1
# Trabajo Práctico Nro.: 1
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
    Ejercicio 2 del trabajo practico Nº1 Powershell
.EXAMPLE
    .\Ejercicio2.ps1 [Path_Entrada][Path_Salida]
.DESCRIPTION
    Este script busca los 5 archivos mas nuevos en el directorio [Path_Entrada] recursivamente, y los copia en el directorio [Path_Salida]
#>

Param($origen,$destino)
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

$cont = 0 # Contador de archivos que cumplen con un determinado filtro.
get-childitem -recurse $origen | where {$_.attributes -eq "archive"} | foreach { $cont++ } # Cuenta los archivos de un cierto directorio que cumplen con el filtro
if($cont -eq 0)
{
    echo("Error: No hay archivos en el directorio $origen");
    exit(1);
}

# Bloque para guardar los 5 archivos (o los que haya) mas nuevos del directorio origen.
$res = Get-ChildItem -Path $origen -recurse  | where {$_.attributes -eq "archive"} | Sort-Object CreationTime -Descending | Select-Object -First 5 
$origen = $origen.trimstart(".\")
$separator_dir = "$origen\",""

$option = [System.StringSplitOptions]::RemoveEmptyEntries # Opcion para el metodo split.

foreach ($elemento in $res) 
    # Bloque para renombrar cada archivo y diferenciarlo en caso de que haya archivos con igual nombre en la estructura del directorio origen. Se copiaran los archivos en el directorio de salida con el formato
    # Nombre_Archivo - Ruta_Archivo
{ 
    $cad = $elemento.fullname.Split($separator_dir, $option) | select -last 1
    $separator_nom = $elemento.name,""
    $cad = $cad.split($separator_nom,$option) | select -last 1
    if($cad -notlike "")
    {
        $cad = $cad.trimend("\")
        $cad = $cad.replace("\","-")  
    }
    $salida = $destino + "\" + $elemento.basename + "-" + $cad
    $salida = $salida.trimend("-")
    $salida = $salida + $elemento.extension
    copy-item $elemento.fullname $salida
}

#EOF