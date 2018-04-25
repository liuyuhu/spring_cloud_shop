package com.diaojuku.shop.user.entity;

import com.diaojuku.common.entity.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 用户信息Entity
 * @author liuyuhu
 * @version 2018-04-25
 */

@Data
@Accessors(chain = true)
public class User extends BaseEntity {
    /**
     * user_id
     */ 
    private Long userId;
    /**
     * aite_id
     */ 
    private String aiteId;
    /**
     * email
     */ 
    private String email;
    /**
     * user_name
     */ 
    private String userName;
    /**
     * password
     */ 
    private String password;
    /**
     * is_surplus_open
     */ 
    private Integer isSurplusOpen;
    /**
     * surplus_password
     */ 
    private String surplusPassword;
    /**
     * question
     */ 
    private String question;
    /**
     * answer
     */ 
    private String answer;
    /**
     * sex
     */ 
    private Integer sex;
    /**
     * birthday
     */ 
    private Date birthday;
    /**
     * user_money
     */ 
    private String userMoney;
    /**
     * frozen_money
     */ 
    private String frozenMoney;
    /**
     * pay_points
     */ 
    private Integer payPoints;
    /**
     * rank_points
     */ 
    private Integer rankPoints;
    /**
     * address_id
     */ 
    private Integer addressId;
    /**
     * reg_time
     */ 
    private Integer regTime;
    /**
     * last_login
     */ 
    private Integer lastLogin;
    /**
     * last_time
     */ 
    private Date lastTime;
    /**
     * last_ip
     */ 
    private String lastIp;
    /**
     * visit_count
     */ 
    private Integer visitCount;
    /**
     * user_rank
     */ 
    private Integer userRank;
    /**
     * is_special
     */ 
    private Integer isSpecial;
    /**
     * ec_salt
     */ 
    private String ecSalt;
    /**
     * salt
     */ 
    private String salt;
    /**
     * parent_id
     */ 
    private Integer parentId;
    /**
     * flag
     */ 
    private Integer flag;
    /**
     * alias
     */ 
    private String alias;
    /**
     * msn
     */ 
    private String msn;
    /**
     * qq
     */ 
    private String qq;
    /**
     * office_phone
     */ 
    private String officePhone;
    /**
     * home_phone
     */ 
    private String homePhone;
    /**
     * mobile_phone
     */ 
    private String mobilePhone;
    /**
     * is_validated
     */ 
    private Integer isValidated;
    /**
     * validated
     */ 
    private Integer validated;
    /**
     * credit_line
     */ 
    private String creditLine;
    /**
     * passwd_question
     */ 
    private String passwdQuestion;
    /**
     * passwd_answer
     */ 
    private String passwdAnswer;
    /**
     * passwd_weixin
     */ 
    private String passwdWeixin;
    /**
     * is_fenxiao
     */ 
    private Integer isFenxiao;
    /**
     * real_name
     */ 
    private String realName;
    /**
     * card
     */ 
    private String card;
    /**
     * face_card
     */ 
    private String faceCard;
    /**
     * back_card
     */ 
    private String backCard;
    /**
     * country
     */ 
    private Integer country;
    /**
     * province
     */ 
    private Integer province;
    /**
     * city
     */ 
    private Integer city;
    /**
     * district
     */ 
    private Integer district;
    /**
     * address
     */ 
    private String address;
    /**
     * status
     */ 
    private Integer status;
    /**
     * mediaUID
     */ 
    private String mediauid;
    /**
     * mediaID
     */ 
    private Integer mediaid;
    /**
     * pc:电脑,mobile:手机,app:应用
     */ 
    private String froms;
    /**
     * headimg
     */ 
    private String headimg;

}