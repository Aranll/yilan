package com.xiaosuokeji.yilan.admin.controller.picture;

import com.xiaosuokeji.yilan.admin.annotation.Security;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Aranl_lin on 2017/8/10.
 */
@Controller("adminPictureIndexController")
@RequestMapping("/admin/picture")
public class IndexController {

    @Security(pKey = "picture", key = "")
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(HttpServletRequest request) {
        return "/admin/picture/index";
    }
}


