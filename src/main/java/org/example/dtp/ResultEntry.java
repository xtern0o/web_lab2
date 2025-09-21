package org.example.dtp;

/**
 * Результат удара, отправляемый пользователю
 * @param coordinates координаты с радиусом
 * @param hit ПОПАЛ или НЕ ПОПАЛ
 * @param timeCompletion время выполнения скрипта
 * @param timeUTC время получения запроса
 */
public record ResultEntry(
        Coordinates coordinates,
        boolean hit,
        long timeCompletion,
        String timeUTC
) {
}
