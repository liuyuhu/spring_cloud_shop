package com.github.generator.service.impl;

import com.github.generator.common.entity.BaseServiceImpl;
import com.github.generator.common.entity.Page;
import com.github.generator.common.utils.IDUtils;
import com.github.generator.dao.GenSchemeDao;
import com.github.generator.dao.GenTableColumnDao;
import com.github.generator.dao.GenTableDao;
import com.github.generator.entity.*;
import com.github.generator.service.GenSchemeService;
import com.github.generator.util.GenUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

/**
 * 生成方案Service
 *
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
public class GenSchemeServiceImpl extends BaseServiceImpl<GenSchemeDao, GenScheme> implements GenSchemeService {
    @Autowired
    private GenSchemeDao genSchemeDao;
    @Autowired
    private GenTableDao genTableDao;
    @Autowired
    private GenTableColumnDao genTableColumnDao;

    @Override
    public Page<GenScheme> find(Page<GenScheme> page, GenScheme genScheme) {
        GenUtils.getTemplatePath();
        page.setPageNo(0);
        page.setResult(genSchemeDao.listPage(page.setCondition(genScheme)));
        return page;
    }

    @Override
    public String saveOrUpdate(GenScheme genScheme) {
        genScheme.setGenTableId(genScheme.getGenTable().getId());
        GenTable genTable = genTableDao.get(genScheme.getGenTableId());
        genScheme.setTableName(genTable.getClassName());
        if (StringUtils.isBlank(genScheme.getId())) {
            genScheme.setId(IDUtils.UUID());
            genSchemeDao.save(genScheme);
        } else {
            genSchemeDao.update(genScheme);
        }
        // 生成代码
        if ("1".equals(genScheme.getFlag())) {
            return generateCode(genScheme);
        }
        return "";
    }

    private String generateCode(GenScheme genScheme) {

        StringBuilder result = new StringBuilder();

        // 查询主表及字段列
        GenTable genTable = genTableDao.get(genScheme.getGenTableId());
        List<GenTableColumn> list = genTableColumnDao.list(new GenTableColumn().setGenTableId(genScheme.getGenTableId()));
        list.sort(Comparator.comparingInt(o -> Integer.parseInt(o.getSort())));
        genTable.setColumnList(list);

        // 获取所有代码模板
        GenConfig config = GenUtils.getConfig();

        // 获取模板列表
        List<GenTemplate> templateList = GenUtils.getTemplateList(config, genScheme.getCategory(), false);
        List<GenTemplate> childTableTemplateList = GenUtils.getTemplateList(config, genScheme.getCategory(), true);

        // 如果有子表模板，则需要获取子表列表
        if (childTableTemplateList.size() > 0) {
            GenTable parentTable = new GenTable();
            parentTable.setParentTable(genTable.getName());
            genTable.setChildList(genTableDao.list(parentTable));
        }

        // 生成子表模板代码
        for (GenTable childTable : genTable.getChildList()) {
            childTable.setParent(genTable);
            childTable.setColumnList(genTableColumnDao.list(new GenTableColumn().setGenTable(new GenTable().setId(childTable.getId()))));
            genScheme.setGenTable(childTable);
            Map<String, Object> childTableModel = GenUtils.getDataModel(genScheme);
            for (GenTemplate tpl : childTableTemplateList) {
                result.append(GenUtils.generateToFile(tpl, childTableModel, genScheme.getReplaceFile()));
            }
        }

        // 生成主表模板代码
        genScheme.setGenTable(genTable);
        Map<String, Object> model = GenUtils.getDataModel(genScheme);
        for (GenTemplate tpl : templateList) {
            result.append(GenUtils.generateToFile(tpl, model, genScheme.getReplaceFile()));
        }
        return result.toString();
    }
}
