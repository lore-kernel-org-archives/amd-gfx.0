Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F8C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D6610E253;
	Thu, 20 Apr 2023 11:57:59 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAA410E253
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:57:56 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id fy21so5704567ejb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991875; x=1684583875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gnGFSay68pYsYx3oU6R1xtr8le0FBIsjUWzvjxKwKGc=;
 b=S7PKbT1T4dr/p4M+EO2NYDKNlQqTWr+lyII2HmaGyj7aY4e366W2QE4XAtakII2thL
 eEMHx7Pb+7hGqhbBbTG2yBISdxv+BuwtmJJdQxg+SPBkDtVe3XL3leU4wWcaN4SzYL4Y
 nh9gXZZOmBn57gvfDrzauG5x8X1msAX463ouVM/sotMMm4vaZXAnadGdtwhWkEGqqGcR
 MoHGURgiEcODs6S7WSNt2L43MGIki1fTfno8f/HyExDiQHlVw4unwe9ImC3ddHvV9109
 VgxUy3jYEm7TXcDu7AIghBzXlXoP4+ogr/+0xZrL9WabeGgR7Tt/Cjs5NEOtt/Fs8MYg
 Wujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991875; x=1684583875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnGFSay68pYsYx3oU6R1xtr8le0FBIsjUWzvjxKwKGc=;
 b=RuV8SJvJSzjQ3rj/PgkMjrQpnVokHJqPQ6HWawdxRZPRGhXDzWFIcLoNGqiEjRZVmx
 6AfRUUHCVevXmyKhd0jVPBxQMyxWU1dCJJiCipAjYm16pv7wPw8GdNdkVMhK/YQtrDwM
 mER2mKNOrQxRMUz+/Gq3UK4shEv3ken31PG8ZLN9JM+L6sJ2BCvA8QHlJIlUxH1xJ/qf
 ghPVxGOUHrKxQ2E3gFcYubFei9zNU9yR8WZQ4Y3gb+91dn8m4JHzYiGh+MmZ8buemLl4
 glt5Rjxvjt9PMyZlOGLDTpZzBZ0kz4IsPx5QYl74lE9AT11slvETcuOW2UN/10RK6/CA
 8A1w==
X-Gm-Message-State: AAQBX9fvkYYy3wIMUjkQVK/tcl3bpiqBspoJQ275s2JeEXR2YXHhm5M9
 AhLscEe6Gi75QCqPC3/kR36PlALepXGAUA==
X-Google-Smtp-Source: AKy350bJzjr2zK6omDq0rblDCXodMU481e7uYik9Tzqi8XICNZOiGDjyolC5oT7jdFHstzDNyL+97w==
X-Received: by 2002:a17:906:1504:b0:94a:a0d7:b7bc with SMTP id
 b4-20020a170906150400b0094aa0d7b7bcmr1415247ejd.10.1681991874820; 
 Thu, 20 Apr 2023 04:57:54 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:54 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/scheduler: properly forward fence errors
Date: Thu, 20 Apr 2023 13:57:45 +0200
Message-Id: <20230420115752.31470-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When a hw fence is signaled with an error properly forward that to the
finished fence.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  4 +---
 drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
 drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
 include/drm/gpu_scheduler.h              |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 15d04a0ec623..eaf71fe15ed3 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
 
-	drm_sched_fence_finished(job->s_fence);
+	drm_sched_fence_finished(job->s_fence, -ESRCH);
 	WARN_ON(job->s_fence->parent);
 	job->sched->ops->free_job(job);
 }
@@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
 		struct drm_sched_fence *s_fence = job->s_fence;
 
-		dma_fence_set_error(&s_fence->finished, -ESRCH);
-
 		dma_fence_get(&s_fence->finished);
 		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
 					   drm_sched_entity_kill_jobs_cb))
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 7fd869520ef2..1a6bea98c5cc 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence)
 	dma_fence_signal(&fence->scheduled);
 }
 
-void drm_sched_fence_finished(struct drm_sched_fence *fence)
+void drm_sched_fence_finished(struct drm_sched_fence *fence, int result)
 {
+	if (result)
+		dma_fence_set_error(&fence->finished, result);
 	dma_fence_signal(&fence->finished);
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index fcd4bfef7415..649fac2e1ccb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
  *
  * Finish the job's fence and wake up the worker thread.
  */
-static void drm_sched_job_done(struct drm_sched_job *s_job)
+static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
 {
 	struct drm_sched_fence *s_fence = s_job->s_fence;
 	struct drm_gpu_scheduler *sched = s_fence->sched;
@@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job)
 	trace_drm_sched_process_job(s_fence);
 
 	dma_fence_get(&s_fence->finished);
-	drm_sched_fence_finished(s_fence);
+	drm_sched_fence_finished(s_fence, result);
 	dma_fence_put(&s_fence->finished);
 	wake_up_interruptible(&sched->wake_up_worker);
 }
@@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)
 {
 	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
 
-	drm_sched_job_done(s_job);
+	drm_sched_job_done(s_job, f->error);
 }
 
 /**
@@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
 			r = dma_fence_add_callback(fence, &s_job->cb,
 						   drm_sched_job_done_cb);
 			if (r == -ENOENT)
-				drm_sched_job_done(s_job);
+				drm_sched_job_done(s_job, fence->error);
 			else if (r)
 				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 		} else
-			drm_sched_job_done(s_job);
+			drm_sched_job_done(s_job, 0);
 	}
 
 	if (full_recovery) {
@@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
 			r = dma_fence_add_callback(fence, &sched_job->cb,
 						   drm_sched_job_done_cb);
 			if (r == -ENOENT)
-				drm_sched_job_done(sched_job);
+				drm_sched_job_done(sched_job, fence->error);
 			else if (r)
 				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 		} else {
-			if (IS_ERR(fence))
-				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
-
-			drm_sched_job_done(sched_job);
+			drm_sched_job_done(sched_job, IS_ERR(fence) ?
+					   PTR_ERR(fence) : 0);
 		}
 
 		wake_up(&sched->job_scheduled);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index ca857ec9e7eb..5c1df6b12ced 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 void drm_sched_fence_free(struct drm_sched_fence *fence);
 
 void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
-void drm_sched_fence_finished(struct drm_sched_fence *fence);
+void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
 
 unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
 void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
-- 
2.34.1

