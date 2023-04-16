unit PedidoVendasModel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.UI, FireDAC.Comp.DataSet, Datasnap.DBClient, Vendas.Model.Conexao.Firedac,
  Vendas.Model.Conexao.Interfaces;

type
  TPedidoVendas = class(TDataModule)
    fdqPedido: TFDQuery;
    dtsPedido: TDataSource;
    fdqCliente: TFDQuery;
    dtsCliente: TDataSource;
    fdqClienteNOME_CLIENTE: TStringField;
    fdqClienteCIDADE_CLIENTE: TStringField;
    fdqClienteUF_CLIENTE: TStringField;
    fdqPedidoDATA_EMISSAO_PEDIDO: TDateField;
    fdqPedidoCODIGO_CLIENTE: TIntegerField;
    fdqPedidoNOME_CLIENTE: TStringField;
    fdqPedidoCIDADE_CLIENTE: TStringField;
    fdqPedidoUF_CLIENTE: TStringField;
    fdqPedidoVALOR_TOTAL_PEDIDO: TBCDField;
    fdqPedidonumero_pedido: TFDAutoIncField;
    procedure fdqPedidoCODIGO_CLIENTEChange(Sender: TField);
    procedure fdqPedidoNUMERO_PEDIDOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    FModelConexao: iModelConexao;
  public
    procedure CarregarPedidoVendas(const NumeroPedido: String);
    procedure InserirPedido;
    procedure GravarPedido;
    procedure CancelarPedido;
    constructor Create(AOwner: TComponent); override;
    property ModelConexao: iModelConexao read FModelConexao write FModelConexao;
  end;

var
  PedidoVendas: TPedidoVendas;

implementation

uses
  Vcl.Dialogs, Vendas.Helpers, System.Types, System.StrUtils, System.UITypes,
  Vendas.Model.Conexao.Factory, PedidoVendasItemModel;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPedidoVendas.CancelarPedido;
begin
  FModelConexao.SchemaAdapter.CancelUpdates;
  PedidoVendasItem.LimparItemAtual;
  InserirPedido;
end;

procedure TPedidoVendas.CarregarPedidoVendas(const NumeroPedido: String);

  procedure ValidarCampo;
  var
    I: Integer;
  begin
    for I := 1 to Length(NumeroPedido) do
    begin
      if not CharInSet(NumeroPedido[I], ['0'..'9']) then
        raise Exception.Create('é necessário digitar apenas números');
    end;
  end;

begin
  if (NumeroPedido.IsEmpty) then
    Exit;

  ValidarCampo;

  fdqPedido.Close;
  fdqPedido.ParamByName('NUMERO_PEDIDO_PRM').Value := NumeroPedido;
  fdqPedido.Open;
  fdqPedido.Edit;

  PedidoVendasItem.fdqPedidoItem.Close;
  PedidoVendasItem.fdqPedidoItem.Open;
end;

constructor TPedidoVendas.Create(AOwner: TComponent);
begin
  inherited;
  FModelConexao :=
    TModelConexaoFactory
      .New
        .ConexaoFiredac;
end;

procedure TPedidoVendas.fdqPedidoCODIGO_CLIENTEChange(Sender: TField);
begin
  fdqCliente.Close;
  fdqCliente.ParamByName('CODIGO_CLIENTE_PRM').Value := PedidoVendas.fdqPedidoCODIGO_CLIENTE.AsVariant;
  fdqCliente.Open;

  if (not fdqClienteNOME_CLIENTE.IsNull) then
  begin
    fdqPedidoNOME_CLIENTE.AsString := fdqClienteNOME_CLIENTE.AsString;
    fdqPedidoCIDADE_CLIENTE.AsString := fdqClienteCIDADE_CLIENTE.AsString;
    fdqPedidoUF_CLIENTE.AsString := fdqClienteUF_CLIENTE.AsString;
  end
  else
  begin
    fdqPedidoNOME_CLIENTE.Clear;
    fdqPedidoCIDADE_CLIENTE.Clear;
    fdqPedidoUF_CLIENTE.Clear;

    if (not fdqPedidoCODIGO_CLIENTE.IsNull) then
    begin
      fdqPedidoCODIGO_CLIENTE.Clear;
      fdqPedidoCODIGO_CLIENTE.FocusControl;
      MessageDlg('O cliente informado não existe. Verifique.', mtError, [mbOK], 0);
    end;
  end;
end;

procedure TPedidoVendas.GravarPedido;

  procedure ValidarCampos;
  begin
    if (fdqPedidoCODIGO_CLIENTE.IsNull) then
    begin
      fdqPedidoCODIGO_CLIENTE.Clear;
      fdqPedidoCODIGO_CLIENTE.FocusControl;
      raise Exception.Create('É necessário informar o cliente.');
    end;

    if (PedidoVendasItem.fdqPedidoItem.IsEmpty) then
    begin
      PedidoVendasItem.CdsItemAtualCODIGO_PRODUTO.Clear;
      PedidoVendasItem.CdsItemAtualCODIGO_PRODUTO.FocusControl;

      raise Exception.Create('É necessário informar pelo menos um item no pedido.');
    end;
  end;

begin
  ValidarCampos;

  FModelConexao.StartTransaction;
  try
    if (FModelConexao.SchemaAdapter.ApplyUpdates(0) = 0) then
      TFDConnection(FModelConexao.EndConexao).Commit
    else
      TFDConnection(FModelConexao.EndConexao).Rollback;
  except
    on e: Exception do
    begin
      TFDConnection(FModelConexao.EndConexao).Rollback;
      raise Exception.Create(e.Message);
    end;
  end;

  PedidoVendasItem.LimparItemAtual;
  InserirPedido;
end;

procedure TPedidoVendas.InserirPedido;
begin
  FModelConexao
    .SchemaAdapter
      .Close
      .Open;

  fdqPedido.Append;
  fdqPedidonumero_pedido.AsInteger :=
    TFDConnection(FModelConexao.EndConexao).ExecSQLScalar('select max(p.numero_pedido) from pedidos p').toInteger + 1;

  fdqPedido.Post;
  fdqPedido.Edit;
  fdqPedidoDATA_EMISSAO_PEDIDO.AsDateTime := Now;
end;

procedure TPedidoVendas.fdqPedidoNUMERO_PEDIDOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.AsInteger <= 0) then
    Text := EmptyStr
  else
    Text := Sender.AsString;
end;

end.

