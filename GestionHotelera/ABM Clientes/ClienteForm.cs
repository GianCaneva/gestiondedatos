using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GestionHotelera.ABM_Clientes
{
    public partial class ClienteForm : Form
    {
        public ClienteForm()
        {
            InitializeComponent();
        }

        private void bntClienteAlta_Click(object sender, EventArgs e)
        {
            this.Hide();
            new AltaCliente().ShowDialog();
            this.Close();
        }

        private void btnClienteEditar_Click(object sender, EventArgs e)
        {
            this.Hide();
            new AgregarCliente().display;
            this.Close();
        }

        private void btnClienteEliminar_Click(object sender, EventArgs e)
        {
            this.Hide();
            new AgregarCliente().display;
            this.Close();
        }

        private void btnClienteBuscar_Click(object sender, EventArgs e)
        {
            this.Hide();
            new MenuPrincipal().ShowDialog();
            this.Close();
        }

        private void btnClienteVolver_Click(object sender, EventArgs e)
        {
            this.Hide();
            new MenuPrincipal().ShowDialog();
            this.Close();
        }

    }
}
