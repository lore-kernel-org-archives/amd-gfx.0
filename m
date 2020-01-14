Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC31C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D2D24672
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU1EUPjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2D24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F41C6E463;
	Tue, 14 Jan 2020 20:04:55 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F856E454
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 20:04:53 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so15312449wmj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nPslf8XCLfvyiJAtfLgumBexLTX1YYwTo6fETm/ZqkA=;
 b=mU1EUPjENPxecqsXT6CCHpzxl5tLp5RuH9kcCIisMXzsuvlhLlFbw1arNChWoWOQPG
 UjAEPsgp/s+Moqvva2UYaws38WULDaVdFIZYnXg30qKepoa1uplOiEgyJixeE/Bzsna5
 t5c5Ji7qKmMZ0ydLkb7og6m2Duc1eVlULgAmYqoYdRWfIdN24pefGaf9svJ9279ZK1iP
 09BVWmi2Qp7IODK/OHvPDEJ5rvvK6fuNqG7tiv+z4IGFMDaWNibOkhlrFiT0Fy+BrpKr
 vaOLrNOZGXkXoL2STpOD+GvRJ0MRA/YKFbYQmLGxAmWlOxIP0e8YVnVl/NMXNw1tWS9P
 VCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nPslf8XCLfvyiJAtfLgumBexLTX1YYwTo6fETm/ZqkA=;
 b=pJJw6cnYPJiLG3tqa7i1mbeZETem7W+69+nbLdvCHs0z4vqvewM6D7pnGLLIclpkvN
 rD6gtt4FPOyJfJ7hOH+ptcPs4z/2AftaLn1Gfje/Qy9vWwKR+fuRT756cFnp8aBZDI2l
 P5dBDmYQjfO81i8xJCERnEW388lP8mDDXFpaCZSn256OeOPbbrP4ImLTb4bC9Nnj3kL4
 anXe3SzwW3tLGwwS9dB4T8yuvaYgVfg/blIKsk8fr/n9kLaV5aD5vCRcHigcXPcIfZGn
 8J9WIun3RUFiP1ZWh76qQ30oEI8c/kNrFDumH2XxEdqftntqva/mu5C50hkb616vKt2J
 5MMQ==
X-Gm-Message-State: APjAAAUlqee0q3SeusfViViyWF/LXXgGZSob5EyBwbyofx7EzbRCUK5l
 kh+8IaMi5Kb34FJCrUkHorQBhLhjcDPf04rh
X-Google-Smtp-Source: APXvYqzzzWibxkljT4uxl5rVITZ1qOZs8NQhteIiYRbNZNxjDLOROjwYnWQU1kq9tHdEFY+gdYrQtQ==
X-Received: by 2002:a1c:49c2:: with SMTP id
 w185mr28217867wma.138.1579032292214; 
 Tue, 14 Jan 2020 12:04:52 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F343700CDDF573F1071AE40.dip0.t-ipconnect.de.
 [2003:c5:8f34:3700:cddf:573f:1071:ae40])
 by smtp.gmail.com with ESMTPSA id n3sm20047784wrs.8.2020.01.14.12.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 12:04:51 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH] drm/scheduler: use idle time to do better loadbalance
Date: Tue, 14 Jan 2020 21:06:17 +0100
Message-Id: <20200114200617.3510-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds required fields to drm_sched_job and drm_gpu_scheduler
structure to cumulatively calculate amount of time a drm_gpu_scheduler
spend on serving a job.

Using least used drm scheduler to choose a run queue
improves drm_sched_entity_get_free_sched()'s job distribution

Below are test results after running amdgpu_test from mesa drm

Before this patch:

sched_name     num of many times it got scheduled
=========      ==================================
sdma0	       314
sdma1          32
comp_1.0.0     56

After this patch:

