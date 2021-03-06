package com.xiaosuokeji.yilan.admin.security.handler;

import com.xiaosuokeji.yilan.admin.security.constant.SecurityConstant;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by xuxiaowei on 2017/5/22.
 */
@Service("logoutSuccessHandler")
public class LogoutSuccessHandlerImpl implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        String successMsg = "{\"status\":true,\"code\":" + String.valueOf(SecurityConstant.SUCCESS.getCode()) + "}";
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(successMsg);
    }
}
