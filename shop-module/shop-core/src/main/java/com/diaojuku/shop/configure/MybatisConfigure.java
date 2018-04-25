package com.diaojuku.shop.configure;

import com.diaojuku.common.interceptor.PageInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author liuyuhu
 * @date 2018/4/23 下午4:17
 */

@Configuration
@MapperScan("com.diaojuku.**.dao")
public class MybatisConfigure {

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


