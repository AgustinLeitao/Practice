# Nombre Del Script: Ejercicio2.ps1
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
    Ejercicio 2 del trabajo practico Nº2 Powershell
.EXAMPLE
    .\Ejercicio2.ps1 [ID_Proceso]
.DESCRIPTION
    Este script muestra informacion acerca de los procesos que se estan ejecutando en el sistema. Si se pasa por parametro un PID se muestra informacion solo acerca de ese PID
#>

Param($proceso,$proceso2)

$PSBoundParameters.Values[0]