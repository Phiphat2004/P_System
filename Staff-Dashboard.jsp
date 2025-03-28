<%-- Document : showOrder Created on : Oct 18, 2023, 3:13:07 PM Author : admin --%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DAOs.OrderDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard</title>
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
        <style>
            .main-body {
                display: flex;
            }

            .navbar {
                background-color: black;
                color: white;
                text-decoration: none;
                font-size: 2.5rem; /* Replaced xx-large with rem */
                font-weight: bold;
            }

            .allbody {
                background-color: rgb(182, 182, 182);
            }

            .listcontent {
                font-size: x-large;
                margin-left: -30px;
                padding-top: 30px;
                width: 130px;
                min-height: 1000px; /* Use min-height */
                background-color: black;
                color: white;
            }

            .listcontent:hover {
                font-size: x-large;
                width: 350px;
                min-height: 1000px; /* Use min-height */
                background-color: black;
                color: white;
                transition: all 0.1s linear;
            }

            .listcontent:hover span {
                display: inline-block;
            }

            .listcontent span {
                display: none;
            }

            .listcontent li {
                padding: 10px;
                width: 300px;
                list-style-type: none;
            }

            .listcontent li:active {
                background-color: white;
                padding: 10px;
                width: 318px;
                list-style-type: none;
            }

            .listcontent li a {
                padding-left: 20px;
                text-decoration: none;
                color: white;
                width: 160px;
            }

            .listcontent li a:active {
                text-decoration: none;
                color: black;
                width: 160px;
            }

            .content {
                background-color: white;
                margin: 20px;
                border-radius: 20px;
                display: inline-block;
                justify-items: center;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 10px;
                font-size: large;
                align-content: center;
            }

            .paymentamount {
                display: flex;
            }

            .amount {
                display: flex;
            }

            .today-data {
                background-color: rgb(207, 179, 235);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }
            .today-data:hover {
                background-color: rgb(159, 109, 209);
            }

            .month-data {
                background-color: rgb(143, 215, 197);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .month-data:hover {
                background-color: rgb(55, 189, 156);
            }
            .year-data {
                background-color: rgb(234, 145, 149);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .year-data:hover {
                background-color: rgb(215, 104, 110);
            }

            .fa-dollar {
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

            .finance {
                background-color: white;
                margin: 20px;
                border-radius: 20px;
                width: 90%;
                display: inline-block;
                justify-items: center;
                padding: 20px;
                font-size: large;
            }

            table {
                padding: 20px;
            }

            table td:first-child {
                width: 70px;
            }

            #orderChart {
                max-width: 100%;
                margin: 20px auto;
            }
            .arrow_box {
                padding: 10px;
                background: #ffffff;
                border: 1px solid #dcdcdc;
            }

            .apexcharts-menu-icon {
                display: none !important; /* Fallback in case toolbar option doesn't work */
            }
        </style>
    </head>
    <body>
        <%
            if (session.getAttribute("acc") == null) {
                boolean flag = false;
                Cookie[] cookies = request.getCookies();
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
        <%
            OrderDAO ord = new OrderDAO();
            DecimalFormat decimalFormat = new DecimalFormat("#,### vnđ");
            String formattedDailyRevenue = "N/A";
            String formattedMonthlyRevenue = "N/A";
            String formattedYearlyRevenue = "N/A";
            try {
                double dailyRevenue = ord.dailyRevenue();
                formattedDailyRevenue = decimalFormat.format(dailyRevenue);
            } catch (Exception e) {
                out.print("Error fetching daily revenue: " + e.getMessage());
            }
            try {
                double monthlyRevenue = ord.monthRevenue();
                formattedMonthlyRevenue = decimalFormat.format(monthlyRevenue);
            } catch (Exception e) {
                out.print("Error fetching monthly revenue: " + e.getMessage());
            }
            try {
                double yearlyRevenue = ord.yearlyRevenue();
                formattedYearlyRevenue = decimalFormat.format(yearlyRevenue);
            } catch (Exception e) {
                out.print("Error fetching yearly revenue: " + e.getMessage());
            }
        %>
        <a href="" class="navbar ps-5"> P-System - STAFF </a>
        <div class="main-body">
            <nav>
                <ul class="listcontent">
                    <li><a href="/P-System/Manager/Dashboard"><i class="fa fa-home me-3"></i><span>Dashboard</span></a></li>
                    <li><a href="/P-System/Manager/manageProduct?type=view"><i class="fa fa-product-hunt me-3"></i><span>Product</span></a></li>
                    <li><a href="/P-System/Manager/importmanagement"><i class="fa fa-download me-3"></i><span>Import</span></a></li>
                    <li><a href="/P-System/Manager/ordermanagement"><i class="fa fa-file me-3"></i><span>Orders</span></a></li>
                    <li><a href="/P-System/Manager/monthRevenue"><i class="fa fa-calendar me-3"></i><span>Month revenue</span></a></li>
                    <li><a href="/P-System/Manager/customermanagement"><i class="fa fa-user me-3"></i><span>Customer</span></a></li>
                    <li><a href="/P-System/Logout"><i class="fa fa-sign-out me-3"></i><span>Logout</span></a></li>
                </ul>
            </nav>
            <div class="allbody">
                <div class="content container">
                    <h2>Payment amount</h2>
                    <div class="paymentamount pt-4">
                        <div class="today-data">
                            <h5>Sale today</h5>
                            <div class="amount">
                                <div class="ms-5">
                                    <label>Payment amount</label>
                                    <p><%= formattedDailyRevenue %></p>
                                </div>
                                <i class="fa fa-dollar"></i>
                            </div>
                        </div>
                        <div class="month-data">
                            <h5>Sale this month</h5>
                            <div class="amount">
                                <div class="ms-5">
                                    <label>Payment amount</label>
                                    <p><%= formattedMonthlyRevenue %></p>
                                </div>
                                <i class="fa fa-dollar"></i>
                            </div>
                        </div>
                        <div class="year-data">
                            <h5>Sale this year</h5>
                            <div class="amount">
                                <div class="ms-5">
                                    <label>Payment amount</label>
                                    <p><%= formattedYearlyRevenue %></p>
                                </div>
                                <i class="fa fa-dollar"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="finance">
                    <h2>Finance data</h2>
                    <div id="orderChart"></div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function () {
                var orders = [
                    <c:forEach items="${listOr}" var="o" varStatus="loop">
                        {
                            orderId: '${o.orderID}',
                            total: ${o.totalPrice},
                            date: '${o.purchaseDate}'
                        }${loop.last ? '' : ','}
                    </c:forEach>
                ];

                // Check if orders array is empty
                if (orders.length === 0) {
                    $("#orderChart").html("<p>No data available to display the chart.</p>");
                    return;
                }

                // Check if ApexCharts library loaded
                if (typeof ApexCharts === 'undefined') {
                    console.error("ApexCharts library failed to load.");
                    $("#orderChart").html("<p>Error: Unable to load the chart library.</p>");
                    return;
                }

                var options = {
                    series: [{
                        name: 'Tổng tiền',
                        data: orders.map(order => order.total)
                    }],
                    chart: {
                        type: 'bar',
                        height: 350,
                        toolbar: {
                            show: false
                        }
                    },
                    plotOptions: {
                        bar: {
                            horizontal: false,
                            columnWidth: '55%',
                            endingShape: 'rounded'
                        }
                    },
                    dataLabels: {
                        enabled: true,
                        formatter: function (val) {
                            return val.toLocaleString('vi-VN') + ' đ';
                        }
                    },
                    xaxis: {
                        categories: orders.map(order => order.orderId),
                        title: {
                            text: 'Mã đơn hàng'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Tổng tiền (VNĐ)'
                        }
                    },
                    tooltip: {
                        y: {
                            formatter: function (val) {
                                return val.toLocaleString('vi-VN') + " VNĐ"
                            }
                        },
                        custom: function({series, seriesIndex, dataPointIndex, w}) {
                            var order = orders[dataPointIndex];
                            return '<div class="arrow_box">' +
                                '<span>Order ID: ' + order.orderId + '</span><br/>' +
                                '<span>Date: ' + order.date + '</span><br/>' +
                                '<span>Total: ' + series[seriesIndex][dataPointIndex].toLocaleString('vi-VN') + ' VNĐ</span>' +
                                '</div>';
                        }
                    }
                };

                var chart = new ApexCharts(document.querySelector("#orderChart"), options);
                chart.render();
            });
        </script>
    </body>
</html>