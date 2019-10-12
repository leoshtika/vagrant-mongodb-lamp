<?php

require 'vendor/autoload.php';

$client = new MongoDB\Client("mongodb://localhost:27017");

echo '<pre>';
foreach ($client->listDatabases() as $databaseInfo) {
    var_dump($databaseInfo);
}