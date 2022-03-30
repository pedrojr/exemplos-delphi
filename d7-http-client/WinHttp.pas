unit WinHttp;

interface

uses
  ActiveX, Classes, WinHttp_TLB;

type
  IWinHttp = interface
    function Prepare: IWinHttp;
    function AddHeader(const Key, Value: string): IWinHttp;
    function AddParam(const Key, Value: string): IWinHttp;
    function SetProxy(ProxySetting: Integer; ProxyServer: OleVariant; BypassList: OleVariant): IWinHttp;
    function SetTimeout(Timeout: Integer): IWinHttp;

    function GET(const Command: string): Boolean;
    function POST(const Command: string): Boolean; overload;
    function POST(const Command, Params: string): Boolean; overload;
    function PUT(const Command: string): Boolean;
    function DELETE(const Command: string): Boolean;
    
    function GetResponseData: string;
    function GetResponseStream: IStream;
    function GetStatusCode: Integer;
    property ResponseData: string read GetResponseData;
    property ResponseStream: IStream read GetResponseStream;
    property StatusCode: Integer read GetStatusCode;
  end;

  TKeyValue = record
    Key: string;
    Value: string;
  end;

  TWinHttp = class(TInterfacedObject, IWinHttp)
  private
    FHeaders: array of TKeyValue;
    FParams: array of TKeyValue;
    FUrl: string;
    FResponseData: string;
    FResponseStream: IStream;
    FStatusCode: Integer;
    FProxySetting: Integer;
    FProxyServer: OleVariant;
    FBypassList: OleVariant;
    FTimeout: Integer;
    function GetResponseData: string;
    function GetResponseStream: IStream;
    function GetStatusCode: Integer;
    function HttpRequest(const Method, Command: string; const Params: string = ''): Boolean;
    procedure ConfigHttpReq(HttpReq: IWinHttpRequest);
    function GetParams: AnsiString;
  public
    constructor Create(const AUrl: string);
    destructor Destroy; override;

    function Prepare: IWinHttp;
    function AddHeader(const Key, Value: string): IWinHttp;
    function AddParam(const Key, Value: string): IWinHttp;
    function SetProxy(ProxySetting: Integer; ProxyServer: OleVariant; BypassList: OleVariant): IWinHttp;
    function SetTimeout(Timeout: Integer): IWinHttp;

    function GET(const Command: string): Boolean;
    function POST(const Command: string): Boolean; overload;
    function POST(const Command, Params: string): Boolean; overload;
    function PUT(const Command: string): Boolean;
    function DELETE(const Command: string): Boolean;

    property ResponseData: string read GetResponseData;
    property ResponseStream: IStream read GetResponseStream;
    property StatusCode: Integer read GetStatusCode;
  end;

implementation

uses
  SysUtils, Variants;

{ TWinHttp }

constructor TWinHttp.Create(const AUrl: string);
begin
  SetLength(FHeaders, 0);
  SetLength(FParams, 0);
  FProxySetting := 0;
  FProxyServer := EmptyStr;
  FBypassList := EmptyStr;
  FTimeout := 10000;
  FUrl := AUrl;
end;

destructor TWinHttp.Destroy;
begin
  SetLength(FHeaders, 0);
  SetLength(FParams, 0);
  inherited;
end;

function TWinHttp.Prepare: IWinHttp;
begin
  SetLength(FHeaders, 0);
  SetLength(FParams, 0);
  Result := Self;
end;

function TWinHttp.AddHeader(const Key, Value: string): IWinHttp;
begin
  SetLength(FHeaders, Length(FHeaders) +1);
  FHeaders[High(FHeaders)].Key := Key;
  FHeaders[High(FHeaders)].Value := Value;
  Result := Self;
end;

function TWinHttp.AddParam(const Key, Value: string): IWinHttp;
begin
  SetLength(FParams, Length(FParams) +1);
  FParams[High(FParams)].Key := Key;
  FParams[High(FParams)].Value := Value;
  Result := Self;
end;

function TWinHttp.SetProxy(ProxySetting: Integer; ProxyServer: OleVariant; BypassList: OleVariant): IWinHttp;
begin
  FProxySetting := ProxySetting;
  FProxyServer := ProxyServer;
  FBypassList := BypassList;
  Result := Self;
end;

function TWinHttp.SetTimeout(Timeout: Integer): IWinHttp;
begin
  FTimeout := Timeout;
  Result := Self;
end;

function TWinHttp.GET(const Command: string): Boolean;
begin
  Result := HttpRequest('GET', Command);
end;

function TWinHttp.POST(const Command: string): Boolean;
begin
  Result := HttpRequest('POST', Command);
end;

function TWinHttp.POST(const Command, Params: string): Boolean;
begin
  Result := HttpRequest('POST', Command, Params);
end;

function TWinHttp.PUT(const Command: string): Boolean;
begin
  Result := HttpRequest('PUT', Command);
end;

function TWinHttp.DELETE(const Command: string): Boolean;
begin
  Result := HttpRequest('DELETE', Command);
end;

function TWinHttp.HttpRequest(const Method, Command: string; const Params: string = ''): Boolean;
var
  HttpReq: IWinHttpRequest;
  Body: AnsiString;
begin
  try
    HttpReq := CoWinHttpRequest.Create;
    HttpReq.Open(Method, FUrl + Command, False);
    ConfigHttpReq(HttpReq);
    if (Params = '') then
    begin
      Body := GetParams;
      if (Trim(string(Body)) = EmptyStr) then
        HttpReq.Send(EmptyParam)
      else
        HttpReq.Send(Body);
    end
    else
      HttpReq.Send(Params);
      
    FResponseData := HttpReq.ResponseText;
    FResponseStream := IUnknown(HttpReq.ResponseStream) as IStream;
    FStatusCode := HttpReq.Status;
    Result:= (FStatusCode = 200);
  except
    on E: Exception do
      raise Exception.Create('Falha ao executar HttpRequest: '+ E.Message);
  end;
end;

procedure TWinHttp.ConfigHttpReq(HttpReq: IWinHttpRequest);
var
  I: Integer;
begin
  HttpReq.SetProxy(FProxySetting, FProxyServer, FBypassList);
  HttpReq.SetTimeouts(FTimeout, FTimeout, FTimeout, FTimeout);

  for I := Low(FHeaders) to High(FHeaders) do
    HttpReq.SetRequestHeader(FHeaders[I].Key, FHeaders[I].Value);

end;

function TWinHttp.GetParams: AnsiString;
var
  I: Integer;
  Return: string;
begin
  Return := EmptyStr;
  for I := Low(FParams) to High(FParams) do
    Return := Return + FParams[I].Key + '=' + FParams[I].Value +'&';
  System.Delete(Return, Length(Return), 1);
  Result := AnsiString(Return);
end;

function TWinHttp.GetResponseData: string;
begin
  Result := FResponseData;
end;

function TWinHttp.GetResponseStream: IStream;
begin
  Result := FResponseStream;
end;

function TWinHttp.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

end.
