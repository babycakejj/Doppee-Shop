*** Keywords ***
Select product color
    [Documentation]    
    ...     สำหรับกดเลือกตัวเลือกสี ของสินค้า ตามค่า ${color} ที่ส่งมา
    ...     และมีค่า default เป็นตัวเลือกแรก หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${color} ค่าของ สี 
    [Arguments]    ${color}=FIRST  
    common.Handle random popup
    ${has_color}    Browser.Get Element Count    selector=${product_detail_locator.lbl_color}
    IF    ${has_color} > 0
        IF    '${color}' == 'FIRST'
            Browser.Click    selector=${product_detail_locator.btn_default_color}
        ELSE
            ${selector}    String.Replace string    string=${product_detail_locator.btn_color}    search_for=color    replace_with=${color}
            Browser.Click    selector=${selector} 
        END
    END

Select product size
    [Documentation]    
    ...     สำหรับกดเลือกตัวเลือกขนาด ของสินค้า ตามค่า ${size} ที่ส่งมา
    ...     และมีค่า default เป็นตัวเลือกแรก หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${size} ค่าของ ขนาด
    [Arguments]    ${size}=FIRST
    ${has_size}    Browser.Get Element Count   selector=${product_detail_locator.lbl_size}
    IF    ${has_size} > 0
        IF    '${size}' == 'FIRST'
            Browser.Click    selector=${product_detail_locator.btn_default_size}
        ELSE
            ${selector}    String.Replace string    string=${product_detail_locator.btn_size}    search_for=size    replace_with=${size}
            Browser.Click    selector=${selector} 
        END
    END

Click increase quantity
    [Documentation]    
    ...     สำหรับกดจำนวนสินค้า ตามค่า ${product_quantity} ที่ส่งมา
    ...     และมีค่า default เป็น 5 หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${product_quantity} ค่าของ จำนวนสินค้า
    [Arguments]    ${product_quantity}=5
    FOR    ${i}    IN RANGE    1    ${product_quantity}
        Browser.Click    selector=${product_detail_locator.btn_increase_quantity}
    END

Get product subtotal value
    [Documentation]    
    ...     สำหรับการดึงค่า subtotal และทำการแปลงให้อยู่ในรูปแบบเลขทศนิยม
    ...     Return
    ...         - ${subtotal} คืนค่า subtotal ที่แปลงแล้ว
    ${subtotal}    Browser.Get text    selector=${product_detail_locator.lbl_subtotal}
    ${subtotal}    String.Replace string      ${subtotal}    ,    ${EMPTY}
    ${subtotal}    String.Replace string      ${subtotal}    THB    ${EMPTY}
    ${subtotal}    BuiltIn.Convert to number   ${subtotal}
    RETURN    ${subtotal}


Get product vat value
    [Documentation]    
    ...     สำหรับการดึงค่า vat และทำการแปลงให้อยู่ในรูปแบบเลขทศนิยม
    ...     Return
    ...         - ${vat} คืนค่า vat ที่แปลงแล้ว
    ${vat}    Browser.Get text    selector=${product_detail_locator.lbl_vat}
    ${vat}    String.Replace string      ${vat}    ,    ${EMPTY}
    ${vat}    String.Replace string      ${vat}    THB    ${EMPTY}
    ${vat}    BuiltIn.Convert to number  ${vat}
    RETURN    ${vat}

Get product total value
    [Documentation]    
    ...     สำหรับการดึงค่า total และทำการแปลงให้อยู่ในรูปแบบเลขทศนิยม
    ...     Return
    ...         - ${total} คืนค่า total ที่แปลงแล้ว
    ${total}    Browser.Get text    selector=${product_detail_locator.lbl_total}
    ${total}    String.Replace string      ${total}    ,    ${EMPTY}
    ${total}    String.Replace string      ${total}    THB    ${EMPTY}
    ${total}    BuiltIn.Convert to number  ${total}
    RETURN    ${total}


Click Add to Cart
    [Documentation]    
    ...     สำหรับกดเพิ่ม สินค้า เข้าตะกร้า
    Browser.Click    selector=${product_detail_locator.btn_add_to_cart}