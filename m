Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F6C02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F414210E40B;
	Wed,  5 Feb 2025 22:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QL30nR8P";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A86A10E386
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oa8kNF73PlkaJTngbTfwdPn9ARNh3UqWONQ1URzbPbM=; b=QL30nR8PN1UWl4EqyTeJ/pHRrj
 FiOTO5nsnaRKb5/yxfj6IH/7Ijc4jK8E287Z5MWzssbrAftuJkC26qaRKBU0PaIv0mC9QL03okOmP
 ubJJOmsoB3ZyyCfNxVJOyUKLbkLk4G8keDamwyydfpVzVxSag4qBoJMIyLj3uBXUv6pAL4WBBwW+/
 ozZqDqEW9bF0RJhM8UnNqO+pvPaPuc9euW7J+5Id/+21QuDWEqi0Vw/6XiAvhaoEyy6uphnCQAcYq
 c3WT9G3+E1VeCzXVA4DmAvH9UkMIDtL2g/H86VwhbGK+Zb720Ou2f08KgSa9FoCs6Yv+IY1l0t50z
 7F1zi9Bw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tfhP7-0041OV-MU; Wed, 05 Feb 2025 16:33:35 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
Date: Wed,  5 Feb 2025 15:33:29 +0000
Message-ID: <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
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

The helper copies code from the existing amdgpu_job_stop_all_jobs_on_sched
with the purpose of reducing the amount of driver code which directly
touch scheduler internals.

If or when amdgpu manages to change the approach for handling the
permanently wedged state this helper can be removed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 44 ++++++++++++++++++++++++++
 include/drm/gpu_scheduler.h            |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a48be16ab84f..0363655db22d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -703,6 +703,50 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
 }
 EXPORT_SYMBOL(drm_sched_start);
 
+/**
+ * drm_sched_cancel_all_jobs - Cancel all queued and scheduled jobs
+ *
+ * @sched: scheduler instance
+ * @errno: error value to set on signaled fences
+ *
+ * Signal all queued and scheduled jobs and set them to error state.
+ *
+ * Scheduler must be stopped before calling this.
+ */
+void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int errno)
+{
+	struct drm_sched_entity *entity;
+	struct drm_sched_fence *s_fence;
+	struct drm_sched_job *job;
+	enum drm_sched_priority p;
+
+	drm_WARN_ON_ONCE(sched, !sched->pause_submit);
+
+	/* Signal all jobs not yet scheduled */
+	for (p = DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs; p++) {
+		struct drm_sched_rq *rq = sched->sched_rq[p];
+
+		spin_lock(&rq->lock);
+		list_for_each_entry(entity, &rq->entities, list) {
+			while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
+				s_fence = job->s_fence;
+				dma_fence_signal(&s_fence->scheduled);
+				dma_fence_set_error(&s_fence->finished, errno);
+				dma_fence_signal(&s_fence->finished);
+			}
+		}
+		spin_unlock(&rq->lock);
+	}
+
+	/* Signal all jobs already scheduled to HW */
+	list_for_each_entry(job, &sched->pending_list, list) {
+		s_fence = job->s_fence;
+		dma_fence_set_error(&s_fence->finished, errno);
+		dma_fence_signal(&s_fence->finished);
+	}
+}
+EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
+
 /**
  * drm_sched_resubmit_jobs - Deprecated, don't use in new code!
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index a0ff08123f07..298513f8c327 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
 void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
+void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int errno);
 void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
 void drm_sched_increase_karma(struct drm_sched_job *bad);
 void drm_sched_reset_karma(struct drm_sched_job *bad);
-- 
2.48.0

