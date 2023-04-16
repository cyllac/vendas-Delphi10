program Vendas;

{$R *.dres}

uses
  Vcl.Forms,
  ULoginView in 'View\ULoginView.pas' {LoginView},
  UPedidoVendasView in 'View\UPedidoVendasView.pas' {PedidoVendasView},
  PedidoVendasModel in 'Model\Pedido\PedidoVendasModel.pas' {PedidoVendas: TDataModule},
  Vendas.Helpers in 'Vendas.Helpers.pas',
  Vendas.Model.Conexao.Interfaces in 'Model\Conexao\Vendas.Model.Conexao.Interfaces.pas',
  System.UITypes,
  Vendas.Model.Conexao.Factory in 'Model\Conexao\Vendas.Model.Conexao.Factory.pas',
  Vendas.Model.Conexao.Firedac in 'Model\Conexao\Vendas.Model.Conexao.Firedac.pas' {ModelConexaoFiredac: TDataModule},
  PedidoVendasItemModel in 'Model\PedidoItem\PedidoVendasItemModel.pas' {PedidoVendasItem: TDataModule},
  Vendas.Controller.Conexao.Interfaces in 'Controller\Vendas.Controller.Conexao.Interfaces.pas',
  Vendas.Controller.Conexao.Factory in 'Controller\Vendas.Controller.Conexao.Factory.pas',
  Vendas.Controller.Conexao in 'Controller\Vendas.Controller.Conexao.pas',
  Vendas.Functions in 'Vendas.Functions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPedidoVendas, PedidoVendas);
  Application.CreateForm(TPedidoVendasItem, PedidoVendasItem);

  if (LoginView = nil) then
    LoginView := TLoginView.Create(Application);

  if (LoginView.ShowModal = mrOK) then
    Application.CreateForm(TPedidoVendasView, PedidoVendasView);

  Application.Run;
end.
