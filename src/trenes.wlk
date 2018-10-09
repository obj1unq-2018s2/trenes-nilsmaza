


class Formacion {
	
	var property locomotora
	var property vagones 
	

	method vagonMasPesado(){
		return vagones.max{elem => elem.pesoMaximo() }
	}
	
	method engancharVagon(vagon){
		vagones.add(vagon)
	}
	
	method desengacharrVagon(vagon){
		vagones.remove(vagon)
	}
	
	method pesoTotal(){
		 return vagones.sum{ elem => elem.pesoMaximo() }
	}
	
	method pesoTotalLocomotora(){
		 return locomotora.sum{ elem => elem.pesoMaximo() }
	}
	
	method pesoDeCargaLocomotora(){
		 return locomotora.sum{ elem => elem.cargaMaximaActual() }
	}
	
	method formacionEficiente(){
		return vagones.all{ elem => elem.pesoMaximo() > self.pesoTotalLocomotora()  }
	}
	
	method vagonesLivianos(){
		 return vagones.filter{ elem => elem.pesoMaximo() > 2500 }.size()
	}
	
	method puedeMoverse(){
		return  self.pesoTotal() < self.pesoDeCargaLocomotora() }
	
	method cuantoKgFaltaParaElArrastre(){
		if( self.pesoDeCargaLocomotora() - self.pesoTotal() > 0 ) return 0
		else return self.pesoDeCargaLocomotora() - self.pesoTotal()
		
	}

}


class VagonDePasajeros{
	
	var property largo = 0
	var property ancho = 0
	var cantidadDePasajerosMaximo = 0
	
	method cantidadDePasajerosATransportar(){
		if(ancho < 2.5 ) cantidadDePasajerosMaximo = largo * 8
		else cantidadDePasajerosMaximo = largo * 8	
	}
	
	method asignarLargo(largoDelV){
		 ancho =largoDelV
	}

		method asignarAncho(anchoDelV){
		 ancho =anchoDelV
	}
	
	method pesoMaximo(){
		 return  cantidadDePasajerosMaximo * 80
	} 
}


class VagonDeCarga{
	
	var property cargaMaxima = 0
	
	method pesoMaximo(){
		return cargaMaxima + 160
	} 

	method cantidadDePasajerosATransportar(){
	 return 0
	}

	}
	
class Locomotora {
	
	var property peso
	var property pesoMaximoDeArrastre
	var property velocidadMaxima

	method cargaMaximaActual(){
		return pesoMaximoDeArrastre - peso
	}
	
	method pesoMaximo(){
		return peso
	}
	
 }
	
class Deposito{
	
	var property formaciones
	
	
	method vagonesPesados(){
		return  formaciones.map{ elem => elem.vagonMasPesado()}
		}
	}

