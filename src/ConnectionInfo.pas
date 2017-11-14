unit ConnectionInfo;

interface

uses
    IniFiles
  ;

type
  IConnectionInfo = interface
    function GetDatabase: string;
    function GetHostname: string;
    function GetPassword: string;
    function GetPort: word;
    function GetUsername: string;
    function GetTablePreffix: string;
    procedure SetDatabase(const Value: string);
    procedure SetHostname(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: word);
    procedure SetUsername(const Value: string);
    procedure SetTablePreffix(const Value: string);
    property Hostname     : string read GetHostname     write SetHostname;
    property Port         : Word   read GetPort         write SetPort;
    property Database     : string read GetDatabase     write SetDatabase;
    property Username     : string read GetUsername     write SetUsername;
    property Password     : string read GetPassword     write SetPassword;
    property TablePreffix : string read GetTablePreffix write SetTablePreffix;
  end;

  TConnectionInfo = class(TInterfacedObject, IConnectionInfo)
  private const
    cSection      = 'Connection';
    cHostname     = 'Hostname';
    cPort         = 'Port';
    cDatabase     = 'Database';
    cUsername     = 'Username';
    cPassword     = 'Password';
    cTablePreffix = 'TablePreffix';
  private var
    FIni: TIniFile;
  private
    function GetDatabase: string;
    function GetHostname: string;
    function GetPassword: string;
    function GetPort: word;
    function GetUsername: string;
    function GetTablePreffix: string;
    procedure SetDatabase(const Value: string);
    procedure SetHostname(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: word);
    procedure SetUsername(const Value: string);
    procedure SetTablePreffix(const Value: string);
  public
    constructor Create(const ConfigurationFile: string);
    destructor Destroy; override;
    class function New(const ConfigurationFile: string): IConnectionInfo;
    property Hostname     : string read GetHostname     write SetHostname;
    property Port         : Word   read GetPort         write SetPort;
    property Database     : string read GetDatabase     write SetDatabase;
    property Username     : string read GetUsername     write SetUsername;
    property Password     : string read GetPassword     write SetPassword;
    property TablePreffix : string read GetTablePreffix write SetTablePreffix;
  end;

implementation

uses
    RO.TCryptString
  ;

{ TConnectionInfo }

constructor TConnectionInfo.Create(const ConfigurationFile: string);
begin
  FIni := TIniFile.Create(ConfigurationFile);
end;

destructor TConnectionInfo.Destroy;
begin
  FIni.Free;
  inherited;
end;

function TConnectionInfo.GetDatabase: string;
begin
  Result := FIni.ReadString(
    cSection,
    cDatabase,
    ''
  );
end;

function TConnectionInfo.GetHostname: string;
begin
  Result := FIni.ReadString(
    cSection,
    cHostname,
    ''
  );
end;

function TConnectionInfo.GetPassword: string;
begin
  Result := TCryptString.New(
    FIni.ReadString(
      cSection,
      cPassword,
      ''
    )
  )
    .Decrypt;
end;

function TConnectionInfo.GetPort: word;
begin
  Result := FIni.ReadInteger(
    cSection,
    cPort,
    3306
  );
end;

function TConnectionInfo.GetTablePreffix: string;
begin
  Result := FIni.ReadString(
    cSection,
    cTablePreffix,
    ''
  );
end;

function TConnectionInfo.GetUsername: string;
begin
  Result := FIni.ReadString(
    cSection,
    cUsername,
    ''
  );
end;

class function TConnectionInfo.New(
  const ConfigurationFile: string): IConnectionInfo;
begin
  Result := Create(ConfigurationFile);
end;

procedure TConnectionInfo.SetDatabase(const Value: string);
begin
  FIni.WriteString(
    cSection,
    cDatabase,
    Value
  );
end;

procedure TConnectionInfo.SetHostname(const Value: string);
begin
  FIni.WriteString(
    cSection,
    cHostname,
    Value
  );
end;

procedure TConnectionInfo.SetPassword(const Value: string);
begin
  FIni.WriteString(
    cSection,
    cPassword,
    TCryptString.New(
      Value
    ).Crypt
  );
end;

procedure TConnectionInfo.SetPort(const Value: word);
begin
  FIni.WriteInteger(
    cSection,
    cPort,
    Value
  );
end;

procedure TConnectionInfo.SetTablePreffix(const Value: string);
begin
  FIni.WriteString(
    cSection,
    cTablePreffix,
    Value
  );
end;

procedure TConnectionInfo.SetUsername(const Value: string);
begin
  FIni.WriteString(
    cSection,
    cUsername,
    Value
  );
end;

end.
