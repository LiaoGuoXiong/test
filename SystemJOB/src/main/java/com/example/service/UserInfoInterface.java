package com.example.service;

import com.example.bean.ClientBean;
import com.example.bean.UserBean;

public interface UserInfoInterface {
    //用户注册
    void register(UserBean user, ClientBean client);
}
