Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EB3C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02EA10E059;
	Thu, 25 Aug 2022 13:32:06 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AD110E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:58 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id s11so26098474edd.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=frJ4SeJ4l59JkS+g0hpMlK855oKoc53D1L1AEHLbSwc=;
 b=AuHAzrsvVxDuY6BZFgE+3mmIfNxn9biQpnDbV+vBmqVCya3flPP9rlzcygbMkoVAkH
 0ZcGR34/I8ayYScS2y3JA5HWw0To9LUK2SACKcNVPu1JFuaU54PfuIRkUWKW7sB1RQ4Z
 gAtLzSqvbBw0sqeAa9sz8CDR91SYpFu9Eg1hb7yzhCEYYWNe86Qz4SwIOvdEWJwg7ZBX
 ix721m1us+TlA+LooKJj0XGQ5kcU7PrwDOOSgAot/obVV3XI3rUhYvtdrvCNSV/3zV1R
 fGeLUxowKNR2pi2j37R8a0WdkplcyUPl0ray6Dci8VSEYfICgNVIPhmcNzExTp3ExNZR
 GCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=frJ4SeJ4l59JkS+g0hpMlK855oKoc53D1L1AEHLbSwc=;
 b=yVjQ3XH1dDa7MFNrcuNWGqwHv40vhIh2HJRqVEW+ByTKc6x3QIxRJ2hqZpa/7HLtHW
 nGHs4jbyHHw2yNTlyX6na6r3KPTh0/vWSDEQ9UBu8fE5RcPyd4behGVjZd94HfzZdarQ
 JTpj2uDo81P/lelfmStIZUC7zaBZvdIs3hBLZYg94fdftU5OyEa3hIWMQCiZzlJYBJOv
 a9boujW73RoTiv3hJS43RzjzyyW41jxxZ5zw/nic6TiDNypcdFiY0XudyRwQs55MHnUc
 TGKb19FEv2d2SHezK3+54WbVbl362hU4j09JxNxKtCD+7v8G/zTwo+O3wJzgtvh3YoN5
 QedQ==
X-Gm-Message-State: ACgBeo0USA6NJkX4vQWUqhHvYFXblDGJ2+DFXrnmJ7mL8HhsXHTPoUhJ
 CxPNycWX8dI52cF1wKG8A3ob/JjXaslCEQ==
X-Google-Smtp-Source: AA6agR7n15c73Vv5mkJDd2/6YhsO1oR8a/h6H5xbZOO2ryrQIxnEMy7uTmW7EFXPSjSQ5Sy+KBYwIQ==
X-Received: by 2002:a05:6402:50cb:b0:440:8bac:1e02 with SMTP id
 h11-20020a05640250cb00b004408bac1e02mr3325613edb.336.1661434316857; 
 Thu, 25 Aug 2022 06:31:56 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amdgpu: add gang submit backend v2
Date: Thu, 25 Aug 2022 15:31:40 +0200
Message-Id: <20220825133142.8272-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
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
index d7eb23b8d692..172095122cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3501,6 +3501,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->gmc.gart_size = 512 * 1024 * 1024;
 	adev->accel_working = false;
 	adev->num_rings = 0;
+	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
 	adev->mman.buffer_funcs = NULL;
 	adev->mman.buffer_funcs_ring = NULL;
 	adev->vm_manager.vm_pte_funcs = NULL;
@@ -3983,6 +3984,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
+	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
 
 	amdgpu_reset_fini(adev);
 
@@ -5916,3 +5918,36 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
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
index 37dc5ee4153d..6f6708caf0e6 100644
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
 
 	dma_fence_put(&job->hw_fence);
 }
@@ -244,12 +262,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
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
@@ -261,8 +283,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
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
index 2a1961bf1194..4763081eb6bc 100644
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
@@ -79,6 +80,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
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

