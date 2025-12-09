function Start-ProgressBar {   #Primero se define una funcion llamada Start-ProgressBar
    [CmdletBinding()]  #Es un atribute para qeu la funcions e comporte como un cmdlet
    param (
        [Parameter(Mandatory = $true)]     #Aqui se definen los parametros, donde se pone $Title para la cadena de texto que ira en la barra. Y el Timer que es el tiempo en entero qeu durara la barra en completarse 
        $Title,
        
        [Parameter(Mandatory = $true)]
        [int]$Timer
    )
    
    for ($i = 1; $i -le $Timer; $i++) {       #Se inicia el bucle for ($i=1 qeu significa que el contador inicia en 1) ($i -le $Timer, que significa que el bucle continúa mientras $i sea menor o igual al valor de $Timer)
        Start-Sleep -Seconds 1                #(Finalmente $i++, basicamnete es lo que hace que el contador se incremente en 1 cada vez) #Aqui tambien se ve que Start-Sleep sirve para pausar la ejecucion por 1 segundo
        $percentComplete = ($i / $Timer) * 100   #Calcula el porcentaje completado con la operacion mostada 
        Write-Progress -Activity $Title -Status "$i seconds elapsed" -PercentComplete $percentComplete  #Se encarga de actualizar la barra de progreso en la consola
    }
} 

# Llamada de funcion 
Start-ProgressBar -Title "Test timeout" -Timer 30   #Para ejecutar la funcion creada
