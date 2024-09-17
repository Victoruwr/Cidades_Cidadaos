program Servidor;

uses
  Vcl.Forms,
  EndPointCidade in 'EndPointCidade.pas',
  uClasses in 'uClasses.pas',
  uFmain in 'uFmain.pas' {FMain},
  EndPointCidadao in 'EndPointCidadao.pas',
  EndPointRelatorio in 'EndPointRelatorio.pas',
  EndpointExportarCsv in 'EndpointExportarCsv.pas',
  EndpointArquivos in 'EndpointArquivos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
