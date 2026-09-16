package cl.iplacex.qa;

import java.util.Map;
import java.util.Objects;

/**
 * Servicio de autenticación en memoria usado para pruebas de integración y aceptación.
 */
public final class LoginService {
    private final Map<String, String> users;

    public LoginService(Map<String, String> users) {
        this.users = Map.copyOf(Objects.requireNonNull(users, "users no puede ser null"));
    }

    public boolean authenticate(String username, String password) {
        if (username == null || password == null || username.isBlank() || password.isBlank()) {
            return false;
        }
        return password.equals(users.get(username));
    }
}
