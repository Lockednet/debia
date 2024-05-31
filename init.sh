#!/bin/bash

# Configurações
GITHUB_USER="Lockednet"  # Substitua pelo nome do usuário do GitHub
GITHUB_REPO="debia"  # Substitua pelo nome do repositório
GITHUB_FILE="proxy.txt"  # Substitua pelo caminho do arquivo no repositório

# Obter o IP do servidor
SERVER_IP=$(hostname -I | awk '{print $1}')

# Verificar se o curl está instalado, se não, instalar automaticamente
if ! command -v curl &> /dev/null; then
    echo "curl não está instalado. Instalando curl..."
    sudo apt-get update
    sudo apt-get install -y curl
fi

# Obter o conteúdo do arquivo do GitHub
response=$(curl -s -H "Accept: application/vnd.github.v3.raw" "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/contents/$GITHUB_FILE")

# Verificar se a resposta está vazia
if [ -z "$response" ]; then
    echo "Não foi possível obter o arquivo do GitHub. Verifique as configurações e tente novamente."
    exit 1
fi

# Verificar se o IP do servidor está no conteúdo do arquivo
if echo "$response" | grep -q "$SERVER_IP"; then
    echo "IP válido. A instalação pode continuar."
else
    echo "ESTE IP NÃO É VALIDO!!"
    exit 1
fi

# Continuar com a execução do script...
reboot
