unit uClasses;

interface
  uses
   IniFiles,
   System.SysUtils,
   Data.DB,
   FireDAC.Comp.Client;

Type
  ICONF = interface
    function AUsername(value:String):ICONF ;overload;
    function AUsername:string;overload;
    function APassword(value:String):ICONF;overload;
    function APassword:string;overload;
    function RestPort(value:integer):ICONF;overload;
    function RestPort:integer;overload;
    function PathLog(Value:string):ICONF; overload;
    function PathLog:string; overload;
    function DBDriverID(Value:string):ICONF; overload;
    function DBDriverID:string; overload;
    function DBUser(Value:string):ICONF; overload;
    function DBUser:string; overload;
    function DBPass(Value:string):ICONF; overload;
    function DBPass:string; overload;
    function DBFile(Value:string):ICONF; overload;
    function DBFile:string; overload;
    function DBPort(Value:integer):ICONF; overload;
    function DBPort:integer; overload;
   end;

  iQuery = interface
    function SQL(Value : String) : iQuery;
    function DataSet : Tdataset;
    function TextoSQl: string;
  end;

  iExecQuery = interface
    function ExecSQL(Value : String) : iExecQuery;
    Procedure StartTransaction;
    Procedure Commit;
    Procedure Rollback;
  end;

   iConexao = interface
    function Connection : TCustomConnection;
  end;


{Classe TCONF}
type
  TCONF = class(TInterfacedObject,ICONF)
  private
    FINI  : TInifile;
    FModelConf: ICONF;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : ICONF;
    function AUsername(value:String):ICONF ;overload;
    function AUsername:string;overload;
    function APassword(value:String):ICONF;overload;
    function APassword:string;overload;
    function RestPort(value:integer):ICONF;overload;
    function RestPort:integer;overload;
    function PathLog(Value:string):ICONF; overload;
    function PathLog:string; overload;
    function DBDriverID(Value:string):ICONF; overload;
    function DBDriverID:string; overload;
    function DBUser(Value:string):ICONF; overload;
    function DBUser:string; overload;
    function DBPass(Value:string):ICONF; overload;
    function DBPass:string; overload;
    function DBFile(Value:string):ICONF; overload;
    function DBFile:string; overload;
    function DBPort(Value:integer):ICONF; overload;
    function DBPort:integer; overload;
  end;


{Classe TConexaoFiredac}
Type
  TConexaoFiredac = class(TInterfacedObject, iConexao)
    private
      FConexao: TFDConnection;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConexao;
      function Connection : TCustomConnection;
  end;

{Classe TQueryFiredac}
Type
  TQueryFiredac = class(TInterfacedObject, iQuery)
    private
      FParent : iConexao;
      FQuery : TFDQuery;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iQuery;
      function SQL(Value : String) : iQuery;
      function DataSet : Tdataset;
      function TextoSQl: string;
  end;

{Classe TQueryFiredac}
Type
  TExecQueryFiredac = class(TInterfacedObject, iExecQuery)
    private
      FParent : iConexao;
      FExecQuery : TFDQuery;
    public
      constructor Create(Parent : iConexao);
      destructor Destroy; override;
      class function New(Parent : iConexao) : iExecQuery;
      function ExecSQL(Value : String) : iExecQuery;
      Procedure StartTransaction;
      Procedure Commit;
      Procedure Rollback;
   end;

implementation


{ TCONF implementação}
function TCONF.APassword(value: String): ICONF;
begin
  FINI.WriteString('API','Password',value);
  Result:=Self;
end;

function TCONF.APassword: string;
begin
  Result:= FINI.Readstring('API','Password','');
end;

function TCONF.AUsername(value: String): ICONF;
begin
  FINI.WriteString('API','Username',value);
  Result:=Self;
end;

function TCONF.AUsername: string;
begin
  Result:= FINI.Readstring('API','Username','');
end;

constructor TCONF.Create;
begin
  FINI := TIniFile.Create(ChangeFileExt(ParamStr(0), '.INI'));
end;

function TCONF.DBDriverID: string;
begin
  Result:= FINI.Readstring('DB','DBDriverID','');
end;

function TCONF.DBDriverID(Value: string): ICONF;
begin
  FINI.WriteString('DB','DBDriverID',value);
  Result:=Self;
end;

function TCONF.DBFile(Value: string): ICONF;
begin
  FINI.WriteString('DB','DBFile',value);
  Result:=Self;
end;

function TCONF.DBFile: string;
begin
  Result:= FINI.Readstring('DB','DBFile','');
