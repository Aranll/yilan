<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: GustinLau
  Date: 2017-05-02
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>医览网-系统-资源管理</title>
    <%@include file="../../common/head.jsp" %>
    <%@include file="../../common/validate.jsp" %>
    <%@include file="../../common/ztree.jsp" %>
</head>
<body>
<div class="app app-header-fixed app-aside-fixed">
    <%@include file="../../common/header.jsp" %>
    <%@include file="./../system_nav.jsp" %>

    <div class="app-content ">
        <div class="app-content-body">
            <div class="bg-light lter b-b wrapper-md ">
                <h1 class="m-n font-thin h3">资源管理</h1>
            </div>
            <div class="wrapper-md">
                <form class="form-horizontal" id="searchForm">
                    <div class="form-group">
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">编号：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="number" name="id" value="${id}"/>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">父级编号：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="number" name="pid" value="${pid}"/>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">键：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="text" name="key" value="${key}"/>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">类型：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <select id="searchType" name="type" class="form-control">
                                <option value="">全部</option>
                                <option value="0">菜单</option>
                                <option value="1">功能</option>
                                <option value="2">url</option>
                            </select>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">名称：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="text" name="name" value="${name}"/>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">URL：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="text" name="url" value="${url}"/>
                        </div>
                        <div class="col-xs-4 col-md-2 col-lg-1 no-padder m-b-md text-right">
                            <label class="control-label">请求方法：</label>
                        </div>
                        <div class="col-xs-8 col-md-4 col-lg-3 m-b-md">
                            <input class="form-control" type="text" name="method" value="${method}"/>
                        </div>
                    </div>
                    <div class="form-group m-t-n-md">
                        <div class="col-xs-12">
                            <sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_create})">
                                <button class="btn btn-success" type="button" data-toggle="modal" data-target="#create">
                                    新增
                                </button>
                            </sec:authorize>
                            <input class="btn btn-default pull-right" value="重置" type="button" onclick="resetSearch()">
                            <input class="btn btn-info pull-right m-r-sm" value="搜索" type="submit">
                        </div>
                    </div>
                </form>

                <div class="panel panel-default m-b-none">
                    <table class="table text-center table-bordered table-striped m-b-none">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>父级ID</th>
                            <th>键</th>
                            <th>类型</th>
                            <th>名称</th>
                            <th>URL</th>
                            <th>请求方法</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${resources.size() eq 0}">
                            <tr>
                                <td colspan="8">无数据</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${resources}" var="resource">
                            <tr>
                                <td>${resource.id}</td>
                                <td>${resource.pid}</td>
                                <td>${resource.key}</td>
                                <td>${resource.typeDesc}</td>
                                <td>${resource.name}</td>
                                <td>${resource.url}</td>
                                <td>${resource.method}</td>
                                <td>
                                    <sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_update})">
                                        <button class="btn btn-info btn-xs" onclick="edit('${resource.id}')">编辑</button>
                                    </sec:authorize>
                                    <sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_delete})">
                                        <button class="btn btn-danger btn-xs" onclick="del('${resource.id}')">删除
                                        </button>
                                    </sec:authorize>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <c:if test="${isPagination}">
                        <div class="col-xs-12">
                            <ul class="pagination pull-right">
                                    ${pagination}
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var $searchForm = $("#searchForm");
    var $searchType = $("#searchType");

    $searchType.val("${type}");

    function resetSearch() {
        $searchForm.find("input[type='text']").each(function () {
            $(this).val("");
        });
        $searchForm.find("input[type='number']").each(function () {
            $(this).val("");
        });
        $searchType.val("");
    }
    <sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_create})">
    var P_TYPE_CREATE = 0;
    </sec:authorize>
    <sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_update})">
    var P_TYPE_EDIT = 1;
    </sec:authorize>

    var treeType;
    function openTreeView(type) {
        treeType = type;
        $('#resourceTree').modal('show');
    }
