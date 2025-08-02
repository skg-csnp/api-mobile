package com.csnp.seedwork.domain.exceptions;

/**
 * Exception thrown when an email address is in an invalid format.
 */
public class InvalidEmailException extends RuntimeException {

    //#region -- Constructors --

    /**
     * Initializes a new instance of the {@code InvalidEmailException} class with a specified error message.
     *
     * @param message The message that describes the error.
     */
    public InvalidEmailException(String message) {
        super(message);
    }

    //#endregion
}