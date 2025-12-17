package backend;

import java.sql.*;
import java.util.ArrayList;

public class TransaksiBackend {

    // --- MODEL: Transaksi ---
    public static class Transaksi {
        public int idTransaksi, idPesanan, idMember;
        public String waktu, metode, nomor;
        public double totalBelanja, diskon, pajak, totalAkhir, nominalBayar, kembalian;
    }

    // --- MODEL: Pesanan ---
    public static class Pesanan {
        private int idOrder, noMeja;
        public int getIdOrder() { return idOrder; }
        public void setIdOrder(int id) { this.idOrder = id; }
        public int getNoMeja() { return noMeja; }
        public void setNoMeja(int no) { this.noMeja = no; }
    }

    // --- CONTROLLER: TransaksiController ---
    public static class TransaksiController {
        public static int getLastId() {
            int id = 0;
            String q = "SELECT MAX(id_transaksi) FROM transaksi";
            try (ResultSet rs = dbHelper.selectQuery(q)) {
                if (rs != null && rs.next()) id = rs.getInt(1);
            } catch (Exception e) { e.printStackTrace(); }
            return id;
        }

        public static int insert(Transaksi t) {
            // Karena PostgreSQL sensitif terhadap format timestamp, kita gunakan casting string ke timestamp di Query
            String query = String.format(
                "INSERT INTO transaksi (id_order, id_member, waktu_transaksi, total_belanja, diskon, service_tax, total_akhir, metode_pembayaran, nominal_bayar, kembalian, nomor_kartu_ewallet) " +
                "VALUES (%d, %s, CAST('%s' AS TIMESTAMP), %.2f, %.2f, %.2f, %.2f, '%s', %.2f, %.2f, '%s')",
                t.idPesanan, 
                (t.idMember > 0 ? String.valueOf(t.idMember) : "NULL"), 
                t.waktu, 
                t.totalBelanja, t.diskon, t.pajak, t.totalAkhir, 
                t.metode, t.nominalBayar, t.kembalian, t.nomor
            );
            
            return dbHelper.insertQueryGetId(query);
        }
    }

    // --- CONTROLLER: PesananController ---
    public static class PesananController {
        public static ArrayList<Pesanan> getNomorMejaTerakhir() {
            ArrayList<Pesanan> list = new ArrayList<>();
            // Gunakan status_bayar untuk membedakan meja yang sedang aktif
            String q = "SELECT id_pesanan, no_meja FROM pesanan WHERE status_bayar = 0 ORDER BY no_meja ASC";
            try (ResultSet rs = dbHelper.selectQuery(q)) {
                if (rs != null) {
                    while (rs.next()) {
                        Pesanan p = new Pesanan();
                        p.setIdOrder(rs.getInt("id_pesanan"));
                        p.setNoMeja(rs.getInt("no_meja"));
                        list.add(p);
                    }
                }
            } catch (Exception e) { e.printStackTrace(); }
            return list;
        }

        public static double getTotalBelanja(int idOrder) {
            double total = 0;
            String q = "SELECT SUM(subtotal) FROM detail_pesanan WHERE id_pesanan = " + idOrder;
            try (ResultSet rs = dbHelper.selectQuery(q)) {
                if (rs != null && rs.next()) total = rs.getDouble(1);
            } catch (Exception e) { e.printStackTrace(); }
            return total;
        }
        
        public static void updateStatusBayar(int idOrder) {
            String q = "UPDATE pesanan SET status_bayar = 1 WHERE id_pesanan = " + idOrder;
            dbHelper.executeQuery(q);
        }
    }

    // --- CONTROLLER: MemberController ---
    public static class MemberController {
        public static int getIdMemberByNama(String nama) {
            int id = 0;
            // PostgreSQL casting untuk case-insensitive search
            String q = "SELECT id_member FROM member WHERE nama_member ILIKE '" + nama + "'";
            try (ResultSet rs = dbHelper.selectQuery(q)) {
                if (rs != null && rs.next()) id = rs.getInt("id_member");
            } catch (Exception e) { e.printStackTrace(); }
            return id;
        }

        public static int getPoinMember(int id) {
            int poin = 0;
            String q = "SELECT poin FROM member WHERE id_member = " + id;
            try (ResultSet rs = dbHelper.selectQuery(q)) {
                if (rs != null && rs.next()) poin = rs.getInt("poin");
            } catch (Exception e) { e.printStackTrace(); }
            return poin;
        }
    }
}