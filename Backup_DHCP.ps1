<#
.SYNOPSIS
    Effectue des sauvegardes DHCP et supprime les anciennes sauvegardes.
    Date    : 
    Version : 2.0

.DESCRIPTION
    Ce script permet d'exporter les configurations DHCP d'un serveur, de les enregistrer dans une structure organisée par date, 
    et de supprimer les sauvegardes dépassant une limite de temps configurable (par défaut : 15 jours).

.NOTES
    Prérequis :
    - Module PowerShell installé pour l'export DHCP.
    - Accès en écriture au chemin de sauvegarde spécifié.
.Licence :
    GNU General Pulic Licence V3.0
    https://github.com/Valceen/
#>

Write-Host "=========================== Déclaration des variables ============================" -ForegroundColor Green

$ComputerDHCP = "$env:ComputerName"  # Nom du serveur DHCP
$BackupServer = "\\SERVER\Backup\DHCP"  # Chemin vers le dossier de sauvegarde
$BackupFolderDate = "$BackupServer\$((Get-Date).ToString('yyyy-MM-dd'))"
$DeleteFolderFiles = (Get-Date).AddDays(-15)  # Supprime les sauvegardes âgées de plus de 15 jours

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Création des dossiers ================================" -ForegroundColor Green

# Création des dossiers si inexistant
@( $BackupServer, $BackupFolderDate ) | ForEach-Object {
    If (!(Test-Path $_)) {
        New-Item $_ -Type Directory | Out-Null
    }
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Sauvegarde DHCP ======================================" -ForegroundColor Green

# Exporter la configuration DHCP dans un fichier XML
Try {
    Export-DhcpServer -ComputerName "$ComputerDHCP" -Leases -File "$BackupFolderDate\DHCPConf.xml" -Verbose
    Write-Host "Sauvegarde DHCP réussie !" -ForegroundColor Green
} Catch {
    Write-Host "Erreur lors de la sauvegarde DHCP : $_" -ForegroundColor Red
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Suppression des anciennes sauvegardes ==================" -ForegroundColor Green

# Supprimer les anciennes sauvegardes
Try {
    Get-ChildItem $BackupServer | Where-Object {$_.LastWriteTime -lt $DeleteFolderFiles} | Remove-Item -Confirm:$False -Recurse -Force
    Write-Host "Anciennes sauvegardes supprimées avec succès !" -ForegroundColor Green
} Catch {
    Write-Host "Erreur lors de la suppression des anciennes sauvegardes : $_" -ForegroundColor Red
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""
