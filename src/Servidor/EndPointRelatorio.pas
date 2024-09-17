unit EndPointRelatorio;

interface
  uses Horse,
        System.JSON,
        DataSet.Serialize,
        System.SysUtils,
        uClasses,
        Data.DB;

procedure Registry_EndPointRelatorio;

implementation

  procedure GetRelatorioCidadao( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery :iQuery;
  Registro: TJSONArray;
  begin
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT CI.ID CODIGO, CI.NOME CIDADAONAME, (CI.endereco ||'' ''|| CI.complemento) ENDERECOCOMPL, '+
               'C.NOME CIDADENAME, C.UF, CI.CEP FROM cidadao CI '+
               'JOIN CIDADE C ON C.ID = CI.CIDADE_ID '+
               'ORDER BY CI.NOME ASC');
    Registro := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(Registro);
  end;

  procedure GetRelatorioCidade( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  Registro : TJSONArray;
  FQuery : iQuery;

    function Filtro:String;
    var min,max:string;
        minB:boolean;
    begin
      Result := emptystr;

      minB := (Req.Query.TryGetValue('min', min));

      if minB and (min <> emptystr)
         then Result := Result + ' HAVING COUNT(CI.ID) >'+ min+' ';

      if (minB and (min <> emptystr)) and (Req.Query.TryGetValue('max', max) and (max<>emptystr)) then
         Result := Result + ' AND COUNT(CI.ID) <'+ max+' '

      else if (Req.Query.TryGetValue('max', max) and (max<>emptystr)) then
         Result := Result + ' HAVING COUNT(CI.ID) <'+ max;
    end;

  begin
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT COUNT(CI.ID)TOTAL ,C.ID CIDADEID, '+
               '(SELECT NOME FROM cidade where ID=C.ID)NOMECIDADE, '+
               '(SELECT UF  FROM cidade where ID=C.ID)UFCIDADE  '+
               'FROM CIDADAO CI '+
               'JOIN CIDADE C ON C.ID = CI.CIDADE_ID '+
               'GROUP BY C.ID'+
                Filtro);

    Registro := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(Registro);
  end;

  procedure GetRelatorioBairro( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var
  FQueryBairro :iQuery;
  FQueryBairroCidadao : iQuery;
  jsonObjet1 : Tjsonobject;
  jsonObjet2 : Tjsonobject;
  jsonarray : tjsonarray;
  Registro : TJSONArray;

  IDCidade  :string;
  begin
    IDCidade := Req.Params.Items['IDCidade'];
    if IDCidade = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidade ['+IDCidade+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;

    FQueryBairro         := TQueryFiredac.New(nil);
    FQueryBairroCidadao  := TQueryFiredac.New(nil);

    FQueryBairro.SQL('SELECT CI.BAIRRO,(select COUNT(*)TOT FROM CIDADAO WHERE BAIRRO=CI.BAIRRO)TOT '+
                     'FROM CIDADAO CI WHERE CI.CIDADE_ID = '+IDCidade+' GROUP BY CI.BAIRRO ');

    Registro := TJSONArray.create;
    while not FQueryBairro.DataSet.Eof do
    begin
      jsonObjet1 := TJSONObject.Create;
      jsonObjet1.AddPair(TJSONPair.Create('BAIRRO',TJSONString.Create(FQueryBairro.DataSet.FieldByName('BAIRRO').value)));
      jsonObjet1.AddPair(TJSONPair.Create('TOT',TJSONNumber.Create(FQueryBairro.DataSet.FieldByName('TOT').asstring)));
      jsonarray := TJSONArray.Create;

      FQueryBairroCidadao.sql('select BAIRRO, NOME FROM cidadao WHERE CIDADE_ID='+IDCidade+' and BAIRRO ='+quotedstr(FQueryBairro.DataSet.FieldByName('BAIRRO').asstring));
      while not FQueryBairroCidadao.dataset.eof do
      begin
        jsonObjet2 := TJSONObject.Create;
        jsonObjet2.AddPair('NOME',TJSONString.Create(FQueryBairroCidadao.DataSet.FieldByName('NOME').value));
        jsonarray.AddElement(jsonObjet2);
        FQueryBairroCidadao.DataSet.Next;
      end;

      jsonObjet1.AddPair(TJSONPair.Create('NOMES',jsonarray ));

      Registro.AddElement(jsonObjet1);
      FQueryBairro.DataSeT.next;
    end;

      Res.Send<TJSONValue>(Registro)
       .Status(THTTPStatus.ok);
  end;

  procedure GetBairroTOT( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery :iQuery;
  Registro: TJSONArray;
  IDCidade:string;
  begin
    IDCidade := Req.Params.Items['IDCidade'];
    if IDCidade = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidade ['+IDCidade+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;
    FQuery := TQueryFiredac.New(nil);
    FQuery.SQL('SELECT CI.BAIRRO,(select COUNT(*)TOT FROM CIDADAO WHERE BAIRRO=CI.BAIRRO AND CIDADAO.CIDADE_ID= '+IDCidade+' )TOT '+
                     'FROM CIDADAO CI WHERE CI.CIDADE_ID = '+IDCidade+' GROUP BY CI.BAIRRO ');
    Registro := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(Registro);
  end;

  procedure GetBairroCidadao( Req : THorseRequest; res : THorseResponse; Next : TProc);
  var FQuery :iQuery;
  Registro: TJSONArray;
  IDCidade:string;
  begin
    IDCidade := Req.Params.Items['IDCidade'];
    if IDCidade = EmptyStr then
    begin
      Res.Send( tjsonobject.Create.AddPair('Mensagem', 'Erro pesquisar parametro ID Cidade ['+IDCidade+']'))
         .Status(THTTPStatus.NoContent);
      exit;
    end;
    FQuery := TQueryFiredac.New(nil);
    FQuery.sql('select BAIRRO, NOME FROM cidadao WHERE CIDADE_ID='+IDCidade);
    Registro := FQuery.DataSet.ToJSONArray();
    Res.Send<TJSONARRAY>(Registro);
  end;

procedure Registry_EndPointRelatorio;
begin
  THorse.Get('/RelatorioCidadao',   GetRelatorioCidadao)
        .Get('/RelatorioCidade',    GetRelatorioCidade)
        .GET('/RelatorioBairro/:IDCidade' , GetRelatorioBairro)
        .Get('/RelatorioBairroTOT/:IDCidade', GetBairroTOT)
        .Get('/RelatorioBairroCidadao/:IDCidade', GetBairroCidadao)

end;

end.
