unit PedidoVendasItemModel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vendas.Model.Conexao.Firedac;

type
  TPedidoVendasItem = class(TDataModule)
    fdqPedidoItem: TFDQuery;
    fdqPedidoItemCODIGO_PEDIDO_ITEM: TFDAutoIncField;
    fdqPedidoItemNUMERO_PEDIDO: TIntegerField;
    fdqPedidoItemCODIGO_PRODUTO: TIntegerField;
    fdqPedidoItemDESCRICAO_PRODUTO: TStringField;
    fdqPedidoItemQUANTIDADE_PEDIDO_ITEM: TBCDField;
    fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM: TBCDField;
    fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM: TBCDField;
    dtsPedidoItem: TDataSource;
    dtsItem: TDataSource;
    fdqProduto: TFDQuery;
    fdqProdutoDESCRICAO_PRODUTO: TStringField;
    fdqProdutoPRECO_VENDA_PRODUTO: TBCDField;
    dtsProduto: TDataSource;
    fdMemItemAtual: TFDMemTable;
    fdMemItemAtualCODIGO_PRODUTO: TIntegerField;
    fdMemItemAtualDESCRICAO_PRODUTO: TStringField;
    fdMemItemAtualQUANTIDADE_PEDIDO_ITEM: TFloatField;
    fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM: TFloatField;
    fdMemItemAtualVALOR_TOTAL_PEDIDO_ITEM: TFloatField;
    procedure fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
    procedure fdqPedidoItemAfterPost(DataSet: TDataSet);
    procedure fdMemItemAtualCODIGO_PRODUTOChange(Sender: TField);
    procedure fdMemItemAtualQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
  private
    procedure RecalcularTotalPedido;
    function CalcularValorTotalItem(const AQuantidade: Double; const AValorUnitario: Double): Double;
  public
    procedure AdicionarItemNaLista;
    procedure ApagarPedidoItem;
    procedure LimparItemAtual;
    constructor Create(AOwner: TComponent); override;
  end;

var
  PedidoVendasItem: TPedidoVendasItem;

implementation

uses
  PedidoVendasModel, Vcl.Dialogs, System.UITypes, Vendas.Functions;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPedidoVendasItem.AdicionarItemNaLista;
begin
  if (fdqPedidoItem.State = dsEdit) then
    fdqPedidoItem.Post
  else
  begin

  TVendasFunctions.ValidarCampo(fdMemItemAtualCODIGO_PRODUTO);
  TVendasFunctions.ValidarCampo(fdMemItemAtualQUANTIDADE_PEDIDO_ITEM);
  TVendasFunctions.ValidarCampo(fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM);

  fdqPedidoItem.Append;
  try
    fdqPedidoItemCODIGO_PRODUTO.AsInteger := fdMemItemAtualCODIGO_PRODUTO.AsInteger;
    fdqPedidoItemDESCRICAO_PRODUTO.AsString := fdMemItemAtualDESCRICAO_PRODUTO.AsString;
    fdqPedidoItemQUANTIDADE_PEDIDO_ITEM.AsFloat := fdMemItemAtualQUANTIDADE_PEDIDO_ITEM.AsFloat;
    fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM.AsFloat := fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat;
    fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM.AsFloat := fdMemItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat;
    PedidoVendas.fdqPedidoVALOR_TOTAL_PEDIDO.AsFloat := (PedidoVendas.fdqPedidoVALOR_TOTAL_PEDIDO.AsFloat + fdMemItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat);

    fdqPedidoItem.Post;
  except
    on e: Exception do
    begin
      raise Exception.Create('Não foi possível adicionar o item na lista.' + sLineBreak + 'Erro: ' + e.Message);
    end;
  end;

  LimparItemAtual;
  end;
  fdMemItemAtualCODIGO_PRODUTO.FocusControl;
end;

procedure TPedidoVendasItem.ApagarPedidoItem;
begin
  if fdqPedidoItem.State in [dsEdit, dsInsert] then
    fdqPedidoItem.Cancel;

  fdqPedidoItem.Delete;
end;

function TPedidoVendasItem.CalcularValorTotalItem(const AQuantidade, AValorUnitario: Double): Double;
begin
  if (AQuantidade > 0) and (AValorUnitario > 0) then
    Result := (AQuantidade * AValorUnitario)
  else
    Result := 0;
end;

constructor TPedidoVendasItem.Create(AOwner: TComponent);
begin
  inherited;
  fdMemItemAtual.CreateDataSet;
  fdMemItemAtual.Open;
  fdMemItemAtual.Insert;
end;

procedure TPedidoVendasItem.fdMemItemAtualCODIGO_PRODUTOChange(Sender: TField);
begin
  fdqProduto.Close;
  fdqProduto.ParamByName('CODIGO_PRODUTO_PRM').Value := fdMemItemAtualCODIGO_PRODUTO.AsVariant;
  fdqProduto.Open;

  if (not fdqProdutoDESCRICAO_PRODUTO.IsNull) then
  begin
    fdMemItemAtualDESCRICAO_PRODUTO.AsString := fdqProdutoDESCRICAO_PRODUTO.AsString;
    fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat := fdqProdutoPRECO_VENDA_PRODUTO.AsFloat;
  end
  else
  begin
    fdMemItemAtualDESCRICAO_PRODUTO.Clear;
    fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM.Clear;

    if (not fdMemItemAtualCODIGO_PRODUTO.IsNull) then
    begin
      fdMemItemAtualCODIGO_PRODUTO.Clear;
      fdMemItemAtualCODIGO_PRODUTO.FocusControl;
      MessageDlg('O produto informado não existe. Verifique.', mtError, [mbOK], 0);
    end;
  end;
end;

procedure TPedidoVendasItem.fdMemItemAtualQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
begin
  fdMemItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat :=
    CalcularValorTotalItem(
      fdMemItemAtualQUANTIDADE_PEDIDO_ITEM.AsFloat,
      fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat);
end;

procedure TPedidoVendasItem.fdqPedidoItemAfterPost(DataSet: TDataSet);
begin
  RecalcularTotalPedido;
end;

procedure TPedidoVendasItem.fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
begin
  fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM.AsFloat :=
    CalcularValorTotalItem(
      fdqPedidoItemQUANTIDADE_PEDIDO_ITEM.AsFloat,
      fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM.AsFloat);
end;

procedure TPedidoVendasItem.LimparItemAtual;
begin
  fdMemItemAtualCODIGO_PRODUTO.Clear;
  fdMemItemAtualDESCRICAO_PRODUTO.Clear;
  fdMemItemAtualQUANTIDADE_PEDIDO_ITEM.Clear;
  fdMemItemAtualVALOR_UNITARIO_PEDIDO_ITEM.Clear;
  fdMemItemAtualVALOR_TOTAL_PEDIDO_ITEM.Clear;
end;

procedure TPedidoVendasItem.RecalcularTotalPedido;
var
  ValorTotalPedido: Double;
begin
  ValorTotalPedido := 0;

  fdqPedidoItem.DisableControls;
  try
    fdqPedidoItem.First;
    while (not fdqPedidoItem.Eof) do
    begin
      ValorTotalPedido := ValorTotalPedido + fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM.AsFloat;
      fdqPedidoItem.Next;
    end;
  finally
    fdqPedidoItem.EnableControls;
  end;

  pedidoVendas.fdqPedidoVALOR_TOTAL_PEDIDO.AsFloat := ValorTotalPedido;
end;

end.
