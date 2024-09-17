unit uRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Vcl.StdCtrls,uclassesInterfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, Datasnap.DBClient, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, frxDBSet, Vcl.DBCtrls;

type
  TfRelaotrios = class(TForm)
    Frx: TfrxDBDataset;
    Relatorios: TfrxReport;
    CdRelatorioCidadao: TClientDataSet;
    CdRelatorioCidadaocodigo: TLargeintField;
    CdRelatorioCidadaocidadaoname: TStringField;
    CdRelatorioCidadaouf: TStringField;
    CdRelatorioCidadaocep: TStringField;
    CdRelatorioCidadaoenderecocompl: TStringField;
    CdRelatorioCidadaocidadename: TStringField;
    BtnImprimir: TButton;
    CdRelatorioCidade: TClientDataSet;
    CdRelatorioCidadetotal: TIntegerField;
    CdRelatorioCidadecidadeid: TLargeintField;
    CdRelatorioCidadenomecidade: TStringField;
    CdRelatorioCidadeufcidade: TStringField;
    cbRel: TComboBox;
    Label2: TLabel;
    CDRelBairroTOT: TClientDataSet;
    CDRelBairroTOTBAIRRO: TStringField;
    frxBairroTOT: TfrxDBDataset;
    frxBairroCidadao: TfrxDBDataset;
    DsBairroCidadao: TDataSource;
    DsBairroToT: TDataSource;
    CDRelBairroTOTTOT: TIntegerField;
    CdRelBairroCidadao: TClientDataSet;
    CdRelBairroCidadaoNOME: TStringField;
    CdRelBairroCidadaoBAIRRO: TStringField;
    DblCidade: TDBLookupComboBox;
    dsCidades: TDataSource;
    cdCidades: TClientDataSet;
    cdCidadesID: TLargeintField;
    StringField1: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnImprimirClick(Sender: TObject);
    procedure cbRelChange(Sender: TObject);
  private
    Req : iRequest ;
    procedure GeraRelatorioCidadao;
    procedure GeraRelatorioCidade;
    procedure GeraRelatorioBairro;
    procedure BuscaCidades;
  public

  end;

var
  fRelaotrios: TfRelaotrios;

implementation
    uses
    DataSet.Serialize,
    REST.Types,System.JSON ;
{$R *.dfm}

procedure TfRelaotrios.GeraRelatorioBairro;
var Jsonarray :TJsonarray;
valormin,valormax:string;
 buttonSelected :integer;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('RelatorioBairroTOT/'+cdCidades.FieldByName('id').AsString)
          .Execute.StatusCode in [200,201] then
    begin
      CDRelBairroTOT.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      CDRelBairroTOT.LoadFromJSON(Jsonarray);
      frxBairroTOT.DataSet:= CDRelBairroTOT;
    end
    else
    begin
      raise Exception.Create('Status: '+inttostr(Req.Response.StatusCode)+sLineBreak+Req.Response.Content);
    end;

    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('RelatorioBairroCidadao/'+cdCidades.FieldByName('id').AsString)
          .Execute.StatusCode in [200,201] then
    begin
      CDRelBairroCidadao.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      CDRelBairroCidadao.LoadFromJSON(Jsonarray);
      frxBairroCidadao.DataSet :=   CDRelBairroCidadao;
    end
    else
    begin
      raise Exception.Create('Status: '+inttostr(Req.Response.StatusCode)+sLineBreak+Req.Response.Content);
    end;

    if (CDRelBairroTOT.IsEmpty) and (CDRelBairroCidadao.IsEmpty) then
    begin
     raise Exception.Create('Não existe dados a serem apresenados!');
     exit;
    end;
    Relatorios.LoadFromFile('RelBairro.fr3');
    Relatorios.ShowReport();

  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;

  end;
end;

procedure TfRelaotrios.GeraRelatorioCidadao;
var Jsonarray :TJsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('RelatorioCidadao')
          .Execute.StatusCode in [200,201] then
    begin
      CdRelatorioCidadao.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      CdRelatorioCidadao.LoadFromJSON(Jsonarray);
      Frx.DataSet := CdRelatorioCidadao;
      Relatorios.DataSet   := Frx;
      Relatorios.LoadFromFile('RelCidadao.fr3');
      Relatorios.ShowReport();
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

procedure TfRelaotrios.GeraRelatorioCidade;
var Jsonarray :TJsonarray;
 valormin,valormax:string;
 buttonSelected :integer;

begin
  buttonSelected := MessageDlg('Deseja filtrar pelo número min/max de total de habitante por cidade?',mtConfirmation,mbYesNo,0) ;

  if buttonSelected=mrYes then
  begin
    InputQuery('Filtro Valor Mínimo','Digite um valor Mínimo :',valormin);
    InputQuery('Filtro Valor Máximo','Digite um valor Máximo :',valormax);
  end;

  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('RelatorioCidade')
          .AddParameter('min',valormin)
          .AddParameter('max',valormax)
          .Execute.StatusCode in [200,201] then
    begin
      CdRelatorioCidade.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      CdRelatorioCidade.LoadFromJSON(Jsonarray);
      Frx.DataSet := CdRelatorioCidade;
      Relatorios.DataSet   := Frx;
      Relatorios.LoadFromFile('RelCidade.fr3');
      Relatorios.ShowReport();
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

procedure TfRelaotrios.BuscaCidades;
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
      MessageDlg(e.Message,mterror,[mbOK],0);
    end;

  end;
end;

procedure TfRelaotrios.Button1Click(Sender: TObject);
begin
  GeraRelatorioCidadao;
end;

procedure TfRelaotrios.cbRelChange(Sender: TObject);
begin
  DblCidade.Visible := cbRel.ItemIndex = 2;
end;

procedure TfRelaotrios.BtnImprimirClick(Sender: TObject);
begin
  case cbRel.ItemIndex of
    0:GeraRelatorioCidadao;
    1:GeraRelatorioCidade;
    2:GeraRelatorioBairro;
  end;

end;

procedure TfRelaotrios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  fRelaotrios:= nil;
end;

procedure TfRelaotrios.FormCreate(Sender: TObject);
begin
  Req := TRequest.New;

  CdRelatorioCidadao.CreateDataSet;
  CdRelatorioCidadao.Open;

  CdRelatorioCidade.CreateDataSet;
  CdRelatorioCidade.Open;

  CDRelBairroTOT.CreateDataSet;
  CDRelBairroTOT.Open;

  CdRelBairroCidadao.CreateDataSet;
  CdRelBairroCidadao.Open;

  cbRelChange(sender);
  cdCidades.CreateDataSet;
  cdCidades.Open;
  BuscaCidades;


end;

end.
