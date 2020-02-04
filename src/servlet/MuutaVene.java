package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;
import model.Vene;

@WebServlet("/MuutaVene")
public class MuutaVene extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MuutaVene() {
        super();
        System.out.println("MuutaVene.MuutaVene()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MuutaVene.doGet()");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MuutaVene.doPost()");
		int tunnus = Integer.parseInt(request.getParameter("tunnus"));
		String nimi = request.getParameter("nimi");	
		String merkkimalli = request.getParameter("merkkimalli");
		double pituus = Double.parseDouble(request.getParameter("pituus"));
		double leveys = Double.parseDouble(request.getParameter("leveys"));
		int hinta = Integer.parseInt(request.getParameter("hinta"));
		PrintWriter out = response.getWriter(  );
	    Vene vene = new Vene (tunnus, nimi, merkkimalli, pituus, leveys, hinta);
		Dao dao = new Dao();			
		if(dao.muutaVene(vene)) {
			 out.println(1);  //Tietojen päivitys onnistui	
		}else {
			 out.println(0);  //Tietojen päivitys epäonnistui	
		} 		
	}
}
