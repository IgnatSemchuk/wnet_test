<?php
include_once('class/class.customer.php');

try {
	$db = DateBase::getDB();
	$id_contract = !empty($_GET['id_contract']) ? $db->escape($_GET['id_contract']) : null;
	$status = isset($_GET['status']) ? $_GET['status'] : array();
	if (is_null($id_contract)) {
		throw new MyException("Вы не ввели ID договора", 0);
	}
	$customer = Customer::getCustomer($id_contract, $status);
	echo json_encode($customer->getJsonData());
} catch (Exception $e) {
	echo json_encode($e->getJsonData());
}



