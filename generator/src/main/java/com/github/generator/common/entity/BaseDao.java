package com.github.generator.common.entity;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * DAO支持类实现
 *
 * @param <T>
 * @author ThinkGem
 * @version 2014-05-16
 */
public interface BaseDao<T> {

    /**
     * 获取单条数据
     *
     * @param id    主键 id
     * @return
     */
    T get(@Param("id") String id);

    /**
     * 根据实体查询记录数
     * @param entity   条件查询实体
     * @return
     */
    int count(T entity);

    /**
     * 获取多条数据
     *
     * @param entity    条件查询实体
     * @return
     */
    List<T> list(T entity);

    /**
     * 查询数据列表，分页
     *
     * @param page      条件查询分页实体
     * @return
     */
    List<T> listPage(Page page);

    /**
     * 查询所有数据列表
     *
     * @param entity    条件查询实体
     * @return
     */
    List<T> listAll(T entity);

    /**
     * 插入数据
     *
     * @param entity    实体信息
     * @return
     */
    int save(T entity);

    /**
     * 更新数据为空字段不更新
     *
     * @param entity    实体信息
     * @return
     */
    int update(T entity);

    /**
     * 根据实体全部更新数据
     *
     * @param entity    实体信息
     * @return
     */
    int updateAll(T entity);

    /**
     * 删除数据（物理删除 logic:false）
     *
     * @param id        主键 id
     * @param logic     是否逻辑删除 true：逻辑删除，false：物理删除
     * @return
     */
    int delete(@Param("id") String id, @Param("logic") Boolean logic);

}