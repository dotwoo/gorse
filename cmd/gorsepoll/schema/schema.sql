--
-- The SQL table definitions for the RSS reader.
--
-- This is made for PostgreSQL 9.1 but should work with most versions.
--
-- NOTE: To read this schema you should look at upgrades too. This is the
--   original schema before upgrades were applied.
--

-- Track each feed to work with.
CREATE TABLE rss_feed (
	id SERIAL,
	name VARCHAR NOT NULL,
	uri VARCHAR NOT NULL,
	update_frequency_seconds INTEGER NOT NULL,
	last_update_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	-- whether the poller actually polls this.
	active BOOLEAN NOT NULL DEFAULT true,
	UNIQUE (name),
	UNIQUE (uri),
	PRIMARY KEY (id)
);

-- Track RSS feed items.
CREATE TABLE rss_item (
	id SERIAL,
	-- html encoded.
	title VARCHAR NOT NULL,
	-- html encoded.
	description VARCHAR NOT NULL,
	-- html encoded.
	link VARCHAR NOT NULL,
	publication_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	rss_feed_id INTEGER NOT NULL REFERENCES rss_feed(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	-- whether read or not.
	read BOOLEAN NOT NULL DEFAULT false,
	-- possible to have same title/description I suppose...
	UNIQUE(rss_feed_id, link),
	PRIMARY KEY (id)
);
