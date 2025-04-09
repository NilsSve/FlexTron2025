Use Windows.pkg
Use DFClient.pkg

Use AllWebControlClasses.pkg
Use cDbLocalWebControlHost.pkg

Use cVendorDataDictionary.dd
Use cInventoryDataDictionary.dd
Use cCustomerDataDictionary.dd
Use cSalesPersonDataDictionary.dd
Use cOrderHeaderDataDictionary.dd
Use cOrderDetailDataDictionary.dd

Deferred_View Activate_oWebDataEntry For ;
Object oWebDataEntry is a dbView

    Set Border_Style to Border_Thick
    Set Size to 303 362
    Set Location to 2 2
    Set Label to "Web DataEntry"
        
    Object oVendorDataDictionary is a cVendorDataDictionary
    End_Object
    
    Object oInventoryDataDictionary is a cInventoryDataDictionary
        Set DDO_Server to oVendorDataDictionary
        
        Procedure OnPostFind Integer eMessage Boolean bFound
            Boolean bSynching
            
            // Each time an inventory item is selected, we use the unit price as the
            // suggested price for the line item.
            
            Get AppSynching of oWebDetail to bSynching
            // Do not perform this action while synchronizing DDOs to the WebApp Client
            If (not(bSynching)) Begin
                Send SetPriceDefault of oOrderDetailDataDictionary Inventory.Unit_Price
            End
        End_Procedure
    End_Object
    
    Object oCustomerDataDictionary is a cCustomerDataDictionary
    End_Object
    
    Object oSalesPersonDataDictionary is a cSalesPersonDataDictionary
    End_Object
    
    /*
    In this sample we Use the Db version to support Data Dictionary and Data Entry Support.  
    */
    Object oWebDetail is a cDbLocalWebControlHost
        Set Size to 302 358
        Set Location to 0 4
        Set piColumnCount to 10
        Set peAnchors to anAll
        
        /*
        This DD is here to Show that you can have them both in the Web side and Windows.
        */
        Object oOrderHeaderDataDictionary is a cOrderHeaderDataDictionary
            Set DDO_Server to oCustomerDataDictionary
            Set DDO_Server to oSalesPersonDataDictionary
            // this lets you save a new parent DD record from within child DD
            Set Allow_Foreign_New_Save_State to True
            
            //Set Field_WebPrompt_Object Field OrderHeader.Order_Number to oOrderWebLookup
        End_Object
    
        Object oOrderDetailDataDictionary is a cOrderDetailDataDictionary
            Set DDO_Server to oOrderHeaderDataDictionary
            Set DDO_Server to oInventoryDataDictionary
            Set Constrain_File to OrderHeader.File_Number
            
            // set the default price and adjust the display total
            Procedure SetPriceDefault Number nNum
                Set Field_Changed_Value Field OrderDetail.Price to nNum
                Send Adjust_Display_total
            End_Procedure
        End_Object
        
        Set Main_DD to oOrderHeaderDataDictionary
        Set Server  to oOrderHeaderDataDictionary
            
        Object oOrderHeaderOrder_Number is a cWebForm
            Entry_Item OrderHeader.Order_Number
            Set piColumnSpan to 5
            Set piColumnIndex to 0
            Set psLabel to "Order Number:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oCustomerCustomer_Number is a cWebForm
            Entry_Item Customer.Customer_Number
            Set piColumnSpan to 5
            Set piColumnIndex to 5
            Set psLabel to "Customer Number:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oOrderHeaderOrder_Date is a cWebDateForm
            Entry_Item OrderHeader.Order_Date
            Set piColumnSpan to 5
            Set psLabel to "Order Date:"
            Set peLabelAlign to alignRight
            Set piColumnIndex to 5
        End_Object
        
        Object oCustomerName is a cWebForm
            Entry_Item Customer.Name
            Set piColumnSpan to 5
            Set piColumnIndex to 0
            Set psLabel to "Customer Name:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oCustomerAddress is a cWebForm
            Entry_Item Customer.Address
            Set piColumnSpan to 5
            Set piColumnIndex to 0
            Set psLabel to "Street Address:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oCustomerCity is a cWebForm
            Entry_Item Customer.City
            Set piColumnSpan to 5
            Set piColumnIndex to 0
            Set psLabel to "City:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oCustomerZip is a cWebForm
            Entry_Item Customer.Zip
            Set piColumnSpan to 5
            Set piColumnIndex to 5
            Set psLabel to "Zip:"
            Set peLabelAlign to alignRight
        End_Object

        Object oCustomerState is a cWebCombo
            Entry_Item Customer.State
            Set piColumnSpan to 5
            Set piColumnIndex to 5
            Set psLabel to "State:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oOrderHeaderOrdered_By is a cWebForm
            Entry_Item OrderHeader.Ordered_By
            Set piColumnSpan to 5
            Set psLabel to "Ordered By:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oSalesPersonID is a cWebParentCombo
            Entry_Item SalesPerson.Name
            Set piColumnSpan to 5
            Set piColumnIndex to 5
            Set psLabel to "Salesperson:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oOrderHeaderTerms is a cWebCombo
            Entry_Item OrderHeader.Terms
            Set piColumnSpan to 5
            Set piColumnIndex to 0
            Set psLabel to "Terms:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oOrderHeaderShip_Via is a cWebCombo
            Entry_Item OrderHeader.Ship_Via
            Set piColumnSpan to 5
            Set piColumnIndex to 5
            Set psLabel to "Ship Via:"
            Set peLabelAlign to alignRight
        End_Object
        
        Object oDetailGrid is a cWebGrid
            Set Server to oOrderDetailDataDictionary
            Set piOrdering to 1
            Set pbFillHeight to True
            Set piColumnSpan to 11
            Set piMinHeight to 200
            
            Object oInventoryItem_ID is a cWebColumn
                Entry_Item Inventory.Item_ID
                Set psCaption to "Item ID"
                Set piWidth to 130
            End_Object
            
            Object oInventoryDescription is a cWebColumn
                Entry_Item Inventory.Description
                Set psCaption to "Description"
                Set piWidth to 320
            End_Object
            
            Object oInventoryUnit_Price is a cWebColumn
                Entry_Item Inventory.Unit_Price
                Set psCaption to "Unit Price"
                Set piWidth to 94
            End_Object
            
            Object oOrderDetailPrice is a cWebColumn
                Entry_Item OrderDetail.Price
                Set psCaption to "Price"
                Set piWidth to 94
                Set pbServerOnChange to True
                
                Procedure OnChange String sNewValue String sOldValue
                    Send Adjust_Display_total of oOrderDetailDataDictionary
                End_Procedure
            End_Object
            
            Object oOrderDetailQty_Ordered is a cWebColumn
                Entry_Item OrderDetail.Qty_Ordered
                Set psCaption to "Quantity"
                Set piWidth to 94
                Set pbServerOnChange to True
                
                Procedure OnChange String sNewValue String sOldValue
                    Send Adjust_Display_total of oOrderDetailDataDictionary
                End_Procedure
            End_Object
            
            Object oOrderDetailExtended_Price is a cWebColumn
                Entry_Item OrderDetail.Extended_Price
                Set psCaption to "Total"
                Set piWidth to 115
            End_Object
        End_Object
        
        Object oOrderHeader_Order_Total is a cWebForm
            Entry_Item OrderHeader.Order_Total
            Set psLabel to "Order Total:"
            
            Set piColumnIndex to 6
            Set peLabelAlign to alignRight
            Set piColumnSpan to 4
        End_Object
        
    End_Object

Cd_End_Object