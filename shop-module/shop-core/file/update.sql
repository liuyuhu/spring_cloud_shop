ALTER TABLE `shdy_shop`.`gen_scheme`
ADD COLUMN `table_name` varchar(255) NULL COMMENT '关联类名' AFTER `category`;

ALTER TABLE `shdy_shop`.`gen_scheme`
ADD COLUMN `change_module` varchar(255) NULL COMMENT '切换模块\n' AFTER `table_name`;

ALTER TABLE `shdy_shop`.`gen_table`
  ADD COLUMN `extend_base` varchar(255) NULL COMMENT '是否集成 baseEntity' AFTER `comments`;