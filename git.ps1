# Ajouter tous les fichiers modifiés à l'index
git add .

# Faire un commit avec un message contenant la date et l'heure actuelle
$commit_message = "save $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commit_message

# Pousser les modifications vers le dépôt distant
git push

# Retourner la date et l'heure du commit avec un affichage plus lisible dans la console PowerShell (### le message ###)

# Exemple de sortie dans la console :
# ###########################
# ### 2020-04-01 14:00:00 ###
# ###########################

# Obtenir la date et l'heure du dernier commit
$commitDate = git log -1 --format=%cd

# Afficher la date et l'heure du commit dans un format lisible
Write-Output "#####################################"
Write-Output "### $commitDate ###"
Write-Output "#####################################"