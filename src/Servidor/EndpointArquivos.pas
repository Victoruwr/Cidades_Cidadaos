unit EndpointArquivos;

interface
    uses Horse,
      System.JSON,
      DataSet.Serialize,
      System.SysUtils,
      uClasses,
      System.Classes;

procedure Registry_EndpointArquivos;

implementation

  procedure PostArquivos( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery : iQuery;
  begin
    try
      FQuery := TQueryFiredac.New(nil);
      FQuery.SQL('SELECT TITULO,EXT,ARQ  FROM ARQUIVOS');
      FQuery.DataSet.LoadFromJSON(Req.Body<TJSONObject>);
      FQuery.DataSet.Insert;
      Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Inserido com sucesso'))
         .Status(THTTPStatus.Ok);
    except
      on E: Exception do
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Incluir Dados ['+e.Message+']'))
         .Status(THTTPStatus.BadRequest);
    end;
  end;

  procedure GetArquivos( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  Registro : TJSONArray;
  FQuery : iQuery;
  begin
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT * FROM  ARQUIVOS ');
    Registro := FQuery.DataSet.ToJSONArray();
    if Registro.Count>0
       then Res.Send<TJSONARRAY>(Registro).Status(THTTPStatus.ok)
       else Res.Send<TJSONARRAY>(Registro).Status(THTTPStatus.NoContent);
  end;

  procedure GetArquivo( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  Registro : TJSONArray;
  FQuery : iQuery;
  ID :string;
  begin
    ID := Req.Params.Items['ID'];
    if ID = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidadão ['+ID+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT * FROM  ARQUIVOS WHERE ID='+ID);
    Registro := FQuery.DataSet.ToJSONArray();
    if Registro.Count>0
       then Res.Send<TJSONARRAY>(Registro).Status(THTTPStatus.ok)
       else Res.Send<TJSONARRAY>(Registro).Status(THTTPStatus.NoContent);
  end;

procedure Registry_EndpointArquivos;
begin
  THorse.Get('/Arquivos',   GetArquivos)
        .Get('/Arquivos/:ID',   GetArquivo)
        .Post('/Arquivo' , PostArquivos);
end;

end.
