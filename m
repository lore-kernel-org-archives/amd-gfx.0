Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B74C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E7C217F4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Jk9QfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E7C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F166E271;
	Mon,  2 Mar 2020 12:55:25 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21466E270
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:55:23 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 6so2588789wmi.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7As5PX5keb+0gR4w8duNUL4HgFo1gq/K4Sv6OZMalLw=;
 b=R2Jk9QfBs1WmT7lxLMnAvhRhjuoDz9mSGwEsKKGHrjNUlhTx2TFdouNTlW29Ccor8R
 Kq5eOwp7jQdyX4o+goWeXhmdvsm6o5k0jFKgTiMnw/6J9lrWs4gkC0emxW8RyJ+MOCCo
 xo/0KauD9lP+dky+OOg0/ru2ThYoc78Od6ncDoD70CjywQSe5nxZIzo78QvojJ3bhw/6
 IRUKHtwIcFVC3xPlQtnMGX1uDjdh9U1N3o52ExCPyP2GRQDRwirgi8ou4QPw9kh0vCiT
 swpbnsfjY60xUABKRVTmJbU5I3ydQvJyncC9vmBzM1t4KsYsDcYv2ZhB9LTFez+NOm0g
 Umeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7As5PX5keb+0gR4w8duNUL4HgFo1gq/K4Sv6OZMalLw=;
 b=RArIdXCLFg+aeW0K6v78Wc7YAwCd1X+xzfb7yshJmxhiLBt7j3XsTWMp0n9hBY1z8j
 CFBYkPCGVsX7wR1q/L8No/LSty5OExpbdldkiQOhPMZ40KuwtoYVoc/oQzXgPaG790Af
 eFbgtQzI/x9sepFQoQIPGH+Xqunc42J2Nv6egJUfRSAC/NK1ONzfup0WK2S/0bVBeVSr
 ZiZDPIFUn096nYDiAuV8qhBANvBCRyJCEdS6py+w91nn2/36DMDouJWvV5dJnE0CpNPR
 NWsUXW971HMNeEapybdf2i7JfLjZ/1NiRBdu5wgyl0OfsxoUMldJgcrldS7a3lR0VGNW
 WrUg==
X-Gm-Message-State: APjAAAXlvdyOX/TwiH59YyOeYDnllsOedZ6tBcaQdC4O6N8rXlhaOcen
 S2KUkhv7mi63FL/JlnmOTxnSZxCiJv0=
X-Google-Smtp-Source: APXvYqzmDT+oi/gsu6+jpkMYfmJacpul43ATc5q57ar1YBCC4PpN+759ANYD+J3ORS2zbGq1lcao2A==
X-Received: by 2002:a1c:a789:: with SMTP id
 q131mr20184503wme.127.1583153721379; 
 Mon, 02 Mar 2020 04:55:21 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F21FC009E54A4A7C1B66128.dip0.t-ipconnect.de.
 [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128])
 by smtp.gmail.com with ESMTPSA id f17sm7492733wrm.3.2020.03.02.04.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:55:20 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 1/4] drm/amdgpu: set compute queue priority at mqd_init
Date: Mon,  2 Mar 2020 13:58:33 +0100
Message-Id: <20200302125836.56915-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were changing compute ring priority while rings were being used
before every job submission which is not recommended. This patch
sets compute queue priority at mqd initialization for gfx8, gfx9 and
gfx10.

Policy: make queue 0 of each pipe as high priority compute queue

High/normal priority compute sched lists are generated from set of high/normal
priority compute queues. At context creation, entity of compute queue
get a sched list from high or normal priority depending on ctx->priority

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 61 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  8 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 15 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 19 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 23 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++++
 9 files changed, 136 insertions(+), 21 deletions(-)

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
index 94a6c42f29ea..8c52152e3a6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -61,12 +61,30 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }

+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
+{
+	switch(prio) {
+	case DRM_SCHED_PRIORITY_MIN:
+	case DRM_SCHED_PRIORITY_NORMAL:
+		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	case DRM_SCHED_PRIORITY_HIGH_SW:
+	case DRM_SCHED_PRIORITY_HIGH_HW:
+	case DRM_SCHED_PRIORITY_KERNEL:
+		return AMDGPU_GFX_PIPE_PRIO_HIGH;
+	default:
+		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	}
+
+	return AMDGPU_GFX_PIPE_PRIO_NORMAL;
+}
+
 static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	struct amdgpu_ctx_entity *entity;
 	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
 	unsigned num_scheds = 0;
+	enum gfx_pipe_priority compute_priority;
 	enum drm_sched_priority priority;
 	int r;

