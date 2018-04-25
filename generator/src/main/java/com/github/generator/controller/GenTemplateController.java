package com.github.generator.controller;

import com.github.generator.common.entity.Page;
import com.github.generator.common.utils.IDUtils;
import com.github.generator.entity.GenTemplate;
import com.github.generator.service.GenTemplateService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * 代码模板Controller
 *
 * @author ThinkGem
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "/gen/genTemplate")
public class GenTemplateController {

    @Autowired
    private GenTemplateService genTemplateService;

    @ModelAttribute
    public GenTemplate get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return genTemplateService.get(id);
        } else {
            return new GenTemplate();
        }
    }

    @RequestMapping(value = {"list", ""})
    public String list(GenTemplate genTemplate, Model model) {
        Page<GenTemplate> page = genTemplateService.find(new Page<GenTemplate>(), genTemplate);
        model.addAttribute("page", page);
        return "genTemplateList";
    }

    @RequestMapping(value = "form")
    public String form(GenTemplate genTemplate, Model model) {
        model.addAttribute("genTemplate", genTemplate);
        return "genTemplateForm";
    }

    @RequestMapping(value = "save")
    public String save(GenTemplate genTemplate) {
        genTemplate.setId(IDUtils.UUID());
        genTemplateService.save(genTemplate);
        return "redirect:/gen/genTemplate/";
    }

    @RequestMapping(value = "delete")
    public String delete(GenTemplate genTemplate) {
        genTemplateService.delete(genTemplate.getId(), true);
        return "redirect:/gen/genTemplate/";
    }

}
