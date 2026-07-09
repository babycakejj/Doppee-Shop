*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Variables         ${CURDIR}/../resources/testdata/sit/add_cart_001.yaml

*** Test Cases ***
add_cart_001 - เลือกสินค้้าที่มีขนาดและสี
    [Documentation]    Author : Kornnisa
    [Tags]    test_id:add_cart_001
    common.Open website
    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    common.Handle random popup
    signin_feature.Sign in to doppee shop  email=${add_cart_001.signin_page.correct_email}  password=${add_cart_001.signin_page.correct_password}
    common.Handle random popup
    navigatebar_page.Verify login success after create account    email=${add_cart_001.signin_page.correct_email}
    navigatebar_page.Click logo doppee shop
    home_page.CLick to view all products 
    product_page.Select product by name  product_name=${add_cart_001.product_page.product_name}
    product_feature.Configure products details  color=${add_cart_001.product_detail_page.product_color}  size=${add_cart_001.product_detail_page.product_size}  product_quantity=${add_cart_001.product_detail_page.quantity_number}
    ${subtotal}   ${total}   ${vat}    product_feature.Get products value
    product_detail_page.Click Add to Cart
    navigatebar_page.Verify quantity in cart badge is displayed as expected  product_quantity=${add_cart_001.product_detail_page.quantity_number}
    navigatebar_page.Click icon cart
    cart_page.Click select all products
    ${coupon}    coupon_feature.Apply coupon  coupon=${add_cart_001.cart_page.coupon}
    ${type}    ${value}    cart_page.Get coupon discount    coupon=${add_cart_001.cart_page.coupon}
    cart_page.Click apply coupon button
    ${shipping_fee}    cart_page.Calculate shipping fee  subtotal=${subtotal}
    ${discount_amount}    cart_page.Calculate discount   type=${type}    value=${value}    subtotal=${subtotal}  
    ${total_calculate}    cart_page.Calculate total after discount  subtotal=${subtotal}    vat=${vat}    shipping=${shipping_fee}    discount=${discount_amount}
    ${total_web}    cart_page.Get total from web display
    cart_page.Compare total from calculate and web    total_calculate=${total_calculate}    total_web=${total_web}