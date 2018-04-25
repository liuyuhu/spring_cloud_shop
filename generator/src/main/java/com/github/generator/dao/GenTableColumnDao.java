package com.github.generator.dao;

import com.github.generator.common.entity.BaseDao;
import com.github.generator.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author liuyuhu
 * @version 2018-04-23
 */

public interface GenTableColumnDao extends BaseDao<GenTableColumn> {

    void deleteByGenTableId(String genTableId);

}