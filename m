Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E641FC5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 18:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF1B10EE80;
	Wed, 19 Aug 2026 18:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hj6sj8K4";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51FA10EE80
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 18:54:15 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso11702845e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165654; x=1787770454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zm036wVSHCwjE+KgqqdhRQjiPW8I9ChBRCr+PRjwQeU=;
 b=Hj6sj8K4U9VUHpfKEfsQ/r0DMNMfBQWDCoKmiAaFrSQ3xNtuJzlgcMy40Kic88u/bS
 KZm18OOyAput30SHmMQA28KGgkVCALOKqNzyE+cPJftRPnCYjQqWpyd45csfez9rYxv/
 5YafuGm96lsFgfpMR5QsUlWHRl3ojwBYukX4cCayVHq52zwlwc9uZFsYv9SzMNsZpQjb
 +owZcTdRLgyo+UGd2/IeteQB0Yy+39pa9/LCQ8l18SSQB1MqQClIooDS3XbQXyS9mmZz
 nKHkipotd9sIlQ4HHOJKXOdwHQk9OcLgYPWvtzx1oK2G6NxoI2j5QZCVNZpWcffk0j/j
 392Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165654; x=1787770454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zm036wVSHCwjE+KgqqdhRQjiPW8I9ChBRCr+PRjwQeU=;
 b=qMTLjV1IQwRxAFKlD2zkahAt5xdDMgGSHTlvFbCtoR79oj7+ZWYJyXHC/MXPTGgDMU
 8bS1i56OXRBwI4hGnitoTnlIAslbRH7P8Vr/xeekKazI04Tqq++X72QHgsnHuqqeCson
 AnJt1ZunGXdaW6WHyhKWbaAf0KCOKS9QiJM09iy0OgRxOsjw9SQ55tH6qWvG5CYIsA3c
 7hc+ppNFfrgC6npwaV3y/c0V0/b+KBIupNLftg+xNSPgv7weFr+a2Y2WAOuAbdTi8kpq
 0KQuSSUHrd0a3ftsBoazFSnjVYnAXmevUzgrOAHPURCradmeJjq3L8Trp9/98+r77Lrg
 XokQ==
X-Gm-Message-State: AOJu0Yxtm+xr/tp93KAMOCfqJ3oWonEqdZA5rqQUc3LSe7+Uo7aLORme
 MdXDOu34Mgf6ic6KygTeEV3IQEjBtL1I2/uYpnXnCES5DsuQt7B8Kr5ccwe20n3ReL4=
X-Gm-Gg: AR+sD13CzW8SCCgR+Ry9MiA8grJJeNHVAG3QWG3sXaHDfFK/mlxCCi/QqOYHHbJOUff
 qlbdpqFvFSQAX8XKXhIODuL7aRXcaOHjq0xwLqc5tkEONwwg7/GrPZvXX8684ixHOqjbGlwYFE3
 nYzgdqj0itNR3ZjxUO8ylVCk+pJpbyOq8vwWoCdrLHba1l/97h7KTUTZuV1JLfOiNKszPSnIuVQ
 YGG/KiRuPCy5NF6NNGGSdLmA4WRCEBaTT1rdHZtZTRVANBS/rZoUq3HnJhE5KPZOg5/K+zznfeu
 gI9nOaAjBRtK3oD2I101yQlcwaSsqCR5XZIodLHTkNBaTPeJ2tvrB0WrtAuhMD54tDJDCZVZWKs
 KIrTNe9WxCwroy5d5GXcKsOuSagmk/jATMKYfH2PWElfWPrqOBzbjDpV4rixx04QSv+g4p3sxvV
 VMQDHAmyBWCgU0vvYtqNBAxzrfvBPKdWmVaiA0vYR3UfnXEZ1w/ue+QZijcMHbE1dKMcztb3Q38
 ciT4qs7CZ13DocIfoHXwntiKg0eywlZ5NeN14y7E4w4x8nZ4h9oOgsQymWg+z6JmKDS9jZY/JV0
 wVdvbdY=
X-Received: by 2002:a05:600c:6308:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-499aa171fd8mr133181025e9.4.1787165653853; 
 Wed, 19 Aug 2026 11:54:13 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm104205315e9.11.2026.08.19.11.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:54:13 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH 1/1] drm/amdgpu: fall back to MMIO TLB invalidation when
 KIQ is unresponsive
Date: Wed, 19 Aug 2026 20:53:49 +0200
Message-ID: <20260819185349.29407-2-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
MIME-Version: 1.0
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

After resume from S4 (hibernation) on gmc_v9 parts with GFXOFF
(observed on Cezanne / Ryzen 7 PRO 5850U, kernel 7.1.8), KIQ-based TLB
flushes start failing at the moment of the thaw and keep failing for
hours of normal desktop use:

  amdgpu 0000:07:00.0: failed to write reg 28b4 wait reg 28c6
  amdgpu 0000:07:00.0: failed to write reg 1a6f4 wait reg 1a706

(80-140 errors/hour measured over 9+ hours; bugzilla 219492)

Two problems follow from the current code:

1. Every failed flush burns the full retry window
   (MAX_KIQ_REG_TRY * MAX_KIQ_REG_BAILOUT_INTERVAL = ~5 s) before
   erroring out, which makes the whole desktop sluggish.

