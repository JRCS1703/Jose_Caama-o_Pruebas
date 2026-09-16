package cl.iplacex.qa;

import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class LoginServiceIT {

    @Test
    void shouldAuthenticateValidUserAndRejectInvalidCredentials() {
        LoginService service = new LoginService(Map.of("qa.user", "Secr3t!"));

        assertTrue(service.authenticate("qa.user", "Secr3t!"));
        assertFalse(service.authenticate("qa.user", "incorrecta"));
        assertFalse(service.authenticate("desconocido", "Secr3t!"));
    }
}
