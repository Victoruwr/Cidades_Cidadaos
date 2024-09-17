unit uClassesInterfaces;

interface
uses
    System.Classes,
    System.JSON,
    REST.Client,
    REST.Types,
    System.Generics.Collections,
    System.SysUtils;

type
 iRequest = interface
   function AddBaseURL(value: String): iRequest;
   function AddHeader(AName: String; AValue: String): iRequest;
   function AddResource(AValue:String):iRequest;
   function AddBody(AJSON:string;const AContentType:TRESTContentType): iRequest;overload;
   function AddBody(FileStream:TFileStream;const AContentType:TRESTContentType): iRequest;overload;
   function AddParameter(AName: String; AValue: Variant): iRequest;
   function AddMethod(value:TRESTRequestMethod):iRequest;
   function Reset: iRequest;
   function Execute :TRESTResponse;
   function Response:TRESTResponse;
  end;

type
    TRequest =class(TInterfacedObject,iRequest)
    private
      FRESTClient: TRESTClient;
      FRESTRequest: TRESTRequest;
      FRESTResponse: TRESTResponse;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iRequest;
      function AddBASEURL(value: String): iRequest;
      function AddHeader(AName: String; AValue: String): iRequest;
      function AddResource(AValue:String):iRequest;
      function AddBody(AJSON:string;const AContentType:TRESTContentType): iRequest;overload;
      function AddBody(FileStream:TFileStream;const AContentType:TRESTContentType): iRequest;overload;
      function AddParameter(AName: String; AValue: Variant): iRequest;
      function AddMethod(value:TRESTRequestMethod):iRequest;
      function Reset: iRequest;
      function Execute :TRESTResponse;
      function Response:TRESTResponse;
  end;

implementation

{ TRequest }

function TRequest.AddBASEURL(value: String): iRequest;
begin
  FRESTClient.BaseURL := value;
  Result := Self;
end;

function TRequest.AddBody(FileStream: TFileStream;
  const AContentType: TRESTContentType): iRequest;
begin
  FRESTRequest.AddBody(FileStream,AContentType);
  Result := Self;
end;

function TRequest.AddBody(AJSON: string;
  const AContentType: TRESTContentType): iRequest;
begin
  FRESTRequest.AddBody(AJSON,AContentType);
  Result := Self;
end;

function TRequest.AddHeader(AName, AValue: String): iRequest;
begin
    FRESTRequest.Params.AddHeader(AName,AValue);
end;

function TRequest.AddMethod(
  value: TRESTRequestMethod): iRequest;
begin
  FRESTRequest.Method:=value;
  Result := Self;
end;

function TRequest.AddParameter(AName: String;
  AValue: Variant): iRequest;
begin
  FRESTRequest.AddParameter( AName, AValue);
  Result := Self;
end;

function TRequest.AddResource(AValue: String): iRequest;
begin
  FRESTRequest.Resource:=AValue;
  Result := Self;
end;

constructor TRequest.Create;
begin
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse:= TRESTResponse.Create(nil);
  FRESTClient := TRESTClient.Create(nil);

  FRESTRequest.Response := FRESTResponse;
  FRESTRequest.Client  := FRESTClient;

  FRESTRequest.Timeout:=60000;
end;

destructor TRequest.Destroy;
begin
  FRESTClient.DisposeOf;
  FRESTRequest.DisposeOf;
  FRESTResponse.DisposeOf;
  inherited;
end;

function TRequest.Execute: TRESTResponse;
begin
  try
    FRESTRequest.Execute;
  finally
    Result := FRESTResponse;
  end;
end;

class function TRequest.New: iRequest;
begin
  Result := Self.Create;
end;

function TRequest.Reset: iRequest;
begin
  FRESTRequest.ResetToDefaults;
  Result := self;
end;

function TRequest.Response: TRESTResponse;
begin
  Result := FRESTResponse;
end;

end.
