unit ULoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vendas.Controller.Conexao.Interfaces;

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
    ckbSalvarSenha: TCheckBox;
    procedure btnConectarClick(Sender: TObject);
    procedure edtServidorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FControllerConexao: iControllerConexao;
    procedure SetKeyPressEnter(var Key: Char);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure LerArquivoINI;
  public
    { Public declarations }
  end;

var
  LoginView: TLoginView;

implementation

{$R *.dfm}

uses
  PedidoVendasModel, UPedidoVendasView, Vendas.Model.Conexao.Factory, Vendas.Helpers, Vendas.Model.Conexao.Firedac,
  Vendas.Controller.Conexao.Factory, IniFiles, Vendas.Functions;

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

  FControllerConexao
        .Model
          .Parametros
            .DriverID('MySQL')
            .Server(edtServidor.Text)
            .Porta(edtPorta.Text.toInteger)
            .UserName(edtUsuario.Text)
            .Password(edtSenha.Text)
            .Database(edtDatabase.Text)
            .SalvarSenha(ckbSalvarSenha.Checked)
          .EndParametros
          .Conectar;

  ModalResult := mrOk;
end;

procedure TLoginView.CreateParams(var Params: TCreateParams);
begin
  inherited;
  // Exibe o ícone do sistema na barra de tarefas do windows.
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure TLoginView.LerArquivoINI;
var
  ArquivoINI: TIniFile;
begin
  ArquivoINI := TIniFile.Create(TVendasFunctions.PegarNomeArquivoINI);
  try
    edtServidor.Text := ArquivoINI.ReadString(SECTION_INI, 'Servidor', 'localhost');
    edtPorta.Text := ArquivoINI.ReadString(SECTION_INI, 'Porta', '3306');
    edtDatabase.Text := ArquivoINI.ReadString(SECTION_INI, 'Database', 'vendas');
    edtUsuario.Text := ArquivoINI.ReadString(SECTION_INI, 'Usuario', 'root');
    edtSenha.Text := ArquivoINI.ReadString(SECTION_INI, 'Senha', EmptyStr);
    ckbSalvarSenha.Checked := (Length(Trim(edtSenha.Text)) > 0);

    if ckbSalvarSenha.Checked then
      edtSenha.Text := TVendasFunctions.DescriptografarSenha(edtSenha.Text);
  finally
    FreeAndNil(ArquivoINI);
  end;
end;

procedure TLoginView.edtServidorKeyPress(Sender: TObject; var Key: Char);
begin
  SetKeyPressEnter(Key);
end;

procedure TLoginView.FormCreate(Sender: TObject);
begin
  FControllerConexao := TControllerConexaoFactory.New.Conexao;

  LerArquivoINI;
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
