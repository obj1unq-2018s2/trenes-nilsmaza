class Formacion {
	
	var property locomotora
	var property vagones 
	

	method vagonMasPesado(){
		return vagones.max{elem => elem.pesoMaximo() }
	}
	
	method engancharLocomotora(locomotoraNueva){
		locomotora.add(locomotoraNueva)
	}
	
	method engancharVagon(vagon){
		vagones.add(vagon)
	}
	
	method desengacharrVagon(vagon){
		vagones.remove(vagon)
	}
	
	method cantidadDeVagones(){
		return vagones.size()
	}
	
	method pesoTotal(){
		 return vagones.sum{ elem => elem.pesoMaximo() }
	}
	
	method pesoTotalLocomotora(){
		 return locomotora.sum{ elem => elem.pesoMaximo() }
	}
	
	method pesoDeCargaATransportarLocomotora(){
		 return locomotora.sum{ elem => elem.cargaMaximaActual() }
	}
	
	method formacionEficiente(){
		return vagones.all{ elem => elem.pesoMaximo() > elem.pesoMaximo() * 5  }
	}
	
	method vagonesLivianos(){
		 return vagones.filter{ elem => elem.pesoMaximo() < 2500 }.size()
	}
	
	method puedeMoverse(){
		return  self.pesoTotal() < self.pesoDeCargaATransportarLocomotora()
	}
	
	method cuantoKgFaltaParaElArrastre(){
		if( self.pesoDeCargaATransportarLocomotora() - self.pesoTotal() > 0 ) return 0
		else return (self.pesoDeCargaATransportarLocomotora() - self.pesoTotal()) * -1
	}
	
	method esCompleja(){
		return locomotora.size() + vagones.size() > 20
			or  self.pesoTotal() + self.pesoTotalLocomotora() > 10000
	}
	
	method baniosDeLAFormacion(){
		return vagones.sum{elem => elem.cantidadDeBanios()}
	}
	
	method cantidadDePasajeros(){
		return vagones.sum{elem => elem.cantidadDePasajeros()}
	}
	
	method cantidadDeVelocidadMaxima(){
		return locomotora.sum{elem => elem.velocidadMaxima()}
	}
}


class VagonDePasajeros{
	
	var property largo = 0
	var property ancho = 0
	var cantidadDePasajerosMaximo = 0
	var banios = 0
	
	
	
	method cantidadDePasajerosATransportar(){
		if(ancho <= 2.5 ) cantidadDePasajerosMaximo = largo * 8
		else cantidadDePasajerosMaximo = largo * 10	
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
	
	method cantidadDeBanios(){
		return banios
	}
	
	method cantidadDePasajeros(){
		return cantidadDePasajerosMaximo
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
	
	method cantidadDeBanios(){
		return 0
	}
	
	method cantidadDePasajeros(){
		return 0
		}
	}
	
class Locomotora {
	
	var property peso
	var property pesoMaximoDeArrastre
	var velocidadMaxima

	method cargaMaximaActual(){
		return pesoMaximoDeArrastre - peso
	}
	
	method pesoMaximo(){
		return peso
	}
	
	method velocidadMaxima(){
		return velocidadMaxima
	}
	
 }
	
class Deposito{
	
	var property formaciones
	var property formacionesSinVagones
	
	method necesitaConductorExperimentado(){
		return formaciones.any{elem => elem.esCompleja()}
	}

	method locomotoraSinUsarNecesaria(){
		return formacionesSinVagones.filter{
			elem => elem.cargaMaximaActual() > self.formacionQueNecesitaAyuda().cuantoKgFaltaParaElArrastre()
		}.first()
	}
	
	
	method formacionQueNecesitaAyuda(){
		return self.listaDeFormacionesQueNecesitanAyuda().first()
	}
	
	method listaDeFormacionesQueNecesitanAyuda(){
		return formaciones.filter{ elem => not elem.puedeMoverse() }
	}
	
	method agregarFormacionEnDeposito(){
		if(not self.listaDeFormacionesQueNecesitanAyuda().isEmpty()){
			self.formacionQueNecesitaAyuda().engancharLocomotora(self.locomotoraSinUsarNecesaria())
		}
	}
	
	method vagonesPesados(){
		return  formaciones.map{ elem => elem.vagonMasPesado()}
		}
	}
	

class LargaDistancia inherits Formacion {
	

	method formacionBienArmada(){
		return self.baniosDeLAFormacion() > self.cantidadDePasajeros() / 50
		 and self.puedeMoverse()
	}
	
//	method velocidadLimite(){
//		if(unionDeCiudadesGrades){
//		 velocidadLimite = 200.min(self.cantidadDeVelocidadMaxima() )}
//	else  velocidadLimite = 150.min(self.cantidadDeVelocidadMaxima() )
//		return velocidadLimite
//		}
		
//	method esTrenDeMaximaVelocidad(){
//		return self.cantidadDeVelocidadMaxima() > 250 and
//				self.vagonesLivianos() == self.cantidadDeVagones()
//	}
	
	}

class TrenDeMaximaVelocidad inherits LargaDistancia{
	
	var unionDeCiudadesGrades = false
	var velocidadLimite = 0

	method permitirEntradaACiudades(){
		unionDeCiudadesGrades = true
	}

	method velocidadLimite(){
		if(unionDeCiudadesGrades){
		 velocidadLimite = 200.min(self.cantidadDeVelocidadMaxima() )}
	else  velocidadLimite = 150.min(self.cantidadDeVelocidadMaxima() )
		return velocidadLimite
		}
		
	method esTrenDeMaximaVelocidad(){
		return self.cantidadDeVelocidadMaxima() > 250 and
				self.vagonesLivianos() == self.cantidadDeVagones()
	}
	
}
	

class CortaDistancia inherits Formacion{
	
	method formacionBienArmada(){
		return  not self.esCompleja() and self.puedeMoverse()
		}
		
	method velocidadLimite(){
		return 60.min(self.cantidadDeVelocidadMaxima() )
	}
	
	
}