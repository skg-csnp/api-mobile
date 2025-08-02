package com.csnp.seedwork.domain.validators;

import java.util.regex.Pattern;

/**
 * Provides validation logic for email address format.
 */
public final class EmailAddressValidator {

    //#region -- Methods --

    /**
     * Determines whether the specified email is in a valid format.
     *
     * @param email The email string to validate.
     * @return {@code true} if the format is valid according to the defined email pattern; otherwise, {@code false}.
     * @implNote This uses a simplified regular expression and may not cover all edge cases of valid email formats defined by RFC 5322.
     */
    public static boolean isValid(String email) {
        return EMAIL_PATTERN.matcher(email).matches();
    }

    //#endregion

    //#region -- Constants --

    /**
     * The regular expression pattern used to validate basic email address format.
     */
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");

    //#endregion

    //#region -- Constructors --

    private EmailAddressValidator() {
        // Prevent instantiation
    }

    //#endregion
}
