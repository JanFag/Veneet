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

@WebServlet("/LisaaVene")
public class LisaaVene extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public LisaaVene() {
        super();
        System.out.println("LisaaVene.LisaaVene()");
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("LisaaVene.doGet()");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("LisaaVene.doPost()");
	
		
		String nimi = request.getParameter("nimi");	
		String merkkimalli = request.getParameter("merkkimalli");
		double pituus = Double.parseDouble(request.getParameter("pituus"));
		double leveys = Double.parseDouble(request.getParameter("leveys"));
		int hinta = Integer.parseInt(request.getParameter("hinta"));

	    Vene vene = new Vene (nimi, merkkimalli, pituus, leveys, hinta);

		PrintWriter out = response.getWriter();
	    response.setContentType("text/html"); 
	    Dao dao = new Dao();
		if(dao.lisaaVene(vene)){
			out.println(1);  //Venee lis‰‰minen onnistui
		}else{
			out.println(0);  //Veneen lis‰‰minen ep‰onnistui
		}		
	}
}










