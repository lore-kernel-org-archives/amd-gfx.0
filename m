Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E65C4BA21
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC04A2072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veqECf67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC04A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B60E6EBC8;
	Wed, 26 Feb 2020 20:34:40 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3166EBCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 20:34:37 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e8so424975wrm.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 12:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZV3WAKe4YHajnMCDc062xpD+FETNPDv8wBsLTg88GcA=;
 b=veqECf67mCxLJu4ed7KTfiDfrBdZXbU/Wq01F6U8hJ2LG2gVwuBf1+tk1g+bHsjEoG
 FZX873WtV+rwaciM7k8wcLZ3cZ2TbK+MqFOk5iSQoFR17WtSvNR6yUM4AnsElaSeQvhY
 laEskaJbQXhAnAq77w/AuFVlzii2r618fgZ4f/d+oNFqp8kRVJAWgrfjYUk4Cr8FFpQt
 PuJp2sHtHHaDE7MzQNlBWeg4fNOMoJ7e3VDD8VTf4cAgGdXplokaW+SUMlWlpl3/xxEc
 ZTkQsOiDSlpZFDVaZL8RQyy/e7Alhvo1AXjsd6DO1a044fOZViChqjQPX4yRNa0SxGOq
 HXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZV3WAKe4YHajnMCDc062xpD+FETNPDv8wBsLTg88GcA=;
 b=NtF7o8kGa2hQWjyENU2nIM7bX7vrzJz65BCK0gZDHebmLaOcyo5nfC/vlTFu2FUoYa
 SaBT/j/91qqm1o8aufBTqqx+pLtjOqJtyzL2hKbksijtV9QzdkGoQ/hD1OrEUQAKGElQ
 mMHbphjPRXyxj1V8WL6aij6KicoNCl5IoMaUdkEqcbIhE+zNbssfxmMhr2N+ygXDF7TX
 e1x1I3zakOTYtUuOYhb7QSjbRUHy8mo1x66J1V0zAYvM5l8+izZMpjXABm3Jgwk0jyGQ
 wH2V+Nl/W1QZaGxDvu7gdZ8SFZQ6aCGuo4g5jEJAIDH1mPWMtx3k60uTgGxsYmBW672F
 vtoQ==
X-Gm-Message-State: APjAAAVwpJJhdhTsFTmZ6gKPS1IbQZLPXlvIAoSRuMe8hLu+vqYUa9nL
 HGY95k7i4gSgYAE3o2Pi4DfIhh785MY=
X-Google-Smtp-Source: APXvYqx9N06tLmTUGwForCKfKjVixGG95wgw69BbDgtqz2Nmms8qkb7aVT13MjahzMLU+nxU6GIPsw==
X-Received: by 2002:a05:6000:114f:: with SMTP id
 d15mr448763wrx.130.1582749275734; 
 Wed, 26 Feb 2020 12:34:35 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F275300BB8A7FF1D96B1B54.dip0.t-ipconnect.de.
 [2003:c5:8f27:5300:bb8a:7ff1:d96b:1b54])
 by smtp.gmail.com with ESMTPSA id d76sm4406191wmd.39.2020.02.26.12.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 12:34:35 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Wed, 26 Feb 2020 21:37:29 +0100
Message-Id: <20200226203730.4621-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226203730.4621-1-nirmoy.das@amd.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were changing compute ring priority while rings were being used
before every job submission which is not recommended. This patch
recreates entity with higher/normal priority sched list when user
changes ctx's priority.

high/normal priority sched list are generated from set of high/normal
priority compute queues. When there are no high priority hw queues then
it fall backs to software priority.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 58 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  4 ++
 5 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f397ff97b4e4..8304d0c87899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct drm_sched_entity *entity = p->entity;
 	enum drm_sched_priority priority;
-	struct amdgpu_ring *ring;
 	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_job *job;
 	uint64_t seq;
@@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
 
