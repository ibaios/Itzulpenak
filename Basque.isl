; *** Inno Setup version 6.1.0+ English messages ***
;
; To download user-contributed translations of this file, go to:
;   https://jrsoftware.org/files/istrans/
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).

[LangOptions]
; The following three entries are very important. Be sure to read and 
; understand the '[LangOptions] section' topic in the help file.
LanguageName=Euskara
LanguageID=$042d
LanguageCodePage=0
; If the language you are translating to requires special font faces or
; sizes, uncomment any of the following entries and change them accordingly.
;DialogFontName=
;DialogFontSize=8
;WelcomeFontName=Verdana
;WelcomeFontSize=12
;TitleFontName=Arial
;TitleFontSize=29
;CopyrightFontName=Arial
;CopyrightFontSize=8

[Messages]

; *** Application titles
SetupAppTitle=Instalazioa
SetupWindowTitle=Instalazioa - %1
UninstallAppTitle=Desinstalazioa
UninstallAppFullTitle=Desinstalazioa - %1

; *** Misc. common
InformationTitle=Informazioa
ConfirmTitle=Berretsi
ErrorTitle=Errorea

; *** SetupLdr messages
SetupLdrStartupMessage=Honek %1 instalatuko du. Jarraitu nahi duzu?
LdrCannotCreateTemp=Ezin izan da aldi baterako fitxategia sortu. Instalazioa bertan behera utzia
LdrCannotExecTemp=Ezin izan da aldi baterako karpetako fitxategia exekutatu. Instalazioa bertan behera utzia
HelpTextNote=

; *** Startup error messages
LastErrorMessage=%1.%n%n%2 errorea: %3
SetupFileMissing=Ez da %1 fitxategia aurkitu instalazio direktorioan. Konpondu arazoa edo eskuratu programaren kopia berri bat.
SetupFileCorrupt=Instalazio-fitxategiak kaltetuta daude. Eskuratu programaren kopia berri bat.
SetupFileCorruptOrWrongVer=Instalazio-fitxategiak kaltetuta daude, edo ez dira instalatzailearen bertsio honekin bateragarriak. Konpondu arazoa edo eskuratu programaren kopia berri bat.
InvalidParameter=Parametro baliogabea pasa da agindu-lerroan:%n%n%1
SetupAlreadyRunning=Instalazioa dagoeneko martxan da.
WindowsVersionNotSupported=Programa hau ez da ordenagailuan exekutatzen ari den Windows bertsioarekin bateragarria.
WindowsServicePackRequired=Programa honek %1 Service Pack %2 edo berriagoa behar du.
NotOnThisPlatform=This program will not run on %1.
OnlyOnThisPlatform=This program must be run on %1.
OnlyOnTheseArchitectures=This program can only be installed on versions of Windows designed for the following processor architectures:%n%n%1
WinVersionTooLowError=This program requires %1 version %2 or later.
WinVersionTooHighError=This program cannot be installed on %1 version %2 or later.
AdminPrivilegesRequired=You must be logged in as an administrator when installing this program.
PowerUserPrivilegesRequired=You must be logged in as an administrator or as a member of the Power Users group when installing this program.
SetupAppRunningError=Setup has detected that %1 is currently running.%n%nPlease close all instances of it now, then click OK to continue, or Cancel to exit.
UninstallAppRunningError=Uninstall has detected that %1 is currently running.%n%nPlease close all instances of it now, then click OK to continue, or Cancel to exit.

; *** Startup questions
PrivilegesRequiredOverrideTitle=Hautatu instalazio modua
PrivilegesRequiredOverrideInstruction=Hautatu instalazio modua
PrivilegesRequiredOverrideText1=%1 erabiltzaile guztientzat instala daiteke (administrazio baimenak behar dira), edo zuretzat soilik.
PrivilegesRequiredOverrideText2=%1 zuretzat soilik instala daiteke, edo erabiltzaile guztientzat (administrazio baimenak behar dira).
PrivilegesRequiredOverrideAllUsers=Instalatu erabiltzaile &guztientzat
PrivilegesRequiredOverrideAllUsersRecommended=Instalatu erabiltzaile &guztientzat (gomendatua)
PrivilegesRequiredOverrideCurrentUser=Instalatu &niretzat soilik
PrivilegesRequiredOverrideCurrentUserRecommended=Instalatu &niretzat soilik (gomendatua)

