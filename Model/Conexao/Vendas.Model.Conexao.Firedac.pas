unit Vendas.Model.Conexao.Firedac;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, Vendas.Model.Conexao.Interfaces, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt;

type
  TModelConexaoFiredac = class(TDataModule, iModelConexao, iModelConexaoParametros, iModelConexaoSchemaAdapter)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDSchemaAdapter: TFDSchemaAdapter;
    procedure FDSchemaAdapterReconcileRow(ASender: TObject; ARow: TFDDatSRow; var Action: TFDDAptReconcileAction);
    procedure FDSchemaAdapterUpdateRow(ASender: TObject; ARow: TFDDatSRow; ARequest: TFDUpdateRequest;
      AUpdRowOptions: TFDUpdateRowOptions; var AAction: TFDErrorAction);
  private
    FDatabase: String;
    FUserName: String;
    FPassword: String;
    FDriverID: String;
    FServer: String;
    FPorta: Integer;
    procedure LerParametros;
    procedure CreateDirectoryResource;
    function ExtractResourceSQL: String;
    procedure ExecutarSQL(const ASQL: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function New: iModelConexao;

    function Conectar: iModelConexao;
    function EndConexao: TCustomConnection;
    function Parametros: iModelConexaoParametros;
    function SchemaAdapter: iModelConexaoSchemaAdapter;
    procedure StartTransaction;

    function Database(const AValue: String): iModelConexaoParametros;
    function UserName(const AValue: String): iModelConexaoParametros;
    function Password(const AValue: String): iModelConexaoParametros;
    function DriverID(const AValue: String): iModelConexaoParametros;
    function Server(const AValue: String): iModelConexaoParametros;
    function Porta(const AValue: Integer): iModelConexaoParametros;
    function EndParametros: iModelConexao;

    function Close: iModelConexaoSchemaAdapter;
    procedure Open;
    function ApplyUpdates(const AMaxErrors: Integer=-1): Integer;
    procedure CancelUpdates;
    function EndSchemaAdapter: iModelConexao;
  end;

var
  ModelConexaoFiredac: TModelConexaoFiredac;

implementation

uses
  System.Types, System.StrUtils, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TModelConexaoFiredac.ApplyUpdates(const AMaxErrors: Integer=-1): Integer;
begin
  Result := FDSchemaAdapter.ApplyUpdates(AMaxErrors);
end;

procedure TModelConexaoFiredac.CancelUpdates;
begin
  FDSchemaAdapter.CancelUpdates;
end;

function TModelConexaoFiredac.Close: iModelConexaoSchemaAdapter;
begin
  Result := Self;
  FDSchemaAdapter.Close;
end;

function TModelConexaoFiredac.Conectar: iModelConexao;

  function GetDDLCreateDataBase: TStringDynArray;
  var
    ListaDDL: TStringList;

  begin
    Result := nil;

    ListaDDL := TStringList.Create;
    try
      ListaDDL.LoadFromFile(ExtractResourceSQL);
      Result := SplitString(ListaDDL.Text, ';');
    finally
      FreeAndNil(ListaDDL);
    end;
  end;

var
  SQLs: TStringDynArray;
  I: Integer;

begin
  Result := Self;
  LerParametros;
  try
    CreateDirectoryResource;
    ExecutarSQL('CREATE DATABASE IF NOT EXISTS vendas');

    FDConnection.Params.Database := FDatabase;
    FDConnection.Open;

    SQLs := GetDDLCreateDataBase;

    for I := 0 to Pred(Length(SQLs)) do
    begin
      if (not Trim(SQLs[I]).isEmpty) then
        ExecutarSQL(SQLs[I]);
    end;
  except
    on e: Exception do
    begin
      raise Exception.CreateFmt(
        'Ocorreu um erro ao conectar na base de dados.' + sLineBreak + 'Erro: '+ sLineBreak + '%s', [e.Message]);
    end;
  end;
end;

constructor TModelConexaoFiredac.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TModelConexaoFiredac.CreateDirectoryResource;
var
  Patch: String;
begin
  Patch := ExtractFilePath(ParamStr(0));
  if not DirectoryExists(Patch + 'SQL') then
    CreateDir(Patch + 'SQL');
end;

function TModelConexaoFiredac.Database(const AValue: String): iModelConexaoParametros;
begin
  Result := Self;
  FDatabase := AValue;
end;

destructor TModelConexaoFiredac.Destroy;
begin

  inherited;
end;

function TModelConexaoFiredac.DriverID(const AValue: String): iModelConexaoParametros;
begin
  Result := Self;
  FDriverID := AValue;
end;

function TModelConexaoFiredac.EndConexao: TCustomConnection;
begin
  Result := FDConnection;
end;

function TModelConexaoFiredac.EndParametros: iModelConexao;
begin
  Result := Self;
end;

function TModelConexaoFiredac.EndSchemaAdapter: iModelConexao;
begin
  Result := Self;
end;

procedure TModelConexaoFiredac.ExecutarSQL(const ASQL: String);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection;
    Query.SQL.Text := ASQL;
    Query.ExecSQL;
  finally
    FreeAndNil(Query);
  end;
end;

function TModelConexaoFiredac.ExtractResourceSQL: String;
var
  Arquivo: TResourceStream;
begin
  Result := EmptyStr;
  Arquivo := TResourceStream.Create(HInstance, 'Resource_DB_Create', RT_RCDATA);
  try
    Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'SQL_Criacao_DB.sql';
    Arquivo.SaveToFile(Result);
  finally
    FreeAndNil(Arquivo);
  end;
end;

procedure TModelConexaoFiredac.FDSchemaAdapterReconcileRow(ASender: TObject; ARow: TFDDatSRow; var Action: TFDDAptReconcileAction);
begin
  raise Exception.Create(EFDDBEngineException(ARow.RowError).Message);
end;

procedure TModelConexaoFiredac.FDSchemaAdapterUpdateRow(ASender: TObject; ARow: TFDDatSRow; ARequest: TFDUpdateRequest;
  AUpdRowOptions: TFDUpdateRowOptions; var AAction: TFDErrorAction);
begin
  raise Exception.Create(EFDDBEngineException(ARow.RowError).Message);
end;

procedure TModelConexaoFiredac.LerParametros;
begin
  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := FDriverID;
  FDConnection.Params.UserName := FUserName;
  FDConnection.Params.Password := FPassword;
  FDConnection.Params.Add('Server=' + FServer);
  FDConnection.Params.Add('Port=' + IntToStr(FPorta));
end;

class function TModelConexaoFiredac.New: iModelConexao;
begin
  Result := Self.Create(nil);
end;

procedure TModelConexaoFiredac.Open;
begin
  FDSchemaAdapter.Open;
end;

function TModelConexaoFiredac.Parametros: iModelConexaoParametros;
begin
  Result := Self;
end;

function TModelConexaoFiredac.Password(const AValue: String): iModelConexaoParametros;
begin
  Result := Self;
  FPassword := AValue;
end;

function TModelConexaoFiredac.Porta(const AValue: Integer): iModelConexaoParametros;
begin
  Result := Self;
  FPorta := AValue;
end;

function TModelConexaoFiredac.SchemaAdapter: iModelConexaoSchemaAdapter;
begin
  Result := Self;
end;

function TModelConexaoFiredac.Server(const AValue: String): iModelConexaoParametros;
begin
  Result := Self;
  FServer := AValue;
end;

procedure TModelConexaoFiredac.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

function TModelConexaoFiredac.UserName(const AValue: String): iModelConexaoParametros;
begin
  Result := Self;
  FUserName := AValue;
end;

end.
