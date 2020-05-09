package com.xula.config;

import cn.hutool.json.JSONUtil;
import com.xula.base.exception.ShiroConfigException;
import com.xula.base.util.IniUtil;
import com.xula.shiro.realm.UserRealm;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.mgt.SessionsSecurityManager;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: shiro配置
 * @author: xula
 * @create: 2018-01-30 10:39
 **/
@Configuration
@EnableConfigurationProperties({
        ShiroProperties.class
})
@Slf4j
public class ShiroConfig {

    @Bean
    public UserRealm userRealm(){
        UserRealm userRealm = new UserRealm();
        userRealm.setName("authorizationCache");
        return userRealm;
    }

    @Bean
    public SimpleCookie simpleCookie() {
        SimpleCookie simpleCookie = new SimpleCookie("dream-manage.session");
        simpleCookie.setPath("/");
        return simpleCookie;
    }

    @Bean
    public SessionDAO sessionDAO() {
        return new EnterpriseCacheSessionDAO();
    }

    @Bean
    public SessionManager sessionManager(@Qualifier("sessionDAO") SessionDAO sessionDAO,SimpleCookie simpleCookie){
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        sessionManager.setGlobalSessionTimeout(1800000);
        sessionManager.setSessionIdCookie(simpleCookie);
        sessionManager.setSessionValidationSchedulerEnabled(true);
        sessionManager.setSessionIdUrlRewritingEnabled(false);
        sessionManager.setSessionDAO(sessionDAO);
        sessionManager.setSessionIdCookieEnabled(true);
        return sessionManager;
    }

    @Bean
    public EhCacheManager shiroEhcacheManager() {
        EhCacheManager ehCacheManager = new EhCacheManager();
        ehCacheManager.setCacheManagerConfigFile("classpath:ehcache-shiro.xml");
        return ehCacheManager;
    }


    @Bean
    public SessionsSecurityManager securityManager(EhCacheManager shiroEhcacheManager,@Qualifier("userRealm") UserRealm userRealm, @Qualifier("sessionManager") SessionManager sessionManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(userRealm);
        securityManager.setCacheManager(shiroEhcacheManager);
        securityManager.setSessionManager(sessionManager);
        return securityManager;
    }

    @Bean
    public ShiroFilterFactoryBean shirFilter(@Qualifier("securityManager") SecurityManager securityManager,ShiroProperties shiroProperties) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        shiroFilter.setSecurityManager(securityManager);
        shiroFilter.setLoginUrl(shiroProperties.getLoginUrl());
        shiroFilter.setSuccessUrl(shiroProperties.getSuccessUrl());
        shiroFilter.setUnauthorizedUrl(shiroProperties.getUnauthorizedUrl());
        shiroFilter.setFilterChainDefinitionMap(getFilterChainDefinitionMap(shiroProperties));
        return shiroFilter;
    }

    /**
     * Shiro路径权限配置
     *
     * @return
     */
    private Map<String, String> getFilterChainDefinitionMap(ShiroProperties shiroProperties) throws ShiroConfigException {
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap();
        // 获取ini格式配置
        String definitions = shiroProperties.getFilterChainDefinitions();
        if (StringUtils.isNotBlank(definitions)) {
            Map<String, String> section = IniUtil.parseIni(definitions);
            log.debug("definitions:{}", JSONUtil.toJsonStr(section));
            for (Map.Entry<String, String> entry : section.entrySet()) {
                filterChainDefinitionMap.put(entry.getKey(), entry.getValue());
            }
        }

        // 获取自定义权限路径配置集合
        List<ShiroPermissionProperties> permissionConfigs = shiroProperties.getPermission();
        log.debug("permissionConfigs:{}", JSONUtil.toJsonStr(permissionConfigs));
        if (CollectionUtils.isNotEmpty(permissionConfigs)) {
            for (ShiroPermissionProperties permissionConfig : permissionConfigs) {
                String url = permissionConfig.getUrl();
                String[] urls = permissionConfig.getUrls();
                String permission = permissionConfig.getPermission();
                if (StringUtils.isBlank(url) && ArrayUtils.isEmpty(urls)) {
                    throw new ShiroConfigException("shiro permission config 路径配置不能为空");
                }
                if (StringUtils.isBlank(permission)) {
                    throw new ShiroConfigException("shiro permission config permission不能为空");
                }

                if (StringUtils.isNotBlank(url)) {
                    filterChainDefinitionMap.put(url, permission);
                }
                if (ArrayUtils.isNotEmpty(urls)) {
                    for (String string : urls) {
                        filterChainDefinitionMap.put(string, permission);
                    }
                }
            }
        }

        log.debug("filterChainMap:{}", JSONUtil.toJsonStr(filterChainDefinitionMap));

        // 如果启用shiro，则设置最后一个设置为authc，否则全部路径放行
        if (shiroProperties.isEnable()) {
            filterChainDefinitionMap.put("/**", "authc");
        } else {
            filterChainDefinitionMap.put("/**", "anon");
        }

        return filterChainDefinitionMap;
    }


    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator proxyCreator = new DefaultAdvisorAutoProxyCreator();
        proxyCreator.setProxyTargetClass(true);
        return proxyCreator;
    }

    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager);
        return advisor;
    }



}
