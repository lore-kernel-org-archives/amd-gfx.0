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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680FC33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 15:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD761207FF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 15:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtfowkn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD761207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD276E41A;
	Tue, 14 Jan 2020 15:42:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F344C6E420
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 15:42:18 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f129so14275349wmf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CJ1xULLzqJQIsGZPXG23x8cIRMDJjcBV3bSI+pIfc28=;
 b=Jtfowkn4GmQO9oUeeaahles9yTixOGGfAKviEjek1lcT1iAPgu555yEwrDgmSNH5Kr
 cBkD6ELtG8ZMJTK5BHHGNk9SC7t3me5yFGKR/zcrKbOxDA9taXBZPadAyRET0yfLG8Gd
 nW0xv7WgOQT8OYMixuTxJOynCffCV1QF8nVV+gRY0W+NaoHFPsPfltbSiUSmENv6j5VJ
 SJIO95TS4+5i0tbba+klxnM404xAYb8PXLBa/3cqO5WYOcuHNxqGFntP4+FSNZKr1xZa
 M5Jz5BaAKg02Ixx5UErF7No/5G3ZyVHU97+ystNAvLE2yjbY0EbfV/AQuQbykNB093h+
 PlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CJ1xULLzqJQIsGZPXG23x8cIRMDJjcBV3bSI+pIfc28=;
 b=p7nV1/inCx4l8Sq7x45zi9kKs5J7bZj33qZuSRBcYSNH+U+pJetbUDsbGrisvGmovG
 gJ3j4I0Mu7YN1NTQ/nNs7Bbt3r/bMrgUORbhh/8FzfNij9xycb13V8038/3XGE71bf2k
 WazrOX38Lf3YJvBQ4xc5w2D5FKbZ8ie/ocioCYpDgyM7eTQY6YFC9fz0rB5rw5yxVpWg
 XNLibgroNP16oAneLYoxUuq2NZG5EEQ3nbJASEq+wMSdXKDAk4NWFKpkHyjPUnvCa7eq
 4IQqE+438TCHGv/AJ3fbzWvLvbgJI20RNe9jGzcSDUlwv3uliTUXvA12fXorHp+u+W5H
 L1yQ==
X-Gm-Message-State: APjAAAWGg90xasp/g51glJ4R5PaRNzUKhnl7D2IMl8gt4dOmmCJV3I0s
 z+XRwnTbTi7oH6FaLUcQ8cbPNuMM0Q0rQhgG
X-Google-Smtp-Source: APXvYqy2CyFGxfpJsJzA3l9XaGnxRNab7aGwX3NAZWflcY4WvzSnBnr4y89U2AjXv5TPbWCiPwD0Ng==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr27968163wmj.130.1579016537105; 
 Tue, 14 Jan 2020 07:42:17 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F343700CDDF573F1071AE40.dip0.t-ipconnect.de.
 [2003:c5:8f34:3700:cddf:573f:1071:ae40])
 by smtp.gmail.com with ESMTPSA id b17sm20429892wrx.15.2020.01.14.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:42:16 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: fix race condition in load balancer
Date: Tue, 14 Jan 2020 16:43:39 +0100
Message-Id: <20200114154339.3519-1-nirmoy.das@amd.com>
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

Jobs submitted in an entity should execute in the order those jobs
are submitted. We make sure that by checking entity->job_queue in
drm_sched_entity_select_rq() so that we don't loadbalance jobs within
an entity.

But because we update entity->job_queue later in drm_sched_entity_push_job(),
there remains a open window when it is possibe that entity->rq might get
updated by drm_sched_entity_select_rq() which should not be allowed.

Changes in this part also improves job distribution.
Below are test results after running amdgpu_test from mesa drm

Before this patch:

sched_name     num of many times it got scheduled
=========      ==================================
sdma0          314
sdma1          32
comp_1.0.0     56
comp_1.1.0     0
comp_1.1.1     0
comp_1.2.0     0
comp_1.2.1     0
comp_1.3.0     0
comp_1.3.1     0

After this patch:

sched_name     num of many times it got scheduled
=========      ==================================
 sdma1          243
 sdma0          164
 comp_1.0.1     14
 comp_1.1.0     11
 comp_1.1.1     10
 comp_1.2.0     15
 comp_1.2.1     14
 comp_1.3.0     10
 comp_1.3.1     10

Fixes: 35e160e781a048 (drm/scheduler: change entities rq even earlier)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 9 +++++++--
 drivers/gpu/drm/scheduler/sched_main.c   | 1 +
 include/drm/gpu_scheduler.h              | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..8414e084b6ac 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -67,6 +67,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->priority = priority;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	entity->last_scheduled = NULL;
+	entity->loadbalance_on = true;
 
 	if(num_sched_list)
 		entity->rq = &sched_list[0]->sched_rq[entity->priority];
@@ -447,6 +448,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
 
 	spsc_queue_pop(&entity->job_queue);
+	if (!spsc_queue_count(&entity->job_queue))
+		entity->loadbalance_on = true;
+
 	return sched_job;
 }
 
@@ -463,7 +467,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct dma_fence *fence;
 	struct drm_sched_rq *rq;
 
-	if (spsc_queue_count(&entity->job_queue) || entity->num_sched_list <= 1)
+	atomic_inc(&entity->rq->sched->num_jobs);
+	if ((entity->num_sched_list <= 1) || !entity->loadbalance_on)
 		return;
 
 	fence = READ_ONCE(entity->last_scheduled);
@@ -477,6 +482,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		entity->rq = rq;
 	}
 
+	entity->loadbalance_on = false;
 	spin_unlock(&entity->rq_lock);
 }
 
@@ -498,7 +504,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
 	bool first;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(&entity->rq->sched->num_jobs);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..00fdc350134e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -562,6 +562,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		return -ENOENT;
 
 	sched = entity->rq->sched;
+	atomic_inc(&entity->rq->sched->num_jobs);
 
 	job->sched = sched;
 	job->entity = entity;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 96a1a1b7526e..a5190869d323 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -97,6 +97,7 @@ struct drm_sched_entity {
 	struct dma_fence                *last_scheduled;
 	struct task_struct		*last_user;
 	bool 				stopped;
+	bool				loadbalance_on;
 	struct completion		entity_idle;
 };
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
