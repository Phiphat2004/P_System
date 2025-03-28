/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CartDAO;
import DAOs.ImportDAO;
import DAOs.ProductDAO;
import DAOs.OrderDAO;
import DAOs.UserDAO;
import Modals.Import;
import Modals.Order;
import Modals.OrderDetail;
import Modals.Product;
import Modals.Size;
import Modals.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author admin
 */
@MultipartConfig
public class ManagerControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();

        switch (path) {
            case "/P-System/Manager/Dashboard":
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
                request.getRequestDispatcher("/Staff-Dashboard.jsp").forward(request, response);
                break;
            case "/P-System/Manager/manageProduct":
                String type = request.getParameter("type");
                System.out.println("type: " + type);
                ProductDAO productDAO = new ProductDAO();
                CartDAO cartDAO = new CartDAO();

                switch (type) {
                    case "view":
                        List<Product> list = productDAO.getAllProducts();
                        request.setAttribute("list", list);
                        request.getRequestDispatcher("/Staff-ProductManagement.jsp").forward(request, response);
                        break;
                    case "delete":
                        String productIdDelete = request.getParameter("pid");
                        cartDAO.delete(Integer.parseInt(productIdDelete));
                        productDAO.deleteProduct(productIdDelete);
                        response.sendRedirect("manageProduct?type=view");
                        break;
                    case "update":
                        //Product productUpdate = productDAO.getProductById(Integer.parseInt(request.getParameter("pid")));
                        Product productUpdate = productDAO.getProductById(Integer.parseInt(request.getParameter("pid")));
                        request.setAttribute("data", productUpdate);
                        request.getRequestDispatcher("/Staff-UpdateProduct.jsp").forward(request, response);
                        break;
                    default:
                        List<Product> listDefault = productDAO.getAllProducts();
                        request.setAttribute("list", listDefault);
                        request.getRequestDispatcher("/Staff-ProductManagement.jsp").forward(request, response);
                        break;
                }
//                ProductDAO productDAO = new ProductDAO();
//                List<Product> list = productDAO.getAllProducts();
//                request.setAttribute("pro", "choose");
//                request.setAttribute("list", list);
//                request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
                break;
            case "/P-System/Manager/monthRevenue":
                OrderDAO or = new OrderDAO();
                List<Order> listRevenue = or.monthlyRevenue();
                request.setAttribute("mth", "choose");
                request.setAttribute("listRevenue", listRevenue);
                request.getRequestDispatcher("/Staff-MonthRevenue.jsp").forward(request, response);
                break;
            case "/P-System/Manager/customermanagement":
                UserDAO u = new UserDAO();
                List<User> user = u.getAllUsers();
                request.setAttribute("listUser", user);
                request.getRequestDispatcher("/Staff-CustomerManagement.jsp").forward(request, response);
                break;
            case "/P-System/Manager/ordermanagement":
                OrderDAO order1 = new OrderDAO();
                List<Order> orderList2 = order1.getOrderAll();
                request.setAttribute("listOr", orderList2);
                request.getRequestDispatcher("/Staff-OrderManagement.jsp").forward(request, response);
                break;
            case "/P-System/Manager/importmanagement":
                ImportDAO importdao = new ImportDAO();
                List<Import> li = importdao.showImport();
                request.setAttribute("listIm", li);
                request.getRequestDispatcher("/Staff-ImportManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getRequestURI();

        switch (path) {
            case "/P-System/Manager/manageProduct":
                String type = request.getParameter("type");
                ProductDAO productDAO = new ProductDAO();
                System.out.println("type post:" + type);
                switch (type) {
                    case "add":
                        int staffID = Integer.parseInt(request.getParameter("staffID"));
                        String productName = request.getParameter("name");
                        String productPrice = request.getParameter("price");
                        String size = request.getParameter("size");
                        int productQuantity = Integer.parseInt(request.getParameter("quantity"));
                        Part filePart = request.getPart("img");
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "img\\product";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }

                        String fileName = getFileName(filePart);
                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        String category = request.getParameter("category");
                        String description = request.getParameter("description");

                        ProductDAO pdao = new ProductDAO();
                        ImportDAO importdao = new ImportDAO();
                        List<Product> lp = pdao.getAllProducts();
                        boolean checkname = false;
                        boolean checksize = false;
                        int proID = 0;

                        for (Product i : lp) {
                            if (i.getProductName().equalsIgnoreCase(productName)) {
                                checkname = true;
                                proID = i.getProductID();
                            }
                            List<Size> ls = pdao.getSize(i.getProductID());
                            for (Size j : ls) {
                                if (j.getSize().equalsIgnoreCase(size)) {
                                    checksize = true;
                                    break;
                                }
                            }
                        }
                        if (!checkname) {
                            productDAO.addProductAndImport(staffID, productName, productPrice, size, productQuantity, "./img/product/" + fileName, description, category, productQuantity);
                        } else {
                            if (!checksize) {
                                productDAO.addSize(String.valueOf(proID), size, path);
                                importdao.addNewImport(staffID, proID, size, productQuantity);
                            } else {
                                productDAO.updateSize(proID, size, productQuantity);
                                importdao.addNewImport(staffID, proID, size, productQuantity);
                            }
                        }
//                        boolean checktoimport = false;
//                        if (checkimport) {
//                            List<Product> lp1 = pdao.getAllProducts();
//                            for (Product i : lp1) {
//                                if (productName.equalsIgnoreCase(i.getProductName())) {
//                                    checktoimport = true;
//                                }
//                            }
//                        }
//                        if (checktoimport) {
//                            importdao.addNewImport(staffID, proID, size, productQuantity);
//                        }
                        response.sendRedirect("manageProduct?type=view");
                        break;
                    case "update":
                        String id = request.getParameter("id");
                        String productNameUpdate = request.getParameter("name");
                        String productPriceUpdate = request.getParameter("price");
                        Part filePartUpdate = request.getPart("img");
                        String uploadPathUpdate = getServletContext().getRealPath("") + File.separator + "img\\product";
                        File uploadDirUpdate = new File(uploadPathUpdate);
                        if (!uploadDirUpdate.exists()) {
                            uploadDirUpdate.mkdir();
                        }
                        String fileNameUpdate = getFileName(filePartUpdate);
                        String filePathUpdate = uploadPathUpdate + File.separator + fileNameUpdate;
                        filePartUpdate.write(filePathUpdate);
                        String productCategoryUpdate = request.getParameter("category");
                        String descriptionUpdate = request.getParameter("description");
                        productDAO.updateProduct(productNameUpdate, productPriceUpdate, "./img/product/" + fileNameUpdate, descriptionUpdate, productCategoryUpdate, id);
                        response.sendRedirect("manageProduct?type=view");
                        break;
                }
                break;

        }
        if (request.getParameter("Accept") != null) {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String orderStatus = "Đang được giao";
            OrderDAO odao = new OrderDAO();
            ProductDAO pdao = new ProductDAO();
            List<Order> lo = odao.showOrderByID(orderID);
            List<OrderDetail> lod = odao.showOrderDetail(orderID);
            int newQuantity = 0;
            for (Order i : lo) {
                if (i.getOrderID() == orderID) {
                    odao.updateOrderStatus(orderID, orderStatus);
                    for (OrderDetail j : lod) {
                        if (j.getOrderID() == orderID) {
                            List<Size> ls = pdao.getSize(j.getProductID());
                            for (Size z : ls) {
                                if (j.getSize().equalsIgnoreCase(z.getSize())) {
                                    newQuantity = z.getQuantity() - j.getQuantity();
                                    pdao.updateSizeQuantity(j.getProductID(), j.getSize(), newQuantity);
                                }
                            }
                        }
                    }
                }
            }
            String uEmail = "";
            Order orderById = odao.getOrderByID(orderID);
            UserDAO udao = new UserDAO();
            User u = udao.GetUserId(String.valueOf(userID));
            uEmail = u.getUserEmail();
            String to = uEmail;
            String subject = "❤️ Đơn hàng của bạn đã được chúng tôi xác nhận. ❤️";
//            String body = "<html><body>"
//                    + "<p>Chào bạn,<b>" + u.getUserName() +"</b>,</p>"
//                    + "<p>❤️ Chúng tôi xin gửi lời cảm ơn chân thành đến bạn vì đã đặt hàng tại cửa hàng của chúng tôi.❤️</p>"
//                    + "<p>Mã đơn hàng của bạn là:<b> " + odao.getNewestOrder().getOrderID() + "</b></p>"
//                    + "<p>Tổng giá trị đơn hàng:<b> " + odao.getNewestOrder().getTotalPrice() + "</b>$</p>"
//                    + "<p>Đia chỉ giao hàng:<b> " + u.getUserAddress() + "</b></p>"
//                    + "<p>Nếu bạn có bất kỳ câu hỏi hoặc yêu cầu đặc biệt nào, vui lòng liên hệ với chúng tôi. "
//                    + "Chúng tôi luôn sẵn lòng hỗ trợ bạn.</p>"
//                    + "<p>Xin một lần nữa cảm ơn bạn đã tin tưởng và ủng hộ cửa hàng của chúng tôi.</p>"
//                    + "<p>Trân trọng,<br>"
//                    + "❤️ Đội ngũ cửa hàng ❤️</p>"
//                    + "</body></html>";
            String body = "<html>\n"
                    + "  <head>\n"
                    + "    <style>\n"
                    + "      body {\n"
                    + "        font-family: Arial, sans-serif;\n"
                    + "        margin: 20px;\n"
                    + "        padding: 20px;\n"
                    + "        background-color: #f7f7f7;\n"
                    + "      }\n"
                    + "\n"
                    + "      p {\n"
                    + "        font-size: 16px;\n"
                    + "        line-height: 1.6;\n"
                    + "        color: #333;\n"
                    + "      }\n"
                    + "\n"
                    + "      b {\n"
                    + "        color: #e44d26;\n"
                    + "      }\n"
                    + "\n"
                    + "      .user-name {\n"
                    + "        color: #FFFFFF;\n"
                    + "      }\n"
                    + "\n"
                    + "      .thank-you {\n"
                    + "        background-color: #e44d26;\n"
                    + "        color: #fff;\n"
                    + "        padding: 10px;\n"
                    + "        border-radius: 5px;\n"
                    + "        text-align: center;\n"
                    + "        font-size: 18px;\n"
                    + "        margin-bottom: 20px;\n"
                    + "      }\n"
                    + "\n"
                    + "      .order-details {\n"
                    + "        background-color: #fff;\n"
                    + "        padding: 15px;\n"
                    + "        border-radius: 5px;\n"
                    + "        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n"
                    + "      }\n"
                    + "\n"
                    + "      .footer {\n"
                    + "        margin-top: 20px;\n"
                    + "        font-size: 14px;\n"
                    + "        color: #666;\n"
                    + "      }\n"
                    + "    </style>\n"
                    + "  </head>\n"
                    + "  <body>\n"
                    + "    <div class=\"thank-you\">\n"
                    + "      <p>Chào bạn, <b class=\"user-name\">" + u.getUserName() + "</b>,</p>\n"
                    + "      <p>❤️ Chúng tôi xin gửi lời cảm ơn chân thành đến bạn vì đã đặt hàng tại cửa hàng của chúng tôi. "
                    + "         Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị đóng gói để giao hàng. ❤️</p>\n"
                    + "    </div>\n"
                    + "\n"
                    + "    <div class=\"order-details\">\n"
                    + "      <p>Mã đơn hàng của bạn là: <b>" + orderById.getOrderID() + "</b></p>\n"
                    + "      <p>Sản phẩm: <b>" + odao.getOrderByID(orderID).getProductSizeAndName() + "</b></p>\n"
                    //                    + "      <p> <img src='" + odao.getNewestOrder().getProductIMG() + "' alt=Product Image'></p>\n"
                    + "      <p>Tổng giá trị đơn hàng: <b>" + formatCurrency(odao.getOrderByID(orderID).getTotalPrice()) + "</b></p>\n"
                    + "      <p>Địa chỉ giao hàng: <b>" + u.getUserAddress() + "</b></p>\n"
                    + "      <p>\n"
                    + "        Nếu bạn có bất kỳ câu hỏi hoặc yêu cầu đặc biệt nào, vui lòng liên hệ với chúng tôi qua email P-System1803@gmail.com.\n"
                    + "        Chúng tôi luôn sẵn lòng hỗ trợ bạn.\n"
                    + "      </p>\n"
                    + "    </div>\n"
                    + "\n"
                    + "    <p class=\"footer\">\n"
                    + "      Xin một lần nữa cảm ơn bạn đã tin tưởng và ủng hộ cửa hàng của chúng tôi.\n"
                    + "      <br />\n"
                    + "      Trân trọng,\n"
                    + "      <br />\n"
                    + "      ❤️ Đội ngũ cửa hàng ❤️\n"
                    + "    </p>\n"
                    + "  </body>\n"
                    + "</html>";
            sendEmail(to, subject, body);
            response.sendRedirect("/P-System/Manager/ordermanagement");
        }

        if (request.getParameter("Success") != null) {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            String orderStatus = "Giao hàng thành công";
            OrderDAO odao = new OrderDAO();
            List<Order> lo = odao.showOrderByID(orderID);
            for (Order i : lo) {
                if (i.getOrderID() == orderID) {
                    odao.updateOrderStatus(orderID, orderStatus);
                }
            }
            response.sendRedirect("/P-System/Manager/ordermanagement");
        }
    }

    public String formatCurrency(float amount) {
        // Tạo một đối tượng NumberFormat để định dạng số tiền
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        // Định dạng số tiền và trả về chuỗi đã định dạng
        return currencyFormatter.format(amount);
    }

    static final String from = "nhanhcungbanthan@gmail.com";
    static final String password = "visu yfrx esml bldr";

    private boolean sendEmail(String to, String subject, String body) {
        // Properties : khai báo các thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, password);
            }
        };

        // Phiên làm việc
        Session session = Session.getInstance(props, auth);

        // Tạo một tin nhắn
        MimeMessage msg = new MimeMessage(session);

        try {
            // Kiểu nội dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // Người gửi
            msg.setFrom(new InternetAddress("\"P-System\" <" + Psystem + ">"));

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tiêu đề email
            msg.setSubject(subject, "UTF-8");

            // Quy định email nhận phản hồi
            // msg.setReplyTo(InternetAddress.parse(from, false))
            // Nội dung
            msg.setContent(body, "text/HTML; charset=UTF-8");

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
            return true;
        } catch (Exception e) {
            System.out.println("Gặp lỗi trong quá trình gửi email");
            e.printStackTrace();
            return false;
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

}
