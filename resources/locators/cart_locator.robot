*** Variables ***
${cart_locator.chk_select_all}      text=Select all
${cart_locator.btn_coupon}      css=button:has-text("${cart_page_translation.coupon}")
${cart_locator.ddl_coupon}      css=button:has(span:has-text("coupon"))
${cart_locator.lbl_coupon}      css=button:has(span:has-text("coupon")) span:last-child
${cart_locator.btn_apply}      css=button:has-text("${cart_page_translation.apply}")
${cart_locator.lbl_total}      css=span:text-is("${cart_page_translation.total}") + span




