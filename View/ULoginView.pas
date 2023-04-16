unit ULoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TLoginView = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    lblServidor: TLabel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblDatabase: TLabel;
    lblPorta: TLabel;
    edtServidor: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtDatabase: TEdit;
    btnConectar: TButton;
    edtPorta: TEdit;
    procedure btnConectarClick(Sender: TObject);
    procedure edtServidorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    procedure SetKeyPressEnter(var Key: Char);
  public
    { Public declarations }
  end;

var
  LoginView: TLoginView;

implementation

{$R *.dfm}

uses
  PedidoVendasModel, UPedidoVendasView, Vendas.Model.Conexao.Factory, Vendas.Helpers;

procedure TLoginView.btnConectarClick(Sender: TObject);

  procedure ValidarCampo(const ACampo: TEdit; const ALabel: TLabel);
  begin
    if (ACampo.Text = EmptyStr) then
    begin
      if ACampo.CanFocus then
        ACampo.SetFocus;


      raise Exception.Create('É necessário informar o campo ' + StringReplace(ALabel.Caption, ':', EmptyStr, []));
    end;
  end;

begin
  ValidarCampo(edtServidor, lblServidor);
  ValidarCampo(edtPorta, lblPorta);
  ValidarCampo(edtUsuario, lblUsuario);
  ValidarCampo(edtSenha, lblSenha);
  ValidarCampo(edtDatabase, lblDatabase);

  PedidoVendas
    .ModelConexao
      .Parametros
        .DriverID('MySQL')
        .Server(edtServidor.Text)
        .Porta(edtPorta.Text.toInteger)
        .UserName(edtUsuario.Text)
        .Password(edtSenha.Text)
        .Database(edtDatabase.Text)
      .EndParametros
      .Conectar;

  ModalResult := mrOk;
end;

procedure TLoginView.edtServidorKeyPress(Sender: TObject; var Key: Char);
begin
  SetKeyPressEnter(Key);
end;

procedure TLoginView.FormShow(Sender: TObject);
begin
  if (btnConectar.CanFocus) then
    btnConectar.SetFocus;
end;

procedure TLoginView.SetKeyPressEnter(var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
