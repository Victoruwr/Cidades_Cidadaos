unit uFcadcidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  uclassesInterfaces, IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFCadCidade = class(TForm)
    cdTodasCidades: TClientDataSet;
    DsTodasCidade: TDataSource;
    cdTodasCidadesNOME: TStringField;
    cdTodasCidadesUF: TStringField;
    cdTodasCidadesUSERCAD: TIntegerField;
    cdTodasCidadesDATAHCAD: TDateTimeField;
    cdTodasCidadesDATAHULTALTER: TDateTimeField;
    cdTodasCidadesID: TLargeintField;
    PnlTop: TPanel;
    Label1: TLabel;
    BtnInserir: TButton;
    CdCidade: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    Label2: TLabel;
    Label3: TLabel;
    PnlCentro: TPanel;
    GridCidade: TDBGrid;
    DbedtNome: TDBEdit;
    DbedtUF: TDBEdit;
    dsCidade: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure CdCidadeAfterInsert(DataSet: TDataSet);
    procedure cdTodasCidadesBeforeDelete(DataSet: TDataSet);
  private
    Req : iRequest ;
    function EnviaCidade:boolean;
    procedure BuscaCidades;
    function DeletaCidade:boolean;
  public
  end;

var
  FCadCidade: TFCadCidade;

implementation
    uses
    DataSet.Serialize,
    REST.Types,System.JSON ;

{$R *.dfm}

procedure TFCadCidade.BuscaCidades;
var Jsonarray :TJsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('Cidades')
          .Execute.StatusCode in [200,201] then
    begin
      cdTodasCidades.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      cdTodasCidades.LoadFromJSON(Jsonarray);
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

procedure TFCadCidade.CdCidadeAfterInsert(DataSet: TDataSet);
begin
  cdCidade.fieldbyname('USERCAD').asinteger        := 1 ;
  cdCidade.fieldbyname('DATAHCAD').AsDateTime      := now ;
  cdCidade.fieldbyname('DATAHULTALTER').AsDateTime := now;
end;

procedure TFCadCidade.cdTodasCidadesBeforeDelete(DataSet: TDataSet);
begin
  IF not DeletaCidade
     then ABORT;
end;

function TFCadCidade.DeletaCidade: boolean;
begin
  try
    Result := (Req.AddBaseURL('Http://localhost:9000')
                  .AddMethod(rmDELETE)
                  .AddResource('Cidade/'+cdTodasCidades.FieldByName('id').AsString)
                  .Execute.StatusCode in [200,201]);
  except
    On E:exception do
    begin
      Result:=false;
      MessageDlg(e.Message,mtError,[mbOK],0);
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

procedure TFCadCidade.BtnInserirClick(Sender: TObject);
begin
  if EnviaCidade then
  begin
    cdCidade.EmptyDataSet;
    cdCidade.Insert;
    BuscaCidades;
  end;
end;

Function TFCadCidade.EnviaCidade:boolean;
begin
  try
    Result := (Req.Reset
                  .AddBaseURL('Http://localhost:9000')
                  .AddMethod(rmPOST)
                  .AddResource('Cidade')
                  .AddBody(cdCidade.ToJSONObjectString ,ContentTypeFromString('application/json'))
                  .Execute.StatusCode in [200,201]);
  except
    On E:exception do
    begin
      Result:=false;
      MessageDlg(e.Message,mtError,[mbOK],0);
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

procedure TFCadCidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  FCadCidade:= nil;
end;

procedure TFCadCidade.FormCreate(Sender: TObject);
begin
  Req := TRequest.New;

  cdTodasCidades.CreateDataSet;
  cdTodasCidades.Open;

  CdCidade.CreateDataSet;
  CdCidade.Open;
  CdCidade.Insert;

  BuscaCidades;
end;

end.
