Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D959AC83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 09:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07E210E5FB;
	Tue,  8 Jul 2025 09:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NXOPy0ef";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F5A10E5E7;
 Tue,  8 Jul 2025 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wLc79qwFhp2VYeEN0pbcSv4L6Ipeb29vtsUVovwqCRE=; b=NXOPy0efyD5FAQDtm0Q70R+pv5
 Vc+QjdUdEuKdgvEKByR1QKJ8kftwKo9EJCCG7vkaOhe10pyISrAL4HtnGRR+A5P0Bq3ysHWC4Sag4
 tSM8rsmtgXqOeJZK2hw8vZsP7PkMM0KkZYbHFeCmgH6W2vu7+GJ3nu1qr5P6LX+WcSBbshekOGYxa
 mdLXL1mUW9DNEzNuS4tQ+HQrYv3tdDW4JjbSQnCFyLHuL0hl2pgESwJ/QX0zu0JJdnc/lmTR8lf9W
 1giUQ1w6EjcF9sPZPhXMwxd501IVI4MCW26Bcxdlm2s6hL1XFnwe5rfs8IHWFO34KeRYKlMcDeYc8
 aym0RkUg==;
Received: from [84.65.48.237] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uZ4zU-00Dx43-UX; Tue, 08 Jul 2025 11:51:57 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v6 09/15] drm/sched: Free all finished jobs at once
Date: Tue,  8 Jul 2025 10:51:41 +0100
Message-ID: <20250708095147.73366-10-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250708095147.73366-1-tvrtko.ursulin@igalia.com>
References: <20250708095147.73366-1-tvrtko.ursulin@igalia.com>
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

To implement fair scheduling we will need as accurate as possible view
into per entity GPU time utilisation. Because sched fence execution time
are only adjusted for accuracy in the free worker we need to process
completed jobs as soon as possible so the metric is most up to date when
view from the submission side of things.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c906c2f3e6d5..f87bb4681b93 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -870,13 +870,12 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
  * @sched: scheduler instance
- * @have_more: are there more finished jobs on the list
  *
  * Returns the next finished job from the pending list (if there is one)
  * ready for it to be destroyed.
  */
 static struct drm_sched_job *
-drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
+drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_job *job, *next;
 
@@ -891,7 +890,6 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
 
-		*have_more = false;
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
@@ -901,8 +899,6 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
 
-			*have_more = dma_fence_is_signaled(&next->s_fence->finished);
-
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
@@ -961,14 +957,9 @@ static void drm_sched_free_job_work(struct work_struct *w)
 	struct drm_gpu_scheduler *sched =
 		container_of(w, struct drm_gpu_scheduler, work_free_job);
 	struct drm_sched_job *job;
-	bool have_more;
 
-	job = drm_sched_get_finished_job(sched, &have_more);
-	if (job) {
+	while ((job = drm_sched_get_finished_job(sched)))
 		sched->ops->free_job(job);
-		if (have_more)
-			__drm_sched_run_free_queue(sched);
-	}
 
 	drm_sched_run_job_queue(sched);
 }
-- 
2.48.0

