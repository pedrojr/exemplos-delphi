unit ServerMethods;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Generics.Collections, ServerClasses, System.JSON;

type
{$METHODINFO ON}
  Vendas = class(TComponent)
  private
    { Private declarations }
    FProdutos: TDictionary<Integer,TProduto>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //Get
    function Produtos(const Id: Integer): string;
    //Post
    function UpdateProdutos(const Produto: TJSONObject): string;
    //Put
    function AcceptProdutos(const Produto: TJSONObject): string;
    //Delete
    function CancelProdutos(const Id: Integer): string;
  end;
{$METHODINFO OFF}

implementation

uses System.StrUtils, Contnrs, Data.DBXPlatform, Rest.Json;

{ Vendas }

constructor Vendas.Create(AOwner: TComponent);
begin
  inherited;
  FProdutos := TDictionary<Integer,TProduto>.Create;
  FProdutos.Add(1,TProduto.Create(1,'Produto 001', 3.5));
  FProdutos.Add(2,TProduto.Create(2,'Produto 001', 11.45));
  FProdutos.Add(3,TProduto.Create(3,'Produto 001', 9.99));
end;

destructor Vendas.Destroy;
var
  Produto: TProduto;
begin
  for Produto in FProdutos.Values do
    Produto.Free;
  FProdutos.Free;
  inherited;
end;

//Get
function Vendas.Produtos(const Id: Integer): string;
var
  JsonArray: TJSONArray;
  Produto: TProduto;
begin
  GetInvocationMetadata.ResponseContentType := 'application/json';
  try
    JsonArray := TJSONArray.Create;
    try
      if (Id > 0) and FProdutos.ContainsKey(Id) then
        JsonArray.AddElement(TJson.ObjectToJsonObject(FProdutos.Items[Id]))
      else
      begin
        for Produto in FProdutos.Values do
          JsonArray.AddElement(TJson.ObjectToJsonObject(Produto));
      end;
      GetInvocationMetadata.ResponseContent := JsonArray.ToString;
      GetInvocationMetadata.ResponseCode := 200; //Ok
    finally
      JsonArray.Free;
    end;
  except
    on E: Exception do
    begin
      GetInvocationMetadata.ResponseContent := '{"Msg":"'+ E.Message +'"}';
      GetInvocationMetadata.ResponseCode := 500; //Internal Server Error
    end;
  end;
end;

//Post
function Vendas.UpdateProdutos(const Produto: TJSONObject): string;
var
  Id: Integer;
  Descricao: string;
  Preco: Currency;
begin
  try
    Id := StrToIntDef(Produto.Values['Id'].ToString,0);
    if (Id > 0) and (not FProdutos.ContainsKey(Id)) then
    begin
      Descricao := Produto.Values['Descricao'].ToString;
      Preco := StrToFloatDef(ReplaceStr(Produto.Values['Preco'].ToString,'.',','),0);
      FProdutos.Add(Id, TProduto.Create(Id,Descricao,Preco));
      GetInvocationMetadata.ResponseContent := '{"Msg":"Ok"}';
      GetInvocationMetadata.ResponseCode := 201; //Created
    end
    else
      GetInvocationMetadata.ResponseContent := '{"Msg":"Produto já existe."}';
  except
    on E: Exception do
    begin
      GetInvocationMetadata.ResponseContent := '{"Msg":"'+ E.Message +'"}';
      GetInvocationMetadata.ResponseCode := 500; //Internal Server Error
    end;
  end;
end;

//Put
function Vendas.AcceptProdutos(const Produto: TJSONObject): string;
var
  Id: Integer;
  Prod: TProduto;
begin
  try
    Id := StrToIntDef(Produto.Values['Id'].ToString,0);
    if (Id > 0) and (FProdutos.ContainsKey(Id)) then
    begin
      Prod := FProdutos.Items[Id];
      Prod.Descricao := Produto.Values['Descricao'].ToString;
      Prod.Preco := StrToFloatDef(ReplaceStr(Produto.Values['Preco'].ToString,'.',','),0);
      GetInvocationMetadata.ResponseContent := '{"Msg":"Ok"}';
      GetInvocationMetadata.ResponseCode := 204; //No Content
    end
    else
      GetInvocationMetadata.ResponseContent := '{"Msg":"Produto não existe."}';
  except
    on E: Exception do
    begin
      GetInvocationMetadata.ResponseContent := '{"Msg":"'+ E.Message +'"}';
      GetInvocationMetadata.ResponseCode := 500; //Internal Server Error
    end;
  end;
end;

//Delete
function Vendas.CancelProdutos(const Id: Integer): string;
begin
  try
    if (Id > 0) and (FProdutos.ContainsKey(Id)) then
    begin
      FProdutos.Items[Id].Free;
      FProdutos.Remove(Id);
      GetInvocationMetadata.ResponseContent := '{"Msg":"Ok"}';
      GetInvocationMetadata.ResponseCode := 204; //No Content
    end
    else
      GetInvocationMetadata.ResponseContent := '{"Msg":"Produto não existe."}';
  except
    on E: Exception do
    begin
      GetInvocationMetadata.ResponseContent := '{"Msg":"'+ E.Message +'"}';
      GetInvocationMetadata.ResponseCode := 500; //Internal Server Error
    end;
  end;
end;

end.

