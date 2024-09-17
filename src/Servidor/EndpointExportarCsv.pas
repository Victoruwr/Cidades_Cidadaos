unit EndpointExportarCsv;

interface
    uses Horse,
        System.JSON,
        DataSet.Serialize,
        System.SysUtils,
        uClasses,
        Data.DB;

procedure Registry_EndPointExportaCsv;

implementation

  procedure GetExportaCsv( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery :iQuery;
  Registro: TJSONArray;
  begin
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('select CIDADAO.ID IDCIDADE, CIDADAO.NOME,ENDERECO,COMPLEMENTO,BAIRRO, '+
               'CIDADE.nome CIDADE, CIDADE.UF,CEP '+
               'FROM CIDADAO '+
               'JOIN cidade ON CIDADE.id = CIDADAO.cidade_id');
    Registro := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(Registro);
  end;

procedure Registry_EndPointExportaCsv;
begin
  THorse.Get('/GetExportaCsv',   GetExportaCsv)

end;

end.
