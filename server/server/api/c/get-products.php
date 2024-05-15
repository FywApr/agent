<?php
// Задаем доступ + обработка ошибки
require_once("..".DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."database".DIRECTORY_SEPARATOR."database.php");
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
    $assoc_array = json_decode($result, JSON_UNESCAPED_UNICODE);
    foreach($assoc_array as $obj) {
        $sql = 'INSERT INTO `smak`.`products`(`id`,`catalog_id`,`sub_catalog_id`,`brand_id`,`name`,`description`,`price`,`compound`,`image_path`,`exp_date`,`exp_type`,`country`,`unit`,`capacity`,`sale`,`promo`,`total_price`) VALUES (DEFAULT, '.$obj["catalog_id"].', '.$obj["sub_catalog_id"].', '.$obj["brand_id"].', "'.$obj["name"].'", "'.$obj["description"].'", '.$obj["price"].', "'.$obj["compound"].'", "'.$obj["image_path"].'", '.$obj["exp_date"].', "'.$obj["exp_type"].'", "'.$obj["country"].'", "'.$obj["unit"].'", '.$obj["capacity"].', '.$obj["sale"].', '.$obj["promo"].', '.$obj["total_price"].')';

        $database->query($sql);
    }
    echo true;
}   