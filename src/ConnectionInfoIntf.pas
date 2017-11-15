unit ConnectionInfoIntf;

interface

type
  IConnectionInfo = interface
  ['{066778CA-982A-4ACE-BCF8-44810C4BBEF5}']
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

implementation

end.
