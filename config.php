<?php
unset($CFG);
global $CFG;
$CFG = new stdClass();
$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv('DB_HOST') ?: 'db';
$CFG->dbname    = getenv('DB_NAME') ?: 'moodle';
$CFG->dbuser    = getenv('DB_USER') ?: 'moodle';
$CFG->dbpass    = getenv('DB_PASS') ?: 'moodle';
$CFG->prefix    = getenv('DB_PREFIX') ?: 'mdl_';
$CFG->dboptions = ['dbpersist' => 0, 'dbport' => 3306, 'dbcollation' => 'utf8mb4_unicode_ci'];
$CFG->wwwroot   = getenv('WWWROOT') ?: 'http://localhost:8080';
$CFG->dataroot  = '/var/www/moodledata';
$CFG->admin     = 'admin';
$CFG->directorypermissions = 0777;
require_once(__DIR__ . '/lib/setup.php');
