unit Vendas.Controller.Conexao;

interface

uses
  Vendas.Controller.Conexao.Interfaces, Vendas.Model.Conexao.Interfaces;

type
  TControllerConexao = class(TInterfacedObject, iControllerConexao)
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerConexao;
    function Model: iModelConexao;
  end;

var
  ModelConexao: iModelConexao;

implementation

uses
  Vendas.Model.Conexao.Factory;

constructor TControllerConexao.Create;
begin
  ModelConexao := TModelConexaoFactory.New.ConexaoFiredac;
end;

destructor TControllerConexao.Destroy;
begin

  inherited;
end;

function TControllerConexao.Model: iModelConexao;
begin
  Result := ModelConexao;
end;

class function TControllerConexao.New: iControllerConexao;
begin
  Result := Self.Create;
end;

end.
