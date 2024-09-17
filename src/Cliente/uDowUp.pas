unit uDowUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB,uclassesInterfaces, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TFDowUp = class(TForm)
    cdArquivo: TClientDataSet;
    cdArquivoTITULO: TStringField;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    cdArquivoARQ: TBlobField;
    cdArquivoEXT: TStringField;
    CdTodosArquivos: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    BlobField1: TBlobField;
    CdTodosArquivosID: TLargeintField;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    BtnDownload: TBitBtn;
    BtnUpload: TBitBtn;
    grid: TDBGrid;
    DsTodosArquivos: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnDownloadClick(Sender: TObject);
    procedure BtnUploadClick(Sender: TObject);
  private
     Req : iRequest ;
     function EnviaArquivo:Boolean;
     procedure BuscaArquivos;
  public
    { Public declarations }
  end;

var
  FDowUp: TFDowUp;

implementation
    uses
    DataSet.Serialize,
    REST.Types,System.JSON ;

{$R *.dfm}


procedure TFDowUp.BtnDownloadClick(Sender: TObject);
var i:integer;
begin
  try
    SaveDialog.Filter     := 'Arquivos '+CdTodosArquivos.FieldByName('EXT').asstring+'|*.'+CdTodosArquivos.FieldByName('EXT').asstring+'';
    SaveDialog.DefaultExt := CdTodosArquivos.FieldByName('EXT').asstring;

    if SaveDialog.Execute then
    begin
      TBlobField(CdTodosArquivos.FieldByName('ARQ')).SaveToFile(SaveDialog.filename);
    end;

    MessageDlg('Download com sucesso!',mtConfirmation,[mbOK],0);
  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;
  end;
end;


procedure TFDowUp.BtnUploadClick(Sender: TObject);
var i,buttonSelected:integer;
begin
  cdArquivo.EmptyDataSet;
  if OpenDialog.Execute then
  begin
    buttonSelected := MessageDlg('Enviar '+inttostr(OpenDialog.Files.count)+' Arquivo(s)?',mtConfirmation,mbYesNo,0) ;
    if buttonSelected=mrYes then
    begin
      if EnviaArquivo then
      begin
        CdTodosArquivos.EmptyDataSet;
        CdTodosArquivos.Insert;
        BuscaArquivos;
      end;
    end;
  end;
end;

procedure TFDowUp.BuscaArquivos;
var Jsonarray :TJsonarray;
begin
  try
    if Req.AddBaseURL('Http://localhost:9000')
          .AddMethod(rmGET)
          .AddResource('Arquivos')
          .Execute.StatusCode in [200,201] then
    begin
      CdTodosArquivos.EmptyDataSet;
      Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;
      CdTodosArquivos.LoadFromJSON(Jsonarray);
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

function TFDowUp.EnviaArquivo:Boolean;
var i:integer;
begin
  try
    cdArquivo.IsEmpty;
    cdArquivo.Insert;
    cdArquivo.FieldByName('TITULO').Asstring := ExtractFileName(OpenDialog.Files[i]);
    cdArquivo.FieldByName('EXT').Asstring    := ExtractFileExt(OpenDialog.Files[i]);
    TBlobField(cdArquivo.FieldByName('ARQ')).LoadFromFile(OpenDialog.Files[i]);
    cdArquivo.Post;

    Result:= (Req.Reset
                 .AddBaseURL('Http://localhost:9000')
                 .AddMethod(rmPOST)
                 .AddResource('Arquivo')
                 .AddBody(cdArquivo.ToJSONObjectString ,ContentTypeFromString('application/json'))
                 .Execute.StatusCode in [200,201]);
  except
    On E:exception do
    begin
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

procedure TFDowUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  FDowUp:= nil;
end;

procedure TFDowUp.FormCreate(Sender: TObject);
begin
  Req := TRequest.New;

  cdArquivo.CreateDataSet;
  cdArquivo.Open;

  CdTodosArquivos.CreateDataSet;
  CdTodosArquivos.Open;

  BuscaArquivos;
end;

end.
