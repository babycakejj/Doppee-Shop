*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Variables         ${CURDIR}/../resources/testdata/sit/signup_001.yaml
Suite Teardown    Browser.Close Browser

*** Test Cases ***
signup_001 - สร้างบัญชีสำเร็จ เมื่อใส่ข้อมูลถูกต้องทั้งหมด
    [Documentation]    Author : Kornnisa
    [Tags]    test_id:signup_001
    common.Open website
    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    common.Handle random popup
    signin_page.Click create account on signin page
    signup_page.Click create account button
    ${email}    signup_feature.Create account  email=RANDOM  fullname=${signup_001.signup_page.default_full_name}  phone_number=${signup_001.signup_page.default_phone}  password=${signup_001.signup_page.default_password}    confirm_password=${signup_001.signup_page.default_confirm_password_pass}
    navigatebar_page.Verify login success after create account    email=${email}