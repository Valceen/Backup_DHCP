## SYNOPSIS
Effectue une sauvegarde de la configuration d'un DHCP et gère leur rétention.<br>
Date    : 2025-04-29<br>
Version : 2.0<br>

## DESCRIPTION
Sauvegarde la configuration d'un serveur DHCP dans un dossier nommé par la date du jour.<br>
Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.<br>

## PREREQUIS
Droits adéquats pour effectuer des sauvegardes.<br>

## FONCTIONNEMENT
- Changer le nom du serveur :<br>
$BackupServer = "\\\\SERVER"<br>
- Fait un sauvegarde dans le répertoire :<br> 
\\\\SERVEUR\\DHCP\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)<br>
Exemple :<br>
\\\\NAS01\\Backup\\DHCP\\DC01\\2025-04-29<br>
- Supprime toutes les sauvegardes de plus 15 jours :<br>
$DeleteFolderFiles = (Get-Date).AddDays(-15)## SYNOPSIS
<br>

## RECOMMANDATION
Fonctionne trés bien avec un compte Gmsa (Group Managed Service Accounts)<br>

Nécéssite :<br>
- droits sur le répertoire de sauvegarde<br>
- membre du groupe Backup Operators<br>

et les droits de la GPO :<br>
- Accéder a cet ordinateur a partir du réseau<br>
- Ouvrir une session en tant que service<br>
- Ouvrir une session en tant que tache<br>
- sauvegarder les fichiers et les répertoires<br>

## Licence
GNU General Public Licence V3.0
https://github.com/Valceen/
