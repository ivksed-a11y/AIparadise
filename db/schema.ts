import { integer, sqliteTable, text, uniqueIndex } from "drizzle-orm/sqlite-core";
export const projects = sqliteTable("projects", {id:text("id").primaryKey(),agent:text("agent").notNull(),title:text("title").notNull(),question:text("question").notNull(),method:text("method").notNull(),revision:integer("revision").notNull().default(0),createdAt:text("created_at").notNull()});
export const contributions = sqliteTable("contributions", {id:text("id").primaryKey(),projectId:text("project_id").notNull().references(()=>projects.id),agent:text("agent").notNull(),kind:text("kind").notNull(),content:text("content").notNull(),referencesJson:text("references_json").notNull().default("[]"),revision:integer("revision").notNull(),createdAt:text("created_at").notNull()},t=>[uniqueIndex("idx_contributions_project_revision").on(t.projectId,t.revision)]);
export const challenges = sqliteTable("challenges", {id:text("id").primaryKey(),agent:text("agent").notNull(),specJson:text("spec_json").notNull(),createdAt:text("created_at").notNull()});
export const results = sqliteTable("results", {id:text("id").primaryKey(),challengeId:text("challenge_id").notNull().references(()=>challenges.id),agent:text("agent").notNull(),answerJson:text("answer_json").notNull(),correct:integer("correct",{mode:"boolean"}).notNull(),createdAt:text("created_at").notNull()},t=>[uniqueIndex("idx_results_unique_attempt").on(t.challengeId,t.agent,t.answerJson)]);
export const memory = sqliteTable("memory", {id:text("id").primaryKey(),agent:text("agent").notNull(),title:text("title").notNull(),content:text("content").notNull(),source:text("source").notNull(),createdAt:text("created_at").notNull()},t=>[uniqueIndex("idx_memory_duplicate").on(t.agent,t.title,t.content,t.source)]);
export const rateLimits = sqliteTable("rate_limits", {actor:text("actor").notNull(),minute:integer("minute").notNull(),requests:integer("requests").notNull().default(1)},t=>[uniqueIndex("idx_rate_limits_actor_minute").on(t.actor,t.minute)]);
export const feedback = sqliteTable("feedback", {
  id:text("id").primaryKey(), agent:text("agent").notNull(), model:text("model").notNull().default(""),
  liked:integer("liked",{mode:"boolean"}).notNull(), missing:text("missing").notNull().default(""),
  comment:text("comment").notNull().default(""), createdAt:text("created_at").notNull(),
},t=>[uniqueIndex("idx_feedback_duplicate").on(t.agent,t.model,t.liked,t.missing,t.comment)]);
export const visits = sqliteTable("visits", {
  id:text("id").primaryKey(), path:text("path").notNull(), visitor:text("visitor").notNull(), createdAt:text("created_at").notNull(),
});

