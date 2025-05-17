from app import db
from datetime import datetime

class Factura(db.Model):
    __tablename__ = 'facturas'

    id           = db.Column(db.Integer, primary_key=True)
    # Apunta a user.idUser, que es tu definición real:
    user_id      = db.Column(db.Integer,
                             db.ForeignKey('user.idUser'),
                             nullable=False)

    # Relación hacia Users (clase se llama Users)
    user         = db.relationship(
        'Users',
        back_populates='facturas'
    )

    date_created = db.Column(db.DateTime, default=datetime.utcnow)
    subtotal     = db.Column(db.Float, nullable=False, default=0.0)
    iva          = db.Column(db.Float, nullable=False, default=0.0)
    total        = db.Column(db.Float, nullable=False, default=0.0)
    revisada     = db.Column(db.Boolean, default=False, nullable=False)

    detalles     = db.relationship(
        'DetalleFactura',
        backref='factura',
        lazy=True,
        cascade='all, delete-orphan'
    )

    def __init__(self, user_id, subtotal, iva, total):
        self.user_id  = user_id
        self.subtotal = subtotal
        self.iva      = iva
        self.total    = total