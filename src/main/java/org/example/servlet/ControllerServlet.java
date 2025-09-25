package org.example.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Сервлет контроллер, принимающий запросы пользователя и делегирующий задачи другим сервлетам
 * @author maxkarn
 */
@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String[] r = req.getParameterValues("r");

        if (x != null && y != null && r != null) {
            req.getRequestDispatcher("/area-check").forward(req, resp);
            return;
        }

        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Плохой запрос(");

    }
}
