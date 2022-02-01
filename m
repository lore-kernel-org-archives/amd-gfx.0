Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7BCC4321E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 15:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B8010E693;
	Tue,  1 Feb 2022 15:28:07 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B1A10E66B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 15:28:07 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id l25so32648942wrb.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Feb 2022 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PC0y94VooHiF4sB8gE75zY+F1IilcN4W3gTW/uwKvx8=;
 b=PP0iq0TTbYLF7Feiz99PuiaJw1mm86YDGPH3OMYiQP9vmmVnBJpP0xxFXfzQsq59Vf
 wJbO6Rx8lC2iZEsRGbOCLiIvCoQw5YoFKyHejTnqmWMK7rPcJ4zE+4ARa3g4cBtxHU4z
 mk25Or+9Q/CfYTE6lL57ValpvHyvdWMnv6qGj3m8lknUerJleRneUc/ZN8Tdj93Na/RI
 ub+dC47ZDApMKC1s4GY+vG/5EUeJqiAD/TG81Sq2rdrc2boCJBL6mxtrjKNmpxX6XRDb
 2f0mDh+D465IttDOla8sYlt3SfNQ4XL6iXYndcohE5sbgSFqKeXZ+weG2mExR9JXWuj4
 u8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PC0y94VooHiF4sB8gE75zY+F1IilcN4W3gTW/uwKvx8=;
 b=qPHL3AngXgJ46iWJqSQp3Obuh37mZzCryvX26LxLJ2d1Wqz7XMtknkkLbk+XoCMDRH
 NXSWjKO9ltTGBHXaXeMflAONdCCu2S6ypCZBrx83Yed/d+7bxnpox3wj8oAZxlbrtS95
 nXmdQF2ebnLghs+lQUuXvmH990k55RtMWHSgWS2heA9y9c9L4uXuEJvc+qFZwFu3RKtP
 RZ06820vGOLvN52tSFlv7f64mn5Mmx9cOU3yj3P5IRGk1Y6SvW0YspBREpz2Dnr8lqK3
 7l3zOlnOInq7BSpvD7BeuL79hZFIRdxp270AyaGRkJBOdOwwV6eUwdJ9Rq7scxcAUkp0
 GqFQ==
X-Gm-Message-State: AOAM532mYvjsFGbPm8eLsh1mP0ZiRWnILdabuDwT/iGND4UIY6gm5HXZ
 6RaDBeqtY++Xh6IgbLmBF/g=
X-Google-Smtp-Source: ABdhPJx9nQv++CrNosby9SIYI4Iqv/ZdLgzKabiDLhbuJxxYn/lMUjeUdq3YaAQX6xAPkcWb8u8xSQ==
X-Received: by 2002:adf:da46:: with SMTP id r6mr21971337wrl.71.1643729285830; 
 Tue, 01 Feb 2022 07:28:05 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id t4sm2303482wmj.10.2022.02.01.07.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 07:28:05 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch,
	felix.kuehling@amd.com
Subject: [PATCH 2/2] drm/amdgpu: rename amdgpu_vm_bo_rmv to _del
Date: Tue,  1 Feb 2022 16:28:02 +0100
Message-Id: <20220201152802.12159-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201152802.12159-1-christian.koenig@amd.com>
References: <20220201152802.12159-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some people complained about the name and this matches much
more Linux naming conventions for object functions.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5df387c4d7fb..5d00a6878ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -778,7 +778,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			continue;
 		if (attachment[i]->bo_va) {
 			amdgpu_bo_reserve(bo[i], true);
-			amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
+			amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
 			amdgpu_bo_unreserve(bo[i]);
 			list_del(&attachment[i]->list);
 		}
@@ -795,7 +795,7 @@ static void kfd_mem_detach(struct kfd_mem_attachment *attachment)
 
 	pr_debug("\t remove VA 0x%llx in entry %p\n",
 			attachment->va, attachment);
-	amdgpu_vm_bo_rmv(attachment->adev, attachment->bo_va);
+	amdgpu_vm_bo_del(attachment->adev, attachment->bo_va);
 	drm_gem_object_put(&bo->tbo.base);
 	list_del(&attachment->list);
 	kfree(attachment);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index da21e60bb827..c6d4d41c4393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -98,7 +98,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
-		amdgpu_vm_bo_rmv(adev, *bo_va);
+		amdgpu_vm_bo_del(adev, *bo_va);
 		ttm_eu_backoff_reservation(&ticket, &list);
 		return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7c1f1b8ca77d..b4c0a4e77525 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -221,7 +221,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	if (!bo_va || --bo_va->ref_count)
 		goto out_unlock;
 
-	amdgpu_vm_bo_rmv(adev, bo_va);
+	amdgpu_vm_bo_del(adev, bo_va);
 	if (!amdgpu_vm_ready(vm))
 		goto out_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ee3c17bd02fc..efd13898c83e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1194,12 +1194,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
 		amdgpu_vce_free_handles(adev, file_priv);
 
-	amdgpu_vm_bo_rmv(adev, fpriv->prt_va);
+	amdgpu_vm_bo_del(adev, fpriv->prt_va);
 
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		/* TODO: how to handle reserve failure */
 		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
-		amdgpu_vm_bo_rmv(adev, fpriv->csa_va);
+		amdgpu_vm_bo_del(adev, fpriv->csa_va);
 		fpriv->csa_va = NULL;
 		amdgpu_bo_unreserve(adev->virt.csa_obj);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7910046fe11a..8174d71764d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2653,7 +2653,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 }
 
 /**
- * amdgpu_vm_bo_rmv - remove a bo to a specific vm
+ * amdgpu_vm_bo_del - remove a bo to a specific vm
  *
  * @adev: amdgpu_device pointer
  * @bo_va: requested bo_va
@@ -2662,7 +2662,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
  *
  * Object have to be reserved!
  */
-void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
+void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		      struct amdgpu_bo_va *bo_va)
 {
 	struct amdgpu_bo_va_mapping *mapping, *next;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 85fcfb8c5efd..a40a6a993bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -435,7 +435,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm *vm,
 							 uint64_t addr);
 void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket);
-void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
+void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		      struct amdgpu_bo_va *bo_va);
 void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   uint32_t fragment_size_default, unsigned max_level,
-- 
2.25.1

