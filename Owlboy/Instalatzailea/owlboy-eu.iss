#define MyAppName "Owlboy euskaraz"
#define MyAppFilesystemName "Owlboy euskaraz"
#define MyAppVersion "1.6"
#define MyAppPublisher "ibaios.eus"
#define MyAppGroupName "ibaios"
#define MyAppURL "https://ibaios.eus/"
#define MyAppIcon "owlboy-eu.ico"
#define MyAppImage "owlboy-eu-instalazioa.bmp"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B31A6027-7B0E-47D7-AD1A-0D995D87F441}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppGroupName}\{#MyAppFilesystemName}
DefaultGroupName={#MyAppGroupName}
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

  
[Languages]
Name: "basque"; MessagesFile: "..\..\..\Basque.isl"

[Files]
Source: "..\eu.csv"; DestDir: "{code:GetSelectedGameDataDir}\localizations"; Flags: ignoreversion
Source: "..\translations.csv"; DestDir: "{code:GetSelectedGameDataDir}\localizations"; Flags: ignoreversion
Source: "..\eu\*"; DestDir: "{code:GetSelectedGameDataDir}\localizations\eu"; Flags: ignoreversion recursesubdirs
Source: "..\flags\eu.png"; DestDir: "{code:GetSelectedGameDataDir}\localizations\flags"; Flags: ignoreversion
 
[Code]
var
  GameDataDirPage: TInputDirWizardPage;



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
  GamePath := FindGamePathInList(GetSteamLibraryPaths(), '\steamapps\common\' + 'Owlboy\data');  
  
  if GamePath = '' then
  begin
    // GOG Galaxy
    GamePath := FindGamePathInList(GetGOGPaths(), 'Owlboy\data');
  
    if GamePath = '' then
    begin
      
      // Program Files

      if DirExists(ExpandConstant('{autopf}') + 'Owlboy\data') then
        GamePath := ExpandConstant('{autopf}') + 'Owlboy\data';
  
    end;
  end;

  // Try with the demo
  if GamePath = '' then
  begin
    GamePath := FindGamePathInList(GetSteamLibraryPaths(), '\steamapps\common\' + 'Owlboy Demo\Data'); 
  end;

  Result := GamePath;
end;



procedure InitializeWizard;
begin
  GameDataDirPage := CreateInputDirPage(wpSelectDir,
    'Hautatu jokoaren karpeta',
    '',
    'Hautatu "Owlboy" jokoaren datuen karpeta non dagoen.'
    + #13#10#13#10 + 'Instalazioa automatikoki antzematen saiatuko da, baina ez badu lortzen, zuk bete beharko duzu.'
    + #13#10#13#10 + 'Aurkitu jokoaren karpeta nagusia (''Owlboy''), eta aukeratu honen barruan dagoen ''data'' izeneko karpeta.',
    False,'');
  
  GameDataDirPage.Add('Datuen &karpeta:');
  
  GameDataDirPage.Values[0] := GetGamePath();
  
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

end;



function GetSelectedGameDataDir(Param: string): string;
begin
  Result:= GameDataDirPage.Values[0];
end;
