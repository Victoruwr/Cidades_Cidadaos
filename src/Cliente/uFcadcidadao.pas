unit uFcadcidadao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  uclassesInterfaces, Datasnap.DBClient;

type
  TFCadCidadao = class(TForm)
    PnlTop: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    BtnInserir: TButton;
    DbedtNome: TDBEdit;
    DbedtUF: TDBEdit;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DblCidade: TDBLookupComboBox;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    pnlcentral: TPanel;
    GridCidadao: TDBGrid;
    cdTodosCidadaos: TClientDataSet;
    DsTodosCidadaos: TDataSource;
    CdCidadao: TClientDataSet;
    dsCidadao: TDataSource;
    cdTodosCidadaosID: TLargeintField;
    cdTodosCidadaosNOME: TStringField;
    cdTodosCidadaosENDERECO: TStringField;
    cdTodosCidadaosCOMPLEMENTO: TStringField;
    cdTodosCidadaosBAIRRO: TStringField;
    cdTodosCidadaosCIDADE_ID: TLargeintField;
    cdTodosCidadaosCEP: TStringField;
    cdTodosCidadaosUSERCAD: TLargeintField;
    cdTodosCidadaosDATAHCAD: TDateTimeField;
    cdTodosCidadaosDATAHULTALTER: TDateTimeField;
    CdCidadaoNOME: TStringField;
    CdCidadaoENDERECO: TStringField;
    CdCidadaoCOMPLEMENTO: TStringField;
    CdCidadaoBAIRRO: TStringField;
    CdCidadaoCIDADE_ID: TLargeintField;
    CdCidadaoCEP: TStringField;
    CdCidadaoUSERCAD: TLargeintField;
    CdCidadaoDATAHCAD: TDateTimeField;
    CdCidadaoDATAHULTALTER: TDateTimeField;
    cdCidades: TClientDataSet;
    StringField1: TStringField;
    dsCidades: TDataSource;
    cdCidadesID: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure CdCidadaoAfterInsert(DataSet: TDataSet);
    procedure cdTodosCidadaosBeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Req : iRequest ;
    function EnviaCidadao:boolean;
    procedure BuscaCidadaos;
    procedure BuscaCidades;
    function DeletaCidadao:boolean;
  public
  end;

var
  FCadCidadao: TFCadCidadao;

implementation
   uses
   DataSet.Serialize,
   REST.Types,System.JSON ;

{$R *.dfm}

{ TFCadCidadao }

procedure TFCadCidadao.BtnInserirClick(Sender: TObject);
begin
  if EnviaCidadao then
  begin
    cdCidadao.EmptyDataSet;
    cdCidadao.Insert;
    BuscaCidadaos;
  end;
end;

procedure TFCadCidadao.BuscaCidadaos;
var Jsonarray :TJsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('Cidadaos')
          .Execute.StatusCode in [200,201] then
    begin
      cdTodosCidadaos.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      cdTodosCidadaos.LoadFromJSON(Jsonarray);
    end
    else
    begin
      raise Exception.Create('Status: '+inttostr(Req.Response.StatusCode)+sLineBreak+Req.Response.Content);
    end;

  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;

  end;
end;

procedure TFCadCidadao.BuscaCidades;
var Jsonarray :TJsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('Cidades')
          .Execute.StatusCode in [200,201] then
    begin
      cdCidades.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      cdCidades.LoadFromJSON(Jsonarray);
    end
    else
    begin
      raise Exception.Create('Status: '+inttostr(Req.Response.StatusCode)+sLineBreak+Req.Response.Content);
    end;

  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
      exit;
    end;

  end;
end;

procedure TFCadCidadao.CdCidadaoAfterInsert(DataSet: TDataSet);
begin
  cdCidadao.fieldbyname('USERCAD').asinteger        := 1 ;
  cdCidadao.fieldbyname('DATAHCAD').AsDateTime      := now ;
  cdCidadao.fieldbyname('DATAHULTALTER').AsDateTime := now;
end;

procedure TFCadCidadao.cdTodosCidadaosBeforeDelete(DataSet: TDataSet);
begin
  IF not DeletaCidadao
     then ABORT;
end;

function TFCadCidadao.DeletaCidadao: boolean;
begin
  try
    Result := (Req.AddBaseURL('Http://localhost:9000')
                  .AddMethod(rmDELETE)
                  .AddResource('Cidadao/'+cdTodosCidadaos.FieldByName('id').AsString)
                  .Execute.StatusCode in [200,201]);
  except
    On E:exception do
    begin
      Result:=false;
      MessageDlg(e.Message,mtError,[mbOK],0);
      exit;
    end;

  end;

  if Result then
  begin
    MessageDlg(Req.Response.Content,mtConfirmation,[mbOK],0);
  end
  else
  begin
    if Req.Response.Content<>EmptyStr
       then  MessageDlg(Req.Response.Content,mtConfirmation,[mbOK],0)
  end
end;

function TFCadCidadao.EnviaCidadao: boolean;
begin
  if CdCidadao.State in dsEditModes then CdCidadao.Post;

  try
    Result := (Req.Reset
                  .AddBaseURL('Http://localhost:9000')
                  .AddMethod(rmPOST)
                  .AddResource('Cidadao')
                  .AddBody(cdCidadao.ToJSONObjectString ,ContentTypeFromString('application/json'))
                  .Execute.StatusCode in [200,201]);
  except
    On E:exception do
    begin
      Result:=false;
      MessageDlg(e.Message,mtError,[mbOK],0);
      EXIT;
    end;

  end;

  if Result then
  begin
    MessageDlg(Req.Response.Content,mtConfirmation,[mbOK],0);
    CdCidadao.EmptyDataSet;
  end
  else
  begin
    if Req.Response.Content<>EmptyStr
       then  MessageDlg(Req.Response.Content,mtConfirmation,[mbOK],0)
  end
end;

procedure TFCadCidadao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  FCadCidadao:= nil;
end;

procedure TFCadCidadao.FormCreate(Sender: TObject);
begin
  Req := TRequest.New;

  cdTodosCidadaos.CreateDataSet;
  cdTodosCidadaos.Open;

  CdCidadao.CreateDataSet;
  CdCidadao.Open;
  CdCidadao.Insert;
  BuscaCidadaos;

  cdCidades.CreateDataSet;
  cdCidades.Open;
  BuscaCidades;
end;

end.
