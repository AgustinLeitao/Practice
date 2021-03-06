# Nombre Del Script: Ejercicio1.ps1
# Trabajo Práctico Nro.: 1
# Ejercicio Nro: 1 POWERSHELL
# Entrega: Primera Entrega
# Integrantes: APELLIDOS, Nombres, DNI    
#    Famiglietti, Cristian, 29824170
#    Famiglietti, Damian, 32123414
#    Leitao Pinheiro, Agustin Jose, 33788181
#    Castillo, Florencia, 32980931
#    Romero, Cristian, 34297484

<#
.SYNOPSIS
    Ejercicio 1 del trabajo practico Nº1 Powershell
.EXAMPLE
    .\Ejercicio1.ps1 [Directorio][Filtro_Archivos][Cantidad_Minima_Archivos][Mensaje_Log]
.DESCRIPTION
    Este script guarda en el visor de eventos informacion sobre la eliminacion de archivos de un directorio pasado por parametro.
#>

param($Path, $Filer, $Cant, $Log) #Parametros recibidos por el script.

$Debug="Y"  
$nl="`r`n" # Variable que representa un salto de linea.
$txtEvento=$Log + $nl; # Texto informativo para escribir en el visor de eventos.

if ($Debug -eq "Y")
{
    $txtEvento=$txtEvento + "Path= " + $path + $nl;
    $txtEvento=$txtEvento + "Filer= " + $filer + $nl;
    $txtEvento=$txtEvento + "Cant= " + $cant + $nl;
}

$find = 0 # Contador de archivos que cumplen con un determinado filtro.
get-childitem -recurse $path | where {$_.attributes -eq "archive" -and $_.name -like $filer} | foreach { $find++ } # Cuenta los archivos de un cierto directorio que cumplen con el filtro
if ($Debug -eq "Y")
{
    $txtEvento=$txtEvento + "Encontrados= " + $find + $nl;
}
if ($find -gt $cant) # Se procede a eliminar los archivos mas viejos, siempre y cuando, haya mas archivos en el directorio que lo indicado por parametro.
{
    $ciclo=0 # Contador de ciclos
    do
    {  
        $fcre = get-date; # Se guarda la fecha y hora actual
        $var= get-childitem -recurse $path | where {$_.attributes -eq "archive" -and $_.name -like $filer} # Se guarda el conjunto de archivos que cumplen con el filtro
        foreach ($elemento in $var)  # Script para obtener dentro de una lista de archivos, el archivo mas antiguo.
        { 
            if($elemento.CreationTime -lt $fcre) 
            {
                $file = $elemento.FullName 
                $fcre = $elemento.CreationTime
            }
        }
        $txtEvento=$txtEvento + "Por depurar: " + $file + $nl
        remove-item $file # Se elimina el archivo mas antiguo
        $find-- # Se resta en 1 los encontrados ya que se borro un archivo
        $ciclo++
    }
    while ($find -ne 0 -and $ciclo -lt 5 ) # Se testea que haya archivos y tambien se controla que no se borren mas de 5.
}
else
{
    $txtEvento=$txtEvento + "No hay nada para depurar" + $nl;
}
Remove-EventLog -Source "Depurar Backups" # Se remueve el evento relacionado con el source descripto, para que luego de la primera ejecucion el script no nos advierta del error que el evento ya existe.
New-EventLog -LogName Application -Source "Depurar Backups" # Se crea el evento
Write-EventLog -LogName Application -Source "Depurar Backups" -EntryType Information -EventId 1 -Message $txtEvento; #Se escribe en el evento creado anteriormente

#EOF