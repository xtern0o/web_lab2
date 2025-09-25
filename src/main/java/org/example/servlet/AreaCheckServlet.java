package org.example.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dtp.Coordinates;
import org.example.dtp.ResultEntry;
import org.example.utils.CoordinatesValidator;

import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * Сервлет, обрабатывающий полученные данные о точке и дающий ответ пользователю
 * @author maxkarn
 */
@WebServlet("/area-check")
public class AreaCheckServlet extends HttpServlet {
    CoordinatesValidator coordinatesValidator = new CoordinatesValidator();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long time = System.currentTimeMillis();
        String currentTimeUTC = Instant.now().toString();

        List<Coordinates> coordinatesList = parseCoordinates(req);

        if (!validateParsedData(coordinatesList, resp)) return;

        List<ResultEntry> newResultEntries = new ArrayList<>();
        coordinatesList.forEach(
                coordinates -> newResultEntries.add(new ResultEntry(
                        coordinates,
                        CoordinatesValidator.checkArea(coordinates),
                        System.currentTimeMillis() - time,
                        currentTimeUTC
                ))
        );

        ServletContext servletContext = getServletContext();

        synchronized (servletContext) {
            List<ResultEntry> resultsList = (List<ResultEntry>) servletContext.getAttribute("resultsList");
            if (resultsList == null) resultsList = new ArrayList<>();
            resultsList.addAll(newResultEntries);
            servletContext.setAttribute("resultsList", resultsList);
        }

        req.setAttribute("newResultEntries", newResultEntries);

        req.getRequestDispatcher("/result.jsp").forward(req, resp);
    }

    private boolean validateParsedData(List<Coordinates> coordinatesList, HttpServletResponse resp) throws IOException {
        if (coordinatesList == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Некорректные данные о точке");
            return false;
        }

        if (!coordinatesList.stream().allMatch((coordinates -> coordinatesValidator.validate(coordinates)))) {
            resp.sendError(422, "Недопустимые числа в точке");
            return false;
        }

        return true;
    }

    private List<Coordinates> parseCoordinates(HttpServletRequest req) {
        try {
            float x = Float.parseFloat(req.getParameter("x"));
            float y = Float.parseFloat(req.getParameter("y"));
            String[] rStringList = req.getParameterValues("r");
            List<Float> rList = new ArrayList<>();
            for (String rString : rStringList) {
                rList.add(Float.parseFloat(rString));
            }
            List<Coordinates> coordinatesList = new ArrayList<>();
            for (float r : rList) {
                coordinatesList.add(new Coordinates(x, y, r));
            }
            return coordinatesList;
        } catch (NumberFormatException numberFormatException) {
            return null;
        }
    }
}
