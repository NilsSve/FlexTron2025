Use DFClient.pkg
Use cLocalWebControlHost.pkg
Use cWebList.pkg
Use cWebColumn.pkg
Use cWebButton.pkg

Use cCustomerDataDictionary.dd

Object oCustomerStateLookup is a dbModalPanel
    Object oCustomer_DD is a cCustomerDataDictionary
    End_Object

    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD

    Set Label to "Customer States"
    Set Size to 225 222
    Set piMinSize to 89 211
    Set Icon to "Default.Ico"
    Set Location to 2 2
    Set Border_Style to Border_Thick

    Procedure Page_Object Boolean bPage
        Forward Send Page_Object bPage

        If (bPage) Begin
            Set Icon to "Default.Ico"
        End
    End_Procedure

    Procedure Close_Panel
        Send Stop_UI
    End_Procedure

    { DesignTime = False }
    Property Handle phoInvokingObject

    Object oSelectionListHost is a cLocalWebControlHost
        Set Size to 225 222
        Set Location to 0 0
        Set peAnchors to anAll
        Set piColumnCount to 13

        Object oPromptList is a cWebList
            Set pbDataAware to False
            Set peDbGridType to gtManual
            Set pbFillHeight to True
            Set pbShowHeader to False

            Object oStateColumn is a cWebColumn
                Set psCaption to "State"
                Set piWidth to 50
            End_Object

            Procedure OnLoad
                Forward Send OnLoad
                Send GridRefresh
            End_Procedure

            Procedure OnManualLoadData tWebRow[] ByRef aTheRows String ByRef sCurrentRowID
                String[] sStates
                Integer iElements iElement iStateColumnId
                Handle hoStatesVT

                Forward Send OnManualLoadData (&aTheRows) (&sCurrentRowID)

                Send Request_Read of oCustomer_DD FIRST_RECORD (RefTable (Customer)) 1
                While (Found)
                    If (SearchArray (Customer.State, sStates) = -1) Begin
                        Move Customer.State to sStates[SizeOfArray (sStates)]
                    End
                    Send Locate_Next of oCustomer_DD
                Loop

                Move (SortArray (sStates)) to sStates
                Move (SizeOfArray (sStates)) to iElements
                If (iElements > 0) Begin
                    Move (ResizeArray (aTheRows, iElements)) to aTheRows
                    Get piColumnId of oStateColumn to iStateColumnId
                    Get Field_Table_Object of oCustomer_DD Field Customer.State to hoStatesVT
                    Decrement iElements
                    For iElement from 0 to iElements
                        Move sStates[iElement] to aTheRows[iElement].sRowId
                        Get Find_Code_Description of hoStatesVT sStates[iElement] to aTheRows[iElement].aCells[iStateColumnId].sValue
                    Loop
                End
            End_Procedure

            Procedure SelectCurrentState
                Send ProcessDataSet 100
            End_Procedure

            Procedure OnProcessDataSet tWebRow[] aData Integer eOperation Integer iSelectedRowIndex
                Handle hoInvokingObject

                Get phoInvokingObject to hoInvokingObject
                Send UpdateInvokingObject of hoInvokingObject aData[iSelectedRowIndex]

                Send Stop_UI
            End_Procedure
        End_Object

        Object oOkButton is a cWebButton
            Set piColumnSpan to 3
            Set psCaption to "Ok"
            Set piColumnIndex to 7

            Procedure OnClick
                Send SelectCurrentState of oPromptList
            End_Procedure
        End_Object

        Object oCancelButton is a cWebButton
            Set piColumnSpan to 3
            Set psCaption to "Cancel"
            Set piColumnIndex to 10

            Procedure OnClick
                Send Stop_UI
            End_Procedure
        End_Object

        On_Key Key_Escape Send Close_Panel
    End_Object

    Procedure Popup Handle hoFocus
        Set phoInvokingObject to hoFocus
        Forward Send Popup
    End_Procedure
End_Object
