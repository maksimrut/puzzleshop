<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="abs">${pageContext.request.contextPath}</c:set>

<fmt:setLocale value="${sessionScope.locale}"/>
<fmt:setBundle basename="/localization/locale"/>

<fmt:message key="user_management.title" var="title"/>
<fmt:message key="user_management.manager_creation" var="new_manager_adding"/>
<fmt:message key="user_management.manager_modal_title" var="manager_modal_title"/>
<fmt:message key="user_management.user_activation" var="activation"/>
<fmt:message key="user_management.user_archiving" var="archiving"/>
<fmt:message key="user_management.user_deletion" var="deletion"/>
<fmt:message key="user_management.action_result_positive_message" var="positive_action_message"/>
<fmt:message key="user_management.action_result_negative_message" var="negative_action_message"/>
<fmt:message key="user_management.registration_result_positive_message" var="registration_result_positive_message"/>
<fmt:message key="user_management.registration_result_negative_message" var="registration_result_negative_message"/>
<fmt:message key="user_management.user_search_result_negative_message" var="negative_user_search_message"/>
<fmt:message key="registration.title" var="registration_title"/>
<fmt:message key="registration.login" var="login"/>
<fmt:message key="registration.password" var="psw"/>
<fmt:message key="registration.confirm_password" var="confirm_psw"/>
<fmt:message key="registration.email" var="email"/>
<fmt:message key="registration.mobile_number" var="mobile_number"/>
<fmt:message key="registration.sign_up_2" var="sign_up"/>

<!DOCTYPE html>
<html lang="en">
<%@include file="../fragment/header.jsp" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

    <%--    <script src="${abs}/js/message.js"></script>--%>
    <%--    <link rel="stylesheet" href="${abs}/css/registration.css">--%>
    <title>${title}</title>
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<div class="container-fluid">
    <form action="${abs}/controller" method="post">
        <input type="hidden" name="command" value="user_list_action_command">
        <div class="container text-center">
            <button type="button" data-toggle="modal" data-target="#create-manager-modal" class="btn btn-primary">
                <span class="glyphicon glyphicon-plus-sign"></span> ${new_manager_adding}
            </button>
            <button type="submit" name="action" value="unblock" class="btn btn-success">
                <span class="glyphicon glyphicon-ok-sign"></span> ${activation}
            </button>
            <button type="submit" name="action" value="block" class="btn btn-warning">
                <span class="glyphicon glyphicon-remove-sign"></span> ${archiving}
            </button>
            <button type="submit" name="action" value="delete" class="btn btn-danger">
                <span class="glyphicon glyphicon-minus-sign"></span> ${deletion}
            </button>
        </div>
        <c:choose>
            <c:when test="${param.user_action_result eq 'true'}">
                <div class="alert alert-success confirmation-message" id="message"><b class="valid_message">${positive_action_message}</b></div>
            </c:when>
            <c:when test="${param.user_action_result eq 'false'}">
                <div class="alert alert-warning confirmation-message" id="message"><b class="invalid_message">${negative_action_message}</b></div>
            </c:when>
            <c:when test="${param.registration_result eq 'true'}">
                <div class="alert alert-success confirmation-message" id="message"><b class="valid_message">${registration_result_positive_message}</b></div>
            </c:when>
            <c:when test="${param.registration_result eq 'false'}">
                <div class="alert alert-warning confirmation-message long-message" id="message"><b class="invalid_message">${registration_result_negative_message}</b></div>
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${not users.isEmpty()}">1234567890</c:when>
            <c:otherwise>${negative_user_search_message}</c:otherwise>
        </c:choose>
    </form>
    <div class="row center-block">
    </div>
    <div id="create-manager-modal" class="modal fade">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">${registration_title}</h4>
                </div>
                <div class="modal-body">
                    <form action="${abs}/controller" method="post" id="manager-form">
                        <input type="hidden" name="command" value="registration_command">
                        <input type="hidden" name="role" value="manager">
                        <div class="form-group">
                            <label for="login">${login}</label>
                            <input type="text" id="login" class="form-control" name="login">
                        </div>
                        <div class="form-group">
                            <label for="psw">${psw}</label>
                            <input type="password" id="psw" class="form-control" name="password">
                        </div>
                        <div class="form-group">
                            <label for="confirm_psw">${confirm_psw}</label>
                            <input type="password" id="confirm_psw" class="form-control" name="confirm_password">
                        </div>
                        <div class="form-group">
                            <label for="email">${email}</label>
                            <input type="email" id="email" class="form-control" name="email_address">
                        </div>
                        <div class="form-group">
                            <label for="mobile_number">${mobile_number}</label>
                            <input type="tel" id="mobile_number" class="form-control" name="mobile_number">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" form="manager-form" class="btn btn-secondary" data-bs-dismiss="modal">${sign_up}</button>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>
</body>

<%@include file="../fragment/footer.jsp" %>
</html>