2. The invalidation is then silently dropped - stale TLB entries are
   left in place - because gmc_v9_0_flush_gpu_tlb() returns as soon as
   amdgpu_gmc_fw_reg_write_reg_wait() finishes, whether it succeeded
   or not.

The KIQ ring is marked ready during resume after its ring test passes,
but on affected systems the ring subsequently stops completing
invalidation commands. sched.ready therefore does not reflect the
state of the hardware in this failure mode, and there is no path back
to the direct MMIO invalidation that already exists in
gmc_v9_0_flush_gpu_tlb() for the pre-KIQ stage.

Make the failure observable and self-healing:

- amdgpu_gmc_fw_reg_write_reg_wait() returns 0/-ETIME and counts
  consecutive failures in adev->gmc.kiq_flush_failures
  (dev_err_ratelimited instead of dev_err, since affected systems
  print this 80-140x/hour for hours)

- gmc_v9_0_flush_gpu_tlb() falls back to its existing MMIO path when
  the KIQ submit fails, so the invalidation is no longer dropped

- after AMDGPU_KIQ_FLUSH_MAX_FAIL (3) consecutive failures the KIQ
  path is skipped entirely until the counter is reset, so wedged
  systems stop paying the 5 s retry window per flush

- the counter is reset on every success and in gmc_v9_0_hw_fini(),
  i.e. every suspend/resume cycle re-arms the KIQ path; nothing is
  disabled proactively

gmc_v10/v11/v12 call sites are unchanged (statement calls compile
fine against the new int return; behavior identical). They can get
the same fallback once this approach is agreed for gmc_v9.

The sibling PASID path (amdgpu_gmc_flush_gpu_tlb_pasid) already has
an -ETIME/MMIO split; this brings the per-VMID path in line with it.

RFC questions for maintainers:

- Is a per-xcd-inst latch preferred over the global gmc one? (single
  inst on the affected hardware here)
- Should the latch also gate the KIQ branch of
  amdgpu_gmc_flush_gpu_tlb_pasid()? (no failures observed on that
  path on the affected system)
- Root cause: with GFXOFF disabled across the S4 cycle (debugfs
  amdgpu_gfxoff), zero errors occur across resume and 30 min of use
  vs ~70-140 in the control arm. The wedge forms in the S4 resume
  window while GFXOFF is allowed, consistent with the existing
  semaphore workaround comment about losing invalidate acknowledge
  state across power-gating cycles in this file.

Tested on Cezanne (Ryzen 7 PRO 5850U, Manjaro 7.1.8): S4 resume with
GFXOFF enabled reproduces the failure storm on stock; hibernate loop
testing of this patch pending maintainer feedback on the approach.

Signed-off-by: Denis Pisarev <pisarevden@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b09410d6..cd5d9e56e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -360,6 +360,8 @@ enum amdgpu_kiq_irq {
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
+/* consecutive KIQ TLB flush failures before falling back to MMIO */
+#define AMDGPU_KIQ_FLUSH_MAX_FAIL 3
 
 /*
  * BIOS.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5d6149ba7..000a1d107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -874,7 +874,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	return r;
 }
 
-void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+int amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst)
@@ -888,7 +888,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	if (adev->mes.ring[MES_PIPE_INST(xcc_inst, 0)].sched.ready) {
 		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
 					      ref, mask, xcc_inst);
-		return;
+		return 0;
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -919,13 +919,20 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq;
 
-	return;
+	atomic_set(&adev->gmc.kiq_flush_failures, 0);
+	return 0;
 
 failed_undo:
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
-	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
+	if (atomic_inc_return(&adev->gmc.kiq_flush_failures) ==
+			AMDGPU_KIQ_FLUSH_MAX_FAIL)
+		dev_warn(adev->dev,
+			 "KIQ reg access keeps failing, falling back to MMIO\n");
+	dev_err_ratelimited(adev->dev,
+			    "failed to write reg %x wait reg %x\n", reg0, reg1);
+	return -ETIME;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index ddb0d500e..3e5c152ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -366,6 +366,8 @@ struct amdgpu_gmc {
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
 	bool flush_pasid_uses_kiq;
+	/* consecutive KIQ TLB flush failures; MMIO fallback when latched */
+	atomic_t kiq_flush_failures;
 
 	bool override_pte;
 };
@@ -447,7 +449,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
-void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+int amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810..a262df837 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -798,13 +798,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
+	    atomic_read(&adev->gmc.kiq_flush_failures) <
+			AMDGPU_KIQ_FLUSH_MAX_FAIL) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-						 1 << vmid, inst);
-		return;
+		if (!amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+						      1 << vmid, inst))
+			return;
+		/* KIQ submit failed - fall through to the MMIO path below
+		 * so the invalidation is not silently dropped
+		 */
 	}
 
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
@@ -2238,6 +2243,11 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	/* KIQ is re-initialized on the next resume; give it a clean
+	 * start for the MMIO fallback latch
+	 */
+	atomic_set(&adev->gmc.kiq_flush_failures, 0);
+
 	gmc_v9_0_gart_disable(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.55.0

