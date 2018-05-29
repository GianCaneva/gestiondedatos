using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FrbaHotel.Clases
{
    class ManejoDeConexion
    {
        public SqlCommand manejadorConexion { get; set; }
        private ConexionABase conexion = new ConexionABase();

        public SqlCommand Ejecutar(string query, IList<SqlParameter> listaDeParametros)
        {
            this.manejadorConexion = new SqlCommand();
            // agrega el query a ejecutar, se puede pasar SP o funciones tambien
            this.manejadorConexion.CommandText = query;

            // carga todos los parametros al SqlCommand
            if (listaDeParametros != null)
            {
                foreach (SqlParameter unParametro in listaDeParametros)
                {
                    this.manejadorConexion.Parameters.Add(unParametro);
                }
            }

            // Si todavia no se establecio una conexion la abre (clase ConexioABase)
            if (this.manejadorConexion.Connection == null)
            {
                this.manejadorConexion.Connection = conexion.AbrirConexion();
            }

            return this.manejadorConexion;
        }

    }
}