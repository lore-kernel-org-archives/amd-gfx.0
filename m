Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4BFC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1958710E925;
	Tue,  1 Sep 2026 08:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D8+fbLp9";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDDB10E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:35 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so4560395e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252094; x=1788856894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LSAXZsRyGXh9uGU1fWvyeJUrYgfAcg4d/bXc8vVz4Eo=;
 b=D8+fbLp9QARm3+XM50MkNQ9cNS0R/AiAloEmTyCP1T/8Z1a3zDjLV/TBgcQizxUuUb
 PleHBx2Navbd5Es+c6/wPOxa12JneV1HjayvzRPILc/tUHZoMIxyksNQT3Wntp6V7owl
 mAY5nJVoZCzTsIP0F91O2bosPrP6pHSUc8yMwFuEpTjkdHddt/7LCS8+bzxwD9IFJgAy
 n5iyvYI7hxEhceFwBloMDcypfIPzg9EWgsOWK6nIdKhcEMVY4Dygn0yqmWreUQqx+lML
 q3GikmU4JJznXKV/kXRhS0dwX8k9eQoGBgIj1p/bkTuYKupm9x0bW2Sx7dkFI9aT20G2
 gY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252094; x=1788856894;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LSAXZsRyGXh9uGU1fWvyeJUrYgfAcg4d/bXc8vVz4Eo=;
 b=VXmDmWZuC3TrgfnoxDZolh3GxTuCe939RHLzBEhDTYMKi/ynD686rFIoo8SU3vPPDX
 zAjbk8e6pTrlG3ap8YHsHr9oQlA40B9G1gpv0a1HbN1q2HJuhBidkoABZ4M4xBl6OqcX
 WfhUw2/zVOza509fKjNv/VrhMjcewmaCWRgUd4F81/2m6yCZSntihRvOVum1h1a/nxjy
 AXbEKYRqmSJ95gT7Mb5N4JI85C+2djbzs1LqNtGAj9gdEKUcpoTe0sHnruXwQhJrtQlb
 3NnjTZzkRLoDIKI2KCSKJ4kRMDNM156KuWUEITqpdJzXrcVWZX3r9tWQ67DzJj3bMGzD
 swhg==
X-Gm-Message-State: AFuF++mw9+FuyKQxRuraWsXybRP7ApNDxNf87zWbUMs+0CUfvc9IY8Im
 zcN01qAsEHdzYkZwU82bpFeMrixSorTS/1CUFb0j0VzOqgr5HOk0SS/pnDJQaNOEywg=
X-Gm-Gg: AR+sD11XKS1XLRkKFvVdCuE46JFoC3nkD9N1hmRb7x67QHrojvRlafnlRCglVDZdDys
 kPm6r24V8z0H824PXh92tvdR2YziC/EWkhZY+7yALq+hem8Utzc5QoxW4DC+o+rn8D7r6nvYkKM
 DFjFDcWMMMipz0lmOgBAlwzJxA1qR2Fu2CWv7BwoDkLo19N5vZLc7AUpNWr2dwgxT4QFrLWNw3K
 3usy72EJf/ZPddq3uCjNFa8H8JUhXlNDy/u6KStzEIbIemHxlAYIyGDWI9oIouCfqJIJTGWjDHr
 2NKCpDvgDuZ6CjKXS68Lh+TKx8zuY38/rWxTrVzBhTlRqefsEcSGBH2WScyY+Tl0MCLuu+nf9kR
 dV0Kf35ise4pjvV22klOUDniFe6fCBma+/A30AAnP6e4V5tbinYpO5KoW19oo0tp1n8tbZInt4T
 qxq0GdTWSLvAHmqtyshKucMykuk8vG9/BitfLHS7lB5CHxkZ1w6QHylCjlwb95U59Bq3rp2gFVu
 vemoXJ23xadwkY5YTm/5yg=
X-Received: by 2002:a05:600c:4e90:b0:49c:ced9:ab7f with SMTP id
 5b1f17b1804b1-49cdd60df3cmr50785575e9.8.1788252094160; 
 Tue, 01 Sep 2026 01:41:34 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/8] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
Date: Tue,  1 Sep 2026 10:41:13 +0200
Message-ID: <20260901084115.262457-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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
index 66f278f77f71..9eebd8380834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -635,3 +635,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
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
index 055dd2522ecd..cb41453c1a19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -156,6 +156,10 @@ struct amdgpu_buffer_funcs {
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
+int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence);
+
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b7bda6361ef9..86eef0a361a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1491,29 +1491,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1909,7 +1886,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
-	.reset = sdma_v5_0_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index d063babab833..09f00c99dd70 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1409,29 +1409,6 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1924,7 +1901,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
-	.reset = sdma_v5_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

