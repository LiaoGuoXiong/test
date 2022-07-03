package com.example.controller;

import com.example.bean.ClientBean;
import com.example.bean.UserBean;
import com.example.service.UserInfoInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;


//用户开发功能
@Controller
@RequestMapping("user")
public class LoginController {

    private static final Logger log = LoggerFactory.getLogger(UserInfoController.class);

    private final UserInfoInterface UserInfoInterface;

    public UserInfoController(com.example.service.UserInfoInterface userInfoInterface) {
        UserInfoInterface = userInfoInterface;
    }
    /*
     *用户注册
     *@return
     */
    @PostMapping("/registUserInfo")
    public  String register(UserBean user,ClientBean client) throws UnsupportedEncodingException {
        log.debug("用户名：{},邮箱：{}，密码：{}，类别：{}",user.getUserName(),user.getPassword(),user.getMailAddress(),client.getClient());

        try {
            //1-1必須項目チェック
            if (user.getMailAddress() != null)throw new RuntimeException("「メールアドレス」を入力して下さい");
            if (user.getUserName() != null)throw new RuntimeException("「ユーザー名」を入力して下さい");
            if (user.getPassWord() != null)throw new RuntimeException("「パスワード」を入力して下さい");
            if (user.getPassWord() != null)throw new RuntimeException("「確認パスワード」を入力して下さい");
            //1,注册用户
            UserInfoInterface.register(user,client);
        }catch (RuntimeException e){
            e.printStackTrace();
            return "redirect:/registUserInfo.jsp?msg=" + URLEncoder.encode(e.getMessage(),"UTF-8");
        }

        return "redirect:/login.jsp";
    }
}
