package com.xula;

import com.xula.config.RedisProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;


/**
 * 启用类
 * @author xla
 */
@EnableConfigurationProperties(value = RedisProperties.class)
@SpringBootApplication(scanBasePackages="com.xula.**")
//@EnableScheduling
public class DreamAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(DreamAdminApplication.class, args);
    }
}
