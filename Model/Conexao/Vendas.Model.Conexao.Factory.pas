unit Vendas.Model.Conexao.Factory;

interface

uses
  Vendas.Model.Conexao.Interfaces;

type
  TModelConexaoFactory = class(TInterfacedObject, iModelConexaoFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelConexaoFactory;
      function ConexaoFiredac: iModelConexao;
  end;


implementation

uses
  Vendas.Model.Conexao.Firedac;

function TModelConexaoFactory.ConexaoFiredac: iModelConexao;
begin
  Result := TModelConexaoFiredac.New;
end;

constructor TModelConexaoFactory.Create;
begin

end;

destructor TModelConexaoFactory.Destroy;
begin

  inherited;
end;

class function TModelConexaoFactory.New: iModelConexaoFactory;
begin
  Result := Self.Create;
end;

end.
