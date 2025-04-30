package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.ContactModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactService {
    private Connection connection;

    public ContactService() {
        try {
            connection = DBConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public boolean saveMessage(ContactModel contact) {
        String query = "INSERT INTO contact_messages (name, email, number, message) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getNumber());
            stmt.setString(4, contact.getMessage());

            int result = stmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
