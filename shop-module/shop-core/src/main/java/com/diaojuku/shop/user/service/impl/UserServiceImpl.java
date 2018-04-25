package com.diaojuku.shop.user.service.impl;

import com.diaojuku.common.entity.BaseServiceImpl;
import com.diaojuku.shop.user.entity.User;
import com.diaojuku.shop.user.dao.UserDao;
import com.diaojuku.shop.user.service.UserService;
import org.springframework.stereotype.Service;

/**
 * 用户信息ServiceImpl
 * @author liuyuhu
 * @version 2018-04-25
 */

@Service
public class UserServiceImpl extends BaseServiceImpl<UserDao, User> implements UserService {
	
}