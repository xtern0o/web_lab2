<%@ page import="org.example.dtp.ResultEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIRE BASE</title>
    <link rel="icon" type="image/x-icon" href="img/USA.png">
    <link rel="shortcut icon" type="image/x-icon" href="img/USA.png">
    <link rel="stylesheet" type="text/css" href="style/index.css">

    <link rel="stylesheet" type="text/css" href="style/toastify.min.css">
    <script type="text/javascript" src="js/toastify.min.js"></script>

    <%
        List<ResultEntry> resultsList = (ArrayList<ResultEntry>) application.getAttribute("resultsList");
    %>

</head>

<body>
    <%@ include file="templates/header.jsp"%>

    <main>
        <div class="grid-container">
            <div class="map-container">
                <h1>Map</h1>
                <div id="canvas-wrapper" class="canvas-container">
                    <canvas id="map-canvas" width="300" height="300"></canvas>
                </div>
                <p id="current_coord" style="width: 100%; text-align: center">---</p>
                <div class="inline-gallery-container">
                    <img src="img/money-6732_256.gif" width="150">
                    <img src="img/american-run.gif" width="150">
                </div>
            </div>

            <div class="form-container">
                <h1>Control unit</h1>
                <div class="control-unit-container">
                    <form id="control-form" method="get" action="controller">
                        <div class="form-grid">

                            <p>Выберите R:</p>
                            <div class="radio-container">
                                <label>
                                    <input type="checkbox" name="r" value="1">
                                    1
                                </label>
                                <label>
                                    <input type="checkbox" name="r" value="1.5">
                                    1.5
                                </label>
                                <label>
                                    <input type="checkbox" name="r" value="2">
                                    2
                                </label>
                                <label>
                                    <input type="checkbox" name="r" value="2.5">
                                    2.5
                                </label>
                                <label>
                                    <input type="checkbox" name="r" value="3">
                                    3
                                </label>
                            </div>

                            <p>Выберите X:</p>
                            <div class="radio-container">
                                <label>
                                    <input type="radio" name="x" value="-2">
                                    -2
                                </label>
                                <label>
                                    <input type="radio" name="x" value="-1.5">
                                    -1.5
                                </label>
                                <label>
                                    <input type="radio" name="x" value="-1">
                                    -1
                                </label>
                                <label>
                                    <input type="radio" name="x" value="-0.5">
                                    -0.5
                                </label>
                                <label>
                                    <input type="radio" name="x" value="0">
                                    0
                                </label>
                                <label>
                                    <input type="radio" name="x" value="0.5">
                                    0.5
                                </label>
                                <label>
                                    <input type="radio" name="x" value="1">
                                    1
                                </label>
                                <label>
                                    <input type="radio" name="x" value="1.5">
                                    1.5
                                </label>
                                <label>
                                    <input type="radio" name="x" value="2">
                                    2
                                </label>
                            </div>

                            <label for="yField"><p>Введите Y:</p></label>
                            <div class="input-wrapper">
                                <input id="yField" name="y" type="number" placeholder="от -5 до 3 (не включительно)" minlength="1" maxlength="8" step="any" required>
                            </div>
                        </div>

                        <div class="row-container" style="margin: 1rem 0">
                            <button id="clear-button" class="form-button" type="button">Очистить</button>
                            <button id="check-button" class="form-button" type="submit">Проверить</button>
                        </div>
                    </form>


                    <% if (request.getAttribute("error") != null) { %>
                    <div class="error-container">
                        <img src="img/danger-18465_256.gif" width="50">
                        <div>
                            <h2 style="text-align: center; color: #780000">Ошибка <%= request.getAttribute("status") %></h2>
                            <p id="error-info-p">Сообщение: <%= request.getAttribute("error") %></p>
                        </div>
                        <button class="close-button">">x</button>
                    </div>
                    <% } %>

                    <div id="table-h" class="inline-gallery-container" style="margin-top: 20px;">
                        <img src="img/radioactive-19946_256.gif" width="50">
                        <h1>Results</h1>
                        <img src="img/radioactive-19946_256.gif" width="50">
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
                                if (resultsList != null) {
                                    for (int i = resultsList.size() - 1; i >= 0; i--) {
                                        ResultEntry resultEntry = resultsList.get(i);
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
                </div>
            </div>
        </div>

    </main>

    <%@ include file="templates/footer.jsp"%>

    <%-- ОООХ КАКОЙ СМАЧНЫЙ КОСТЫЛЬ --%>
    <script>
        const points = [
            <%
                if (resultsList != null) {
                    for (int i = resultsList.size() - 1; i >= 0; i--) {
                        ResultEntry entry = resultsList.get(i);
            %>
            {
                x: <%= entry.coordinates().x() %>,
                y: <%= entry.coordinates().y() %>,
                r: <%= entry.coordinates().r() %>,
                hit: <%= entry.hit() %>
            }<%= (i > 0) ? "," : "" %>
            <%      }
                }
            %>
        ];
    </script>

    <script src="js/canvas.js"></script>
    <script src="js/index.js"></script>

</body>