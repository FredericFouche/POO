
# Vérifier si le dépôt a des modifications non commitées
if (git status | Select-String -Pattern "nothing to commit, working tree clean") {
    Write-Host "###############################################################################################################" -ForegroundColor Cyan
    Write-Host "Aucun changement détecté, rien à commiter !" -ForegroundColor Yellow
    Write-Host "###############################################################################################################" -ForegroundColor Cyan
} else {
        # Ajouter tous les fichiers modifiés à l'index
    git add .

    # Liste des types de commit possibles
    $commitTypes = @(
        @{ Name = "fix"; Description = "Correction d'un bug" },
        @{ Name = "feat"; Description = "Ajout d'une nouvelle fonctionnalité" },
        @{ Name = "refactor"; Description = "Refactoring du code" },
        @{ Name = "docs"; Description = "Mise à jour de la documentation" },
        @{ Name = "test"; Description = "Ajout ou mise à jour de tests" },
        @{ Name = "chore"; Description = "Mise à jour de tâches automatisées" },
        @{ Name = "style"; Description = "Mise à jour de l'indentation, des espaces, etc." },
        @{ Name = "perf"; Description = "Amélioration des performances" },
        @{ Name = "ci"; Description = "Mise à jour de la configuration CI" },
        @{ Name = "build"; Description = "Mise à jour de la configuration de build" },
        @{ Name = "revert"; Description = "Revert d'un commit" }
    )

    # Afficher les types de commit et demander à l'utilisateur de choisir
    $index = 1
    $commitTypes | ForEach-Object {
        Write-Host "$index. $($_.Name) - $($_.Description)"
        $index++
    }
    $userChoice = Read-Host "Veuillez choisir un type de commit (1-$($commitTypes.Count))"
    $selectedCommitType = $commitTypes[$userChoice - 1].Name

    # Vérification de la saisie de l'utilisateur
    if (-not $selectedCommitType) {
        Write-Host "Choix invalide. Opération annulée." -ForegroundColor Red
        return
    }

    # Créer le message de commit
    $commit_message = "${selectedCommitType}: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
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
    Write-Host "###############################################################################################################" -ForegroundColor Cyan
    Write-Host "Date du commit : $commitDateFormatted" -ForegroundColor Yellow
    Write-Host "Dépôt : $accountName / $repoName" -ForegroundColor Yellow
    Write-Host "Commit de type $selectedCommitType et push terminé !" -ForegroundColor Green
    Write-Host "###############################################################################################################" -ForegroundColor Cyan

}
