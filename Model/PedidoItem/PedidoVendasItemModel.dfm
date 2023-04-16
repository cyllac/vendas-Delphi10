object PedidoVendasItem: TPedidoVendasItem
  OldCreateOrder = False
  Height = 179
  Width = 201
  object fdqPedidoItem: TFDQuery
    AfterPost = fdqPedidoItemAfterPost
    CachedUpdates = True
    IndexFieldNames = 'NUMERO_PEDIDO'
    MasterSource = PedidoVendas.dtsPedido
    MasterFields = 'NUMERO_PEDIDO'
    Connection = ModelConexaoFiredac.FDConnection
    SchemaAdapter = ModelConexaoFiredac.FDSchemaAdapter
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
    Left = 32
    Top = 16
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
    end
    object fdqPedidoItemCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'codigo_produto'
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
      OnChange = fdqPedidoItemQUANTIDADE_PEDIDO_ITEMChange
      Precision = 10
      Size = 2
    end
    object fdqPedidoItemVALOR_UNITARIO_PEDIDO_ITEM: TBCDField
      DefaultExpression = '0'
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO_PEDIDO_ITEM'
      Origin = 'valor_unitario_pedido_item'
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
      DisplayFormat = '0.00,'
      EditFormat = '0.00,'
      Precision = 10
      Size = 2
    end
  end
  object dtsPedidoItem: TDataSource
    DataSet = fdqPedidoItem
    Left = 115
    Top = 16
  end
  object dtsItem: TDataSource
    DataSet = CdsItemAtual
    Left = 115
    Top = 68
  end
  object CdsItemAtual: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 68
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
  object fdqProduto: TFDQuery
    Connection = ModelConexaoFiredac.FDConnection
    SQL.Strings = (
      'select'
      '  p.descricao_produto,'
      '  p.preco_venda_produto'
      'from'
      '  produtos p'
      'where'
      '  (p.codigo_produto = :codigo_produto_prm)')
    Left = 32
    Top = 120
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
    Left = 112
    Top = 120
  end
end
