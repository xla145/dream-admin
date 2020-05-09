
package com.xula.shiro.realm;

import com.xula.base.constant.BaseConstant;
import com.xula.entity.SysAction;
import com.xula.event.EventModel;
import com.xula.event.LoginEvent;
import com.xula.service.auth.IAuthService;
import com.xula.service.sys.sysuser.ISysUserService;
import com.xula.utils.ReqUtils;
import com.xula.utils.ShiroUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @author xla
 * 验证功能
 */
public class UserRealm extends AuthorizingRealm {


    @Autowired
    private ISysUserService sysUserService;
    @Autowired
    private IAuthService iAuthService;
    @Autowired
    private ApplicationContext applicationContext;

    private Logger logger = LoggerFactory.getLogger(UserRealm.class);

    /**
     * 授权(验证权限时调用)
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SysAction.SysUser user = (SysAction.SysUser) principalCollection.getPrimaryPrincipal();
        Integer userId = user.getUid();

        List<String> permsList;
        List<SysAction> menuList;
        //系统管理员，拥有最高权限
        if (userId == 1) {
            menuList = iAuthService.getSysUserAction(1);
        } else {
            menuList = iAuthService.getSysUserAction(userId);
        }
        permsList = new ArrayList<>(menuList.size());
        for (SysAction menu : menuList) {
            permsList.add(menu.getPerms());
        }
        //用户权限列表
        Set<String> permsSet = new HashSet<>();
        for (String perms : permsList) {
            if (StringUtils.isBlank(perms)) {
                continue;
            }
            permsSet.addAll(Arrays.asList(perms.trim().split(",")));
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(permsSet);
        return info;
    }

    /**
     * 由于项目初始化的时候就创建了这个类，所以不能使用
     * @Autowired
     * private HttpServletRequest request;
     * 只能通过 RequestContextHolder 获取到的ServletRequestAttributes，通过ServletRequestAttributes获取到HttpServletRequest
     * 原因是因为每次请求，会在ServletRequestAttributes中存储当前线程HttpServletRequest对象，存储在ThreadLocal中
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = servletRequestAttributes.getRequest();
        String username = (String) authenticationToken.getPrincipal();
        String password = new String((char[]) authenticationToken.getCredentials());
        //查询用户信息
        SysAction.SysUser sysUser = sysUserService.getSysUser(username);
        if (BaseConstant.isDev) {//开发环境不用登录
            sysUser = sysUserService.getSysUser("admin");
            return new SimpleAuthenticationInfo(sysUser, password, getName());
        }
        //账号不存在
        if (sysUser == null) {
            throw new UnknownAccountException("账号或密码不正确");
        }

        //密码错误
        if (!password.equals(sysUser.getPswd())) {
            throw new IncorrectCredentialsException("账号或密码不正确");
        }

        //账号锁定
        if (sysUser.getIsValid() == 0) {
            throw new LockedAccountException("账号已被锁定,请联系管理员");
        }

        int uid = sysUser.getUid();
        int cid = -1;
        int userType = sysUser.getType();
        String ip = ReqUtils.getIp(request);
        ShiroUtils.setSessionAttribute("ip", ip);
        String userAgent = request.getHeader("user-agent");
        String referer = request.getHeader("Referer");

        logger.info("用户登录成功,userType：" + userType + ",cid:" + cid + ",uid:" + uid + ",username:" + sysUser.getName() + ",ip:" + ip + ",userAgent:" + userAgent);

        EventModel eventModel = new EventModel();
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("referer", referer);
        param.put("userAgent", userAgent);
        param.put("ip", ip);
        param.put("lastLoginTime", new Date());
        eventModel.setParam(param);
        eventModel.setSysUser(sysUser);
        applicationContext.publishEvent(new LoginEvent(eventModel));  //发布登录事件
        return new SimpleAuthenticationInfo(sysUser, password, getName());
    }

    /**
     * 清除缓存
     */
    public void doClearCache() {
        super.doClearCache(ShiroUtils.getSubject().getPrincipals());
    }
}