; *** Misc. errors
ErrorCreatingDir=Instalatzaileak ezin izan du "%1" direktorioa sortu
ErrorTooManyFilesInDir=Ezin izan da fitxategirik sortu "%1" direktorioan fitxategi gehiegi dituelako

; *** Setup common messages
ExitSetupTitle=Irten instalaziotik
ExitSetupMessage=Instalazioa osatu gabe dago. Orain irteten bazara, programa ez da instalatuko.%n%nAurrerago berriro exekuta dezakezu instalatzailea, eta instalazioa osatu.%n%nInstalaziotik irten?
AboutSetupMenuItem=Instalazioari &buruz...
AboutSetupTitle=Instalazioari buruz
AboutSetupMessage=%1 %2 bertsioa%n%3%n%n%1 webgunea:%n%4
AboutSetupNote=
TranslatorNote=

; *** Buttons
ButtonBack=< &Aurrekoa
ButtonNext=&Hurrengoa >
ButtonInstall=&Instalatu
ButtonOK=Ados
ButtonCancel=Utzi
ButtonYes=&Bai
ButtonYesToAll=Bai &guztiari
ButtonNo=&Ez
ButtonNoToAll=E&z guztiari
ButtonFinish=A&maitu
ButtonBrowse=A&rakatu...
ButtonWizardBrowse=A&rakatu...
ButtonNewFolder=&Sortu karpeta berria

; *** "Select Language" dialog messages
SelectLanguageTitle=Hautatu instalaziorako hizkuntza
SelectLanguageLabel=Hautatu instalazioa burutzeko erabiliko den hizkuntza.

; *** Common wizard text
ClickNext=Egin klik Hurrengoan jarraitzeko, edo Utzi instalaziotik irteteko.
BeveledLabel=
BrowseDialogTitle=Arakatu karpeta bila
BrowseDialogLabel=Hautatu karpeta bat azpiko zerrendatik, eta gero sakatu Ados.
NewFolderName=Karpeta berria

; *** "Welcome" wizard page
WelcomeLabel1=Ongi etorri "[name]" aplikazioaren instalazio-laguntzailera
WelcomeLabel2=Programa honek [name/ver] instalatuko du ordenagailuan.%n%nJarraitu aurretik, gainontzeko aplikazioak ixtea gomendatzen da.

; *** "Password" wizard page
WizardPassword=Pasahitza
PasswordLabel1=Instalazio hau pasahitz bidez babesturik dago.
PasswordLabel3=Sartu pasahitza, gero sakatu Hurrengoa jarraitzeko. Pasahitzetan maiuskula/minuskula bereizten da.
PasswordEditLabel=&Pasahitza:
IncorrectPassword=Sartutako pasahitza ez da zuzena. Saiatu berriro.

; *** "License Agreement" wizard page
WizardLicense=Lizentziaren onarpena
LicenseLabel=Irakurri ondorengo informazio garrantzitsua jarraitu aurretik.
LicenseLabel3=Irakurri ondorengo Lizentziaren onarpena. Instalazioarekin jarraitu aurretik lizentziaren baldintzak onartu behar dituzu.
LicenseAccepted=Baldintzak &onartzen ditut
LicenseNotAccepted=&Ez ditut baldintzak onartzen

; *** "Information" wizard pages
WizardInfoBefore=Informazioa
InfoBeforeLabel=Irakurri ondorengo informazio garrantzitsu hau jarraitu aurretik.
InfoBeforeClickLabel=Instalazioarekin jarraitzeko prest egotean, sakatu Hurrengoa.
WizardInfoAfter=Informazioa
InfoAfterLabel=Irakurri ondorengo informazio garrantzitsua jarraitu aurretik.
InfoAfterClickLabel=Instalazioarekin jarraitzeko prest egotean, sakatu Hurrengoa.

