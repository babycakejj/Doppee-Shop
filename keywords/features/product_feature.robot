*** Keywords ***
Configure products details
    [Arguments]    ${color}=FIRST    ${size}=FIRST    ${product_quantity}=5
    product_detail_page.Select product color    color=${color}
    product_detail_page.Select product size    size=${size}
    product_detail_page.Click increase quantity    product_quantity=${product_quantity}

Get products value
    ${subtotal}    product_detail_page.Get product subtotal value
    ${vat}    product_detail_page.Get product vat value
    ${total}    product_detail_page.Get product total value

    RETURN   ${subtotal}   ${total}   ${vat}