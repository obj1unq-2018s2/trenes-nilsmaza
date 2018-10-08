


class Locomotora {
	
	var property peso
	var property pesoMaximoDeArrastre
	var property velocidadMaxima
	
	
	
	}


class VagonDePasajeros{
	
	var property largo = 0
	var property ancho = 0
	var cantidadDePasajerosMaximo = 0
	
	method cantidadDePasajerosATransportar(){
		if(ancho < 2.5 )  cantidadDePasajerosMaximo = largo * 8
		else cantidadDePasajerosMaximo = largo * 8	
	}
	
	method asignarLargo(largoDelV){
		 ancho =largoDelV
	}

		method asignarAncho(anchoDelV){
		 ancho =anchoDelV
	}
	
	method pesoMaximo(){
		return cantidadDePasajerosMaximo * 80
	} 
}


class VagonDeCarga{
	
	var property cargaMaxima = 0
	
	method pesoMaximo(){
		return cargaMaxima + 160
	} 

	}
	
	
	
	
