*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Variables         ${CURDIR}/../resources/testdata/sit/e2e_001.yaml

*** Test Cases ***
e2e_001 - ทดสอบแบบ End-to-End 
    [Documentation]    Author : Kornnisa
    [Tags]    test_id:e2e_001
    # Precondition : เปิด url
    common.Open website
    # step 1
    # กด Profile บน Navigatebar 
    navigatebar_page.Click icon profile
    # เลือกเมนู Sign in 
    navigatebar_page.Click menu sign in
    # เลือก Create account
    signin_page.Click create account on signin page
    # step 2 กดปุ่ม Create account
    signup_page.Click create account button
    # step 3 สร้างบัญชีให้สำเร็จ และตรวจสอบว่ามีการเข้าสู่ระบบโดยอัติโนมัติ ด้วย email ที่เพิ่งทำการสร้างบัญชี
    ${email}    signup_feature.Create account  email=RANDOM  fullname=${e2e_001.signup_page.default_full_name}  phone_number=${e2e_001.signup_page.default_phone}  password=${e2e_001.signup_page.default_password}    confirm_password=${e2e_001.signup_page.default_confirm_password_pass}
    navigatebar_page.Verify login success after create account    email=${email}
    # step 4 กด Profile บน Navigatebar 
    navigatebar_page.Click icon profile
    # step 5 เลือกเมนู Profile 
    navigatebar_page.Click menu profile
    # step 6 ทำการอัพโหลดรูป และตรวจสอบว่าการอัพโหลดสำเร็จ 
    profile_page.Upload image  
    profile_page.Verify upload image is success
    # step 7 กลับไปยัง home page 
    navigatebar_page.Click logo doppee shop
    # step 8 กรอก email ในช่อง Get Exclusive Deals
    home_page.Fill email to subscribe    email=${email}
    # step 9 กดปุ่ม Subscribe และตรวจสอบว่ามีข้อความขอบคุณที่มี email ที่กรอกไป
    home_page.Click subscribe button
    home_page.Verify subscribe is success    email=${email}   
    # step 10 ไปยังหน้า product list และทำการเลือกสินค้า
    home_page.CLick to view all products 
    product_page.Select product by name    product_name=${e2e_001.product_page.product_name}  
    # step 11 เลือกรายละเอียดสินค้า ให้ครบถ้วน ได้แก่ ขนาด สี และจำนวน
    product_feature.Configure products details    color=${e2e_001.product_detail_page.product_color}      size=${e2e_001.product_detail_page.product_size}    product_quantity=${e2e_001.product_detail_page.quantity_number}
    # step 12 ดึงข้อมูล subtotal, vat, total และกดปุ่ม Add to cart แล้วตรวจสอบว่ามีสินค้าในตะกร้าตามจำนวนที่เพิ่ม
    ${subtotal}   ${total}   ${vat}    product_feature.Get products value
    product_detail_page.Click Add to Cart
    navigatebar_page.Verify quantity in cart badge is displayed as expected    product_quantity=${e2e_001.product_detail_page.quantity_number}
    # step 13 กด Cart บน Navigatebar 
    navigatebar_page.Click icon cart
    # step 14 เลือก Select เพื่อเลือกสินค้้าทั้งหมดในตะกร้า
    cart_page.Click select all products
    # step 15 กด Dropdown คูปอง และเลือกคูปองที่ต้องการใช้
    ${coupon}    coupon_feature.Apply coupon  coupon=${e2e_001.cart_page.coupon}
    # step 16 กดปุ่ม Apply และทำการคำนวณข้อมูล จาก step 12 และดึง total จากหน้า Your cart มาเปรียบเทียบกัน
    cart_page.Click apply coupon button
    ${type}    ${discount_value}    cart_page.Get coupon discount    coupon=${e2e_001.cart_page.coupon}
    ${shipping_fee}    cart_page.Calculate shipping fee    subtotal=${subtotal}
    ${discount_amount}    cart_page.Calculate discount     type=${type}    value=${discount_value}    subtotal=${subtotal}
    ${total_calculate}    cart_page.Calculate total after discount    subtotal=${subtotal}    vat=${vat}    shipping=${shipping_fee}    discount=${discount_amount}
    ${total_web}    cart_page.Get total from web display
    cart_page.Compare total from calculate and web    total_calculate=${total_calculate}    total_web=${total_web}