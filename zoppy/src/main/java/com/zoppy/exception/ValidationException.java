package com.zoppy.exception;

public class ValidationException extends Exception{
    private final String errorMessage;

    public ValidationException(String errorMessage) {
        super(errorMessage);
        this.errorMessage = errorMessage;
    }

    public String getErrorMessage() {
        return errorMessage;
    }
}
