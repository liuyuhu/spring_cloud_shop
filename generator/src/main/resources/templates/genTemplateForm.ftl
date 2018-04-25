<html>
<head>
    <title>代码模板管理</title>
    <meta name="decorator" content="default"/>
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
    <li><a href="/gen/genScheme/form">生成方案查看</a></li>
    <li><a href="/gen/genTable/">业务表列表</a></li>
    <li><a href="/gen/genTable/form">业务表查看</a></li>
    <li><a href="/gen/genTemplate/">代码模板列表</a></li>
    <li class="active"><a href="/gen/genTemplate/form">代码模板查看</a></li>
</ul>
<br/>
<form id="inputForm" action="/gen/genTemplate/save" method="post" class="form-horizontal">
    <input type="hidden" name="id"/>
    <div class="control-group">
        <label class="control-label">名称:</label>
        <div class="controls">
            <input name="name" maxlength="200" class="required"/>
        </div>
    </div>
   <#-- <div class="control-group">
        <label class="control-label">归属分类:</label>
        <div class="controls">
				<select name="category" class="required">
					<option value=""></option>
					<options items="${fns:getDictList('gen_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</select>
            <checkboxes items="${fns:getDictList('gen_category')}" name="categoryList" itemLabel="label"
                             itemValue="value" htmlEscape="false"/>
        </div>
    </div>-->
    <div class="control-group">
        <label class="control-label">生成路径:</label>
        <div class="controls">
            <input name="filePath" maxlength="500" class="required input-xxlarge"/>
            <br/>
            <span class="help-inline">
					示例如下：<br/>
					java：src/main/java/\${packageName}/\${moduleName}/entity/\${subModuleName}<br/>
					view：src/main/webapp/WEB-INF/views/\${lastPackageName}/${moduleName}/\${subModuleName}<br/>
					mapper:/src/main/resources/mappings/\${dbType}/\${lastPackageName}/\${moduleName}/\${subModuleName}
				</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">生成文件名:</label>
        <div class="controls">
            <input name="fileName" maxlength="500" class="required input-xlarge"/>
            <br/>
            <span class="help-inline">
					示例如下：<br/>
					java：\${ClassName}Entity.jsp<br/>
					view：\${className}List.jsp
				</span>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
</html>
