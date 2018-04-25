<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>生成方案管理</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="/bootstrap-3.3.7/css/bootstrap.css">
    <script src="/jquery-1.8.3.js"></script>
    <script src="/bootstrap-3.3.7/js/bootstrap.js"></script>
    <script src="/jquery.validate.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    //loading('正在提交，请稍等...');
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
    <li class="active"><a href="/gen/genScheme/form">生成方案查看</a></li>
    <li><a href="/gen/genTable/">业务表列表</a></li>
    <li><a href="/gen/genTable/form">业务表查看</a></li>
</ul>
<br/>
<form id="inputForm" action="/gen/genScheme/save" method="post" class="form-horizontal">
    <input type="hidden"  name="id" value="${genScheme.id}"/>
    <input type="hidden"  name="genTableId" value="${genScheme.genTableId}"/>
    <input type="hidden" id="flag" name="flag" value="${genScheme.flag}"/>
    <div class="control-group">
        <label class="control-label">对应实体:</label>
        <div class="controls">
            <input readonly name="tableName" value="${genScheme.tableName}" maxlength="200"/>
            <span class="help-inline"></span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">方案名称:</label>
        <div class="controls">
            <input name="name" value="${genScheme.name}" maxlength="200" class="required"/>
            <span class="help-inline"></span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">maven模块切换:</label>
        <div class="controls">
            <input name="changeModule" value="${genScheme.changeModule}" maxlength="200"/>
            <span class="help-inline"></span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">模板分类:</label>
        <div class="controls">
            <select name="category" class="required input-xlarge">
                <#list config.categoryList as item>
                    <option value="${item.value}" <#if genScheme.category == item.value>selected</#if>>${item.label}</option>
                </#list>
            </select>
            <span class="help-inline">
					生成结构：{包名}/{模块名}/{分层(dao,entity,service,controller)}/{子模块名}/{java类}
            </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成包路径:</label>
        <div class="controls">
            <input name="packageName" value="${genScheme.packageName}" maxlength="500" class="required input-xlarge"/>
            <span class="help-inline">建议模块包：com.diaojuku.generator</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成模块名:</label>
        <div class="controls">
            <input name="moduleName" value="${genScheme.moduleName}" maxlength="500" class="required input-xlarge"/>
            <span class="help-inline">可理解为子系统名，例如 sys</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成子模块名:</label>
        <div class="controls">
            <input name="subModuleName" value="${genScheme.subModuleName}" maxlength="500" class="input-xlarge"/>
            <span class="help-inline">可选，分层下的文件夹，例如 </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成功能描述:</label>
        <div class="controls">
            <input name="functionName" value="${genScheme.functionName}" maxlength="500" class="required input-xlarge"/>
            <span class="help-inline">将设置到类描述</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成功能名:</label>
        <div class="controls">
            <input name="functionNameSimple" value="${genScheme.functionNameSimple}" maxlength="500" class="required input-xlarge"/>
            <span class="help-inline">用作功能提示，如：保存“某某”成功</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成功能作者:</label>
        <div class="controls">
            <input name="functionAuthor" value="${genScheme.functionAuthor}" maxlength="500" class="required input-xlarge"/>
            <span class="help-inline">功能开发者</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">业务表名:</label>
        <div class="controls">
            <select name="genTable.id" class="required input-xlarge">
                <#list tableList as table>
                    <option value="${table.id}" <#if genScheme.genTableId == table.id>selected</#if>>${table.nameAndComments}</option>
                </#list>
            </select>
            <span class="help-inline">生成的数据表，一对多情况下请选择主表。</span>
        </div>
    </div>
    <#--<div class="control-group hide">
        <label class="control-label">备注:</label>
            <div class="controls">
                <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
            </div>
    </div>-->
    <div class="control-group">
        <label class="control-label">生成选项:</label>
        <div class="controls">
            <input type="checkbox" name="replaceFile" value="1">是否替换现有文件
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存方案" onclick="$('#flag').val('0');"/>&nbsp;
        <input id="btnSubmit" class="btn btn-danger" type="submit" value="保存并生成代码" onclick="$('#flag').val('1');"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
<script>
    function chooseFlag(flag) {
        $("#flag").val(flag);
    }
</script>
</html>
