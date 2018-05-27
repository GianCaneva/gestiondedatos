namespace GestionHotelera.ABM_Clientes
{
    partial class ClienteForm
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
            this.btnClienteVolver = new System.Windows.Forms.Button();
            this.bntClienteAlta = new System.Windows.Forms.Button();
            this.btnClienteBuscar = new System.Windows.Forms.Button();
            this.btnClienteEditar = new System.Windows.Forms.Button();
            this.btnClienteEliminar = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnClienteVolver
            // 
            this.btnClienteVolver.Location = new System.Drawing.Point(1, 2);
            this.btnClienteVolver.Name = "btnClienteVolver";
            this.btnClienteVolver.Size = new System.Drawing.Size(75, 23);
            this.btnClienteVolver.TabIndex = 0;
            this.btnClienteVolver.Text = "< Volver";
            this.btnClienteVolver.UseVisualStyleBackColor = true;
            this.btnClienteVolver.Click += new System.EventHandler(this.btnClienteVolver_Click);
            // 
            // bntClienteAlta
            // 
            this.bntClienteAlta.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.bntClienteAlta.Location = new System.Drawing.Point(135, 95);
            this.bntClienteAlta.Name = "bntClienteAlta";
            this.bntClienteAlta.Size = new System.Drawing.Size(171, 32);
            this.bntClienteAlta.TabIndex = 2;
            this.bntClienteAlta.Text = "ALTA CLIENTE";
            this.bntClienteAlta.UseVisualStyleBackColor = true;
            this.bntClienteAlta.Click += new System.EventHandler(this.bntClienteAlta_Click);
            // 
            // btnClienteBuscar
            // 
            this.btnClienteBuscar.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClienteBuscar.Location = new System.Drawing.Point(135, 254);
            this.btnClienteBuscar.Name = "btnClienteBuscar";
            this.btnClienteBuscar.Size = new System.Drawing.Size(171, 32);
            this.btnClienteBuscar.TabIndex = 5;
            this.btnClienteBuscar.Text = "BUSCAR CLIENTE";
            this.btnClienteBuscar.UseVisualStyleBackColor = true;
            this.btnClienteBuscar.Click += new System.EventHandler(this.btnClienteBuscar_Click);
            // 
            // btnClienteEditar
            // 
            this.btnClienteEditar.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClienteEditar.Location = new System.Drawing.Point(135, 147);
            this.btnClienteEditar.Name = "btnClienteEditar";
            this.btnClienteEditar.Size = new System.Drawing.Size(171, 32);
            this.btnClienteEditar.TabIndex = 6;
            this.btnClienteEditar.Text = "EDITAR CLIENTE";
            this.btnClienteEditar.UseVisualStyleBackColor = true;
            this.btnClienteEditar.Click += new System.EventHandler(this.btnClienteEditar_Click);
            // 
            // btnClienteEliminar
            // 
            this.btnClienteEliminar.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClienteEliminar.Location = new System.Drawing.Point(135, 199);
            this.btnClienteEliminar.Name = "btnClienteEliminar";
            this.btnClienteEliminar.Size = new System.Drawing.Size(171, 32);
            this.btnClienteEliminar.TabIndex = 7;
            this.btnClienteEliminar.Text = "ELIMINAR CLIENTE";
            this.btnClienteEliminar.UseVisualStyleBackColor = true;
            this.btnClienteEliminar.Click += new System.EventHandler(this.btnClienteEliminar_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Underline))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(170, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 25);
            this.label1.TabIndex = 8;
            this.label1.Text = "Cliente";
            // 
            // ClienteForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(428, 362);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnClienteEliminar);
            this.Controls.Add(this.btnClienteEditar);
            this.Controls.Add(this.btnClienteBuscar);
            this.Controls.Add(this.bntClienteAlta);
            this.Controls.Add(this.btnClienteVolver);
            this.Name = "ClienteForm";
            this.Text = "ClienteForm";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnClienteVolver;
        private System.Windows.Forms.Button bntClienteAlta;
        private System.Windows.Forms.Button btnClienteBuscar;
        private System.Windows.Forms.Button btnClienteEditar;
        private System.Windows.Forms.Button btnClienteEliminar;
        private System.Windows.Forms.Label label1;
    }
}