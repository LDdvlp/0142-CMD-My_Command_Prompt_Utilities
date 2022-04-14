@ECHO OFF
REM @ECHO OFF en ligne 1 pour désactiver l' écho
REM et l'affichage de l'invite de commandes,
REM avec @ pour ne pas afficher la commande ECHO OFF elle même.

REM *****************************************************************************************************************************************
REM
REM ___  ___        _____                                           _  ______                          _     _   _ _   _ _ _ _   _            
REM |  \/  |       /  __ \                                         | | | ___ \                        | |   | | | | | (_) (_) | (_)           
REM | .  . |_   _  | /  \/ ___  _ __ ___  _ __ ___   __ _ _ __   __| | | |_/ / __ ___  _ __ ___  _ __ | |_  | | | | |_ _| |_| |_ _  ___  ___  
REM | |\/| | | | | | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` | |  __/ '__/ _ \| '_ ` _ \| '_ \| __| | | | | __| | | | __| |/ _ \/ __| 
REM | |  | | |_| | | \__/\ (_) | | | | | | | | | | | (_| | | | | (_| | | |  | | | (_) | | | | | | |_) | |_  | |_| | |_| | | | |_| |  __/\__ \ 
REM \_|  |_/\__, |  \____/\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_| \_|  |_|  \___/|_| |_| |_| .__/ \__|  \___/ \__|_|_|_|\__|_|\___||___/ 
REM          __/ |                                                                              | |                                           
REM         |___/                                                                               |_|                                           
REM
REM *****************************************************************************************************************************************

REM Récupération du code page actuel dans une variable,
REM généralement 850 pour encodage en Multilingual (Latin I)
REM Stockage de la sortie de commande CHCP dans une variable avec une boucle FOR
REM IMPORTANT !!! : en invite de commande, mettre %a et dans un fichier mettre %%a
REM CHCP : CHange Code Page
FOR /F "usebackq delims==" %%a IN (`CHCP`) DO SET OLDCHCP=%%a

REM Changement du Code Page en 65001 pour encodage en UTF-8 (universel, surtout pour les accents)
SET NEWCHCP=65001
CHCP %NEWCHCP%

:startmenu
COLOR 1B
CLS
ECHO.
GOTO menu1 

:menu1
ECHO    **********************
ECHO    *   Utilities Menu   *
ECHO    **********************
ECHO.
ECHO    ----------------------
ECHO    01. Windows Version                                     - (Window)
ECHO    02. Windows Informations                                - (Prompt)
ECHO    03. System Informations                                 - (Window)
ECHO    04. System Informations                                 - (Prompt)
ECHO    05. List Temp Directory                                 - (Prompt)
ECHO    06. Empty Temp Directory Content - [Admin Only Started] - (Prompt)
ECHO    07. Windows User Accounts                               - (Window)
ECHO    08. Windows Applications                                - (Window)
ECHO    09. Windows Printers                                    - (Window)
ECHO    10. WiFi Keys                                           - (Prompt)
ECHO    11. DirectX Diagnostic Tool, DxDiag                     - (Window)
ECHO    12. Désinstaller ou modifier un programme               - (Window)
ECHO    13. Informations d’identification stockées              - (Prompt)
ECHO    14. Code Page - Encodage du texte affiché               - (Prompt)
ECHO    ----------------------
ECHO    99. Backend
ECHO    ----------------------
ECHO    00. Quit
ECHO.

SET /p choice1=Enter your choice : 

IF /I "%choice1%"=="01" (GOTO winver)
IF /I "%choice1%"=="02" (GOTO wininfos)
IF /I "%choice1%"=="03" (GOTO msinfos)
IF /I "%choice1%"=="04" (GOTO sysinfos)
IF /I "%choice1%"=="05" (GOTO listtempdir)
IF /I "%choice1%"=="06" (GOTO emptytempdir)
IF /I "%choice1%"=="07" (GOTO winuseraccounts)
IF /I "%choice1%"=="08" (GOTO winapps)
IF /I "%choice1%"=="09" (GOTO winprinters)
IF /I "%choice1%"=="10" (GOTO wifikeys)
IF /I "%choice1%"=="11" (GOTO dxdiag)
IF /I "%choice1%"=="12" (GOTO appwiz)
IF /I "%choice1%"=="13" (GOTO cmdkeylist)
IF /I "%choice1%"=="14" (GOTO chcp)
IF /I "%choice1%"=="99" (GOTO backendmenu)
IF /I "%choice1%"=="00" (GOTO quitmenu)

GOTO startmenu

:: 001 - Display Windows Version
:winver
winver
GOTO startmenu

:: 002 - Display Windows Informations
:wininfos
COLOR 1F
CLS
ECHO.
ECHO    ****************************
ECHO    *   Windows Informations   *
ECHO    ****************************
ECHO.
ECHO    Computer Name          : %COMPUTERNAME%
ECHO    User Name              : %USERNAME%
ECHO    ComSpec                : %ComSpec%
ECHO    (COMmand interpreter SPECification)
ECHO    Temporary Files (TEMP) : %TEMP%
ECHO    Temporary Files (TMP)  : %TMP%
CALL :whenready
GOTO startmenu

:: 003 - Display System Informations (Window)
:msinfos
msinfo32
GOTO startmenu

:: 004 - Display System Informations (Prompt)
:sysinfos
COLOR 1F
CLS
systeminfo
CALL :whenready
GOTO startmenu

:: 005 - List Temp Directory
:listtempdir
COLOR 1F
CLS
DIR %TEMP%
CALL :whenready
GOTO startmenu

:: 006 - Empty Temp Directory
:emptytempdir
COLOR 1F
CLS
DEL /Q/F/S %TEMP%\*
CALL :whenready
GOTO startmenu

:: 007 - Display Windows User Accounts
:winuseraccounts
netplwiz 
GOTO startmenu

:: 008 - Display Windows Applications
:winapps
explorer shell:AppsFolder
GOTO startmenu

:: 009 - Display Windows Printers
:winprinters
start shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{2227A280-3AEA-1069-A2DE-08002B30309D}
GOTO startmenu

:: 010 - Display the WiFi
:wifikeys
COLOR 34
CLS
ECHO.
ECHO ***************************************************
ECHO *   SSID List (Service Set Identifier : Wifi) :   *
ECHO ***************************************************
netsh wlan show profile
set /p ssidname=Enter SSID : 
ECHO.
ECHO **********************   SSID : %ssidname% **********************
netsh wlan show profile %ssidname% key=clear
CALL :whenready
GOTO startmenu

:: 011 - Display DxDiag
:dxdiag
dxdiag 
GOTO startmenu

:: 012 - Désinstaller ou modifier un programme
:appwiz
appwiz.cpl
GOTO startmenu

:: 013 - Informations d’identification actuellement stockées
:cmdkeylist
COLOR 1F
CLS
ECHO.
ECHO    ***********************************************
ECHO    *   Informations d’identification  stockées   *
ECHO    ***********************************************
ECHO.
cmdkey /list
CALL :whenready
GOTO startmenu

:: 014 - Informations d’identification actuellement stockées
:chcp
COLOR 1F
CLS
ECHO.
ECHO    *****************************************************************
ECHO    *   Encodage du texte affiché avant le démarrage du programme   *
ECHO    *****************************************************************
ECHO.
ECHO    %OLDCHCP%
ECHO.
ECHO    ******************************************
ECHO    *   Encodage du texte affiché en cours   *
ECHO    ******************************************
ECHO.
ECHO    Page de codes active : %NEWCHCP%
ECHO.
CALL :whenready

GOTO startmenu

:: 099 - Backend
:backendmenu
COLOR 4E
CLS 
ECHO.
GOTO menu2

:menu2
ECHO    **********************
ECHO    *   Backend Menu   *
ECHO    **********************
ECHO.
ECHO    ----------------------
ECHO    1. Dos Colors
ECHO    ----------------------
ECHO    0. Return to main menu
ECHO.

SET /p choice2=Enter your choice : 

IF /I "%choice2%"=="1" (GOTO doscolors)
IF /I "%choice2%"=="0" (GOTO startmenu)

GOTO backendmenu

:: 099-1 - DOS Colors
:doscolors
SET BG=9
SET FG=0
COLOR %BG%%FG%
CLS
ECHO.
ECHO    *********************
ECHO    *    Color Codes    *
ECHO    *********************
ECHO.
ECHO    COLOR BackgroundForeground
ECHO    COLOR %BG%%FG%
ECHO.
ECHO    0   -   Black          -   Noir 
ECHO    1   -   Blue           -   Bleu fonce
ECHO    2   -   Green          -   Vert
ECHO    3   -   Aqua           -   Bleu gris
ECHO    4   -   Red            -   Marron
ECHO    5   -   Purple         -   Pourpre
ECHO    6   -   Yellow         -   Kaki
ECHO    7   -   White          -   Gris clair
ECHO    8   -   Gray           -   Gris
ECHO    9   -   Light Blue     -   Bleu clair
ECHO    A   -   Light Green    -   Vert clair
ECHO    B   -   Light Aqua     -   Cyan
ECHO    C   -   Light Red      -   Rouge
ECHO    D   -   Light Purple   -   Rose
ECHO    E   -   Light Yellow   -   Jaune
ECHO    F   -   Bright White   -   Blanc
CALL :whenready

GOTO backendmenu

:whenready
ECHO.
ECHO    --------------------------- 
ECHO    Strike a key when ready ...
ECHO    --------------------------- 
PAUSE > NUL
EXIT /B

:: 000 - Quit Menu
:quitmenu
CLS
ECHO.
ECHO See you soon !!! Stay tuned :-)
ECHO.
COLOR