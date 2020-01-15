Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6694C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79152214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXCE1CSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79152214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5978889D84;
	Wed, 15 Jan 2020 17:20:37 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BF189D84
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 17:20:36 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p17so806492wmb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UuI4fwQHTeptAdsRphcNRHk2tv40uzSvtMq1z2K766A=;
 b=WXCE1CSaL180CCwiQ+kUivgWNu7XqqampHYNhJFZlwK7th9cgnN7vjjfizutOzdL+K
 v/qP2SscOvJfwoSiR6PwjXdieV6s/Fz1URq4yy2Oo/SBvVobojOMJXAradgjFQpIWkvh
 +RiXM8Duh/3vbLNFPjz2cwlJ+HwuTewhf7R/ut5uzU7AD/IF7xqiDlEps7kPZBFEgOhV
 s7laV9iqrvWQh9EB1CqEpqbkluH1PgAlxYl2ZSd2L9JmtGjTJfTLru5QLBPopL91NgCZ
 lqrcsC1cWuFCN71rE7Q5e2F7sQcR315iHYMr23e0Qs5+SpDMa16QRvR5K9p9QGqtZ2h5
 MpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UuI4fwQHTeptAdsRphcNRHk2tv40uzSvtMq1z2K766A=;
 b=KYv0taL8TEtoUumX1r12R/LEsKMr2+4TCfpz+v6R8m8z026jyNFlbTf5aEK1FfUetV
 947TUsgGPs5zB4AldiLt0AIgV23aFZruGOwnagD95MIlCvgUx1VU1wvpsciXKvy0AqSq
 IF4fSN7k72u7I7mBldWH+w8xjxuWA2IkyusTFM3zcBWK5KxupRtK1iwTWfat33saFHEX
 ydFQesehn+ZIXWcBZNhdKgmZqk+cGvOqic0pasw/hN/c4Go8JY0tkpKH+vLoKF8BmYe1
 l1gkDB58G/9Gb80S1fj3Hmqx2RM3ODMJMxuL23JJqXxGQvX+Ta/8adkMbJ8GX2TjfeUj
 s6gQ==
X-Gm-Message-State: APjAAAUnHZcnn/r5RB58KOkTUkEHDp+Q8cYfcOCiBsA3wYt1iNNBdfoA
 wf165ohPtnyeWMZ9JRnC1kYHhqlPARCq1EAg
X-Google-Smtp-Source: APXvYqwheZ6yOzNHssPCwz1z92Wxd1dChfeXOA8IGxEOly0UuA9rpuyfU3p1ryhzT9fU8/AfRQNOCQ==
X-Received: by 2002:a05:600c:10cd:: with SMTP id
 l13mr1050376wmd.102.1579108834175; 
 Wed, 15 Jan 2020 09:20:34 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2BBB00033A7193FF097830.dip0.t-ipconnect.de.
 [2003:c5:8f2b:bb00:33a:7193:ff09:7830])
 by smtp.gmail.com with ESMTPSA id a9sm155846wmm.15.2020.01.15.09.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 09:20:33 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: improve job distribution with multiple queues
Date: Wed, 15 Jan 2020 18:21:53 +0100
Message-Id: <20200115172153.33694-1-nirmoy.das@amd.com>
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

This patch uses score based logic to select a new rq for better
loadbalance between multiple rq/scheds instead of num_jobs.

Below are test results after running amdgpu_test from mesa drm

Before this patch:

sched_name     num of many times it got scheduled
=========      ==================================
sdma0          314
sdma1          32
comp_1.0.0     56
comp_1.0.1     0
comp_1.1.0     0
comp_1.1.1     0
comp_1.2.0     0
comp_1.2.1     0
comp_1.3.0     0
comp_1.3.1     0
After this patch:

sched_name     num of many times it got scheduled
=========      ==================================
sdma0          216
sdma1          185
comp_1.0.0     39
comp_1.0.1     9
comp_1.1.0     12
comp_1.1.1     0
comp_1.2.0     12
comp_1.2.1     0
comp_1.3.0     12
comp_1.3.1     0

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++-----
 drivers/gpu/drm/scheduler/sched_main.c   |  6 ++++--
 include/drm/gpu_scheduler.h              |  6 +++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..33e2cd1089a2 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -130,7 +130,7 @@ static struct drm_sched_rq *
 drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 {
 	struct drm_sched_rq *rq = NULL;
-	unsigned int min_jobs = UINT_MAX, num_jobs;
+	unsigned int min_score = UINT_MAX, num_score;
 	int i;
 
 	for (i = 0; i < entity->num_sched_list; ++i) {
@@ -141,9 +141,9 @@ drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 			continue;
 		}
 
-		num_jobs = atomic_read(&sched->num_jobs);
-		if (num_jobs < min_jobs) {
-			min_jobs = num_jobs;
+		num_score = atomic_read(&sched->score);
+		if (num_score < min_score) {
+			min_score = num_score;
 			rq = &entity->sched_list[i]->sched_rq[entity->priority];
 		}
 	}
@@ -498,7 +498,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
 	bool first;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(&entity->rq->sched->num_jobs);
+	atomic_inc(&entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..71ce6215956f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -92,6 +92,7 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
 	if (!list_empty(&entity->list))
 		return;
 	spin_lock(&rq->lock);
+	atomic_inc(&rq->sched->score);
 	list_add_tail(&entity->list, &rq->entities);
 	spin_unlock(&rq->lock);
 }
@@ -110,6 +111,7 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	if (list_empty(&entity->list))
 		return;
 	spin_lock(&rq->lock);
+	atomic_dec(&rq->sched->score);
 	list_del_init(&entity->list);
 	if (rq->current_entity == entity)
 		rq->current_entity = NULL;
@@ -655,7 +657,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 	struct drm_gpu_scheduler *sched = s_fence->sched;
 
 	atomic_dec(&sched->hw_rq_count);
-	atomic_dec(&sched->num_jobs);
+	atomic_dec(&sched->score);
 
 	trace_drm_sched_process_job(s_fence);
 
@@ -830,7 +832,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	spin_lock_init(&sched->job_list_lock);
 	atomic_set(&sched->hw_rq_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
-	atomic_set(&sched->num_jobs, 0);
+	atomic_set(&sched->score, 0);
 	atomic64_set(&sched->job_id_count, 0);
 
 	/* Each scheduler will run on a seperate kernel thread */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 96a1a1b7526e..537f7a4655a5 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -261,7 +261,7 @@ struct drm_sched_backend_ops {
  * @job_list_lock: lock to protect the ring_mirror_list.
  * @hang_limit: once the hangs by a job crosses this limit then it is marked
  *              guilty and it will be considered for scheduling further.
- * @num_jobs: the number of jobs in queue in the scheduler
+ * @score: score to help loadbalancer pick a idle sched
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
  *
@@ -282,8 +282,8 @@ struct drm_gpu_scheduler {
 	struct list_head		ring_mirror_list;
 	spinlock_t			job_list_lock;
 	int				hang_limit;
-	atomic_t                        num_jobs;
-	bool			ready;
+	atomic_t                        score;
+	bool				ready;
 	bool				free_guilty;
 };
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
