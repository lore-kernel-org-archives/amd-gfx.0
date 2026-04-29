Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42DFCD13DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240C610F25F;
	Thu, 30 Apr 2026 07:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="AGz8tEj7";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE4CE10F0CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 17:37:10 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-94ab69af6c8so698864241.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1777484229; x=1778089029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9jIAgqmNQYvaI7Z1F5IA3p1ashE9xvLiL45a/VfhazQ=;
 b=AGz8tEj7LCvd0qmhBww4UeHOJjveUQFjIg63SOEfXi1qYlMM6lW2hAkUEgNz5tJfaB
 Iu61kzU2miuE5Bu9L1XDo6Id2Sb3UZ8y0nELvbmR1ew9RptSGwBSc0A/LKPbRkPjw2z1
 xytsm6Bw2JEJpvjIdmkZ0LJIW1UrTCTsvTlqIKyHWu/M3PPLqj9GhZJbNu3o39jwKYDZ
 my/mwvPJV87awSsPonrcftAUO/f9lun2j334aRmht/CAmJwtNeQEODjDP6bYx7onrTwm
 WAe0u94yeHLxVtnkdXhiR9CKy6PLrWVET5ZNw57P10ptl086qXiE6dck1vvZmW/975Ba
 b2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777484229; x=1778089029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jIAgqmNQYvaI7Z1F5IA3p1ashE9xvLiL45a/VfhazQ=;
 b=aYg/Glmq1R46kxhtjlStzDJlvgP35SOyIdvVW4oQJsU/vUnC4nvIdFAvBX81ypP/my
 DsDOijEP/pL6lwe0LdVhSo+jQ51LF64MueSsXkB3CPocd8PmYlNvV1BJRy8t5dQaChK0
 Xbp0cUjnZey+M0zayNLUWOkBq82lGhfFKT8Wy/yWzrqYA+LfuPMmbYBxHPTgRkpSDjwS
 KX4u1o3Pv9rwPUo2ErkwCw61XJUH60JcYsnTAlMFZ5gKsZg0lrojvI5Q17MUJOPV9yFl
 Rqyu7iv9F1hDKfQ04RVTUyUN5IlQxzkT0lNf+NepdJ0LSou8wK1MTAu4yD7VGo2Ax9jB
 k5sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XbIwa1eb+SM07wy2B3Nt1o2V8S0QJLnSf2bjDtz47uJ4SpY3EZQaMsEDEL5idlNVUoaqPeWES@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUrzIIlYNa6oBYEi7M2IZX6dAodg0O1X2a9cVs3MtW2Chqmf08
 hF68WifJJmYERg2MBKIlGPw1Uxk/iWDHW4dTA7mLF5GK7AfKfnt0UTyZ3hSLVk+j3Qo=
X-Gm-Gg: AeBDievsLsqX6sHUMaxuRGEvOQ3rR0Ii5eDtZFwT1A08Z7gh9erkMc1Z/j5NgpsmXZ4
 p/dXoo3K1QwRExgXlzeFtXRMnjNALselDlnErBGIVToAlLl3fhIC0ccKO2+ech3GMi4hvqHE5mK
 ukeVQ1ik+qd+CNt5K37MFK1C2Q+upnOmpPirgmToHsE/YH9nlpsket0EwUOUwmWUP9rUv/y02+h
 b5lSc6MWjryFD7I8H3eBognjvi4fI9rdaKdX89ofqkQTjJPJpjB1G6JXmkj1K4U6VET4fcUPaCb
 6r7tZKaENwwClIbFkqE2jY0CyKvhd/2HUCbhInTLILFvcobo+qVMYDRr9tJs0kH8G1e+aASyw06
 Ma495Xfm2+9+wE0Ms+PWNYUKEmUpkuqob4gaq1PLdZTXGCNCJUu6yKLmNC2dfJIC8/y69yN39ig
 IxY4kX2X6X1TjE8kf8bn0DJ0gvGIU/ak00VyUBDPdqA2i1wBQ=
X-Received: by 2002:a67:c512:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-6296a37b409mr1241963137.3.1777484228886; 
 Wed, 29 Apr 2026 10:37:08 -0700 (PDT)
Received: from localhost.localdomain ([152.234.115.70])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95cb760fbe7sm1389109241.7.2026.04.29.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:37:08 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12
Date: Wed, 29 Apr 2026 14:36:46 -0300
Message-Id: <20260429173646.7653-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:38:12 +0000
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

The functions gfx_v11_0_handle_priv_fault and gfx_v12_0_handle_priv_fault
are identical. This patch replaces them with a single implementation in
amdgpu_gfx, called amdgpu_gfx_handle_priv_fault, to reduce code
duplication.

Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
Co-developed-by: Felipe Sousa <felipesousa@usp.br>
Signed-off-by: Felipe Sousa <felipesousa@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 43 ++---------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 43 ++---------------------
 4 files changed, 54 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..c8d769cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,52 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ * 
+ * @adev: amdgpu_device pointer
+ * @entry: interrupt vector entry from the hardware
+ * 
+ * This function handles privileged instruction faults by identifying 
+ * the faulty ring (gfx or compute) and triggering a scheduler fault.
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+	struct amdgpu_ring *ring;
+	int i;
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
+		}
+	}
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..5655af43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..da869f928 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6684,49 +6684,12 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
-					struct amdgpu_iv_entry *entry)
-{
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
-
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
-}
-
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal register access in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -6735,7 +6698,7 @@ static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal opcode in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -6744,7 +6707,7 @@ static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal instruction in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..883878e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5015,49 +5015,12 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
-					struct amdgpu_iv_entry *entry)
-{
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
-
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
-}
-
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal register access in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -5066,7 +5029,7 @@ static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal opcode in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -5075,7 +5038,7 @@ static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal instruction in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
-- 
2.34.1

