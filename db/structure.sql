CREATE TABLE "aspects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "brief" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "ideas" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "phase" integer, "brief" text, "image" varchar(255), "active" boolean, "industry" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "rails_admin_histories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "message" text, "username" varchar(255), "item" integer, "table" varchar(255), "month" integer(2), "year" integer(5), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_rails_admin_histories" ON "rails_admin_histories" ("item", "table", "month", "year");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130628153434');

INSERT INTO schema_migrations (version) VALUES ('20130701002954');

INSERT INTO schema_migrations (version) VALUES ('20130705224328');

INSERT INTO schema_migrations (version) VALUES ('20130705225022');

INSERT INTO schema_migrations (version) VALUES ('20130705233832');

INSERT INTO schema_migrations (version) VALUES ('20130706005124');
