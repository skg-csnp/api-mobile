package com.csnp.seedwork.domain.valueobjects;

import com.csnp.seedwork.domain.ValueObject;
import com.csnp.seedwork.domain.exceptions.InvalidEmailException;
import com.csnp.seedwork.domain.validators.EmailAddressValidator;

import java.util.stream.Stream;

/**
 * Represents an email address as a value object with validation logic.
 */
public final class EmailAddress extends ValueObject {

    //#region -- Overrides --

    /**
     * Gets the components used for equality comparison.
     *
     * @return a stream containing the value.
     */
    @Override
    protected Stream<Object> getEqualityComponents() {
        return Stream.of(value);
    }

    @Override
    public String toString() {
        return value;
    }

    //#endregion

    //#region -- Methods --

    /**
     * Initializes a new instance of the {@link EmailAddress} class.
     * Use {@link #create(String)} to instantiate.
     *
     * @param value The validated email address.
     */
    private EmailAddress(String value) {
        this.value = value;
    }

    /**
     * Creates a new {@link EmailAddress} instance after validating the input.
     *
     * @param email The raw email string to validate and create.
     * @return A new instance of {@link EmailAddress}.
     * @throws IllegalArgumentException   Thrown when the email is null or blank.
     * @throws InvalidEmailException      Thrown when the email format is invalid.
     */
    public static EmailAddress create(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }

        if (!EmailAddressValidator.isValid(email)) {
            throw new InvalidEmailException("Email format is invalid");
        }

        return new EmailAddress(email.trim().toUpperCase());
    }

    //#endregion

    //#region -- Properties --

    /**
     * Gets the normalized email address string.
     */
    private final String value;

    public String getValue() {
        return value;
    }

    //#endregion
}
