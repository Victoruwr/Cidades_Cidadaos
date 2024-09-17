unit uConsultas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uClassesInterfaces;

type
  TFconsulta = class(TForm)
    EdtCidade: TEdit;
    BtnConsultarCidade: TButton;
    Memo: TMemo;
    Label1: TLabel;
    EdtCidadao: TEdit;
    BtnConsultarCidadao: TButton;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnConsultarCidadeClick(Sender: TObject);
    procedure BtnConsultarCidadaoClick(Sender: TObject);
  private
     Req : iRequest ;
  public
    { Public declarations }
  end;

var
  Fconsulta: TFconsulta;

implementation
    uses
    DataSet.Serialize,
    REST.Types,System.JSON ;
{$R *.dfm}

procedure TFconsulta.BtnConsultarCidadaoClick(Sender: TObject);
var Jsonarray :TJsonarray;
begin
  try
    Req.AddBaseURL('Http://localhost:9000')
       .AddMethod(rmGET)
       .AddResource('Cidadao/'+EdtCidadao.Text)
       .Execute ;

    Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;

    Memo.Lines.add('Cidadão');
    Memo.Lines.add('Retorno: '+inttostr(Req.Response.StatusCode)+sLineBreak);

    if Jsonarray <> nil
       then  Memo.Lines.add(Jsonarray.ToJSON+sLineBreak);

  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;

  end;
end;

procedure TFconsulta.BtnConsultarCidadeClick(Sender: TObject);
var Jsonarray :TJsonarray;
begin
  try
    Req.AddBaseURL('Http://localhost:9000')
       .AddMethod(rmGET)
       .AddResource('Cidade/'+EdtCidade.Text)
       .Execute ;

    Jsonarray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Response.Content),0) as TJsonArray;

    Memo.Lines.add('Cidade');
    Memo.Lines.add('Retorno: '+inttostr(Req.Response.StatusCode)+sLineBreak);

    if Jsonarray <> nil
       then  Memo.Lines.add(Jsonarray.ToJSON+sLineBreak);

  except
    On E:exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;

  end;
end;

procedure TFconsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  release;
  Fconsulta:= nil;
end;

procedure TFconsulta.FormCreate(Sender: TObject);
begin
   Req := TRequest.New;
end;

end.
