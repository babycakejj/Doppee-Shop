*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Suite Teardown    Browser.Close Browser

*** Test Cases ***
TC001 - ไม่รวม feature
    [Documentation]    Author : Kornnisa

    common.Open website
    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    signin_page.Click create account on signin page
    signup_page.Click create account button
    signup_page.Fill full name    
    ${email}    signup_page.Fill email  email
    signup_page.Fill phone number  
    signup_page.Fill email  
    signup_page.Fill password  
    signup_page.Fill confirm password  
    signup_page.Click for create account
    navigatebar_page.Verify login success after create account    email=${email}
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu profile
    profile_page.Upload image  
    profile_page.Verify upload image is success
    navigatebar_page.Click logo doppee shop
    home_page.Fill email to subscribe    email=${email}
    home_page.Click subscribe button
    home_page.Verify subscribe is success    email=${email}   
    home_page.CLick to view all products   
    product_page.Select product by name  
    product_detail_page.Select product color    color    
    product_detail_page.Select product size    size    
    product_detail_page.Click increase quantity    product_quantity
    ${subtotal}    product_detail_page.Get product subtotal value
    ${vat}    product_detail_page.Get product vat value
    ${total}    product_detail_page.Get product total value
    product_detail_page.Click Add to Cart
    navigatebar_page.Verify quantity in cart badge is displayed as expected    product_quantity
    navigatebar_page.Click icon cart
    cart_page.Click select all products
    cart_page.Click dropdown coupon
    ${coupon}    cart_page.Select coupon    coupon=${coupon}  
    cart_page.Click apply coupon button
    ${type}    ${discount_value}    cart_page.Get coupon   discount  coupon${coupon}
    ${shipping_fee}    cart_page.Calculate shipping fee    subtotal=${subtotal}
    ${discount_amount}    cart_page.Calculate discount     type=${type}    value=${discount_value}  
    ${total_calculate}    cart_page.Calculate total after discount    subtotal=${subtotal}    vat=${vat}    shipping=${shipping_fee}    discount=${discount_amount}
    ${total_web}    cart_page.Get total from web display
    cart_page.Compare total from calculate and web    total_calculate=${total_calculate}    total_web=${total_web}