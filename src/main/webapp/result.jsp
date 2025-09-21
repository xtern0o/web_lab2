<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.dtp.ResultEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIRE BASE</title>
    <link rel="icon" type="image/x-icon" href="img/USA.png">
    <link rel="shortcut icon" type="image/x-icon" href="img/USA.png">
    <link rel="stylesheet" type="text/css" href="style/index.css">
</head>

<body>
<%@ include file="templates/header.jsp"%>

<%
    List<ResultEntry> newResultEntries = ((ArrayList<ResultEntry>) request.getAttribute("newResultEntries"));
%>

<main>
    <div class="result-page-container">
        <div class="inline-gallery-container" style="margin-top: 20px;">
            <img src="img/cowboy-395_256.gif" width="75">
            <h1>Shot result</h1>
            <img src="img/cowboy-395_256.gif" width="75">
        </div>
        <table id="results-table">
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Результат</th>
                <th>Текущее время</th>
                <th>Время работы</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (newResultEntries != null) {
                    for (int i = newResultEntries.size() - 1; i >= 0; i--) {
                        ResultEntry resultEntry = newResultEntries.get(i);
            %>
                    <tr>

                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.coordinates().x() %></th>
                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.coordinates().y() %></th>
                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.coordinates().r() %></th>
                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.hit() ? "<p style=\"color: green;\"><b>HIT</b></p>" : "<p style=\"color: red\"><b>MISS</b></p>" %></th>
                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.timeUTC() %></th>
                        <th class="table-row" style="background-color: <%= resultEntry.hit() ? "rgba(0, 128, 0, 0.3)" : "rgba(128, 0, 0, 0.3)" %>"><%= resultEntry.timeCompletion() + " мс" %></th>
                    </tr>
                <% } %>
            <% } %>
            </tbody>
        </table>
        <a class="classic-link" href="<%= request.getContextPath() %>">< вернуться к форме ввода</a>
    </div>
</main>

<%@ include file="templates/footer.jsp"%>
</body>