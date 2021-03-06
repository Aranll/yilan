package com.xiaosuokeji.yilan.admin.security.core;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

import javax.servlet.*;
import java.io.IOException;

/**
 * Created by xuxiaowei on 2017/5/22.
 */
public class SecurityInterceptorFilter extends AbstractSecurityInterceptor implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(SecurityInterceptorFilter.class);

	private FilterInvocationSecurityMetadataSource securityMetadataSource;
	
	public void destroy() {}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		FilterInvocation fi = new FilterInvocation(request, response, chain); 
        invoke(fi);
	}

	public void init(FilterConfig arg0) throws ServletException {}

	@Override
	public Class<?> getSecureObjectClass() {
		return FilterInvocation.class;
	}

	@Override
	public SecurityMetadataSource obtainSecurityMetadataSource() {
		return this.securityMetadataSource;
	} 
    
	public void invoke(FilterInvocation fi) throws IOException, ServletException { 
	    InterceptorStatusToken token = super.beforeInvocation(fi); 
        try { 
        	fi.getChain().doFilter(fi.getRequest(), fi.getResponse()); 
        } catch(Exception e){
        	logger.error("error : ", e);
        } finally { 
        	super.afterInvocation(token, null); 
        } 
	}

	public void setSecurityMetadataSource(FilterInvocationSecurityMetadataSource securityMetadataSource) {
		this.securityMetadataSource = securityMetadataSource;
	}
}
