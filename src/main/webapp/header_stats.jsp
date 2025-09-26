<%@ page import="java.util.*" %>
<%@ page import="org.example.filter.HeaderCountFilter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Header count</title>
    <link rel="icon" type="image/x-icon" href="img/USA.png">
    <link rel="shortcut icon" type="image/x-icon" href="img/USA.png">
    <link rel="stylesheet" type="text/css" href="style/index.css">

    <link rel="stylesheet" type="text/css" href="style/toastify.min.css">
</head>
<body>
    <%
        Map<String, Long> headersStat = (HashMap<String, Long>) application.getAttribute(HeaderCountFilter.HEADERS_COUNT_ATTRIBUTE);
        List<Map.Entry<String, Long>> entryList = new ArrayList<>();
        if (headersStat != null) {
            entryList.addAll(headersStat.entrySet());
            entryList.sort(Map.Entry.<String, Long>comparingByValue().reversed());
        }
    %>

    <%@ include file="templates/header.jsp" %>

    <main>
        <div class="stats-page-container">
            <h1>Сколько раз мы встретили разные заголовки?</h1>
            <% if (headersStat != null) { %>
            <table>
                <thead>
                <tr>
                    <th>Заголовок</th>
                    <th>Количество раз</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Map.Entry<String, Long> entry : entryList) {
                %>

                <tr>
                    <th class="table-row"><%= entry.getKey() %></th>
                    <th class="table-row"><%= entry.getValue() %></th>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <% } else { %>
            <p style="text-align: center; width: 100%">походу нету заголововков это как</p>
            <% } %>

            <a class="classic-link" href="<%= request.getContextPath() %>">< вернуться к форме ввода</a>

        </div>
    </main>

    <%@ include file="templates/footer.jsp" %>
</body>
</html>
