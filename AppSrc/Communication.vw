Use Windows.pkg
Use DFClient.pkg

Use AllWebControlClasses.pkg
Use cLocalWebControlHost.pkg

Deferred_View Activate_oCommunication For ;
Object oCommunication is a dbView
    Set Border_Style to Border_Thick
    Set Size to 200 477
    Set Location to 14 39
    Set Label to "Communication"
    
    /*
    In this sample we Use the cLocalControlHost to communicate with Windows
    through Events and WebSets, like we are normally able to Handle in Windows, and change
    information provided by the user.
    */
    Object oLeftWebHost is a cLocalWebControlHost
        Set Size to 195 368
        Set Location to 3 7
        Set piColumnCount to 12
        Set peAnchors to anTopBottomLeft
        
        Object oInfo is a cWebLabel
            Set psCaption to @"In this sample we use the cLocalControlHost to communicate with Windows
            through Events and WebSets, like we are normally able to Handle in Windows, and change 
            information provided by the user."
            Set piColumnSpan to 12
        End_Object
        
        Object oSample1 is a cWebLabel
            Set psCaption to @"1. Clicking the Change button will set the value of the form next to it (in same container)."
            Set piColumnSpan to 12
        End_Object

        Object oSample1FormInput is a cWebForm
            Set piColumnSpan to 10
            Set pbReadOnly to True
            Set pbShowLabel to False
        End_Object

        Object oSample1ChangeBtn is a cWebButton
            Set piColumnSpan to 2
            Set psCaption to "Change"
            Set piColumnIndex to 10 

            Procedure OnClick
                WebSet psValue of oSample1FormInput to "Changed!"
            End_Procedure
        End_Object
        
        Object oSample2 is a cWebLabel
            Set psCaption to @"2. Clicking the Change button on the Windows side will set the value of the form (in the control host)."
            Set piColumnSpan to 12
        End_Object

        Object oSample2FormInput is a cWebForm
            Set piColumnSpan to 12
            Set pbReadOnly to True
            Set pbShowLabel to False
        End_Object
        
        Object oSample3 is a cWebLabel
            Set psCaption to @"3. Typing will sync the values between Windows and web."
            Set piColumnSpan to 12
        End_Object

        Object oSample3SyncedWebForm is a cWebForm
            Set piColumnSpan to 12
            Set pbServerOnChange to True
            Set pbShowLabel to False
            
            Procedure OnChange String sNewValue String sOldValue
                Set Value of oSample3SyncedWinForm to sNewValue
            End_Procedure
        End_Object
        
        Object oSample4 is a cWebLabel
            Set psCaption to @"4. Clicking the toggle will enable/disable the button in the other cLocalControlHost."
            Set piColumnSpan to 12
        End_Object

        Object oSample4FlipBtnDisabler is a cWebCheckbox
            Set piColumnSpan to 8
            Set psCSSClass to "FlipSwitch"
            Set pbServerOnChange to True
            
            Procedure OnChange String sNewValue String sOldValue
                Boolean bChecked
                Get GetChecked to bChecked
                WebSet pbEnabled of oSample4Btn to bChecked
            End_Procedure
        End_Object
    End_Object

    // Right side Windows
    Object oSample2ChangeBtn is a Button
        Set Size to 15 99
        Set Location to 109 374
        Set Label to "Change"
        Set peAnchors to anTopLeftRight
    
        Procedure OnClick
            WebSet psValue of oSample2FormInput to "Changed by Windows." 
        End_Procedure
    End_Object

    // Right side Windows
    Object oSample3SyncedWinForm is a Form
        Set Size to 14 100
        Set Location to 143 374
        Set peAnchors to anTopLeftRight

        Procedure OnChange
            String sVal
            Get Value to sVal
            WebSet psValue of oSample3SyncedWebForm to sVal
        End_Procedure
    End_Object

    Object oSample4WebHostRight is a cLocalWebControlHost
        Set Size to 28 105
        Set Location to 168 372
        Set piColumnCount to 4
        Set peAnchors to anTopLeftRight

        Object oSample4Btn is a cWebButton
            Set psCaption to "Button in another container"
            Set piColumnSpan to 4
            Set pbEnabled to False
        End_Object
    End_Object

Cd_End_Object