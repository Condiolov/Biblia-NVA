<?php
###################################################################################
# Script : index.php
# Versão : 1.0 (/var/www/html/biblianva/index.php)
# Autor  : Thiago Condé
# Data   : 2022-03-16 21:39:07
# Info   : Index.php para exibição da biblia NVA completa, para impressão e salvamento em PDF
###################################################################################

//conexão
$servername = "localhost";
$username = "usuario";
$password = "senha";
$bd = "meuBD";
function conectar(){
	global $servername,$bd,$username, $password,$conn;
	try {
		$conn = new \PDO("mysql:host=$servername;dbname=$bd;", $username, $password, array(\PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"));
		$conn->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
	}catch(\PDOException $e){
		echo "Connection failed: " . $e->getMessage();
	}
	return $conn;
}


$livro=array("","Gênesis","Êxodo","Levítico","Números","Deuteronômio","Josué","Juízes","Rute","1 Samuel","2 Samuel","1 Reis","2 Reis","1 Crônicas","2 Crônicas","Esdras","Neemias","Ester","Jó","Salmos","Provérbios","Eclesiastes","Cânticos","Isaías","Jeremias","Lamentações","Ezequiel","Daniel","Oséias","Joel","Amós","Obadias","Jonas","Miquéias","Naum","Habacuque","Sofonias","Ageu","Zacarias","Malaquias","Mateus","Marcos","Lucas","João","Atos","Romanos","1 Coríntios","2 Coríntios","Gálatas","Efésios","Filipenses","Colossenses","1 Tessalonicenses","2 Tessalonicenses","1 Timóteo","2 Timóteo","Tito","Filemom","Hebreus","Tiago","1 Pedro","2 Pedro","1 João","2 João","3 João","Judas","Apocalipse");


$conn = conectar();
$tabela ="bibliaNVA";
$capitulo = "";
$controle_capitulo ="";
$controle_livro = "";
$mostra_versos = $conn->query("SELECT * FROM `$tabela`");
// $mostra_versos = $conn->query("show create table `$tabela`");

// var_dump( $mostra_versos->fetch(PDO::FETCH_ASSOC));
// exit;

echo "
<style>
#c {
font-size: 4rem;
height: 4rem;
font-weight: bold;
float: left;
margin: 1px 1px;
}
h1 {
font-size: 50px;
text-align: center;
margin-bottom: 1rem;
}
body {
text-align: justify;

}
</style>
";

while($resp =$mostra_versos->fetch(PDO::FETCH_ASSOC)){

	if ($controle_livro != $resp['n_livro'] ){
		$titulo= "<h1 id='livro". $resp['n_livro'] ."'>" .$livro[$resp['n_livro']]. "</h1>";
		$controle_livro = $resp['n_livro'];
	}else
		$titulo = "";

	if ($controle_capitulo != $resp['n_capitulo'] ){
		$capitulo = "<br><p id='c'>" . $resp['n_capitulo'] . "</p>";
		$controle_capitulo = $resp['n_capitulo'];
	}else
		$capitulo =  "";



	echo  $titulo . $capitulo . "<sup>" . $resp['n_versiculo'] . "</sup>" . str_replace(array("Yahweh","Jesus","Deus","Cristo","Senhor"), array("<b>Yahweh</b>","<b>Jesus</b>","<b>Deus</b>","<b>Cristo</b>","<b>Senhor</b>"), $resp['versiculo']);


}


?>
