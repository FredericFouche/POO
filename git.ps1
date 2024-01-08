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

# Obtenir la date et l'heure du dernier commit dans un format standard ISO 8601
$commitDateRaw = git log -1 --format=%cI

# Convertir la chaîne de date en un objet DateTime et le formater pour l'affichage
$commitDateFormatted = Get-Date $commitDateRaw -Format "dddd d MMMM yyyy, HH:mm:ss"

# Obtenir l'URL du dépôt distant
$remoteUrl = git remote -v | Select-String -Pattern "origin\s+(?<url>git@github\.com:(.+)\.git)" | ForEach-Object { $_.Matches[0].Groups["url"].Value }

# Extraire le nom du compte et le nom du dépôt
$repoDetails = $remoteUrl -replace 'git@github.com:', ''
$accountName, $repoName = $repoDetails.Split('/')[0..1]

# Afficher la date et l'heure du commit dans un format lisible dans la console PowerShell avec des couleurs
Write-Host "###############################################################################################################" -ForegroundColor Cyan
Write-Host "   Date du commit : $commitDateFormatted" -ForegroundColor Yellow
Write-Host "   Dépôt : $accountName / $repoName" -ForegroundColor Yellow
Write-Host "   Commit et push terminé !" -ForegroundColor Green
Write-Host "###############################################################################################################" -ForegroundColor Cyan
