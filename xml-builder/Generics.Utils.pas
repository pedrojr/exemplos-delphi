unit Generics.Utils;

interface

uses
  Generics.Collections;

type
  //Uso do TList para manter a ordenação de acordo com a adição dos itens
  TPairs<TKey, TValue> = class(TList<TPair<TKey, TValue>>)
  public
    procedure Add(const AKey: TKey; const AValue: TValue); overload;
  end;

implementation

{ TPairs }

procedure TPairs<TKey, TValue>.Add(const AKey: TKey; const AValue: TValue);
var
  Pair: TPair<TKey, TValue>;
begin
  Pair.Create(AKey, AValue);
  inherited Add(Pair);
end;

end.
