object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'Teste Pr'#225'tico'
  ClientHeight = 569
  ClientWidth = 1292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OnClose = FormClose
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 280
    Top = 144
    object Mcad: TMenuItem
      Caption = 'Cadastros'
      object MCadCidade: TMenuItem
        Caption = 'Cadastro Cidades'
        OnClick = MCadCidadeClick
      end
      object McadCidadao: TMenuItem
        Caption = 'Cadastro Cidad'#227'os'
        OnClick = McadCidadaoClick
      end
    end
    object Mconsulta: TMenuItem
      Caption = 'ConsultaID'
      OnClick = MconsultaClick
    end
    object MRel: TMenuItem
      Caption = 'Relat'#243'rios'
      OnClick = MRelClick
    end
    object MExporta: TMenuItem
      Caption = 'Exporta Arquivo csv'
      OnClick = MExportaClick
    end
    object MArmazenamento: TMenuItem
      Caption = 'Download e Upload'
      OnClick = MArmazenamentoClick
    end
    object Msair: TMenuItem
      Caption = 'Sair do Sistema'
    end
  end
end
