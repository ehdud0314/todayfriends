package board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Board;

@WebServlet("/page/board/delete1")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BoardDeleteServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		excute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		excute(request, response);
	}

	protected void excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BoardService sv = new BoardService();
		Board vo = new Board();
		int hobbyId = Integer.parseInt(request.getParameter("hobbyId"));
		vo.setHobbyId(hobbyId);
		int loc = Integer.parseInt(request.getParameter("locnum"));
		vo.setLocNum(loc);
		
		String bno = request.getParameter("bno");
		int result = 0;
		
		vo.setBno(Integer.parseInt(request.getParameter("bno")));
		PrintWriter out = response.getWriter();
		result = sv.boardDelete(vo);
		if (result == 1) {
		
			System.out.println("삭제성공");
		request.getRequestDispatcher("/page/board/boardread?hobbyId="+hobbyId+"&locnum="+loc).forward(request, response);
		} else {
			System.out.println("삭제실패");
			String msg = "글 삭제 실패";
			out.println("<script>alert('" + msg + "');history.back();</script>");
		}
	}
}