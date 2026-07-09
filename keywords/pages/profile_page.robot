*** Keywords ***
Upload image
    [Documentation]    
    ...     สำหรับการอัพโหลดรูปโปรไฟล์
    ...         - ${img_path} path ของรูปที่อยู่บนเครื่อง

    [Arguments]    ${img_path}=${profile_page.image_path}
    common.Handle random popup
    Browser.Upload file by selector    selector=${profile_locator.img_profile}     path=${img_path} 
    Browser.Wait for load state    state=load     timeout=${TIMEOUT}    

Verify upload image is success
    [Documentation]    
    ...     สำหรับตรวจสอบว่าอัพโหลดรูปภาพสำเร็จแล้ว จากข้อความใน ${profile_locator.lbl_upload_img} ที่ปรากฎบนหน้าจอ
    [Arguments]    ${img_path}=${profile_page.image_path}
    Browser.Wait for elements state    text=${profile_page.verify_photo_updated_text}    state=visible    timeout=${TIMEOUT}   