/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.blob_practice;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 *
 * @author HP
 */
@Controller
public class Blob_controller extends HttpServlet 
{
    @RequestMapping("/home")
    public String index()
    {
        return "start";
    }
    @RequestMapping(value="/upload_page")
    public String upload()
    {
        return"upload_page";
    }
    
    @RequestMapping(value = "/upload_successful", method = RequestMethod.POST)
    public String submitresForm(HttpServletRequest request, 
            HttpServletResponse response, 
            @RequestParam("a") String a,
            @RequestParam("b")String b,
            @RequestParam("c") CommonsMultipartFile file) 
    {

        try {
            HttpSession session = request.getSession();

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbms", "root", "Monu@2003");
            PreparedStatement stmt = con.prepareStatement("INSERT INTO images (name, Id, data) values (?,?,?)");
            
            stmt.setString(1, a);
            stmt.setInt(2, Integer.parseInt(b));

            
            InputStream inputStream = null;

            if (file != null) {
                inputStream = file.getInputStream();
            }
            
            if (inputStream != null) {
               stmt.setBlob(3, inputStream);
            }
            int row = stmt.executeUpdate();
            if (row > 0) {
                return "start";
            }
            return "start";
        }
        catch (SQLException | ClassNotFoundException | IOException ex) 
        {
            throw new RuntimeException(ex);
        }
    }
    
    @RequestMapping(value = "/viewuploaddocuments", method = RequestMethod.GET)
    public String viewing() {
        return "view_document";
    }
    
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deletep() {
        return "delete_document";
    }
    
    @RequestMapping(value = "/deletesucc", method = RequestMethod.POST)
    public String deletedocume(@RequestParam("a") String a) {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbms", "root", "Monu@2003");
            PreparedStatement stmt = con.prepareStatement("delete FROM images WHERE id=?");
            stmt.setString(1, a);

            stmt.executeUpdate();
        } catch (Exception K) {
            System.out.println(K.getMessage());
        }
        return "start";
    }
    
}
