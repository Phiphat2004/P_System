<%-- 
    Document   : managerProduct
    Created on : Oct 18, 2023, 11:07:25 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@page   contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Customer Management</title>
        <link rel="stylesheet" href="style.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"
            />
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
                height: 1050px;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 350px;
                height: 1050px;
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
                background-color: white;
                margin: 20px;
                border-radius: 20px;
                width: 100%;
                display: inline-block;
                justify-items: center;
                padding: 20px;
                font-size: large;
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
        <a href="" class="navbar ps-5"> P-System - ADMIN</a>
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
            <div class="container">
                <div class="content" id="managestaff">
                    <h1>Staff Management</h1>
                    <a class="btn btn-success m-2" id="btnaddstaff" >
                        <i class="fa fa-plus"></i> 
                        <span >Add New Staff</span>
                    </a>
                    <table id="example" style="width: 100%;">
                        <thead>
                            <tr>
                                <th class="align-middle">NO</th>
                                <th class="align-middle">Staff ID</th>
                                <th class="align-middle">Staff Name</th>
                                <th class="align-middle">Email</th>
                                <th class="align-middle">Date of birth</th>
                                <th class="align-middle">Phone number</th>
                                <th class="align-middle">Address</th>
                                <th class="align-middle">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="stt" value="0" />
                            <c:forEach items="${listStaff}" var="o">
                                <c:set var="stt" value="${stt + 1}" />
                                <tr>
                                    <td class="align-middle"><p>${stt}</p></td>
                                    <td class="align-middle"><p>${o.staffID}</p></td>
                                    <td class="align-middle"><p>${o.staffName}</p></td>
                                    <td class="align-middle"><p>${o.staffEmail}</p></td>
                                    <td class="align-middle"><p>${o.staffDOB}</p></td>
                                    <td class="align-middle"><p>${o.staffPhone}</p></td>
                                    <td class="align-middle"><p>${o.staffAddress}</p></td>
                                    <td class="align-middle">
                                        <a href="/P-System/AdminManager/staffmanagement/edit/${o.staffID}" class="btn btn-primary text-white m-2" ><i class="fa fa-pencil p-1"></i></a>
                                        <a href="/P-System/AdminManager/staffmanagement/delete/${o.staffID}" onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này không?')" class="btn btn-danger text-white m-2" name="delete" ><i class="fa fa-trash p-1"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Add product -->
                <div id="addstaff" class="bg-white container p-5 mt-5 rounded-5" style="display: none;">
                    <div class="add product">
                        <form method="post" id="registerform" action="AdminManager">
                            <h1 class="text-center">Add new staff</h1>
                            <%
                                String display = (String) request.getAttribute("display");
                                if (request.getAttribute("display") != null) {
                            %>
                            <p class="text-center" style="color: red;"><%= display %></p>
                            <%
                                }
                            %>
                            <div class="m-3">
                                <label class="form-label fw-bold">Email:</label>
                                <input id="email1" type="text" name="email" class="form-control" placeholder="Enter email">
                                <p id="emailerror1"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Staffname:</label>
                                <input id="username" type="text" name="staffname" class="form-control" placeholder="Enter staffname">
                                <p id="usernameerror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Password:</label>
                                <input id="password1" type="password" name="password" class="form-control"
                                       placeholder="Enter password">
                                <p id="passerror1"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Confirm password:</label>
                                <input id="repassword" type="password" name="repassword" class="form-control"
                                       placeholder="Enter password again">
                                <p id="repasserror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Day of birth:</label>
                                <input id="birthday" type="date" name="birthday" class="form-control"
                                       placeholder="Enter your email">
                                <p id="birtherror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Phone number:</label>
                                <input id="phone" type="text" name="phone" class="form-control" placeholder="Enter phone number">
                                <p id="phoneerror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Address:</label>
                                <textarea id="address" name="address" cols="30" rows="5" class="form-control"
                                          placeholder="Enter address"></textarea>
                                <p id="addresserror"></p>
                            </div>
                            <div class="buttongroup text-center">
                                <input type="hidden" name="staffID" value="<%= session.getAttribute("id")%>">
                                <button type="submit"  value="Add" name="addNewStaff" id="btnadd" class="rounded-3" onclick="checkRegis()">Add</button>
                                <button type="reset" value="Cancel" id="btncancel" class="rounded-3">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <script>
                                    $(document).ready(function () {
                                        $("#example").DataTable();
                                    });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"
        ></script>
        <script src="/P-System/validate.js"></script>
        <script>
                                    const manage = document.getElementById("managestaff");
                                    const add = document.getElementById("addstaff");
                                    const btnadd = document.getElementById("btnaddstaff");
                                    var btncancel = document.getElementById("btncancel");

                                    btnadd.addEventListener("click", function () {
                                        add.style.display = "block";
                                        manage.style.display = "none";
                                    });

                                    btncancel.addEventListener("click", function () {
                                        location.reload();
                                    });
        </script>
        <%
            if (request.getAttribute("display") != null) {
        %>
        <script>
            const divContent1 = document.getElementById("addstaff");
            const divProfile = document.getElementById("managestaff");
            divContent1.style.display = "block";
            divProfile.style.display = "none";
        </script>
        <%
            }
        %>
    </body>
</html>

