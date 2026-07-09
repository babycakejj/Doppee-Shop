*** Keywords ***
Click create account button
    [Documentation]    
    ...     สำหรับกดปุ่ม create account เพื่อไปยังหน้าสร้างบัญชี
    common.Handle random popup
    Browser.Wait for elements state  selector=${signup_locator.btn_create_account_1}  state=visible    timeout=${TIMEOUT}  
    Browser.Wait for elements state  selector=${signup_locator.btn_create_account_1}  state=enabled    timeout=${TIMEOUT}  
    Browser.Click    selector=${signup_locator.btn_create_account_1}
    Switch Page    NEW

Fill full name
    [Documentation]    
    ...     สำหรับกรอกค่า full name ตามค่า fullname ที่ส่งเข้ามา
    ...     และมีค่า default ตาม ${signup_page.default_full_name} หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${fullname} ค่าของ full name
    [Arguments]    ${fullname}=${signup_page.default_full_name}
    Browser.Fill text    selector=${signup_locator.txt_fullname}    txt=${fullname}

Fill phone number
    [Documentation]    
    ...     สำหรับกรอกค่า phone number ตามค่า phone_number ที่ส่งเข้ามา
    ...     และมีค่า default ตาม ${signup_page.default_phone} หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${phone_number} ค่าของ phone number
    [Arguments]    ${phone_number}=${signup_page.default_phone}
    Browser.Fill text    selector=${signup_locator.txt_phone_number}    txt=${phone_number}

Fill email
    [Documentation]    
    ...     สำหรับกรอกค่า email ตามค่า email ที่ส่งเข้ามา
    ...     และจะทำการสุ่มให้ หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${email} ค่าของ email
    ...     Return
    ...         - ${email} คืนค่าของ email ที่ถูกกรอกไปกลับมา
    [Arguments]    ${email}=RANDOM
    IF    '${email}' == 'RANDOM'
        ${random_email_id}    String.Generate Random String    length=5    chars=[LETTERS][NUMBERS]
        ${email}    BuiltIn.Set Variable    ${random_email_id}@doppiotech.com
    END
    Browser.Fill Text    selector=${signup_locator.txt_email}    txt=${email}
    RETURN    ${email}

Fill password
    [Documentation]    
    ...     สำหรับกรอกค่า password ตามค่า password ที่ส่งเข้ามา
    ...     และมีค่า default ตาม ${signup_page.default_password} หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${password} ค่าของ password
    [Arguments]    ${password}=${signup_page.default_password}
    Browser.Fill text    selector=${signup_locator.txt_password}    txt=${password}

Fill confirm password
    [Documentation]    
    ...     สำหรับกรอกค่า password อีกครั้ง ตามค่า password ที่ส่งเข้ามา
    ...     และมีค่า default ตาม ${signup_page.default_password} หากไม่มีการส่งค่ามา
    ...     Arguments
    ...         - ${password} ค่าของ password
    [Arguments]    ${password}=${signup_page.default_confirm_password_pass}
    Browser.Fill text    selector=${signup_locator.txt_confirm_password}    txt=${password}

Click for create account
    [Documentation]    
    ...     สำหรับกดปุ่ม create account เพื่อสร้างบัญชี
    Browser.Click    selector=${signup_locator.btn_create_account_2}