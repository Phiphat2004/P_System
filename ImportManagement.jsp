<%-- 
    Document   : ImportManager.jsp
    Created on : Dec 12, 2023, 7:03:38 PM
    Author     : Dell
--%>

<%@page import="Modals.ImportDetail"%>
<%@page import="Modals.Import"%>
<%@page import="DAOs.ImportDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Import Management</title>
        <link rel="stylesheet" href="style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
        <style>
            .main-body{
                display: flex;
            }

            .body{
                width: 2000px;
                background-color: rgb(180, 180, 180);
            }

            .navbar{
                background-color: black;
                color: white;
                text-decoration: none;
                font-size: xx-large;
                font-weight: bold;
            }

            .listcontent{
                font-size: x-large;
                margin-left: -30px;
                padding-top: 30px;
                width: 130px;
                height: 1900px;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 350px;
                height: 1900px;
                background-color: black;
                color: white;
                transition: all 0.1s linear;
            }

            .listcontent:hover span{
                display: inline-block;
            }

            .listcontent span{
                display: none;
            }

            .listcontent li{
                padding: 10px;
                width: 300px;
                list-style-type: none;
            }

            .listcontent li:active{
                background-color: white;
                padding: 10px;
                width: 318px;
                list-style-type: none;
            }

            .listcontent li a{
                padding-left: 20px;
                text-decoration: none;
                color: white;
                width: 160px;
            }

            .listcontent li a:active{
                text-decoration: none;
                color: black;
                width: 160px;
            }

            .content{
                background-color: rgb(233, 233, 233);
                margin: 20px;
                border-radius: 20px;
                width: 100%;
                display: inline-block;
                justify-items: center;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 10px;
                font-size: large;
            }



            .paymentamount{
                display: flex;
            }

            .amount{
                display: flex;
            }

            .today-data{
                background-color: rgb(207, 179, 235);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }
            .today-data:hover{
                background-color: rgb(159, 109, 209);
            }

            .month-data{
                background-color: rgb(143, 215, 197);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .month-data:hover{
                background-color: rgb(55, 189, 156);
            }
            .year-data{
                background-color: rgb(234, 145, 149);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .year-data:hover{
                background-color: rgb(215, 104, 110);
            }

            .fa-dollar{
                background-color: rgb(17, 85, 167);
                color: white;
                font-size: 1.5rem;
                padding: 1.3rem;
                height: 60px;
                width: 60px;
                margin-left: 50px;
                text-align: center;
                border-radius: 50%;
            }

            .manageproduct{
                background-color: rgb(255, 255, 255);
                margin: 20px;
                border-radius: 20px;
                padding: 30px;
                font-size: x-large;
            }

            .finance td{
                width: 50px;
            }

            .addproduct{
                font-size: x-large;
            }

            .buttongroup{
                text-align: center;
            }

            .buttongroup button{
                width: 100px;
                padding: 10px;
                margin-top: 20px;
                border: none;
                font-size: x-large;
                color: white;
                background: black;
            }

            .buttongroup button:active{
                border: 1px solid black;
                color: black;
                background: white;
            }


        </style>
    </head>
    <body class="allbody">
        <%
            Cookie[] cookies = request.getCookies();
            if (session.getAttribute("acc") == null) {
                boolean flag = false;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("staff") && !cookie.getValue().equals("")) {
                            session.setAttribute("id", cookie.getValue());
                            flag = true;
                            break;
                        }
                    }
                }
                if (!flag) {
                    response.sendRedirect("/P-System/Login");
                }
            } else {
                boolean flag = false;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("staff") && !cookie.getValue().equals("")) {
                            session.setAttribute("id", cookie.getValue());
                            flag = true;
                            break;
                        }
                    }
                }
                if (!flag) {
                    response.sendRedirect("/P-System/Login");
                }
            }
        %>
        <a href="" class="navbar ps-5">
            P-System - STAFF
        </a>
        <div class="main-body">
            <nav>
                <ul class="listcontent">  
                    <li>
                        <a href="/P-System/Manager/Dashboard"><i class="fa fa-home me-3"></i> 
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Manager/manageProduct?type=view"><i class="fa fa-product-hunt me-3"></i> 
                            <span>Product</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Manager/importmanagement"
                           ><i class="fa fa-download me-3"></i>
                            <span>Import</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Manager/ordermanagement"
                           ><i class="fa fa-file me-3"></i>
                            <span>Orders</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Manager/monthRevenue"><i class="fa fa-calendar me-3"></i>
                            <span>Month revenue</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Manager/customermanagement"><i class="fa fa-user me-3"></i>
                            <span>Customer</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Logout"><i class="fa fa-sign-out me-3"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="body">
                <div id="manageproduct" class="manageproduct">


                    <h2>Finace data</h2>
                    <table id="example">
                        <thead>
                            <tr>
                                <th class="align-middle">Import ID</th>
                                <th class="align-middle">Staff ID</th>
                                <th class="align-middle">Name</th>
                                <th class="align-middle">Email</th>
                                <th class="align-middle">Phone</th>
                                <th class="align-middle">Import Date</th>
                                <th class="align-middle">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ImportDAO idao = new ImportDAO();
                                List<Import> listi = (List<Import>) request.getAttribute("listIm");
                                for (Import i : listi) {
                            %>
                            <tr>
                                <td class="align-middle"><p><%= i.getImportID()%></p></td>
                                <td class="align-middle"><p><%= i.getStaffID()%></p></td>
                                <td class="align-middle"><p><%= i.getStaffName()%></p></td>
                                <td class="align-middle"><p><%= i.getStaffEmail()%></p></td>
                                <td class="align-middle"><p><%= i.getStaffPhone()%></p></td>
                                <td class="align-middle"><p><%= i.getImportDate()%></p></td>
                                <td class="align-middle">
                                    <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ImportDetail<%= i.getImportID()%>">Chi tiết</a>
                                    <!-- Modal -->
                                    <div class="modal fade" id="ImportDetail<%= i.getImportID()%>">" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-scrollable modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Import Detail</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <table style="width: 100%;text-align: center;">
                                                            <tr>
                                                                <th class="align-middle">ID</th>
                                                                <th class="align-middle">Name</th>
                                                                <th class="align-middle">Image</th>
                                                                <th class="align-middle">Size</th>
                                                                <th class="align-middle">Quantity</th>
                                                                <th class="align-middle">Price</th>
                                                            </tr>
                                                            <%
                                                                List<ImportDetail> detail = idao.showImportDetail(i.getImportID());
                                                                for (ImportDetail j : detail) {
                                                                    if (i.getImportID() == j.getImportID()) {
                                                            %>
                                                            <tr>
                                                                <td class="align-middle"><%= j.getProductID()%></td>
                                                                <td class="align-middle"><%= j.getProductName()%></td>
                                                                <td class="align-middle"><img src="/P-System/<%= j.getProductImg()%>" width="90" height="90" alt="alt"/></td>
                                                                <td class="align-middle"><%= j.getSize()%></td>
                                                                <td class="align-middle"><%= j.getQuantity()%></td>
                                                                <td class="align-middle"><p>
                                                                        <fmt:formatNumber
                                                                        value="<%= j.getPrice()%>"
                                                                            type="number"
                                                                            pattern="###,### vnđ"
                                                                            />
                                                                    </p></td>
                                                            </tr>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>   
                </div>
            </div>  
        </div>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    </body>
</html>

