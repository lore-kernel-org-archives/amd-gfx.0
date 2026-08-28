Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05FC61DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA02E10F372;
	Fri, 28 Aug 2026 12:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PwuuNT+c";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9C910F36F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:39 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so128853266b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918857; x=1788523657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BtPDnFD/wNqPKqQoXYCdftNBV1h086F3eB74129TCBI=;
 b=PwuuNT+cm3Xvtd5wLFJUlADCQ8oKCrhwC2sUVd/lnDJSEh0ZIp34CAXv8ca2JWYviw
 l9aPn12+MhseMN79oVWKQJvfUObSgnpsrZymBcsAHZx5Kncr8qMs+lVRZYhWFv4U4xtr
 ZmvPnm3xLgR15fOiG9VsLtzFn7ryAKb1aDRp3RvxhwRQtRHjHD6ydVZRuRDx71GJL4ET
 OTwwe7SURpj7iLBK1uR9L5SCwGn/KVpmiftd5XHygyKbLz/b559YoP+AhxYSpl5B5OLt
 URXE42NApE/Vd36cIb2vaHLaTN9iYQZMmd83tSuY7OmvZqHMF6Gn3yOZYAyKxioBE988
 XaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918857; x=1788523657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BtPDnFD/wNqPKqQoXYCdftNBV1h086F3eB74129TCBI=;
 b=e2MJsDxqHRSS76r9Zm0LVSgArczVOQjatH+DxTvEgTfbV5akqIyF888WB/McfnYwT7
 /HQz3xDDyyjqb2RLWbWAgtq/aufq7nv8ZvK5kuMsHX7fy9y0W9om9rNDBIrZnyimEH+S
 g6qBvrAAAxfxm/KCaF6VSocZ/hKse93H8eJHsTWM5GmGfX5khI9rwVuAyYwhl0HHaRPV
 V2I1ufatNaxeqA8cYmoBv2Wm4wxRKG7aaFS9hyCeSNvcmcJK+nue/qoRmU1YrmrY3Wi/
 x0EztEkqbfzdi5KnmiJO65YxDkhcVXmDkni4KdSKmY9YywdtWCIxxubCL0kNOwWJ2yzZ
 WiIw==
X-Gm-Message-State: AFuF++mzYZhJgzSmKy/od6+LqnHJR8j7LCLJRn0wo0NiShQ5KZkhg7gj
 e81Xfohlje/G2PYpdSitCH/H/EBZhl7vyYF2NbZPAtafuwVavYw2fv9vBOxdzq2u
X-Gm-Gg: AR+sD114cdNHADHyUfUGM1OdVOY7yRNDrYUeokO+hQZ9WFBAMt/yBf2c5c/5C1uZOFc
 xD4TAt9lk9j8qn/krXSimOPv0PptPWCKUqFJQS2/kNxLHo0c6vmQ5JYxihvKwl5mWxRVhnHBaZF
 KbyMDc6KfGS1/JHWl31nQGL70ERh/GUKXbHylkYC3i1JCAyqLiBtvYHFnZf8uYK4UDECzpcFKZv
 QRat5hV4YIgZoiwwNxtW0xPTzp3pl7nEitPnylRTQvM7kAnbkD+YIwSHQaS01iYD/pQAii6+Rer
 ZY5bOibnBoe2twKQOaGYljM+Js7iXQobmZjvQr6MI7cH8lm7e2WAvz/+hS/Ic/MwUZ1SVdoPHUR
 PwLUuy3dYitLlEJq9Ql/sxVeS2xjPp/aCNYkyH+ZbFEgdlRvH1y9y+Q3w6HcZI0fIr1whgXkRUw
 Skt2CAh0X9lyAcUMi3wz3Phj//gvnjTmj7DdGtRYF1p38kTW044TR6IG+5TUY3RJXTWqOSgrbxf
 xnXFZ4Cw3f10UEqUfyLsRRY
X-Received: by 2002:a17:907:6d29:b0:c1f:9cdb:9965 with SMTP id
 a640c23a62f3a-c2556fb8aa8mr391472566b.2.1787918857351; 
 Fri, 28 Aug 2026 05:07:37 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
Date: Fri, 28 Aug 2026 14:07:27 +0200
Message-ID: <20260828120729.25908-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120729.25908-1-timur.kristof@gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
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
index 4f4e56022c97..7c4e145ca0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -160,6 +160,10 @@ struct amdgpu_buffer_funcs {
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
+int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence);
+
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 0da54c335822..76f8765fb175 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1518,29 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1936,7 +1913,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
-	.reset = sdma_v5_0_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 5543e381dcca..e7f4b74f27b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1436,29 +1436,6 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1951,7 +1928,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
-	.reset = sdma_v5_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