; *** "User Information" wizard page
WizardUserInfo=Erabiltzailearen datuak
UserInfoDesc=Sartu zure informazioa.
UserInfoName=Erabiltzaile-&izena:
UserInfoOrg=&Erakundea:
UserInfoSerial=&Serie-zenbakia:
UserInfoNameRequired=Izena sartu behar duzu.

; *** "Select Destination Location" wizard page
WizardSelectDir=Hautatu helburuko kokalekua
SelectDirDesc=Non instalatu behar da "[name]"?
SelectDirLabel3=Instalatzaileak "[name]" ondorengo karpetan instalatuko du.
SelectDirBrowseLabel=Jarraitzeko, sakatu Hurrengoa. Beste karpeta bat hautatu nahi baduzu, sakatu Arakatu.
DiskSpaceGBLabel=Gutxienez [gb] GB libre behar dira diskoan.
DiskSpaceMBLabel=Gutxienez [mb] MB libre behar dira diskoan.
CannotInstallToNetworkDrive=Instalatzaileak ezin du sareko unitate batean instalatu.
CannotInstallToUNCPath=Instalatzaileak ezin du UNC bide-izen batean instalatu.
InvalidPath=You must enter a full path with drive letter; for example:%n%nC:\APP%n%nor a UNC path in the form:%n%n\\server\share
InvalidDrive=The drive or UNC share you selected does not exist or is not accessible. Please select another.
DiskSpaceWarningTitle=Not Enough Disk Space
DiskSpaceWarning=Setup requires at least %1 KB of free space to install, but the selected drive only has %2 KB available.%n%nDo you want to continue anyway?
DirNameTooLong=The folder name or path is too long.
InvalidDirName=The folder name is not valid.
BadDirName32=Folder names cannot include any of the following characters:%n%n%1
DirExistsTitle=Karpeta existitzen da
DirExists=The folder:%n%n%1%n%nalready exists. Would you like to install to that folder anyway?
DirDoesntExistTitle=Folder Does Not Exist
DirDoesntExist=The folder:%n%n%1%n%ndoes not exist. Would you like the folder to be created?

; *** "Select Components" wizard page
WizardSelectComponents=Hautatu osagaiak
SelectComponentsDesc=Zein osagai instalatu beharko lirateke?
SelectComponentsLabel2=Aukeratu zein osagai instala daitezen nahi duzun; desautatu instalatu nahi ez dituzunak. Sakatu Hurrengoa jarraitzeko prest egotean.
FullInstallation=Instalazio osoa
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=Instalazio konpaktua
CustomInstallation=Instalazio pertsonalizatua
NoUninstallWarningTitle=Osagaiak existitzen dira
NoUninstallWarning=Instalazioak antzeman du hurrengo osagaiok dagoeneko ordenagailuan instalatuta daudela:%n%n%1%n%nOsagaiok desautatuz gero, ez dira desinstalatuko.%n%nAurrera jarraitu nahi duzu?
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceGBLabel=Uneko hautapenak gutxienez [gb] GB libre behar ditu diskoan.
ComponentsDiskSpaceMBLabel=Uneko hautapenak gutxienez [mb] MB libre behar ditu diskoan.

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=Hautatu ataza gehigarriak
SelectTasksDesc=Zein ataza gehigarri burutu beharko lirateke?
SelectTasksLabel2=Aukeratu instalazioak "[name]" instalatu bitartean zein ataza gehigarri burutu ditzan nahi duzun; [name], eta sakatu Hurrengoa.

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=Hautatu Hasi menuko karpeta
SelectStartMenuFolderDesc=Where should Setup place the program's shortcuts?
SelectStartMenuFolderLabel3=Setup will create the program's shortcuts in the following Start Menu folder.
SelectStartMenuFolderBrowseLabel=To continue, click Next. If you would like to select a different folder, click Browse.
MustEnterGroupName=You must enter a folder name.
GroupNameTooLong=The folder name or path is too long.
InvalidGroupName=The folder name is not valid.
BadGroupName=The folder name cannot include any of the following characters:%n%n%1
NoProgramGroupCheck2=&Ez sortu Hasi menuko karpetarik

