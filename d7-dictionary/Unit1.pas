unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SimpleDictionary;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Dictionary: TSimpleDictionary;
  O: TObject;
  I: Integer;
begin
  Dictionary := nil;
  try
    Dictionary := TSimpleDictionary.Create;

    Memo1.Lines.Add('Add: 001,002,003,004,005');
    Dictionary.AddOrSet('001', TObject.Create);
    Dictionary.AddOrSet('002', TObject.Create);
    Dictionary.AddOrSet('003', TObject.Create);
    Dictionary.AddOrSet('004', TObject.Create);
    Dictionary.AddOrSet('005', TObject.Create);
    Memo1.Lines.Add('Count: '+ IntToStr(Dictionary.Count));

    if Dictionary.ContainsKey('003') then
    begin
      Dictionary.Remove('003');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Remove 003');
      Memo1.Lines.Add('Count: '+ IntToStr(Dictionary.Count));
    end;

    Memo1.Lines.Add('');
    for I := 0 to Dictionary.Count -1 do
      Memo1.Lines.Add(Dictionary.Keys[I]);

    Memo1.Lines.Add('');
    O := Dictionary.Objects['005'];
    Memo1.Lines.Add(O.ClassName);

    Dictionary.Clear;
  finally
    Dictionary.Free;
  end;
end;

end.
