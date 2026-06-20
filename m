Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61FCD98F0
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jun 2026 11:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2EA10E375;
	Sun, 21 Jun 2026 11:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="xTvJci8+";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EADA10E220
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 16:04:20 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-5176ca6bab1so35079761cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781971459; x=1782576259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9LoTmNWXhl/uf1b0J5TKw+hOQ98YAC1iyy1IKtKZNA=;
 b=xTvJci8+28LnrYC2CQGTopxtDlithKCZSGvujqDdZOXT0CyEe/LgEskrcTtc0TMMD6
 FRvkZVyzYJOoltb69TCslGWZ0kFHlGMKOXaaKcsx+mfaM05dErmcqxMjuSa6mIb2zKNE
 FeSIfKs6zzk04qdewMvp6SudPHRxtiYpi758mbnBZI2GXXat2zhgHsXmPT/Sfg/XDWWD
 NShJTBhF7oHdNdSBDczx14nDRBzz30o1zq367z9MqBkLksOZlyY1xWiCk0hWoSBqzNRu
 +E+P1fP106aTXT53EyZcid7BXRCNjGObs3X3qDbtu3YXrOtw+th77/NEQ7LVeCTOQ+JB
 zWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781971459; x=1782576259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h9LoTmNWXhl/uf1b0J5TKw+hOQ98YAC1iyy1IKtKZNA=;
 b=okgR4KhSA0mnPq8iVXm9I2s/6MQlHgMKRb82Rc8Q4HjR8JmLt0y33Bwkrpt+p1dDAb
 MK1s9OdT8DEmUtNxnqybXcuuAd2MTwkCw+TAkqlWNUYs8CglJkgjLHjz2mFhRhb+R2Qf
 p0WPIuaIWP3F0oOQb3uXT4WMJRph+L41rEEiGOeFKoJYzIsxgwuRAIRrjxPaijydYLSD
 aNbxQy1EIaFPpo7SveHDCRKvlOemUqGCq6dX/GViw8hXvhZdKltPiYLow8np/Bt8It0m
 P/1zPlVSrufM0HUygcH3mIB4N8QG3WwOZSnIM1aGAq0w3XRXSuoQwHd/+cnuE3lzqfib
 kbBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98gBO82U9IvqL3iCMQfhCR+dubKc6KjLHCA+TWFKvpfqFZVREg/Kp3mL7p+h1km3x003Y1qur4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7vwupuodb29eC56UcIVQO7Hln0YVoCJU7gz1BA1J+R2I/FWgR
 yoBUVcGK6sVfROiGDhC09OZXYLaiWI+CCZRs0T8pwS7a1bmXX+WePr9MVqRx6cQKz1Q=
X-Gm-Gg: AfdE7ckOqBfLW7bK76k4RKBkxRs8UWaf+CPMUEqzN/eFluLpGoEofCaKpN4LS59hPFU
 QEAKOJxvqxzUcwzym3EnwqcibOhEZ4xQv5KKRcEGRccpQUVPPu7PUEYtCQRusbwgD+41vxC7WmM
 LOJ3I4c3t2rmas9fxSXojbOvZYKabDNJxq5zGbl7kf92LC+g8aRi2G+1WnBNh4p3saTw/N1c8Vs
 47Wz1ek8twdOp1M7Pon5EE1KB1mi39TX2uYhnjZHInbxTqNn/Z7x9EeW9VqIaeEA47OR5H+JZqq
 KzGhJEMr1lLUOxbdeUSLpdlcxlHvBcafghTfY6J43hLbS4yfgxXvL21sg7Z8M7MX8UZzfzSA4vD
 JYtDgXSd7bZkhTC3kgrySmXA9p6+43pSIrsRSLKyGT8/75JXPmWyaLMGhjj0ulHja2z0vtg+/rq
 2iqn955LuLdvENXAI7GYuHXuPJxg==
X-Received: by 2002:ac8:5a4f:0:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-519e6640873mr100545251cf.12.1781971458814; 
 Sat, 20 Jun 2026 09:04:18 -0700 (PDT)
Received: from localhost.localdomain ([179.100.109.88])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a098528basm24303761cf.16.2026.06.20.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 09:04:18 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 RESEND] drm/amd/amdgpu: remove duplicated code in gfx_v11
 and gfx_v12
Date: Sat, 20 Jun 2026 13:04:07 -0300
Message-Id: <20260620160407.8195-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <96a6ce62-d015-4cc7-8584-bb73171f23a9@usp.br>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 11:39:50 +0000
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
Resending v3 as it has been over a month 
without further comments and v2 was already reviewed by Christian.

v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +-------------------
 4 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..205d35911 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,40 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ *
+ * @adev: amdgpu_device pointer
+ * @me_id: micro-engine ID of the faulty ring
+ * @pipe_id: pipe ID of the faulty ring
+ * @queue_id: queue ID of the faulty ring
+ *
+ * This function handles privileged instruction faults by identifying
+ * the faulty ring (gfx or compute) and triggering a scheduler fault
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id) {
+			drm_sched_fault(&ring->sched);
+			return;
+		}
+	}
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id)
+			drm_sched_fault(&ring->sched);
+	}
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..0b2f6ce85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..888c9f3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
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
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..3f0d29372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
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
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.34.1

