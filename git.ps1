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
$commitDateRaw = git log -1 --format=%cd
$commitDate = Get-Date $commitDateRaw -Format "dddd, MMMM d, yyyy HH:mm:ss"

# Obtenir le nom du dépôt distant
$depotName = git remote -v | Select-String -Pattern "origin\s+(?<url>.+?)(\s|$)" | ForEach-Object { $_.Matches[0].Groups["url"].Value }

# Afficher la date et l'heure du commit dans un format lisible dans la console PowerShell avec des couleurs
Write-Host "###############################################################################################################" -ForegroundColor Cyan
Write-Host "   $commitDate on $depotName " -ForegroundColor Yellow
Write-Host "   Commit et push terminé !" -ForegroundColor Green
Write-Host "###############################################################################################################" -ForegroundColor Cyan
