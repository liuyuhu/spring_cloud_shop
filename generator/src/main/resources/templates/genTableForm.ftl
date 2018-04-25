<html>
<head>
    <title>业务表管理</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="/bootstrap-3.3.7/css/bootstrap.css">
    <script src="/jquery-1.8.3.js"></script>
    <script src="/bootstrap-3.3.7/js/bootstrap.js"></script>
    <script src="/jquery.validate.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#comments").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    //loading('正在提交，请稍等...');
                    $("input[type=checkbox]").each(function () {
                        $(this).after("<input type=\"hidden\" name=\"" + $(this).attr("name") + "\" value=\""
                            + ($(this).attr("checked") ? "1" : "0") + "\"/>");
                        $(this).attr("name", "_" + $(this).attr("name"));
                    });
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body style="margin: 20px">
<ul class="nav nav-tabs">
    <li><a href="/gen/genScheme/">生成方案列表</a></li>
    <li><a href="/gen/genScheme/form">生成方案查看</a></li>
    <li><a href="/gen/genTable/">业务表列表</a></li>
    <li class="active"><a href="/gen/genTable/form">业务表查看</a>
    </li>
</ul>
<#if genTable.name ??>
    <form id="inputForm" action="/gen/genTable/save" method="post" class="form-horizontal">
        <input type="hidden" name="id" value="${genTable.id}"/>
        <fieldset>
            <legend>基本信息</legend>
            <div class="control-group">
                <label class="control-label">表名:</label>
                <div class="controls">
                    <input name="name" value="${genTable.name}" maxlength="200" class="required" readonly />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">说明:</label>
                <div class="controls">
                    <input name="comments" value="${genTable.comments}" maxlength="200" class="required"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">类名:</label>
                <div class="controls">
                    <input name="className" value="${genTable.className}" maxlength="200" class="required"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否继承基类BaseEntity:</label>
                <div class="controls">
                    <input type="checkbox" <#if genTable.extendBase == 1 >checked</#if> name="extendBase">继承基类BaseEntity
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">父表表名:</label>
                <div class="controls">
                    <select name="parentTable" class="input-xlarge">
                        <option value="">无</option>
                        <#list tableList as table>
                            <option value="${table.name}">${table.nameAndComments}</option>
                        </#list>
                    </select>
                    &nbsp;当前表外键：
                    <select name="parentTableFk" class="input-xlarge">
                        <option value="">无</option>
                        <#list genTable.columnList as item>
                            <option value="${item.name}">${item.nameAndComments}</option>
                        </#list>
                    </select>
                    <span class="help-inline">如果有父表，请指定父表表名和外键</span>
                </div>
            </div>
            <#--<div class="control-group hide">
                <label class="control-label">备注:</label>
                <div class="controls">
                <textarea name="remarks"  rows="4" maxlength="200" class="input-xxlarge"/>
            </div>-->
            <legend>字段列表</legend>
            <div class="control-group">
                <table id="contentTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr>
                        <th title="数据库字段名">列名</th>
                        <th title="默认读取数据库字段备注">说明</th>
                        <th title="数据库中设置的字段类型及长度">物理类型</th>
                        <th title="实体对象的属性字段类型">Java类型</th>
                        <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">
                            Java属性名称 <i class="icon-question-sign"></i></th>
                        <th title="是否是数据库主键">主键</th>
                        <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
                        <th title="选中后该字段被加入到insert语句里">插入</th>
                        <th title="选中后该字段被加入到update语句里">编辑</th>
                        <#--<th title="选中后该字段被加入到查询列表里">列表</th>-->
                        <th title="选中后该字段被加入到查询条件里">查询</th>
                        <th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
                        <th title="字段在表单中显示的类型">显示表单类型</th>
                        <#--<th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>-->
                        <th>排序</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list genTable.columnList as column>
                        <tr <#if column.valid == 1>class="error" title="已删除的列，保存之后消失！"</#if>>
                            <td nowrap>
                                <input type="hidden" name="columnList[${column_index}].id" value="${column.id!""}"/>
                                <input type="hidden" name="columnList[${column_index}].valid" value="1"/>
                                <input type="hidden" name="columnList[${column_index}].genTable.id" value="${column.genTableId!""}"/>
                                <input type="hidden" name="columnList[${column_index}].name" value="${column.name}"/>${column.name}
                            </td>
                            <td>
                                <input type="text" name="columnList[${column_index}].comments"
                                       value="${column.comments}" maxlength="200" class="required"
                                       style="width:100px;"/>
                            </td>
                            <td nowrap>
                                <input type="hidden" name="columnList[${column_index}].jdbcType"
                                       value="${column.jdbcType}"/>${column.jdbcType}
                            </td>
                            <td>
                                <select name="columnList[${column_index}].javaType" class="required input-mini"
                                        style="width:85px;*width:75px">
                                    <#list config.javaTypeList as dict>
                                        <option value="${dict.value}" <#if dict.value==column.javaType>selected</#if>>${dict.label}</option>
                                    </#list>
                                </select>
                            </td>
                            <td>
                                <input type="text" name="columnList[${column_index}].javaField"
                                       value="${column.javaField}" maxlength="200" class="required input-small"/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnList[${column_index}].isPk"
                                       value="1" <#if column.isPk == "1">checked</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnList[${column_index}].isNull"
                                       value="1" <#if column.isNull == "1">checked</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnList[${column_index}].isInsert"
                                       value="1" <#if column.isInsert == "1">checked</#if> />
                            </td>
                            <td>
                                <input type="checkbox" name="columnList[${column_index}].isEdit"
                                       value="1" <#if column.isEdit?? && column.isEdit == "1">checked</#if>/>
                            </td>
                        <#--<td>
                            <input type="checkbox" name="columnList[${column_index}].isList"
                                   value="1" ${column.isList eq '1' ? 'checked' : ''}/>
                        </td>-->
                            <td>
                                <input type="checkbox" name="columnList[${column_index}].isQuery"
                                       value="1" <#if column.isQuery == '1'>checked</#if> />
                            </td>
                            <td>
                                <select name="columnList[${column_index}].queryType" class="required input-mini">
                                    <#list config.queryTypeList as dict>
                                        <option value="${dict.value!""}" <#if dict.value ?? && dict.value==column.queryType>selected</#if>>${dict.label!""}</option>
                                    </#list>
                                </select>
                            </td>
                            <td>
                                <select name="columnList[${column_index}].showType" class="required"
                                        style="width:100px;">
                                    <#list config.showTypeList as dict>
                                        <option value="${dict.value}" <#if dict.value==column.showType>selected</#if> >${dict.label}</option>
                                    </#list>
                                </select>
                            </td>
                        <#--<td>
                            <input type="text" name="columnList[${column_index}].dictType"
                                   value="${column.dictType}" maxlength="200" class="input-mini"/>
                        </td>-->
                            <td>
                                <input type="text" name="columnList[${column_index}].sort" value="${column.sort}"
                                       maxlength="200" class="required input-min digits"/>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <div class="form-actions">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </form>
<#else>
    <form id="inputForm" action="/gen/genTable/form" method="post" class="form-horizontal">
        <input type="hidden" name="id"/>
        <br/>
        <div class="control-group">
            <label class="control-label">表名:</label>
            <div class="controls">
                <select name="name" class="input-xxlarge">
                    <#list tableList as item>
                        <option value="${item.name}">${item.nameAndComments}</option>
                    </#list>
                </select>
            </div>
            <div class="form-actions">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </div>
    </form>
</#if>
</body>
</html>
