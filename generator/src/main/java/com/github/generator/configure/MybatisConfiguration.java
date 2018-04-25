package com.github.generator.configure;

import com.github.generator.common.interceptor.PageInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author liuyuhu
 * @date 2018/4/23 下午4:17
 */

@Configuration
@MapperScan("com.github.generator.dao")
public class MybatisConfiguration {

    /**
     * 分页插件
     *
     * @return PageInterceptor
     */
    @Bean
    public PageInterceptor pageInterceptor() {
        return new PageInterceptor();
    }
}


