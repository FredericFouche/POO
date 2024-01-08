# Ajouter tous les fichiers modifiés à l'index
git add .

# Faire un commit avec un message contenant la date et l'heure actuelle
$commit_message = "save $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commit_message

# Pousser les modifications vers le dépôt distant
git push
