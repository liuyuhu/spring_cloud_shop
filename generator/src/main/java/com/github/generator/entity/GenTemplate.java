package com.github.generator.entity;

import com.github.generator.common.entity.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang3.StringUtils;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * 代码模板信息Entity
 * @author liuyuhu
 * @version 2018-04-23
 */

@Data
@Accessors(chain = true)
@XmlRootElement(name = "template")
public class GenTemplate extends BaseEntity {
    /**
     * 编号
     */ 
    private String id;
    /**
     * 名称
     */ 
    private String name;
    /**
     * 分类
     */ 
    private String category;
    /**
     * 生成文件路径
     */ 
    private String filePath;
    /**
     * 生成文件名
     */ 
    private String fileName;
    /**
     * 内容
     */ 
    private String content;

    @XmlTransient
    public List<String> getCategoryList() {
        if (category == null) {
            return new ArrayList<>();
        } else {
            return Arrays.asList(StringUtils.split(category, ","));
        }
    }

    public void setCategoryList(List<String> categoryList) {
        if (categoryList == null) {
            this.category = "";
        } else {
            this.category = "," + StringUtils.join(categoryList, ",") + ",";
        }
    }

}