; *** "Ready to Install" wizard page
WizardReady=Instalatzeko prest
ReadyLabel1=Instalazioa prest dago "[name]" ordenagailuan instalatzeko.
ReadyLabel2a=Sakatu Instalatu instalazioarekin jarraitzeko, edo sakatu Atzera ezarpenak berrikusi edo aldatzeko.
ReadyLabel2b=Sakatu Instalatu instalazioarekin jarraitzeko.
ReadyMemoUserInfo=Erabiltzaile-informazioa:
ReadyMemoDir=Helburuko kokalekua:
ReadyMemoType=Instalazio mota:
ReadyMemoComponents=Hautatutako osagaiak:
ReadyMemoGroup=Hasi menuko karpeta:
ReadyMemoTasks=Ataza gehigarriak:

; *** TDownloadWizardPage wizard page and DownloadTemporaryFile
DownloadingLabel=Fitxategi gehigarriak deskargatzen...
ButtonStopDownload=&Gelditu deskarga
StopDownload=Ziur deskarga geldiarazi nahi duzula?
ErrorDownloadAborted=Deskarga bertan behera utzia
ErrorDownloadFailed=Deskargak huts egin du: %1 %2
ErrorDownloadSizeFailed=Tamaina eskuratzeak huts egin du: %1 %2
ErrorFileHash1=Fitxategiaren hash-ak huts egin du: %1
ErrorFileHash2=Okerreko fitxategiaren hash-a: %1 espero zen, %2 aurkitu da
ErrorProgress=Aurrerapen baliogabea: %1 / %2
ErrorFileSize=Fitxategi-tamaina baliogabea: %1 espero zen, %2 aurkitu da

; *** "Preparing to Install" wizard page
WizardPreparing=Instalatzeko prestatzen
PreparingDesc=Instalazioa [name] ordenagailuan instalatzeko prestatzen ari da.
PreviousInstallNotCompleted=The installation/removal of a previous program was not completed. You will need to restart your computer to complete that installation.%n%nAfter restarting your computer, run Setup again to complete the installation of [name].
CannotContinue=Setup cannot continue. Please click Cancel to exit.
ApplicationsFound=The following applications are using files that need to be updated by Setup. It is recommended that you allow Setup to automatically close these applications.
ApplicationsFound2=The following applications are using files that need to be updated by Setup. It is recommended that you allow Setup to automatically close these applications. After the installation has completed, Setup will attempt to restart the applications.
CloseApplications=&Automatically close the applications
DontCloseApplications=&Do not close the applications
ErrorCloseApplications=Setup was unable to automatically close all applications. It is recommended that you close all applications using files that need to be updated by Setup before continuing.
PrepareToInstallNeedsRestart=Setup must restart your computer. After restarting your computer, run Setup again to complete the installation of [name].%n%nWould you like to restart now?

; *** "Installing" wizard page
WizardInstalling=Instalatzen
InstallingLabel=Itxaron instalazioak "[name]" ordenagailuan instalatu artean.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=[name] programaren instalazioa burutu da
FinishedLabelNoIcons=Instalazioak burutu du "[name]" aplikazioa ordenagailuan instalatzeko prozesua.
FinishedLabel=Instalazioak burutu du "[name]" aplikazioa ordenagailuan instalatzeko prozesua. Aplikazioa abiaraz daiteke instalatutako lasterbideak erabiliz.
ClickFinish=Sakatu Amaitu instalaziotik irteteko.
FinishedRestartLabel="[name]" aplikazioaren instalazioa burutzeko ordenagailua berrabiarazi beharra dago. Orain berrabiarazi nahi duzu?
FinishedRestartMessage=[name]" aplikazioaren instalazioa burutzeko ordenagailua berrabiarazi beharra dago.%n%nOrain berrabiarazi nahi duzu?
ShowReadmeCheck=Bai, ikusi IRAKURRI fitxategia
YesRadio=&Bai, berrabiarazi ordenagailua orain
NoRadio=&Ez, ordenagailua geroago berrabiaraziko dut
; used for example as 'Run MyProg.exe'
RunEntryExec=Exekutatu %1
; used for example as 'View Readme.txt'
RunEntryShellExec=Ikusi %1

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=Setup Needs the Next Disk
SelectDiskLabel2=Please insert Disk %1 and click OK.%n%nIf the files on this disk can be found in a folder other than the one displayed below, enter the correct path or click Browse.
PathLabel=&Path:
FileNotInDir2=The file "%1" could not be located in "%2". Please insert the correct disk or select another folder.
SelectDirectoryLabel=Please specify the location of the next disk.

