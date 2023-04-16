unit Vendas.Controller.Conexao.Interfaces;

interface

uses
  Vendas.Model.Conexao.Interfaces;

type
  iControllerConexao = interface
    ['{886F91F3-3131-44D3-BE32-DE4F2EA07A74}']
    function Model: iModelConexao;
  end;

  iControllerConexaoFactory = interface
    ['{B1C095B9-B84B-433F-AF62-3957C062377A}']
    function Conexao: iControllerConexao;
  end;

implementation

end.
