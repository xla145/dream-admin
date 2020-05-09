package com.xula.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @email: xuliandream@gmail.com
 * @author: xula
 * @date: 2020/5/8
 * @time: 18:46
 */
@Data
@ConfigurationProperties(prefix = "spring.redis")
public class RedisProperties {

    private String prefix;
}
