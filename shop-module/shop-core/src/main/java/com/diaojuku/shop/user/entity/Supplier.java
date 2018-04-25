package com.diaojuku.shop.user.entity;

import com.diaojuku.common.entity.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 商家用户信息Entity
 * @author liuyuhu
 * @version 2018-04-25
 */

@Data
@Accessors(chain = true)
public class Supplier extends BaseEntity {
    /**
     * supplier_id
     */ 
    private Long supplierId;
    /**
     * 申请入驻人id
     */ 
    private Long userId;
    /**
     * 供货商名称
     */ 
    private String supplierName;
    /**
     * 店铺等级
     */ 
    private Integer rankId;
    /**
     * 店铺类型
     */ 
    private Integer typeId;
    /**
     * 公司名称
     */ 
    private String companyName;
    /**
     * 公司所在地(国家)
     */ 
    private Integer country;
    /**
     * 公司所在地(省)
     */ 
    private Integer province;
    /**
     * 公司所在地(市)
     */ 
    private Integer city;
    /**
     * 公司所在地(县/区)
     */ 
    private Integer district;
    /**
     * 公司详细地址
     */ 
    private String address;
    /**
     * 公司电话
     */ 
    private String tel;
    /**
     * 电子邮件
     */ 
    private String email;
    /**
     * 公司规模
     */ 
    private String guimo;
    /**
     * 公司类型
     */ 
    private String companyType;
    /**
     * bank
     */ 
    private String bank;
    /**
     * 营业执照电子版
     */ 
    private String zhizhao;
    /**
     * contact
     */ 
    private String contact;
    /**
     * id_card
     */ 
    private String idCard;
    /**
     * contact_back
     */ 
    private String contactBack;
    /**
     * contact_shop
     */ 
    private String contactShop;
    /**
     * contact_yunying
     */ 
    private String contactYunying;
    /**
     * contact_shouhou
     */ 
    private String contactShouhou;
    /**
     * contact_caiwu
     */ 
    private String contactCaiwu;
    /**
     * contact_jishu
     */ 
    private String contactJishu;
    /**
     * system_fee
     */ 
    private Double systemFee;
    /**
     * supplier_bond
     */ 
    private Double supplierBond;
    /**
     * supplier_rebate
     */ 
    private Integer supplierRebate;
    /**
     * supplier_rebate_paytime
     */ 
    private Integer supplierRebatePaytime;
    /**
     * supplier_remark
     */ 
    private String supplierRemark;
    /**
     * nav_list
     */ 
    private String navList;
    /**
     * 状态
     */ 
    private Integer status;
    /**
     * 申请时间
     */ 
    private Integer addTime;
    /**
     * 申请入驻步骤
     */ 
    private Integer applynum;
    /**
     * 联系人
     */ 
    private String contactsName;
    /**
     * 联系人电话
     */ 
    private String contactsPhone;
    /**
     * 营业执照号
     */ 
    private String businessLicenceNumber;
    /**
     * 法定经营范围
     */ 
    private String businessSphere;
    /**
     * 组织机构代码
     */ 
    private String organizationCode;
    /**
     * 组织机构代码证电子版
     */ 
    private String organizationCodeElectronic;
    /**
     * 一般纳税人证明
     */ 
    private String generalTaxpayer;
    /**
     * 银行开户名
     */ 
    private String bankAccountName;
    /**
     * 公司开户行银行账号
     */ 
    private String bankAccountNumber;
    /**
     * 开户银行支行名称
     */ 
    private String bankName;
    /**
     * 支行联行号
     */ 
    private String bankCode;
    /**
     * 银行开户名(结算)
     */ 
    private String settlementBankAccountName;
    /**
     * 公司银行账号(结算)
     */ 
    private String settlementBankAccountNumber;
    /**
     * 开户银行支行名称(结算)
     */ 
    private String settlementBankName;
    /**
     * 支行联行号(结算)
     */ 
    private String settlementBankCode;
    /**
     * 税务登记证号
     */ 
    private String taxRegistrationCertificate;
    /**
     * 纳税人识别号
     */ 
    private String taxpayerId;
    /**
     * 开户银行许可证电子版
     */ 
    private String bankLicenceElectronic;
    /**
     * 税务登记证号电子版
     */ 
    private String taxRegistrationCertificateElectronic;
    /**
     * 入驻商的佣金
     */ 
    private Double supplierMoney;
    /**
     * 手持身份证照片
     */ 
    private String handheldIdcard;
    /**
     * 身份证证明照片
     */ 
    private String idcardFront;
    /**
     * 身份证反面照片
     */ 
    private String idcardReverse;
    /**
     * 身份证号码
     */ 
    private String idCardNo;
    /**
     * latitude
     */ 
    private String latitude;
    /**
     * longitude
     */ 
    private String longitude;
    /**
     * 个人微信二维码
     */ 
    private String wechatQrCode;
    /**
     * 店铺门头照
     */ 
    private String shopPhoto;
    /**
     * 店铺分类 10：商家 20：渔具店
     */ 
    private Integer type;

}