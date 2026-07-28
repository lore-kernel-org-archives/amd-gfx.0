Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3DC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C65610EC32;
	Wed, 29 Jul 2026 13:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="AMYDnEZb";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23B110E60F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 22:24:45 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so226831a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1785277485; x=1785882285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LwBMGAMsIUTN2reHfg9pCJRS35YlsvPIR79zq15iPHA=;
 b=AMYDnEZbzm8ctU+esmZOzJ/3c6zb+FuSIRCMMfz+tfrFImk4hYJih3W9z4tZR4aCng
 kexGKb5FeaEjfi/IfJ9GsDa9EpL38b3iJSHZLnK+rqclI32xY/Q7vk8tQld84APUiDr8
 ov2/uPdd2bkxH/adPSw1wGHvI8t2If44DynmtbSqd3Zfa0F6g0ywQ1CCZW1SYFKjK4D3
 4KXFhOWWjCpHwK6RzsAR/5T1MiNE5mCnIxH8mypQVaayugPNlF99l008fbli1V4pbx5h
 qaK6v1cg+DrlvSwE2adIQwUw32JS1ICFmTPKOnFy/qjHOG1puxZrCYhCDa0ZszFFR1fN
 exvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785277485; x=1785882285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LwBMGAMsIUTN2reHfg9pCJRS35YlsvPIR79zq15iPHA=;
 b=WIjdcoq8U5wO7ftkeCbC6QjbUbzTTQ48xoO/pyFm8ZkEs07fVF8+xW8RsHpBYKt4md
 oHIclYtRuzE/ZS4SN518FNliS6KISUR9FSqJHcm6JlIzFdSuykJQUca43GjLdTvgqgVp
 7pNO3dpVA0xfYa4bBiV0PlgaVhsUw/7sOxsUA3PiZ+uCscWu6iwDXyO1iYXt10xkK2Xo
 wghvwbP9gNlLqUQQ8oyH0gkdlddJnMlZpvE0wQvSt/vum5GM2Q6DxiGXV2UzKPBBVF+w
 v5i9zktlFCFMUHB353vgGrd7lOyIOw04pq4PDM9h6tcjtcGki99N3D1EZ0rEHLizn0Ud
 A8Yw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcA8493/rDSTyb7mMY4TK5IKLRmx7UzVH3GgrNhqJ9PfLbWE6hf5gFd/p+Ojkh0DOc2u8TE2t+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzys0oTmJ//NK7ksisjVFOEFI1dm/Blfo/32A8JR+tj9kzIICx3
 oMw/ivLgOEQVmQaleHmPKcrNZ2F/gwCQMke27W12TT0Iq9p/GNb4TCK1nMWpmZSd3QM=
X-Gm-Gg: AR+sD10wBfdMLIyJG6aol4LmGiQXjj/vW1SPbzvI8L0KrBgoEXouwrjE3rerDGJIZAR
 y1lsSdOB0z1x0b2S3NSPXv42duEADhs4kV4fj0CFgKg/1oKOHJRpZtLxFjJGY+Nqd4MgyNM78nd
 VrPN7VNmMEC2VxGmZ40iHuEw9TfHCVlGztOnqYUo2BbSv9w5Ckimm1fRQ7CKWOnkcc9a6XaeiZx
 mT3F6kBVJAB5K5YGJSEkCFF4aamUkJeBqqFzR2wvQmVFxE//H5zCzwzSCB1pKeXV5gStQYqkOhK
 riATX01B1b1UEZ6YCv8InPMY/9ipyl3/LPOk+kjS/x/PaQ2l9aZLh9UQ3wYjzc57cQUgEKs3WYd
 OkTKsQPg+Y4JFmyFLoHgZv/h6op1wbh14IccaOJdwYj7zKrObZ1SVD9k0ojbFkCjWsxFpYvg3aO
 q73rCkcpLKpSxDDBb3T4g/6j62mdCiDvwf+2Ff967FqQRZCTNuFCvKHSv51KLK6Ygjxlf6v3L8T
 w==
X-Received: by 2002:a05:6a20:450c:b0:3c0:9c1b:d0b5 with SMTP id
 adf61e73a8af0-3c8ba627823mr5764691637.64.1785277484815; 
 Tue, 28 Jul 2026 15:24:44 -0700 (PDT)
Received: from localhost.localdomain ([152.234.118.71])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504cc73b6sm2323584eec.18.2026.07.28.15.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:24:44 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Tue, 28 Jul 2026 19:24:35 -0300
Message-Id: <20260728222436.8393-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728072643.5F3A71F000E9@smtp.kernel.org>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:16:19 +0000
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

The functions gfx_v11_0_handle_priv_fault and
gfx_v12_0_handle_priv_fault share the same logic for searching and
triggering a scheduler fault on a ring. This patch moves the shared
ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
the version-specific files to maintain proper architectural separation.

Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
Co-developed-by: Felipe Sousa <felipesousa@usp.br>
Signed-off-by: Felipe Sousa <felipesousa@usp.br>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v6:
Updated code with latest changes from amd-staging-drm-next.

v5:
Return early on adv->gfx.disable_kq check.

v4:
Restore the adev->gfx.disable_kq check to prevent falsely triggering
scheduler faults on idle kernel rings when MES is managing user queues.

v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 49 +++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 50 +++--------------------
 4 files changed, 66 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3b40c38..9ff0829ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_mes.h"
+#include "amdgpu_userq.h"
 #include "mes_userqueue.h"
 #include "nvd.h"
 
@@ -855,6 +856,58 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ *
+ * @adev: amdgpu_device pointer
+ * @entry: interrupt vector entry containing fault information
+ * @me_id: micro-engine ID of the faulty ring
+ * @pipe_id: pipe ID of the faulty ring
+ * @queue_id: queue ID of the faulty ring
+ *
+ * This function handles privileged instruction faults by identifying
+ * the faulty ring (gfx or compute) and triggering a scheduler fault
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	/*
+	 * Try KQ first by ring_id (HW slot is authoritative). The
+	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
+	 * never share a HW slot.
+	 */
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id) {
+				drm_sched_fault(&ring->sched);
+				return;
+			}
+		}
+
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id) {
+				drm_sched_fault(&ring->sched);
+				return;
+			}
+		}
+	}
+
+	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b..c15f45a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -620,6 +620,9 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry,
+					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc369..489e0c97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6710,52 +6710,13 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id, pipe_id, queue_id;
 
-	/*
-	 * Try KQ first by ring_id (HW slot is authoritative). The
-	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
-	 * never share a HW slot.
-	 */
-	if (!adev->gfx.disable_kq) {
-		u8 me_id = (entry->ring_id & 0x0c) >> 2;
-		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
-		u8 queue_id = (entry->ring_id & 0x70) >> 4;
-		struct amdgpu_ring *ring;
-		int i;
-
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
+	amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c526..32cd9ad66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5041,53 +5041,13 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id, pipe_id, queue_id;
 
-	/*
-	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
-	 * a HW slot (compute_hqd_mask contract).
-	 */
-	if (!adev->gfx.disable_kq) {
-		u8 me_id, pipe_id, queue_id;
-		struct amdgpu_ring *ring;
-		int i;
-
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
-
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
+	amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.34.1

