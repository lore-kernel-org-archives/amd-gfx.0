Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C1C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6E7206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsjGZgu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6E7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0468C89872;
	Fri, 13 Mar 2020 14:31:04 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDD26EBDD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:31:02 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g62so10541005wme.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UHw9fLnZFrAHp0i2Ib5zMg7cDFiCTNPTdvY9OEX2o9Y=;
 b=TsjGZgu1RRK7FS1wydj8r5Q1V1B7V0nj7bw4lBCF31VjsBvGSh5HQCZ0X9gBG91yUi
 8NL4CfdATA39nE1fC8j2F1lxNFRReKNlJ0AQzYmgDngud/+8zJ/NmKsGMKNt3LZRykCb
 Z//PJlT0lobSKhKlC/7FhOfCIGE7BYNdLeE9Flbl+uAOBp1BKn7+Ks/qWNoIR7DMJz1G
 cD7HawWJvt9eY9IdVDBnSv5dul+WkCaYj7IfA07OMeHe9AE9OdbsZKbfjzeLk3TH21zp
 kqZnJfooF5nQXX02gan704SaWXXkeLwfjZwv7qHsVL3XS7hLcAPZOQv6UrLQAbZ76aEe
 ZqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UHw9fLnZFrAHp0i2Ib5zMg7cDFiCTNPTdvY9OEX2o9Y=;
 b=kRwvJZmmSSBv51IEKFH/LOur6v8rOd8ZWPXNBAtI8r4hdJ5oH5yLZ8wrOwu4Ahput5
 sKEBVltQjjkPg33cUClF8elXdLLT07Zq3eOyNHv5uMPIanIuIfDZXmi/7aHN+gPXiZUd
 hleDsBseu/gu2dxISESdF/LcnP948vRjw9k/raxpgI5jF0U5m+ipYajsuf4ug+DkkFjt
 ZPrIxLtITGXf1raxFvwMAPAS80N/LH/W5V8uYfY0zVJf60oydPSNSwKBqaNxvuar/aFN
 fcSw+VZq4gQSlH+NfOoH3YtnnCvPycoOoDDNJcI/32PlWI85d7LFyTmTGt0uwBZgRPSv
 jAvA==
X-Gm-Message-State: ANhLgQ2EJtE6QYsDz8iG7cafRUjiyauP6SiyPQdyA1P17cf3frvy/fVr
 93yv9friQqQs/5YjJYw1CVx8iJ6+Hrhui4eh
X-Google-Smtp-Source: ADFU+vvhP7r8FvRJ8zSw2hTrnOZJx/fn3PSjqMAjHWaUOS/22lDF+cnQre6WGTCwCtxb13qIy9oNRA==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr11262555wme.49.1584109861106; 
 Fri, 13 Mar 2020 07:31:01 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F29A900DB158106D933A960.dip0.t-ipconnect.de.
 [2003:c5:8f29:a900:db15:8106:d933:a960])
 by smtp.gmail.com with ESMTPSA id x17sm41638298wrt.31.2020.03.13.07.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 07:31:00 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/sched: implement and export drm_sched_pick_best
Date: Fri, 13 Mar 2020 15:34:32 +0100
Message-Id: <20200313143433.114437-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313143433.114437-1-nirmoy.das@amd.com>
References: <20200313143433.114437-1-nirmoy.das@amd.com>
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove drm_sched_entity_get_free_sched() and use the logic of picking
the least loaded drm scheduler from a drm scheduler list to implement
drm_sched_pick_best(). This patch also exports drm_sched_pick_best() so
that it can be utilized by other drm drivers.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 36 ++----------------------
 drivers/gpu/drm/scheduler/sched_main.c   | 36 ++++++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  3 ++
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index d631521a9679..c803e14eed91 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -137,38 +137,6 @@ bool drm_sched_entity_is_ready(struct drm_sched_entity *entity)
 	return true;
 }

-/**
- * drm_sched_entity_get_free_sched - Get the rq from rq_list with least load
- *
- * @entity: scheduler entity
- *
- * Return the pointer to the rq with least load.
- */
-static struct drm_sched_rq *
-drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
-{
-	struct drm_sched_rq *rq = NULL;
-	unsigned int min_jobs = UINT_MAX, num_jobs;
-	int i;
-
-	for (i = 0; i < entity->num_sched_list; ++i) {
-		struct drm_gpu_scheduler *sched = entity->sched_list[i];
-
-		if (!entity->sched_list[i]->ready) {
-			DRM_WARN("sched%s is not ready, skipping", sched->name);
-			continue;
-		}
-
-		num_jobs = atomic_read(&sched->num_jobs);
-		if (num_jobs < min_jobs) {
-			min_jobs = num_jobs;
-			rq = &entity->sched_list[i]->sched_rq[entity->priority];
-		}
-	}
-
-	return rq;
-}
-
 /**
  * drm_sched_entity_flush - Flush a context entity
  *
@@ -479,6 +447,7 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 {
 	struct dma_fence *fence;
+	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;

 	if (spsc_queue_count(&entity->job_queue) || entity->num_sched_list <= 1)
@@ -489,7 +458,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;

 	spin_lock(&entity->rq_lock);
-	rq = drm_sched_entity_get_free_sched(entity);
+	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
+	rq = sched ? &sched->sched_rq[entity->priority] : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..1dcafc8d14fc 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -705,6 +705,42 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	return job;
 }

+/**
+ * drm_sched_pick_best - Get a drm sched from a sched_list with the least load
+ * @sched_list: list of drm_gpu_schedulers
+ * @num_sched_list: number of drm_gpu_schedulers in the sched_list
+ *
+ * Returns pointer of the sched with the least load or NULL if none of the
+ * drm_gpu_schedulers are ready
+ */
+struct drm_gpu_scheduler *
+drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
+		     unsigned int num_sched_list)
+{
+	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
+	int i;
+	unsigned int min_jobs = UINT_MAX, num_jobs;
+
+	for (i = 0; i < num_sched_list; ++i) {
+		sched = sched_list[i];
+
+		if (!sched->ready) {
+			DRM_WARN("scheduler %s is not ready, skipping",
+				 sched->name);
+			continue;
+		}
+
+		num_jobs = atomic_read(&sched->num_jobs);
+		if (num_jobs < min_jobs) {
+			min_jobs = num_jobs;
+			picked_sched = sched;
+		}
+	}
+
+	return picked_sched;
+}
+EXPORT_SYMBOL(drm_sched_pick_best);
+
 /**
  * drm_sched_blocked - check if the scheduler is blocked
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index ae39eacee250..26b04ff62676 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -341,5 +341,8 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence);
 unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
 void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
 		                unsigned long remaining);
+struct drm_gpu_scheduler *
+drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
+		     unsigned int num_sched_list);

 #endif
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
