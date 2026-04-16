terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# 1. Red de la aplicación
resource "docker_network" "app_network" {
  name = "NETWORK"
}

# 2. Definición de Imágenes
resource "docker_image" "postgres_img" {
  name         = "postgres:15-alpine"
  keep_locally = false
}

resource "docker_image" "api_img" {
  name = "api_image"
  build {
    context = "./api"
  }
}

resource "docker_image" "web_img" {
  name = "web_image"
  build {
    context = "./web"
  }
}

# 3. Definición de Contenedores

# Contenedor de Base de Datos
resource "docker_container" "bd_cont" {
  name  = "bd"
  image = docker_image.postgres_img.image_id
  networks_advanced { name = docker_network.app_network.name }
  
  # Variables de entorno necesarias para que Postgres no se apague
  env = [
    "POSTGRES_DB=practica_db",
    "POSTGRES_USER=admin_user",
    "POSTGRES_PASSWORD=password123"
  ]

  ports {
    internal = 5432
    external = 4003
  }
}

# Contenedor de la API
resource "docker_container" "api_cont" {
  name  = "api01"
  image = docker_image.api_img.image_id
  networks_advanced { name = docker_network.app_network.name }
  
  ports {
    internal = 3000
    external = 4002
  }
}

# Contenedor Web
resource "docker_container" "web_cont" {
  name  = "web-LOCAL-01"
  image = docker_image.web_img.image_id
  networks_advanced { name = docker_network.app_network.name }
  
  ports {
    internal = 80
    external = 4001
  }
}
