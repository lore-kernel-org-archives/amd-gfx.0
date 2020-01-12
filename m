Return-Path: <SRS0=GvpJ=3B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378FEC33CA7
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jan 2020 01:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E70206E2
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jan 2020 01:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLrIgjAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E70206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734A76E2B4;
	Sun, 12 Jan 2020 01:23:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37E46E2B4
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jan 2020 01:23:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b19so5905995wmj.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR2qBUCX9Om9MxUupoQKGS56wJrprwfAkBcEpMdjsv8=;
 b=RLrIgjAFv+Iyc0yNkr3omOCKwZ3H0Ehd/LvHI/Glwu9wdA9ys4m8XqDtsgVdm39x5W
 TLZMv5EPoICXMbdSbt5bCIoepjK+IAUkYr9eack9a24iLAxniY1ny6Wh6d/K+EMap87M
 c/wXN/9iwF/q/RzJH8Nri+y0N+qR3K2Rf/8Hx1ouTOZYeI626OLVGJNMAeIxMy6oFNhX
 DCpEsFFXLzk0RGIlUgBtDjrOuShyToqYfBUiCiYNZ6F9vd69f+IUdd+YMOorY0M2nSCJ
 ZYABTNjC+bdsNEpDgT6zWj218tQRaxtTEDknNiP31UB96QXmVVuZ2gJeV9Q1MRTj6qpC
 /niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR2qBUCX9Om9MxUupoQKGS56wJrprwfAkBcEpMdjsv8=;
 b=CuZ9Rhix0CdCTvCMUu+DfqERGLRVMCEzaGRCjWxVqc4O+yycdWz+6cgd90F5OExo3z
 ob5Jd6DJujGUl4DcBF92gOXl1lHad7myB8CYDi5snhwSNZ5xhHRCB6xznkyMLn0Z67R/
 6xQJwZBc6Mj2rC0UntJbgLNXFjJ76g+cXofqsG3aKHTeNopKr+LiMwdFRSvbx6Unfqp2
 mxnUi6tmvW4UEEYIECwbJm8u64SJdiranhfBGH+Tb3gc8n+dEfD0O0y+lJQtc3lNIz43
 hl4n2tNLVo47bvNrSfWpVU65Uaxlrg2bf/rY0y36cMqSYOJvSnxi6McgSOQ4PSxj0kYQ
 E5dA==
X-Gm-Message-State: APjAAAWt1FEEAd+VX+bWAmEG9+GwSnFegNJ3y8lOtr3CqHremUKFS3Du
 bYZVgalLv/o/5bRpkUDgaAe84HPlXLA=
X-Google-Smtp-Source: APXvYqzeOp+XDmBrLMn/W9d0wLbXwb88Z0aBJ9+r0t1DXNT1sn4WME2E0T7KGdkUSCrLcQUN9sfpNA==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr12058474wmc.112.1578792233194; 
 Sat, 11 Jan 2020 17:23:53 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F028C00C12D27CB56CFD93F.dip0.t-ipconnect.de.
 [2003:c5:8f02:8c00:c12d:27cb:56cf:d93f])
 by smtp.gmail.com with ESMTPSA id n3sm8107013wrs.8.2020.01.11.17.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2020 17:23:52 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH] drm/scheduler: use idle time to do better loadbalance
Date: Sun, 12 Jan 2020 02:25:07 +0100
Message-Id: <20200112012507.7468-1-nirmoy.das@amd.com>
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
sdma0	       113
sdma1          383
comp_1.0.0     9
comp_1.0.1     9
comp_1.1.0     8
comp_1.1.1     8
comp_1.2.0    12
comp_1.2.1    13
comp_1.3.0    16
comp_1.3.1    9

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 9 +++++----
 drivers/gpu/drm/scheduler/sched_main.c   | 2 ++
 include/drm/gpu_scheduler.h              | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..b5555af787d0 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -130,7 +130,7 @@ static struct drm_sched_rq *
 drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 {
 	struct drm_sched_rq *rq = NULL;
-	unsigned int min_jobs = UINT_MAX, num_jobs;
+	uint64_t min_time_consumed = -1, total_consumed_time;
 	int i;
 
 	for (i = 0; i < entity->num_sched_list; ++i) {
@@ -141,9 +141,9 @@ drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 			continue;
 		}
 
-		num_jobs = atomic_read(&sched->num_jobs);
-		if (num_jobs < min_jobs) {
-			min_jobs = num_jobs;
+		total_consumed_time = sched->total_consumed_time;
+		if (total_consumed_time < min_time_consumed) {
+			min_time_consumed = total_consumed_time;
 			rq = &entity->sched_list[i]->sched_rq[entity->priority];
 		}
 	}
@@ -499,6 +499,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
 
 	trace_drm_sched_job(sched_job, entity);
 	atomic_inc(&entity->rq->sched->num_jobs);
+	sched_job->start_time = ktime_get_ns();
 	WRITE_ONCE(entity->last_user, current->group_leader);
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..67fdf4f248d4 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -653,6 +653,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
 	struct drm_sched_fence *s_fence = s_job->s_fence;
 	struct drm_gpu_scheduler *sched = s_fence->sched;
+	uint64_t end = ktime_get_ns();
 
 	atomic_dec(&sched->hw_rq_count);
 	atomic_dec(&sched->num_jobs);
@@ -660,6 +661,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 	trace_drm_sched_process_job(s_fence);
 
 	drm_sched_fence_finished(s_fence);
+	s_job->sched->total_consumed_time += end - s_job->start_time;
 	wake_up_interruptible(&sched->wake_up_worker);
 }
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 96a1a1b7526e..496d9b209d12 100644
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
@@ -285,6 +286,7 @@ struct drm_gpu_scheduler {
 	atomic_t                        num_jobs;
 	bool			ready;
 	bool				free_guilty;
+	uint64_t			total_consumed_time;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
