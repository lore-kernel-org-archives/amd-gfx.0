Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F24C6FA8B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB12410ECFF;
	Fri, 16 Sep 2022 09:09:06 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5650210ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:58 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id l8so10294457wmi.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=VEvjdcYNNCNMxM/X25CQeHKL5GYQDxfkKbXJAhvO+fo=;
 b=bsaMeNIG19L3HFiM8OVYRZDXIMqzuUbShyLrM8r1gdM9lQCHAm8w4cSoV97ZFEPGMS
 v+MknRK1opKqoXZLwas8+qPg/xg5Bc+j7RhNLXfMKY2zy9aoYAz3Trka25VfYtrexx20
 V4zzhWvPtJqJzXC7BWVGjW3588DqbmqH6qZKJC+DenUPOTME6kJDqG2BRYoL8JAdbi7o
 7RrnUdlrEBnx4kW47q1jR9BOI0Qj61kiBq9mrL0UhghggO1/GgoO8amtoAbHQpaI1jI4
 bGI1o1HBszkbN8yIqI5ERNyPtNYNce65XWiMJ/9bTrEcpplfVm/xPR1qwHuk1/4otK5/
 PGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=VEvjdcYNNCNMxM/X25CQeHKL5GYQDxfkKbXJAhvO+fo=;
 b=Jc5IxsVcVzqEJ81jq2xVOWVsFHOxQjiSLQO3rZRQ5J1JJSuFRqnRFQnXbGztumbRId
 ToIDTxusFM1OiAp0EZgNc74TMn4TqRM1enTTO/dhUasi0MBs+bFoDV9nTlXFHtgGMG0n
 MYLu/J9q/PfZb6+wPc4EPQXmG1UbCy2bh6cE/eOCpnSdwyBZpIpQpe5vaHCTeD6MmNqH
 MdBQI++nK0bzLbla+oxwdYYG6xoDCJHT+3zyari48svAxlkIGxbuUB4Got5pO+r53I9A
 rvGI3H3LRmwrplf30rIrY+Cq/T8qVzEngkClx/hRORghAxbFTjmHS4Ey5wDJLXFftO9o
 cbbQ==
X-Gm-Message-State: ACgBeo2gust6aGrI3AGnAC6jAuRJAYxeLvsSHmNif8q2D4Gu/KnRBtzx
 85HVgOdD3PDOqdhDr441YMAJxEOU4Gt+eg==
X-Google-Smtp-Source: AA6agR6L0qpIQKnCxX3oynfHp2VYKajDGX4E2K0WPoIz/2Aaji6SxdmiMgg+yPC3j0X4TPa3qbS4aw==
X-Received: by 2002:a05:600c:2f9a:b0:3b4:9bd5:1472 with SMTP id
 t26-20020a05600c2f9a00b003b49bd51472mr9325107wmn.171.1663319336570; 
 Fri, 16 Sep 2022 02:08:56 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 7/8] drm/amdgpu: add gang submit backend v2
Date: Fri, 16 Sep 2022 11:08:44 +0200
Message-Id: <20220916090845.3336-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows submitting jobs as gang which needs to run on multiple
engines at the same time.

Basic idea is that we have a global gang submit fence representing when the
gang leader is finally pushed to run on the hardware last.

Jobs submitted as gang are never re-submitted in case of a GPU reset since this
won't work and will just deadlock the hardware immediately again.

v2: fix logic inversion, improve documentation, fix rcu

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79bb6fd83094..ae9371b172e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -885,6 +885,7 @@ struct amdgpu_device {
 	u64				fence_context;
 	unsigned			num_rings;
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
+	struct dma_fence __rcu		*gang_submit;
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
 	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
@@ -1294,6 +1295,8 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 				u32 reg);
 void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
+struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
+					    struct dma_fence *gang);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 943c9e750575..b6f6445e50d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3503,6 +3503,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->gmc.gart_size = 512 * 1024 * 1024;
 	adev->accel_working = false;
 	adev->num_rings = 0;
+	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
 	adev->mman.buffer_funcs = NULL;
 	adev->mman.buffer_funcs_ring = NULL;
 	adev->vm_manager.vm_pte_funcs = NULL;
@@ -3984,6 +3985,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
+	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
 
 	amdgpu_reset_fini(adev);
 
@@ -5919,3 +5921,36 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 	(void)RREG32(data);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
+
+/**
+ * amdgpu_device_switch_gang - switch to a new gang
+ * @adev: amdgpu_device pointer
+ * @gang: the gang to switch to
+ *
+ * Try to switch to a new gang.
+ * Returns: NULL if we switched to the new gang or a reference to the current
+ * gang leader.
+ */
+struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
+					    struct dma_fence *gang)
+{
+	struct dma_fence *old = NULL;
+
+	do {
+		dma_fence_put(old);
+		rcu_read_lock();
+		old = dma_fence_get_rcu_safe(&adev->gang_submit);
+		rcu_read_unlock();
+
+		if (old == gang)
+			break;
+
+		if (!dma_fence_is_signaled(old))
+			return old;
+
+	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
+			 old, gang) != old);
+
+	dma_fence_put(old);
+	return NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 877b3c22a8a8..cfbe19cfe9af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -173,11 +173,29 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 	dma_fence_put(&job->hw_fence);
 }
 
+void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
+				struct amdgpu_job *leader)
+{
+	struct dma_fence *fence = &leader->base.s_fence->scheduled;
+
+	WARN_ON(job->gang_submit);
+
+	/*
+	 * Don't add a reference when we are the gang leader to avoid circle
+	 * dependency.
+	 */
+	if (job != leader)
+		dma_fence_get(fence);
+	job->gang_submit = fence;
+}
+
 void amdgpu_job_free(struct amdgpu_job *job)
 {
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
+	if (job->gang_submit != &job->base.s_fence->scheduled)
+		dma_fence_put(job->gang_submit);
 
 	if (!job->hw_fence.ops)
 		kfree(job);
@@ -247,12 +265,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
 		fence = amdgpu_sync_get_fence(&job->sync);
 	}
 
+	if (!fence && job->gang_submit)
+		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
+
 	return fence;
 }
 
 static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
+	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence = NULL, *finished;
 	struct amdgpu_job *job;
 	int r = 0;
@@ -264,8 +286,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
 	trace_amdgpu_sched_run_job(job);
 
-	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
-		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
+	/* Skip job if VRAM is lost and never resubmit gangs */
+	if (job->vram_lost_counter != atomic_read(&adev->vram_lost_counter) ||
+	    (job->job_run_counter && job->gang_submit))
+		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
 		DRM_INFO("Skip scheduling IBs!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 866d35bbe073..ab7b150e5d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -50,6 +50,7 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct dma_fence	hw_fence;
+	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
@@ -84,6 +85,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
+void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
+				struct amdgpu_job *leader);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 		      void *owner, struct dma_fence **f);
-- 
2.25.1

