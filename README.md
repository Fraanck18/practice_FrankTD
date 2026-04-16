# Proyecto de Infraestructura: Despliegue Multicontenedor con Terraform

Este repositorio contiene la configuración necesaria para desplegar una arquitectura de microservicios utilizando *Terraform* como herramienta de Infraestructura como Código (IaC) y *Docker* como plataforma de contenedores.

## 🚀 Arquitectura del Sistema
El despliegue consta de tres componentes principales interconectados en una red aislada llamada NETWORK:

1.  *Frontend (web-LOCAL-01)*: Servidor Nginx que sirve contenido estático.
    * *Puerto Local*: 4001
2.  *Backend (api01)*: API construida en Node.js que procesa la lógica de negocio.
    * *Puerto Local*: 4002
3.  *Base de Datos (bd)*: Instancia de PostgreSQL para persistencia de datos.
    * *Puerto Local*: 4003

## 🛠️ Requisitos Previos
* Docker Engine funcionando.
* Terraform v1.14.8+ instalado.
* Acceso a la terminal (Zsh/Bash).

## 📋 Instrucciones de Despliegue

Siga estos pasos para levantar la infraestructura completa:

1.  *Inicializar el directorio de trabajo:*
    ```Descarga los proveedores necesarios (Docker provider).
    bash
    terraform init
    ```

2.  *Validar la configuración:*
    Verifica que el archivo main.tf no tenga errores sintácticos.
    ```bash
    terraform validate
    ```

3.  *Aplicar la infraestructura:*
    Construye las imágenes y levanta los contenedores automáticamente.
    ```bash
    terraform apply -auto-approve
    ```

## 🔄 Mantenimiento
* Para detener y eliminar todos los recursos creados:
    ```bash
    terraform destroy -auto-approve
    ```
---
**Desarrollado por:** FrankTD
**Curso:** Cloud Computing / DevOps
