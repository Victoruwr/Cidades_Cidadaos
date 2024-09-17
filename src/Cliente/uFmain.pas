unit uFmain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFMain = class(TForm)
    MainMenu: TMainMenu;
    MRel: TMenuItem;
    Msair: TMenuItem;
    Mcad: TMenuItem;
    MCadCidade: TMenuItem;
    McadCidadao: TMenuItem;
    MExporta: TMenuItem;
    Mconsulta: TMenuItem;
    MArmazenamento: TMenuItem;
    procedure MCadCidadeClick(Sender: TObject);
    procedure McadCidadaoClick(Sender: TObject);
    procedure MRelClick(Sender: TObject);
    procedure MExportaClick(Sender: TObject);
    procedure MconsultaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MArmazenamentoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation
  uses uFCadCidade,uFcadcidadao,uRelatorios,uFexporta,uconsultas,uDowUp;
{$R *.dfm}

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFMain.MArmazenamentoClick(Sender: TObject);
begin
 if not assigned(FDowUp) then
  begin
    FDowUp := TFDowUp.Create(self);
    FDowUp.Show;
  end;
end;

procedure TFMain.McadCidadaoClick(Sender: TObject);
begin
  if not assigned(FCadCidadao) then
  begin
    FCadCidadao := TFCadCidadao.Create(self);
    FCadCidadao.Show;
  end;
end;

procedure TFMain.MCadCidadeClick(Sender: TObject);
begin
  if not assigned(FCadCidade) then
  begin
    FCadCidade := TFCadCidade.Create(self);
    FCadCidade.Show;
  end;
end;

procedure TFMain.MconsultaClick(Sender: TObject);
begin
  if not assigned(Fconsulta) then
  begin
    Fconsulta := TFconsulta.Create(self);
    Fconsulta.Show;
  end;
end;

procedure TFMain.MExportaClick(Sender: TObject);
begin
  if not assigned(Fexporta) then
  begin
    Fexporta := TFexporta.Create(self);
    Fexporta.Show;
  end;
end;

procedure TFMain.MRelClick(Sender: TObject);
begin
  if not assigned(fRelaotrios) then
  begin
    fRelaotrios := TfRelaotrios.Create(self);
    fRelaotrios.Show;
  end;
end;

end.
