Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E95C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8696A10E42B;
	Tue,  5 Sep 2023 06:04:25 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E26B10E428
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:23 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so2744545a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893861; x=1694498661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL34cweFPbKRTHzeYjfZVw3Y+Gtc7yxoa/S6tTzsSEI=;
 b=nPzYy1IE8pqsiiX7qRS79P6IOu9Mbi+ShQ/eZwGbzE7ieA4jHTHkU4kHo+Yrc6sZX3
 NGWPHU01f8Y1Qm+ck4F0xQw9LYT5w3ivU7OgEbZ9jZxJu5WTwn3IbT9MNeFvZGgXTDSn
 dRiZX2OWTdzB/NS4eNGO/qH7IvDTzfqIJ2uEEFEwW9pyFH4ycBzvubCXDYRXEqKJecO7
 hgQtjkfHhJV1TRZ88of/FNhGWk4BfNkVGMx+J9tuFk3F1gnRKL/Gzlj7FFZKN5lpHPYg
 VTfTMyniwMPBNaB2TxDSSh5PAb0Ahmiyy6dl6Dkyi+q/L+46hQ9m7YHXy2Uj8bb7wJ9n
 luzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893861; x=1694498661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IL34cweFPbKRTHzeYjfZVw3Y+Gtc7yxoa/S6tTzsSEI=;
 b=YDn9+uVOEqw6BZdZ9OcVAmu7KMN3SUl+Ge/XB1O5HQ4mm8vi92SOe3HeJ+2LOcnBu3
 tpP+UxyUJ7oC8SIEgKb2RSyjDc21Eq0ImOI88wCzHw7KBSzsXOh+lWLEP2//G4LAThwz
 6i+DvNJHkxJaLNDB9kh/4UP5L2k5N8w1hG9n4gcm+Q9uh1E3jp4OMfeZ3u2dG6dZ4j1L
 sFZdy1xE6m816sZbrlszbUiGP0pLIsM2CvWuuQel4q64O9djcoAMjPvtJKn6emffO80Z
 p0HDB4zo4YAOlLC3bOjD7dReLyRZGxk8737LeQev3tIGyi+hIKTxUSDDFQqIivW4vSHB
 t2KQ==
X-Gm-Message-State: AOJu0Ywy1mZ50XoE/JCruX2vLtV8RGLOfbWNoByoJbALubC+lv3xuMNa
 1Mf/q7Xg2VU0iu+UegmOHbJaDFSI3fb2MT6+
X-Google-Smtp-Source: AGHT+IFCFhffBhrQrEqzuQmNWSBsZdvKtipD/ootLnDqZh9vF2F0w9l5B/whrhPFCrJSlJ3fohBWvA==
X-Received: by 2002:aa7:c314:0:b0:528:90d7:a19 with SMTP id
 l20-20020aa7c314000000b0052890d70a19mr9016847edq.11.1693893861593; 
 Mon, 04 Sep 2023 23:04:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:10 +0200
Message-Id: <20230905060415.1400-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905060415.1400-1-christian.koenig@amd.com>
References: <20230905060415.1400-1-christian.koenig@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Testing for reset is pointless since the reset can start right after the
test.

The same PASID can be used by more than one VMID, reset each of them.

Move the KIQ and all the workaround handling into common GMC code.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  60 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  10 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 109 ++++++++----------------
 3 files changed, 102 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 857051093900..b5f1a1218725 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -32,6 +32,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xgmi.h"
 
 #include <drm/drm_drv.h>