-	ring = to_amdgpu_ring(entity->rq->sched);
-	amdgpu_ring_priority_get(ring, priority);
-
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 94a6c42f29ea..ea4dc57d2237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -85,8 +85,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_COMPUTE:
-			scheds = adev->gfx.compute_sched;
-			num_scheds = adev->gfx.num_compute_sched;
+			if (priority <= DRM_SCHED_PRIORITY_NORMAL) {
+				scheds = adev->gfx.compute_sched;
+				num_scheds = adev->gfx.num_compute_sched;
+			} else {
+				scheds = adev->gfx.compute_sched_high;
+				num_scheds = adev->gfx.num_compute_sched_high;
+			}
 			break;
 		case AMDGPU_HW_IP_DMA:
 			scheds = adev->sdma.sdma_sched;
@@ -502,6 +507,24 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }
 
+static void amdgpu_ctx_hw_priority_override(struct amdgpu_ctx *ctx,
+					    const u32 hw_ip,
+					    enum drm_sched_priority priority)
+{
+	int i;
+
+	for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
+		if (!ctx->entities[hw_ip][i])
+			continue;
+
+		/* TODO what happens with prev scheduled jobs */
+		drm_sched_entity_destroy(&ctx->entities[hw_ip][i]->entity);
+		amdgpu_ctx_fini_entity(ctx->entities[hw_ip][i]);
+
+		amdgpu_ctx_init_entity(ctx, AMDGPU_HW_IP_COMPUTE, i);
+
+	}
+}
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
@@ -515,12 +538,18 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 			struct drm_sched_entity *entity;
+			struct amdgpu_ring *ring;
 
 			if (!ctx->entities[i][j])
 				continue;
 
 			entity = &ctx->entities[i][j]->entity;
-			drm_sched_entity_set_priority(entity, ctx_prio);
+			ring = to_amdgpu_ring(entity->rq->sched);
+
+			if (ring->funcs->init_priority)
+				amdgpu_ctx_hw_priority_override(ctx, i, priority);
+			else
+				drm_sched_entity_set_priority(entity, ctx_prio);
 		}
 	}
 }
@@ -630,6 +659,7 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 
 void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
 {
+	enum drm_sched_priority priority;
 	int i, j;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
@@ -638,8 +668,26 @@ void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
-		adev->gfx.num_compute_sched++;
+		priority = adev->gfx.compute_ring[i].priority;
+		if (priority <= DRM_SCHED_PRIORITY_NORMAL) {
+			adev->gfx.compute_sched[i] =
+				&adev->gfx.compute_ring[i].sched;
+			adev->gfx.num_compute_sched++;
+		} else {
+			adev->gfx.compute_sched_high[i] =
+				&adev->gfx.compute_ring[i].sched;
+			adev->gfx.num_compute_sched_high++;
+		}
+	}
+
+	/* if there are no high prio compute queue then mirror with normal
+	 * priority so amdgpu_ctx_init_entity() works as expected */
+	if (!adev->gfx.num_compute_sched_high) {
+		for (i = 0; i < adev->gfx.num_compute_sched; i++) {
+			adev->gfx.compute_sched_high[i] =
+			       adev->gfx.compute_sched[i];
+		}
+		adev->gfx.num_compute_sched_high = adev->gfx.num_compute_sched;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ca17ffb01301..d58d748e3a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -279,7 +279,9 @@ struct amdgpu_gfx {
 	unsigned			num_gfx_rings;
 	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
 	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
+	struct drm_gpu_scheduler	*compute_sched_high[AMDGPU_MAX_COMPUTE_RINGS];
 	uint32_t			num_compute_sched;
+	uint32_t			num_compute_sched_high;
 	unsigned			num_compute_rings;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d42be880a236..4981e443a884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 
 	drm_sched_job_cleanup(s_job);
 
-	amdgpu_ring_priority_put(ring, s_job->s_priority);
 	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
@@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 		      void *owner, struct dma_fence **f)
 {
 	enum drm_sched_priority priority;
-	struct amdgpu_ring *ring;
 	int r;
 
 	if (!f)
@@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
 
-	ring = to_amdgpu_ring(entity->rq->sched);
-	amdgpu_ring_priority_get(ring, priority);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 18e11b0fdc3e..4501ae7afb2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -326,6 +326,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 	ring->max_dw = max_dw;
 	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
+	    ring->funcs->init_priority)
+		ring->funcs->init_priority(ring);
+
 	mutex_init(&ring->priority_mutex);
 
 	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
