<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
<form id="tiedot">
<table>
	<thead>
		<tr>
			<th colspan="6" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
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
		<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>			
			<td><input type="submit" id="tallenna" value="Lisää"></td>
		</tr>
	</tbody>
</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function(){
		
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});
		
		
	$("#tiedot").validate({						
		rules: {
			nimi:  {
				required: true,				
				minlength: 2				
			},	
			merkkimalli:  {
				required: true,				
				minlength: 2				
			},
			pituus:  {
				required: true
				
			},	
			leveys:  {
				required: true
								
			},
			hinta:  {
				required: true
								
			}	
		},
		messages: {
			nimi: {     
				required: "Puuttuu",				
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Puuttuu",				
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu"
				
			},
			leveys: {
				required: "Puuttuu"
				
			},
			hinta: {
				required: "Puuttuu"
				
			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}		
	});   
	$("#nimi").focus();
});

function siirryViiveella(){
	setTimeout(function(){document.location="listaaveneet.jsp"},1500);
}

function lisaaTiedot(){
	$.post({url:"LisaaVene", data:$("#tiedot").serialize(), success:function(result) {  //Tiedot kulkevat palvelimelle POST-metodilla
        if(result==0){
        	$("#ilmo").html("Veneen lisääminen epäonnistui.");
        }else if(result==1){			
        	$("#ilmo").html("Veneen lisääminen onnistui.");
        	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
        	siirryViiveella();
		}
    }});	
}
</script>
</body>
</html>