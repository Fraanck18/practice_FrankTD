terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.25.0" 
    }
  }
}

provider "docker" {}

resource "docker_network" "app_network" {
  name = "NETWORK"
}

resource "docker_image" "postgres_img" {
  name = "postgres:15-alpine"
}

resource "docker_container" "bd_cont" {
  name  = "bd"
  image = docker_image.postgres_img.latest
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = 5432
    external = 4003
  }
}

resource "docker_image" "api_img" {
  name = "api_image"
  build { path = "./api" }
}

resource "docker_container" "api_cont" {
  name  = "api01"
  image = docker_image.api_img.latest
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = 3000
    external = 4002
  }
}

resource "docker_image" "web_img" {
  name = "web_image"
  build { path = "./web" }
}

resource "docker_container" "web_cont" {
  name  = "web-LOCAL-01"
  image = docker_image.web_img.latest
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = 80
    external = 4001
  }
}
