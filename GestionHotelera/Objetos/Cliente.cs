using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

/*
namespace GestionHotelera.Objetos
{
    class Cliente
    {/*
        private String nombre;
        private String apellido;
        private DateTime fechaDeNacimiento;
        private Decimal nacionalidad;
        private Decimal tipoDeDocumento;
        private Decimal documento;
        private String mail;
        private Decimal telefono;
        private String calle;
        private String numero;
        private Decimal piso;
        private String departamento;
        private String localidad;
        private Decimal paisDeOrigen;

        /////////////////// Getter & Setter
        public String getNombre() { return nombre; }
        public void setNombre(String nombre) { this.nombre = nombre; }

        public String getApellido() { return apellido; }
        public void setApellido(String apellido) { this.apellido = apellido; }

        public DateTime getFechaDeNacimiento() { return fechaDeNacimiento; }
        public void setFechaDeNacimiento(DateTime fechaDeNacimiento) 
        {
            if (fechaDeNacimiento.Equals(DateTime.MinValue))
                throw new CampoVacioException("Fecha de nacimiento");

            this.fechaDeNacimiento = fechaDeNacimiento; 
        }

        public Decimal getNacionalidad() { return nacionalidad; }
        public void setNacionalidad(Decimal nacionalidad) { this.nacionalidad = nacionalidad; }

        public Decimal getTipoDeDocumento() { return tipoDeDocumento; }
        public void setTipoDeDocumento(Decimal tipoDeDocumento) { this.tipoDeDocumento = tipoDeDocumento; }

        public Decimal getDocumento() { return documento; }
        public void setDocumento(Decimal documento) { this.documento = documento; }

        public String getMail() { return mail; }
        public void setMail(String mail) { this.mail = mail; }

        public Decimal getTelefono() { return telefono; }
        public void setTelefono(Decimal telefono) { this.telefono = telefono; }

        public String getCalle() { return calle; }
        public void setCalle(String calle) { this.calle = calle; }

        public String getNumero() { return numero; }
        public void setNumero (String numero) { this.numero = numero; }

        public Decimal getPiso() { return piso; }
        public void setPiso(Decimal piso) { this.piso = piso; }

        public String getDepartamento() { return departamento; }
        public void setDepartamento(String departamento) { this.departamento = departamento; }

        public String getLocalidad() { return localidad; }
        public void setLocalidad(String localidad) { this.localidad = localidad; }

        public Decimal getPaisDeOrigen() { return paisDeOrigen; }
        public void setPaisDeOrigen(Decimal paisDeOrigen) { this.paisDeOrigen = paisDeOrigen; }

        public void CargarInformacion(SqlDataReader reader) 
        {
            this.nombre = Convert.ToString(reader["nombre"]);
            this.apellido = Convert.ToString(reader["apellido"]);
            this.fechaDeNacimiento = Convert.ToDateTime(reader["fecha_Nacimiento"]);
            this.nacionalidad = Convert.ToDecimal(reader["nacionalidad"]);
            this.tipoDeDocumento = Convert.ToDecimal(reader["tipo_Documento"]);
            this.documento = Convert.ToDecimal(reader["documento"]);
            this.mail = Convert.ToString(reader["mail"]);
            this.telefono = Convert.ToDecimal(reader["telefono"]);
            this.calle = Convert.ToString(reader["calle"]);
            this.numero = Convert.ToString(reader["numero_Calle"]);
            this.piso = Convert.ToDecimal(reader["piso"]);
            this.departamento = Convert.ToString(reader["departamento"]);
            this.localidad = Convert.ToString(reader["localidad"]);
            this.paisDeOrigen = Convert.ToDecimal(reader["paisOrigen"]);

        }*/
        /*
        public IList<System.Data.SqlClient.SqlParameter> GetParametros()
        {
            /*
            IList<SqlParameter> parametros = new List<SqlParameter>();
            parametros.Clear();
            parametros.Add(new SqlParameter("@dni", this.dni));
            parametros.Add(new SqlParameter("@mail", this.mail));
            parametros.Add(new SqlParameter("@nombre", this.nombre));
            parametros.Add(new SqlParameter("@apellido", this.apellido));
            parametros.Add(new SqlParameter("@direccion", this.direc));
            parametros.Add(new SqlParameter("@cod_postal", this.cod_postal));
            parametros.Add(new SqlParameter("@fecha_nacimiento", this.fechaDeNacimiento));
            parametros.Add(new SqlParameter("@telefono", this.telefono));
            parametros.Add(new SqlParameter("@habilitado", this.habilitado));
            return parametros;
             * 
             * 
             * 
             * 
             * Cliente
             * Reserva
             * Estadia
             * Usuario
             * Rol
             * Hotel
             * */

