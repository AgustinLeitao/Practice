# Nombre Del Script: Ejercicio4.ps1
# Trabajo Práctico Nro.: 1
# Ejercicio Nro: 4 POWERSHELL
# Entrega: Primera Entrega
# Integrantes: APELLIDOS, Nombres, DNI    
#    Famiglietti, Cristian, 29824170
#    Famiglietti, Damian, 32123414
#    Leitao Pinheiro, Agustin Jose, 33788181
#    Castillo, Florencia, 32980931
#    Romero, Cristian, 34297484

<#
.SYNOPSIS
    Ejercicio 4 del trabajo practico Nº1 Powershell
.EXAMPLE
    .\Ejercicio4.ps1 [Numero_Entero1][Numero_Entero2][Path_Salida]
.EXAMPLE
    .\Ejercicio4.ps1 2 10 C:\Salida.txt
.EXAMPLE
    .\Ejercicio4.ps1 -3 -50 C:\Salida.txt
.DESCRIPTION
    Este script realiza la suma, resta, promedio de 2 numeros enteros respectivamente y lo guarda en archivo
#>

param($x,$y,$path)
$nombre_script = $MyInvocation.MyCommand.Name

if( ($x -like "") -or ($y -like "")  )
{ 
    echo "Error: Cantidad De Parametros Invalida"
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
    exit(1)
}
else
{
    if( ($x -notmatch "^[-]?[0-9.]+$") )
    {
        echo "Error: El Parametro [$x] no es un numero entero"
        echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
        echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
        exit(1)
    }
    if( ($y -notmatch "^[-]?[0-9.]+$") )
    {
        echo "Error: El Parametro [$y] no es un numero entero"
        echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
        echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
        exit(1)
    }
    if( (Test-Path -pathType "leaf" $path) -eq 0)
    {
        echo "Error: El parametro [$path] no es un archivo o no existe."
        echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
        echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
        exit(1)  
    }
    else
    {
       $path = [System.IO.FileInfo] $path
       if( $path.extension -ne ".txt" )
       {
          echo "Error: El parametro [$path] no es un archivo de texto"
          echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
          echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
          exit(1)   
       }    
    }
}

echo "Suma: $x + $y = $($x+$y)" > $path
echo "Resta: $x - $y = $($x-$y)" >> $path
echo "Multiplicacion: $x * $y = $($x*$y)" >> $path
echo "Promedio: ($x+$y)/2 = $(($x+$y)/2)" >> $path
echo "Resultados Guardados En $path"

#EOF