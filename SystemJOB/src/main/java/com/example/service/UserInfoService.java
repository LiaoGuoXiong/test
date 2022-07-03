package com.example.service;

import com.example.dao.UserInfoDao;
import com.example.bean.ClientBean;
import com.example.bean.UserBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

@Service
@Transactional
public class UserInfoService implements UserInfoInterface{
    private UserInfoDao userdao;

    @Autowired
    public UserInfoService(UserInfoDao userdao) {
        this.userdao = userdao;
    }

    @Override
    public void register(UserBean user,ClientBean client) {

        //1.查询数据用户是否存在该用户名
        UserBean userDB = userdao.findByUserName(user.getUserName());
        if(!ObjectUtils.isEmpty(userDB))throw new RuntimeException("用户名已存在！");
        {

        //2.进行注册

            userdao.save(user);
        }
        //2.如果存在报错，用户名已经存在
        //3.如果不存在进行注册

    }

}
