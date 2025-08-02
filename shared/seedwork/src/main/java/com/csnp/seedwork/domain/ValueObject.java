package com.csnp.seedwork.domain;

import java.util.Objects;
import java.util.stream.Stream;

/**
 * Represents a base class for value objects in the domain-driven design pattern.
 * A value object is defined by its components rather than a unique identity.
 */
public abstract class ValueObject {

    //#region -- Overrides --

    /**
     * Indicates whether some other object is "equal to" this one.
     *
     * @param obj the reference object with which to compare.
     * @return {@code true} if this object is the same as the obj argument; {@code false} otherwise.
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true; // same reference
        }

        if (obj == null || this.getClass() != obj.getClass()) {
            return false;
        }

        ValueObject other = (ValueObject) obj;

        return this.getEqualityComponents()
            .map(component -> component != null ? component : NullValue.INSTANCE)
            .toList()
            .equals(
                other.getEqualityComponents()
                     .map(component -> component != null ? component : NullValue.INSTANCE)
                     .toList()
            );
    }

    /**
     * Returns a hash code value for the object.
     *
     * @return a hash code value for this object.
     */
    @Override
    public int hashCode() {
        return getEqualityComponents()
            .map(component -> component != null ? component.hashCode() : 0)
            .reduce(1, (hash, h) -> 23 * hash + h);
    }

    //#endregion

    //#region -- Methods --

    /**
     * Gets the components used to determine equality for the value object.
     * Derived classes must implement this to specify which properties form equality.
     *
     * @return a stream of components to compare.
     */
    protected abstract Stream<Object> getEqualityComponents();

    //#endregion

    //#region -- Inner Types --

    /**
     * Null placeholder for equality comparison.
     */
    private static final class NullValue {
        static final NullValue INSTANCE = new NullValue();

        @Override
        public boolean equals(Object obj) {
            return obj == null || obj instanceof NullValue;
        }

        @Override
        public int hashCode() {
            return 0;
        }
    }

    //#endregion
}
