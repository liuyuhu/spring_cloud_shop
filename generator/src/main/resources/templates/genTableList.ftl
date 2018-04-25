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

        });
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body style="margin: 20px">
<ul class="nav nav-tabs">
    <li><a href="/gen/genScheme/">生成方案列表</a></li>
    <li><a href="/gen/genScheme/form">生成方案查看</a></li>
    <li class="active"><a href="/gen/genTable/">业务表列表</a></li>
    <li><a href="/gen/genTable/form">业务表添加</a></li>
</ul>
<form id="searchForm" action="/gen/genTable/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>表名：</label><input name="name" maxlength="50" class="input-medium"/>
    <label>说明：</label><input name="comments" maxlength="50" class="input-medium"/>
    <label>父表表名：</label><input name="parentTable" maxlength="50" class="input-medium"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th class="sort-column name">表名</th>
        <th>说明</th>
        <th class="sort-column class_name">类名</th>
        <th class="sort-column parent_table">父表</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#list page.result as genTable>
        <tr>
            <td><a href="/gen/genTable/form">${genTable.name}</a></td>
            <td>${genTable.comments}</td>
            <td>${genTable.className}</td>
            <td title="点击查询子表">
                <a href="javascript" onclick="$('#parentTable').val('${genTable.parentTable}');
                        $('#searchForm').submit();">${genTable.parentTable}
                </a>
            </td>
            <td>
                <a href="/gen/genTable/form?id=${genTable.id}">修改</a>
                <a href="/gen/genTable/delete?id=${genTable.id}"
                   onclick="return confirmx('确认要删除该业务表吗？', this.href)">删除</a>
            </td>
        </tr>
    </#list>
    </tbody>
</table>
</body>
</html>
