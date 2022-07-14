Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55361C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0449A45BF;
	Thu, 14 Jul 2022 10:39:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D806CA45B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:15 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id sz17so2627023ejc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jFE05OSofP5CnnpLbnrxhReYn8s8Zx57MvAbxTsu2LE=;
 b=WtQic0/xzLEf92B06v/oZWp52WL8DbObdmFVlTsHrH8mw3WDHvTogQETLEHrhIqR8S
 3mT43hPu+BohlRTNUTEsgcE4X3J3XPSiUbaeiaLUBA2JxBD+uw1v5SbmYjxB+GTzgXxi
 o2E3rR1aKEXLZWTQTPeJXPek2juzeeN8D3nwRdZJrt3EuCcb0LwDAWTt+QpeGni/tGvf
 CofoHg5U8xkuHUilqs/7NL2oU61cYzM+FdaxdPyH7hJOJ7+CJFgY1cPuf0tbtNdxCTY1
 fYkhXWfnXFERFPqLTaO2SwAhsy82aJkRNTjTm5zOS/HHySTsd1o4sj+eUYU/IIjDNRr3
 NVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFE05OSofP5CnnpLbnrxhReYn8s8Zx57MvAbxTsu2LE=;
 b=Vv640yOPG2psJmK7rPrPlAHfS7m0aCkhiqI+o52tQm2RIgYEX2+9nxktKa8Ax+wQow
 u82ojWza+hF5utAEHsWaAByL23lOt8xPZq8gDaa63dFyljgeSYwjN18V61i2UY6jMIcZ
 mjPY0E/NGGIHqSV0vbdL0oPse/1F9MXfIEouwF3NX8f/IefvAddL/4M0iJY5tAOKrFry
 LQPygevKje5nINmhyjviPpFjhKQSATFmg0h7D2D8aoDa9+cOYEzXsSjAWYj+7eqWJibB
 s/qBoxl9xr/xMaWQRcf8T/o30tb4eOD4wcekwuzQazyxL2E6sa10ofPfaSqsjoM7nF0U
 rQ2g==
X-Gm-Message-State: AJIora9HyxaFAbdysVW0cxdWwVxEjH2iFcby/shBxmmcmmYVaOG0IMR4
 XzDhFLYijW/glDq1fAkGN3eXsK460SY=
X-Google-Smtp-Source: AGRyM1v4+VTvn75DPUMqw3+DIoTG3xJaUt30yk2MbFqklNFTCkSLoFEGtL+yXstSsJ1yyyq//cnqNw==
X-Received: by 2002:a17:907:9613:b0:72b:68df:8ada with SMTP id
 gb19-20020a170907961300b0072b68df8adamr8383080ejc.31.1657795154398; 
 Thu, 14 Jul 2022 03:39:14 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 09/10] drm/amdgpu: add gang submit backend
Date: Thu, 14 Jul 2022 12:39:01 +0200
Message-Id: <20220714103902.7084-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows submitting jobs as gang which needs to run on multiple
engines at the same time.

Basic idea is that we have a global gang submit fence representing when the
gang leader is finally pushed to run on the hardware last.

Jobs submitted as gang are never re-submitted in case of a GPU reset since this
won't work and will just deadlock the hardware immediately again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2871a3e3801f..19308db52984 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -881,6 +881,7 @@ struct amdgpu_device {
 	u64				fence_context;
 	unsigned			num_rings;
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
+	struct dma_fence __rcu		*gang_submit;
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
 	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
@@ -1288,6 +1289,8 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 				u32 reg);
 void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
+struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
+					    struct dma_fence *gang);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e1c9587f659b..f80beb7208c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3499,6 +3499,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->gmc.gart_size = 512 * 1024 * 1024;
 	adev->accel_working = false;
 	adev->num_rings = 0;
+	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
 	adev->mman.buffer_funcs = NULL;
 	adev->mman.buffer_funcs_ring = NULL;
 	adev->vm_manager.vm_pte_funcs = NULL;
@@ -3979,6 +3980,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
+	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
 
 	amdgpu_reset_fini(adev);
 
@@ -5905,3 +5907,35 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 	(void)RREG32(data);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
+
+/**
+ * amdgpu_device_switch_gang - switch to a new gang
+ * @adev: amdgpu_device pointer
+ * @gang: the gang to switch to
+ *
+ * Try to switch to a new gang or return a reference to the current gang if that
+ * isn't possible.
+ * Returns: Either NULL if we switched correctly or a reference to the existing
+ * gang.
+ */
+struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
+					    struct dma_fence *gang)
+{
+	struct dma_fence *old = NULL;
+
+	do {
+		dma_fence_put(old);
+		old = dma_fence_get_rcu_safe(&adev->gang_submit);
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
index 3255b2fca611..f3a1fdbd41a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -180,11 +180,29 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 		kfree(job);
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
 
 	/* only put the hw fence if has embedded fence */
 	if (job->hw_fence.ops != NULL)
@@ -258,12 +276,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
 		fence = amdgpu_sync_get_fence(&job->sync);
 	}
 
+	if (!fence && !job->gang_submit)
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
@@ -275,8 +297,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
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
index 0bab8fe0d419..615328130615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -51,6 +51,7 @@ struct amdgpu_job {
 	struct amdgpu_sync	sched_sync;
 	struct dma_fence	hw_fence;
 	struct dma_fence	*external_hw_fence;
+	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
@@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
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

