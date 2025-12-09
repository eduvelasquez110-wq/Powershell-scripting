# Prerequisitos

# Actualizar la lista de paquetes 
sudo apt-get update #Se encarga de actualizar la lista de paquetes disponibles en los repositorios del sistema

# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common  #Instala los paquetes (wget-Para descargar archivos de internet) (apt-transport-https) (software-properties-common)

# Version de Ubuntu
source /etc/os-release #Se encarga de ejecutar el archivo /etc/os-release en la shell actual

# Descargar las claves del repositorio de Microsoft
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb #Descarga un archivo .deb desde los servidores de Microsoft

# Registrar las claves del repositorio de Microsoft
sudo dpkg -i packages-microsoft-prod.deb #Instala (-i) el paquete .deb que se acaba de descargar

# Eliminar el archivo de claves del repositorio de Microsoft
rm packages-microsoft-prod.deb #Elimina (rm) el archivo de instalación (.deb) descargado

# Actualizar la lista de paquetes después de agregar packages.microsoft.com
sudo apt-get update #Actuaiza la lista de paquetes.

###################################

# Instalar PowerShell
sudo apt-get install -y powershell #Descarga el paquete powershell del repositorio de Microsoft

# Iniciar PowerShell
pwsh
