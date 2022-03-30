unit ServerClasses;

interface

type
  TProduto = class
  private
    FId: Integer;
    FDescricao: string;
    FPreco: Currency;
  public
    constructor Create(PId: Integer; const PDescricao: string; PPreco: Currency);
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write FDescricao;
    property Preco: Currency read FPreco write FPreco;
  end;

implementation

{ TProduto }

constructor TProduto.Create(PId: Integer; const PDescricao: string; PPreco: Currency);
begin
  FId := PId;
  FDescricao := PDescricao;
  FPreco := PPreco;
end;

end.

