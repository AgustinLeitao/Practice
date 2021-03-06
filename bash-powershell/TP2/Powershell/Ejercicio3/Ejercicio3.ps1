# Nombre Del Script: Ejercicio3.ps1
# Trabajo Práctico Nro.: 2
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
    Ejercicio 3 del trabajo practico Nº2 Powershell
.EXAMPLE
    .\Ejercicio3.ps1 [Hostname]
.DESCRIPTION
    Este script muestra informacion acerca de un computer_name pasado por parametro.
#>

param($computer_name)
$nombre_script = $MyInvocation.MyCommand.Name

if( ($computer_name -like "")  )
{ 
    echo "Error: Cantidad De Parametros Invalida"
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
    exit(1)
}

if(Test-Connection -ComputerName $computer_name -Count 1 -ea 0) 
{   
    $ele= @{Expression={$_.IpAddress[0]};Label="IP";width=25},@{Expression={$_.IPSubnet[0]};Label="Subred";width=20},@{Expression={$_.MACAddress};Label="Direccion MAC";width=20}
    Get-WmiObject -class Win32_NetworkAdapterConfiguration -ComputerName $computer_name | ? {$_.IPEnabled} | Format-Table $ele
}
else
{
    echo "Error: El hostname $computer_name no existe"
    echo "Escriba get-help $nombre_script para recibir ayuda acerca de la invocacion al script"
    echo "Escriba get-help $nombre_script -examples para que se muestren ejemplos de invocacion"
    exit(1)
}

#EOF