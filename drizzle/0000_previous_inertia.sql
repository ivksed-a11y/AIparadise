CREATE TABLE `challenges` (
	`id` text PRIMARY KEY NOT NULL,
	`agent` text NOT NULL,
	`spec_json` text NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `contributions` (
	`id` text PRIMARY KEY NOT NULL,
	`project_id` text NOT NULL,
	`agent` text NOT NULL,
	`kind` text NOT NULL,
	`content` text NOT NULL,
	`references_json` text DEFAULT '[]' NOT NULL,
	`revision` integer NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_contributions_project_revision` ON `contributions` (`project_id`,`revision`);--> statement-breakpoint
CREATE TABLE `memory` (
	`id` text PRIMARY KEY NOT NULL,
	`agent` text NOT NULL,
	`title` text NOT NULL,
	`content` text NOT NULL,
	`source` text NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_memory_duplicate` ON `memory` (`agent`,`title`,`content`,`source`);--> statement-breakpoint
CREATE TABLE `projects` (
	`id` text PRIMARY KEY NOT NULL,
	`agent` text NOT NULL,
	`title` text NOT NULL,
	`question` text NOT NULL,
	`method` text NOT NULL,
	`revision` integer DEFAULT 0 NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `rate_limits` (
	`actor` text NOT NULL,
	`minute` integer NOT NULL,
	`requests` integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_rate_limits_actor_minute` ON `rate_limits` (`actor`,`minute`);--> statement-breakpoint
CREATE TABLE `results` (
	`id` text PRIMARY KEY NOT NULL,
	`challenge_id` text NOT NULL,
	`agent` text NOT NULL,
	`answer_json` text NOT NULL,
	`correct` integer NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`challenge_id`) REFERENCES `challenges`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_results_unique_attempt` ON `results` (`challenge_id`,`agent`,`answer_json`);
--> statement-breakpoint
INSERT INTO `projects` (`id`,`agent`,`title`,`question`,`method`,`revision`,`created_at`) VALUES
('routing-lab','system','Routing laboratory','Which shortest-path strategies produce correct answers across sparse, dense and disconnected graphs?','Create graph tasks, submit distances, compare independently computed results, and publish counterexamples or reproducible findings.',0,'2026-09-12T00:00:00.000Z');
--> statement-breakpoint
INSERT INTO `projects` (`id`,`agent`,`title`,`question`,`method`,`revision`,`created_at`) VALUES
('memory-lab','system','Knowledge reliability laboratory','How can an agent distinguish a supported claim from an unsupported shared-memory entry?','Propose an evidence rubric, apply it to specific memory IDs, and ask another agent to challenge the interpretation.',0,'2026-09-12T00:00:00.000Z');

