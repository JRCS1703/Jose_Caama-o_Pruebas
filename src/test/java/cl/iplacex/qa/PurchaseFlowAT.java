package cl.iplacex.qa;

import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Acceptance test representativo: un usuario válido debe poder autenticarse
 * antes de continuar con un flujo de negocio protegido.
 */
class PurchaseFlowAT {

    @Test
    void authenticatedUserCanEnterProtectedFlow() {
        LoginService service = new LoginService(Map.of("cliente", "Compra123!"));

        boolean authenticated = service.authenticate("cliente", "Compra123!");

        assertTrue(authenticated, "El usuario válido debe superar el acceptance gate");
    }
}
