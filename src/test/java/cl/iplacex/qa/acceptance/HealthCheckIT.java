package cl.iplacex.qa.acceptance;

import org.junit.jupiter.api.Test;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HealthCheckIT {
    @Test
    void stagingShouldRespondSuccessfully() throws Exception {
        String baseUrl = System.getenv().getOrDefault("BASE_URL", "http://localhost:8080");
        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(5))
                .build();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(baseUrl + "/actuator/health"))
                .timeout(Duration.ofSeconds(10))
                .GET()
                .build();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        assertEquals(200, response.statusCode(),
                "El ambiente de pruebas debe responder HTTP 200 en /actuator/health");
    }
}
