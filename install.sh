# Prerequisitos

# Actualizar la lista de paquetes 
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common

# Version de Ubuntu
source /etc/os-release

# Descargar las claves del repositorio de Microsoft
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Registrar las claves del repositorio de Microsoft
sudo dpkg -i packages-microsoft-prod.deb

# Eliminar el archivo de claves del repositorio de Microsoft
rm packages-microsoft-prod.deb

# Actualizar la lista de paquetes después de agregar packages.microsoft.com
sudo apt-get update

###################################

# Instalar PowerShell
sudo apt-get install -y powershell

# Iniciar PowerShell
pwsh