; *** Installation phase messages
SetupAborted=Setup was not completed.%n%nPlease correct the problem and run Setup again.
AbortRetryIgnoreSelectAction=Select action
AbortRetryIgnoreRetry=&Try again
AbortRetryIgnoreIgnore=&Ignore the error and continue
AbortRetryIgnoreCancel=Cancel installation

; *** Installation status messages
StatusClosingApplications=Aplikazioak ixten...
StatusCreateDirs=Direktorioak sortzen...
StatusExtractFiles=Fitxategiak erauzten...
StatusCreateIcons=Lasterbideak sortzen...
StatusCreateIniEntries=INI sarrerak sortzen...
StatusCreateRegistryEntries=Erregistroko sarrerak sortzen...
StatusRegisterFiles=Fitxategiak erregistratzen...
StatusSavingUninstall=Desinstalatzeko informazioa gordetzen...
StatusRunProgram=Instalazioa amaitzen...
StatusRestartingApplications=Aplikazioak berrabiarazten...
StatusRollback=Aldaketak desegiten...

; *** Misc. errors
ErrorInternal2=Barne-errorea: %1
ErrorFunctionFailedNoCode=%1(e)k huts egin du
ErrorFunctionFailed=%1(e)k huts egin du; %2 kodea
ErrorFunctionFailedWithMessage=%1(e)k huts egin du; %2 kodea.%n%3
ErrorExecutingProgram=Ezin izan da fitxategia exekutatu:%n%1

; *** Registry errors
ErrorRegOpenKey=Errorea erregistroko gakoa irekitzean:%n%1\%2
ErrorRegCreateKey=Errorea erregistroko gakoa sortzean:%n%1\%2
ErrorRegWriteKey=Errorea erregistroko gakoa idaztean:%n%1\%2

; *** INI errors
ErrorIniEntry=Errorea INI sarrera sortzean "%1" fitxategian.

; *** File copying errors
FileAbortRetryIgnoreSkipNotRecommended=&Skip this file (not recommended)
FileAbortRetryIgnoreIgnoreNotRecommended=&Ignore the error and continue (not recommended)
SourceIsCorrupted=The source file is corrupted
SourceDoesntExist=The source file "%1" does not exist
ExistingFileReadOnly2=The existing file could not be replaced because it is marked read-only.
ExistingFileReadOnlyRetry=&Remove the read-only attribute and try again
ExistingFileReadOnlyKeepExisting=&Keep the existing file
ErrorReadingExistingDest=An error occurred while trying to read the existing file:
FileExistsSelectAction=Select action
FileExists2=The file already exists.
FileExistsOverwriteExisting=&Overwrite the existing file
FileExistsKeepExisting=&Keep the existing file
FileExistsOverwriteOrKeepAll=&Do this for the next conflicts
ExistingFileNewerSelectAction=Select action
ExistingFileNewer2=The existing file is newer than the one Setup is trying to install.
ExistingFileNewerOverwriteExisting=&Overwrite the existing file
ExistingFileNewerKeepExisting=&Keep the existing file (recommended)
ExistingFileNewerOverwriteOrKeepAll=&Do this for the next conflicts
ErrorChangingAttr=An error occurred while trying to change the attributes of the existing file:
ErrorCreatingTemp=An error occurred while trying to create a file in the destination directory:
ErrorReadingSource=An error occurred while trying to read the source file:
ErrorCopying=An error occurred while trying to copy a file:
ErrorReplacingExistingFile=An error occurred while trying to replace the existing file:
ErrorRestartReplace=RestartReplace failed:
ErrorRenamingTemp=An error occurred while trying to rename a file in the destination directory:
ErrorRegisterServer=Unable to register the DLL/OCX: %1
ErrorRegSvr32Failed=RegSvr32 failed with exit code %1
ErrorRegisterTypeLib=Unable to register the type library: %1

