*** Keywords ***
Apply coupon
    [Documentation]    
    ...     สำหรับกดเลือกคูปอง ตามค่าที่ผู้ใช้ระบุ
    ...     Arguments
    ...         - ${coupon} โค้ด ของ คูปอง
    [Arguments]    ${coupon}=FLAT50
    cart_page.Click dropdown coupon
    ${coupon}    cart_page.Select coupon  coupon=${coupon}  
    RETURN    ${coupon}