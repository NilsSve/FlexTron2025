Use Windows.pkg
Use DFClient.pkg

Use cLocalWebControlHost.pkg
Use cCustomerDataDictionary.dd

Use WebResourceManager.wo

Use cWebCombo.pkg
Use cWebSlider.pkg
Use cWebGroup.pkg
Use cWebCheckbox.pkg
Use cWebContextMenu.pkg

Use cDRReport.pkg
Use cWebDRReportViewer.pkg

Use DataFlexReports\CustomerState.sl
Use DataFlexReports\HTMLReportPreviewer.dg
Use DataFlexReports\PDFReportPreviewer.dg
Use DataFlexReports\ImageReportPreviewer.dg

Deferred_View Activate_oCustomerListReportsView for ;
Object oCustomerListReportsView is a dbView
    Object oCustomer_DD is a cCustomerDataDictionary
    End_Object

    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD

    Set Border_Style to Border_Thick
    Set Size to 236 329
    Set Location to 2 2
    Set Label to "DataFlex Reports"

    Object oDataFlexReportsSelections is a cLocalWebControlHost
        Set Size to 236 327
        Set Location to 0 0
        Set piColumnCount to 12
        Set peAnchors to anAll

        On_Key Key_Escape Send Close_Panel

        Procedure Prompt_Callback Handle hoPrompt
            Handle hoFocus

            Get FocusObject to hoFocus
            Send Prompt_Callback of hoFocus hoPrompt
        End_Procedure

        Object oLeftGroup is a cWebGroup
            Set piColumnCount to 12
            Set piColumnIndex to 0
            Set piColumnSpan to 6
            Set pbShowCaption to False
            Set pbFillHeight to True

            Object oSelectionsGroup is a cWebGroup
                Set psCaption to "Customer Selections"
                Set piColumnCount to 12
                Set pbShowBorder to False

                Object oContextMenu is a cWebContextMenu
                    Set psContextCSSSelector to ".ClearableInput input"
                    Set pbChildScopes to True
                    
                    Object oClear is a cWebMenuItem
                        Set psCaption to "Clear"
                        
                        Procedure OnClick
                            Handle hoControl
                            Get ContextScope of oContextMenu to hoControl
                            
                            If (hoControl <> 0) Begin
                                WebSet psValue of hoControl to ""
                            End
                        End_Procedure
                    End_Object
                End_Object

                Object oCustomerNumberForm is a cWebForm
                    Set piColumnSpan to 0
                    Set peLabelPosition to lpTop
                    Set peLabelAlign to alignLeft
                    Set psLabel to "Number:"
                    Set psToolTip to "Enter/select the Customer number to filter on"
                    Set peDatatype to typeNumber
                    Set piMaxLength to 10
                    Set pbPromptButton to True
                    Set psCSSClass to "ClearableInput"

                    Procedure OnPrompt
                        Send Popup of Customer_sl
                    End_Procedure

                    Procedure ShowSelectedCustomer Handle hoPrompt
                        String[] SelectedCustomers

                        Get SelectedColumnValues of hoPrompt 0 to SelectedCustomers
                        If (SizeOfArray (SelectedCustomers) > 0) Begin
                            WebSet psValue to SelectedCustomers[0]
                        End
                    End_Procedure

                    Procedure Prompt_Callback Handle hoPrompt
                        String sValue
                        Integer iColumn

                        Set phoInvokingObject of hoPrompt to Self
                        Set peUpdateMode of hoPrompt to umPromptCustom
                        Get SelectBestColumn of hoPrompt (RefTable (Customer)) (RefTable (Customer.Customer_Number)) to iColumn
                        Set piUpdateColumn of hoPrompt to iColumn
                        Set phmPromptUpdateCallback of hoPrompt to (RefProc (ShowSelectedCustomer))
                        WebGet psValue to sValue
                        Set psSeedValue of hoPrompt to sValue
                    End_Procedure

                    Function CustomerNumberFilter Returns Integer
                        Integer iCustomerNumber

                        WebGet psValue to iCustomerNumber

                        Function_Return iCustomerNumber
                    End_Function
                End_Object

                Object oCustomerNameForm is a cWebForm
                    Set piColumnSpan to 0
                    Set peLabelPosition to lpTop
                    Set peLabelAlign to alignLeft
                    Set psLabel to "Name:"
                    Set psToolTip to "Enter/select the Customer name to filter on"
                    Set peDatatype to typeAscii
                    Set piMaxLength to 30
                    Set pbPromptButton to True
                    Set psCSSClass to "ClearableInput"

                    Procedure OnPrompt
                        Send Popup of Customer_sl
                    End_Procedure

                    Procedure ShowSelectedCustomer Handle hoPrompt
                        String[] SelectedCustomers

                        Get SelectedColumnValues of hoPrompt 1 to SelectedCustomers
                        If (SizeOfArray (SelectedCustomers) > 0) Begin
                            WebSet psValue to SelectedCustomers[0]
                        End
                    End_Procedure

                    Procedure Prompt_Callback Handle hoPrompt
                        String sValue
                        Integer iColumn

                        Set phoInvokingObject of hoPrompt to Self
                        Set peUpdateMode of hoPrompt to umPromptCustom
                        Get SelectBestColumn of hoPrompt (RefTable (Customer)) (RefTable (Customer.Name)) to iColumn
                        Set piUpdateColumn of hoPrompt to iColumn
                        Set phmPromptUpdateCallback of hoPrompt to (RefProc (ShowSelectedCustomer))
                        WebGet psValue to sValue
                        Set psSeedValue of hoPrompt to sValue
                    End_Procedure

                    Function CustomerNameFilter Returns String
                        String sCustomerName

                        WebGet psValue to sCustomerName

                        Function_Return sCustomerName
                    End_Function
                End_Object

                Object oCustomerBalancesSlider is a cWebSlider
                    Set pbShowValue to True
                    Set pbShowRange to True
                    Set pbShowMarkers to True
                    Set pbRanged to True
                    Set peLabelPosition to lpTop
                    Set psLabel to "Balance"

                    Function CustomerBalanceRange Returns Integer[]
                        Integer[2] iValues

                        WebGet piFrom to iValues[0]
                        WebGet piTo to iValues[1]

                        Function_Return iValues
                    End_Function

                    Procedure OnLoad
                        Forward Send OnLoad

                        Send Request_Read of oCustomer_DD FIRST_RECORD Customer.File_Number 3
                        Set piMinValue to Customer.Balance
                        Send Request_Read of oCustomer_DD LAST_RECORD Customer.File_Number 3
                        Set piMaxValue to Customer.Balance
                        Set piTo to Customer.Balance
                    End_Procedure
                End_Object

                Object oCustomerStateForm is a cWebForm
                    Set piColumnSpan to 0
                    Set peLabelPosition to lpTop
                    Set peLabelAlign to alignLeft
                    Set psLabel to "State:"
                    Set psToolTip to "Enter/select the Customer state to filter on"
                    Set peDatatype to typeAscii
                    Set piMaxLength to 2
                    Set pbPromptButton to True
                    Set pbCapslock to True
                    Set psCSSClass to "ClearableInput"

                    Procedure OnPrompt
                        Send Popup of oCustomerStateLookup Self
                    End_Procedure

                    Procedure UpdateInvokingObject tWebRow SelectedRowData
                        WebSet psValue to SelectedRowData.sRowId
                    End_Procedure

                    Function CustomerStateFilter Returns String
                        String sCustomerState

                        WebGet psValue to sCustomerState

                        Function_Return sCustomerState
                    End_Function
                End_Object
            End_Object
        End_Object

        Object oRightGroup is a cWebGroup
            Set piColumnIndex to 6
            Set piColumnCount to 12
            Set piColumnSpan to 6
            Set pbFillHeight to True
            Set pbShowCaption to False

            Object oOutputGroup is a cWebGroup
                Set psCaption to "Output"
                Set pbShowBorder to False
                Set piColumnIndex to 0

                Object oOutputCombo is a cWebCombo
                    Set piColumnSpan to 0
                    Set pbShowLabel to False

                    Procedure OnFill
                        Send AddComboItem "H" "HTML"
                        Send AddComboItem "P" "PDF"
                        Send AddComboItem "I" "Image"
                    End_Procedure

                    Set psValue to "HTML"
                End_Object
            End_Object

            Object oSortOrderGroup is a cWebGroup
                Set psCaption to "Order By"
                Set piColumnCount to 12
                Set pbShowBorder to False
                Set piColumnIndex to 0

                Function SortField Returns String
                    String sSortField

                    WebGet psValue of oSortOnCombo to sSortField

                    Function_Return sSortField
                End_Function

                Function SortDirection Returns Boolean
                    Boolean bSortDescending

                    Get GetChecked of oSortDescending to bSortDescending

                    Function_Return bSortDescending
                End_Function

                Object oSortOnCombo is a cWebCombo
                    Set piColumnSpan to 12
                    Set pbShowLabel to False

                    Procedure OnFill
                        Send AddComboItem "{Customer.Customer_Number}" "Customer_Number"
                        Send AddComboItem "{Customer.Name}" "Name"
                    End_Procedure

                    Set psValue to "{Customer.Customer_Number}"
                End_Object

                Object oSortDescending is a cWebCheckBox
                    Set piColumnSpan to 4
                    Set psCaption to "Descending"
                End_Object
            End_Object
        End_Object

        Object oRunButton is a cWebButton
            Set psCaption to "Run Report"
            Set piColumnSpan to 12

            Procedure OnClick
                String sOutput

                WebGet psValue of oOutputCombo to sOutput

                Case Begin
                    Case (sOutput = 'H')
                        Send ShowReport of oHTMLReportPreviewer (oReport)
                        Case Break
                    Case (sOutput = 'P')
                        Send ShowReport of oPDFReportPreviewer (oReport)
                        Case Break
                    Case (sOutput = 'I')
                        Send ShowReport of oImageReportPreviewer (oReport)
                        Case Break
                Case End
            End_Procedure
        End_Object
    End_Object

    Object oReport is a cDRReport
        Set psReportName to "CustomerList.dr"

        Procedure OnInitializeReport
            Set piReportLanguage '' to LANG_DEFAULT

            Send SetFilters
            Send SetSortFields
        End_Procedure

        Procedure SetSortFields
            String sReportId sSortField
            Boolean bSortDescending

            Get psReportId to sReportId
            Get SortField of oSortOrderGroup to sSortField
            Get SortDirection of oSortOrderGroup to bSortDescending

            If (bSortDescending) Begin
                Send AddRecordSortField sReportId sSortField C_drDescending
            End
            Else Begin
                Send AddRecordSortField sReportId sSortField C_drAscending
            End
        End_Procedure

        Procedure SetFilters
            String sReportId sCustomerName sCustomerState
            Integer iCustomerNumber
            Integer[2] iValues

            Get psReportId to sReportId

            Get CustomerNumberFilter of oCustomerNumberForm to iCustomerNumber
            If (iCustomerNumber > 0) Begin
                Send AddFilter sReportId "{Customer.Customer_Number}" C_drEqual iCustomerNumber
            End

            Get CustomerNameFilter of oCustomerNameForm to sCustomerName
            If (sCustomerName <> "") Begin
                Send AddFilter sReportId "{Customer.Name}" C_drEqual sCustomerName
            End

            Get CustomerBalanceRange of oCustomerBalancesSlider to iValues
            Send AddFilter sReportId "{Customer.Balance}" C_drGreaterThanOrEqual iValues[0]
            Send AddFilter sReportId "{Customer.Balance}" C_drLessThanOrEqual iValues[1]

            Get CustomerStateFilter of oCustomerStateForm to sCustomerState
            If (sCustomerState <> "") Begin
                Send AddFilter sReportId "{Customer.State}" C_drEqual sCustomerState
            End
        End_Procedure
    End_Object
Cd_End_Object
