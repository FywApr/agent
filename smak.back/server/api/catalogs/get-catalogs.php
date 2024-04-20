<?php
// Задаем доступ + обработка ошибки
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Method: GET");
header("Content-Type: application/json");
if ($_SERVER["REQUEST_METHOD"] != "GET") {
  header("HTTP/1.1 400 Bad request");
  echo '{"result": false, "message": "Неверный формат запроса"}';
}

// Запрос к БД
require_once(".." . DIRECTORY_SEPARATOR . ".." . DIRECTORY_SEPARATOR . "database" . DIRECTORY_SEPARATOR . "database.php");

$sql = 'SELECT `catalogs`.`id`, `catalogs`.`name`, `catalogs`.`image` FROM `smak`.`catalogs`';
$query = $database->query($sql);
$arr = [];
while ($row = $query->fetch_assoc()) {
  $arr[] = $row;
}
$query->close();
$database->close();

echo json_encode($arr, JSON_UNESCAPED_UNICODE);
exit;
