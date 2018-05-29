/*
namespace GestionHotelera.ABM_Clientes
{
    partial class AltaCliente
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.gbAltaClienteDatosPersonales = new System.Windows.Forms.GroupBox();
            this.mcAltaClienteFechaDeNacimiento = new System.Windows.Forms.MonthCalendar();
            this.txtAltaClienteTelefono = new System.Windows.Forms.TextBox();
            this.txtAltaClienteMail = new System.Windows.Forms.TextBox();
            this.txtAltaClienteDocumento = new System.Windows.Forms.TextBox();
            this.cboAltaClienteTipoDeDocumento = new System.Windows.Forms.ComboBox();
            this.cboAltaClienteNacionalidad = new System.Windows.Forms.ComboBox();
            this.btnAltaClienteFechaDeNacimiento = new System.Windows.Forms.Button();
            this.txtAltaClienteFechaDeNacimiento = new System.Windows.Forms.TextBox();
            this.txtAltaClienteApellido = new System.Windows.Forms.TextBox();
            this.txtAltaClienteNombre = new System.Windows.Forms.TextBox();
            this.lblTelefono = new System.Windows.Forms.Label();
            this.lblMail = new System.Windows.Forms.Label();
            this.lblDocumento = new System.Windows.Forms.Label();
            this.lblAltaClienteTipoDeDocumento = new System.Windows.Forms.Label();
            this.lblAltaClienteNacionalidad = new System.Windows.Forms.Label();
            this.lblAltaClienteFechaDeNacimiento = new System.Windows.Forms.Label();
            this.lblAltaClienteApellido = new System.Windows.Forms.Label();
            this.lblAltaClienteNombre = new System.Windows.Forms.Label();
            this.gbAltaClienteDireccion = new System.Windows.Forms.GroupBox();
            this.txtAltaClientePaisDeOrigen = new System.Windows.Forms.TextBox();
            this.txtAltaClienteLocalidad = new System.Windows.Forms.TextBox();
            this.txtAltaClienteDepartamento = new System.Windows.Forms.TextBox();
            this.txtAltaClientePiso = new System.Windows.Forms.TextBox();
            this.txtAltaClienteNumero = new System.Windows.Forms.TextBox();
            this.txtAltaClienteCalle = new System.Windows.Forms.TextBox();
            this.lblAltaClientePaisDeOrigen = new System.Windows.Forms.Label();
            this.lblAltaClienteLocalidad = new System.Windows.Forms.Label();
            this.lblAltaClienteDepartamento = new System.Windows.Forms.Label();
            this.lblAltaClientePiso = new System.Windows.Forms.Label();
            this.lblAltaClienteNumero = new System.Windows.Forms.Label();
            this.lblAltaClienteCalle = new System.Windows.Forms.Label();
            this.btnAltaClienteVolver = new System.Windows.Forms.Button();
            this.btnAltaClienteHome = new System.Windows.Forms.Button();
            this.cmdAltaClienteGuardar = new System.Windows.Forms.Button();
            this.btnAltaClienteLimpiar = new System.Windows.Forms.Button();
            this.gbAltaClienteDatosPersonales.SuspendLayout();
            this.gbAltaClienteDireccion.SuspendLayout();
            this.SuspendLayout();
            // 
            // gbAltaClienteDatosPersonales
            // 
            this.gbAltaClienteDatosPersonales.Controls.Add(this.mcAltaClienteFechaDeNacimiento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteTelefono);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteMail);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteDocumento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.cboAltaClienteTipoDeDocumento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.cboAltaClienteNacionalidad);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.btnAltaClienteFechaDeNacimiento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteFechaDeNacimiento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteApellido);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.txtAltaClienteNombre);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblTelefono);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblMail);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblDocumento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblAltaClienteTipoDeDocumento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblAltaClienteNacionalidad);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblAltaClienteFechaDeNacimiento);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblAltaClienteApellido);
            this.gbAltaClienteDatosPersonales.Controls.Add(this.lblAltaClienteNombre);
            this.gbAltaClienteDatosPersonales.Location = new System.Drawing.Point(64, 44);
            this.gbAltaClienteDatosPersonales.Name = "gbAltaClienteDatosPersonales";
            this.gbAltaClienteDatosPersonales.Size = new System.Drawing.Size(495, 253);
            this.gbAltaClienteDatosPersonales.TabIndex = 0;
            this.gbAltaClienteDatosPersonales.TabStop = false;
            this.gbAltaClienteDatosPersonales.Text = "Datos Personales";
            // 
            // mcAltaClienteFechaDeNacimiento
            // 
            this.mcAltaClienteFechaDeNacimiento.Location = new System.Drawing.Point(230, 36);
            this.mcAltaClienteFechaDeNacimiento.Name = "mcAltaClienteFechaDeNacimiento";
            this.mcAltaClienteFechaDeNacimiento.TabIndex = 17;
            this.mcAltaClienteFechaDeNacimiento.Visible = false;
            this.mcAltaClienteFechaDeNacimiento.DateChanged += new System.Windows.Forms.DateRangeEventHandler(this.mcAltaClienteFechaDeNacimiento_DateChanged);
            // 
            // txtAltaClienteTelefono
            // 
            this.txtAltaClienteTelefono.Location = new System.Drawing.Point(163, 219);
            this.txtAltaClienteTelefono.Name = "txtAltaClienteTelefono";
            this.txtAltaClienteTelefono.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteTelefono.TabIndex = 16;
            // 
            // txtAltaClienteMail
            // 
            this.txtAltaClienteMail.Location = new System.Drawing.Point(163, 193);
            this.txtAltaClienteMail.Name = "txtAltaClienteMail";
            this.txtAltaClienteMail.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteMail.TabIndex = 15;
            // 
            // txtAltaClienteDocumento
            // 
            this.txtAltaClienteDocumento.Location = new System.Drawing.Point(163, 167);
            this.txtAltaClienteDocumento.Name = "txtAltaClienteDocumento";
            this.txtAltaClienteDocumento.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteDocumento.TabIndex = 14;
            // 
            // cboAltaClienteTipoDeDocumento
            // 
            this.cboAltaClienteTipoDeDocumento.FormattingEnabled = true;
            this.cboAltaClienteTipoDeDocumento.Location = new System.Drawing.Point(163, 142);
            this.cboAltaClienteTipoDeDocumento.Name = "cboAltaClienteTipoDeDocumento";
            this.cboAltaClienteTipoDeDocumento.Size = new System.Drawing.Size(294, 21);
            this.cboAltaClienteTipoDeDocumento.TabIndex = 13;
            // 
            // cboAltaClienteNacionalidad
            // 
            this.cboAltaClienteNacionalidad.FormattingEnabled = true;
            this.cboAltaClienteNacionalidad.Location = new System.Drawing.Point(163, 117);
            this.cboAltaClienteNacionalidad.Name = "cboAltaClienteNacionalidad";
            this.cboAltaClienteNacionalidad.Size = new System.Drawing.Size(294, 21);
            this.cboAltaClienteNacionalidad.TabIndex = 12;
            // 
            // btnAltaClienteFechaDeNacimiento
            // 
            this.btnAltaClienteFechaDeNacimiento.Location = new System.Drawing.Point(320, 90);
            this.btnAltaClienteFechaDeNacimiento.Name = "btnAltaClienteFechaDeNacimiento";
            this.btnAltaClienteFechaDeNacimiento.Size = new System.Drawing.Size(137, 20);
            this.btnAltaClienteFechaDeNacimiento.TabIndex = 11;
            this.btnAltaClienteFechaDeNacimiento.Text = "Seleccionar Fecha";
            this.btnAltaClienteFechaDeNacimiento.UseVisualStyleBackColor = true;
            this.btnAltaClienteFechaDeNacimiento.Click += new System.EventHandler(this.btnAltaClienteFechaDeNacimiento_Click);
            // 
            // txtAltaClienteFechaDeNacimiento
            // 
            this.txtAltaClienteFechaDeNacimiento.Location = new System.Drawing.Point(163, 90);
            this.txtAltaClienteFechaDeNacimiento.Name = "txtAltaClienteFechaDeNacimiento";
            this.txtAltaClienteFechaDeNacimiento.Size = new System.Drawing.Size(151, 20);
            this.txtAltaClienteFechaDeNacimiento.TabIndex = 10;
            // 
            // txtAltaClienteApellido
            // 
            this.txtAltaClienteApellido.Location = new System.Drawing.Point(163, 62);
            this.txtAltaClienteApellido.Name = "txtAltaClienteApellido";
            this.txtAltaClienteApellido.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteApellido.TabIndex = 9;
            // 
            // txtAltaClienteNombre
            // 
            this.txtAltaClienteNombre.Location = new System.Drawing.Point(163, 36);
            this.txtAltaClienteNombre.Name = "txtAltaClienteNombre";
            this.txtAltaClienteNombre.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteNombre.TabIndex = 8;
            // 
            // lblTelefono
            // 
            this.lblTelefono.AutoSize = true;
            this.lblTelefono.Location = new System.Drawing.Point(36, 226);
            this.lblTelefono.Name = "lblTelefono";
            this.lblTelefono.Size = new System.Drawing.Size(49, 13);
            this.lblTelefono.TabIndex = 7;
            this.lblTelefono.Text = "Telefono";
            // 
            // lblMail
            // 
            this.lblMail.AutoSize = true;
            this.lblMail.Location = new System.Drawing.Point(36, 200);
            this.lblMail.Name = "lblMail";
            this.lblMail.Size = new System.Drawing.Size(26, 13);
            this.lblMail.TabIndex = 6;
            this.lblMail.Text = "Mail";
            // 
            // lblDocumento
            // 
            this.lblDocumento.AutoSize = true;
            this.lblDocumento.Location = new System.Drawing.Point(36, 174);
            this.lblDocumento.Name = "lblDocumento";
            this.lblDocumento.Size = new System.Drawing.Size(62, 13);
            this.lblDocumento.TabIndex = 5;
            this.lblDocumento.Text = "Documento";
            // 
            // lblAltaClienteTipoDeDocumento
            // 
            this.lblAltaClienteTipoDeDocumento.AutoSize = true;
            this.lblAltaClienteTipoDeDocumento.Location = new System.Drawing.Point(36, 150);
            this.lblAltaClienteTipoDeDocumento.Name = "lblAltaClienteTipoDeDocumento";
            this.lblAltaClienteTipoDeDocumento.Size = new System.Drawing.Size(101, 13);
            this.lblAltaClienteTipoDeDocumento.TabIndex = 4;
            this.lblAltaClienteTipoDeDocumento.Text = "Tipo de Documento";
            // 
            // lblAltaClienteNacionalidad
            // 
            this.lblAltaClienteNacionalidad.AutoSize = true;
            this.lblAltaClienteNacionalidad.Location = new System.Drawing.Point(36, 125);
            this.lblAltaClienteNacionalidad.Name = "lblAltaClienteNacionalidad";
            this.lblAltaClienteNacionalidad.Size = new System.Drawing.Size(69, 13);
            this.lblAltaClienteNacionalidad.TabIndex = 3;
            this.lblAltaClienteNacionalidad.Text = "Nacionalidad";
            // 
            // lblAltaClienteFechaDeNacimiento
            // 
            this.lblAltaClienteFechaDeNacimiento.AutoSize = true;
            this.lblAltaClienteFechaDeNacimiento.Location = new System.Drawing.Point(36, 97);
            this.lblAltaClienteFechaDeNacimiento.Name = "lblAltaClienteFechaDeNacimiento";
            this.lblAltaClienteFechaDeNacimiento.Size = new System.Drawing.Size(106, 13);
            this.lblAltaClienteFechaDeNacimiento.TabIndex = 2;
            this.lblAltaClienteFechaDeNacimiento.Text = "Fecha de Nacimento";
            // 
            // lblAltaClienteApellido
            // 
            this.lblAltaClienteApellido.AutoSize = true;
            this.lblAltaClienteApellido.Location = new System.Drawing.Point(36, 69);
            this.lblAltaClienteApellido.Name = "lblAltaClienteApellido";
            this.lblAltaClienteApellido.Size = new System.Drawing.Size(44, 13);
            this.lblAltaClienteApellido.TabIndex = 1;
            this.lblAltaClienteApellido.Text = "Apellido";
            // 
            // lblAltaClienteNombre
            // 
            this.lblAltaClienteNombre.AutoSize = true;
            this.lblAltaClienteNombre.Location = new System.Drawing.Point(36, 39);
            this.lblAltaClienteNombre.Name = "lblAltaClienteNombre";
            this.lblAltaClienteNombre.Size = new System.Drawing.Size(44, 13);
            this.lblAltaClienteNombre.TabIndex = 0;
            this.lblAltaClienteNombre.Text = "Nombre";
            // 
            // gbAltaClienteDireccion
            // 
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClientePaisDeOrigen);
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClienteLocalidad);
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClienteDepartamento);
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClientePiso);
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClienteNumero);
            this.gbAltaClienteDireccion.Controls.Add(this.txtAltaClienteCalle);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClientePaisDeOrigen);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClienteLocalidad);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClienteDepartamento);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClientePiso);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClienteNumero);
            this.gbAltaClienteDireccion.Controls.Add(this.lblAltaClienteCalle);
            this.gbAltaClienteDireccion.Location = new System.Drawing.Point(64, 317);
            this.gbAltaClienteDireccion.Name = "gbAltaClienteDireccion";
            this.gbAltaClienteDireccion.Size = new System.Drawing.Size(495, 205);
            this.gbAltaClienteDireccion.TabIndex = 17;
            this.gbAltaClienteDireccion.TabStop = false;
            this.gbAltaClienteDireccion.Text = "Direccion";
            // 
            // txtAltaClientePaisDeOrigen
            // 
            this.txtAltaClientePaisDeOrigen.Location = new System.Drawing.Point(163, 167);
            this.txtAltaClientePaisDeOrigen.Name = "txtAltaClientePaisDeOrigen";
            this.txtAltaClientePaisDeOrigen.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClientePaisDeOrigen.TabIndex = 13;
            // 
            // txtAltaClienteLocalidad
            // 
            this.txtAltaClienteLocalidad.Location = new System.Drawing.Point(163, 143);
            this.txtAltaClienteLocalidad.Name = "txtAltaClienteLocalidad";
            this.txtAltaClienteLocalidad.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteLocalidad.TabIndex = 12;
            // 
            // txtAltaClienteDepartamento
            // 
            this.txtAltaClienteDepartamento.Location = new System.Drawing.Point(163, 118);
            this.txtAltaClienteDepartamento.Name = "txtAltaClienteDepartamento";
            this.txtAltaClienteDepartamento.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteDepartamento.TabIndex = 11;
            // 
            // txtAltaClientePiso
            // 
            this.txtAltaClientePiso.Location = new System.Drawing.Point(163, 90);
            this.txtAltaClientePiso.Name = "txtAltaClientePiso";
            this.txtAltaClientePiso.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClientePiso.TabIndex = 10;
            // 
            // txtAltaClienteNumero
            // 
            this.txtAltaClienteNumero.Location = new System.Drawing.Point(163, 63);
            this.txtAltaClienteNumero.Name = "txtAltaClienteNumero";
            this.txtAltaClienteNumero.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteNumero.TabIndex = 9;
            // 
            // txtAltaClienteCalle
            // 
            this.txtAltaClienteCalle.Location = new System.Drawing.Point(163, 36);
            this.txtAltaClienteCalle.Name = "txtAltaClienteCalle";
            this.txtAltaClienteCalle.Size = new System.Drawing.Size(294, 20);
            this.txtAltaClienteCalle.TabIndex = 8;
            // 
            // lblAltaClientePaisDeOrigen
            // 
            this.lblAltaClientePaisDeOrigen.AutoSize = true;
            this.lblAltaClientePaisDeOrigen.Location = new System.Drawing.Point(36, 174);
            this.lblAltaClientePaisDeOrigen.Name = "lblAltaClientePaisDeOrigen";
            this.lblAltaClientePaisDeOrigen.Size = new System.Drawing.Size(76, 13);
            this.lblAltaClientePaisDeOrigen.TabIndex = 5;
            this.lblAltaClientePaisDeOrigen.Text = "Pais de Origen";
            // 
            // lblAltaClienteLocalidad
            // 
            this.lblAltaClienteLocalidad.AutoSize = true;
            this.lblAltaClienteLocalidad.Location = new System.Drawing.Point(36, 150);
            this.lblAltaClienteLocalidad.Name = "lblAltaClienteLocalidad";
            this.lblAltaClienteLocalidad.Size = new System.Drawing.Size(53, 13);
            this.lblAltaClienteLocalidad.TabIndex = 4;
            this.lblAltaClienteLocalidad.Text = "Localidad";
            // 
            // lblAltaClienteDepartamento
            // 
            this.lblAltaClienteDepartamento.AutoSize = true;
            this.lblAltaClienteDepartamento.Location = new System.Drawing.Point(36, 125);
            this.lblAltaClienteDepartamento.Name = "lblAltaClienteDepartamento";
            this.lblAltaClienteDepartamento.Size = new System.Drawing.Size(74, 13);
            this.lblAltaClienteDepartamento.TabIndex = 3;
            this.lblAltaClienteDepartamento.Text = "Departamento";
            // 
            // lblAltaClientePiso
            // 
            this.lblAltaClientePiso.AutoSize = true;
            this.lblAltaClientePiso.Location = new System.Drawing.Point(36, 97);
            this.lblAltaClientePiso.Name = "lblAltaClientePiso";
            this.lblAltaClientePiso.Size = new System.Drawing.Size(27, 13);
            this.lblAltaClientePiso.TabIndex = 2;
            this.lblAltaClientePiso.Text = "Piso";
            // 
            // lblAltaClienteNumero
            // 
            this.lblAltaClienteNumero.AutoSize = true;
            this.lblAltaClienteNumero.Location = new System.Drawing.Point(36, 70);
            this.lblAltaClienteNumero.Name = "lblAltaClienteNumero";
            this.lblAltaClienteNumero.Size = new System.Drawing.Size(44, 13);
            this.lblAltaClienteNumero.TabIndex = 1;
            this.lblAltaClienteNumero.Text = "Numero";
            // 
            // lblAltaClienteCalle
            // 
            this.lblAltaClienteCalle.AutoSize = true;
            this.lblAltaClienteCalle.Location = new System.Drawing.Point(36, 39);
            this.lblAltaClienteCalle.Name = "lblAltaClienteCalle";
            this.lblAltaClienteCalle.Size = new System.Drawing.Size(30, 13);
            this.lblAltaClienteCalle.TabIndex = 0;
            this.lblAltaClienteCalle.Text = "Calle";
            // 
            // btnAltaClienteVolver
            // 
            this.btnAltaClienteVolver.Location = new System.Drawing.Point(3, 1);
            this.btnAltaClienteVolver.Name = "btnAltaClienteVolver";
            this.btnAltaClienteVolver.Size = new System.Drawing.Size(75, 23);
            this.btnAltaClienteVolver.TabIndex = 18;
            this.btnAltaClienteVolver.Text = "< Volver";
            this.btnAltaClienteVolver.UseVisualStyleBackColor = true;
            this.btnAltaClienteVolver.Click += new System.EventHandler(this.btnAltaClienteVolver_Click);
            // 
            // btnAltaClienteHome
            // 
            this.btnAltaClienteHome.Location = new System.Drawing.Point(542, 1);
            this.btnAltaClienteHome.Name = "btnAltaClienteHome";
            this.btnAltaClienteHome.Size = new System.Drawing.Size(75, 23);
            this.btnAltaClienteHome.TabIndex = 19;
            this.btnAltaClienteHome.Text = "Home";
            this.btnAltaClienteHome.UseVisualStyleBackColor = true;
            this.btnAltaClienteHome.Click += new System.EventHandler(this.btnAltaClienteHome_Click);
            // 
            // cmdAltaClienteGuardar
            // 
            this.cmdAltaClienteGuardar.Location = new System.Drawing.Point(278, 551);
            this.cmdAltaClienteGuardar.Name = "cmdAltaClienteGuardar";
            this.cmdAltaClienteGuardar.Size = new System.Drawing.Size(158, 23);
            this.cmdAltaClienteGuardar.TabIndex = 20;
            this.cmdAltaClienteGuardar.Text = "Guardar";
            this.cmdAltaClienteGuardar.UseVisualStyleBackColor = true;
            this.cmdAltaClienteGuardar.Click += new System.EventHandler(this.cmdAltaClienteGuardar_Click);
            // 
            // btnAltaClienteLimpiar
            // 
            this.btnAltaClienteLimpiar.Location = new System.Drawing.Point(103, 551);
            this.btnAltaClienteLimpiar.Name = "btnAltaClienteLimpiar";
            this.btnAltaClienteLimpiar.Size = new System.Drawing.Size(158, 23);
            this.btnAltaClienteLimpiar.TabIndex = 21;
            this.btnAltaClienteLimpiar.Text = "Limpiar";
            this.btnAltaClienteLimpiar.UseVisualStyleBackColor = true;
            this.btnAltaClienteLimpiar.Click += new System.EventHandler(this.btnAltaClienteLimpiar_Click);
            // 
            // AltaCliente
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(620, 602);
            this.Controls.Add(this.btnAltaClienteLimpiar);
            this.Controls.Add(this.cmdAltaClienteGuardar);
            this.Controls.Add(this.btnAltaClienteHome);
            this.Controls.Add(this.btnAltaClienteVolver);
            this.Controls.Add(this.gbAltaClienteDireccion);
            this.Controls.Add(this.gbAltaClienteDatosPersonales);
            this.Name = "AltaCliente";
            this.Text = "Dar Alta a Cliente";
            this.gbAltaClienteDatosPersonales.ResumeLayout(false);
            this.gbAltaClienteDatosPersonales.PerformLayout();
            this.gbAltaClienteDireccion.ResumeLayout(false);
            this.gbAltaClienteDireccion.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbAltaClienteDatosPersonales;
        private System.Windows.Forms.TextBox txtAltaClienteTelefono;
        private System.Windows.Forms.TextBox txtAltaClienteMail;
        private System.Windows.Forms.TextBox txtAltaClienteDocumento;
        private System.Windows.Forms.ComboBox cboAltaClienteTipoDeDocumento;
        private System.Windows.Forms.ComboBox cboAltaClienteNacionalidad;
        private System.Windows.Forms.Button btnAltaClienteFechaDeNacimiento;
        private System.Windows.Forms.TextBox txtAltaClienteFechaDeNacimiento;
        private System.Windows.Forms.TextBox txtAltaClienteApellido;
        private System.Windows.Forms.TextBox txtAltaClienteNombre;
        private System.Windows.Forms.Label lblTelefono;
        private System.Windows.Forms.Label lblMail;
        private System.Windows.Forms.Label lblDocumento;
        private System.Windows.Forms.Label lblAltaClienteTipoDeDocumento;
        private System.Windows.Forms.Label lblAltaClienteNacionalidad;
        private System.Windows.Forms.Label lblAltaClienteFechaDeNacimiento;
        private System.Windows.Forms.Label lblAltaClienteApellido;
        private System.Windows.Forms.Label lblAltaClienteNombre;
        private System.Windows.Forms.GroupBox gbAltaClienteDireccion;
        private System.Windows.Forms.TextBox txtAltaClientePaisDeOrigen;
        private System.Windows.Forms.TextBox txtAltaClienteLocalidad;
        private System.Windows.Forms.TextBox txtAltaClienteDepartamento;
        private System.Windows.Forms.TextBox txtAltaClientePiso;
        private System.Windows.Forms.TextBox txtAltaClienteNumero;
        private System.Windows.Forms.TextBox txtAltaClienteCalle;
        private System.Windows.Forms.Label lblAltaClientePaisDeOrigen;
        private System.Windows.Forms.Label lblAltaClienteLocalidad;
        private System.Windows.Forms.Label lblAltaClienteDepartamento;
        private System.Windows.Forms.Label lblAltaClientePiso;
        private System.Windows.Forms.Label lblAltaClienteNumero;
        private System.Windows.Forms.Label lblAltaClienteCalle;
        private System.Windows.Forms.MonthCalendar mcAltaClienteFechaDeNacimiento;
        private System.Windows.Forms.Button btnAltaClienteVolver;
        private System.Windows.Forms.Button btnAltaClienteHome;
        private System.Windows.Forms.Button cmdAltaClienteGuardar;
        private System.Windows.Forms.Button btnAltaClienteLimpiar;
    }
}
*/