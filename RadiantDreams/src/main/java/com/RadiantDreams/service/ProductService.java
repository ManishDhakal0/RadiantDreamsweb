package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.ProductModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    /**
     * Fetches all products from the database
     * @return List<ProductModel>
     */
    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();
        String query = "SELECT * FROM product";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getString("category"));
                product.setAvailability(rs.getBoolean("availability"));
                product.setImageUrl(rs.getString("image_url"));
                product.setQuantity(rs.getInt("quantity"));

                products.add(product);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        

        return products;
    }
    public ProductModel getProductById(int id) {
        String query = "SELECT * FROM product WHERE id = ?";
        
        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ProductModel product = new ProductModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getString("category"));
                product.setAvailability(rs.getBoolean("availability"));
                product.setImageUrl(rs.getString("image_url"));
                product.setQuantity(rs.getInt("quantity"));
                return product;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }
    public List<ProductModel> getProductsByCategory(String category) {
        List<ProductModel> products = new ArrayList<>();
        String query = "SELECT * FROM product WHERE category = ?";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getString("category"));
                product.setAvailability(rs.getBoolean("availability"));
                product.setImageUrl(rs.getString("image_url"));
                product.setQuantity(rs.getInt("quantity"));

                products.add(product);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return products;
    }


}
