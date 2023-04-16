object PedidoVendas: TPedidoVendas
  OldCreateOrder = False
  Height = 156
  Width = 187
  object fdqPedido: TFDQuery
    CachedUpdates = True
    Connection = ModelConexaoFiredac.FDConnection
    SchemaAdapter = ModelConexaoFiredac.FDSchemaAdapter
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.UpdateTableName = 'vendas.pedidos'
    UpdateOptions.KeyFields = 'numero_pedido'
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
    Left = 32
    Top = 16
    ParamData = <
      item
        Name = 'NUMERO_PEDIDO_PRM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqPedidonumero_pedido: TFDAutoIncField
      AutoGenerateValue = arNone
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ServerAutoIncrement = False
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
      IdentityInsert = True
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
    Left = 104
    Top = 16
  end
  object fdqCliente: TFDQuery
    Connection = ModelConexaoFiredac.FDConnection
    SQL.Strings = (
      'select'
      '  c.nome_cliente,'
      '  c.cidade_cliente,'
      '  c.uf_cliente'
      'from'
      '  clientes c'
      'where'
      '  c.codigo_cliente = :codigo_cliente_prm')
    Left = 32
    Top = 64
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
    Left = 104
    Top = 64
  end
end
