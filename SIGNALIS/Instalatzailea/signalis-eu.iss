#define MyAppName "SIGNALIS euskaraz"
#define MyAppFilesystemName "SIGNALIS euskaraz"
#define MyAppVersion "2.4"
#define MyAppPublisher "ibaios.eus"
#define MyAppURL "https://ibaios.eus/"
#define MyAppIcon "signalis-eu.ico"
#define MyAppImage "signalis-eu-instalazioa.bmp"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{DC314B91-42D0-41CA-9755-014184E6795A}
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
Source: "..\..\..\itzultool\bin\release\net6.0\win-x64\publish\itzultool-0.4-win-x64.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "signalis-eu-es.emip"; DestDir: "{app}"; Flags: ignoreversion
Source: "signalis-eu-fr.emip"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "{app}\itzultool-0.4-win-x64.exe"; Parameters: "decompress ""{code:GetSelectedGameDataDir}\data.unity3d"""
Filename: "{app}\itzultool-0.4-win-x64.exe"; Parameters: "extractassets ""{code:GetSelectedGameDataDir}\data.unity3d.decomp"" resources.assets"
Filename: "{app}\itzultool-0.4-win-x64.exe"; Parameters: "applyemip ""{app}\{code:GetSelectedEmip}"" ""{code:GetSelectedGameDataDir}"""
Filename: "{cmd}"; Parameters: "/C del /f  ""{code:GetSelectedGameDataDir}\resources.assets.bak0000"""
Filename: "{app}\itzultool-0.4-win-x64.exe"; Parameters: "replaceassets ""{code:GetSelectedGameDataDir}\data.unity3d.decomp"" ""{code:GetSelectedGameDataDir}\resources.assets"""
Filename: "{cmd}"; Parameters: "/C del  ""{code:GetSelectedGameDataDir}\resources.assets"""
Filename: "{cmd}"; Parameters: "/C move  ""{code:GetSelectedGameDataDir}\data.unity3d"" ""{code:GetSelectedGameDataDir}\data.unity3d.bak"""; Check: KeepOriginalBundleChecked
Filename: "{cmd}"; Parameters: "/C del  ""{code:GetSelectedGameDataDir}\data.unity3d"""; Check: Not KeepOriginalBundleChecked
Filename: "{app}\itzultool-0.4-win-x64.exe"; Parameters: "compress ""{code:GetSelectedGameDataDir}\data.unity3d.decomp"" ""{code:GetSelectedGameDataDir}\data.unity3d"""; Check: CompressBundleChecked
Filename: "{cmd}"; Parameters: "/C del  ""{code:GetSelectedGameDataDir}\data.unity3d.decomp"""; Check: CompressBundleChecked
Filename: "{cmd}"; Parameters: "/C move  ""{code:GetSelectedGameDataDir}\data.unity3d.decomp"" ""{code:GetSelectedGameDataDir}\data.unity3d"""; Check: Not CompressBundleChecked

[Code]
var
  GameDataDirPage: TInputDirWizardPage;
  AdditionalOptionsPage: TInputQueryWizardPage;
  LanguageComboBox: TNewComboBox;
  CompressBundleCheckBox: TNewCheckBox;
  KeepOriginalBundleCheckBox: TNewCheckBox;


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
  GamePath := FindGamePathInList(GetSteamLibraryPaths(), '\steamapps\common\' + 'SIGNALIS\SIGNALIS_Data');  
  
  if GamePath = '' then
  begin
    // GOG Galaxy
    GamePath := FindGamePathInList(GetGOGPaths(), 'SIGNALIS\SIGNALIS_Data');
  
    if GamePath = '' then
    begin
      
      // Program Files

      if DirExists(ExpandConstant('{autopf}') + 'SIGNALIS\SIGNALIS_Data') then
        GamePath := ExpandConstant('{autopf}') + 'SIGNALIS\SIGNALIS_Data';
  
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
    'Hautatu "SIGNALIS" jokoaren datuen karpeta non dagoen.'
    + #13#10#13#10 + 'Instalazioa automatikoki antzematen saiatuko da, baina ez badu lortzen, zuk bete beharko duzu.'
    + #13#10#13#10 + 'Aurkitu jokoaren karpeta nagusia (''SIGNALIS''), eta aukeratu honen barruan dagoen ''SIGNALIS_Data'' izeneko karpeta.',
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

  CompressBundleCheckBox := TNewCheckBox.Create(AdditionalOptionsPage);
  CompressBundleCheckBox.Parent := AdditionalOptionsPage.Surface;
  CompressBundleCheckBox.Anchors := [akLeft, akRight, akBottom];
  CompressBundleCheckBox.Height := ScaleY(36);
  CompressBundleCheckBox.Top := LanguageComboBox.Top + LanguageComboBox.Height + ScaleY(8);
  CompressBundleCheckBox.Width := AdditionalOptionsPage.SurfaceWidth;
  CompressBundleCheckBox.Caption := 'Amaieran bundlea &konprimatu (diskoan leku gutxiago hartuko du, baina konprimatzeko prozesua motela da, 5min inguru).';

  KeepOriginalBundleCheckBox := TNewCheckBox.Create(AdditionalOptionsPage);
  KeepOriginalBundleCheckBox.Parent := AdditionalOptionsPage.Surface;
  KeepOriginalBundleCheckBox.Anchors := [akLeft, akRight, akBottom];
  KeepOriginalBundleCheckBox.Height := ScaleY(36);
  KeepOriginalBundleCheckBox.Top := CompressBundleCheckBox.Top + CompressBundleCheckBox.Height + ScaleY(8);
  KeepOriginalBundleCheckBox.Width := AdditionalOptionsPage.SurfaceWidth;
  KeepOriginalBundleCheckBox.Caption := 'Jatorrizko bundlea &gorde (diskoan lekua hartuko du, eta denda gehienetan erraza da jokoa berrinstalatzea arazorik badago).';
  
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

  // Choose to compress in the end or not
  Result := Result + 'Amaieran bundlea konprimatu:'
    + NewLine + Space;
  if CompressBundleCheckBox.Checked then
    Result:= Result + 'Bai'
  else
    Result:= Result + 'Ez';

  Result:= Result + NewLine + NewLine;

  // Choose to keep original bundle or not
  Result := Result + 'Jatorrizko bundlea gorde:'
    + NewLine + Space;
  if KeepOriginalBundleCheckBox.Checked then
    Result:= Result + 'Bai'
  else
    Result:= Result + 'Ez';

  Result:= Result + NewLine + NewLine;

end;

function GetSelectedGameDataDir(Param: string): string;
begin
  Result:= GameDataDirPage.Values[0];
end;

function GetSelectedEmip(Param: string): string;
begin
  if LanguageComboBox.ItemIndex = 0 then
    Result := 'signalis-eu-es.emip'
  else
    Result := 'signalis-eu-fr.emip';
end;

function CompressBundleChecked: Boolean;
begin
  Result := CompressBundleCheckBox.Checked;
end;

function KeepOriginalBundleChecked: Boolean;
begin
  Result := KeepOriginalBundleCheckBox.Checked;
end;