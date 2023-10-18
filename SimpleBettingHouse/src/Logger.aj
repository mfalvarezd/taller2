import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import com.bettinghouse.*;


public aspect Logger {
	File file = new File ("Register.txt");
	Calendar cal = Calendar.getInstance();
	User user;
	
	pointcut registro(User user, Person person) : call(* successfulSignUp(User, Person))&& args(user,person); 
	
	after(User user, Person person): registro(user, person){
		
		String accion = "";
		String nickname ="";
		/*
		if(thisJoinPoint.getSignature().getName().equals("succesfulSignUp")){
			accion= "Registrar Usuario";
			nickname= ((User)args[1]).getNickname()+"password: ";
		}
		*/
		System.out.println(" Funca " + user.getNickname());
	}
		
		pointcut Logs(User user, Person person) : call(* Log*(User, Person))&& args(user,person);
		after(User user, Person person): Logs(user, person){
			System.out.println(" Funca Log " + user.getNickname());
		}
		
	
	
	
	
	
	public void EscribirAr(String datos, String nombreAr) {
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(nombreAr,true)))){
			out.println(datos);
		
		}catch (IOException e) {
			e.printStackTrace();
			
		}
	}
}

