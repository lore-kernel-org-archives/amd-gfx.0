Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E38C79F99
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425EA10EB35;
	Tue,  8 Sep 2026 18:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAGNiugu";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B068B10ED12
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:17 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so105122f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891076; x=1789495876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E2x1fP6np6zJr/DUnvHLC3KFTz6QrTFaFY+49kC/FME=;
 b=DAGNiuguuoEN/7lXxNxwluGC/+kQUvVsOtjbPWHjEBZ1Y1v8gcmbV7crRO9HQh0EBD
 o99Jd5mCWw7y88zt6kyMjC2vs2IxrUXy0MXQapX0ieUD6n5i3NCpbeaKr3uLoHO2cJ1G
 ZkRYyKj+jxy4APPI8sdE01cfkddwOQkqX7F7zxWnLMnFoF/aHtRoOAQKIsgceSOVmxcq
 vVHFlQKcdMzm6GeEL3WILq1XIZaPw0x1ppj9cGURUYF5IAB2fwpeaz12XXbYmgZQQ3/F
 a/mzW1f0sYrnaZdfQ+16lXI6+HrWjQQhX9m4bob64WQcbXjl/Sk7UkzB4mIimYEZBMyd
 FoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891076; x=1789495876;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E2x1fP6np6zJr/DUnvHLC3KFTz6QrTFaFY+49kC/FME=;
 b=pBzNenzTFdcmN6wz1+VlGub2cEBiUuW50riHVCRAsI8UYo6BFOTnNW0I9op2zLcHEb
 74NGllPZ9Z2VmjMPpZXDdnGGo1C5E8KgSfI3OOUoueyM6/t21kFDKADZf2rXC/YuydNv
 4ai8kjOXv/gsLaxExpVTaTKaZ8MeYL64n7Km58CkeHIhQ6c1Gs8obShPF3qkRh3iaKoU
 cVm79+GMH16lGkZ0WQY3hEFXM8Z8apK7Hn50Y75SODwHyaLvehxyU9RjSTIusMBFZsFL
 uXighTHJNRub0LFn/+l+lCuTz/ZGnPT4bfBlJstt5TtXgbUJXj1yeQk0+euXv72+PW1U
 PnsQ==
X-Gm-Message-State: AFuF++n6opLvRNro30d1UnOsPR8iFeIxlAKabwiExnn9VtfccAoX62Yc
 gYx3TTBQ5iJ61tBPRzmYRf3mgIZOjND30TRigKizXe/n5IplCkOPpWRQNmm5FL7g
X-Gm-Gg: AYBFou234cdpVvud9y34DR2MrkjnhP0klDimLI+GxC61DJhMzDcfqWycpG6DPkBoICP
 qZrcoe5Jeap3iC/B58Y7Rh6kXBkaAYjzwHSxh//A3fFmj+/1dQ0cySyVqKQR7L2M97o09SYOMN6
 yVV1XbaIoR4t4a6jtkbjtwddb21JBbVRJDxwDg1aHBKSCKLUvRB8LDdH/heFcai7x6Oa7XpgAF8
 Ww654o66/7SfSAtRetnRZ2Xc3Izp57Zp2StoHych4Z9PsVGCW7rmoJ1jv7VhfV2R6C6NEeDOb5P
 r0Pw8Pzx5URFvs+aDqiwtdzT8182gKkmMP0x4h2POf+Y8UWa689kHOi3lxFvbQ867mBZVDUcpsI
 Lr99LcejYUcyof3dwRW17j4yFJk8oRgjXgm9dTJdBeoGWta3+h6EcZvFgxcxvtY+qkOHyRPLabI
 mPnEwuBjrc1l8dcWgsGQsvWccsDdc8OVBCNf5/5Vza/obP1GCFSXJhRqtUARhfxndjePsLW0HB2
 VgJIndchTi+aQy3O7/LQQ==
X-Received: by 2002:a05:600c:3543:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49d1f354321mr15075265e9.9.1788891075478; 
 Tue, 08 Sep 2026 11:11:15 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/9] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
Date: Tue,  8 Sep 2026 20:10:50 +0200
Message-ID: <20260908181052.381126-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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

The code was exactly the same between SDMA v5.0 and v5.2
furthermore the exact same implementation can be shared
between all SDMA versions that don't use MES.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 37 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 +---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +---------------
 4 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 3495b7553950..71a7a70a80c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -628,3 +628,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 	return ret;
 }
+
+/**
+ * amdgpu_sdma_reset_queue_legacy() - Reset legacy SDMA queue after timeout (without MES)
+ *
+ * @ring: Pointer to the ring of the SDMA queue
+ * @vmid: VMID of the timed out job
+ * @timedout_fence: Fence of the timed out job
+ *
+ * Common implementation for resetting SDMA queues without MES (legacy).
+ * This relies on the proper amdgpu_sdma_funcs to be set up
+ * for the given ring.
+ *
+ * Applicable to SDMA versions that don't rely on the MES yet,
+ * that is all versions up to SDMA v5.x and older.
+ */
+int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	amdgpu_amdkfd_suspend(adev, true);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
+	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 44ba997c8e80..fb0316b28f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -157,6 +157,10 @@ struct amdgpu_buffer_funcs {
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
+int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence);
+
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d24659a69382..a4d2a107c74f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1495,29 +1495,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
-				 unsigned int vmid,
-				 struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int r;
-
-	if (ring->me >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance not found\n");
-		return -EINVAL;
-	}
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
-	amdgpu_amdkfd_resume(adev, true);
-	if (r)
-		return r;
-
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-}
-
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
 {
 	u32 f32_cntl, freeze, cntl, stat1_reg;
@@ -1913,7 +1890,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
-	.reset = sdma_v5_0_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 76e1f9f39525..e7613e27e774 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1414,29 +1414,6 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
-				 unsigned int vmid,
-				 struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int r;
-
-	if (ring->me >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance not found\n");
-		return -EINVAL;
-	}
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
-	amdgpu_amdkfd_resume(adev, true);
-	if (r)
-		return r;
-
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-}
-
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
 {
 	u32 f32_cntl, freeze, cntl, stat1_reg;
@@ -1929,7 +1906,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
-	.reset = sdma_v5_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

