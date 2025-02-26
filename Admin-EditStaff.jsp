<%-- 
    Document   : managerProduct
    Created on : Oct 18, 2023, 11:07:25 PM
    Author     : admin
--%>

<%@page import="Modals.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Management</title>
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
                background-color: rgb(183, 183, 183);
            }

            .allbody{

                background-color: rgb(182, 182, 182);
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
                height: 1000px;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 350px;
                height: 1000px;
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

            .update{
                margin: 20px;
                text-align: center;
            }

            #editEmployeeModal{
                height: fit-content;
            }

            .update button{
                background-color: black;
                color: white;
                font-size: x-large;
                padding: 10px;
                border: none;
            }

            .update button:active{
                background-color: white;
                color: black;
                border: 1px solid;
            }

            .update a{
                background-color: black;
                color: white;
                padding: 10px;
                border: none;
                text-decoration: none;
            }

            .update a:active{
                background-color: white;
                color: black;
                padding: 10px;
                border: 1px solid black;
                text-decoration: none;
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
                        if (cookie.getName().equals("admin") && !cookie.getValue().equals("")) {
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
                        if (cookie.getName().equals("admin") && !cookie.getValue().equals("")) {
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
            P-System - ADMIN
        </a>
        <div class="main-body">
            <nav>
                <ul class="listcontent">
                    <li>
                        <a href="/P-System/AdminManager/Dashboard"><i class="fa fa-home me-3"></i> 
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/AdminManager/usermanagement"><i class="fa fa-user me-3"></i>
                            <span>Customer</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/AdminManager/staffmanagement"
                           ><i class="fa fa-users me-3"></i>
                            <span>Staff</span>
                        </a>
                    </li>
                    <li>
                        <a href="/P-System/Logout"><i class="fa fa-sign-out me-3"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div id="editEmployeeModal" class="container mt-5 bg-white p-5 rounded-5">
                <%
                    Staff staff = (Staff) request.getAttribute("Staff");
                    if (staff != null) {
                %>
                <form action="AdminManager" method="post" >
                    <div>						
                        <h4 class="modal-title mb-4">Update Staff</h4>
                    </div>
                    <div>		
                        <input value="update" name="type" type="hidden" class="form-control hidden" >
                        <div class="form-group mb-3">
                            <label class="fs-4">ID: <span><%= staff.getStaffID()%></span></label>
                            <input value="<%= staff.getStaffID()%>" name="id" type="hidden" class="form-control" readonly required >
                        </div>
                        <div class="form-group">
                            <label>Staff Name</label>
                            <input value="<%= staff.getStaffName()%>" id="name" name="name" type="text" class="form-control" required>
                        <p id="nameerror"></p>
                        </div>
                        <div class="form-group">
                            <label>Day of birth</label>
                            <input type="date" name="DOB" id="birthday" value="<%= staff.getStaffDOB()%>" class="form-control" required >
                        <p id="DOBerror"></p>
                        </div>
                        <div class="form-group">
                            <label>Phone number</label>
                            <input type="text" name="phone" id="phone" class="form-control"  value="<%= staff.getStaffPhone()%>"  pattern="^0+[0-9]{9,10}$" required title="Please enter a valid phone number starting with 0 and followed by 9 to 10 digits">
                        <p id="phoneerror"></p>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <textarea name="address" id="address" class="form-control" required ><%= staff.getStaffAddress()%></textarea>
                        <p id="ADerror"></p>
                        </div>
                    </div>
                    <div class="update">
                        <button type="submit" class="rounded-3 fs-5" value="Update" name="update">Update</button>
                        <a href="/P-System/AdminManager/staffmanagement" role="button" class="rounded-3 fs-5" >Cancel</a>
                    </div>
                </form> 
                <%
                    }
                %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
