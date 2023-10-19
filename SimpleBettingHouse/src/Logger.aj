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
	
	pointcut registro(User user, Person person) : call(* successfulSignUp(User, Person))&& args(user,person); 
	
	after(User user, Person person): registro(user, person){
		System.out.println("Usuario creado y registrado exitosamente!");
		EscribirAr(user, file);
	}
	
	
	
	//Esto aún está en prueba, no sé como es que podemos llamar a ambos a la vez
	pointcut Logs(User user, Person person) : call(* Log*(User, Person))&& args(user,person);
		after(User user, Person person): Logs(user, person){
			System.out.println(" Funca Log " + user.getNickname());
		}
		
	
	
	
	
	
	public void EscribirAr(User user, File file) {
		try {
			FileWriter fileWriter = new FileWriter (file, true);
			
			fileWriter.write("Usuario registrado: ["+ user.toString()+"] "+ "Fecha: [ "+ dateFormat.format(cal.getTime())+"] ");
			fileWriter.close();
			
		}catch (IOException e) {
			e.printStackTrace();
			
		}
	}
}

