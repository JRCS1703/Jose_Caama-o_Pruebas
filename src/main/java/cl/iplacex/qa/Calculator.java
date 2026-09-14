package cl.iplacex.qa;

public final class Calculator {
    public int sum(int a, int b) {
        return Math.addExact(a, b);
    }

    public int subtract(int a, int b) {
        return Math.subtractExact(a, b);
    }
}
