package org.example.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.utils.RequestDataValidator;

import java.io.IOException;

/**
 * Сервлет контроллер, принимающий запросы пользователя и делегирующий задачи другим сервлетам
 * @author maxkarn
 */
@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    private final RequestDataValidator requestDataValidator = new RequestDataValidator();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (requestDataValidator.validate(req)) {
            req.getRequestDispatcher("/area-check").forward(req, resp);
            return;
        }

        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Плохой запрос(");

    }
}
