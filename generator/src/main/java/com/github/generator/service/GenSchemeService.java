package com.github.generator.service;

import com.github.generator.common.entity.BaseService;
import com.github.generator.common.entity.Page;
import com.github.generator.entity.GenScheme;

/**
 * 生成方案Service
 *
 * @author ThinkGem
 * @version 2013-10-15
 */
public interface GenSchemeService extends BaseService<GenScheme> {

    Page<GenScheme> find(Page<GenScheme> page, GenScheme genScheme);

    String saveOrUpdate(GenScheme genScheme);

}
