Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81763C36019
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 20:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4CB10E485;
	Mon, 31 Mar 2025 20:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F5T9eNqJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22DE10E47B;
 Mon, 31 Mar 2025 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0UeIhW5wnZTI9hyYIqYK6KBHqOuuUlNTKq1OWnN8SCk=; b=F5T9eNqJg/6A+GH7iAwvCa9Cws
 sLlfzvoa1tLSDPEmt3VGXV0zNOnpSFmP407CDO3DzZrkgSHFu+UUBky4WZ1T9GBTkZq4k5dCg+pzj
 t7KtCKqb59v3wwAQvq702mQWa0SOCgZDQe8kt4meT1ufevxYkJ4rqRjipZO6tpG26AWA/9Hyo/Qyx
 QNZ3aqC7jhZ1vjR1z9Yxfmf6LGizJlhcv9ZT4fS3g06zfTZtrZZg9RwTHkXC8iJthFtkCMlZnLq1+
 103U+kZDFOGrkyNnhzv1/eExUqHrJ7RomGRwjWhaDp1ormqbWotxu/AxPxN2tklRBfA3Fn69cIQmC
 54gyD2AQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tzLZY-009M2u-5n; Mon, 31 Mar 2025 22:17:28 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC v3 03/14] drm/sched: Consolidate drm_sched_job_timedout
Date: Mon, 31 Mar 2025 21:16:54 +0100
Message-ID: <20250331201705.60663-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250331201705.60663-1-tvrtko.ursulin@igalia.com>
References: <20250331201705.60663-1-tvrtko.ursulin@igalia.com>
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

Reduce to one spin_unlock for hopefully a little bit clearer flow in the
function. It may appear that there is a behavioural change with the
drm_sched_start_timeout_unlocked() now not being called if there were
initially no jobs on the pending list, and then some appeared after
unlock, however if the code would rely on the TDR handler restarting
itself then it would fail to do that if the job arrived on the pending
list after the check.

Also fix one stale comment while touching the function.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 37 +++++++++++++-------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 4a4c07d0163c..f593b88ab02c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -522,38 +522,37 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
 
 static void drm_sched_job_timedout(struct work_struct *work)
 {
-	struct drm_gpu_scheduler *sched;
+	struct drm_gpu_scheduler *sched =
+		container_of(work, struct drm_gpu_scheduler, work_tdr.work);
+	enum drm_gpu_sched_stat status;
 	struct drm_sched_job *job;
-	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
-
-	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
 
 	/* Protects against concurrent deletion in drm_sched_get_finished_job */
 	spin_lock(&sched->job_list_lock);
 	job = list_first_entry_or_null(&sched->pending_list,
 				       struct drm_sched_job, list);
-
 	if (job) {
 		/*
 		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
+		 * drm_sched_get_finished_job. It will be reinserted back after
+		 * scheduler worker is stopped at which point it's safe.
 		 */
 		list_del_init(&job->list);
-		spin_unlock(&sched->job_list_lock);
+	}
+	spin_unlock(&sched->job_list_lock);
 
-		status = job->sched->ops->timedout_job(job);
+	if (!job)
+		return;
 
-		/*
-		 * Guilty job did complete and hence needs to be manually removed
-		 * See drm_sched_stop doc.
-		 */
-		if (sched->free_guilty) {
-			job->sched->ops->free_job(job);
-			sched->free_guilty = false;
-		}
-	} else {
-		spin_unlock(&sched->job_list_lock);
+	status = job->sched->ops->timedout_job(job);
+
+	/*
+	 * Guilty job did complete and hence needs to be manually removed. See
+	 * documentation for drm_sched_stop.
+	 */
+	if (sched->free_guilty) {
+		job->sched->ops->free_job(job);
+		sched->free_guilty = false;
 	}
 
 	if (status != DRM_GPU_SCHED_STAT_ENODEV)
-- 
2.48.0

