unit Vendas.Helpers;

interface

uses
  Controls, System.Variants;

type
  TCaptionHelper = record helper for TCaption
    function toInteger: Integer;
  end;

  TVariantHelper = record helper for Variant
    function toInteger: Integer;
  end;

implementation

uses
  System.SysUtils;

function TCaptionHelper.toInteger: Integer;
begin
  Result := StrToInt(Self);
end;

function TVariantHelper.toInteger: Integer;
begin
  Result := StrToIntDef(VarToStrDef(Self, EmptyStr), 0);
end;

end.
