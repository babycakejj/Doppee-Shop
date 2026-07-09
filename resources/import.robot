*** Settings ***
Library           Browser
Library           String

# setting
Variables         ${CURDIR}/./settings/${env}/setting.yaml

# testdata
Variables         ${CURDIR}/./testdata/${env}/testdata.yaml

# translation
Variables         ${CURDIR}/./translation/${lang}.yaml

# keywords
Resource         ${CURDIR}/../keywords/common/common.robot
Resource         ${CURDIR}/../keywords/pages/navigatebar_page.robot
Resource         ${CURDIR}/../keywords/pages/signin_page.robot
Resource         ${CURDIR}/../keywords/pages/signup_page.robot
Resource         ${CURDIR}/../keywords/pages/profile_page.robot
Resource         ${CURDIR}/../keywords/pages/home_page.robot
Resource         ${CURDIR}/../keywords/pages/product_page.robot
Resource         ${CURDIR}/../keywords/pages/product_detail_page.robot
Resource         ${CURDIR}/../keywords/pages/cart_page.robot

# features
Resource         ${CURDIR}/../keywords/features/signup_feature.robot
Resource         ${CURDIR}/../keywords/features/product_feature.robot
Resource         ${CURDIR}/../keywords/features/coupon_feature.robot
Resource         ${CURDIR}/../keywords/features/signin_feature.robot

# locators
Resource         ${CURDIR}/./locators/navigatebar_locator.robot
Resource         ${CURDIR}/./locators/common_locator.robot
Resource         ${CURDIR}/./locators/signin_locator.robot
Resource         ${CURDIR}/./locators/signup_locator.robot
Resource         ${CURDIR}/./locators/profile_locator.robot
Resource         ${CURDIR}/./locators/home_locator.robot
Resource         ${CURDIR}/./locators/product_page_locator.robot
Resource         ${CURDIR}/./locators/product_detail_locator.robot
Resource         ${CURDIR}/./locators/cart_locator.robot