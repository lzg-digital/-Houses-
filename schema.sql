-- Database Schema for 😴 houses

CREATE TABLE IF NOT EXISTS staff (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT,
    role TEXT NOT NULL CHECK(role IN ('Boss', 'Staff')),
    is_active INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS properties (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rooms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    room_number TEXT NOT NULL,
    status TEXT DEFAULT 'Wazi' CHECK(status IN ('Wazi', 'Imekaliwa')),
    FOREIGN KEY(property_id) REFERENCES properties(id) ON DELETE CASCADE,
    UNIQUE(property_id, room_number)
);

CREATE TABLE IF NOT EXISTS tenants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    primary_phone TEXT NOT NULL,
    alt_phone TEXT,
    email TEXT,
    property_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    status TEXT DEFAULT 'Haijalipwa' CHECK(status IN ('Haijalipwa', 'Amelipa', 'Deni')),
    registered_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY(property_id) REFERENCES properties(id),
    FOREIGN KEY(room_id) REFERENCES rooms(id)
);

CREATE TABLE IF NOT EXISTS contracts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tenant_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    monthly_rent REAL NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT DEFAULT 'Haijaanza' CHECK(status IN ('Haijaanza', 'InafanyaKazi', 'Imeisha')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(tenant_id) REFERENCES tenants(id),
    FOREIGN KEY(property_id) REFERENCES properties(id),
    FOREIGN KEY(room_id) REFERENCES rooms(id)
);

CREATE TABLE IF NOT EXISTS payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contract_id INTEGER NOT NULL,
    tenant_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    payment_date DATE NOT NULL,
    payment_method TEXT NOT NULL,
    reference TEXT UNIQUE,
    receipt_number TEXT UNIQUE NOT NULL,
    balance REAL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(contract_id) REFERENCES contracts(id),
    FOREIGN KEY(tenant_id) REFERENCES tenants(id)
);

CREATE TABLE IF NOT EXISTS inspections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('Ingia', 'Toka')),
    inspection_date DATE NOT NULL,
    inspector TEXT NOT NULL,
    doors TEXT, windows TEXT, plumbing TEXT, electrical TEXT, walls TEXT, floors TEXT, other TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(property_id) REFERENCES properties(id),
    FOREIGN KEY(room_id) REFERENCES rooms(id)
);

CREATE TABLE IF NOT EXISTS maintenance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    description TEXT NOT NULL,
    priority TEXT NOT NULL CHECK(priority IN ('Chini', 'Kati', 'Juu')),
    status TEXT DEFAULT 'Pending' CHECK(status IN ('Pending', 'In Progress', 'Completed')),
    reported_date DATE DEFAULT CURRENT_DATE,
    assigned_staff_id INTEGER,
    FOREIGN KEY(property_id) REFERENCES properties(id),
    FOREIGN KEY(room_id) REFERENCES rooms(id),
    FOREIGN KEY(assigned_staff_id) REFERENCES staff(id)
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    action TEXT NOT NULL,
    operation_result TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Initial Boss account
INSERT OR IGNORE INTO staff (username, role, is_active) VALUES ('113333', 'Boss', 1);
