package com.github.generator.service;

import com.github.generator.common.entity.BaseService;
import com.github.generator.common.entity.Page;
import com.github.generator.entity.GenTemplate;

/**
 * 代码模板Service
 *
 * @author ThinkGem
 * @version 2013-10-15
 */
public interface GenTemplateService extends BaseService<GenTemplate> {

    Page<GenTemplate> find(Page<GenTemplate> page, GenTemplate genTemplate);

    @Override
    int save(GenTemplate genTemplate);

}
