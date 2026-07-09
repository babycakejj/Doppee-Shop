*** Keywords ***
Create account
    [Arguments]    ${email}     ${fullname}    ${phone_number}    ${password}    ${confirm_password}
    signup_page.Fill full name    fullname=${fullname} 
    ${email}    signup_page.Fill email    email=${email}
    signup_page.Fill phone number    phone_number=${phone_number}
    signup_page.Fill password    password=${password}
    signup_page.Fill confirm password    password=${confirm_password}
    signup_page.Click for create account
    RETURN    ${email}