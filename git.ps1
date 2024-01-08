# Vérifier si le dépôt a des modifications non commitées
if (git status | Select-String -Pattern "nothing to commit, working tree clean") {
    Write-Host "Aucun changement détecté, rien à commiter !" -ForegroundColor Yellow
} else {
    # Ajouter tous les fichiers modifiés à l'index
    git add .

    # Faire un commit avec un message contenant la date et l'heure actuelle
    $commit_message = "save $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git commit -m $commit_message

    # Pousser les modifications vers le dépôt distant
    git push

    # Extraire les informations du dernier commit
    $commitDateRaw = git log -1 --format=%cI
    $commitDateFormatted = Get-Date $commitDateRaw -Format "dddd d MMMM yyyy, HH:mm:ss"
    $remoteUrl = git remote -v | Select-String -Pattern "origin\s+(?<url>git@github\.com:(.+)\.git)" | ForEach-Object { $_.Matches[0].Groups["url"].Value }
    $repoDetails = $remoteUrl -replace 'git@github.com:', ''
    $accountName, $repoName = $repoDetails.Split('/')[0..1]

    # Afficher les informations du commit
    Write-Host "Date du commit : $commitDateFormatted" -ForegroundColor Yellow
    Write-Host "Dépôt : $accountName / $repoName" -ForegroundColor Yellow
    Write-Host "Commit et push terminé !" -ForegroundColor Green
}
