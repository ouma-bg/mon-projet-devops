# Pipeline CI/CD avec Jenkins, Docker & Terraform sur AWS

## Description
Ce projet met en place une chaîne DevOps complète : une API Flask conteneurisée,
déployée automatiquement via un pipeline Jenkins déclaratif, avec l'infrastructure
provisionnée en Infrastructure as Code (Terraform) sur AWS.

## Stack technique
- **Application** : API REST (Flask)
- **Conteneurisation** : Docker
- **CI/CD** : Jenkins (pipeline déclaratif)
- **Infrastructure as Code** : Terraform
- **Cloud** : AWS (EC2, Security Groups)
- **Registry** : Docker Hub

## Architecture
```bash
GitHub → Jenkins → Build Docker Image → Push Registry → Terraform Apply → Déploiement EC2
```
## Structure du projet
```bash
mon-projet-devops/
├── app.py              # Application Flask
├── requirements.txt    # Dépendances Python
├── Dockerfile           # Image Docker de l'application
├── Jenkinsfile           # Pipeline CI/CD déclaratif
└── terraform/
├── main.tf          # Ressources AWS (EC2, Security Group)
├── variables.tf     # Variables Terraform
└── outputs.tf       # Outputs (IP de l'instance)
```
## Installation locale
```bash
pip install -r requirements.txt
python app.py
```

## Build Docker
```bash
docker build -t mon-app:latest .
docker run -p 5000:5000 mon-app:latest
```

## Déploiement infrastructure (Terraform)
```bash
cd terraform
terraform init
terraform apply
```

## Auteur
Oumaima Baghadi