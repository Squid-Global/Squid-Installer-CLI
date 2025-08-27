@echo off
setlocal

echo Please wait...

:: Dossier d'installation
set INSTALL_DIR="C:\Program Files\Squid"
set REPO_DIR=%INSTALL_DIR%\Squid-Installer-CLI

:: Vérifier que git est installé
where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Cant find Git (Git needs to be installed and in the PATH)
    pause
    exit /b 1
)

:: Créer le dossier parent si nécessaire
if not exist %INSTALL_DIR% (
    mkdir %INSTALL_DIR%
    if errorlevel 1 (
        echo [ERROR] Cant write the program.
        pause
        exit /b 1
    )
)

:: Vérifier si le repo existe déjà
if exist %REPO_DIR% (
    echo [INFO] Squid Installer is already installed.
    echo [INFO] Updating...
    cd /d %REPO_DIR%
    git pull
    if errorlevel 1 (
        echo [ERROR] Cant pull repo.
        pause
        exit /b 1
    )
) else (
    echo [INFO] Installing...
    cd /d %INSTALL_DIR%
    git clone https://github.com/Squid-Global/Squid-Installer-CLI
    if errorlevel 1 (
        echo [ERROR] Cant pull repo.
        pause
        exit /b 1
    )
)

:: Lancer le launcher dans une nouvelle fenetre
start "" "%REPO_DIR%\app\launcher.bat"
if errorlevel 1 (
    echo [ERROR] Cant start the program.
    pause
    exit /b 1
)

echo [FINISHED] Installation finished. Starting Installer...

:: Supprimer ce script (s'auto-destruction)
del "%~f0"

exit