*** Keywords ***
Open website
    [Documentation]
    ...    เปิด Browser Chromium แบบ headless=false
    ...    สร้าง Browser Context พร้อมเปิด Tracing
    ...    เปิดหน้าเว็บ Doppee Shop ตามค่า ${BASE_URL}
    Browser.New browser    browser=chromium    headless=false    timeout=${TIMEOUT}  
    Browser.New context    tracing=true    
    Browser.New page    url=${BASE_URL} 

Handle random popup
    [Documentation]    
    ...     ปิด Popup แบบสุ่มที่จะปรากฎบนหน้าจอ
    ${popup_visible}    Run keyword and return status    Browser.Wait for elements state    selector=${common_locator.btn_close}    state=visible    timeout=500ms
    IF    ${popup_visible}  
        Browser.Click    selector=${common_locator.btn_close}
    END
    