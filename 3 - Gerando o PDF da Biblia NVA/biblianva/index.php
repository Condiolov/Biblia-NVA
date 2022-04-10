<?php
###################################################################################
# Script : index.php
# Versão : 1.0 (/var/www/html/biblianva/index.php)
# Autor  : Thiago Condé
# Data   : 2022-03-16 21:39:07
# Info   : Index.php para exibição da biblia NVA completa, para impressão e salvamento em PDF
# Modif. : Adicionado a capa e os link
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

// $mostra_versos = $conn->query("show create table `$tabela`");
// var_dump( $mostra_versos->fetch(PDO::FETCH_ASSOC));
// exit;

include('capa.html');

# criação do menu dos livros
$menu = "<br>";
foreach ($livro as $i => $v) {
	$menu .= "<a href='#ir_".$i."'>$v</a> ";
}

# criação do menu dos capitulos
$menu_cap="";
$indices = $conn->query("SELECT MAX(n_capitulo) FROM `$tabela` GROUP BY n_livro");
$indices=$indices->fetchAll(PDO::FETCH_COLUMN); // pego o numero maximo de versiculos

echo "<div id='biblia'>";

$mostra_versos = $conn->query("SELECT * FROM `$tabela`");
while($resp =$mostra_versos->fetch(PDO::FETCH_ASSOC)){

	if ($controle_livro != $resp['n_livro'] ){
		$menu_cap ="";
		if ($indices[$resp['n_livro']-1]>3){ // indice apenas para livros com mais de 3 capitulos
			for ($x = 1; $x <= $indices[$resp['n_livro']-1]; $x++)
				$menu_cap .= "<a href='#ir_". ($resp['n_livro']) ."_".$x."'>$x</a> ";

			$menu_cap .= "<br>";
		}

		$titulo=  "<div style=\"page-break-before: always;\">". $menu ."</div><h1 id='ir_". $resp['n_livro'] ."'>" .$livro[$resp['n_livro']]. "</h1> $menu_cap";
		$controle_livro = $resp['n_livro'];
	}else
		$titulo = "";

	if ($controle_capitulo != $resp['n_capitulo'] ){
		$capitulo = "<br><p class='c' id='ir_".$resp['n_livro']."_".$resp['n_capitulo']."'>" . $resp['n_capitulo'] . " </p>";
		$controle_capitulo = $resp['n_capitulo'];
	}else
		$capitulo =  "";



	echo  $titulo . $capitulo . "<sup>" . $resp['n_versiculo'] . "</sup>" . str_replace(array("Yahweh","Jesus","Deus","Cristo","Senhor"), array(" <b>Yahweh</b>"," <b>Jesus</b>"," <b>Deus</b>"," <b>Cristo</b>"," <b>Senhor</b>"), $resp['versiculo']). " ";

	//  	if ($resp["n_capitulo"]==10){echo "</div>";exit;}

}

echo '<div style="page-break-before: always;"></div><h1>BibliaNVA gerada por BOT da <a href="https://condtec.com.br">condtec.com.br</a></h1>';
echo "</div>";
?>
