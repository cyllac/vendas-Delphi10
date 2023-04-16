unit PedidoVendasItemModel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

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
    CdsItemAtual: TClientDataSet;
    CdsItemAtualCODIGO_PRODUTO: TIntegerField;
    CdsItemAtualDESCRICAO_PRODUTO: TStringField;
    CdsItemAtualQUANTIDADE_PEDIDO_ITEM: TFloatField;
    CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM: TFloatField;
    CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM: TFloatField;
    fdqProduto: TFDQuery;
    fdqProdutoDESCRICAO_PRODUTO: TStringField;
    fdqProdutoPRECO_VENDA_PRODUTO: TBCDField;
    dtsProduto: TDataSource;
    procedure CdsItemAtualCODIGO_PRODUTOChange(Sender: TField);
    procedure CdsItemAtualQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
    procedure fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
    procedure fdqPedidoItemAfterPost(DataSet: TDataSet);
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
  PedidoVendasModel, Vcl.Dialogs, System.UITypes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPedidoVendasItem.AdicionarItemNaLista;

  procedure ValidarCampo(const ACampo: TField);
  begin
    if (ACampo.AsString = EmptyStr) then
    begin
      ACampo.FocusControl;
      raise Exception.Create('É necessário informar o campo ' + ACampo.DisplayName);
    end;
  end;

begin
  ValidarCampo(CdsItemAtualCODIGO_PRODUTO);
  ValidarCampo(CdsItemAtualQUANTIDADE_PEDIDO_ITEM);
  ValidarCampo(CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM);

  fdqPedidoItem.Append;
  try
    fdqPedidoItemCODIGO_PRODUTO.AsInteger := CdsItemAtualCODIGO_PRODUTO.AsInteger;
    fdqPedidoItemDESCRICAO_PRODUTO.AsString := CdsItemAtualDESCRICAO_PRODUTO.AsString;
    fdqPedidoItemQUANTIDADE_PEDIDO_ITEM.AsFloat := CdsItemAtualQUANTIDADE_PEDIDO_ITEM.AsFloat;
    fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM.AsFloat := CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat;
    fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM.AsFloat := CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat;
    PedidoVendas.fdqPedidoVALOR_TOTAL_PEDIDO.AsFloat := (PedidoVendas.fdqPedidoVALOR_TOTAL_PEDIDO.AsFloat + CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat);
    fdqPedidoItem.Post;
  except
    on e: Exception do
    begin
      raise Exception.Create('Não foi possível adicionar o item na lista.' + sLineBreak + 'Erro: ' + e.Message);
    end;
  end;

  LimparItemAtual;
  CdsItemAtualCODIGO_PRODUTO.FocusControl;
end;

procedure TPedidoVendasItem.ApagarPedidoItem;
begin
  if fdqPedidoItem.State in [dsEdit, dsInsert] then
    fdqPedidoItem.Post;

  fdqPedidoItem.Delete;
end;

function TPedidoVendasItem.CalcularValorTotalItem(const AQuantidade, AValorUnitario: Double): Double;
begin
  if (AQuantidade > 0) and (AValorUnitario > 0) then
    Result := (AQuantidade * AValorUnitario)
  else
    Result := 0;
end;

procedure TPedidoVendasItem.CdsItemAtualCODIGO_PRODUTOChange(Sender: TField);
begin
  fdqProduto.Close;
  fdqProduto.ParamByName('CODIGO_PRODUTO_PRM').Value := CdsItemAtualCODIGO_PRODUTO.AsVariant;
  fdqProduto.Open;

  if (not fdqProdutoDESCRICAO_PRODUTO.IsNull) then
  begin
    CdsItemAtualDESCRICAO_PRODUTO.AsString := fdqProdutoDESCRICAO_PRODUTO.AsString;
    CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat := fdqProdutoPRECO_VENDA_PRODUTO.AsFloat;
  end
  else
  begin
    CdsItemAtualDESCRICAO_PRODUTO.Clear;
    CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM.Clear;

    if (not CdsItemAtualCODIGO_PRODUTO.IsNull) then
    begin
      CdsItemAtualCODIGO_PRODUTO.Clear;
      CdsItemAtualCODIGO_PRODUTO.FocusControl;
      MessageDlg('O produto informado não existe. Verifique.', mtError, [mbOK], 0);
    end;
  end;

end;

procedure TPedidoVendasItem.CdsItemAtualQUANTIDADE_PEDIDO_ITEMChange(Sender: TField);
begin
  CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM.AsFloat :=
    CalcularValorTotalItem(
      CdsItemAtualQUANTIDADE_PEDIDO_ITEM.AsFloat,
      CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM.AsFloat);
end;

constructor TPedidoVendasItem.Create(AOwner: TComponent);
begin
  inherited;
  CdsItemAtual.CreateDataSet;
  CdsItemAtual.Open;
  CdsItemAtual.Insert;
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
  CdsItemAtualCODIGO_PRODUTO.Clear;
  CdsItemAtualDESCRICAO_PRODUTO.Clear;
  CdsItemAtualQUANTIDADE_PEDIDO_ITEM.Clear;
  CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM.Clear;
  CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM.Clear;
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
