<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%int cnt = 0;%>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="https://lh3.googleusercontent.com/LFzwHm1EEee15GGA-PMBtnoQQXNsqzprA5ZUaWxiA2EHAMt46K2l9_mm9TurXW_tV1cMw6y-TKD5p4JyrxnMIvkjJIRQZhGP71WYpzqZrbgQORbgH2wvkcmyFHUEUuTuA0S4LR-3MVK2FN7hl6Xu9KBHKhCD3OsVjwNVaIzuqJazzcOXW7h1lEG1t4_IhzFHFcF0_w6EOxrpU5ar-3XhAoRaUeY1o6yjGl_0gZiCb7BF6X0IUPdz3JVGIC8jKNRyK-3OIyKQMC8k8BLYKsebN9SsL3u8f5rfxW-BGmShHgMlKu9IglFG3P8PBHwsGQ6tsYmGg2kp54U0LmRQ0oq3saSW1v-M78A_rnk8hgcqnqV4MZQyfQPxDiccHs3EIjL-Gjq39YaEzYbrijqkWFucRCrW7MRiRMkvI_-FEUYRe1teNCjj-NoAJuxiNpl_t1Fy40Sk9fPo2tDUnHMg_Oy57n7TaKyfwUiuKY1GvnAcrm4cVmOBDWOXj_i4bjHRrKcHwO1jMCbjYFcvY-43kByOyJw-Q0Ll0W64cI9GsvFj_pDGJm9VD4Vwj6pJ533yZfY1OTSsqk9p52hqGxNU6NnRGm53eJmmpTZ5IQnlrPqMirsjtvP2MqRDuAMK25jiZQ0Cm5_Wki5iguHt_8A7svFU7Uh_Ow5oex-jTSBHmhZo0ZS5IjUwAb_7bGnZF-XN0LkoMDjPX9S79DI1wiy3T9l8CIHk9qoRJn82kVcK5U4gnWdlDkw5kZ91tBLx8Xiv6OoOmGySndA6mGO8WeMeCKb4CgHFwt2CSKs6wtA22R99ttZCaf-H6Hh2B1HEQgQhBPI9tWA1TTDdieYKle0MsuYtJN9DqENGWkZN-H9w7Z8U68msi59-cfBKdyPdaWiEB4Ru2MkJ9Y9UsOWHs-nTrjg9M75mcxwCTfsrgs972xnm0NR-LZHdfuVgjl7vjG0m5VGBzNG9eKVBi_hQL4-59fAJtA=w266-h317-s-no?authuser=0" type="image/x-icon">
        <title>BLOB Concept</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">


        <style>
            body{
                padding-top: 2em;
                text-align: center;
            }
            .command{
                padding: 2em;
            }

        </style>

    </head>

    <body>
        <h1>Your Uploaded Documents </h1>
        <div class="command">
            <a href="home"><button>Go to Home Page</button></a>
            <a href="upload_page"><button>Click to Upload Documents Again</button></a>
            <a href="delete"><button>Click to Delete Documents</button></a>

        </div>


        <div class="container">
            <div class="row">
                <div class="col">


                    <table id="myTable" lign="center" border="10" border width="100" style="width:50%" class="table table-hover table-dark">
                        <thead>

                            <tr>
                                <th>Name</th>
                                <th>ID</th>
                                <th>Document</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                int colind = 0;
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");

                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbms", "root", "Monu@2003");

                                    PreparedStatement stmt = con.prepareStatement("select * from images");
                                    ResultSet rs = stmt.executeQuery();

                                    while (rs.next()) {

                                        Blob imageBlob = rs.getBlob("data");
                                        InputStream imageStream = imageBlob.getBinaryStream();
                                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                                        byte[] buffer = new byte[4096];
                                        int n = 0;
                                        while (-1 != (n = imageStream.read(buffer))) {
                                            outputStream.write(buffer, 0, n);
                                        }
                                        byte[] imageBytes = outputStream.toByteArray();
                            %>

                            <tr>
                                <td><%=rs.getString(1)%></td>
                                <td><%=rs.getString(2)%></td>
                                <td class="item-td">
                                    <div class="card item-card" align="center" style="width: 14rem;">
                                        <img class="card-img-top" alt="..." style="object-fit: cover;width: 100%;height: 100%;" src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(imageBytes)%>"/>
                                        <!--align="center" margin="40px"-->
                                    </div>
                                </td>
                                <%colind++;%>
                                <% if (colind % 4 == 0) {
                                %></tr>
                                <%}%>
                                <%
                                        }
                                    } catch (Exception k) {
                                        System.out.println(k.getMessage());
                                    }
                                %>
                        </tbody>
                    </table>

                </div>
            </div>   
        </div>
    </body>
</html>