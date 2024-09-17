unit uFmain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxClass, frxExportPDF, frxDBSet,
  Horse,
  Horse.Jhonson,
  System.JSON,
  Horse.BasicAuthentication,
  Horse.CORS,
  Horse.Logger,
  Horse.Logger.Provider.LogFile,
  uClasses, FireDAC.Phys.IBBase;

type
  TFMain = class(TForm)
    lbStatus: TLabel;
    ChaveServidor: TToggleSwitch;
    Label1: TLabel;
    EditPortaHorse: TEdit;
    Label4: TLabel;
    EdtPathLog: TEdit;
    BbGravarConf: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BbGravarConfClick(Sender: TObject);
    procedure ChaveServidorClick(Sender: TObject);
  private
     Conf: ICONF;
     Procedure Lerconfigs;
     function Authentication(const AUsername, APassword: string):boolean;
  public

  end;

var
  FMain: TFMain;
  LLogFileConfig: THorseLoggerLogFileConfig;
implementation

{$R *.dfm}

uses EndPointCidade, EndPointCidadao, EndPointRelatorio, EndpointExportarCsv, EndpointArquivos;

function TFMain.Authentication(const AUsername, APassword: string): boolean;
begin
  Result := AUsername.Equals(conf.AUsername) and
            APassword.Equals(Conf.APassword);
end;

procedure TFMain.BbGravarConfClick(Sender: TObject);
begin
  conf.RestPort(strtoint(EditPortaHorse.Text))
      .PathLog(EdtPathLog.Text);
  Lerconfigs;
end;

procedure TFMain.ChaveServidorClick(Sender: TObject);
begin
  case ChaveServidor.State of
    tssOff:
     begin
       THorse.StopListen;
       ChaveServidor.FrameColor := clRed;
       ChaveServidor.ThumbColor := clRed;
     end ;
    tssOn:
     begin
       THorse.Listen(StrToInt(EditPortaHorse.Text));
       ChaveServidor.FrameColor := clBlue;
       ChaveServidor.ThumbColor := clBlue;

     end;
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  Conf := TCONF.New;
  Lerconfigs;
  ChaveServidor.State := tssOn;
  THorse.Use(CORS);
  THorse.Use(Jhonson());
  LLogFileConfig := THorseLoggerLogFileConfig.New
                   .SetLogFormat('[${request_clientip}] [${time}] [${request_method}] [${request_path_info}] [${request_version}] [${response_status}] [${response_location}] [${exception}] ')
                   .SetDir( EdtPathLog.Text );
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New(LLogFileConfig));
  THorse.Use( THorseLoggerManager.HorseCallback() );
  EndPointCidade.Registry_EndPointCidade;
  EndPointCidadao.Registry_EndPointCidadao;
  EndPointRelatorio.Registry_EndPointRelatorio;
  EndpointExportarCsv.Registry_EndPointExportaCsv;
  EndpointArquivos.Registry_EndpointArquivos;
end;

procedure TFMain.Lerconfigs;
begin
  with conf do
  begin
    EditPortaHorse.Text := inttostr(RestPort);
    EdtPathLog.Text   := PathLog;
  end;

end;

end.
