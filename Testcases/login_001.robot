*** Settings ***
Resource         ${CURDIR}/../resources/import.robot
Variables         ${CURDIR}/../resources/testdata/sit/login_001.yaml

*** Test Cases ***
login_001 - เข้าสู่ระบบด้วยบัญชีที่ถูกต้อง
    [Documentation]    Author : Kornnisa
    [Tags]    test_id:login_001
    common.Open website
    common.Handle random popup
    navigatebar_page.Click icon profile
    navigatebar_page.Click menu sign in
    common.Handle random popup
    signin_feature.Sign in to doppee shop  email=${login_001.signin_page.correct_email}  password=${login_001.signin_page.correct_password}
    common.Handle random popup
    navigatebar_page.Verify login success after create account    email=${login_001.signin_page.correct_email}