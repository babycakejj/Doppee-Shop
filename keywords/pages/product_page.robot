*** Keywords ***
Select product by name
    [Documentation]    
    ...     สำหรับเลือกสินค้า ตามค่า product_name ที่ส่งเข้ามา
    ...     และมีค่า default เป็น sunglasses ตาม ${product_page.product_name} หากไม่มีการส่งค่ามาช
    ...     Arguments
    ...         - ${product_name} ชื่อของสินค้า
    [Arguments]    ${product_name}=${product_page.product_name}
    common.Handle random popup
    Browser.Wait for load state    state=load    timeout=${TIMEOUT}   
    Browser.Scroll to element   text=${product_name}
    ${selector}    String.Replace string    string=${product_page_locator.lbl_product_name}    search_for=product_name    replace_with=${product_name}
    Browser.Click    selector=${selector} 


