Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEDCA5FAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7837010F3DD;
	Wed, 30 Sep 2026 13:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caHRJj9j";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8302310F3F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:22 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so50073675e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775201; x=1791380001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IG1nHIDMNXHhVtmqRQ1SBfwo8kCDgQLox4j+H3YFab4=;
 b=caHRJj9j7a9ittPmPJVAzuA3yQ9h+YfFeMXlWWy825xVBVljY4NnyHvnUwSieouRKM
 tQ5/RBF5CaWekgK6gZ0Hewvpd7jl40oz/yqc7c3xdH6uIS1sT84VKp4dnqqt3k/6RsMc
 vp2XNpee9u2fFeBFplaqALS1kLhVvW3PJ7ylqdAu4WuvjberGwbskaUbyqUsHxyEhPFq
 GwRR/G17dOCEe/EHQul6gWgEbpGqvd5DuRg2lWiwQoeStTUgYhdmSVNVTBaUUyMGjR8g
 WQ1u+EqyRCG++dbOSXqtAwSPkUfbv6Koi+e18X1DdsLBv8LYPAmY0hkSA7wXBN5lM11h
 FYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775201; x=1791380001;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IG1nHIDMNXHhVtmqRQ1SBfwo8kCDgQLox4j+H3YFab4=;
 b=ZvGvI4V86lCQ+hDQWRX5ZnxwQjZefEMWdMYlEO8MLy0WSz7OFssWs9YAuDe6TuydsR
 JV/hm6GJnymqZWhMglRkd4T4F74oB+pibpVMzJ/PmRkp0iWSYE7ZbH1GTMuo9DVI8EUL
 Y6//tfR4HauZ/mAAyoDsUk+MdI6Bt8Yfsv5AjmlEMAx/XXVkLg5GpwDaFmD66cdg+G4X
 Hz9kaj4ZeFdRLWMObaEIVW2ZFtnFSJf8zogax/8PKbZMwtcxd6LiK7HAfKgYbGSzI8KA
 DRybFMxHBDV4ysKw2qnApnspQk2I1knlbrQmOzI9uk56bx22gmwB+d1E6I4Ronz7CAY1
 oy/g==
X-Gm-Message-State: AFuF++n2ca1uTeUAYaJQK1DkC+fLAaFE+oiM1Rp+6rV3k5UHZHHfS0iP
 HHAQ8IdUY2hjljEtNQCixbkf70r/N4sCfVnbnKebkAr9J0DiOku5cvAA
X-Gm-Gg: AYBFou26BfrF62pkCaFwEQKi95svXums4TqXooSAMqWG5CtuYVzc1xut8pvPtxiR2tO
 rlp5j69fIUDfOs0Bkqn759hYEuxnrWz4fuysS2z4HQm8e+EB4iDPJURU2/JhuIkxdyNA8jJ82SM
 TeVeVFQDfDFpstXE62IqQ6wOk3/VpvBfqtBHMXXnCxaW3pFe6dhcWKNuM9A3aB4RejJ8dMcCVdY
 2Jqq7v7abp1O6DQooRLPBQCK31y9qGFqlaS5jvKkDE/sfzgjgXpNw25+fhWLvmhododG7KkwiKL
 63pZQCT/idwuIsMHzZ/EeTuFUWNtIRrh8oMi+gyvOhSCHxS5sJcVJf5AFD5KyY/8pqsMg34IUxq
 +w/s5SBQIhiw8RVkpWQKInRvQicWKYJLUyKMj/xaZpX9OtHrj7rmuRstooXvfn6qJ6qqfbJBhwW
 NVC+JNeWe0Np8daexLCNMeDAtNWkduDF94lL6QcT5ELE4QdJoVFvgJ3oIcNPG/ew1CNZ1o0CfyL
 ofnc8Nf0II=
X-Received: by 2002:a05:600c:4e42:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a01aff3a44mr26366485e9.10.1790775200771; 
 Wed, 30 Sep 2026 06:33:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_pdes
Date: Wed, 30 Sep 2026 15:33:11 +0200
Message-ID: <20260930133315.12270-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
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
index 76f11cff869c7..e52fc0273e49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -821,7 +821,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	/* Always update PDEs after we touched the mappings. */
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm);
 	if (r)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 7189ee0939ca2..708ca8d56e8c2 100644
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
@@ -4892,7 +4892,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto out_unreserve;
@@ -5035,7 +5035,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto error_npa_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 63875761dfaca..116ab0b967f8d 100644
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
index aaf702ec2acda..75a6f9c2a8be3 100644
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
index f6f14f1e96b39..d84e0a3ff88d4 100644
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

