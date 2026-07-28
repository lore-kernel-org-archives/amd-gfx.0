Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5963C54F4C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 07:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC0610E7C7;
	Tue, 28 Jul 2026 07:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="awvPFk1P";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4E010E512
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 02:50:59 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-81ed2a06b9eso28982737b3.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1785207059; x=1785811859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z29Jn7Z+oZ7PC1rJvwh1pAjNavUuUm55iKxWhWS6e6w=;
 b=awvPFk1PyMOUpUXp4f45L9CzH6cM7EPwMC6R6IdNr2CkTEe3rL+NkYGQAFJpOldlzd
 eOwEVmcm2pbc0sFOJyL3D5XjkYiwY1wfRnjJq6qJNEHwnPc5qo35lsO/ulJ8RONzu8By
 CHkMsyqdihQ7RAMzDBc68yTxDdb4DacQp+NY2jZ6kpjIwkbEpjXqbjuvIklIuJt4BNXH
 Cq+2P/8gqx2nxHap4Ju3eTjeE6FVSQLSOtDhLrbbBkqmHixuiGJnQcvcdVuaVMtUVw8L
 41Iz5Vh83r/k5hiV1Ag8SYDkH0tA+Rfqq+PqhSkBoPP6cCP6KPGIWTk015UGhowHQzT3
 Vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785207059; x=1785811859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z29Jn7Z+oZ7PC1rJvwh1pAjNavUuUm55iKxWhWS6e6w=;
 b=I+yEvjjML6tBCqCjMDTDpiiR4M8mucsiXMDQ3I5BcdIsLzn2X3Y0edO27yBMT/R0hr
 02VfQ28JDABmkwwgOZiPzLtfTZtiTq88pmveQC8nIWjhVIpjCqPZFqQ3WXhwsEUJEQc3
 xQFMCfBFHJUaAKr/mLzfZ49K8VUkFW6jhb0bRc4voanu5Ki+Olw1EVX5cxc2MzWHq+T1
 VYwiWRdIqrqe0NRrmUL7GFTQy3Bxz5K2GEyBnrpYZS+GGVXA51qjkrtnT9cGKVWD1gtE
 Qc4nqsK3XSQOx6bwZSK6Kb+GJUMbgN8mLT0/EnMJhfH/qoEXEqeFbkq3iYqaRDbeE+/4
 BFHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRVBMLwsQk3HfYa/8EKJ4nc1EvrKg5rWm5OfrLGQvwS82mTm8nimhCviE+4W7EpINkelk2RY0c@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbN1kyGCxNt/HtLJDKCLRWeRZArvblZGMN+fv4fgUOOFTixKx2
 IEKiutBnfxQBdZ882aBTOzg9WcCYmSucHzVEI02ImzCOKcPGujoiJBAhf6SQ1SEIZA0=
X-Gm-Gg: AR+sD12GwBRIAF1v36SYBtwtWEvMkX8IratPb5cHU/ToPHmAjPJQ43j1D10gzQhC4Ae
 3431FlPXYK6fNNy+RxgMOtBhT1nFI/6KCWl7u8pIwoHWlI/xJg9T94aNKCs/bmI8HIIdHVZ449D
 Dyuj3ULOpejI11s16O4XWP/WbUvvbrAHBZB+kQfL4mEp6mNVzMWyqxOSJsjRuTRXf39A0CtOKfF
 YjBhCVMtE0kEkVi4CqykstSRrP7lXm+7xrfNDVzv75IuLRp6GdkjLmiwn2tY4dZt13UgHkWQh+G
 NfAotcvAlPk1nAWxD5T/vac+x7kCOE4PIxy50HtTX/FAUwBcwXA+J+vmFprQ6HVAGEX47xyz/i5
 9jEADwZo/Ljc7lkDCI0eK0nHlkEp8z3QLOHqRg2gjgz8q60FF/MGsnxCbxJgxpEJY6VYeVjRSJw
 yWKDaO2xP6PiyBYnM=
X-Received: by 2002:a05:690c:698d:b0:81d:2254:8504 with SMTP id
 00721157ae682-81f993c9973mr1812387b3.56.1785207058670; 
 Mon, 27 Jul 2026 19:50:58 -0700 (PDT)
Received: from localhost.localdomain ([152.234.118.71])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f657bfddcsm40714637b3.18.2026.07.27.19.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 19:50:58 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Mon, 27 Jul 2026 23:50:48 -0300
Message-Id: <20260728025048.14970-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADnq5_OkpYczJu0LK9pEmBWFx=3Cq4GXNhSghRLGO-jXQvomJA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:22:39 +0000
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 49 +++---------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 50 +++---------------------
 4 files changed, 64 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3b40c38..06df4d1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_mes.h"
+#include "amdgpu_userq.h"
 #include "mes_userqueue.h"
 #include "nvd.h"
 
@@ -855,6 +856,56 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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
+			    ring->queue == queue_id)
+				drm_sched_fault(&ring->sched);
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

