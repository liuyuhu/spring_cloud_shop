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

        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function deleteConfirm(href) {
            var flag = confirm('确认要删除该代码模板吗？');
            if (flag) {
                window.location.href = href;
            } else {
            }
        }

    </script>
</head>
<body style="margin: 20px">
<ul class="nav nav-tabs">
    <li><a href="/gen/genScheme/">生成方案列表</a></li>
    <li><a href="/gen/genScheme/form">生成方案查看</a></li>
    <li><a href="/gen/genTable/">业务表列表</a></li>
    <li><a href="/gen/genTable/form">业务表查看</a></li>
    <li class="active"><a href="/gen/genTemplate/">代码模板列表</a></li>
    <li><a href="/gen/genTemplate/form">代码模板添加</a></li>
</ul>
<form id="searchForm" action="/gen/genTemplate/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>分类 ：</label>
    <select name="category" class="input-medium"></select>
    <label>名称 ：</label><input name="name" maxlength="50" class="input-medium"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form>
<div id="messageBoxError" class="alert alert-error">
    <button data-dismiss="alert" class="close">×</button>
    代码模板管理，已废弃！模板管理改为XML配置方式，见 /src/main/java/com/thinkgem/jeesite/template 文件夹
</div>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>名称</th>
        <th>分类</th>
        <th>备注</th>
        <th>操作</th>
    </thead>
    <tbody>
    <#list page.result as genTemplate>
        <tr>
            <td><a href="/gen/genTemplate/form?id=${genTemplate.id}">${genTemplate.name}</a></td>
            <td>
                <a href="/gen/genTemplate/form?id=${genTemplate.id}">修改</a>
                <a href="/gen/genTemplate/delete?id=${genTemplate.id}"
                   onclick="return deleteConfirm(this.href)">删除</a>
            </td>
        </tr>
    </#list>
    </tbody>
</table>
</body>
</html>