</script>
<sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_create})">
    <%--新增资源--%>
    <div class="modal fade" id="create" data-backdrop="static" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">新增资源</h4>
                </div>
                <div class="modal-body">
                    <form name="createForm" class="form-horizontal">
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">父级</label>
                            </div>
                            <div class="col-xs-9">
                                <input id="createPid" type="hidden" name="pid">
                                <input id="createPName" class="form-control" type="text" name="pName" readonly
                                       onclick="openTreeView(P_TYPE_CREATE)"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">键</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="key"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">名称</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="name"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">类型</label>
                            </div>
                            <div class="col-xs-9">
                                <select id="createType" name="type" class="form-control">
                                    <option value="0">菜单</option>
                                    <option value="1">功能</option>
                                    <option value="2">url</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row" id="createURL" style="display: none;">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">URL</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="url"/>
                            </div>
                        </div>
                        <div class="form-group row" id="createMethod" style="display: none;">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">请求方法</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="method"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">顺序</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="number" name="seq"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">记录日志</label>
                            </div>
                            <div class="col-xs-9">
                                <select id="createLog" name="log" class="form-control">
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </div>
                        </div>
                    </form>
                    <div class="clearfix"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-success" onclick="submitCreateForm()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        var $createForm = $("form[name='createForm']");
        var $createType = $("#createType");
        var $createUrl = $("#createURL");
        var $createMethod = $("#createMethod");

        $createType.on("change", function () {
            if ($createType.val() == 2) {
                $createUrl.css("display", "block");
                $createMethod.css("display", "block");
            } else {
                $createUrl.css("display", "none");
                $createUrl.val(" ");
                $createMethod.css("display", "none");
                $createMethod.val(" ");
            }
        });
        var createValidate = $createForm.validate({
            errorClass: 'text-danger',
            rules: {
                pName: {
                    required: true
                },
                key: {
                    required: true,
                    notEmpty: true
                },
                name: {
                    required: true,
                    notEmpty: true
                },
                type: {
                    required: true
                },
                url: {
                    required: true,
                    notEmpty: true
                },
                method: {
                    required: true,
                    notEmpty: true
                },
                seq: {
                    required: true,
                    digits: true
                }
            },
            messages: {
                pName: {
                    required: "请选择父级"
                },
                key: {
                    required: "键不能为空",
                    notEmpty: "键不能为空"
                },
                name: {
                    required: "名称不能为空",
                    notEmpty: "名称不能为空"
                },
                type: {
                    required: "请选择类型"
                },
                url: {
                    required: "URL不能为空",
                    notEmpty: "URL不能为空"
                },
                method: {
                    required: "请求方法不能为空",
                    notEmpty: "请求方法不能为空"
                },
                seq: {
                    required: "顺序不能为空",
                    digits: "请填入数字"
                }
            },
            submitHandler: function (form) {
                doPost("<%=request.getContextPath()%>/admin/system/security/resource/create", $(form).serialize(), function (data) {
                    if (data.status) {
                        $("#info_success").modal("show");
//                        setTimeout(function(){
//                            window.location.reload(true);
//                        },800);
                    } else {
                        $("#info").html(data.msg);
                        $("#info_fail").modal("show");
                    }
                });
            }
        });

        $('#create').on('hidden.bs.modal', function (e) {
            createValidate.resetForm();
            $createForm[0].reset();
        });

        function submitCreateForm() {
            $createForm.submit();
        }

    </script>
