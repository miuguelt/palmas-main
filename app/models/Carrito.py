from app import db
from app.models.users import Users
from app.models.Productos import Productos

class Carrito(db.Model):
    __tablename__  = 'carrito'
    idCarrito      = db.Column(db.Integer, primary_key=True)
    idProducto     = db.Column(db.Integer, db.ForeignKey('productos.idProducto'))
    idUser         = db.Column(
                        db.Integer,
                        db.ForeignKey('user.idUser'),
                        nullable=False
                    )
    cantidad       = db.Column(db.Integer, nullable=True, default=1)
    talla          = db.Column(db.String(10), nullable=False, server_default='')
    
    # Relaciones
    producto       = db.relationship('Productos', backref='carrito', lazy=True)
    usuario        = db.relationship(
                         'Users',
                         back_populates='carrito'
                     )

    def get_id(self):
        return str(self.idCarrito)
