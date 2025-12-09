# script3.ps1
function New-FolderCreation {  #Define una funcion llamada New-FolderCreation
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$foldername
    )

    # Crear una ruta absoluta para la carpeta en relación con la ubicación actual
    $logpath = Join-Path -Path (Get-Location).Path -ChildPath $foldername  #(Get-Location).Path: Obtiene la ruta de la carpeta donde se está ejecutando el script y el Join-Path combina esa ruta con el $foldername
    if (-not (Test-Path -Path $logpath)) {  #Se ecarga de verificar si la carpeta ya existe
        New-Item -Path $logpath -ItemType Directory -Force | Out-Null
    }

    return $logpath   #Devuelve la ruta absoluta
}

function Write-Log {
    [CmdletBinding()]
    param(
        # Crear conjunto de parámetros
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]    #Create se utiliza para crear uno o más archivos de registro nuevos con formato de fecha y hora
        [Alias('Names')]
        [object]$Name,                    # Puede ser una sola cadena o una matriz

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$Ext,

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$folder,

        [Parameter(ParameterSetName = 'Create', Position = 0)]
        [switch]$Create,

        # Conjunto de parámetros de mensaje
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]  #Conjunto de Parámetros Message el cual se utiliza para agregar un mensaje a un archivo de registro existente
        [string]$message,       #El texto del mensaje que se registrará

        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$path,   #La ruta completa del archivo

        [Parameter(Mandatory = $false, ParameterSetName = 'Message')]
        [ValidateSet('Information','Warning','Error')]
        [string]$Severity = 'Information',

        [Parameter(ParameterSetName = 'Message', Position = 0)]
        [switch]$MSG
    )

    switch ($PsCmdlet.ParameterSetName) {         #determina qué bloque de código ejecutar basándose en el conjunto de parámetros utilizados asl llamar la funcion
        "Create" {   #
            $created = @()

            # Normalizar $Name a una matriz
            $namesArray = @()
            if ($null -ne $Name) {
                if ($Name -is [System.Array]) { $namesArray = $Name }      #Normaliza la entrada $Name a una matriz ($namesArray) para que tdodo funcione bien 
                else { $namesArray = @($Name) }
            }

            # Formato de fecha y hora (seguro para nombres de archivos)
            $date1 = (Get-Date -Format "yyyy-MM-dd")  #Genera las cadenas de fecha y hora en un formato seguro
            $time  = (Get-Date -Format "HH-mm-ss")  

            # Asegúrese de que la carpeta exista y obtenga la ruta absoluta de la carpeta
            $folderPath = New-FolderCreation -foldername $folder  #Hace el llamado de la priera funcion creada en este codigo 

            foreach ($n in $namesArray) {  #Inicia un bucle para procesar todos los nombres de los archivos 
                # sanitize name to string
                $baseName = [string]$n

                # Crear nombre de archivo
                $fileName = "${baseName}_${date1}_${time}.$Ext"

                # Ruta completa para el archivo
                $fullPath = Join-Path -Path $folderPath -ChildPath $fileName

                # Crea el archivo (New-Item -Force lo creará o sobrescribirá; usa -ErrorAction Stop para detectar errores)
                try {
                    # Si prefiere NO sobrescribir el archivo existente, utilice: if (-not (Test-Path $fullPath)) { New-Item ... }
                    New-Item -Path $fullPath -ItemType File -Force -ErrorAction Stop | Out-Null

                    # Opcionalmente, escriba una línea de encabezado (descoméntela si lo desea)
                    # "Registro creado: $(Get-Date)" | Archivo de salida - Ruta de archivo $ Ruta completa - Codificación UTF8 - Anexar

                    $created += $fullPath
                }
                catch {
                    Write-Warning "Failed to create file '$fullPath' - $_"
                }
            }

            return $created
        }

        "Message" {
            # Asegúrese de que exista el directorio para el archivo de mensajes
            $parent = Split-Path -Path $path -Parent   #Verifica la existencia de la carpeta padre 
            if ($parent -and -not (Test-Path -Path $parent)) {
                New-Item -Path $parent -ItemType Directory -Force | Out-Null
            }

            $date = Get-Date
            $concatmessage = "|$date| |$message| |$Severity|"

            switch ($Severity) {        #imprime el mensaje en la consola con el color correspondiente
                "Information" { Write-Host $concatmessage -ForegroundColor Green }
                "Warning"     { Write-Host $concatmessage -ForegroundColor Yellow }
                "Error"       { Write-Host $concatmessage -ForegroundColor Red }
            }

            # Añadir mensaje a la ruta especificada (crea un archivo si no existe)
            Add-Content -Path $path -Value $concatmessage -Force   #Escribe la línea de registro formateada

            return $path
        }

        default {
            throw "Unknown parameter set: $($PsCmdlet.ParameterSetName)"
        }
    }
}

# ---------- Example usage ----------
# This will create the folder "logs" (if missing) and create a file Name-Log_YYYY-MM-DD_HH-mm-ss.log
$logPaths = Write-Log -Name "Name-Log" -folder "logs" -Ext "log" -Create
$logPaths
