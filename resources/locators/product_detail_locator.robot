*** Variables ***
${product_detail_locator.lbl_size}      css=label:has-text("Size")  
${product_detail_locator.lbl_color}      css=label:has-text("Color")  
${product_detail_locator.btn_default_color}    css=label:has-text("Color") + div [aria-label="productdetail-button"]:nth-child(1)
${product_detail_locator.btn_default_size}    css=label:has-text("Size") + div [aria-label="productdetail-button"]:nth-child(1)
${product_detail_locator.btn_increase_quantity}    css=[id^="btn-qty-inc"]
${product_detail_locator.btn_add_to_cart}    css=button:has-text("${product_detail_page_translation.add_to_cart}")
${product_detail_locator.btn_color}    css=[aria-label="productdetail-button"]:text-is("color")
${product_detail_locator.btn_size}    css=[aria-label="productdetail-button"]:text-is("size")
${product_detail_locator.lbl_subtotal}      css=span:text-is("${product_detail_page_translation.subtotal}") + span
${product_detail_locator.lbl_vat}      css=span:text-is("${product_detail_page_translation.vat}") + span
${product_detail_locator.lbl_total}      css=span:text-is("${product_detail_page_translation.total}") + span
