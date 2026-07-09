*** Keywords ***
Sign in to doppee shop
    [Arguments]    ${email}    ${password}
    signin_page.Fill email    email=${email}
    signin_page.Fill password    password=${password}
    signin_page.Click for sign in