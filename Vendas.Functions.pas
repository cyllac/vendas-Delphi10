unit Vendas.Functions;

interface

uses
  Data.DB;

type
  TVendasFunctions = class
  public
    class procedure ValidarCampo(const ACampo: TField); overload;
    class procedure ValidarCampo(const ACampo: String); overload;
  end;

implementation

uses
  System.SysUtils;

class procedure TVendasFunctions.ValidarCampo(const ACampo: TField);
begin
  if (ACampo.AsString = EmptyStr) then
  begin
    ACampo.FocusControl;
    raise Exception.Create('É necessário informar o campo ' + ACampo.DisplayName);
  end;
end;

class procedure TVendasFunctions.ValidarCampo(const ACampo: String);
var
  I: Integer;
begin
  for I := 1 to Length(ACampo) do
  begin
    if not CharInSet(ACampo[I], ['0'..'9']) then
      raise Exception.Create('é necessário digitar apenas números');
  end;
end;

end.
