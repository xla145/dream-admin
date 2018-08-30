package com.xula.controller;

import com.xula.base.helper.CustomBigDecimalEditor;
import com.xula.base.helper.SpecialDateEditor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;

/**
 * base Controller
 *
 * @author xla
 */
@Controller
public class BaseController {


    @Value("${online.domain}")
    private String domain;

    /**
     * 处理绑定对象参数中dete 转换问题
     *
     * @param dataBinder
     */
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        dataBinder.registerCustomEditor(Date.class, new SpecialDateEditor());
        dataBinder.registerCustomEditor(BigDecimal.class, new CustomBigDecimalEditor());
    }

    /**
     * 上下文环境地址
     *
     * @param request
     * @return
     */
    public static String contextPath(HttpServletRequest request) {
        return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
    }

    /**
     * @author cy
     * @description 得到项目的根目录的绝对路径
     */
    public static String getPath(HttpServletRequest request){
        String path = request.getServletContext().getRealPath("/");
        path = path.replaceAll("\\\\", "/");
        return path;
    }

    /**
     * 返回消息页面
     *
     * @param msg 消息内容
     */
    public String renderTips(Model model, String msg) {
        model.addAttribute("msg", msg);
        return "common/notice";
    }

    public void setDomain(Model model) {
        model.addAttribute("domain", domain);
    }


}
