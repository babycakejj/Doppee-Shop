*** Variables ***
${signin_locator.btn_create_account}      css=iframe[name="login-frame"] >>> [href="/signup"]
${signin_locator.txt_email}      css=iframe.w-full >>> css=#em
${signin_locator.txt_password}      css=iframe.w-full >>> css=#pw
${signin_locator.btn_signin}      css=iframe.w-full >>> css=[id*="btn-signin"]
${signin_locator.lbl_signin_error}      css=iframe.w-full >>> css=#err

