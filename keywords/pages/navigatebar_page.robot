*** Keywords ***
Click icon profile
    [Documentation]    
    ...     สำหรับกด icon user บน navigate bar
    common.Handle random popup
    Browser.Click    selector=${navigatebar_locator.btn_account}

Click menu sign in
    [Documentation]    
    ...     สำหรับกดเมนู sign in
    Browser.Click    selector=${navigatebar_locator.btn_signin}
    Browser.Wait for load state    state=networkidle    timeout=${TIMEOUT}   

Verify login success after create account
    [Documentation]    
    ...     สำหรับตรวจสอบว่าหลังจากสมัครบัญชีแล้ว ระบบทำการเข้าสู่ระบบให้อัติโนมัติ
    ...     Arguments
    ...         - ${email} ค่าของ email ที่ต้องการตรวจสอบ เป็น email ที่เพิ่งสมัครบัญชี
    [Arguments]  ${email}
    common.Handle random popup
    Browser.Get text    selector=${navigatebar_locator.lbl_username} >> text=${email}

Click menu profile
    [Documentation]    
    ...     สำหรับกดเมนู profile
    Browser.Click    selector=${navigatebar_locator.btn_profile}  

Click logo doppee shop
    [Documentation]    
    ...     สำหรับกดโลโก้ Doopee Shop
    Browser.Click    selector=${navigatebar_locator.btn_logo} >> text=Doppee Shop

Verify quantity in cart badge is displayed as expected
    [Documentation]    
    ...     สำหรับตรวจสอบจำนวนของในตะกร้าสินค้า
    [Arguments]    ${product_quantity}=5
    Browser.Wait for load state   state=networkidle    timeout=${TIMEOUT}
    Browser.Wait for elements state   selector=${navigatebar_locator.lbl_quantity_in_cart} >> text=${product_quantity}   state=visible   

Click icon cart
    [Documentation]    
    ...     สำหรับกด icon ตะกร้าสินค้า เพื่อไปยังหน้าตะกร้าสินค้า
    Browser.Wait for load state   state=networkidle    timeout=${TIMEOUT}
    Browser.Click    selector=${navigatebar_locator.btn_cart} 