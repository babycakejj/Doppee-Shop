*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Variables         ${CURDIR}/../resources/testdata/sit/login_002.yaml

*** Test Cases ***
login_002 - เข้าสู่ระบบด้วยบัญชีที่ไม่ถูกต้อง
    [Documentation]    Author : Kornnisa
    [Tags]    test_id:login_002
    common.Open website
    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    common.Handle random popup
    signin_feature.Sign in to doppee shop  email=${login_002.signin_page.correct_email}  password=${login_002.signin_page.wrong_password}
    signin_page.Verify signin unsuccess when password not correct