sched_name     num of many times it got scheduled
=========      ==================================
sdma0	       210
sdma1          211
comp_1.0.0     10
comp_1.0.1     10
comp_1.1.0     14
comp_1.1.1     6
comp_1.2.0     12
comp_1.2.1     14
comp_1.3.0     8
comp_1.3.1     10

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 23 +++++++++++++++++------
 drivers/gpu/drm/scheduler/sched_main.c   |  7 +++++--
 include/drm/gpu_scheduler.h              | 11 ++++++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..e71cfe47b0e1 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -130,9 +130,10 @@ static struct drm_sched_rq *
 drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 {
 	struct drm_sched_rq *rq = NULL;
-	unsigned int min_jobs = UINT_MAX, num_jobs;
-	int i;
+	uint64_t min_time_consumed = -1, total_consumed_time;
+	int i, skip_idx = 0;
 
+	spin_lock(&entity->sched_list[0]->last_picked_lock);
 	for (i = 0; i < entity->num_sched_list; ++i) {
 		struct drm_gpu_scheduler *sched = entity->sched_list[i];
 
@@ -141,13 +142,23 @@ drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 			continue;
 		}
 
-		num_jobs = atomic_read(&sched->num_jobs);
-		if (num_jobs < min_jobs) {
-			min_jobs = num_jobs;
+		total_consumed_time = atomic64_read(&sched->total_consumed_time);
+		if (total_consumed_time < min_time_consumed && !sched->last_picked) {
+			min_time_consumed = total_consumed_time;
 			rq = &entity->sched_list[i]->sched_rq[entity->priority];
+			sched->last_picked = true;
+			skip_idx = i;
 		}
 	}
 
+	for (i = 0; i < entity->num_sched_list; ++i) {
+		struct drm_gpu_scheduler *sched = entity->sched_list[i];
+
+		if (i != skip_idx)
+			sched->last_picked = false;
+	}
+
+	spin_unlock(&entity->sched_list[0]->last_picked_lock);
 	return rq;
 }
 
@@ -498,7 +509,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
 	bool first;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(&entity->rq->sched->num_jobs);
+	sched_job->start_time = ktime_get_ns();
 	WRITE_ONCE(entity->last_user, current->group_leader);
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..8f3c6f62c7dc 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -653,13 +653,14 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
 	struct drm_sched_fence *s_fence = s_job->s_fence;
 	struct drm_gpu_scheduler *sched = s_fence->sched;
+	uint64_t end = ktime_get_ns();
 
 	atomic_dec(&sched->hw_rq_count);
-	atomic_dec(&sched->num_jobs);
 
 	trace_drm_sched_process_job(s_fence);
 
 	drm_sched_fence_finished(s_fence);
+	atomic64_add((end - s_job->start_time), &sched->total_consumed_time);
 	wake_up_interruptible(&sched->wake_up_worker);
 }
 
@@ -828,9 +829,10 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->ring_mirror_list);
 	spin_lock_init(&sched->job_list_lock);
+	spin_lock_init(&sched->last_picked_lock);
 	atomic_set(&sched->hw_rq_count, 0);
+	atomic64_set(&sched->total_consumed_time, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
-	atomic_set(&sched->num_jobs, 0);
 	atomic64_set(&sched->job_id_count, 0);
 
 	/* Each scheduler will run on a seperate kernel thread */
@@ -843,6 +845,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	}
 
 	sched->ready = true;
+	sched->last_picked = false;
 	return 0;
 }
 EXPORT_SYMBOL(drm_sched_init);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 96a1a1b7526e..9b71facad1cd 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -191,6 +191,7 @@ struct drm_sched_job {
 	struct dma_fence_cb		finish_cb;
 	struct list_head		node;
 	uint64_t			id;
+	uint64_t			start_time;
 	atomic_t			karma;
 	enum drm_sched_priority		s_priority;
 	struct drm_sched_entity  *entity;
@@ -261,9 +262,11 @@ struct drm_sched_backend_ops {
  * @job_list_lock: lock to protect the ring_mirror_list.
  * @hang_limit: once the hangs by a job crosses this limit then it is marked
  *              guilty and it will be considered for scheduling further.
- * @num_jobs: the number of jobs in queue in the scheduler
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
+ * @last_picked: Indicate if the sched was pick up on last loadbalance decision
+ * @last_picked_lock: lock to protect the last_picked
+ * @total_consumed_time: Total time consumed by this sched executing jobs
  *
  * One scheduler is implemented for each hardware ring.
  */
@@ -282,9 +285,11 @@ struct drm_gpu_scheduler {
 	struct list_head		ring_mirror_list;
 	spinlock_t			job_list_lock;
 	int				hang_limit;
-	atomic_t                        num_jobs;
-	bool			ready;
+	bool				ready;
 	bool				free_guilty;
+	bool				last_picked;
+	spinlock_t			last_picked_lock;
+	atomic64_t			total_consumed_time;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