; *** Uninstall display name markings
; used for example as 'My Program (32-bit)'
UninstallDisplayNameMark=%1 (%2)
; used for example as 'My Program (32-bit, Erabiltzaile guztientzat)'
UninstallDisplayNameMarks=%1 (%2, %3)
UninstallDisplayNameMark32Bit=32-bit
UninstallDisplayNameMark64Bit=64-bit
UninstallDisplayNameMarkAllUsers=Erabiltzaile guztientzat
UninstallDisplayNameMarkCurrentUser=Uneko erabiltzailearentzat

; *** Post-installation errors
ErrorOpeningReadme=An error occurred while trying to open the README file.
ErrorRestartingComputer=Setup was unable to restart the computer. Please do this manually.

; *** Uninstaller messages
UninstallNotFound=File "%1" does not exist. Cannot uninstall.
UninstallOpenError=File "%1" could not be opened. Cannot uninstall
UninstallUnsupportedVer=The uninstall log file "%1" is in a format not recognized by this version of the uninstaller. Cannot uninstall
UninstallUnknownEntry=An unknown entry (%1) was encountered in the uninstall log
ConfirmUninstall=Ziur "%1" eta bere osagai guztiak betiko ezabatu nahi dituzula?
UninstallOnlyOnWin64=This installation can only be uninstalled on 64-bit Windows.
OnlyAdminCanUninstall=This installation can only be uninstalled by a user with administrative privileges.
UninstallStatusLabel=Itxaron "%1" ordenagailutik desinstalatu bitartean.
UninstalledAll="%1" behar bezala desinstalatu da ordenagailutik.
UninstalledMost=%1 uninstall complete.%n%nSome elements could not be removed. These can be removed manually.
UninstalledAndNeedsRestart=To complete the uninstallation of %1, your computer must be restarted.%n%nWould you like to restart now?
UninstallDataCorrupted="%1" file is corrupted. Cannot uninstall

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=Ezabatu fitxategi partekatua?
ConfirmDeleteSharedFile2=The system indicates that the following shared file is no longer in use by any programs. Would you like for Uninstall to remove this shared file?%n%nIf any programs are still using this file and it is removed, those programs may not function properly. If you are unsure, choose No. Leaving the file on your system will not cause any harm.
SharedFileNameLabel=Fitxategi-izen:
SharedFileLocationLabel=Kokalekua:
WizardUninstalling=Desinstalatze-egoera
StatusUninstalling=%1 desinstalatzen...

; *** Shutdown block reasons
ShutdownBlockReasonInstallingApp=%1 instalatzen.
ShutdownBlockReasonUninstallingApp=%1 desinstalatzen.

; The custom messages below aren't used by Setup itself, but if you make
; use of them in your scripts, you'll want to translate them.

[CustomMessages]

NameAndVersion=%1 %2 bertsioa
AdditionalIcons=Lasterbide gehigarriak:
CreateDesktopIcon=Sortu &mahaigaineko lasterbidea
CreateQuickLaunchIcon=Sortu Abio &Bizkorreko lasterbidea
ProgramOnTheWeb=%1 sarean
UninstallProgram=Desinstalatu %1
LaunchProgram=Abiarazi %1
AssocFileExtension=&Lotu %1 %2 fitxategi-luzapenarekin
AssocingFileExtension=%1 %2 fitxategi-luzapenarekin lotzen...
AutoStartProgramGroupDescription=Abioa:
AutoStartProgram=Abiarazi %1 automatikoki
AddonHostProgramNotFound=%1 ezin izan da hautatutako karpetan aurkitu.%n%nAurrera jarraitu nahi duzu?
