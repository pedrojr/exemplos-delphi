unit XmlElement;

interface

uses
  Generics.Collections, Generics.Utils;

type
  TXmlElement = class
  private
    FName: string;
    FValue: string;
    FParent: TXmlElement;
    FElements: TPairs<string, TXmlElement>;
    FAttributes: TDictionary<string, string>;
  public
    constructor Create(const Name, Value: string; Parent: TXmlElement = nil);
    destructor Destroy; override;
    property Name: string read FName;
    property Value: string read FValue;
    property Parent: TXmlElement read FParent;
    property Elements: TPairs<string, TXmlElement> read FElements;
    property Attributes: TDictionary<string, string> read FAttributes;
  end;

implementation

{ TXmlElement }

constructor TXmlElement.Create(const Name, Value: string; Parent: TXmlElement = nil);
begin
  FName := Name;
  FValue := Value;
  FParent := Parent;
  FElements := TPairs<string, TXmlElement>.Create;
  FAttributes := TDictionary<string, string>.Create;
end;

destructor TXmlElement.Destroy;
var
  Item: TPair<string, TXmlElement>;
begin
  for Item in FElements do
    Item.Value.Free;
  FElements.Free;
  FAttributes.Free;
  inherited;
end;

end.