end;

function TCONF.DBPass(Value: string): ICONF;
begin
  FINI.WriteString('DB','DBPass',value);
  Result:=Self;
end;

function TCONF.DBPass: string;
begin
  Result:= FINI.Readstring('DB','DBPass','');
end;

function TCONF.DBPort(Value: integer): ICONF;
begin
  FINI.Writeinteger('DB','DBPort',value);
  Result:=Self;
end;

function TCONF.DBPort: integer;
begin
  Result:= FINI.Readinteger('DB','DBPort',3050);
end;

function TCONF.DBUser: string;
begin
  Result:= FINI.Readstring('DB','DBUser','');
end;

function TCONF.DBUser(Value: string): ICONF;
begin
  FINI.WriteString('DB','DBUser',value);
  Result:=Self;
end;

destructor TCONF.Destroy;
begin
  FINI.DisposeOf;
  inherited;
end;

class function TCONF.New: ICONF;
begin
  Result := Self.Create;
end;

function TCONF.PathLog: string;
begin
  Result:= FINI.Readstring('API','PathLog','');
end;

function TCONF.PathLog(Value: string): ICONF;
begin
  FINI.WriteString('API','PathLog',value);
  Result:=Self;
end;

function TCONF.RestPort: integer;
begin
  Result:= FINI.Readinteger('API','Port',9000);
end;

function TCONF.RestPort(value: integer): ICONF;
begin
  FINI.Writeinteger('API','Port',value);
  Result:=Self;
end;


{ TConexaoFiredac Implementação}
function TConexaoFiredac.Connection: TCustomConnection;
begin
  Result := FConexao;
end;

constructor TConexaoFiredac.Create;
var CONF: ICONF;
begin
  try
    FConexao := TFDConnection.Create(NIL);
    FConexao.TxOptions.AutoCommit := false;
    FConexao.Params.Clear;
    CONF:= TCONF.New;
    with FConexao, Conf do
    begin
      Params.Clear;
      Params.DriverID := DBDriverID;
      Params.database := DBFile;
      Params.UserName := DBUser;
      Params.Password := DBPass;
      ConnectedStoredUsage := [];
      Connected := true;
    end;
  except on E: Exception do
    Raise Exception.Create('Erro ao Conectar com o Banco de Dados'+E.Message);
  End;
end;

destructor TConexaoFiredac.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

class function TConexaoFiredac.New: iConexao;
begin
  Result := Self.Create;
end;


{ TQueryFiredac Implementação}
constructor TQueryFiredac.Create(Parent: iConexao);
begin
  FParent := Parent;
  FQuery := TFDQuery.Create(nil);
  if not Assigned(FParent)
     then FParent := TConexaoFiredac.New;
  FQuery.Connection := TFDConnection(FParent.Connection);
end;

function TQueryFiredac.DataSet: Tdataset;
begin
   Result := FQuery;
end;

destructor TQueryFiredac.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

class function TQueryFiredac.New(Parent: iConexao): iQuery;
begin
  Result := Self.Create(Parent);
end;

function TQueryFiredac.SQL(Value: String): iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
  FQuery.Active := true;
  FQuery.FetchAll;
end;

function TQueryFiredac.TextoSQl: string;
begin
  Result := FQuery.sql.Text;
end;


{ TExecQueryFiredac Implementação}
procedure TExecQueryFiredac.Commit;
begin
  FExecQuery.Connection.Commit;
end;

constructor TExecQueryFiredac.Create(Parent: iConexao);
begin
  FParent := Parent;
  FExecQuery := TFDQuery.Create(nil);
  if not Assigned(FParent)
     then FParent := TConexaoFiredac.New;
  FExecQuery.Connection := TFDConnection(FParent.Connection);
end;

destructor TExecQueryFiredac.Destroy;
begin
  FExecQuery.DisposeOf;
  inherited;
end;

function TExecQueryFiredac.ExecSQL(Value: String): iExecQuery;
begin
  Result := Self;
  FExecQuery.SQL.Clear;
  FExecQuery.SQL.Add(Value);
  FExecQuery.ExecSql;
end;

class function TExecQueryFiredac.New(Parent: iConexao): iExecQuery;
begin
  Result := Self.Create(Parent);
end;

procedure TExecQueryFiredac.Rollback;
begin
  FExecQuery.Connection.Rollback;
end;

procedure TExecQueryFiredac.StartTransaction;
begin
  FExecQuery.Connection.StartTransaction;
end;

end.
