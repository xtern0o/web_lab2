package org.example.utils;

import java.util.function.Predicate;

/**
 * Абстрактный класс валидатора на предикате
 * @param <T> валидируемый класс
 * @author maxkarn
 */
public abstract class Validator<T> {
    private Predicate<T> validatePredicate;

    public Validator(Predicate<T> predicate) {
        validatePredicate = predicate;
    }

    public Predicate<T> getValidatePredicate() {
        return validatePredicate;
    }

    public void setValidatePredicate(Predicate<T> validatePredicate) {
        this.validatePredicate = validatePredicate;
    }

    public boolean validate(T obj) {
        return validatePredicate.test(obj);
    }
}