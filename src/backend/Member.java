package backend;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Member {
    private Integer idMember;
    private String namaMember;
    private String noTelp;
    private String email;
    private Integer points;
    private LocalDateTime tanggalJoin;
    
    // Constructors
    public Member() {}
    
    public Member(Integer idMember, String namaMember, String noTelp, String email, 
                  Integer points, LocalDateTime tanggalJoin) {
        this.idMember = idMember;
        this.namaMember = namaMember;
        this.noTelp = noTelp;
        this.email = email;
        this.points = points;
        this.tanggalJoin = tanggalJoin;
    }
    
    // Getters and Setters
    public Integer getIdMember() { return idMember; }
    public void setIdMember(Integer idMember) { this.idMember = idMember; }
    
    public String getNamaMember() { return namaMember; }
    public void setNamaMember(String namaMember) { this.namaMember = namaMember; }
    
    public String getNoTelp() { return noTelp; }
    public void setNoTelp(String noTelp) { this.noTelp = noTelp; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public Integer getPoints() { return points; }
    public void setPoints(Integer points) { this.points = points; }
    
    public LocalDateTime getTanggalJoin() { return tanggalJoin; }
    public void setTanggalJoin(LocalDateTime tanggalJoin) { this.tanggalJoin = tanggalJoin; }
    
    // Database operations
    private Connection getConnection() throws SQLException {
        String url = "jdbc:postgresql://localhost:5432/kasir_cafe";
        String user = "postgres";
        String password = "your_password";
        return DriverManager.getConnection(url, user, password);
    }
    
    public void save() {
        if (this.idMember == 0) {
            insert();
        } else {
            update();
        }
    }
    
    private void insert() {
        String sql = "INSERT INTO member (nama_member, no_telp, email, points, tanggal_join) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, this.namaMember);
            stmt.setString(2, this.noTelp);
            stmt.setString(3, this.email);
            stmt.setInt(4, this.points != null ? this.points : 0);
            stmt.setTimestamp(5, this.tanggalJoin != null ? 
                Timestamp.valueOf(this.tanggalJoin) : Timestamp.valueOf(LocalDateTime.now()));
            
            stmt.executeUpdate();
            
            // Get generated ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                this.idMember = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting member: " + e.getMessage(), e);
        }
    }
    
    private void update() {
        String sql = "UPDATE member SET nama_member = ?, no_telp = ?, email = ?, points = ? " +
                    "WHERE id_member = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, this.namaMember);
            stmt.setString(2, this.noTelp);
            stmt.setString(3, this.email);
            stmt.setInt(4, this.points != null ? this.points : 0);
            stmt.setInt(5, this.idMember);
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating member: " + e.getMessage(), e);
        }
    }
    
    public boolean delete() {
        String sql = "DELETE FROM member WHERE id_member = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, this.idMember);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting member: " + e.getMessage(), e);
        }
    }
    
    public Member getById(int id) {
        String sql = "SELECT * FROM member WHERE id_member = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToMember(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting member by ID: " + e.getMessage(), e);
        }
        return null;
    }
    
    public List<Member> getAll() {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM member ORDER BY id_member";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                members.add(mapResultSetToMember(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting all members: " + e.getMessage(), e);
        }
        return members;
    }
    
    public List<Member> search(String keyword) {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM member WHERE " +
                    "LOWER(nama_member) LIKE LOWER(?) OR " +
                    "no_telp LIKE ? OR " +
                    "LOWER(email) LIKE LOWER(?) " +
                    "ORDER BY id_member";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                members.add(mapResultSetToMember(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error searching members: " + e.getMessage(), e);
        }
        return members;
    }
    
    private Member mapResultSetToMember(ResultSet rs) throws SQLException {
        Member member = new Member();
        member.setIdMember(rs.getInt("id_member"));
        member.setNamaMember(rs.getString("nama_member"));
        member.setNoTelp(rs.getString("no_telp"));
        member.setEmail(rs.getString("email"));
        member.setPoints(rs.getInt("points"));
        
        Timestamp timestamp = rs.getTimestamp("tanggal_join");
        if (timestamp != null) {
            member.setTanggalJoin(timestamp.toLocalDateTime());
        }
        
        return member;
    }
}