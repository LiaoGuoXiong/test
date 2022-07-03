package com.example.dao;

import com.example.bean.UserBean;

public interface UserInfoDao {
    //根据用户名查询用户
    UserBean findByUserName(String username);
    //注册用户
    void save(UserBean user);
}
