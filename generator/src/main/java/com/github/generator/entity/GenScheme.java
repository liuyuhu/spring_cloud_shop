package com.github.generator.entity;

import com.github.generator.common.entity.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 实体生层方案Entity
 * @author  liuyuhu
 * @version 2018-04-23
 */

@Data
@Accessors(chain = true)
public class GenScheme extends BaseEntity {
    /**
     * 编号
     */ 
    private String id;
    /**
     * 名称
     */ 
    private String name;
    /**
     * 实体类名称
     */ 
    private String tableName;
    /**
     * 分类
     */ 
    private String category;
    /**
     * 更换模块名
     */ 
    private String changeModule;
    /**
     * 生成包路径
     */ 
    private String packageName;
    /**
     * 生成模块名
     */ 
    private String moduleName;
    /**
     * 生成子模块名
     */ 
    private String subModuleName;
    /**
     * 生成功能名
     */ 
    private String functionName;
    /**
     * 生成功能名（简写）
     */ 
    private String functionNameSimple;
    /**
     * 生成功能作者
     */ 
    private String functionAuthor;
    /**
     * 生成表编号
     */ 
    private String genTableId;

    /**
     * 实体表之外信息
     */
    /**
     * 业务表名
     */
    private GenTable genTable;
    /**
     * 0：保存方案； 1：保存方案并生成代码
     */
    private String flag;
    /**
     * 是否替换现有文件    0：不替换；1：替换文件
     */
    private Boolean replaceFile = false;

}