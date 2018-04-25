package com.github.generator.configure;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.annotation.PostConstruct;
import java.util.Properties;

/**
 * @author liuyuhu
 * @date 2018/4/24 下午7:13
 */

@Configuration
public class FreemarkerConfiguration {

    @Autowired
    protected freemarker.template.Configuration configuration;

    @PostConstruct
    public void  setSharedVariable() throws Exception{
//        属性值为空，去掉异常
        configuration.setSetting("classic_compatible", "true");
    }

    /*@Bean
    public FreeMarkerConfigurer FreeMarkerConfigurer() {
        FreeMarkerConfigurer configure = new FreeMarkerConfigurer();
        configure.setDefaultEncoding("utf-8");
        configure.setTemplateLoaderPath("/");
        Properties properties = new Properties();
        properties.put("classic_compatible", "true");
        configure.setFreemarkerSettings(properties);
        return configure;
    }*/

}
