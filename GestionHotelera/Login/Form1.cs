using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace GestionHotelera.Login
{
    public partial class Form1 : Form
    {
        private ManejoDeConexion conector;
        

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (textUsuario.Text == "")
                {
                    MessageBox.Show("Falta ingresar el nombre de usuario", "Datos faltantes", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                if (textContrasenia.Text == "")
                {
                    MessageBox.Show("Falta ingresar la contraseña", "Datos faltantes", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                SqlCommand command = new SqlCommand();
                IList<SqlParameter> listaDeParametros = new List<SqlParameter>();

                String usuario = textUsuario.Text;
                String contrasenia = textContrasenia.Text;

                listaDeParametros.Add(new SqlParameter("@usuario", usuario));
                listaDeParametros.Add(new SqlParameter("@pass", contrasenia));

                String query = "BIG_DATA.Login";
                command = conector.Ejecutar(query, listaDeParametros);
                command.CommandType = CommandType.StoredProcedure;
                command.ExecuteNonQuery();

                command.Parameters.Clear();
                listaDeParametros.Clear();

                query = "SELECT idRol FROM BIG_DATA.Usuario WHERE username = @usuario";
                listaDeParametros.Add(new SqlParameter("@usuario", usuario));
                command = conector.Ejecutar(query, listaDeParametros);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    MessageBox.Show("" + Convert.ToDecimal(reader["idRol"]));
                }
            }
            catch (Exception exr)
            {
                MessageBox.Show("ERROR" + exr.Message);
            }

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            conector = new ManejoDeConexion();
        }

    

    }
}
