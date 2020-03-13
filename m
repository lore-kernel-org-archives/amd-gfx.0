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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A7C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC44206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRRZo93z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC44206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E056EBCD;
	Fri, 13 Mar 2020 12:01:31 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48256EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 12:01:30 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f3so4757635wrw.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2dG+pkgPcHIx6R4HCGHnOqQbvR1TiodmcWY5PZw5u34=;
 b=JRRZo93zxSX2+pEgqq4ntCKWXBWD40DldKa/YJ/AYoJvmIpoWV5kNIjq6EUjJvR87T
 iN0o11L3rTrYwJjCvOyAom/Z3I8h3824VQ/R3PGOW8OH/ZNOho5s07qlQV5MqQdIObk4
 FXixlSjGnSvS0b3HzqgWaU97jaT2evTS4kWbS3NWoWSNOjgcOj3mFXT9pjEb4DNrgiqk
 juG+dclnuN+/Vu0xQGTtMes1SGLAyqhsQMeW+z4U8Wnr1VoWPt0Ruhzjzfap24pcjT6r
 l1mZzxJFEFaE9CxgTYaDpOTW7R9N2bFulltzucV7s9TymzgvaOoiCxRcN/XWL16kNfKV
 ho9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2dG+pkgPcHIx6R4HCGHnOqQbvR1TiodmcWY5PZw5u34=;
 b=Eo2bVoiK4HzpoZj4hVo7+0wnnUCm0JvT+9z+9YXVIzY6jm0dKBXT61MCTC132SlPoi
 tp0oYhI+eaLSC5Vp9RcDnq+tNNhtYvu5Psidm3J6pXJai/6S7ao0yXQIa3Ru7/6cG9C3
 op2ROotK+sefCnD6NnQgR0LWxIkQFx/70HRoER3MGksMNfgNnYlBpgJwKS27t1ApA6Dj
 xHVXUhjOSq2cbaOOs5FDg8WRsfggHWPfAftvAxoPTOa5mSJkIfELFFAv0JGG91ce5PX5
 csgHWoo5L2VA6APshP7F40fj9q/f/inp6eL5jqngQnOu6Ad4/zJ46AkuQr4Mns3WkErV
 UIHg==
X-Gm-Message-State: ANhLgQ1bg482XvR5LvZqwHAJUjaba33gxNRShsAN29ENjpM1gCgUA5jU
 6lh73PABZfIas65JXHCUhpdRrSSSjp/dzU4g
X-Google-Smtp-Source: ADFU+vvCB6IpnASCdJXl3mZw3QE2EXYWGf0vnOrY4TPtwrbNr0ICZ/uY87+ydxGT8Ypom1ibElBbXg==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr16671355wru.22.1584100887279; 
 Fri, 13 Mar 2020 05:01:27 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F29A900DB158106D933A960.dip0.t-ipconnect.de.
 [2003:c5:8f29:a900:db15:8106:d933:a960])
 by smtp.gmail.com with ESMTPSA id c23sm17058428wme.39.2020.03.13.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 05:01:26 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/sched: implement and export drm_sched_pick_best
Date: Fri, 13 Mar 2020 13:05:07 +0100
Message-Id: <20200313120508.36004-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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

Refactor drm_sched_entity_get_free_sched() to move the logic of picking
the least loaded drm scheduler from a drm scheduler list to implement
drm_sched_pick_best(). This patch also exports drm_sched_pick_best() so
that it can be utilized by other drm drivers.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 20 +++-----------
 drivers/gpu/drm/scheduler/sched_main.c   | 35 ++++++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  3 ++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index d631521a9679..3f6397d60bff 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -147,24 +147,12 @@ bool drm_sched_entity_is_ready(struct drm_sched_entity *entity)
 static struct drm_sched_rq *
 drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
 {
+	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq = NULL;
-	unsigned int min_jobs = UINT_MAX, num_jobs;
-	int i;
-
-	for (i = 0; i < entity->num_sched_list; ++i) {
-		struct drm_gpu_scheduler *sched = entity->sched_list[i];

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
+	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
+	if (sched)
+		rq = &sched->sched_rq[entity->priority];

 	return rq;
 }
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3fad5876a13f..d640f4087795 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -705,6 +705,41 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
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
+	 	     unsigned int num_sched_list)
+{
+	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
+	unsigned int min_jobs = UINT_MAX, num_jobs;
+	int i;
+
+	for (i = 0; i < num_sched_list; ++i) {
+		sched = sched_list[i];
+
+		if (!sched->ready) {
+			DRM_WARN("sched%s is not ready, skipping", sched->name);
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
index ae39eacee250..ca6b8b01fac9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -341,5 +341,8 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence);
 unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
 void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
 		                unsigned long remaining);
+struct drm_gpu_scheduler *
+drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
+		    unsigned int num_sched_list);

 #endif
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
