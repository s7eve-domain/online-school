-- SwidHub PostgreSQL schema (starting point for the production build)
CREATE TYPE user_role AS ENUM ('learner','instructor','mentor','admin');
CREATE TABLE users(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),name TEXT NOT NULL,email TEXT UNIQUE NOT NULL,password_hash TEXT,role user_role NOT NULL DEFAULT 'learner',status TEXT DEFAULT 'active',country TEXT,language TEXT,created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE categories(id SERIAL PRIMARY KEY,name TEXT UNIQUE NOT NULL,slug TEXT UNIQUE NOT NULL);
CREATE TABLE courses(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),instructor_id UUID REFERENCES users,category_id INT REFERENCES categories,title TEXT NOT NULL,description TEXT,level TEXT,language TEXT,duration_hours NUMERIC,price_ngn INT DEFAULT 0,status TEXT DEFAULT 'draft',rating NUMERIC(2,1),created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE lessons(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),course_id UUID REFERENCES courses ON DELETE CASCADE,position INT,title TEXT,video_url TEXT,duration_min INT);
CREATE TABLE quizzes(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),lesson_id UUID REFERENCES lessons ON DELETE CASCADE,question TEXT,options JSONB,answer_index INT);
CREATE TABLE enrollments(user_id UUID REFERENCES users,course_id UUID REFERENCES courses,progress INT DEFAULT 0,completed_at TIMESTAMPTZ,PRIMARY KEY(user_id,course_id));
CREATE TABLE lesson_progress(user_id UUID REFERENCES users,lesson_id UUID REFERENCES lessons,notes TEXT,done BOOLEAN DEFAULT false,PRIMARY KEY(user_id,lesson_id));
CREATE TABLE reviews(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),user_id UUID REFERENCES users,course_id UUID REFERENCES courses,mentor_id UUID,rating INT CHECK(rating BETWEEN 1 AND 5),body TEXT,created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE mentors(user_id UUID PRIMARY KEY REFERENCES users,field TEXT,skills TEXT[],years INT,bio TEXT,intro_video_url TEXT,hourly_price_ngn INT,timezone TEXT,verified BOOLEAN DEFAULT false,application_status TEXT DEFAULT 'pending');
CREATE TABLE mentor_credentials(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),mentor_id UUID REFERENCES mentors,file_url TEXT,label TEXT);
CREATE TABLE availability(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),mentor_id UUID REFERENCES mentors,weekday INT,start_time TIME,end_time TIME);
CREATE TABLE sessions(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),mentor_id UUID REFERENCES mentors,learner_id UUID REFERENCES users,starts_at TIMESTAMPTZ,type TEXT,status TEXT DEFAULT 'requested',price_ngn INT,commission_ngn INT,meeting_url TEXT);
CREATE TABLE messages(id BIGSERIAL PRIMARY KEY,from_id UUID REFERENCES users,to_id UUID REFERENCES users,body TEXT,created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE coupons(code TEXT PRIMARY KEY,percent_off INT,amount_off_ngn INT,expires_at TIMESTAMPTZ);
CREATE TABLE orders(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),user_id UUID REFERENCES users,total_ngn INT,coupon TEXT REFERENCES coupons,stripe_payment_id TEXT,status TEXT DEFAULT 'pending',created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE order_items(order_id UUID REFERENCES orders,kind TEXT,ref_id UUID,price_ngn INT);
CREATE TABLE payouts(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),mentor_id UUID REFERENCES mentors,amount_ngn INT,status TEXT DEFAULT 'requested');
CREATE TABLE reports(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),reporter_id UUID REFERENCES users,kind TEXT,body TEXT,status TEXT DEFAULT 'open');
CREATE TABLE posts(id UUID PRIMARY KEY DEFAULT gen_random_uuid(),title TEXT,slug TEXT UNIQUE,body TEXT,published_at TIMESTAMPTZ);
-- Platform commission on mentor sessions: 40% (commission_ngn = price_ngn * 0.40)
