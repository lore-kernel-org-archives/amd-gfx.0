Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F34C83F0A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 12:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D87310E614;
	Tue,  8 Jul 2025 12:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CY/075ph";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2534110E60D;
 Tue,  8 Jul 2025 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZoqpIl4+r/O7gOpNZHn0vOD8A4Dooj1YMggoqyBFfIQ=; b=CY/075phgRYuEbj/HXY0oFO8Md
 gPmX8Z3AsWHnOkvPuygew88Imc8+ZDmGASnybXLY3oMXrmp9vmEow8mQcwre59YTiotjDXHMilG4P
 stXs9JR4ZBSZonrYAT+GfzqmS8gQHr/LU7XgUdhxqmyJIh4U/Q7nWuX2dLLq5j+kgR24M5OrZTi5h
 31EZ7qd6tzd0X55+oEdaiNwjrEosE9Al2SfVRhnWEPCqruK9lac9SenUj3Kw+Wiz9Jg33J04lIZ4F
 JOSAJLXoc62n/3K8l26ZZRKFkwWR6Am2/tEWUvbeHQLxTnKV15/ixmzu/C7lPOoOS03sgGPmgI0eq
 DTmnt1sQ==;
Received: from [84.65.48.237] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uZ7JK-00E03Z-UO; Tue, 08 Jul 2025 14:20:35 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/sched: Avoid double re-lock on the job free path
Date: Tue,  8 Jul 2025 13:20:32 +0100
Message-ID: <20250708122032.75668-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Currently the job free work item will lock sched->job_list_lock first time
to see if there are any jobs, free a single job, and then lock again to
decide whether to re-queue itself if there are more finished jobs.

Since drm_sched_get_finished_job() already looks at the second job in the
queue we can simply add the signaled check and have it return the presence
of more jobs to free to the caller. That way the work item does not have
to lock the list again and repeat the signaled check.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 37 ++++++++++----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1f077782ec12..1bce0b66f89c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -366,22 +366,6 @@ static void __drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 		queue_work(sched->submit_wq, &sched->work_free_job);
 }
 
-/**
- * drm_sched_run_free_queue - enqueue free-job work if ready
- * @sched: scheduler instance
- */
-static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
-{
-	struct drm_sched_job *job;
-
-	spin_lock(&sched->job_list_lock);
-	job = list_first_entry_or_null(&sched->pending_list,
-				       struct drm_sched_job, list);
-	if (job && dma_fence_is_signaled(&job->s_fence->finished))
-		__drm_sched_run_free_queue(sched);
-	spin_unlock(&sched->job_list_lock);
-}
-
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
@@ -1102,12 +1086,13 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
  * @sched: scheduler instance
+ * @have_more: are there more finished jobs on the list
  *
  * Returns the next finished job from the pending list (if there is one)
  * ready for it to be destroyed.
  */
 static struct drm_sched_job *
-drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
+drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
 {
 	struct drm_sched_job *job, *next;
 
@@ -1115,22 +1100,25 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 
 	job = list_first_entry_or_null(&sched->pending_list,
 				       struct drm_sched_job, list);
-
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
 
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
-		/* make the scheduled timestamp more accurate */
+
+		*have_more = false;
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
-
 		if (next) {
+			/* make the scheduled timestamp more accurate */
 			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
 				     &next->s_fence->scheduled.flags))
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
+
+			*have_more = dma_fence_is_signaled(&next->s_fence->finished);
+
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
@@ -1189,12 +1177,15 @@ static void drm_sched_free_job_work(struct work_struct *w)
 	struct drm_gpu_scheduler *sched =
 		container_of(w, struct drm_gpu_scheduler, work_free_job);
 	struct drm_sched_job *job;
+	bool have_more;
 
-	job = drm_sched_get_finished_job(sched);
-	if (job)
+	job = drm_sched_get_finished_job(sched, &have_more);
+	if (job) {
 		sched->ops->free_job(job);
+		if (have_more)
+			__drm_sched_run_free_queue(sched);
+	}
 
-	drm_sched_run_free_queue(sched);
 	drm_sched_run_job_queue(sched);
 }
 
-- 
2.48.0

