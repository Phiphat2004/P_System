/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.OrderDAO;
import DAOs.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import DAOs.UserDAO;
import Modals.Order;
import Modals.Staff;
import Modals.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dell
 */
public class AdminManagerController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();

        switch (path) {
              case "/P-System/AdminManager/Dashboard":
                OrderDAO order = new OrderDAO();
                List<Order> orderList = order.getOrderAll();
                List<Order> orderList1 = new ArrayList<>();
                for(Order i:orderList){
                    if(!i.getOrderStatus().equalsIgnoreCase("Chờ xác nhận")){
                        orderList1.add(i);
                    }
                }
                request.setAttribute("ord", "choose");
                request.setAttribute("listOr", orderList1);
                request.getRequestDispatcher("/Admin-Dashboard.jsp").forward(request, response);
                break;
            case "/P-System/AdminManager/usermanagement":
                UserDAO u = new UserDAO();
                List<User> user = u.getAllUsers();
                request.setAttribute("listUser", user);
                request.getRequestDispatcher("/Admin-UserManagement.jsp").forward(request, response);
                break;
            case "/P-System/AdminManager/staffmanagement":
                StaffDAO s = new StaffDAO();
                List<Staff> staff = s.getAllStaffs();
                String display = (String) request.getAttribute("display");
                request.setAttribute("display", display);
                request.setAttribute("listStaff", staff);
                request.getRequestDispatcher("/Admin-StaffManagement.jsp").forward(request, response);
                break;
        }

        if (path.startsWith("/P-System/AdminManager/staffmanagement/delete")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            StaffDAO sdao = new StaffDAO();
            sdao.deleteStaffID(Integer.parseInt(id));
            response.sendRedirect("/P-System/AdminManager/staffmanagement");

        } else if (path.startsWith("/P-System/AdminManager/staffmanagement/edit")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            StaffDAO sdao = new StaffDAO();
            Staff staff = sdao.GetStaffByID(id);
            request.setAttribute("Staff", staff);
            request.getRequestDispatcher("/Admin-EditStaff.jsp").forward(request, response);

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("addNewStaff") != null) {
            String email = request.getParameter("email");
            String name = request.getParameter("staffname");
            String pass = request.getParameter("password");
            Date DOB = Date.valueOf(request.getParameter("birthday"));
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Staff s = new Staff(email, pass, name, DOB, phone, address);
            StaffDAO sdao = new StaffDAO();
            List<Staff> ls = sdao.getStaffList(email);

            int kq = 0;
            boolean checkexist = false;
            for (Staff i : ls) {
                if (i.getStaffEmail().equalsIgnoreCase(email)) {
                    checkexist = true;
                }
            }

            if (checkexist) {
                List<Staff> staff = sdao.getAllStaffs();
                request.setAttribute("listStaff", staff);
                request.setAttribute("display", "Email trùng! Vui lòng thử lại.");
                request.getRequestDispatcher("/Admin-StaffManagement.jsp").forward(request, response);
            } else {
                try {
                    kq = sdao.AddNew(s);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminManagerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (kq != 0) {
                    List<Staff> staff = sdao.getAllStaffs();
                    request.setAttribute("listStaff", staff);
                    response.sendRedirect("/P-System/AdminManager/staffmanagement");
//                request.getRequestDispatcher("/StaffManagement-Admin.jsp").forward(request, response);
                } else {
                    List<Staff> staff = sdao.getAllStaffs();
                    request.setAttribute("listStaff", staff);
                    request.setAttribute("display", "Xãy ra lỗi! Vui lòng thử lại.");

                    request.getRequestDispatcher("/Admin-StaffManagement.jsp").forward(request, response);
                }
            }
        }

        if (request.getParameter("update") != null) {
            String staffID = request.getParameter("id");
            String staffName = request.getParameter("name");
            Date staffDOB = Date.valueOf(request.getParameter("DOB"));
            String staffPhone = request.getParameter("phone");
            String staffAddress = request.getParameter("address");

            StaffDAO sdao = new StaffDAO();
            sdao.updateStaff(staffName, staffPhone, staffAddress, staffDOB, staffID);
            List<Staff> staff = sdao.getAllStaffs();
            request.setAttribute("listStaff", staff);
            response.sendRedirect("/P-System/AdminManager/staffmanagement");

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
