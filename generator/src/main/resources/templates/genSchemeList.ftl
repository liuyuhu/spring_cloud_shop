<head>
    <title>生成方案管理</title>
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
    </script>
</head>
<body style="margin: 20px">
<ul class="nav nav-tabs">
    <li class="active"><a href="/gen/genScheme/">生成方案列表</a></li>
    <li><a href="/gen/genScheme/form">生成方案添加</a></li>
    <li><a href="/gen/genTable/">业务表列表</a></li>
    <li><a href="/gen/genTable/form">业务表查看</a></li>

</ul>
<form id="searchForm" action="/gen/genScheme/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>方案名称 ：</label>
    <input name="name" maxlength="50" class="input-medium"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>方案名称</th>
        <th>对应类名</th>
        <th>生成包路径</th>
        <th>模块名</th>
        <th>功能名</th>
        <th>功能作者</th>
        <th colspan="2">操作</th>
    </thead>
    <tbody>
        <#list page.result as genScheme >
            <tr>
                <td><a href="/gen/genScheme/form?id=${genScheme.id}">${genScheme.name}</a></td>
                <td><#if genScheme.tableName ??>${genScheme.tableName}</#if></td>
                <td>${genScheme.packageName}</td>
                <td>${genScheme.moduleName}<#if genScheme.subModuleName ?? && genScheme.subModuleName != "" >.</#if>${genScheme.subModuleName}</td>
                <td>${genScheme.functionName}</td>
                <td>${genScheme.functionAuthor}</td>
                <td><a href="/gen/genScheme/form?id=${genScheme.id}">修改</a></td>
                <td><a href="/gen/genScheme/delete?id=${genScheme.id}"
                       onclick="return confirmx('确认要删除该生成方案吗？', this.href)">删除</a></td>
            </tr>
        </#list>
    </tbody>
</table>
</body>
</html>
