*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Suite Teardown    Browser.Close Browser

*** Test Cases ***
TC003 - เปลี่ยนภาษาของหน้าเว็บ
    [Documentation]    Author : Kornnisa
    common.Open website

    Browser.Click    css=button:has(span:has-text("EN"))
    Browser.Click    css=button:has(span:has-text("TH"))


    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    signin_page.Click create account on signin page
    signup_page.Click create account button
    ${email}    signup_feature.Create account  email=RANDOM  fullname=subasa  phone_number=09996784532  password=Pass1234
    navigatebar_page.Verify login success after create account    email=${email}
    navigatebar_page.Click logo doppee shop
    home_page.CLick to view all products 
    product_page.Select product by name  product_name=Classic Tee
    product_feature.Configure products details  color=White  size=S  product_quantity=10
    ${subtotal}   ${total}   ${vat}    product_feature.Get products value
    product_detail_page.Click Add to Cart
    navigatebar_page.Verify quantity in cart badge is displayed as expected  product_quantity=10
    navigatebar_page.Click icon cart
    cart_page.Click select all products
    ${coupon}    coupon_feature.Apply coupon  coupon=${cart_page.default_coupon}
    ${type}    ${value}    cart_page.Get coupon discount    coupon=FLAT50
    cart_page.Click apply coupon button
    ${shipping_fee}    cart_page.Calculate shipping fee  subtotal=${subtotal}
    ${discount_amount}    cart_page.Calculate discount   type=${type}    value=${value}    subtotal=${subtotal}  
    ${total_calculate}    cart_page.Calculate total after discount  subtotal=${subtotal}    vat=${vat}    shipping=${shipping_fee}    discount=${discount_amount}
    ${total_web}    cart_page.Get total from web display
    cart_page.Compare total from calculate and web    total_calculate=${total_calculate}    total_web=${total_web}