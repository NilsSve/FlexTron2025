Use Windows.pkg
Use DFClient.pkg
Use DFEntry.pkg

Use AllWebControlClasses.pkg
Use cDbLocalWebControlHost.pkg

Use cCustomerDataDictionary.dd

Deferred_View Activate_oMixedDataEntry For ;
Object oMixedDataEntry is a dbView
    Set Border_Style to Border_Thick
    Set Size to 218 305
    Set Location to 2 2
    Set Label to "Mixed DataEntry"
    
    Object oCustomer_DD is a cCustomerDataDictionary
    End_Object

    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD

    Object oCustomerCustomerNumber is a dbForm
        Entry_Item Customer.Customer_Number
        Set Location to 10 71
        Set Size to 12 229
        Set Label to "Customer Number:"
        Set peAnchors to anTopLeftRight
    End_Object

    Object oCustomerName is a dbForm
        Entry_Item Customer.Name
        Set Location to 24 71
        Set Size to 12 228
        Set Label to "Customer Name:"
        Set peAnchors to anTopLeftRight
    End_Object

    /*
    In this sample we Use the Db version to support Data Dictionary and Data Entry Support.  
    */
    Object oWebDetail is a cDbLocalWebControlHost
        Set Size to 181 297
        Set Location to 36 7
        Set piColumnCount to 12
        Set peAnchors to anAll

        Object oCustomerDetail is a cWebTabContainer
            Object oContactInfo is a cWebTabPage
                Set psCaption to "Contact Info"
                Set piColumnCount to 12    

                Object oCustomerAddress is a cWebForm
                    Entry_Item Customer.Address

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "Street Address:"
                End_Object

                Object oCustomerCity is a cWebForm
                    Entry_Item Customer.City

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "City:"
                End_Object

                Object oCustomerState is a cWebCombo
                    Entry_Item Customer.State

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "State:"
                End_Object

                Object oCustomerZip is a cWebForm
                    Entry_Item Customer.Zip

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "Zip/Postal Code:"
                End_Object

                Object oCustomerPhoneNumber is a cWebForm
                    Entry_Item Customer.Phone_Number

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "Phone Number:"
                End_Object

                Object oCustomerFaxNumber is a cWebForm
                    Entry_Item Customer.Fax_Number

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "Fax Number:"
                End_Object

                Object oCustomerEMailAddress is a cWebForm
                    Entry_Item Customer.EMail_Address

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "E-Mail Address:"
                End_Object
            End_Object

            Object oCreditDetail is a cWebTabPage
                Set psCaption to "Credit Info"
                Set piColumnCount to 12    

                Object oCustomerCreditLimit is a cWebForm
                    Entry_Item Customer.Credit_Limit

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 6
                    Set psLabel to "Credit Limit:"
                End_Object

                Object oCustomerPurchases is a cWebForm
                    Entry_Item Customer.Purchases

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 6
                    Set psLabel to "Total Purchases:"
                End_Object

                Object oCustomerStatus is a cWebCheckBox
                    Entry_Item Customer.Status

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psCaption to "Active Status"
                End_Object
            End_Object

            Object oCommentDetail is a cWebTabPage
                Set psCaption to "Comments"
                Set piColumnCount to 12    

                Object oCustomerComments is a cWebEdit
                    Entry_Item Customer.Comments

                    Set Server to oCustomer_DD
                    Set piColumnSpan to 0
                    Set psLabel to "Comments:"
                    Set pbFillHeight to True
                End_Object
            End_Object
        End_Object
    End_Object

Cd_End_Object