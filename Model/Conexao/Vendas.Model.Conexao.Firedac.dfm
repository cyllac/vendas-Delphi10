object ModelConexaoFiredac: TModelConexaoFiredac
  OldCreateOrder = False
  Height = 260
  Width = 234
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=vendas'
      'Password=root'
      'User_Name=root')
    LoginPrompt = False
    Left = 80
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 72
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 80
    Top = 120
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvUpdateMode, uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    OnReconcileRow = FDSchemaAdapterReconcileRow
    OnUpdateRow = FDSchemaAdapterUpdateRow
    Left = 80
    Top = 168
  end
end
