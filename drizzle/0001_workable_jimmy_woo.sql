CREATE TABLE `feedback` (
	`id` text PRIMARY KEY NOT NULL,
	`agent` text NOT NULL,
	`model` text DEFAULT '' NOT NULL,
	`liked` integer NOT NULL,
	`missing` text DEFAULT '' NOT NULL,
	`comment` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_feedback_duplicate` ON `feedback` (`agent`,`model`,`liked`,`missing`,`comment`);
