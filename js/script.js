
window.onload = function() {
	document.getElementById("send").onclick = function() {
		if (!validateForm()) {
			return false;
		} else {
		ajaxRequest(); }
	};
};

function ajaxRequest() {
	var data = '?id_contract=' + document.getElementById("id_contract").value;
	var status = document.getElementsByName("status[]");
	
	for (var i = 0; status.length > i; i++) {
		if (status[i].checked) {
			data += "&status[" + i + "]=" + status[i].value;
		}
	}

    request = new XMLHttpRequest(); 

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			result = JSON.parse(request.responseText);
			if (result.code == 0) {
				$('#result').loadTemplate('templates/error.html', result);
			} else {
			 	$('#result').loadTemplate('templates/view.html', result);
			}
		}
	};

	request.open("GET", "app.php" + data, true);
	request.send();
}

function validateForm() {
	var regexp = /[a-zа-я]+/i;
	var id_contract = document.getElementById("id_contract").value;

	if (regexp.test(id_contract)) {
		document.getElementById("info").innerHtml = "Используйте только цифры!";
		return false;
	}

	return true;	
}
