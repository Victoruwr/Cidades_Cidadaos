unit EndPointCidade;

interface
    uses Horse,
        System.JSON,
        DataSet.Serialize,
        System.SysUtils,
        uClasses;

procedure Registry_EndPointCidade;

implementation

  procedure GETCidades( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  RegCidades : TJSONArray;
  FQuery : iQuery;
  begin
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT * FROM CIDADE');
    RegCidades := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(RegCidades)
       .Status(THTTPStatus.ok);
  end;

  procedure GETCidade( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  RegCidade : TJSONArray;
  FQuery : iQuery;
  ID  :string;
  begin
    ID := Req.Params.Items['ID'];
    if ID = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidade ['+ID+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT * FROM CIDADE where ID ='+ID);
    RegCidade := FQuery.DataSet.ToJSONArray();
    if RegCidade.Count>0
       then Res.Send<TJSONARRAY>(RegCidade).Status(THTTPStatus.ok)
       else Res.Send<TJSONARRAY>(RegCidade).Status(THTTPStatus.NoContent);
  end;

  procedure DeleteCidade( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
   FQueryExec : iExecQuery;
   ID  :string;
  begin
    ID := Req.Params.Items['ID'];
    try
      FQueryExec := TExecQueryFiredac.New(nil);
      FqueryExec.StartTransaction;  // Prepara para que se ocorrer algum erro nas exclusões abaixo, possa desfazê-las para que seja verificado os erros ocorrido
      FQueryExec.ExecSQL('Delete from CIDADE Where ID='+QuotedStr(ID));
      FQueryExec.Commit;     // Confirmar as esclusões
      Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Deletado com sucesso'))
         .Status(THTTPStatus.Ok);
    except  on E: Exception do
      begin
        FQueryExec.Rollback; // Desfazer exclusões acima realizadas
        Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Deletar Dados ['+e.Message+']'))
           .Status(THTTPStatus.BadRequest);
      end;
    End;
  end;

  procedure PutCidade( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
    FQuery : iQuery;
    ID  :string;
  begin
    Try
      ID := Req.Params.Items['ID'];
      FQuery := TQueryFiredac.New(nil);
      FQuery.SQL('SELECT NOME,UF,USERCAD,DATAHCAD,DATAHULTALTER FROM CIDADE Where ID='+ID);
      FQuery.DataSet.MergeFromJSONObject( Req.Body<TJSONObject>);
      Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Atualizado com sucesso'))
         .Status(THTTPStatus.Ok);
    except  on E: Exception do
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Alterar Dados ['+e.Message+']'))
         .Status(THTTPStatus.BadRequest);
    End;
  end;

  procedure PostCidades( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery : iQuery;
  begin
    try
      FQuery := TQueryFiredac.New(nil);
      FQuery.SQL('SELECT NOME,UF,USERCAD,DATAHCAD,DATAHULTALTER FROM CIDADE');
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

procedure Registry_EndPointCidade;
begin
  THorse.Get('/Cidades/',   GETCidades)
        .Get('/Cidade/:ID',   GETCidade)
        .Delete('/Cidade/:ID',DeleteCidade)
        .Put('/Cidade/:ID', PutCidade)
        .Post('/Cidade',    PostCidades);
end;

end.