@@ -623,6 +624,65 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
+int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
+				   uint32_t flush_type, bool all_hub,
+				   uint32_t inst)
+{
+	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
+		adev->usec_timeout;
+	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
+	unsigned int ndw;
+	signed long r;
+	uint32_t seq;
+
+	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
+	    !down_read_trylock(&adev->reset_domain->sem)) {
+		return adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
+								flush_type,
+								all_hub, inst);
+	}
+
+	/* 2 dwords flush + 8 dwords fence */
+	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_0)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	spin_lock(&adev->gfx.kiq[inst].ring_lock);
+	amdgpu_ring_alloc(ring, ndw);
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+
+	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+
+	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+		goto error_unlock_reset;
+	}
+
+	amdgpu_ring_commit(ring);
+	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
+	if (r < 1) {
+		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
+		r = -ETIME;
+		goto error_unlock_reset;
+	}
+	r = 0;
+
+error_unlock_reset:
+	up_read(&adev->reset_domain->sem);
+	return r;
+}
+
 /**
  * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9e7df2f69123..7732d4ef845e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -335,11 +335,12 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+
+	bool flush_tlb_needs_extra_type_0;
+	bool flush_tlb_needs_extra_type_2;
+	bool flush_pasid_uses_kiq;
 };
 
-#define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) \
-	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
-	((adev), (pasid), (type), (allhub), (inst)))
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
@@ -404,6 +405,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			      uint32_t vmhub, uint32_t flush_type);
+int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
+				   uint32_t flush_type, bool all_hub,
+				   uint32_t inst);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4f6990ba71cb..39016b6900d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -954,87 +954,30 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
 					bool all_hub, uint32_t inst)
 {
-	int vmid, i;
-	signed long r;
-	uint32_t seq;
-	uint16_t queried_pasid;
-	bool ret;
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
-	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
-
-	if (amdgpu_in_reset(adev))
-		return -EIO;
-
-	if (ring->sched.ready && down_read_trylock(&adev->reset_domain->sem)) {
-		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
-		 * heavy-weight TLB flush (type 2), which flushes
-		 * both. Due to a race condition with concurrent
-		 * memory accesses using the same TLB cache line, we
-		 * still need a second TLB flush after this.
-		 */
-		bool vega20_xgmi_wa = (adev->gmc.xgmi.num_physical_nodes &&
-				       adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
-		/* 2 dwords flush + 8 dwords fence */
-		unsigned int ndw = kiq->pmf->invalidate_tlbs_size + 8;
-
-		if (vega20_xgmi_wa)
-			ndw += kiq->pmf->invalidate_tlbs_size;
-
-		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		/* 2 dwords flush + 8 dwords fence */
-		amdgpu_ring_alloc(ring, ndw);
-		if (vega20_xgmi_wa)
-			kiq->pmf->kiq_invalidate_tlbs(ring,
-						      pasid, 2, all_hub);
-
-		if (flush_type == 2 &&
-		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
-		    adev->rev_id == 0)
-			kiq->pmf->kiq_invalidate_tlbs(ring,
-						pasid, 0, all_hub);
-
-		kiq->pmf->kiq_invalidate_tlbs(ring,
-					pasid, flush_type, all_hub);
-		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			up_read(&adev->reset_domain->sem);
-			return -ETIME;
-		}
-
-		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-		if (r < 1) {
-			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-			up_read(&adev->reset_domain->sem);
-			return -ETIME;
-		}
-		up_read(&adev->reset_domain->sem);
-		return 0;
-	}
+	uint16_t queried;
+	int i, vmid;
 
 	for (vmid = 1; vmid < 16; vmid++) {
+		bool valid;
 
-		ret = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-				&queried_pasid);
-		if (ret && queried_pasid == pasid) {
-			if (all_hub) {
-				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-					gmc_v9_0_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
-			} else {
-				gmc_v9_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB(0), flush_type);
-			}
-			break;
+		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+								 &queried);
+		if (!valid || queried != pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask,
+					 AMDGPU_MAX_VMHUBS)
+				gmc_v9_0_flush_gpu_tlb(adev, vmid, i,
+						       flush_type);
+		} else {
+			gmc_v9_0_flush_gpu_tlb(adev, vmid,
+					       AMDGPU_GFXHUB(0),
+					       flush_type);
 		}
 	}
 
 	return 0;
-
 }
 
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
@@ -2335,6 +2278,24 @@ static int gmc_v9_0_hw_init(void *handle)
 	bool value;
 	int i, r;
 
+	adev->gmc.flush_pasid_uses_kiq = true;
+
+	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
+	 * (type 2), which flushes both. Due to a race condition with
+	 * concurrent memory accesses using the same TLB cache line, we still
+	 * need a second TLB flush after this.
+	 */
+	adev->gmc.flush_tlb_needs_extra_type_2 =
+		adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0) &&
+		adev->gmc.xgmi.num_physical_nodes;
+	/*
+	 * TODO: This workaround is badly documented and had a buggy
+	 * implementation. We should probably verify what we do here.
+	 */
+	adev->gmc.flush_tlb_needs_extra_type_0 =
+		adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
+		adev->rev_id == 0;
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
 
-- 
2.34.1

