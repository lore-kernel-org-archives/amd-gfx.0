Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F5BCA5FA7
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7414710EACB;
	Mon, 28 Sep 2026 15:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZC34mFnM";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5557210EAC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:50 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso34107175e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608249; x=1791213049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZhJmUV0i/46PbXY+7D6q9Kjq8y0ifHLgSL2N7tORVgs=;
 b=ZC34mFnME2aGw1QSYG6Bqlm9T+ZzILXOVxMEWdEcPhnPShe7umPAwqSM4/pKwR0ZES
 sWefo+HE6ni8pU1McG4o8rukRCEjhsD7ZKknKCqU+s2thpPZh9BbW5SVUdtHPz19q2Nt
 b4HWlI1e4u92Galer49GH3fYHTaTh7SOb2GVgFOlRah7rzP1fD2O0V/+nMAkL4TaARKF
 4/rU3uVdB4/GV4TEaCEEBv/hYAQAfLeggKtnkkCKh+BUAynFNlWtnoKRuu1azr6UPTYO
 vVoPR+7ooNT+dI6od6suObce0StGKYlBoxGa+2wR51U9fJ8Q7v2SLb5wkD8obhAdSXxd
 ttVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608249; x=1791213049;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZhJmUV0i/46PbXY+7D6q9Kjq8y0ifHLgSL2N7tORVgs=;
 b=C3DZsSJzu8RCrq6YLNzcnN9AislFWIZIMoEaDlN4ZYTImkaYWI1U0H+yu8dH6bLsH4
 5ezjjWAvPTzxjb9KXTRq06Jg0xXgbJe2+RdOyuDt7RJklkrBG3tM5hSArBN/5+N8w7hp
 y2PpooEa4rXey671IcAjERILIzRJPFtOv6hEii9WhvDehdxWpo2OBNmkc+pFn6mOZ1e8
 bg2Q1zy+AbKu0tuRdnPLR44ina2eLRyaMNPGZypPpFN+TBOj6ZL2kI8QAp1GpA1RHpfC
 L9ib43omLIS/u0HT4rPTUCSO8SHnjb8JxOThd3H0ucPXBV9Ao5AYV7JqoNVrniFql4tz
 Wh1w==
X-Gm-Message-State: AFuF++ngzQ5/55/6esmM0fXzNFtsXRHFNWAgD8wLrH/qYNlP8d52hxx+
 wbtaB5/Va1f+oVxh5cuNkMGF7fpKvVgnEqZ5gWuABiV+yRa4NiprBcYk
X-Gm-Gg: AYBFou3BiYlg7UL8Vf5kwohCJQ+un21/e1dVMDB6WPRMaRL0q2sN0xyq7v8r4A045Tt
 1d1RiPUMwj6OnMHkoCq9TNC8S47O6JsC1UnaAOcQOH9z6nYSOcOT8Bsr2I8h2hKmbSZGqe4EKka
 WYJEI6R9nEsLNN89+amqAzz55R8nYQZOuNOQPfdZkdqAZH8tZW5fa8k+AMg2moDA0o8YURY/xVM
 ZkcM0dZP34ZcmWcZPrJ/FMjWYjWc/Hjc20AsQAsTIDEIPf4bQFMHcIoBOHQ/UFi17GSTocVFUOq
 trdio7ulZbUrqzeiKvWl9K7d+3gotCYHxK4rPpCLC3BImSja2tvnzDTGw9fKYkw01S88vSGEJ8c
 XaI0EhdyTrz60iCnW7bS75w6sNDwPNgDJw7Vb2VmwmMPtTAe25L+t/gponqXyv2FyjBXnf68/pw
 BotKyHt6QJI4FGO+tgl2kS0+md0AmZUUK4Ms81BQ8+nnkraGjOflkcvU0jS27YucR6pF7vi4WZi
 pO7fXDWy3M=
X-Received: by 2002:a05:600c:4e4b:b0:4a0:1fb:9a88 with SMTP id
 5b1f17b1804b1-4a001fb9be3mr75789525e9.13.1790608248262; 
 Mon, 28 Sep 2026 08:10:48 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_pdes
Date: Mon, 28 Sep 2026 17:10:38 +0200
Message-ID: <20260928151041.1857-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That case is handled by amdgpu_vm_update_leaves now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c       | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  2 +-
 8 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d32..cb46111b2dc8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -503,7 +503,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	ret = amdgpu_vm_update_pdes(adev, vm);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e7a9c2de46131..eef3acfdb7c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1182,7 +1182,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4e4814caf61a9..86a1239e49149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -811,7 +811,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	/* Always update PDEs after we touched the mappings. */
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index aac97dca36e33..899153716b7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2065,7 +2065,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
@@ -2119,7 +2119,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r) {
 		dev_err(adev->dev,
 			"failed %d to update page directories for NPA: 0x%llx\n",
@@ -2661,7 +2661,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during force retry rpcs\n",
@@ -2798,7 +2798,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during all NPA addresses unmapping\n",
@@ -4873,7 +4873,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto out_unreserve;
@@ -5016,7 +5016,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto error_npa_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c65..cf427037a8303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1173,7 +1173,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		goto retry_lock;
 	}
 
-	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	ret = amdgpu_vm_update_pdes(adev, vm);
 	if (ret)
 		goto unlock_all;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 017ec0ac0870d..cc6c419ff6fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -985,15 +985,13 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @immediate: submit immediately to the paging queue
  *
  * Makes sure all directories are up to date.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate)
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry, *tmp;
@@ -1011,7 +1009,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3ff17625a8c0c..a3556cf6dd525 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -451,8 +451,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed);
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate);
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 411bd3394442a..af8d2ede183a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1540,7 +1540,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		last_start = prange->start + i + 1;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r) {
 		pr_debug("failed %d to update directories 0x%lx\n", r,
 			 prange->start);
-- 
2.43.0

