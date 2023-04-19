unit Vendas.Functions;

interface

uses
  Data.DB;

type
  TVendasFunctions = class
  public
    class procedure ValidarCampo(const ACampo: TField); overload;
    class procedure ValidarCampo(const ACampo: String); overload;
    class function ExtractResource(const AResourceName: String; const APath:String): String;
    class function PegarNomeArquivoINI: String;
    class function CriptografarSenha(const ASenha: string): string;
    class function DescriptografarSenha(const ASenhaCriptografada: string): string;
  end;

const
  SECTION_INI = 'Configurações';

implementation

uses
  System.SysUtils, System.Classes, System.Types, Vcl.Dialogs, System.NetEncoding;

class procedure TVendasFunctions.ValidarCampo(const ACampo: TField);
begin
  if (ACampo.AsString = EmptyStr) then
  begin
    ACampo.FocusControl;
    raise Exception.Create('É necessário informar o campo ' + ACampo.DisplayName);
  end;

  if (ACampo.InheritsFrom(TFloatField)) and (ACampo.AsFloat <= 0) then
  begin
    ACampo.FocusControl;
    raise Exception.Create('O campo ' + ACampo.DisplayName + ' precisa ser maior que zero.');
  end;
end;

class function TVendasFunctions.PegarNomeArquivoINI: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Vendas.ini';
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

class function TVendasFunctions.CriptografarSenha(const ASenha: string): string;
var
  Encoder: TBase64Encoding;
begin
  Encoder := TBase64Encoding.Create();
  try
    Result := TEncoding.UTF8.GetString(Encoder.Encode(TEncoding.UTF8.GetBytes(ASenha)));
  finally
    Encoder.Free();
  end;
end;

class function TVendasFunctions.DescriptografarSenha(const ASenhaCriptografada: string): string;
var
  Encoder: TBase64Encoding;
begin
  Encoder := TBase64Encoding.Create();
  try
    Result := TEncoding.UTF8.GetString(Encoder.DecodeStringToBytes(ASenhaCriptografada));
  finally
    Encoder.Free();
  end;
end;

class function TVendasFunctions.ExtractResource(const AResourceName: String; const APath:String): String;
var
  Arquivo: TResourceStream;
begin
  Result := APath;

  if (not FileExists(APath)) then
  begin
    Arquivo := TResourceStream.Create(HInstance, AResourceName, RT_RCDATA);
    try
      Result := APath;
      Arquivo.SaveToFile(Result);
    finally
      FreeAndNil(Arquivo);
    end;
  end;
end;



end.
