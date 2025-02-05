Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE4C0219D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B70510E40F;
	Wed,  5 Feb 2025 22:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JhEx9V7U";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAD210E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6n92MA0LwtlbndrwAzSebNW/OrcbYnnzLWJ0/98Je54=; b=JhEx9V7U6ASU9gLPTdch5zR00h
 yKf6mJrQsNmuqgSf865Iu9AV9UCRQe5ux6mx6lOS77X7VD3hwkrWYJMkdMCH9sfZUvyQy0LS6GRdl
 0QcvkmOz67o1g4PWjIxWdbm2ZKoC9fBAVhXippb6L1z41d/XdqVL5GE9NFw765kHe7mhoy4SOAsfm
 qn+0a1ucwenOPLdXlOg2R+aZLqJaZdtiOcf+ZBFxlEU1iJqYdl7+EDftJFkF1LH/MJu6yJbm8pekb
 T9ZHreYrVpwlHYeNXVk4+OaqcUybtYqX6jXfvcXY1zwd6d4tO1KueuqWXpPixFBKHXxdWyBnJspty
 zyKJsKeg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tfhP8-0041Ob-DW; Wed, 05 Feb 2025 16:33:36 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/4] drm/amdgpu: Use drm_sched_cancel_all_jobs helper
Date: Wed,  5 Feb 2025 15:33:30 +0000
Message-ID: <20250205153332.14852-3-tvrtko.ursulin@igalia.com>
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

Replace amdgpu_job_stop_all_jobs_on_sched() helper by scheduler common
drm_sched_cancel_all_jobs() and remove one duplicated instance of the
to_drm_sched_job() macro.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 --
 3 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d100bb7a137c..509460f5fe7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5980,7 +5980,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
 
 			if (need_emergency_restart)
-				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
+				drm_sched_cancel_all_jobs(&ring->sched,
+							  -EHWPOISON);
 		}
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..9e32c504b481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -411,40 +411,6 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
-#define to_drm_sched_job(sched_job)		\
-		container_of((sched_job), struct drm_sched_job, queue_node)
-
-void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
-{
-	struct drm_sched_job *s_job;
-	struct drm_sched_entity *s_entity = NULL;
-	int i;
-
-	/* Signal all jobs not yet scheduled */
-	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
-		struct drm_sched_rq *rq = sched->sched_rq[i];
-		spin_lock(&rq->lock);
-		list_for_each_entry(s_entity, &rq->entities, list) {
-			while ((s_job = to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
-				struct drm_sched_fence *s_fence = s_job->s_fence;
-
-				dma_fence_signal(&s_fence->scheduled);
-				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
-				dma_fence_signal(&s_fence->finished);
-			}
-		}
-		spin_unlock(&rq->lock);
-	}
-
-	/* Signal all jobs already scheduled to HW */
-	list_for_each_entry(s_job, &sched->pending_list, list) {
-		struct drm_sched_fence *s_fence = s_job->s_fence;
-
-		dma_fence_set_error(&s_fence->finished, -EHWPOISON);
-		dma_fence_signal(&s_fence->finished);
-	}
-}
-
 const struct drm_sched_backend_ops amdgpu_sched_ops = {
 	.prepare_job = amdgpu_job_prepare_job,
 	.run_job = amdgpu_job_run,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ce6b9ba967ff..5a25c281d98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -105,6 +105,4 @@ struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job);
 int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 			     struct dma_fence **fence);
 
-void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched);
-
 #endif
-- 
2.48.0

