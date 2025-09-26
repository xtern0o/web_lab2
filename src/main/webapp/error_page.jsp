<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ошибка <%= request.getAttribute("javax.servlet.error.status_code") %></title>
    <link rel="icon" type="image/x-icon" href="img/USA.png">
    <link rel="shortcut icon" type="image/x-icon" href="img/USA.png">
    <link rel="stylesheet" type="text/css" href="style/index.css">
</head>

<body>
    <%@ include file="templates/header.jsp"%>

    <main>
        <div class="result-page-container">
            <div class="error-container">
                <img src="img/danger-18465_256.gif" width="50">
                <div>
                    <h2 style="text-align: center; color: #780000">Ошибка <%= request.getAttribute("jakarta.servlet.error.status_code") %></h2>
                    <p id="error-info-p">Сообщение: <%= request.getAttribute("jakarta.servlet.error.message") %></p>
                </div>
            </div>
            <a class="classic-link" href="<%= request.getContextPath() %>">< вернуться к форме ввода</a>
        </div>
    </main>

    <%@ include file="templates/footer.jsp"%>
</body>