package org.example.utils;

import org.example.dtp.Coordinates;

import java.util.Set;
import java.util.function.Predicate;

/**
 * Валидатор координат
 * @author maxkarn
 */
public class CoordinatesValidator extends Validator<Coordinates> {
    public CoordinatesValidator() {
        super((coordinates) ->  (Set.of(-2F, -1.5F, -1F, -0.5F, 0F, 0.5F, 1F, 1.5F, 2F).contains(coordinates.x())) &&
                                (-5 < coordinates.y() && coordinates.y() < 3) &&
                                (Set.of(1F, 1.5F, 2F, 2.5F, 3F).contains(coordinates.r())));
    }

    /**
     * Проверка принадлежности точке к площади согласно варианту
     * @param coordinates координаты и радиус
     * @return true если внутри, false если вне площади
     */
    public static boolean checkArea(Coordinates coordinates) {
        float x = coordinates.x(), y = coordinates.y(), r = coordinates.r();
        if (x > 0 && y > 0) {
            if (y > -x + (r / 2)) return false;
        } else if (x <= 0 && y > 0) {
            if (y > r || x > r) return false;
        } else if (x <= 0 && y <= 0) {
            return false;
        } else if (x > 0 && y <= 0) {
            if (x * x + y * y > (r / 2) * (r / 2)) return false;
        }
        return true;
    }
}