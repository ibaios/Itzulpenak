#define MyAppName "Untitled Goose Game euskaraz"
#define MyAppFilesystemName "Untitled Goose Game euskaraz"
#define MyAppVersion "1.0"
#define MyAppPublisher "ibaios.eus"
#define MyAppGroupName "ibaios"
#define MyAppURL "https://ibaios.eus/"
#define MyAppIcon "untitled-goose-game-eu.ico"
#define MyAppImage "untitled-goose-game-eu-instalazioa.bmp"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{802C6A0D-28C5-4298-866D-EBA9BDCFE4DB}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\ibaios\{#MyAppFilesystemName}
DefaultGroupName=ibaios
SetupIconFile={#MyAppIcon}
WizardImageFile={#MyAppImage}
DisableWelcomePage=no
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename={#MyAppFilesystemName}
Compression=lzma
SolidCompression=yes
WizardSizePercent=150
WizardStyle=modern
SetupLogging=yes
  
[Languages]
Name: "basque"; MessagesFile: "..\..\..\Basque.isl"

[Files]
Source: "..\eu-es.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\eu-fr.json"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "{cmd}"; Parameters: "/C move  ""{code:GetSelectedGameDataDir}\StreamingAssets\StringTables\{code:GetSelectedLanguageFile}.json"" ""{code:GetSelectedGameDataDir}\StreamingAssets\StringTables\{code:GetSelectedLanguageFile}.json.bak"""
Filename: "{cmd}"; Parameters: "/C move  ""{app}\eu-{code:GetSelectedLanguageCode}.json"" ""{code:GetSelectedGameDataDir}\StreamingAssets\StringTables\{code:GetSelectedLanguageFile}.json"""

[Code]
var
  GameDataDirPage: TInputDirWizardPage;
  AdditionalOptionsPage: TInputQueryWizardPage;
  LanguageComboBox: TNewComboBox;

function ParseSteamConfig(FileName: string): TArrayOfString;
var
  Lines: TArrayOfString;
  Line: string;
  I: Integer;
  P: Integer;
  SteamLibraryPaths: TArrayOfString;
begin
  P := 0;
  LoadStringsFromFile(FileName, Lines);

  SetArrayLength(SteamLibraryPaths, GetArrayLength(Lines));

  for I := 0 to GetArrayLength(Lines) - 1 do
  begin
    Line := Trim(Lines[I]);
    if Copy(Line, 1, 6) = '"path"' then
    begin
      Delete(Line, 1, 6);
      Line := Trim(Line);
      Delete(Line, 1, 1);
      Delete(Line, Length(Line), 1);
      SteamLibraryPaths[P] := Line;
      P := P + 1;
    end;
  end;
  SetArrayLength(SteamLibraryPaths, P);
  Result := SteamLibraryPaths;
end;

function GetSteamLibraryPaths(): TArrayOfString;
var
  SteamLibraryPaths: TArrayOfString;
  SteamLibraryPathsConfig: string;
begin
  
  // Get Steam Library Paths
  SteamLibraryPathsConfig := ExpandConstant('{autopf}') + '\Steam\config\libraryfolders.vdf';
  if FileExists(SteamLibraryPathsConfig) then
    SteamLibraryPaths := ParseSteamConfig(SteamLibraryPathsConfig)
  else
  begin
    // Maybe it is in GNU/Linux with Wine
    SteamLibraryPathsConfig :=  'z:\home\' + ExpandConstant('{%username|DefaultValue}') + '\.steam\steam\config\libraryfolders.vdf';
    if FileExists(SteamLibraryPathsConfig) then
      SteamLibraryPaths := ParseSteamConfig(SteamLibraryPathsConfig);
    // Maybe it is Steam Deck
    SteamLibraryPathsConfig :=  'z:\home\deck\.steam\steam\config\libraryfolders.vdf';
    if FileExists(SteamLibraryPathsConfig) then
      SteamLibraryPaths := ParseSteamConfig(SteamLibraryPathsConfig)
  end;  

  if GetArrayLength(SteamLibraryPaths) = 0 then
  begin
    SetArrayLength(SteamLibraryPaths, 1);
    SteamLibraryPaths[0] := ExpandConstant('{autopf}') + '\Steam\';
  end;
  
  Result := SteamLibraryPaths 
end;

function GetGOGPaths(): TArrayOfString;
var
  GOGPaths: TArrayOfString;
begin
  
   if DirExists(ExpandConstant('{autopf}') + '\GOG Galaxy\Games\') then
  begin
    SetArrayLength(GOGPaths, GetArrayLength(GOGPaths) + 1);
    GOGPaths[GetArrayLength(GOGPaths) - 1] := ExpandConstant('{autopf}') + '\GOG Galaxy\Games\';
  end;

  if DirExists(ExpandConstant('{autopf}') + '\GOG Games\') then
  begin
    SetArrayLength(GOGPaths, GetArrayLength(GOGPaths) + 1);
    GOGPaths[GetArrayLength(GOGPaths) - 1] := ExpandConstant('{autopf}') + '\GOG Games\';
  end;

  Result := GOGPaths;
end;

function FindGamePathInList(PathList: TArrayOfString; PathSuffix: string): string;
var
  I: integer;
begin
  if GetArrayLength(PathList) > 0 then
  begin
    for I := 0 to GetArrayLength(PathList) - 1 do
    begin
      StringChangeEx(PathList[I], '\\', '\', True);
      if DirExists(PathList[I] + PathSuffix) then
        Result := PathList[I] + PathSuffix;
      end;
    end;
end;

function GetGamePath(): string;
var
  GamePath: string;
  
begin
  
  GamePath := '';

  // Steam
  GamePath := FindGamePathInList(GetSteamLibraryPaths(), '\steamapps\common\' + 'Untitled Goose Game\Untitled_Data');  
  
  if GamePath = '' then
  begin
    // GOG Galaxy
    GamePath := FindGamePathInList(GetGOGPaths(), 'Untitled Goose Game\Untitled_Data');
  
    if GamePath = '' then
    begin
      
      // Program Files

      if DirExists(ExpandConstant('{autopf}') + 'Untitled Goose Game\Untitled_Data') then
        GamePath := ExpandConstant('{autopf}') + 'Untitled Goose Game\Untitled_Data';
  
    end;
  end;
  
  Result := GamePath;
end;

procedure InitializeWizard;
var
  LanguageLabelStaticText: TNewStaticText;
begin
  GameDataDirPage := CreateInputDirPage(wpSelectDir,
    'Hautatu jokoaren karpeta',
    '',
    'Hautatu "Untitled Goose Game" jokoaren datuen karpeta non dagoen.'
    + #13#10#13#10 + 'Instalazioa automatikoki antzematen saiatuko da, baina ez badu lortzen, zuk bete beharko duzu.'
    + #13#10#13#10 + 'Aurkitu jokoaren karpeta nagusia (''Untitled Goose Game''), eta aukeratu honen barruan dagoen ''Untitled_Data'' izeneko karpeta.',
    False,'');
  
  GameDataDirPage.Add('Datuen &karpeta:');
  
  GameDataDirPage.Values[0] := GetGamePath();

  AdditionalOptionsPage := CreateInputQueryPage(GameDataDirPage.ID,
    'Hautatu ordezkatuko den hizkuntza',
    'Euskarazko itzulpena instalatu ahal izateko, beste hizkuntza bat kendu behar da.',
    'Euskara ezin denez hizkuntza gisa era egokian gehitu, beste hizkuntza bat gainidatziko da.'
    + #13#10#13#10 + 'Hautatu zein hizkuntzaren lekua hartuko duen euskarazko itzulpenak.'
    + #13#10#13#10 + 'Errazena jokoak une honetan darabilen hizkuntza ordezkatzea da. Horrela, instalazioa amaitu ondoren ez duzu beste ezer konfiguratu beharko, eta automatikoki euskaraz egongo da jokoa.');
  
  LanguageLabelStaticText := TNewStaticText.Create(AdditionalOptionsPage);
  LanguageLabelStaticText.Parent := AdditionalOptionsPage.Surface;
  LanguageLabelStaticText.Anchors := [akLeft, akRight, akBottom];
  LanguageLabelStaticText.Top := ScaleY(50);
  LanguageLabelStaticText.AutoSize := True;
  LanguageLabelStaticText.Caption := 'Ordezkatuko den &hizkuntza:';

  LanguageComboBox := TNewComboBox.Create(AdditionalOptionsPage);
  LanguageComboBox.Style := csDropDownList;
  LanguageComboBox.Parent := AdditionalOptionsPage.Surface;
  LanguageComboBox.Anchors := [akLeft, akRight, akBottom];
  LanguageComboBox.Top := LanguageLabelStaticText.Top + LanguageLabelStaticText.Height + ScaleY(8);
  LanguageComboBox.Width := AdditionalOptionsPage.SurfaceWidth;
  LanguageComboBox.Items.Add('Gaztelania');
  LanguageComboBox.Items.Add('Frantsesa');
  LanguageComboBox.ItemIndex := 0;
  
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: string): string;
begin
  Result := '';

  if MemoUserInfoInfo <> '' then begin
    Result := MemoUserInfoInfo + NewLine + NewLine;
  end;

  if MemoDirInfo <> '' then begin
    Result := Result + MemoDirInfo + NewLine + NewLine;
  end;

  if MemoTypeInfo <> '' then begin
    Result := Result + MemoTypeInfo + NewLine + NewLine;
  end;

  if MemoComponentsInfo <> '' then begin
    Result := Result + MemoComponentsInfo + NewLine + NewLine;
  end;

  if MemoGroupInfo <> '' then begin
    Result := Result + MemoGroupInfo + NewLine + NewLine;
  end;

  if MemoTasksInfo <> '' then begin
    Result := Result + MemoTasksInfo + NewLine + NewLine;
  end;

  // Add game data location info
  Result := Result + 'Jokoaren datuen karpeta:' 
    + NewLine + Space + GameDataDirPage.Values[0] + NewLine + NewLine;

  // Add replaced language info
  Result := Result + 'Ordezkatuko den hizkuntza:' 
    + NewLine + Space + LanguageComboBox.Items[LanguageComboBox.ItemIndex] + NewLine + NewLine;

end;

function GetSelectedGameDataDir(Param: string): string;
begin
  Result:= GameDataDirPage.Values[0];
end;

function GetSelectedLanguageCode(Param: string): string;
begin
  if LanguageComboBox.ItemIndex = 0 then
    Result := 'es'
  else
    Result := 'fr';
end;

function GetSelectedLanguageFile(Param: string): string;
begin
  if LanguageComboBox.ItemIndex = 0 then
    Result := 'spanish'
  else
    Result := 'french';
end;