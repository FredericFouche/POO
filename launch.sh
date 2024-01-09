#!/bin/bash

# Vérifier si PowerShell est disponible
if command -v pwsh &> /dev/null
then
    # Exécuter le script PowerShell
    pwsh ./git.ps1
else
    # Exécuter le script Zsh/Bash
    ./git.sh
fi
