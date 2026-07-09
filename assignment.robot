*** Settings ***
Library           Browser
Library           String
Suite Teardown    Close Browser

*** Variables ***
${base_url}       http://192.8.8.236:5173/
${browser}        chromium
${phone}          0123456789
${name}           name
${password}       Ab123456

*** Keywords ***
Open Browser
    [Documentation]    เปิด Chrome
    Browser.New Browser    ${browser}    headless=false  # การบ้าน
    Browser.New Context    tracing=true    # การบ้าน
    Browser.New Page    ${base_url}    # การบ้าน  agrument 10 web

Close Popup
    ${popup_visible}=    Run Keyword And Return Status    Browser.Wait For Elements State    css=[aria-label="Close popup"]    visible    timeout=500ms

    IF    ${popup_visible}  # ทำไม ไม่เชียนเต็ม
        Browser.Click    css=[aria-label="Close popup"]
    END

Click Icon Profile
    Close Popup
    Browser.Click    css=[id^="btn-account"]

Click Sign In
    Browser.Click    css=[href="/signin"]
    Browser.Wait For Load State    state=load    timeout=15s    # รอโหลดอะไร
    Wait For Elements State  iframe  attached  timeout=15s          # อะไร

Click Create Account on signin
    Close Popup

    Wait For Elements State  iframe[name="login-frame"] >>> [href="/signup"]  visible  timeout=15s  #  iframe[name="login-frame"] >>> [href="/signup"]

    Wait For Elements State  iframe[name="login-frame"] >>> [href="/signup"]  enabled  timeout=15s  #  visible, enabled
    
    Browser.Wait For Load State    state=load    timeout=15s
    
    Click  iframe[name="login-frame"] >>> [href="/signup"]


Click Create Account
    Close Popup

    Browser.Wait For Elements State  css=[id^="btn-open-signup"]  visible  timeout=15s

    Browser.Wait For Elements State  css=[id^="btn-open-signup"]  enabled  timeout=15s

    Browser.Click    css=[id^="btn-open-signup"]
    

    # ${pages}    Get Page Ids  #  ตอนแรกมี 1 >> เพิ่มเป้น 2 อัน 2 ไปอยุ่ที่ไหน
    # Log To Console    Pages=${pages}

    Switch Page    NEW   # อะไรวะ


Fill full name
    # ${random_name}=     Generate Random String    8    [LETTERS]
    Browser.Fill text    css=#full-name    ${name}

Fill phone
    # ${random_phone}=     Generate Random String    9    [NUMBERS]
    Browser.Fill text    css=#phone    ${phone}

Fill email
    # Browser.Click    css=#em    #  ทำยังไงให้ email สามารถรับทั้ง random, specific
    ${random_email_id}=  Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=    Set Variable    ${random_email_id}@doppiotech.com
    Browser.Fill text    css=#em    ${email}
    RETURN   ${email}

Fill password
    # ${upper}=    Generate Random String    1    [UPPER]
    # ${lower}=    Generate Random String    1    [LOWER]
    # ${other}=    Generate Random String    6    [LETTERS][NUMBERS]

    # ${password}=    Set Variable    ${upper}${lower}${other}
    Browser.Fill text    css=#pw    ${password}

Fill confirm password
    Browser.Fill text    css=#confirm    ${password}

Click Create Account Button
    Browser.Wait For Elements State  css=#btn-signup  visible  timeout=15s

    Browser.Wait For Elements State  css=#btn-signup  enabled  timeout=15s

    Browser.Click    css=#btn-signup

Verify login
    [Arguments]  ${email}
    Close Popup
    Browser.Get Element States    css=[id^="btn-account"] >> text=${email}

Click Profile 
    Close Popup
    Browser.Click    css=[id^="btn-account"]
    Browser.Click    css=[href="/profile"]  

Upload image
    Close Popup
    Browser.Upload File By Selector    css=[type="file"]    /Users/doppio/Downloads/IMG_8932.JPG  # ใช้ได้เฉพาะ tag อะไร เพราะอะไรตัวอิื่นใช้ได้
    Browser.Wait For Load State    state=load    timeout=15s

Verify Upload Success
    Browser.Wait For Elements State    text=Photo updated!    visible    timeout=15s

Click Logo
    Browser.Click    css=[href="/"]  

Input email 
    [Arguments]    ${email}
    Close Popup
    Browser.Fill text    css=#subscribe-email    ${email}

Click subscribe 
    Browser.Click    css=#subscribe-btn

Verify subscribe Success
    [Arguments]    ${email}
    Browser.Wait For Elements State   css=.thanks    visible    timeout=15s
    ${response}=    Browser.Get Text    css=.thanks
    Should Be Equal As Strings    ${response}    🎉 Thanks! We'll send deals to ${email}

