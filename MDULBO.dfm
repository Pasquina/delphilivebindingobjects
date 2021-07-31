object MDLBO: TMDLBO
  OldCreateOrder = False
  Height = 258
  Width = 386
  object dgCorp: TDataGeneratorAdapter
    FieldDefs = <
      item
        Name = 'CorpName'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'CorpStreetAddress'
        Generator = 'ColorsNames'
        ReadOnly = False
      end
      item
        Name = 'CorpCity'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'CorpStateProvince'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'CorpCountry'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'CorpMainPhone'
        FieldType = ftDateTime
        Generator = 'DateTime'
        ReadOnly = False
      end>
    Active = True
    AutoPost = False
    RecordCount = 1
    Options = [loptAllowInsert, loptAllowDelete, loptAllowModify]
    Left = 40
    Top = 24
  end
  object absCorp: TAdapterBindSource
    AutoActivate = True
    OnCreateAdapter = absCorpCreateAdapter
    Adapter = dgCorp
    ScopeMappings = <>
    Left = 40
    Top = 88
  end
  object dgBranches: TDataGeneratorAdapter
    FieldDefs = <
      item
        Name = 'BranchName'
        Generator = 'ColorsNames'
        ReadOnly = False
      end
      item
        Name = 'BranchFullAddress'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'BranchMainPhone'
        Generator = 'DateTime'
        ReadOnly = False
      end>
    Active = True
    AutoPost = False
    Options = [loptAllowInsert, loptAllowDelete, loptAllowModify]
    Left = 120
    Top = 24
  end
  object absBranches: TAdapterBindSource
    AutoActivate = True
    OnCreateAdapter = absBranchesCreateAdapter
    Adapter = dgBranches
    ScopeMappings = <>
    Left = 120
    Top = 88
  end
  object dgEmployees: TDataGeneratorAdapter
    FieldDefs = <
      item
        Name = 'EmpFirstName'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'EmpMiddleName'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'EmpSurname'
        Generator = 'LoremIpsum'
        ReadOnly = False
      end
      item
        Name = 'EmpFullName'
        Generator = 'ContactNames'
        ReadOnly = False
      end>
    Active = True
    AutoPost = False
    Options = [loptAllowInsert, loptAllowDelete, loptAllowModify]
    Left = 200
    Top = 24
  end
  object absEmployees: TAdapterBindSource
    AutoActivate = True
    OnCreateAdapter = absEmployeesCreateAdapter
    Adapter = dgEmployees
    ScopeMappings = <>
    Left = 200
    Top = 88
  end
end
