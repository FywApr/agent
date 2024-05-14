<?php
// Задаем доступ + обработка ошибки
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Method: GET");
header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] != "GET") {
  echo '{"result": false, "message": "Неверный формат запроса"}';
}

$url = 'http://test.test/ws_test/hs/ws/ws_test/';

$options = array(
    'http' => array(
        'method' => 'GET',
        'header' => "Content-Type: application/json\r\n" .
                    "Origin: http://localhost:3000\r\n" . // Заголовок Origin для CORS
                    "Access-Control-Request-Method: GET\r\n" // Заголовок Access-Control-Request-Method для CORS preflight request
    )
);

$context = stream_context_create($options);
$result = file_get_contents($url, false, $context);

if ($result === FALSE) {
    // Обработка ошибки
    echo "Ошибка при выполнении запроса";
} else {
    // Обработка успешного ответа
    echo $result;
}