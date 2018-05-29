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
    public partial class AltaCliente : Form
    {
        /*
        public AltaCliente()
        {
            InitializeComponent();
        }

        private void mcAltaClienteFechaDeNacimiento_DateChanged(object sender, DateRangeEventArgs e)
        {

        }

        private void btnAltaClienteFechaDeNacimiento_Click(object sender, EventArgs e)
        {
            mcAltaClienteFechaDeNacimiento.Visible = true;
        }

        private void mcAltaClienteFechaDeNacimiento_DateSelected(object sender, System.Windows.Forms.DateRangeEventArgs e)
        {
            txtAltaClienteFechaDeNacimiento.Text = e.Start.ToShortDateString();
            mcAltaClienteFechaDeNacimiento.Visible = false;

        }      

        private void cmdAltaClienteGuardar_Click(object sender, EventArgs e)
        {
            String nombre = txtAltaClienteNombre.Text;
            String apellido = txtAltaClienteApellido.Text;
            DateTime fechaDeNacimiento;
            DateTime.TryParse(txtAltaClienteFechaDeNacimiento.Text , out fechaDeNacimiento);
            String nacionalidad = cboAltaClienteNacionalidad.Text;
            String tipoDeDocumento = cboAltaClienteTipoDeDocumento.Text;
            String documento = txtAltaClienteDocumento.Text;
            String mail = txtAltaClienteMail.Text;
            String telefono = txtAltaClienteTelefono.Text;

            String calle = txtAltaClienteCalle.Text;
            String numero = txtAltaClienteNumero.Text;
            String piso = txtAltaClientePiso.Text;
            String departamento = txtAltaClienteDepartamento.Text;
            String localidad = txtAltaClienteLocalidad.Text;
            String paisDeOrigen = txtAltaClientePaisDeOrigen.Text;
   
            try
            {
                if (nombre == "")
                    throw new CampoVacioException("Nombre");
                if (apellido == "")
                    throw new CampoVacioException("Apellido");
                if (fechaDeNacimiento == "")
                    throw new CampoVacioException("FechaDeNacimiento");
                if (nacionalidad == "")
                    throw new CampoVacioException("Nacionalidad");
                if (tipoDeDocumento == "")
                    throw new CampoVacioException("TipoDeDocumento");
                if (documento == "")
                    throw new CampoVacioException("Documento");
                if (telefono == "")
                    throw new CampoVacioException("Telefono");



            }        
        }

        private void btnAltaClienteLimpiar_Click(object sender, EventArgs e)
        {
            txtAltaClienteNombre.Text = "";
            txtAltaClienteApellido.Text = "";
            txtAltaClienteFechaDeNacimiento.Text = "";
            cboAltaClienteNacionalidad.Text = "";
            cboAltaClienteTipoDeDocumento.Text = "";
            txtAltaClienteDocumento.Text = "";
            txtAltaClienteMail.Text = "";
            txtAltaClienteTelefono.Text = "";
            txtAltaClienteCalle.Text = "";
            txtAltaClienteNumero.Text = "";
            txtAltaClientePiso.Text = "";
            txtAltaClienteDepartamento.Text = "";
            txtAltaClienteLocalidad.Text = "";
            txtAltaClientePaisDeOrigen.Text = "";
        }

        private void btnAltaClienteHome_Click(object sender, EventArgs e)
        {
            VolverAlMenuPrincial();
        }

        private void btnAltaClienteVolver_Click(object sender, EventArgs e)
        {
            this.Hide();
            new ClienteForm().ShowDialog();
            this.Close();
        }

        private void VolverAlMenuPrincial()
        {
            this.Hide();
            new MenuPrincipal().ShowDialog();
            this.Close();
        }
         * */
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // AltaCliente
            // 
            this.ClientSize = new System.Drawing.Size(284, 262);
            this.Name = "AltaCliente";
            this.Load += new System.EventHandler(this.AltaCliente_Load);
            this.ResumeLayout(false);

        }

        private void AltaCliente_Load(object sender, EventArgs e)
        {

        }
    }
}
