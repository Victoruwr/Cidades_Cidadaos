unit uFexporta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.ExtDlgs,uclassesInterfaces, System.JSON;

type
  TFexporta = class(TForm)
    Label2: TLabel;
    EdPath: TEdit;
    BtnSelecione: TButton;
    SaveDialog1: TSaveDialog;
    cdCSV: TClientDataSet;
    cdCSVID: TLargeintField;
    cdCSVNOME: TStringField;
    cdCSVENDERECO: TStringField;
    cdCSVCOMPLEMENTO: TStringField;
    cdCSVBAIRRO: TStringField;
    cdCSVCIDADE: TStringField;
    cdCSVUF: TStringField;
    cdCSVCEP: TStringField;
    BtnExportar: TButton;
    procedure BtnSelecioneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnExportarClick(Sender: TObject);
  private
     Req : iRequest ;
     procedure BuscaDados;
     procedure Exportar;
  public
    { Public declarations }
  end;

var
  Fexporta: TFexporta;

implementation

uses
   DataSet.Serialize,
   REST.Types;

{$R *.dfm}

procedure TFexporta.BtnExportarClick(Sender: TObject);
var
Slista : Tstringlist;
ncampo : integer;
CLinha :string;
begin
  try
    BuscaDados;

    SLista := Tstringlist.Create;
    Clinha :='';

    for ncampo := 0 to cdcsv.Fields.Count-1 do
    CLinha := CLinha+cdcsv.Fields[NCAMPO].DisplayLabel+';';

    SLISTA.Add(CLINHA);

    cdcsv.first;
    while not cdcsv.Eof do
    begin
      Clinha :='';
      for NCAMPO := 0 to cdcsv.Fields.Count-1 do
      CLinha := CLinha+cdcsv.Fields[ncampo].DisplayText+';';
      SLISTA.Add(Clinha);
      cdcsv.Next;
    end;
  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
      exit;
    end;
  end;

  SLISTA.SaveToFile(EdPath.Text);
  MessageDlg('Arquivo gravado com sucesso!',mtInformation,[mbOK],0);
end;

procedure TFexporta.BtnSelecioneClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveDialog1.DefaultExt := 'csv';
    EdPath.Text := SaveDialog1.FileName;
  end;
end;

procedure TFexporta.BuscaDados;
var Jsonarray :Tjsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('GetExportaCsv')
          .Execute.StatusCode in [200,201] then
    begin
      cdcsv.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      cdcsv.LoadFromJSON(Jsonarray);
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

procedure TFexporta.Exportar;
begin

end;

procedure TFexporta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  Fexporta:= nil;
end;

procedure TFexporta.FormCreate(Sender: TObject);
begin
  Req := TRequest.New;
  cdcsv.CreateDataSet;
  cdcsv.Open;
end;

end.
