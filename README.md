[![Terraform](https://github.com/Chambras/HashiTalksLatam2024S1/actions/workflows/terraform.yml/badge.svg)](https://github.com/Chambras/HashiTalksLatam2024S1/actions/workflows/terraform.yml)

# Creación de entornos de análisis de datos en la nube usando Terraform

Esta sesión explorará paso a paso el proceso de creacion, administracion de clusters, espacios de trabajo (Workspaces) y otros recursos de Databricks usando Terraform.

Muestra como integrar Terraform, Ansible y GitHub Actions con el fin de crear fácilmente entornos de análisis de datos. También usa un clúster de Databricks para analizar los datos.

Esto demo usa FAA's System Wide Information System (SWIM) por sus siglas en ingles y se conecta a TFMS ( Traffic Flow Management System ) usando un servidor Kafka. Mas información sobre SWIM y TFMS se puede encontrar [aca](https://www.faa.gov/air_traffic/technology/swim/).

Este demo tambien esta basado en el articulo q publique titulado [Ingest FAA SWIM content to analyze flight data](https://aka.ms/AAgnicg) en Azure Architecture Center.

## Estructura del Proyecto

Este proyecto tiene las siguientes carpetas que facilitan su reutilización, adición o eliminación.

```ssh
.
├── .devcontainer
├── .github
├── .gitignore
├── LICENSE
├── README.md
├── ansible
├── notebooks
└── terraform-azure
```

## Cuidado

Tenga en cuenta que al ejecutar este demo es posible que se facture a su subscripción de Azure.

## Autor

- Marcelo Zambrana
