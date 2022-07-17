unit MetaclassType;

interface

function GetPropertiesObject(PObject: TObject): string;

implementation

uses
  Rtti, ClassesTestes;

function GetPropertiesObject(PObject: TObject): string;
var
  VContext: TRttiContext;
  VType: TRttiType;
  VProperty: TRttiProperty;
  VAttribute: TCustomAttribute;
  VAttrLabel: string;
begin
  Result := '';
  VContext := TRttiContext.Create;
  VType := VContext.GetType(PObject.ClassInfo);
  for VProperty in VType.GetProperties do
  begin
    if TRttiInstanceType(VProperty.Parent).MetaclassType = PObject.ClassType then
    begin
      VAttrLabel := VProperty.Name;
      for VAttribute in VProperty.GetAttributes do
      begin
        if VAttribute is NameAttribute then
          VAttrLabel := (VAttribute as NameAttribute).Name;
      end;
      Result := Result + VAttrLabel +':'+ VProperty.GetValue(PObject).AsString +',';
    end;
  end;
  Delete(Result,Length(Result),1);
end;

end.