@@ -85,8 +103,10 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_COMPUTE:
-			scheds = adev->gfx.compute_sched;
-			num_scheds = adev->gfx.num_compute_sched;
+			compute_priority =
+				amdgpu_ctx_sched_prio_to_compute_prio(priority);
+			scheds = adev->gfx.compute_prio_sched[compute_priority];
+			num_scheds = adev->gfx.num_compute_sched[compute_priority];
 			break;
 		case AMDGPU_HW_IP_DMA:
 			scheds = adev->sdma.sdma_sched;
@@ -628,20 +648,47 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	mutex_destroy(&mgr->lock);
 }

+
+static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
+{
+	int num_compute_sched_normal = 0;
+	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
+	int i;
+
+	/* fill compute_sched array as: start from 0th index for normal priority scheds and
+	 * start from (last_index - num_compute_sched_normal) for high priority
+	 * scheds */
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		if (!adev->gfx.compute_ring[i].gfx_pipe_priority)
+			adev->gfx.compute_sched[num_compute_sched_normal++] =
+				&adev->gfx.compute_ring[i].sched;
+		else
+			adev->gfx.compute_sched[num_compute_sched_high--] =
+				&adev->gfx.compute_ring[i].sched;
+	}
+
+	/* compute ring only has two priority for now */
+	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
+	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
+
+	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
+	adev->gfx.compute_prio_sched[i] =
+		&adev->gfx.compute_sched[num_compute_sched_high - 1];
+	adev->gfx.num_compute_sched[i] =
+		adev->gfx.num_compute_rings - num_compute_sched_normal;
+}
+
 void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
 {
 	int i, j;

+	amdgpu_ctx_init_compute_sched(adev);
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
 		adev->gfx.num_gfx_sched++;
 	}

-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
-		adev->gfx.num_compute_sched++;
-	}
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
 		adev->sdma.num_sdma_sched++;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7403588684b3..952725e7243c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -192,6 +192,14 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
 	return adev->gfx.mec.num_mec > 1;
 }

+bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
+					       int queue)
+{
+	/* Policy: make queue 0 of each pipe as high priority compute queue */
+	return (queue == 0);
+
+}
+
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 {
 	int i, queue, pipe, mec;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 37ba05b63b2a..47a5cdae28c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -41,6 +41,16 @@
 #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES

+enum gfx_pipe_priority {
+	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
+	AMDGPU_GFX_PIPE_PRIO_HIGH,
+	AMDGPU_GFX_PIPE_PRIO_MAX
+
+};
+
+#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
+#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -280,8 +290,9 @@ struct amdgpu_gfx {
 	uint32_t			num_gfx_sched;
 	unsigned			num_gfx_rings;
 	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
+	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
 	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
-	uint32_t			num_compute_sched;
+	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
 	unsigned			num_compute_rings;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
@@ -363,6 +374,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
 				     int pipe, int queue);
+bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
+					       int queue);
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 			       int pipe, int queue);
 void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 24caff085d00..201c6ac7bf9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -222,6 +222,7 @@ struct amdgpu_ring {
 	struct mutex		priority_mutex;
 	/* protected by priority_mutex */
 	int			priority;
+	bool			gfx_pipe_priority;

 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *ent;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 96cf617e41d1..e3b45acb1a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3211,6 +3211,22 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return r;
 }

+static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct v10_compute_mqd *mqd)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
+			ring->gfx_pipe_priority = true;
+			mqd->cp_hqd_queue_priority =
+				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
+		} else {
+			ring->gfx_pipe_priority = false;
+		}
+	}
+}
+
 static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3336,6 +3352,9 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;

+	/* set static priority for a compute queue/ring */
+	gfx_v10_0_compute_mqd_set_priority(ring, mqd);
+
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 393a1324daa9..05b6f01e1228 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4430,6 +4430,22 @@ static int gfx_v8_0_deactivate_hqd(struct amdgpu_device *adev, u32 req)
 	return r;
 }

+static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *mqd)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
+			ring->gfx_pipe_priority = true;
+			mqd->cp_hqd_queue_priority =
+				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
+		} else {
+			ring->gfx_pipe_priority = false;
+		}
+	}
+}
+
 static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -4553,9 +4569,6 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	/* defaults */
 	mqd->cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
 	mqd->cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
-	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
-	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
 	mqd->cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
 	mqd->cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
 	mqd->cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
@@ -4567,6 +4580,10 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
 	mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);

+	/* set static priority for a queue/ring */
+	gfx_v8_0_mqd_set_priority(ring, mqd);
+	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 015647959d69..ef263d075e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3314,6 +3314,22 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 }

+static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
+			ring->gfx_pipe_priority = true;
+			mqd->cp_hqd_queue_priority =
+				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
+		} else {
+			ring->gfx_pipe_priority = false;
+		}
+	}
+}
+
 static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3450,6 +3466,10 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;

+	/* set static priority for a queue/ring */
+	gfx_v9_0_mqd_set_priority(ring, mqd);
+	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
 	 */
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
