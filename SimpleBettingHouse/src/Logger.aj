import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import com.bettinghouse.*;


public aspect Logger {
	File file = new File ("Register.txt");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	User user;
	String mensaje;
	
	pointcut registro(User user, Person person) : call(* successfulSignUp(User, Person))&& args(user,person); 
	
	after(User user, Person person): registro(user, person){
		mensaje= "Usuario registrado: ";
		System.out.println("Usuario creado y registrado exitosamente!");
		System.out.println("Usuario registrado: ["+ user.toString()+"] "+ "Fecha: [ "+ dateFormat.format(cal.getTime())+"] ");
		EscribirAr(user, file, mensaje);
	}
	pointcut logIn(User user) : call(* effectiveLogIn(User))&& args(user);			
	pointcut loggedOut(User user) : call(* effectiveLogOut(User))&& args(user);		
	after(User user): (logIn(user) || loggedOut(user)){		
		if(thisJoinPointStaticPart.getSignature().getName().equals("effectiveLogIn")) {
						mensaje= "Sesión iniciada por usuario: ";
		}//baidal 2
		System.out.println(mensaje+"["+ user.toString()+"] "+ "Fecha: [ "+ dateFormat.format(cal.getTime())+"] ");		
		EscribirAr(user, logfile, mensaje);				}
		
	
	
	
	//Esto aún está en prueba, no sé como es que podemos llamar a ambos a la vez
	pointcut Logs(User user, Person person) : call(* Log*(User, Person))&& args(user,person);
		after(User user, Person person): Logs(user, person){
			System.out.println(" Funca Log " + user.getNickname());
		}
		
	
	
	
	
	
	public void EscribirAr(User user, File file, String mensaje) {
		try {
			FileWriter fileWriter = new FileWriter (file, true);
			
			fileWriter.write(mensaje+"["+ user.toString()+"] "+ "Fecha: [ "+ dateFormat.format(cal.getTime())+"] \n");
			fileWriter.close();
			
		}catch (IOException e) {
			e.printStackTrace();
			
		}
	}
}

