# Imagen base: Ubuntu 22.04 LTS
# Proporciona un sistema estable y compatible con la mayoría de herramientas
FROM ubuntu:22.04

# Evita preguntas interactivas durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instalación de dependencias básicas
# - curl / git: descargas y control de versiones
# - ca-certificates: certificados SSL (HTTPS)
# - unzip / rsync: utilidades comunes
# - sudo / bash: gestión de usuarios y shell
# - nginx: servidor web
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    unzip \
    sudo \
    bash \
    rsync \
    nginx \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Creación del usuario "runner"
# -m crea el home (/home/runner)
# Se le da acceso a sudo sin contraseña (necesario para el runner)
RUN useradd -m runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Establecemos el directorio de trabajo del contenedor
WORKDIR /home/runner

# Descarga del GitHub Actions Runner oficial
# Se descarga la versión concreta 2.331.0 para Linux x64
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "arm64" ]; then \
      curl -L -o actions-runner.tar.gz \
        https://github.com/actions/runner/releases/download/v2.331.0/actions-runner-linux-arm64-2.331.0.tar.gz ; \
    else \
      curl -L -o actions-runner.tar.gz \
        https://github.com/actions/runner/releases/download/v2.331.0/actions-runner-linux-x64-2.331.0.tar.gz ; \
    fi && \
    tar xzf actions-runner.tar.gz && \
    rm actions-runner.tar.gz && \
    chown -R runner:runner /home/runner

# Instalación de dependencias adicionales requeridas por el runner
RUN ./bin/installdependencies.sh

# Aseguramos que el directorio de trabajo es el correcto
WORKDIR /home/runner

# Copiamos el script de arranque del runner al contenedor
COPY ubuntu/githubaction.sh /home/runner

# Cambiamos propietario y permisos del script
# runner será el usuario que lo ejecute
RUN chown runner:runner /home/runner/githubaction.sh && \
    chmod 755 /home/runner/githubaction.sh

# Redirección de logs de Nginx a la salida estándar del contenedor
# Esto permite ver los logs usando `docker logs`
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Exponemos el puerto 80 (por defecto de Nginx)
# Solo es informativo; el mapeo real se hace en docker-compose
EXPOSE 80

# Cambiamos al usuario runner por seguridad
USER runner

# Punto de entrada del contenedor
# Ejecuta el script que registra y lanza el GitHub Runner
# (Está comentado para poder entrar manualmente al contenedor si se desea)
#ENTRYPOINT ["./githubaction.sh"]