Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D392C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 13:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3217D10E78B;
	Thu, 10 Nov 2022 13:00:22 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E0710E78B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 13:00:16 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id h9so2202635wrt.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekUWKjawwsGOP6J+e64C1gu2Y1hbNcSfzVVgXsAxLCM=;
 b=dyvuzp93ydDX+c0TodPG1k6axQC8N1PXt5G5BCs4NQwtSHhI4flrB9XTKQeJB+ZrdT
 wRErGZWUIPQ44aS2hYmqJfyLzNcbIVyk+rvJZINizonIdQ58nhmP1GbvypqZrxBTPZ3d
 rZPp+63tf7RMe+BXq5+AH9jqWsCmqgW8jk/7NPrOlkcF5Xw2qEMsm9wgMF/dldY2iESZ
 FmpYpNMbJs7Sh6sx4LxQQEiKJLOydcznJB30EWVEsAOpXsZlv3izIYDWrol6eWNwqyqF
 MYJvEy/yAgNksAbcj4OWXXsx/goAXWRtjQvtSyt6UF+nvKbmzQ1PXT3On1mXkMpTsuak
 wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekUWKjawwsGOP6J+e64C1gu2Y1hbNcSfzVVgXsAxLCM=;
 b=Uc6CMMOIUZKi4Y8otM43cdaj/mGn0Xxd9peKMGqTSWyaHhfVv6dxTliHiM8+ugQ831
 j37bTYQkGVXuCWTjUBshE3V/+TnsRW5VUIeogv0aISCL1hR2i+q/EunmHVfqL5ZnENHY
 9ZBF9QIFNtM3D3QLzyt/RPnAS377oE2fP9ieiYE7m2iCH+rYbkKYxvlPygz1ZDvNNvin
 LB4zrCbWUQ/ws6aCIO9ciCnvPleUu0Cvja+e4B5vAXvSziBXH/3+wEXUhQFXkEPrKsBw
 VPGC9t8UpX6HVk+T1tsKt0KbJKbRgdM+1zzsQFYKlN2yqn4lpu59fw+7EduQeAfkvBX9
 t8Pw==
X-Gm-Message-State: ANoB5pkQPtBO1EXdzIwRHrbXJBQAIdZ9++G/Mj7u+sYMeaAlma93Vxf1
 fGZmTtg03GLuFT6xrTjsK0w=
X-Google-Smtp-Source: AA0mqf6051IDHctncY7HJutnZGcCU+A8uBzMntylg+Y88NpkolLmrwpAp+HGLJZ3fcYnXG0UWLHaKQ==
X-Received: by 2002:a5d:640e:0:b0:23b:14c6:33be with SMTP id
 z14-20020a5d640e000000b0023b14c633bemr20227459wru.418.1668085215044; 
 Thu, 10 Nov 2022 05:00:15 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 az11-20020a05600c600b00b003b4cba4ef71sm5318965wmb.41.2022.11.10.05.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 05:00:14 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: rename the files for HMM handling
Date: Thu, 10 Nov 2022 14:00:08 +0100
Message-Id: <20221110130009.1835-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110130009.1835-1-christian.koenig@amd.com>
References: <20221110130009.1835-1-christian.koenig@amd.com>
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

Clean that up a bit, no functional change.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++-
 .../amd/amdgpu/{amdgpu_mn.c => amdgpu_hmm.c}  | 37 ++++++++++---------
 .../amd/amdgpu/{amdgpu_mn.h => amdgpu_hmm.h}  |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
 9 files changed, 33 insertions(+), 31 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_mn.c => amdgpu_hmm.c} (86%)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_mn.h => amdgpu_hmm.h} (87%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6ad39cf71bdd..712075a491f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -250,7 +250,7 @@ endif
 amdgpu-$(CONFIG_COMPAT) += amdgpu_ioc32.o
 amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
-amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_mn.o
+amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9999c18e7d8e..06234cf13d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -82,7 +82,6 @@
 #include "amdgpu_vce.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_mn.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 83659e6419a8..48250a961582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -29,6 +29,7 @@
 #include "amdgpu_object.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_hmm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
 #include <uapi/linux/kfd_ioctl.h>
@@ -951,7 +952,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		goto out;
 	}
 
-	ret = amdgpu_mn_register(bo, user_addr);
+	ret = amdgpu_hmm_register(bo, user_addr);
 	if (ret) {
 		pr_err("%s: Failed to register MMU notifier: %d\n",
 		       __func__, ret);
@@ -991,7 +992,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
 unregister_out:
 	if (ret)
-		amdgpu_mn_unregister(bo);
+		amdgpu_hmm_unregister(bo);
 out:
 	mutex_unlock(&process_info->lock);
 	return ret;
@@ -1775,7 +1776,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	mutex_unlock(&process_info->lock);
 
 	/* No more MMU notifiers */
-	amdgpu_mn_unregister(mem->bo);
+	amdgpu_hmm_unregister(mem->bo);
 
 	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
 	if (unlikely(ret))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 91571b1324f2..a0780a4e3e61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -38,6 +38,7 @@
 #include "amdgpu.h"
 #include "amdgpu_display.h"
 #include "amdgpu_dma_buf.h"
+#include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
 
 static const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
@@ -87,7 +88,7 @@ static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
 	struct amdgpu_bo *robj = gem_to_amdgpu_bo(gobj);
 
 	if (robj) {
-		amdgpu_mn_unregister(robj);
+		amdgpu_hmm_unregister(robj);
 		amdgpu_bo_unref(&robj);
 	}
 }
