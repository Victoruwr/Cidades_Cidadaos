unit EndPointCidadao;

interface
   uses Horse,
        System.JSON,
        DataSet.Serialize,
        System.SysUtils,
        uClasses;

procedure Registry_EndPointCidadao;

implementation

 procedure GETCidadaos( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  RegCidadaos : TJSONArray;
  FQuery : iQuery;
  begin
   FQuery := TQueryFiredac.New(nil);
   FQuery.SQL('SELECT * FROM CIDADAO');
   RegCidadaos := FQuery.DataSet.ToJSONArray();
   Res.Send<TJSONARRAY>(RegCidadaos);
  end;

  procedure GETCidadao( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  RegCidadao : TJSONArray;
  FQuery : iQuery;
  ID  :string;
  begin
    ID := Req.Params.Items['ID'];
    if ID = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidadão ['+ID+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT * FROM CIDADAO where ID ='+ID);
    RegCidadao := FQuery.DataSet.ToJSONArray();
    if RegCidadao.Count>0
       then Res.Send<TJSONARRAY>(RegCidadao).Status(THTTPStatus.ok)
       else Res.Send<TJSONARRAY>(RegCidadao).Status(THTTPStatus.NoContent);
  end;

  procedure DeleteCidadao( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
   FQueryExec : iExecQuery;
   ID  :string;
  begin
    ID := Req.Params.Items['ID'];
    try
      FQueryExec := TExecQueryFiredac.New(nil);
      FqueryExec.StartTransaction;  // Prepara para que se ocorrer algum erro nas exclusões abaixo, possa desfazê-las para que seja verificado os erros ocorrido
      FQueryExec.ExecSQL('Delete from CIDADAO Where ID='+QuotedStr(ID));
      FQueryExec.Commit;     // Confirmar as esclusões
      Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Deletado com sucesso')).Status(THTTPStatus.Ok);
    except on E: Exception do
      begin
        FQueryExec.Rollback; // Desfazer exclusões acima realizadas
        Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Deletar Dados ['+e.Message+']'))
           .Status(THTTPStatus.BadRequest);
      end;
    end;
  end;

  procedure PutCidadao( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
    FQuery : iQuery;
    ID  :string;
  begin
    Try
      ID := Req.Params.Items['ID'];
      FQuery := TQueryFiredac.New(nil);
      FQuery.SQL('SELECT NOME,ENDERECO,COMPLEMENTO,BAIRRO,CIDADE_ID,CEP,USERCAD,DATAHCAD,DATAHULTALTER FROM CIDADAO Where ID='+ID);
      FQuery.DataSet.MergeFromJSONObject( Req.Body<TJSONObject>);
      Res.Send(tjsonobject.Create.AddPair('Mensagem', 'Atualizado com sucesso')).Status(THTTPStatus.Ok);
    except  on E: Exception do
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro Alterar Dados ['+e.Message+']'))
         .Status(THTTPStatus.BadRequest);
    End;
  end;

  procedure PostCidadaos( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery : iQuery;
  begin
   try
     FQuery := TQueryFiredac.New(nil);
     FQuery.SQL('SELECT NOME,ENDERECO,COMPLEMENTO,BAIRRO,CIDADE_ID,CEP,USERCAD,DATAHCAD,DATAHULTALTER FROM CIDADAO');
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

procedure Registry_EndPointCidadao;
begin
  THorse.Get('/Cidadaos/',   GETCidadaos)
        .Get('/Cidadao/:ID',   GETCidadao)
        .Delete('/Cidadao/:ID',DeleteCidadao)
        .Put('/Cidadao/:ID', PutCidadao)
        .Post('/Cidadao',    PostCidadaos);
end;

end.
