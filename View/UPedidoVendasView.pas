unit UPedidoVendasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList;

type
  TPedidoVendasView = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel7: TPanel;
    btnPesquisar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnFechar: TButton;
    Panel8: TPanel;
    Label1: TLabel;
    edtNomeCliente: TDBEdit;
    edtCodigoCliente: TDBEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    btnAdicionarItem: TButton;
    Panel5: TPanel;
    grdItens: TDBGrid;
    Panel6: TPanel;
    edtTotalGeral: TDBEdit;
    lblCodigoProduto: TLabel;
    lblQuantidade: TLabel;
    lblValorUnitario: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCidadeCliente: TDBEdit;
    edtUfCliente: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtDataEmissao: TDBEdit;
    Label9: TLabel;
    ImageList: TImageList;
    ActionList: TActionList;
    actPesquisar: TAction;
    edtNumeroPedido: TDBEdit;
    Label2: TLabel;
    edtCodigoProduto: TDBEdit;
    edtDescricaoProduto: TDBEdit;
    edtQuantidade: TDBEdit;
    edtValorUnitario: TDBEdit;
    edtValorTotal: TDBEdit;
    btnExcluir: TButton;
    actExcluir: TAction;
    btnControleButtons: TButton;
    actControleBotoes: TAction;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actControleBotoesUpdate(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
  private
    FFormatSettings: TFormatSettings;
    procedure SetKeyPressEnter(var Key: Char);
    procedure ValidateFloat(var Key: Char; var Sender: TObject);
    procedure ReposicionarBotoes;
    function AtivarBotoesExcluirPesquisar: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  PedidoVendasView: TPedidoVendasView;

implementation

uses
  PedidoVendasModel, PedidoVendasItemModel, Vendas.Helpers, System.UITypes, ULoginView;

{$R *.dfm}

procedure TPedidoVendasView.btnGravarClick(Sender: TObject);
begin
  PedidoVendas.GravarPedido;
  ReposicionarBotoes;
end;

constructor TPedidoVendasView.Create(AOwner: TComponent);
begin
  inherited;
  // Guarda o separador decimal do S.O. usado nos campos Float
  {$WARNINGS OFF}
  FFormatSettings := TFormatSettings.Create(GetThreadLocale());
  {$WARNINGS ON}
end;

procedure TPedidoVendasView.actControleBotoesUpdate(Sender: TObject);
begin
  btnPesquisar.Visible := AtivarBotoesExcluirPesquisar;
  btnExcluir.Visible := btnPesquisar.Visible;

  if btnExcluir.Visible then
    ReposicionarBotoes;
end;

procedure TPedidoVendasView.actExcluirExecute(Sender: TObject);
var
  NumeroPedido: String;
begin
  InputQuery('Exclusão de Pedidos de Vendas', 'Informe o número do pedido: ', NumeroPedido);

  if (not NumeroPedido.IsEmpty) then
    PedidoVendas.ExcluirPedidoVendas(NumeroPedido);
end;

procedure TPedidoVendasView.actPesquisarExecute(Sender: TObject);
var
  NumeroPedido: String;
begin
  InputQuery('Pesquisa de Pedidos de Vendas', 'Informe o número do pedido: ', NumeroPedido);

  if (not NumeroPedido.IsEmpty) then
    PedidoVendas.CarregarPedidoVendas(NumeroPedido);
end;

function TPedidoVendasView.AtivarBotoesExcluirPesquisar: Boolean;
begin
  Result := PedidoVendas.fdqPedidoCODIGO_CLIENTE.IsNull and
    (PedidoVendas.fdqPedidoCODIGO_CLIENTE.AsInteger = 0);
end;

procedure TPedidoVendasView.btnAdicionarItemClick(Sender: TObject);
begin
  PedidoVendasItem.AdicionarItemNaLista;
end;

procedure TPedidoVendasView.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  SetKeyPressEnter(Key);
end;

procedure TPedidoVendasView.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  SetKeyPressEnter(Key);
  ValidateFloat(Key, Sender);
end;

procedure TPedidoVendasView.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  SetKeyPressEnter(Key);
  ValidateFloat(Key, Sender);
end;

procedure TPedidoVendasView.FormShow(Sender: TObject);
begin
  PedidoVendas.InserirPedido;

  if (edtCodigoCliente.CanFocus) then
    edtCodigoCliente.SetFocus;
end;

procedure TPedidoVendasView.grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not grdItens.DataSource.DataSet.IsEmpty) then
  begin
    if MessageDlg('Deseja realmente excluir o item do pedido atual?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      grdItens.DataSource.DataSet.Delete;
      Key := 0;
    end;
  end;
end;

procedure TPedidoVendasView.grdItensKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    PedidoVendasItem.EditarPedidoItem;
end;

procedure TPedidoVendasView.ReposicionarBotoes;
begin
  if AtivarBotoesExcluirPesquisar and (btnExcluir.Left <> 150) then
  begin
    btnPesquisar.Left := 8;
    btnGravar.Left := 79;
    btnExcluir.Left := 150;
    btnCancelar.Left := 221;
    btnFechar.Left := 292;
  end;
end;

procedure TPedidoVendasView.SetKeyPressEnter(var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TPedidoVendasView.ValidateFloat(var Key: Char; var Sender: TObject);
var
  DecimalSeparator: Char;
begin
  DecimalSeparator := FFormatSettings.DecimalSeparator;
  if (not CharInSet(Key, [#8, '0'..'9', DecimalSeparator])) or
     ((Key = DecimalSeparator) and (Pos(Key, (Sender as TDBEdit).Text) > 0)) or
     (((Key = DecimalSeparator)) and ((Sender as TDBEdit).Text = ',')) or
     ((Key = '-') and ((Sender as TDBEdit).SelStart <> 0)) then
  begin
    Key := #0;
  end;
end;

procedure TPedidoVendasView.btnCancelarClick(Sender: TObject);
begin
  PedidoVendas.CancelarPedido;
  ReposicionarBotoes;
end;

procedure TPedidoVendasView.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