@@ -414,7 +415,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto release_object;
 
-	r = amdgpu_mn_register(bo, args->addr);
+	r = amdgpu_hmm_register(bo, args->addr);
 	if (r)
 		goto release_object;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
similarity index 86%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index b86c0b8252a5..a68072f766c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -49,9 +49,10 @@
 
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_hmm.h"
 
 /**
- * amdgpu_mn_invalidate_gfx - callback to notify about mm change
+ * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
  *
  * @mni: the range (mm) is about to update
  * @range: details on the invalidation
@@ -60,9 +61,9 @@
  * Block for operations on BOs to finish and mark pages as accessed and
  * potentially dirty.
  */
-static bool amdgpu_mn_invalidate_gfx(struct mmu_interval_notifier *mni,
-				     const struct mmu_notifier_range *range,
-				     unsigned long cur_seq)
+static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
+				      const struct mmu_notifier_range *range,
+				      unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -83,12 +84,12 @@ static bool amdgpu_mn_invalidate_gfx(struct mmu_interval_notifier *mni,
 	return true;
 }
 
-static const struct mmu_interval_notifier_ops amdgpu_mn_gfx_ops = {
-	.invalidate = amdgpu_mn_invalidate_gfx,
+static const struct mmu_interval_notifier_ops amdgpu_hmm_gfx_ops = {
+	.invalidate = amdgpu_hmm_invalidate_gfx,
 };
 
 /**
- * amdgpu_mn_invalidate_hsa - callback to notify about mm change
+ * amdgpu_hmm_invalidate_hsa - callback to notify about mm change
  *
  * @mni: the range (mm) is about to update
  * @range: details on the invalidation
@@ -97,9 +98,9 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_gfx_ops = {
  * We temporarily evict the BO attached to this range. This necessitates
  * evicting all user-mode queues of the process.
  */
-static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
-				     const struct mmu_notifier_range *range,
-				     unsigned long cur_seq)
+static bool amdgpu_hmm_invalidate_hsa(struct mmu_interval_notifier *mni,
+				      const struct mmu_notifier_range *range,
+				      unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -117,12 +118,12 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
 	return true;
 }
 
-static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
-	.invalidate = amdgpu_mn_invalidate_hsa,
+static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
+	.invalidate = amdgpu_hmm_invalidate_hsa,
 };
 
 /**
- * amdgpu_mn_register - register a BO for notifier updates
+ * amdgpu_hmm_register - register a BO for notifier updates
  *
  * @bo: amdgpu buffer object
  * @addr: userptr addr we should monitor
@@ -130,25 +131,25 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
  * Registers a mmu_notifier for the given BO at the specified address.
  * Returns 0 on success, -ERRNO if anything goes wrong.
  */
-int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
+int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
 {
 	if (bo->kfd_bo)
 		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
 						    addr, amdgpu_bo_size(bo),
-						    &amdgpu_mn_hsa_ops);
+						    &amdgpu_hmm_hsa_ops);
 	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
 					    amdgpu_bo_size(bo),
-					    &amdgpu_mn_gfx_ops);
+					    &amdgpu_hmm_gfx_ops);
 }
 
 /**
- * amdgpu_mn_unregister - unregister a BO for notifier updates
+ * amdgpu_hmm_unregister - unregister a BO for notifier updates
  *
  * @bo: amdgpu buffer object
  *
  * Remove any registration of mmu notifier updates from the buffer object.
  */
-void amdgpu_mn_unregister(struct amdgpu_bo *bo)
+void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
 {
 	if (!bo->notifier.mm)
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
similarity index 87%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index 14a3c1864085..4e596a16d288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -38,16 +38,16 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
-int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
-void amdgpu_mn_unregister(struct amdgpu_bo *bo);
+int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
+void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
 #else
-static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
+static inline int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
 {
 	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
 		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
 	return -ENODEV;
 }
-static inline void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
+static inline void amdgpu_hmm_unregister(struct amdgpu_bo *bo) {}
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a56d28bd23be..0668b09d7394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -58,6 +58,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
 #include "bif/bif_4_1_d.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index a5095b3a0235..018fa4c61b85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -28,7 +28,6 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_object.h"
 #include "amdgpu_vm.h"
-#include "amdgpu_mn.h"
 #include "amdgpu_res_cursor.h"
 #include "kfd_priv.h"
 #include "kfd_svm.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 39fbe19b978a..d069e6c096b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -26,7 +26,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_object.h"
 #include "amdgpu_vm.h"
-#include "amdgpu_mn.h"
+#include "amdgpu_hmm.h"
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
 #include "kfd_priv.h"
-- 
2.34.1

