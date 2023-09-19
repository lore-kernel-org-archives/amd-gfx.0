Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A34CD5BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D5910E39F;
	Tue, 19 Sep 2023 12:08:35 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1256610E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:29 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-532c3b4b55eso610800a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125307; x=1695730107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PgMUqe8nXUxqRt1Fi3a97nVsT0Q647xLxlLWbpSoTHs=;
 b=SoX+spCfbdljW1PLRTpa1PcHXiSBjuJsMUKi+xLtHbI11Ld7aLHcV6uO0beMUOKHsb
 fDoZMKq9euz51rtaOJc/O5NSecBQ1vv9GzS17Oj7IJFVfSsKMyJuav0fFuqR3lhsc1pe
 UZ4xs7vIf4z+xFbW01q+3ndf8tBvQn/fVPnNrxztQa4QGi3YH9NlywMt1WkSIRSx0GSR
 VEimWEvpzaeHcaIuvpFImv/2MDnj4bkJ3NWf9yrdhrAAlEICt1PBo+R9eP/RYOEtJjGZ
 FjCASPxxPREDzktYqPSC9zZ0wGXHtYmGkIcp3cLF7+R6TAUWexLG2MZuFuCME6egZ+TA
 rTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125307; x=1695730107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgMUqe8nXUxqRt1Fi3a97nVsT0Q647xLxlLWbpSoTHs=;
 b=s062mx9Lct8nbOT2TmN0eh2swd91UMYzNM37ru9g0VNN2U/HFIyAZsAYoJoHAymzvE
 b+9jO1Df3ZB4CjBTqWLLg7UFXLsZ9UzSbWgPxNBnNVqK4cbE5qFoICbsIHzz9QmbjMdw
 gwAIiazFMGpxnrHIm6xT1kFa7GF+St9c7IZhYuBDQ325bZvCjkqOaIEHc1Z1NZ3sNwIM
 Gbnu2ULa7nh/4ZkIY9MpWCc8eoV1EazOTnLH/8SY7uucZK3mypORY4MycywexQ3N1Nuy
 e82cFdM1HrwcKpvb+XAUxeevrnQvSykw3/A7DjFSVEHQGL7sW7jo6GbfRpGjcIoXQrie
 G5SA==
X-Gm-Message-State: AOJu0YxGw2ukVexKwfoO68KNjw67R5n1rht6bcRf/L5tgfs3LspYyvv4
 Qs14QKkPm6GwoLdSIBXOspo=
X-Google-Smtp-Source: AGHT+IELZmjoZ5ewpYNMx/rh8GisUSwzZXNQ61s1cBqBl1ebahXXjbFiEzqZikw3tH+vWSnnKkAp3A==
X-Received: by 2002:a05:6402:b8e:b0:532:d596:1c1f with SMTP id
 cf14-20020a0564020b8e00b00532d5961c1fmr600144edb.12.1695125307349; 
 Tue, 19 Sep 2023 05:08:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:17 +0200
Message-Id: <20230919120822.95241-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919120822.95241-1-christian.koenig@amd.com>
References: <20230919120822.95241-1-christian.koenig@amd.com>
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

Testing for reset is pointless since the reset can start right after the
test.

The same PASID can be used by more than one VMID, invalidate each of them.

Move the KIQ and all the workaround handling into common GMC code.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  60 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  10 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 111 ++++++++----------------
 3 files changed, 102 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7db2884ceb3a..07f657e2f3a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -32,6 +32,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xgmi.h"
 
 #include <drm/drm_drv.h>
@@ -627,6 +628,65 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
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
index 0f82ab48887a..37b33eb84210 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -956,89 +956,30 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
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
-				       amdgpu_ip_version(adev, GC_HWIP, 0) ==
-					       IP_VERSION(9, 4, 0));
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
-		    amdgpu_ip_version(adev, GC_HWIP, 0) ==
-			    IP_VERSION(9, 4, 3) &&
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
@@ -2360,6 +2301,24 @@ static int gmc_v9_0_hw_init(void *handle)
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
+		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &&
+		adev->gmc.xgmi.num_physical_nodes;
+	/*
+	 * TODO: This workaround is badly documented and had a buggy
+	 * implementation. We should probably verify what we do here.
+	 */
+	adev->gmc.flush_tlb_needs_extra_type_0 =
+		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+		adev->rev_id == 0;
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
 
-- 
2.34.1

