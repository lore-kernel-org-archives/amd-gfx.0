Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80C1C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 13:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E7A10E3F2;
	Tue, 15 Nov 2022 13:39:02 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEFF10E3EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 13:38:58 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id g12so24128733wrs.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=URClznZ4ywTAGqFnZ1KBwhIKMMeA+Nkg7pvzWgIP3Nk=;
 b=pY3IO0AgOnow+mB/6gJZkWptx5/7BYw7QmDOGlGmLAnB8Snn0RY6kCTLRdzX03J2DE
 rP9mJ6RT0hbuOmQIb4PlzFdC3sI2/cmA0nep3CNmb0wZk2pAmMWPBvtWoOPGIg2e8VQq
 3XGd+2+z4NpV4nwIWOPkkb/ZmYx4uiUXvk3yHnlpn66UljebnNd4pLa9HH4zZ2xEAQbB
 sg30N96UWJSVI8SutNvG2YkjYbSP7S0Iju0ovRTXS8tlFa1EwgkoQoG+PaKtAAS+8JBX
 vKglk8au9FEliq1+NsdfSPe6IpKAmjAmxthp3s0zHEaR5S1CAVyyNOGUkFMnEyKML4T6
 l7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URClznZ4ywTAGqFnZ1KBwhIKMMeA+Nkg7pvzWgIP3Nk=;
 b=IIuqXF0yJ0tq8+i2oqa4na1MmUSaPnT6M0YiT6kCoXwVve+N/NIhSTnFXS2zrpwd2k
 tsooJ5DUNNooRsHYmnPC3qeJA8GKOtM7ie6FXxWFSTJ/rmxiAp7fnvyjLF8FFRTVoen1
 OumuPKDWm34hUPDu2QYDeHtZgLTI2jfY7R1xNlVRzdB2fl4pTuuol4KpnNAesLCsBlpw
 MLeLeUgpSMd8q7P5QCwoUA6i2dhBRH6inrpuS6V9YZXRYE/2UdV7WP1tW0Q/5oD8XnRg
 4ikZvrLshz/Qqi+6naw21v6PnYHG1MU4KQf05QN8CAst22vOi88idR1Z81J8yb8NXfaG
 BA4Q==
X-Gm-Message-State: ANoB5plGibpaTAKiv0/+VldkXlvy2wd73uu4kmh0uT96A3B+HF4iPG/z
 3Dvy3uEhdOwkv5vnIvTDy2bL2vC5Nm4=
X-Google-Smtp-Source: AA0mqf7d2bUgDQCtLW+oGASCxT7oxDakKwABMG0gFLl9fVimbltd6X85pPA61UBW8fdO0c2wYhGHGA==
X-Received: by 2002:a05:6000:98b:b0:236:6a53:3a19 with SMTP id
 by11-20020a056000098b00b002366a533a19mr10532866wrb.409.1668519537078; 
 Tue, 15 Nov 2022 05:38:57 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a1c3507000000b003c6f1732f65sm20405469wma.38.2022.11.15.05.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Nov 2022 05:38:56 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: rename the files for HMM handling
Date: Tue, 15 Nov 2022 14:38:52 +0100
Message-Id: <20221115133853.7950-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133853.7950-1-christian.koenig@amd.com>
References: <20221115133853.7950-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clean that up a bit, no functional change.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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
index 29c22a27db80..8f5ceab43882 100644
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

