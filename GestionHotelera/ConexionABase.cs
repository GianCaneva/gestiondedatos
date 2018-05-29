using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace FrbaHotel.Clases
{
    class ConexionABase
    {
        private SqlConnection Conexion { get; set; }

        public SqlConnection AbrirConexion()
        {

            string conectionString = "Data Source=localhost\\SQLSERVER2012;Initial Catalog=GD1C2018;Persist Security Info=True;User ID=gdHotel2018;Password=gd2018";
            SqlConnection conexionABase = new SqlConnection(conectionString);
            conexionABase.Open();
            SqlCommand comm = new SqlCommand("SET ARITHABORT ON", conexionABase);
            comm.ExecuteNonQuery();
            return conexionABase;
        }

        public void CerrarConexion()
        {
            if (this.Conexion != null)
            {
                this.Conexion.Close();
            }
        }
    }
}