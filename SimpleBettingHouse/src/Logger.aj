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
	
	pointcut registro(): execution(void signUp()); 
	
	after(): registro(){
		String accion = "Usuario Registrado";
		System.out.println(accion);
		
		
		
	}
	
	
	
	
	public void EscribirAr(String datos, String nombreAr) {
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(nombreAr,true)))){
			out.println(datos);
		
		}catch (IOException e) {
			e.printStackTrace();
			
		}
	}
}

