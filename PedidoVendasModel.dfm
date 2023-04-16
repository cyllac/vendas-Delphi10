object PedidoVendas: TPedidoVendas
  OldCreateOrder = False
  Height = 423
  Width = 441
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=3306'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 72
    Top = 32
  end
  object fdqPedido: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SchemaAdapter = FDSchemaAdapter
    SQL.Strings = (
      'select'
      '  p.numero_pedido,'
      '  p.data_emissao_pedido,'
      '  p.codigo_cliente,'
      '  p.valor_total_pedido,'
      '  c.nome_cliente,'
      '  c.cidade_cliente,'
      '  c.uf_cliente'
      'from'
      '  pedidos p'
      
        '    inner join clientes c on (c.codigo_cliente = p.codigo_client' +
        'e)'
      'where'
      '  (p.numero_pedido = :numero_pedido_prm)')
    Left = 184
    Top = 88
    ParamData = <
      item
        Name = 'NUMERO_PEDIDO_PRM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqPedidoNUMERO_PEDIDO: TFDAutoIncField
      FieldName = 'NUMERO_PEDIDO'
      Origin = 'numero_pedido'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      OnGetText = fdqPedidoNUMERO_PEDIDOGetText
    end
    object fdqPedidoDATA_EMISSAO_PEDIDO: TDateField
      FieldName = 'DATA_EMISSAO_PEDIDO'
      Origin = 'data_emissao_pedido'
      DisplayFormat = 'dd/MM/yyyy'
      EditMask = '!99/99/9999;1;_'
    end
    object fdqPedidoVALOR_TOTAL_PEDIDO: TBCDField
      DefaultExpression = '0'
      FieldName = 'VALOR_TOTAL_PEDIDO'
      Origin = 'valor_total_pedido'
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
      Precision = 10
      Size = 2
    end
    object fdqPedidoCODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Origin = 'codigo_cliente'
      OnChange = fdqPedidoCODIGO_CLIENTEChange
    end
    object fdqPedidoNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'nome_cliente'
      ProviderFlags = []
      Size = 100
    end
    object fdqPedidoCIDADE_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE_CLIENTE'
      Origin = 'cidade_cliente'
      ProviderFlags = []
      Size = 50
    end
    object fdqPedidoUF_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF_CLIENTE'
      Origin = 'uf_cliente'
      ProviderFlags = []
      Size = 2
    end
  end
  object dtsPedido: TDataSource
    DataSet = fdqPedido
    Left = 296
    Top = 88
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 184
    Top = 32
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 296
    Top = 32
  end
  object fdqPedidoItem: TFDQuery
    AfterPost = fdqPedidoItemAfterPost
    CachedUpdates = True
    IndexFieldNames = 'NUMERO_PEDIDO'
    MasterSource = dtsPedido
    MasterFields = 'NUMERO_PEDIDO'
    DetailFields = 'NUMERO_PEDIDO'
    Connection = FDConnection
    SchemaAdapter = FDSchemaAdapter
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'select'
      '  pi.codigo_pedido_item,'
      '  pi.numero_pedido,'
      '  pi.codigo_produto,'
      '  pi.quantidade_pedido_item,'
      '  pi.valor_unitario_pedido_item,'
      '  pi.valor_total_pedido_item,'
      '  p.descricao_produto'
      'from'
      '  pedidos_itens pi'
      
        '    inner join produtos p on (p.codigo_produto = pi.codigo_produ' +
        'to) '
      'where  '
      '  pi.numero_pedido = :numero_pedido')
    Left = 184
    Top = 136
    ParamData = <
      item
        Name = 'NUMERO_PEDIDO'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end>
    object fdqPedidoItemCODIGO_PEDIDO_ITEM: TFDAutoIncField
      FieldName = 'CODIGO_PEDIDO_ITEM'
      Origin = 'codigo_pedido_item'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
    end
    object fdqPedidoItemNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Origin = 'numero_pedido'
      Required = True
    end
    object fdqPedidoItemCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'codigo_produto'
      Required = True
    end
    object fdqPedidoItemDESCRICAO_PRODUTO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO_PRODUTO'
      Origin = 'descricao_produto'
      ProviderFlags = []
      Size = 100
    end
    object fdqPedidoItemQUANTIDADE_PEDIDO_ITEM: TBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE_PEDIDO_ITEM'
      Origin = 'quantidade_pedido_item'
      Required = True
      OnChange = fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange
      Precision = 10
      Size = 2
    end
    object fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM: TBCDField
      DefaultExpression = '0'
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO_PEDIDO_ITEM'
      Origin = 'valor_unitario_pedido_item'
      Required = True
      OnChange = fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
      Precision = 10
      Size = 2
    end
    object fdqPedidoItemVALOR_TOTAL_PEDIDO_ITEM: TBCDField
      DefaultExpression = '0'
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL_PEDIDO_ITEM'
      Origin = 'valor_total_pedido_item'
      Required = True
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
      Precision = 10
      Size = 2
    end
  end
  object dtsPedidoItem: TDataSource
    DataSet = fdqPedidoItem
    Left = 296
    Top = 136
  end
  object fdqCliente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '  c.nome_cliente,'
      '  c.cidade_cliente,'
      '  c.uf_cliente'
      'from'
      '  clientes c'
      'where'
      '  c.codigo_cliente = :codigo_cliente_prm')
    Left = 184
    Top = 184
    ParamData = <
      item
        Name = 'CODIGO_CLIENTE_PRM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqClienteNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Origin = 'nome_cliente'
      Required = True
      Size = 100
    end
    object fdqClienteCIDADE_CLIENTE: TStringField
      FieldName = 'CIDADE_CLIENTE'
      Origin = 'cidade_cliente'
      Required = True
      Size = 50
    end
    object fdqClienteUF_CLIENTE: TStringField
      FieldName = 'UF_CLIENTE'
      Origin = 'uf_cliente'
      Required = True
      Size = 2
    end
  end
  object dtsCliente: TDataSource
    DataSet = fdqCliente
    Left = 296
    Top = 184
  end
  object fdqProduto: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '  p.descricao_produto,'
      '  p.preco_venda_produto'
      'from'
      '  produtos p'
      'where'
      '  (p.codigo_produto = :codigo_produto_prm)')
    Left = 184
    Top = 232
    ParamData = <
      item
        Name = 'CODIGO_PRODUTO_PRM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqProdutoDESCRICAO_PRODUTO: TStringField
      FieldName = 'DESCRICAO_PRODUTO'
      Origin = 'descricao_produto'
      Required = True
      Size = 100
    end
    object fdqProdutoPRECO_VENDA_PRODUTO: TBCDField
      FieldName = 'PRECO_VENDA_PRODUTO'
      Origin = 'preco_venda_produto'
      Required = True
      Precision = 10
      Size = 2
    end
  end
  object dtsProduto: TDataSource
    DataSet = fdqProduto
    Left = 296
    Top = 232
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvUpdateMode, uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 88
  end
  object dtsItem: TDataSource
    DataSet = CdsItemAtual
    Left = 296
    Top = 280
  end
  object CdsItemAtual: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 280
    object CdsItemAtualCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'CODIGO_PRODUTO'
      OnChange = CdsItemAtualCODIGO_PRODUTOChange
    end
    object CdsItemAtualDESCRICAO_PRODUTO: TStringField
      FieldName = 'DESCRICAO_PRODUTO'
      Size = 100
    end
    object CdsItemAtualQUANTIDADE_PEDIDO_ITEM: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE_PEDIDO_ITEM'
      OnChange = CdsItemAtualQUANTIDADE_PEDIDO_ITEMChange
    end
    object CdsItemAtualVALOR_UNITARIO_PEDIDO_ITEM: TFloatField
      DefaultExpression = '0'
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO_PEDIDO_ITEM'
      OnChange = CdsItemAtualQUANTIDADE_PEDIDO_ITEMChange
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
    end
    object CdsItemAtualVALOR_TOTAL_PEDIDO_ITEM: TFloatField
      DefaultExpression = '0'
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL_PEDIDO_ITEM'
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
    end
  end
end
