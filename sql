CREATE TABLE IF NOT EXISTS projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS conversations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS messages_search_idx ON messages USING GIN (to_tsvector('french', content));


sudo apt install git cmake libglib2.0-dev libgudev-1.0-dev libusb-1.0-0-dev libnss3-dev libpixman-1-dev meson ninja-build -y

git clone https://gitlab.freedesktop.org/libfprint/libfprint.git
cd libfprint
meson builddir
cd builddir
ninja
sudo ninja install

sudo systemctl restart fprintd
fprintd-enroll
