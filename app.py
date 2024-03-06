import os
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
app.config.from_object("config.Config")
db = SQLAlchemy(app)

migrate = Migrate(app, db)


# Uncomment for SQLite
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///ips.db'
# Uncomment for PostgreSQL
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL")
# print("DATABASE_URL:", os.getenv('DATABASE_URL'))
#
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


class ReversedIP(db.Model):
    __tablename__ = 'reversed_ip'

    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String(50), unique=True, nullable=False)


# Create tables
with app.app_context():
    db.create_all()


@app.route('/reverse')
def index():
    # IP address
    ip_address = request.remote_addr
    # Reverse the IP address
    reversed_ip = '.'.join(ip_address.split('.')[::-1])
    # Store in database if not already present
    if not ReversedIP.query.filter_by(ip=reversed_ip).first():
        db.session.add(ReversedIP(ip=reversed_ip))
        db.session.commit()
    return f'Reversed IP: {reversed_ip}'


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