</sec:authorize>
<sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_update})">
    <%--编辑资源--%>
    <div class="modal fade" id="edit" data-backdrop="static" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">编辑资源</h4>
                </div>
                <div class="modal-body">
                    <form name="editForm" class="form-horizontal">
                        <input type="hidden" name="id">
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">父级</label>
                            </div>
                            <div class="col-xs-9">
                                <input id="editPid" type="hidden" name="pid">
                                <input id="editPName" class="form-control" type="text" name="pName" readonly
                                       onclick="openTreeView(P_TYPE_EDIT)"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">键</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="key"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">名称</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="name"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">类型</label>
                            </div>
                            <div class="col-xs-9">
                                <select id="editType" name="type" class="form-control">
                                    <option value="0">菜单</option>
                                    <option value="1">功能</option>
                                    <option value="2">url</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row" id="editURL" style="display: none;">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">URL</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="url"/>
                            </div>
                        </div>
                        <div class="form-group row" id="editMethod" style="display: none;">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">请求方法</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="text" name="method"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">顺序</label>
                            </div>
                            <div class="col-xs-9">
                                <input class="form-control" type="number" name="seq"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-xs-3 text-right">
                                <label class="control-label required">记录日志</label>
                            </div>
                            <div class="col-xs-9">
                                <select id="editLog" name="log" class="form-control">
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </div>
                        </div>
                    </form>
                    <div class="clearfix"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-info" onclick="submitEditForm()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <script>

        var $editType = $("#editType");
        var $editUrl = $("#editURL");
        var $editMethod = $("#editMethod");

        $editType.on("change", function () {
            if ($editType.val() == 2) {
                $editUrl.css("display", "block");
                $editMethod.css("display", "block");
            } else {
                $editUrl.css("display", "none");
                $editUrl.val(" ");
                $editMethod.css("display", "none");
                $editMethod.val(" ");
            }
        });

        var $editForm = $("form[name='editForm']");
        var editValidate = $editForm.validate({
            errorClass: 'text-danger',
            rules: {
                pName: {
                    required: true
                },
                key: {
                    required: true,
                    notEmpty: true
                },
                name: {
                    required: true,
                    notEmpty: true
                },
                type: {
                    required: true
                },
                url: {
                    required: true,
                    notEmpty: true
                },
                method: {
                    required: true,
                    notEmpty: true
                },
                seq: {
                    required: true,
                    digits: true
                },
                log: {
                    required: true
                }
            },
            messages: {
                pName: {
                    required: "请选择父级"
                },
                key: {
                    required: "键不能为空",
                    notEmpty: "键不能为空"
                },
                name: {
                    required: "名称不能为空",
                    notEmpty: "名称不能为空"
                },
                type: {
                    required: "请选择类型"
                },
                url: {
                    required: "URL不能为空",
                    notEmpty: "URL不能为空"
                },
                method: {
                    required: "请求方法不能为空",
                    notEmpty: "请求方法不能为空"
                },
                seq: {
                    required: "顺序不能为空",
                    digits: "请填入数字"
                },
                log: {
                    required: "请选择是否记录日志"
                }
            },
            submitHandler: function (form) {
                doPost("<%=request.getContextPath()%>/admin/system/security/resource/update", $(form).serialize(), function (data) {
                    if (data.status) {
                        $("#info_success").modal("show");
                        setTimeout(function(){
                            window.location.reload(true);
                        },800);
                    } else {
                        $("#info").html(data.msg);
                        $("#info_fail").modal("show");
                    }
                });
            }
        });

        $('#edit').on('hidden.bs.modal', function (e) {
            editValidate.resetForm();
            $editType.trigger("change");
            $("#edit").find(".text-danger").removeClass("text-danger");
        });

        function edit(id) {
            doPost("<%=request.getContextPath()%>/admin/system/security/resource/find", {id: id}, function (data) {
                if (data.status) {
                    var _data = data.data;
                    $editForm.find("input[name='id']").val(_data.id);
                    $editForm.find("input[name='pid']").val(_data.pid);
                    $editForm.find("input[name='pName']").val(_data.pName);
                    $editForm.find("input[name='key']").val(_data.key);
                    $editForm.find("input[name='name']").val(_data.name);
                    $editForm.find("input[name='seq']").val(_data.seq);
                    $editForm.find("select[name='type']").val(_data.type);
                    $editForm.find("select[name='log']").val(_data.log);
                    $editType.trigger("change");
                    if (_data.type == 2) {
                        $editForm.find("input[name='url']").val(_data.url);
                        $editForm.find("input[name='method']").val(_data.method);
                    }
                    $("#edit").modal('show');
                } else {
                    $("#info").html(data.msg);
                    $("#info_fail").modal("show");
                }
            });
        }

        function submitEditForm() {
            $editForm.submit();
        }
    </script>
</sec:authorize>
<sec:authorize access="hasAnyRole(${sessionScope.sec_op.system_resource_delete})">
    <%--删除资源--%>
    <div class="modal fade" id="del" data-backdrop="static" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除资源</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-danger">确认删除该资源？</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger" onclick="submitDelete()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        var deleteId;
        function del(id) {
            deleteId = id;
            $("#del").modal('show');
        }
        function submitDelete() {
            doPost("<%=request.getContextPath()%>/admin/system/security/resource/delete", {id: deleteId}, function (data) {
                if (data.status) {
                    $("#info_success").modal("show");
                    setTimeout(function(){
                        window.location.reload(true);
                    },800);
                } else {
                    $("#info").html(data.msg);
                    $("#info_fail").modal("show");
                }
            });
        }
    </script>
</sec:authorize>

<sec:authorize
        access="hasAnyRole(${sessionScope.sec_op.system_resource_create}) or hasAnyRole(${sessionScope.sec_op.system_resource_update})">
    <div class="modal fade" id="resourceTree" data-backdrop="static" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">父级</h4>
                </div>
                <div class="modal-body">
                    <ul id="tree" class="ztree" style="overflow:auto;height: 500px"></ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-success" onclick="selectConfirm()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        var zTreeObj,
            setting = {
                data: {
                    key: {
                        children: "sons"
                    }
                },
                view: {
                    selectedMulti: false
                }
            },
            zTreeNodes = [{"name": "顶级", "id": 0, "sons":${resourceTree eq null ? "[]":resourceTree}}];

        $(document).ready(function () {
            zTreeObj = $.fn.zTree.init($("#tree"), setting, zTreeNodes);

        });

        function selectConfirm() {
            var selectedNode = zTreeObj.getSelectedNodes()[0];
            if (treeType === P_TYPE_CREATE) {
                $("#createPid").val(selectedNode.id);
                $('#createPName').val(selectedNode.name);
            } else {
                $("#editPid").val(selectedNode.id);
                $('#editPName').val(selectedNode.name);
            }
            $('#resourceTree').modal('hide');
        }

        $('#resourceTree').on('hidden.bs.modal', function (e) {
            zTreeObj.selectNode(zTreeNodes[0]);
            zTreeObj.expandAll(false);
        });
    </script>
</sec:authorize>
<jsp:include page="../../common/operationTip.jsp"/>

</body>
</html>
