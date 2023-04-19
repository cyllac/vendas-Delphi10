unit PedidoVendasModel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.UI, FireDAC.Comp.DataSet, Datasnap.DBClient, Vendas.Model.Conexao.Firedac, Vendas.Model.Conexao.Interfaces;

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
  public
    constructor Create(AOwner: TComponent); override;

    procedure CarregarPedidoVendas(const NumeroPedido: String);
    procedure InserirPedido;
    procedure GravarPedido;
    procedure CancelarPedido;
    procedure ExcluirPedidoVendas(const NumeroPedido: String);
  end;

var
  PedidoVendas: TPedidoVendas;

implementation

uses
  Vcl.Dialogs, Vendas.Helpers, System.Types, System.StrUtils, System.UITypes, Vendas.Model.Conexao.Factory, PedidoVendasItemModel,
  Vendas.Controller.Conexao, Vendas.Functions;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPedidoVendas.CancelarPedido;
begin
  ModelConexao.SchemaAdapter.CancelUpdates;
  InserirPedido;
end;

procedure TPedidoVendas.CarregarPedidoVendas(const NumeroPedido: String);
begin
  if (NumeroPedido.IsEmpty) then
    Exit;

  TVendasFunctions.ValidarCampo(NumeroPedido);

  fdqPedido.Close;
  fdqPedido.ParamByName('NUMERO_PEDIDO_PRM').Value := NumeroPedido;
  fdqPedido.Open;

  if (not fdqPedidonumero_pedido.IsNull) then
  begin
    fdqPedido.Edit;

    PedidoVendasItem.fdqPedidoItem.Close;
    PedidoVendasItem.fdqPedidoItem.Open;
  end
  else
  begin
    ShowMessage('Esse número de pedido não existe. Verifique.');
    InserirPedido;
  end;
end;

constructor TPedidoVendas.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TPedidoVendas.ExcluirPedidoVendas(const NumeroPedido: String);
begin
  if (NumeroPedido.IsEmpty) then
    Exit;

  TVendasFunctions.ValidarCampo(NumeroPedido);

  fdqPedido.Close;
  fdqPedido.ParamByName('NUMERO_PEDIDO_PRM').Value := NumeroPedido;
  fdqPedido.Open;

  if (not fdqPedidonumero_pedido.IsNull) then
  begin
    fdqPedido.Delete;

    ModelConexao.StartTransaction;
    try
      if (ModelConexao.SchemaAdapter.ApplyUpdates(0) = 0) then
        TFDConnection(ModelConexao.EndConexao).Commit
      else
        TFDConnection(ModelConexao.EndConexao).Rollback;
    except
      on e: Exception do
      begin
        TFDConnection(ModelConexao.EndConexao).Rollback;
        raise Exception.Create(e.Message);
      end;
    end;
  end
  else
    ShowMessage('Esse número de pedido não existe. Verifique.');

  InserirPedido;
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
    TVendasFunctions.ValidarCampo(fdqPedidoCODIGO_CLIENTE);

    if (PedidoVendasItem.fdqPedidoItem.IsEmpty) then
    begin
      PedidoVendasItem.fdMemItemAtualCODIGO_PRODUTO.Clear;
      PedidoVendasItem.fdMemItemAtualCODIGO_PRODUTO.FocusControl;

      raise Exception.Create('É necessário informar pelo menos um item no pedido.');
    end;
  end;

begin
  ValidarCampos;

  ModelConexao.StartTransaction;
  try
    if (ModelConexao.SchemaAdapter.ApplyUpdates(0) = 0) then
      TFDConnection(ModelConexao.EndConexao).Commit
    else
      TFDConnection(ModelConexao.EndConexao).Rollback;
  except
    on e: Exception do
    begin
      TFDConnection(ModelConexao.EndConexao).Rollback;

      MessageDlg('O pedido atual será descartado.' + sLineBreak + 'Erro: ' + e.Message, mtError, [mbOK], 0);
    end;
  end;

  InserirPedido;
end;

procedure TPedidoVendas.InserirPedido;
begin
  PedidoVendasItem.LimparItemAtual;

  ModelConexao
    .SchemaAdapter
      .Close
      .Open;

  fdqPedido.Append;
  fdqPedidonumero_pedido.AsInteger :=
    TFDConnection(ModelConexao.EndConexao).ExecSQLScalar('select max(p.numero_pedido) from pedidos p').toInteger + 1;

  fdqPedido.Post;
  fdqPedido.Edit;
  fdqPedidoDATA_EMISSAO_PEDIDO.AsDateTime := Now;
  fdqPedidoCODIGO_CLIENTE.FocusControl;
end;

procedure TPedidoVendas.fdqPedidoNUMERO_PEDIDOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.AsInteger <= 0) then
    Text := EmptyStr
  else
    Text := Sender.AsString;
end;

end.

