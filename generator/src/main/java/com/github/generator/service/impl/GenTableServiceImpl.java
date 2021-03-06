package com.github.generator.service.impl;

import com.github.generator.common.entity.BaseServiceImpl;
import com.github.generator.common.entity.Page;
import com.github.generator.common.utils.IDUtils;
import com.github.generator.common.utils.MyStringUtils;
import com.github.generator.dao.GenDataBaseDictDao;
import com.github.generator.dao.GenTableColumnDao;
import com.github.generator.dao.GenTableDao;
import com.github.generator.entity.GenTable;
import com.github.generator.entity.GenTableColumn;
import com.github.generator.service.GenTableService;
import com.github.generator.util.GenUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * 业务表Service
 *
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
public class GenTableServiceImpl extends BaseServiceImpl<GenTableDao, GenTable> implements GenTableService {

    @Autowired
    private GenTableDao genTableDao;
    @Autowired
    private GenTableColumnDao genTableColumnDao;
    @Autowired
    private GenDataBaseDictDao genDataBaseDictDao;

    @Override
    public GenTable getById(String id) {
        GenTable genTable = genTableDao.get(id);
        GenTableColumn genTableColumn = new GenTableColumn();
        genTableColumn.setGenTableId(id);
        List<GenTableColumn> columnList = genTableColumnDao.list(genTableColumn);
        columnList.sort(Comparator.comparingInt(o -> Integer.parseInt(o.getSort())));
        genTable.setColumnList(columnList);
        return genTable;
    }

    @Override
    public Page<GenTable> find(Page<GenTable> page, GenTable genTable) {
        page.setPageNo(0);
        page.setResult(genTableDao.listPage(page.setCondition(genTable)));
        return page;
    }

    /**
     * 获取物理数据表列表
     *
     * @param genTable
     * @return
     */
    @Override
    public List<GenTable> findTableListFormDb(GenTable genTable) {
        return genDataBaseDictDao.findTableList(genTable);
    }

    /**
     * 验证表名是否可用，如果已存在，则返回false
     *
     * @param tableName
     * @return
     */
    @Override
    public boolean checkTableName(String tableName) {
        if (StringUtils.isBlank(tableName)) {
            return true;
        }
        GenTable genTable = new GenTable();
        genTable.setName(tableName);
        List<GenTable> list = genTableDao.list(genTable);
        return list.size() == 0;
    }

    /**
     * 获取物理数据表列表
     *
     * @param genTable
     * @return
     */
    @Override
    public GenTable getTableFormDb(GenTable genTable) {
        // 如果有表名，则获取物理表
        if (StringUtils.isNotBlank(genTable.getName())) {

            List<GenTable> list = genDataBaseDictDao.findTableList(genTable);
            if (list.size() > 0) {

                // 如果是新增，初始化表属性
                if (StringUtils.isBlank(genTable.getId())) {
                    genTable = list.get(0);
                    // 设置字段说明
                    if (StringUtils.isBlank(genTable.getComments())) {
                        genTable.setComments(genTable.getName());
                    }
                    genTable.setClassName(MyStringUtils.toCapitalizeCamelCase(genTable.getName()));
                }

                // 添加新列
                List<GenTableColumn> columnList = genDataBaseDictDao.findTableColumnList(genTable);
                for (GenTableColumn column : columnList) {
                    boolean b = false;
                    for (GenTableColumn e : genTable.getColumnList()) {
                        if (e.getName().equals(column.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        genTable.getColumnList().add(column);
                    }
                }

                // 删除已删除的列
                for (GenTableColumn e : genTable.getColumnList()) {
                    boolean b = false;
                    for (GenTableColumn column : columnList) {
                        if (column.getName().equals(e.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        e.setValid(1);
                    }
                }

                // 获取主键
                genTable.setPkList(genDataBaseDictDao.findTablePK(genTable));

                // 初始化列属性字段
                GenUtils.initColumnField(genTable);

            }
        }
        return genTable;
    }

    @Override
    public void saveAndColumn(GenTable genTable) {
        Date date = new Date();
        if (StringUtils.isBlank(genTable.getId())) {
            genTable.setId(IDUtils.UUID());
            genTable.setCreateTime(date);
            genTable.setUpdateTime(date);
            genTableDao.save(genTable);
        } else {
            genTable.setUpdateTime(date);
            genTableDao.update(genTable);
        }
        // 保存列
        for (GenTableColumn column : genTable.getColumnList()) {
            column.setGenTableId(genTable.getId());
            if (StringUtils.isBlank(column.getId())) {
                column.setId(IDUtils.UUID());
                column.setCreateTime(date);
                column.setUpdateTime(date);
                genTableColumnDao.save(column);
            } else {
                column.setUpdateTime(date);
                genTableColumnDao.update(column);
            }
        }
    }

    @Override
    public void deleteColumn(GenTable genTable) {
        genTableDao.delete(genTable.getId(), true);
        genTableColumnDao.deleteByGenTableId(genTable.getId());
    }

}
