*** Keywords ***
Click select all products
    [Documentation]    
    ...     สำหรับกด check box > select all เพื่อทำการเลือกสินค้าทั้งหมดในตะกร้า
    common.Handle random popup
    Browser.Wait for load state    state=networkidle    timeout=${TIMEOUT}
    Browser.Click    selector=${cart_locator.chk_select_all}


Click dropdown coupon
    [Documentation]    
    ...     สำหรับกด dropdown coupon 
    Browser.Wait for load state    state=networkidle    timeout=${TIMEOUT}    
    Browser.Click    selector=${cart_locator.btn_coupon}


Select coupon
    [Documentation]    
    ...     สำหรับกดเลือก coupon ที่ต้องการตามค่า coupon ที่ส่งมา
    ...     Arguments
    ...         - ${coupon} ค่าของโค้ด coupon โดยกำหนดค่าเริ่มต้นเป้น FLAT50
    ...     Return
    ...         - ${discount} คืนค่าของ coupon ที่ถูกเลือก เพื่อนำไปคำนวณต่อ
    [Arguments]    ${coupon}=FLAT50
    Browser.Wait for load state   state=networkidle    timeout=${TIMEOUT}
    ${selector}    String.Replace string    string=${cart_locator.ddl_coupon}    search_for=coupon    replace_with=${coupon}
    Browser.Click    selector=${selector}     
    RETURN    ${coupon}


Click apply coupon button
   [Documentation]    
    ...     สำหรับกดปุ่ม Apply เพื่อใช้ coupon ที่เลือก
    Browser.Click       selector=${cart_locator.btn_apply}

Get coupon discount
    [Documentation]    
    ...     สำหรับตรวจสอบประเภทของคูปองส่วนลด และแปลงค่าที่ได้ให้อยู่ในรูปแบบตัวเลข
    ...     Arguments
    ...         - ${coupon} ค่าของ coupon ที่เลือก ตัวอย่าง: -THB1,000 / -10%
    ...     Return
    ...         - AMOUNT/PERCENT รูปแบบที่ลด
    ...         - ${discount} มูลค่าที่ลด แปลงเป็นจำนวนทศนิยมแล้ว
    [Arguments]    ${coupon}
    ${coupon}    String.Replace string    string=${coupon}    search_for=\n    replace_with=${EMPTY}
    ${selector}    String.Replace string    string=${cart_locator.lbl_coupon}    search_for=coupon    replace_with=${coupon}
    ${discount}    Browser.Get text    selector=${selector}
    IF    '${discount}'.startswith('-THB')
        ${discount}    String.Replace string    ${discount}    -THB    ${EMPTY}
        ${discount}    String.Replace string    ${discount}    ,       ${EMPTY}
        ${discount}    BuiltIn.Convert to number    ${discount}
        RETURN    AMOUNT    ${discount}
    ELSE
        ${discount}    String.Replace string    ${discount}    -    ${EMPTY}
        ${discount}    String.Replace string    ${discount}    %    ${EMPTY}
        ${discount}    BuiltIn.Convert to number    ${discount}
        RETURN    PERCENT    ${discount}
    END

Calculate shipping fee
    [Documentation]    
    ...     สำหรับคำนวณค่าส่ง จากราคาของสินค้าทั้งหมด
    ...     Arguments
    ...         - ${subtotal} ราคาของสินค้าทั้งหมด
    ...     Return
    ...         - ${shipping} ค่าจัดส่ง   
    [Arguments]    ${subtotal}   
    IF    ${subtotal} >= 1000
        ${shipping}    BuiltIn.Set Variable    0
    ELSE
        ${shipping}    BuiltIn.Set Variable    50
    END
    RETURN    ${shipping}

Calculate discount 
    [Documentation]    
    ...     สำหรับคำนวณมูลค่าส่วนลดจากประเภทของคูปอง
    ...     Arguments
    ...         - ${type} รูปแบบการลดราคาเป็น AMOUNT/PERCENT
    ...         - ${value} มูลค่าที่จะลดราคาฃอง
    ...     Return
    ...         - ${discount} จำนวนเงินส่วนลดที่คำนวณแล้ว
    [Arguments]    ${type}    ${value}    ${subtotal}
    IF    '${type}' == 'PERCENT'
        ${discount}    BuiltIn.Evaluate    ${subtotal} * ${value} / 100
    ELSE
        ${discount}    BuiltIn.Set variable    ${value}
    END
    RETURN    ${discount}

Calculate total after discount
    [Documentation]    
    ...     สำหรับคำนวณยอดรวมสุทธิหลังหักส่วนลด
    ...     Arguments
    ...         - ${subtotal} ยอดรวมสินค้า
    ...         - ${vat} ภาษีมูลค่าเพิ่ม
    ...         - ${shipping} ค่าจัดส่ง
    ...         - ${discount} ส่วนลดที่คำนวณแล้ว
    ...     Return
    ...         - ${amount} ยอดรวมสุทธิ

    [Arguments]    ${subtotal}    ${vat}    ${shipping}    ${discount}   

    ${amount}    BuiltIn.Evaluate    (${subtotal} + ${vat} + ${shipping}) - ${discount}


    RETURN    ${amount}

Get total from web display
    [Documentation]    
    ...     สำหรับดึงค่า total ยอดรวมสุทธิที่แสดงบนหน้าจอ
    ...     Return
    ...         - ${total} ยอดรวมสุทธิ
    ${total}    Browser.Get text    selector=${cart_locator.lbl_total}
    ${total}    String.Replace string      ${total}    ,    ${EMPTY}
    ${total}    String.Replace string      ${total}    THB    ${EMPTY}
    ${total}    BuiltIn.Convert to number   ${total}
    RETURN    ${total}


Compare total from calculate and web
    [Documentation]    
    ...     สำหรับตรวจสอบยอดรวมสุทธิระหว่าง
    ...     total_calculate ค่าที่คาดหวัง
    ...     total_web ค่าที่แสดงบนหน้าจอ
    [Arguments]    ${total_calculate}    ${total_web}
    BuiltIn.Should be equal as numbers    first=${total_calculate}    second=${total_web}