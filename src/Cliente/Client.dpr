program Client;

uses
  Vcl.Forms,
  uFmain in 'uFmain.pas' {FMain},
  uFcadcidade in 'uFcadcidade.pas' {FCadCidade},
  uClassesInterfaces in 'uClassesInterfaces.pas',
  uFcadcidadao in 'uFcadcidadao.pas' {FCadCidadao},
  uRelatorios in 'uRelatorios.pas' {fRelaotrios},
  uFexporta in 'uFexporta.pas' {Fexporta},
  uConsultas in 'uConsultas.pas' {Fconsulta},
  uDowUp in 'uDowUp.pas' {FDowUp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
