package com.xula.utils;

import java.util.List;
import java.util.Map;

/**
 * redis 操作封装
 * @author xula
 * @param <K>
 * @param <V>
 */
public interface RedisCommand<K,V> {

    /*
     * 获取map对象
     * @param key map对应的key
     * @return
     */
    Map<K,V> getMap(K key);

    /**
     * 获取map缓存中的某个对象
     * @param key map对应的key
     * @param field map中该对象的key
     * @return
     */
    <T> T getMapField(Class<T> entity, K key, K field);


    /**
     * 是否存在map-key
     * @param key
     * @param field
     * @return
     */
    boolean hasMapKey(K key, K field);



    /**
     * 删除map中的key
     * @param key
     * @param field
     * @return
     */
    void delMapKey(K key, K... field);


    /**
     * 更新map的值
     * @param key
     * @param field
     * @param value
     */
    void updateOrInsertMapFieldValue(K key, K field, V value);


    /**
     * 获取范围内的数据
     * @param key
     * @param s
     * @param e
     * @return
     */
    List<Object> getList(K key, long s, long e);


    /**
     * 普通类型的数据添加
     * @param key
     * @param value
     * @param time
     */
    void add(K key, V value, long time);



    /**
     * 获取普通类型的数据
     * @param key
     */
    V get(K key);


    /**
     * 删除key
     * @param key
     */
    void delete(K... key);


    /**
     * 添加列表数据
     * @param key
     * @param value
     * @param time
     */
    void addList(K key, V value, long time);


    /**
     * 获取列表条数
     * @param key
     */
    long getListSize(K key);

}
