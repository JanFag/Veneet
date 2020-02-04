<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Veneiden listaus</title>
</head>
<body>
	<span id="ilmo"></span>
	<table id="listaus">
		<thead>	
			<tr>
				<th colspan="6" class="oikealle"><span id="uusiVene">Lisää uusi vene</span></th>
				
			</tr>
			<tr>
				<th colspan="3" class="oikealle">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" id="hae" value="Hae"></th>
				
				<th></th>
			
			</tr>		
			<tr>
				<th>Nimi</th>
				<th>Merkkimalli</th>
				<th>Pituus</th>
				<th>Leveys</th>
				<th>Hinta</th>	
				<th></th>
							
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
<script>
$(document).ready(function(){
	
	$("#uusiVene").click(function(){
		document.location="lisaavene.jsp";
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeTiedot();
		  }
	});
	
	
	
	$("#hae").click(function(){	
		haeTiedot();
	});
	
	//Tässä tulee käyttää document-tason kuuntelijaa, koska poista-luokan elementit on luotu jQuerylla ja suora sidonta sivulle puuttuu
	$(document).on('click','.poista', function(){ //Ajetaan poista-luokan napin painamisella
		var obj = $(this); 	
		var tunnus = obj[0].id;		
		if(confirm("Poista vene " + obj[0].title + "?")){	
			$.post({url:"PoistaVene", data:{tunnus: tunnus}, success:function(result) {  //Tiedot kulkevat palvelimelle POST-metodilla
		        console.log(result);
				if(result==0){
		        	$("#ilmo").html("Veneen poisto epäonnistui.");
		        }else if(result==1){
		        	$("#rivi_"+tunnus).css("background-color", "lightcoral"); //Värjätään poistetun auton rivi
		        	
		        	alert("Veneen "+ obj[0].title +" poisto onnistui.");
		        	siirryViiveella();
				}
				
				
		    }});
		}
	});
	
});

function siirryViiveella(){
	setTimeout(function(){haeTiedot()},1500);
}

function haeTiedot(){	
	$("#listaus tbody").empty();
	$.getJSON({url:"ListaaVeneet", data:{hakusana: $("#hakusana").val()}, success:function(result){	
		$.each(result.veneet, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.tunnus+"'>";
        	htmlStr+="<td>"+field.nimi+"</td>";
        	htmlStr+="<td>"+field.merkkimalli+"</td>";
        	htmlStr+="<td>"+field.pituus+"</td>";
        	htmlStr+="<td>"+field.leveys+"</td>";
        	htmlStr+="<td>"+field.hinta+"</td>";
        	htmlStr+="<td><a href='muutavene.jsp?tunnus="+field.tunnus+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' id='"+field.tunnus+"' title='"+field.nimi+" "+field.merkkimalli+"'>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}
</script>
</body>
</html>