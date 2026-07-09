*** Keywords ***
Fill email to subscribe
    [Documentation]    
    ...     สำหรับการกรอก email ในช่อง Get exclusive deals
    ...     Arguments
    ...         - ${email} ค่าของ email ที่ต้องการกรอก
    [Arguments]    ${email}    
    common.Handle random popup
    Browser.Fill text   selector= ${home_locator.txt_subscribe_email}    txt=${email}

Click subscribe button
    [Documentation]    
    ...     สำหรับการกดปุ่ม Subscibe
    Browser.Click    selector=${home_locator.btn_subscribe_email}

Verify subscribe is success
    [Documentation]    
    ...     สำหรับตรวจข้อความขอบคุณ ว่าแสดง email ที่กรอกหรือไม่
    ...     Arguments
    ...         - ${email} ค่าของ email ที่ต้องการกรอก
    [Arguments]    ${email}
    ${message_thank}    Browser.Get Text    selector=${home_locator.lbl_subscribe_email}
    Builtin.Should be equal as strings    first=${message_thank}    second=🎉 Thanks! We'll send deals to ${email}

CLick to view all products
    [Documentation]    
    ...     สำหรับกดปุ่ม View all ในหน้า Home เพื่อไปยังหน้า Product list page
    Browser.Wait for load state   state=networkidle    timeout=${TIMEOUT}
    Browser.Click    selector=${home_locator.btn_view_all}
