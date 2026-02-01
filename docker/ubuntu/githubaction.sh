#!/bin/bash
set -e
#Iniciar servicio NGINX en ubuntu
echo "Starting Nginx..."
sudo service nginx start

# Creamos una variable para hacer un identificador
# único al registrar el runner de github
# formato: timestamp + random number
UNIQUE_ID="$(date +%s)-$RANDOM"
TOKEN="B2733TNM46T6HXPXLQRM3JLJP6NM4"
GITHUB_REPOSITORY="https://github.com/gadiro2005-sys/IESRomeroVargas_despliegue_apps"
RUNNER_PATH="/home/runner"
CONTAINER_NAME="server-$UNIQUE_ID"
LABELS="linux,server-$UNIQUE_ID"
echo "▶ Registering runner: $CONTAINER_NAME"
#Registramos el runner
./config.sh \
  --unattended \
  --url "$GITHUB_REPOSITORY" \
  --token "$TOKEN" \
  --name "$CONTAINER_NAME" \
  --work "$RUNNER_PATH" \
  --labels "$LABELS" \
  --replace
#Iniciamos el runner
echo "▶ Starting runner"
echo "========================================="
echo "ID CONTAINER: $CONTAINER_NAME"
echo "========================================="
./run.sh

