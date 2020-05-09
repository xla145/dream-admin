package com.xula.base.helper;

import org.apache.commons.lang.StringUtils;

import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;

/**
 * 类说明: BigDecimal custom property editor
 * @author xula
 */  
public class CustomBigDecimalEditor extends PropertyEditorSupport {

    @Override
    public void setAsText(String text) throws IllegalArgumentException {  
        if (StringUtils.isEmpty(text)) {
            // Treat empty String as null value.  
            setValue(null);  
        } else {  
            setValue(new BigDecimal(text).setScale(2, BigDecimal.ROUND_HALF_UP));
        }  
    }  
}  