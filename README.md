# Mon Projet Fullstack - Django Backend et Flutter Frontend

Ce projet est une application fullstack composée d'une API backend développée avec Django et un frontend mobile développé avec Flutter.

## Table des matières

1. [Prérequis](#prérequis)
2. [Installation Backend (Django)](#installation-backend-django)
3. [Installation Frontend (Flutter)](#installation-frontend-flutter)
4. [Exécution des serveurs](#exécution-des-serveurs)
5. [Liens API](#liens-api)

## Prérequis

### Backend (Django)
- Python 3.x
- pip (pour installer les packages Python)
- Django
- Django REST Framework
- SimpleJWT pour l'authentification par token
- Swagger et ReDoc pour la documentation API

### Frontend (Flutter)
- Flutter SDK installé
- Un émulateur ou un appareil connecté pour exécuter l'application mobile
- Dart 2.x

## Installation Backend (Django)

### Étapes d'installation

1. **Cloner le repository**

    ```bash
    git clone https://github.com/SimonTHD/Test_technique.git
    cd Test_technique/test_technique_db
    ```

2. **Créer et activer un environnement virtuel**

    ```bash
    python3 -m venv env
    source env/bin/activate  # Sur Windows: env\Scripts\activate
    ```

3. **Installer les dépendances**

    ```bash
    pip install -r requirements.txt
    ```

4. **Appliquer les migrations de la base de données**

    ```bash
    python manage.py migrate
    ```

## Installation Frontend (Flutter)

### Étapes d'installation

1. **Cloner le repository**

    ```bash
    git clone https://github.com/SimonTHD/Test_technique.git
    cd Test_technique/test_technique_flutter
    ```

2. **Installer les dépendances Flutter**

    ```bash
    flutter pub get
    ```

## Exécution des serveurs

### Lancer le serveur Django

1. **Démarrer le serveur de développement**

    ```bash
    python manage.py runserver
    ```

2. Accédez à l'interface d'administration sur `http://127.0.0.1:8000/admin` et à la documentation API sur `http://127.0.0.1:8000/swagger` ou `http://127.0.0.1:8000/redoc`.

### Lancer l'application Flutter

1. **Exécuter l'application mobile**

    ```bash
    flutter run
    ```

2. Sélectionnez votre émulateur ou appareil connecté pour exécuter l'application.

## Liens API

Voici les différentes routes disponibles dans l'API Django :

- **Authentification :**
    - `POST /api/token/` : Obtenir un token d'authentification JWT
    - `POST /api/token/refresh/` : Rafraîchir le token JWT

- **Documentation :**
    - `GET /swagger/` : Interface Swagger pour la documentation API
    - `GET /redoc/` : Interface ReDoc pour la documentation API

- **Gestion des utilisateurs :**
    - `POST /api/create-user/` : Créer un nouvel utilisateur

- **Projets :**
    - `POST /projects/` : Créer un nouveau projet
    - `GET /projects/user/` : Récupérer les projets de l'utilisateur connecté
    - `DELETE /projects/delete/<int:project_id>/` : Supprimer un projet
    - `PUT /projects/update/<int:project_id>/` : Mettre à jour un projet

## Conclusion

Ce projet combine un backend Django REST API avec un frontend Flutter mobile, permettant de gérer des projets github. 
