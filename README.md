# IES_ROMERO_DESPLIEGUE

# 💻 Práctica despliegue seguro de aplicaciones con github actions
# IES Romero Vargas - Jerez de la Frontera (Cádiz)


## 📌 Descripción clase 1
Esta práctica tiene como objetivo:
- Comprender el concepto de despliegue seguro de aplicaciones simulando servidores con docker
- Comprobar el flujo de github actions en el despliegue de cambios en todos los contenedores docker

---

## 🛠️ Tecnologías utilizadas
- Docker
- HTML, CSS
---

## ✅ Instalación y configuración

### 1. Arrancar máquina docker

Clonar repositorio

```
git clone https://github.com/gadiro2005-sys/IESRomeroVargas_despliegue_apps.git
cd IESRomeroVargas_despliegue_apps
```

Arrancamos el contendor docker para la práctica

```
cd docker
docker compose -f docker-compose.yml -p docker up -d
o de otra forma
docker-compose up -d
```
```
docker ps
docker exec -it ubuntu22_server /bin/bash
```

Abrir el navegador con la siguiente dirección url:
- [ ] [Localhost](http://localhost:8006) 
Veremos la página index del servidor web NGINX


## License
GNU - For open source projects.

