using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace GestionHotelera
{
    class DatabaseConnecion
    {

        private SqlConnection connection { get; set; }

        public SqlConnection openConnecion()
        {
            string conf = ConfigurationManager.AppSettings["configuracionSQL"].ToString();
            SqlConnection conn = new SqlConnection(conf);
            conn.Open();
            SqlCommand comm = new SqlCommand("SET ARITHABORT ON", conn);
            comm.ExecuteNonQuery();
            return conn;
        }

        public void closeConnection()
        {
            if (this.connection != null)
            {
                this.connection.Close();
            }
        }

    }
}
