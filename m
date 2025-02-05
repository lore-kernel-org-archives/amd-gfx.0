Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F0AC0219C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2C110E403;
	Wed,  5 Feb 2025 22:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NksqmTSH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB5510E7E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=prGFYoW4w60N1FjzQTzAtKnQQyhuDvPLVtBWvkJCyFs=; b=NksqmTSHwZYalc2aJoEyfeQjX1
 HjDhx5I4uWT7K169Vh2SCTgp7xCyYRkKr5TOQumjaCrAuYiga/urvQDLzEIUP77HsKr6QnxP8uUaA
 v2WjZEC+jh3t1YOBd9qZQL/MdBXyZDzAcZ8o2AMkLHbu4LOvMe5HYXcLTahkKrUK8dBtg7rMy+AOM
 m4cGtBx75OnazUJmph3Fn6HJzm34++I2RGXG7mR7i1Ao9OrAXj/o2ztji0OcXnI0l7uPYa5iE/68l
 kRF6Cg2+MnSCiQYkAgFIcu2CEs1ao6H5JAyHJGCv3Har5SekjIdMERJJg25K6n/nqvO6uIw5dlcBX
 rt2sNjrQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tfhP9-0041Of-4v; Wed, 05 Feb 2025 16:33:37 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 3/4] drm/sched: Add internal job peek/pop API
Date: Wed,  5 Feb 2025 15:33:31 +0000
Message-ID: <20250205153332.14852-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:38:15 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Idea is to add helpers for peeking and poppling jobs from entities with
the goal of decoupling the hidden assumption in the code that queue_node
is the first element in struct drm_sched_job.

That assumption usually comes in the form of:

  while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue))))

Which breaks if the queue_node is re-positioned due to_drm_sched_job
being implemented with a container_of.

This also allows us to remove duplicate definition of to_drm_sched_job
which the scheduler apparently tried to keep internal, but failed since
in one of the previous patches we also removed a copy from amdgpu.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
 drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c     |  9 ++---
 3 files changed, 52 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..737feff147a5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -28,11 +28,10 @@
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
 
+#include "sched_internal.h"
+
 #include "gpu_scheduler_trace.h"
 
-#define to_drm_sched_job(sched_job)		\
-		container_of((sched_job), struct drm_sched_job, queue_node)
-
 /**
  * drm_sched_entity_init - Init a context entity used by scheduler when
  * submit to HW ring.
@@ -255,7 +254,7 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	/* The entity is guaranteed to not be used by the scheduler */
 	prev = rcu_dereference_check(entity->last_scheduled, true);
 	dma_fence_get(prev);
-	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
+	while ((job = __drm_sched_entity_queue_pop(entity))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
@@ -477,7 +476,7 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 {
 	struct drm_sched_job *sched_job;
 
-	sched_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
+	sched_job = __drm_sched_entity_queue_peek(entity);
 	if (!sched_job)
 		return NULL;
 
@@ -513,7 +512,7 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO) {
 		struct drm_sched_job *next;
 
-		next = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
+		next = __drm_sched_entity_queue_peek(entity);
 		if (next) {
 			struct drm_sched_rq *rq;
 
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
new file mode 100644
index 000000000000..565c83e32371
--- /dev/null
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -0,0 +1,43 @@
+
+
+/**
+ * __drm_sched_entity_queue_pop - Low level helper for popping queued jobs
+ *
+ * @entity: scheduler entity
+ *
+ * Low level helper for popping queued jobs.
+ *
+ * Returns the job dequeued or NULL.
+ */
+static inline struct drm_sched_job *
+__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
+{
+	struct spsc_node *node;
+
+	node = spsc_queue_pop(&entity->job_queue);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct drm_sched_job, queue_node);
+}
+
+/**
+ * __drm_sched_entity_queue_peek - Low level helper for peeking at the job queue
+ *
+ * @entity: scheduler entity
+ *
+ * Low level helper for peeking at the job queue
+ *
+ * Returns the job at the head of the queue or NULL.
+ */
+static inline struct drm_sched_job *
+__drm_sched_entity_queue_peek(struct drm_sched_entity *entity)
+{
+	struct spsc_node *node;
+
+	node = spsc_queue_peek(&entity->job_queue);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct drm_sched_job, queue_node);
+}
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 0363655db22d..41d6f839748e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -78,6 +78,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/spsc_queue.h>
 
+#include "sched_internal.h"
+
 #define CREATE_TRACE_POINTS
 #include "gpu_scheduler_trace.h"
 
@@ -87,9 +89,6 @@ static struct lockdep_map drm_sched_lockdep_map = {
 };
 #endif
 
-#define to_drm_sched_job(sched_job)		\
-		container_of((sched_job), struct drm_sched_job, queue_node)
-
 int drm_sched_policy = DRM_SCHED_POLICY_FIFO;
 
 /**
@@ -123,7 +122,7 @@ static bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
 {
 	struct drm_sched_job *s_job;
 
-	s_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
+	s_job = __drm_sched_entity_queue_peek(entity);
 	if (!s_job)
 		return false;
 
@@ -728,7 +727,7 @@ void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int errno)
 
 		spin_lock(&rq->lock);
 		list_for_each_entry(entity, &rq->entities, list) {
-			while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
+			while ((job = __drm_sched_entity_queue_pop(entity))) {
 				s_fence = job->s_fence;
 				dma_fence_signal(&s_fence->scheduled);
 				dma_fence_set_error(&s_fence->finished, errno);
-- 
2.48.0

