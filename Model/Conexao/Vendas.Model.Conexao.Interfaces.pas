unit Vendas.Model.Conexao.Interfaces;

interface

uses
  Data.DB;

type
  iModelConexaoParametros = interface;
  iModelConexaoSchemaAdapter = interface;

  iModelConexao = interface
    ['{C109D2D6-0204-49DA-BAE7-E6F95D2EF35C}']
    function Conectar: iModelConexao;
    function EndConexao: TCustomConnection;
    function Parametros: iModelConexaoParametros;
    function SchemaAdapter: iModelConexaoSchemaAdapter;
    procedure StartTransaction;
  end;

  iModelConexaoParametros = interface
    ['{617C6C25-8DA1-427B-A8F8-275953112DAE}']
    function Database(const AValue: String): iModelConexaoParametros;
    function UserName(const AValue: String): iModelConexaoParametros;
    function Password(const AValue: String): iModelConexaoParametros;
    function DriverID(const AValue: String): iModelConexaoParametros;
    function Server(const AValue: String): iModelConexaoParametros;
    function Porta(const AValue: Integer): iModelConexaoParametros;
    function SalvarSenha(const AValue: Boolean): iModelConexaoParametros;
    function EndParametros: iModelConexao;
  end;

  iModelConexaoSchemaAdapter = interface
    ['{EFAD2463-391C-4DB8-B026-C915DDB9F660}']
    function Close: iModelConexaoSchemaAdapter;
    procedure Open;
    function ApplyUpdates(const AMaxErrors: Integer=-1): Integer;
    procedure CancelUpdates;
    function EndSchemaAdapter: iModelConexao;
  end;

  iModelConexaoFactory = interface
    ['{503E7C26-73AD-446B-9943-6068AAC4270B}']
    function ConexaoFiredac: iModelConexao;
  end;

implementation

end.
