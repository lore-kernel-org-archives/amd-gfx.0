Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A090C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 09:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B32410F297;
	Thu, 31 Mar 2022 09:47:38 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44E510F293
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:47:34 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id h1so27528509edj.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mx+QkgXD1WNckwfCmSuHCpngAV1Ktf9TX1oV/Vjtpi4=;
 b=cLn4IJ63f7SQXz1GqEC4DQYLxp4QaxR4tuAty7JZa67Ui60XSe0Jm47Ii2VIrXXzcl
 pQX/Hj3Eckpx1tLgMpwut5R+urxAw86A9ld3n0YtYGSIIjNjb78mq61tENYVI15YCWV8
 sWYTboQcdVtaIv/7q114+/szmvo/2E8KTv6dD/zy3FeTBzBzjlkyhbagEyOF2ZeR8X9x
 18yCq8M0e+vgiL/Mx7SKkn7Y0mxc+yW2G44VOgKFlg6tFiy4VnTMAmO9ZeuOFVS940ST
 9btuAgpP8D7yVx0CpwLphtjAMH0+AhoSuFdxdhMfrBgvQ857Y6Cw1mqvS1W5R5TNRCF7
 9ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mx+QkgXD1WNckwfCmSuHCpngAV1Ktf9TX1oV/Vjtpi4=;
 b=I8MQJxM0AnLQpkOUPhQwMZsxB8oe4BrOm4UwdbGDvxwz2Rp1t+TkvMM+wYEY12RGwY
 0jAPy2B/Cq/2u4LjirDHiG5f2Pib6OiHZDp61FGqTVnc8h6G1fuzbIE2x8gUdlmfed4I
 AJNxs7nQuqv71niv2CS5WrBKk+sGHrM25Yay8vjwNtLo/baRgTtCgGgZXPvAtzaDkPXb
 sW86ePlLP3O+kguwwwCNAsTfseQsNYVtl3GQrwjNDfdc+JSqGTrin9wXpSAf3PvNm88P
 yzyh+R9wXXXmnuuCB64HMT6s2yI9mFw8sEthgPmwQxmmDiyWKsFeSY2LTbLRFchqWhki
 c8Xw==
X-Gm-Message-State: AOAM531A+wyurC4GCbRDVhjFOh+hJHlcq83phPeNb22QuOImzDdZhmKM
 0yDsrcP6dh6pasPL1I9i28w=
X-Google-Smtp-Source: ABdhPJzazFd3r3kWIgN7gh9QpQ5jCVAAvhfAzhCuSrvKEoNLojSI/eH80R2dOd1n45QizyvyWsg+OA==
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id
 c16-20020a05640227d000b00419518458aemr15805914ede.314.1648720053310; 
 Thu, 31 Mar 2022 02:47:33 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 qk30-20020a1709077f9e00b006dfae33d969sm9249202ejc.216.2022.03.31.02.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 02:47:32 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: add last_update to amdgpu_vm_update_pdes
Date: Thu, 31 Mar 2022 11:47:26 +0200
Message-Id: <20220331094727.27153-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331094727.27153-1-christian.koenig@amd.com>
References: <20220331094727.27153-1-christian.koenig@amd.com>
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

Allows separate tracking of VM updates.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 57b521bb1eec..92a6ca415ab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -410,7 +410,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	ret = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 50fddd6715db..87daa75b57c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -849,7 +849,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3f84eedb4d96..9cdfee67efeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -623,7 +623,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			goto error;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 
 error:
 	if (r && r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 05024999556b..3391256e2448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -725,14 +725,15 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @immediate: submit immediately to the paging queue
+ * @last:update: optional returned last update
  *
  * Makes sure all directories are up to date.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate)
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  bool immediate, struct dma_fence **last_update)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry;
@@ -759,7 +760,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			goto error;
 	}
 
-	r = vm->update_funcs->commit(&params, &vm->last_update);
+	r = vm->update_funcs->commit(&params, last_update ? : &vm->last_update);
 	if (r)
 		goto error;
 
@@ -2529,7 +2530,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (r)
 		goto error_unlock;
 
-	r = amdgpu_vm_update_pdes(adev, vm, true);
+	r = amdgpu_vm_update_pdes(adev, vm, true, NULL);
 
 error_unlock:
 	amdgpu_bo_unreserve(root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3c7df1b8e3c9..692ec7b51ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -394,8 +394,8 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			      int (*callback)(void *p, struct amdgpu_bo *bo),
 			      void *param);
 int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate);
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  bool immediate, struct dma_fence **last_update);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 907b02045824..74824e3806d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1294,7 +1294,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		last_start = prange->start + i + 1;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (r) {
 		pr_debug("failed %d to update directories 0x%lx\n", r,
 			 prange->start);
-- 
2.25.1

