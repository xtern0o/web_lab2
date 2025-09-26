package org.example.utils;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Валидатор данных из запроса. Проверяет их наличие
 */
public class RequestDataValidator extends Validator<HttpServletRequest> {
    public RequestDataValidator() {
        super((req) -> {
            String x = req.getParameter("x");
            String y = req.getParameter("y");
            String[] r = req.getParameterValues("r");

            return x != null && y != null && r != null;
        });
    }
}
