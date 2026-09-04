Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AF3C79F80
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD5C10F8CF;
	Fri,  4 Sep 2026 07:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IgIu8NvA";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3541C10F8CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:10 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso4966565e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506948; x=1789111748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LSAXZsRyGXh9uGU1fWvyeJUrYgfAcg4d/bXc8vVz4Eo=;
 b=IgIu8NvAB3lin1hB8nXamBfOZmWjxmcS4z0YWh2GqxJLTsJF4AwDVKgByOvAmveSB5
 tLufBXsBSTNtZfqLKXH+DJtdL4k1cHguUClLYTC12+UYfR49cx2JdQ8sx9omV2r+cOk9
 TQTSv1sJBHxGNx54BAdh60KjxVSKfafjuERGHwCtDC1bcrtbkZFm6YSpKRZFB8WTuGWz
 xuzmcl3qZxcGe6mijEafJGgjUuDXYAGkaLShiTnG9napdzO5Z9lTxUZ1Qa3Uk4m+Kw8K
 UNluv40vhpVqhWUALWYXMFKhxEGO3dbuFqGbHe7RzzttNsZd+T2LKxx9GGFuRYmXoezZ
 4QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506948; x=1789111748;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LSAXZsRyGXh9uGU1fWvyeJUrYgfAcg4d/bXc8vVz4Eo=;
 b=Ydjqsy5N0rSAmyvaB8OUZMmgjjfE0Q8s7n8/T3k8PGWjBhQaYLF4T+rc4DII8w8xov
 3GayrDrG3H5Ox82wtwBh2Dvi6trtYqv8NfMQ6Iiwd82g5Fep3beFypM/Z3ElHSRZcklC
 jrtoMg/dNhthfTWSp5eRKJ0L6T+Ya9PBAuADxi+Wo2L2pM8KfcO3Xim5JFpm9Xl06Tj7
 wcPAKXrmD2fPOQWFFaUh9yl2/N/qNBkHJ3N5OdZAR/gfnKrBjCDAUqxYRAoW2/1Jz3OW
 XxwRfRNH3j/wJszdFZAMatmSHBJOmEOWTCX7h5tQUznXI8aRqoPRFcKfFoiidSbdcaeO
 FowQ==
X-Gm-Message-State: AFuF++lxL3fF3yD1XcunHJkAN7p1L7SrTFCLZOGs0ZLgRC6BfzJ5Mj9w
 TyIR5xcDhH8wg6zHXnTlFYCB66/i2aEUJzEv7yIQwGCBMOiKqg7kmxUY9LbtLvcJVac=
X-Gm-Gg: AYBFou0X2QlIE0qSKPaH2rCVr0SFhJHthR36kvgK5fSBKyqjTNk6gwrz6MVPuyYI3+S
 hLXW+ihxUKpudprXJH94Fgbt8HhHAq+gd9VCAV1u6DSUWjHIdjHcicyInQAFOEXHs6cni4kHsbU
 kSdp4oID6TE/+F3Dk6qMj4HagO2Y3WhRN00iC2w6pvrL+fUqgeCGG/cD5oOTIbtI/kBWiOxocyg
 9vv0JJit/bqszBgheEoAjcOlmwrYlqEBwzRZMa41DQ3Pca8Fe3rJ//b+h/mzh0c9uJTF68SoZAd
 lOSYJjcR/AgwlLcKCDmofKdFwA+LdzhG3voLTy9RKnyeCA/AOzExes/7AWs2BYtVH/k2f6WLN8l
 JvovHO5K8wIvTGYgiPmTlw/cpcNsYdxYa/D5Zeum1LfDaZDWJDm8YnmwbvKozWFw+BQ8ZND97lQ
 memAaaoo8K8+uUtLchr0rIr3AVI5OwuMiYARRMMpoLxx4EdRptnyArA0YwLtSIKSUdTbL7qBumP
 so/h3xsOfkshIKt2Sz3
X-Received: by 2002:a05:600c:5493:b0:49b:8f18:714a with SMTP id
 5b1f17b1804b1-49cf824a6c5mr42518985e9.12.1788506948339; 
 Fri, 04 Sep 2026 00:29:08 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:29:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/8] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
Date: Fri,  4 Sep 2026 09:28:48 +0200
Message-ID: <20260904072850.321759-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904072850.321759-1-timur.kristof@gmail.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
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