Select product 
    [Arguments]    ${product}=Sunglasses
    Browser.Wait For Load State    state=load    timeout=15s
    # Browser.Wait For Elements State   css=[id^="product-card"]:nth-child(1)    visible    timeout=15s
    Browser.Click    css=[aria-label="home-featured-viewall"]

    Browser.Scroll To Element   text=${product}

    Browser.Click    text=${product}

    # Browser.Click    css=[id^="product-card"]:nth-child(1)

Select Product Options
    Close Popup


    [Arguments]    ${color}=FIRST    ${size}=FIRST

    Close Popup

    ${has_color}=    Browser.Get Element Count    css=label:has-text("Color")
    IF    ${has_color} > 0
        IF    '${color}' == 'FIRST'
            Browser.Click    css=label:has-text("Color") + div [aria-label="productdetail-button"]:nth-child(1)
        ELSE
            Browser.Click    text=${color}
        END
    END

    ${has_size}=    Browser.Get Element Count    css=label:has-text("Size")
    IF    ${has_size} > 0
        IF    '${size}' == 'FIRST'
            Browser.Click    css=label:has-text("Size") + div [aria-label="productdetail-button"]:nth-child(1)
        ELSE
            Browser.Click    text=${size}
        END
    END

More quantity
    Browser.Wait For Load State    state=load    timeout=15s
    [Arguments]    ${qty}=5

    FOR    ${i}    IN RANGE    1    ${qty}
        Browser.Click    css=[id^="btn-qty-inc"]
    END

Get Price
    Browser.Wait For Load State    state=load    timeout=15s

    ${subtotal}=    Browser.Get Text    css=span:has-text("Subtotal") + span
    ${subtotal}=    Replace String      ${subtotal}    ,    ${EMPTY}
    ${subtotal}=    Replace String      ${subtotal}    THB    ${EMPTY}
    ${subtotal}=    Convert To Number   ${subtotal}

    ${vat}=    Browser.Get Text    css=span:has-text("VAT (7%)") + span
    ${vat}=    Replace String      ${vat}    ,    ${EMPTY}
    ${vat}=    Replace String      ${vat}    THB    ${EMPTY}
    ${vat}=    Convert To Number  ${vat}

    ${total}=    Browser.Get Text    css=span:has-text("Total (incl. VAT)") + span
    ${total}=    Replace String      ${total}    ,    ${EMPTY}
    ${total}=    Replace String      ${total}    THB    ${EMPTY}
    ${total_1}=    Convert To Number  ${total}

    Log To Console    Subtotal=${subtotal}
    Log To Console    VAT=${vat}
    Log To Console    Total=${total_1}

    RETURN    ${total_1}   #  การบ้าน  return list or scalar

Click Add to Cart
    Browser.Wait For Load State    state=load    timeout=15s
    Browser.Click    css=button:has-text("Add to cart")
    Browser.Wait For Load State    state=load    timeout=15s

Check quantity in cart
    Browser.Wait For Elements State   css=[id^="btn-cart"] >> text=5   visible   timeout=15s

Click cart
    Browser.Click    css=[href="/cart"]  

Click select all
    Close Popup
    Browser.Wait For Load State    state=networkidle    timeout=15s

    Browser.Click    text=Select all
    Browser.Wait For Load State    state=load    timeout=15s


Select Coupon
    Browser.Click    css=button:has-text("Coupon")

    Browser.Wait For Load State    state=load    timeout=15s

    Browser.Click       css=button:has-text("Apply")

    Browser.Wait For Load State    state=networkidle    timeout=15s



Compare
    [Arguments]    ${total_discount}

    ${total_final}=    Browser.Get Text    css=span:has-text("Total") + span >> nth=1
    ${total_final}=    Replace String    ${total_final}    ,    ${EMPTY}
    ${total_final}=    Replace String    ${total_final}    THB    ${EMPTY}
    ${total_final}=    Convert To Number    ${total_final}

    ${expected}=    Evaluate    ${total_discount}

    Builtin.Should Be Equal As Numbers    first=${total_final}    second=${expected}
    Browser.Log to console   ${total_final} is equal to ${expected}

*** Test Cases ***
Open Browser
    Open Browser
    Click Icon Profile
    Click Sign In
    Click Create Account on signin
    Click Create Account
    Fill full name
    Fill phone
    ${email}  Fill email
    Fill password
    Fill confirm password
    Click Create Account Button
    Verify login  ${email}
    Click Profile 
    Upload image
    Verify Upload success
    Click Logo
    Input email    ${email}
    Click subscribe 
    Verify subscribe Success    ${email}
    Select product  
    Select Product Options
    More quantity
    ${total_1}   Get Price
    Click Add to Cart
    Check quantity in cart
    Click cart
    Click select all
    Select coupon
    Compare  ${total_1}

