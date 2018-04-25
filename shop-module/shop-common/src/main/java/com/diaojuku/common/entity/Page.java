package com.diaojuku.common.entity;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页类
 *
 * @author liuyuhu
 * @date  2018/04/23
 */
@Data
@Accessors(chain = true)
public class Page<T> {
    /**
     * 当前页码
     */
    private int pageNo = 1;
    /**
     * 页面大小
     */
    private int pageSize = 10;
    /**
     * 总记录数
     */
    private long count;
    /**
     * 查询对象
     */
    private T condition;
    /**
     * 排序信息
     */
    private String orderBy;
    /**
     * 结果集
     */
    private List result = new ArrayList();

    public Page(){}

    public Page(T condition) {
        this.condition = condition;
    }

    public Page(T condition, String orderBy) {
        this(condition);
        this.orderBy = orderBy;
    }

}
