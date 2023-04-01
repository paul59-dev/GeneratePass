# Générateur de mots et gestionnaire de mots de passe

Ce projet vise à fournir un outil simple et pratique pour générer des mots aléatoires et sécurisés ainsi que pour gérer des mots de passe de manière efficace. L'outil utilise une combinaison de méthodes de génération de nombres aléatoires et de combinaisons de caractères pour générer des mots aléatoires.

## Fonctionnalités

- Génère des mots aléatoires en fonction des paramètres spécifiés, tels que la longueur et les types de caractères à utiliser.
- Génère des mots de passe sécurisés en utilisant des techniques avancées de hachage et de salage.
- Stocke les mots de passe en toute sécurité dans une base de données chiffrée pour un accès facile et sûr.
- Permet de rechercher, modifier et supprimer les mots de passe stockés.
- Offre une interface utilisateur simple et conviviale pour accéder à toutes les fonctionnalités.

## Technologies utilisées

- Python pour la logique de génération de mots et de gestion de mots de passe.
- Flask pour la création d'une interface web conviviale.
- SQLite pour la base de données de stockage des mots de passe.
- HTML, CSS et JavaScript pour la conception de l'interface utilisateur.

## Comment utiliser

1. Clonez ce dépôt sur votre machine locale.
2. Installez les dépendances en exécutant `pip install -r requirements.txt`.
3. Configurez le fichier `config.py` pour spécifier les paramètres de génération de mots de passe et les informations de connexion à la base de données.
4. Exécutez l'application en exécutant `python app.py`.
5. Accédez à l'interface utilisateur en ouvrant votre navigateur et en naviguant vers `http://localhost:5000`.

## Avertissement de sécurité

Ce projet a été conçu pour un usage personnel et ne doit pas être utilisé pour stocker des mots de passe sensibles ou critiques, tels que ceux utilisés pour les comptes bancaires ou les services de paiement en ligne. Il est recommandé d'utiliser un gestionnaire de mots de passe tiers pour stocker en toute sécurité les mots de passe les plus importants.
