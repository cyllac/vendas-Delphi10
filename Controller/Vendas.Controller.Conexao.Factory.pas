unit Vendas.Controller.Conexao.Factory;

interface

uses
  Vendas.Controller.Conexao.Interfaces, Vendas.Model.Conexao.Interfaces;

type
  TControllerConexaoFactory = class(TInterfacedObject, iControllerConexaoFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerConexaoFactory;
      function Conexao : iControllerConexao;
  end;

implementation

uses
  System.SysUtils, Vendas.Controller.Conexao;

function TControllerConexaoFactory.Conexao: iControllerConexao;
begin
  Result := TControllerConexao.New;
end;

constructor TControllerConexaoFactory.Create;
begin

end;

destructor TControllerConexaoFactory.Destroy;
begin

  inherited;
end;

class function TControllerConexaoFactory.New: iControllerConexaoFactory;
begin
  Result := Self.Create;
end;

end.
