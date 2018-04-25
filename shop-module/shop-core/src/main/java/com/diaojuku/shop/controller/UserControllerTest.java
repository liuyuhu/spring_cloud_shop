package com.diaojuku.shop.controller;

import com.diaojuku.shop.user.entity.User;
import com.diaojuku.shop.user.service.UserService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author liuyuhu
 * @date 2018/4/25 下午2:47
 */

@RestController
public class UserControllerTest {

    @Resource
    private UserService userService;

    @RequestMapping("/test/user")
    public User get(Long userId) {
        return userService.get(String.valueOf(userId));
    }
}
