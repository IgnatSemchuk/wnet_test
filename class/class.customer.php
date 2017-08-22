<?php
/**
* 
*/
class MyException extends Exception
{
    public function getJsonData()
    {
        $var = get_object_vars($this);
        return $var;
    }
}


/**
* Класс одиночка для работы с базой данных
*/
final class DateBase
{
    private static $db = null;   //одиночка экземпляр класса DataBase
    private $connection;         //соединение с базой данных

    /* Все магические методы закрываем */
    private function __clone()
    {}

    private function __sleep()
    {}

    private function __wakeup()
    {}
    
    private function __construct()
    {
        $this->connection = new mysqli('localhost', 'root', '', 'wnet');
        if($this->connection->connect_error) {
            throw new MyException("Ошибка подключения к БД ({$this->connection->connect_errno}) {$this->connection->connect_error}", 0);
        }
        $this->connection->set_charset('utf8');
    }

    public static function getDB()
    {
        if (is_null(self::$db)) {
            self::$db = new self();
        }
        return self::$db;
    }

    public function query($sql) {
        if ($this->connection->connect_error) {
            throw new MyException("Связь с БД потеряна ({$this->connection->connect_errno}) {$this->connection->connect_error}", 0);
        }
        $result = $this->connection->query($sql);
        if ($this->connection->error) {
            throw new MyException("Ошибка выполнения запроса к БД ({$this->connection->errno}) {$this->connection->error}", 0);
        }
        if (is_bool($result)) {
            return $result;
        }
        $data = $result->fetch_all(MYSQLI_ASSOC);
        $result->free();
        return $data;
    }

    public function escape($str) {
        return $this->connection->real_escape_string($str);
    }

    /* При уничтожении объекта закрывается соединение с базой данных */
    public function __destruct()
    {
        if ($this->connection) {
            $this->connection->close();
        }
    }

}


class Customer
{
    private static $customers = array();

    private $name_customer;
    private $company;
    private $number;
    private $date_sign;
    private $services;

    private function __construct(array $data)
    {
        $this->name_customer = $data['name_customer'];
        $this->company = $data['company'];
        $this->number = $data['number'];
        $this->date_sign = $data['date_sign'];
        $this->services = $data['services'];
    }

    private function __clone()
    {}

    private function __sleep()
    {}

    private function __wakeup()
    {}

    public static function getCustomer ($id_contract, $status)
    {
        $db = DateBase::getDB();
        $sql = "SELECT id_customer
            FROM obj_contracts
            WHERE id_contract = " . $id_contract;
        $result = $db->query($sql);
        if (empty($result)) {
            throw new MyException("Договора с ID {$id_contract} не существует!", 0);
        }
        $id_customer = $result[0]['id_customer'];
        if (isset(self::$customers[$id_customer])) {
            return self::$customers[$id_customer];
        }

        $sql = "SELECT cus.name_customer, cus.company, con.number, con.date_sign, GROUP_CONCAT(ser.title_service SEPARATOR '<br />') as services
            FROM obj_customers cus JOIN
                (obj_contracts con JOIN obj_services ser
                 ON con.id_contract = ser.id_contract)
            ON con.id_customer = cus.id_customer
            WHERE ser.status IN (" . "'" . implode("', '", $status) . "'" . ") AND con.id_contract = {$id_contract}";
        $result = $db->query($sql);
        self::$customers[$id_customer] = new Customer($result[0]);
        return self::$customers[$id_customer];
    }

    public function getJsonData() {
        $var = get_object_vars($this);
        foreach ($var as &$value) {
            if (is_object($value) && method_exists($value,'getJsonData')) {
                $value = $value->getJsonData();
            }
        }
        return $var;
    }

    public function getName()
    {
        return $this->name_customer;
    }
    
    public function getCompany()
    {
        return $this->company;
    }

    public function getNumberContract()
    {
        return $this->number;
    }    

    public function getDataSing()
    {
        return $this->data_sign;
    }

    public function getServices()
    {
        return $this->services;
    }   
}
