<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
    prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@page
        contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Month Revenue</title>
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
                        height: 850px;
                        background-color: black;
                        color: white;
                    }

                    .listcontent:hover{
                        font-size: x-large;
                        width: 350px;
                        height: 850px;
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
                <a href="" class="navbar ps-5"> P-System - STAFF</a>
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
                                <a href="/P-System/Manager/customermanagement"
                                   ><i class="fa fa-user me-3"></i>
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
                    <div class="container">
                        <div class="content">
                            <h1>Month Revenue</h1>
                            <table class="table-bordered" id="example">
                                <thead>
                                    <tr>
                                        <th class="align-middle">Month</th>
                                        <th class="align-middle">Total revenue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listRevenue}" var="o">
                                        <tr>
                                            <th class="align-middle">${o.monthRevenue}</th>
                                            <th class="align-middle">
                                                <fmt:formatNumber
                                                    value="${o.totalRevenue}"
                                                    type="number"
                                                    pattern="###,### vnđ"
                                                    />
                                            </th>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
            </body>
        </html>
