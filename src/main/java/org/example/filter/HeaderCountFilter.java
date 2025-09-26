package org.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebFilter("/*")
public class HeaderCountFilter implements Filter {
    private ServletContext servletContext;
    public static final String HEADERS_COUNT_ATTRIBUTE = "headersCount";


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        servletContext = filterConfig.getServletContext();
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        collectHeadersStat((HttpServletRequest) request);

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }

    /**
     * Обновление статистики по полученным заголовкам
     * @param req реквестик)
     */
    private synchronized void collectHeadersStat(HttpServletRequest req) {
        Map<String, Long> headersCount = (Map<String, Long>) servletContext.getAttribute(HEADERS_COUNT_ATTRIBUTE);
        if (headersCount == null) headersCount = new HashMap<>();
        Map<String, Long> finalHeadersCount = headersCount;


        Enumeration<String> currentHeaders = req.getHeaderNames();
        currentHeaders.asIterator().forEachRemaining(
                (header) -> finalHeadersCount.put(header, finalHeadersCount.getOrDefault(header, 0L) + 1)
        );

        servletContext.setAttribute(HEADERS_COUNT_ATTRIBUTE, finalHeadersCount);
    }
}
