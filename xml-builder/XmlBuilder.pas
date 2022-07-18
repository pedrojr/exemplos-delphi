unit XmlBuilder;

interface

type
  IXmlBuilder = interface
    ['{92EDE642-CD1D-43C7-B2ED-F8896DE65D69}']
    /// <summary>Adiciona elemento na estrutura</summary>
    /// <param name="Name">Nome da tag no xml</param>
    /// <param name="Value">Valor da tag no xml</param>
    /// <param name="Conditional">Adiciona ou não o elemento de valor</param>
    function Element(const Name: string; const Value: string = ''; Conditional: Boolean = True): IXmlBuilder;
    /// <summary>Adiciona atributo no elemento ativo</summary>
    /// <param name="Name">Nome do atributo</param>
    /// <param name="Value">Valor do atributo</param>
    function Attribute(const Name, Value: string): IXmlBuilder;
    /// <summary>Retorna Xml como string</summary>
    /// <param name="Pretty">Devolve Xml como string formatada</param>
    function ToStr(Pretty: Boolean = False): string;
    /// <summary>Sobe para o primeiro nível da estrutura</summary>
    function First: IXmlBuilder;
    /// <summary>Sobe um nível na estrutura fechando o elemento ativo</summary>
    function Up: IXmlBuilder;
  end;

function NewXmlBuilder(const Version: string = '1.0'; const Encoding: string = ''): IXmlBuilder;

implementation

uses
  SysUtils, StrUtils, Generics.Collections, Generics.Utils, XmlElement;

type
  TXmlBuilder = class(TInterfacedObject, IXmlBuilder)
  private
    FVersion: string;
    FEncoding: string;
    FActiveElement: TXmlElement;
    FElements: TPairs<string, TXmlElement>;
    function ElementToXml(Element: TXmlElement; Pretty: Boolean; PrettyLevel: Byte = 0): string;
    function AttributesToStr(Attributes: TDictionary<string, string>): string;
    function Indentation(Level: Byte; Increment: Byte = 2): string;
  public
    constructor Create(const Version, Encoding: string);
    destructor Destroy; override;
    function Element(const Name: string; const Value: string = ''; Conditional: Boolean = True): IXmlBuilder;
    function Attribute(const Name, Value: string): IXmlBuilder;
    function ToStr(Pretty: Boolean = False): string;
    function First: IXmlBuilder;
    function Up: IXmlBuilder;
  end;

function NewXmlBuilder(const Version: string = '1.0'; const Encoding: string = ''): IXmlBuilder;
begin
  Result := TXmlBuilder.Create(Version, Encoding);
end;

const
  LineBreak = AnsiString(#13#10);

{ TXmlBuilder }

constructor TXmlBuilder.Create(const Version, Encoding: string);
begin
  FVersion := Version;
  FEncoding := Encoding;
  FActiveElement := nil;
  FElements := TPairs<string, TXmlElement>.Create;
end;

destructor TXmlBuilder.Destroy;
var
  Item: TPair<string, TXmlElement>;
begin
  for Item in FElements do
    Item.Value.Free;
  FElements.Free;
  inherited;
end;

function TXmlBuilder.Element(const Name: string; const Value: string = ''; Conditional: Boolean = True): IXmlBuilder;
var
  Element: TXmlElement;
begin
  if Conditional then
  begin
    Element := TXmlElement.Create(Name, Value, FActiveElement);
    if FActiveElement = nil then
      FElements.Add(Name, Element)
    else
      FActiveElement.Elements.Add(Name, Element);
    FActiveElement := Element;
  end
  else if Value = '' then
    raise Exception.Create('Valueless element cannot be ignored.');
  Result := Self;
end;

function TXmlBuilder.Attribute(const Name, Value: string): IXmlBuilder;
begin
  if FActiveElement = nil then
    raise Exception.Create('Active element not defined.');
  FActiveElement.Attributes.AddOrSetValue(Name, Value);
  Result := Self;
end;

function TXmlBuilder.First: IXmlBuilder;
begin
  FActiveElement := nil;
  Result := Self;
end;

function TXmlBuilder.Up: IXmlBuilder;
begin
  if (FActiveElement <> nil) and (FActiveElement.Parent <> nil) then
    FActiveElement := FActiveElement.Parent;
  Result := Self;
end;

function TXmlBuilder.ToStr(Pretty: Boolean = False): string;
var
  Item: TPair<string, TXmlElement>;
begin
  Result := '<?xml version="'+ FVersion +
            IfThen(FEncoding <> '', '" encoding="'+ FEncoding) +'"?>'+
            IfThen(Pretty, LineBreak);
  if FActiveElement = nil then
  begin
    for Item in FElements do
      Result := Result + ElementToXml(Item.Value, Pretty);
  end
  else
    Result := Result + ElementToXml(FActiveElement, Pretty);
  Result := Trim(Result) + LineBreak;
end;

function TXmlBuilder.ElementToXml(Element: TXmlElement; Pretty: Boolean; PrettyLevel: Byte = 0): string;
var
  Attributes: string;
  Item: TPair<string, TXmlElement>;
begin
  if not Assigned(Element) then
    Exit;
  Attributes := AttributesToStr(Element.Attributes);
  Result := IfThen(Pretty, Indentation(PrettyLevel)) +
            '<'+ Element.Name + IfThen(Attributes <> '', ' '+ Attributes) +'>';
  if Element.Value <> '' then
    Result := Result + Element.Value +'</'+ Element.Name +'>'+
              IfThen(Pretty, LineBreak)
  else
  begin
    Result := Result + IfThen(Pretty, LineBreak);
    for Item in Element.Elements do
      Result := Result + ElementToXml(Item.Value, Pretty, PrettyLevel + 1);
    Result := Result + IfThen(Pretty, Indentation(PrettyLevel)) +
              '</'+ Element.Name +'>'+ IfThen(Pretty, LineBreak);
  end;
end;

function TXmlBuilder.AttributesToStr(Attributes: TDictionary<string, string>): string;
var
  Key: string;
begin
  Result := '';
  for Key in Attributes.Keys do
    Result := Result + Key +'="'+ Attributes.Items[Key] +'" ';
  Result := Trim(Result);
end;

function TXmlBuilder.Indentation(Level: Byte; Increment: Byte = 2): string;
var
  Spaces: Integer;
begin
  Result := '';
  Spaces := Level * Increment;
  while Length(Result) < Spaces do
    Result := Result + ' ';
end;

end.
