unit SimpleDictionary;

interface

uses
  SysUtils, Classes;

type
  TSimpleDictionary = class
  private
    FItems: TStringList;
    function GetCount: Integer;
    function GetObject(const aKey: string): TObject;
    function GetKey(Index: Integer): string;
  public
    constructor Create;
    destructor Destroy; override;
    function ContainsKey(const aKey: string): Boolean;
    procedure AddOrSet(const aKey: string; aObject: TObject);
    procedure Remove(const aKey: string);
    procedure Clear;
    property Count: Integer read GetCount;
    property Keys[Index: Integer]: string read GetKey;
    property Objects[const aKey: string]: TObject read GetObject;
  end;

implementation

{ TSimpleDictionary }

constructor TSimpleDictionary.Create;
begin
  FItems := TStringList.Create;
end;

destructor TSimpleDictionary.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TSimpleDictionary.ContainsKey(const aKey: string): Boolean;
begin
  Result := FItems.IndexOf(aKey) >= 0;
end;

procedure TSimpleDictionary.AddOrSet(const aKey: string; aObject: TObject);
var
  Key: String;
  Index: Integer;
begin
  Index := FItems.IndexOf(aKey);
  if Index >= 0 then
    Remove(aKey);
  SetString(Key, PChar(aKey), StrLen(PChar(aKey)));
  FItems.AddObject(Key, aObject);
end;

procedure TSimpleDictionary.Remove(const aKey: string);
var
  Index: Integer;
begin
  Index := FItems.IndexOf(aKey);
  if Index >= 0 then
  begin
    FItems.Objects[Index].Free;
    FItems.Delete(Index);
  end;
end;

procedure TSimpleDictionary.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count -1 do
    FItems.Objects[I].Free;
  FItems.Clear;
end;

function TSimpleDictionary.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TSimpleDictionary.GetKey(Index: Integer): string;
begin
  Result := '';
  if (Index >= 0) and (Index < FItems.Count) then
    Result := FItems.Strings[Index];
end;

function TSimpleDictionary.GetObject(const aKey: string): TObject;
var
  Index: Integer;
begin
  Result := nil;
  Index := FItems.IndexOf(aKey);
  if Index >= 0 then
    Result := FItems.Objects[Index];
end;

end.
