package com.xula.utils;

import com.xula.config.RedisProperties;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author xula
 * @date 2019/08/13 9:36
 **/
@Component
public class RedisHandle {

    private static RedisTemplate redisTemplate;

    private static RedisProperties redisProperties;
    /**
     * key 前缀
     */
    private static String prefix;

    public RedisHandle(RedisTemplate redisTemplate, RedisProperties redisProperties) {
        RedisHandle.redisTemplate = redisTemplate;
        RedisHandle.redisProperties = redisProperties;
        RedisHandle.prefix = redisProperties.getPrefix();
    }

    /**
     * key添加命名空间
     * @param key
     * @Author LinYouRu
     * @Date 11:20 2019/6/6
     * @return String
     **/
    private static String keyAndSpace(String key){
        return prefix + key;
    }

    /**
     * 指定缓存失效时间
     * @param key
     * @param time
     * @Author LinYouRu
     * @Date 10:09 2019/4/11
     * @return boolean
     **/
    public static boolean expire(String key,long time) {
        key = keyAndSpace(key);
        if(time > 0){
            return redisTemplate.expire(key, time, TimeUnit.SECONDS);
        }
        return true;
    }


    public static Map<String, Object> getMap(String key) {
        key = keyAndSpace(key);
        return redisTemplate.boundHashOps(key).entries();
    }

    public <T> T getMapField(Class<T> entity, String key, String field) {
        Map<String, Object> map = getMap(key);
        if (map == null) {
            return null;
        }
        Object object = map.get(field);
        if(entity.isInstance(object)){
            return entity.cast(object);
        }
        return null;
    }

    public static boolean hasMapKey(String key, String field) {
        key = keyAndSpace(key);
        return redisTemplate.boundHashOps(key).hasKey(field);
    }


    public static void delMapKey(String key, String... field) {
        key = keyAndSpace(key);
        redisTemplate.boundHashOps(key).delete(field);
    }

    public static void updateOrInsertMapFieldValue(String key, String field, Object value) {
        key = keyAndSpace(key);
        redisTemplate.boundHashOps(key).put(field,value);
    }

    /**
     * 获取列表数据 根据
     * @param key
     * @param s
     * @param e
     * @return
     */
    public static List<Object> getList(String key, long s, long e) {
        key = keyAndSpace(key);
        return redisTemplate.boundListOps(key).range(s,e);
    }

    /**
     * 添加普通数据
     * @param key
     * @param value
     * @param time
     */
    public static void add(String key, Object value, long time) {
        if (time > 0) {
            expire(key,time);
        }
        key = keyAndSpace(key);
        redisTemplate.boundValueOps(key).set(value);
    }


    /**
     * 根据key获取普通数据
     * @param key
     * @return
     */
    public static Object get(String key) {
        key = keyAndSpace(key);
        return redisTemplate.boundValueOps(key).get();
    }


    /**
     * 根据key 删除数据
     * @param keys
     */
    public static void delete(String... keys) {
        List<String> keyList = CollectionUtils.arrayToList(keys);
        List<String> newKeyList = keyList.stream().map(s -> keyAndSpace(s)).collect(Collectors.toList());
        redisTemplate.delete(newKeyList);
    }


    /**
     * 添加列表数据
     * @param key
     * @param value
     * @param time
     */
    public static void addList(String key, Object value, long time) {
        if (time > 0) {
            expire(key,time);
        }
        key = keyAndSpace(key);
        redisTemplate.boundListOps(key).leftPush(value);
    }


    /**
     * 获取列表条数
     * @param key
     */
    public static long getListSize(String key) {
        key = keyAndSpace(key);
        return redisTemplate.boundListOps(key).size();
    }
}
