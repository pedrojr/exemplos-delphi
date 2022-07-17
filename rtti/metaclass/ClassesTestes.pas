unit ClassesTestes;

interface

uses
  Classes;

type
  NameAttribute = class(TCustomAttribute)
  private
    FName: string;
  public
    property Name: string read FName;
    constructor Create(const PName: string);
    function GetValue(const PValue: string): string;
  end;

  TClasseBase = class
  protected
    FId: string;
  public
    property Id: string read FId write FId;
  end;

  TClasseAttr = class(TClasseBase)
  published
    [Name('Código')]
    property Id;
  end;

implementation

{ NameAttribute }

constructor NameAttribute.Create(const PName: string);
begin
  FName := PName;
end;

function NameAttribute.GetValue(const PValue: string): string;
begin
  Result := FName;
end;

end.
