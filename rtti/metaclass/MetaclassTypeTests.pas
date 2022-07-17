unit MetaclassTypeTests;

interface

uses
  TestFramework, Classes;

type
  TestMetaclassType = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetPropertiesObject;
  end;

implementation

uses
  MetaclassType, ClassesTestes;

procedure TestMetaclassType.SetUp;
begin
end;

procedure TestMetaclassType.TearDown;
begin
end;

procedure TestMetaclassType.TestGetPropertiesObject;
var
  ObjAttr: TClasseAttr;
  ObjStr: string;
begin
  ObjAttr := nil;
  try
    ObjAttr := TClasseAttr.Create;
    ObjAttr.Id := '1234567890';
    ObjStr := GetPropertiesObject(ObjAttr);
    CheckEquals('Código:1234567890', ObjStr);
  finally
    ObjAttr.Free;
  end;
end;

initialization
  RegisterTest(TestMetaclassType.Suite);
end.

