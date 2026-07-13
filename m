Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660ACC44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F127A10E997;
	Mon, 13 Jul 2026 13:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Px5PR2IJ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A04B10E997
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:25 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso26182275e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948043; x=1784552843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fi+qZ27EGhlGeX8OvNNhvS1DU7am8zudakOt4o7oCgM=;
 b=Px5PR2IJoCpil4bSyTUAj0FaizV7UcNMCt9iLjk7lPUmFs+iNCeF6Rw85Uj/QI8C5W
 +dWI0kefQTRqPxSBNxD/9InzuLosWMYp+J8iW3a+xkpMeZO6R6jtGc2H66EVQGpbBAil
 Dj70cHLV8pLPOAsaUV+VuMC8MIeyPLQQ5QoDumpn6QI12MktLuhZnULpk+hmt8PC8VuM
 NcJbQBnCrG3wIQVgnvR7S0dp6NUzJJpHC9B2oZb3PWS1wreZsxALEUyHBRlNMWAp2yol
 IP2L8liD0tohGOq7BQT6x3fRCbGZ5vJBCtdXbnx+BrBd9DslQC/RMisGhow7xlfJmVhB
 Lhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948043; x=1784552843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fi+qZ27EGhlGeX8OvNNhvS1DU7am8zudakOt4o7oCgM=;
 b=oEKP0WiFq9LAwSx4FtHO7VuuFk4BuxQNvwjqeA2LwJ4ZORgJuDj5JrxAWA9632w1dj
 yvPTG5fw2e0e2bm2gY5pAJMbGWKpkyMirie7RHq1zUrxk2Anafl9yhmAxXtIjqXO0DFZ
 4+UkrH7uOh5LiRyAtRcCjphEnmSye2cVct4bFI7aFRu+A7FpPhh2nANzOW/1YCCzTcFF
 iUpn1fHcrLGLuDAhvUJPfdZPIUju9237oot7MrPfNLEGp2qTz1FZLX5YhhUJ7FShP7HP
 IQvdp2FtJkTdzeJVYfqn43mYa0JavJskXviodfhbt9Mn9b+53MzPzDcR2dY88WUmczTs
 0Jkg==
X-Gm-Message-State: AOJu0YzMZdWH35A2fBS3wAb8SLLxU5VMZ/6lf1SdJxlK53478vAM5UGe
 V4lhRIsrwnrhuZDiCyvp3phSBQw3WE6c7j63MJVa23v/0GGMgzNc/pspHRZ0lg==
X-Gm-Gg: AfdE7clBDqrO5ryN3mnQIKfO1Gip2gg3c4IiFs0XFhK2tAvTNwcns4Ol1JLOqkosmeY
 jNfSOQHlFA71hf8ICZgDdXZgH9So+Z9e/yuwvJCyu9Lqu543YGqvtrQY5uAqN4nqO+ngsFXdNQT
 dUJY/PtNKnq35CiUBTQPbkaQvLnGOtrqP3ry017VO77xKlPy2Zed7qV4H3IOT4OKH+R00EAQr86
 0kM1xMx7rZDysk76z/3I65H2nIsRE0lYnE3p8c0c/WameDA+SXLeTwZ6Hvmg6gOEDz0l6hQiRAJ
 h9u7Oy1pXvbG/3R1cFhepEw4pmkgSB1Knb9WtCfD9LhuaGKJROD5UFkRq07Mek+Xbpwk334oX4z
 kuILp8VTwK1n7ryJUocMfFkvZZMhIrXfgos91ttCAKsg1L+lp4RRe5kRsgc5F9Wn+2wVp+cFnYz
 8oZcTb+Eo8G536+oQgR32YXSUwivmJw7bkUFEd0NYACwTnwLiOUA//oA==
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-493f884f5f2mr88524085e9.37.1783948043270; 
 Mon, 13 Jul 2026 06:07:23 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/11] drm/amdgpu/gfx6: Initialize compute rings before CP
 start
Date: Mon, 13 Jul 2026 15:07:02 +0200
Message-ID: <20260713130709.34262-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713130709.34262-1-timur.kristof@gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
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

In GFX6 GPUs, compute takes the same CP path as graphics.
CP ME command parser executes packets for each ring buffer:
RB0 supports graphics, RB1 and RB2 are compute only.
Initialize all three rings before calling gfx_v6_0_cp_gfx_start()
to make sure they are all in a sane state before execution starts.

Previously, the two compute-only rings were initialized after
the ME had been already started, which could cause the ME to
start executing the ring contents before the rings could be
properly initialized. This happens to work when the HW is first
initialized, but not during an IP block reset where we want
to reinitialize the compute rings before starting the ME
to prevent it from executing garbage from these rings.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 134 ++++++++++++++------------
 1 file changed, 70 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 8e8e5fe487f5..ca6a62e822b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2128,12 +2128,24 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * gfx_v6_0_cp_gfx_resume() - Initialize CP rings
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * In GFX6 GPUs, compute takes the same CP path as graphics.
+ * CP ME command parser executes packets for each ring buffer:
+ * RB0 supports graphics, RB1 and RB2 are compute only.
+ * Initialize all three rings before calling gfx_v6_0_cp_gfx_start()
+ * to make sure they are all in a sane state before execution starts.
+ */
 static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 	u32 tmp;
 	u32 rb_bufsz;
 	int r;
+	int i;
 	u64 rptr_addr;
 
 	WREG32(mmCP_SEM_WAIT_TIMER, 0x0);
@@ -2173,12 +2185,69 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 	WREG32(mmCP_RB0_BASE, ring->gpu_addr >> 8);
 
+	/* ring 1  - compute only */
+	if (adev->gfx.num_compute_rings >= 1) {
+		ring = &adev->gfx.compute_ring[0];
+
+		rb_bufsz = order_base_2(ring->ring_size / 8);
+		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
+#ifdef __BIG_ENDIAN
+		tmp |= BUF_SWAP_32BIT;
+#endif
+		WREG32(mmCP_RB1_CNTL, tmp);
+
+		WREG32(mmCP_RB1_CNTL, tmp | CP_RB1_CNTL__RB_RPTR_WR_ENA_MASK);
+		ring->wptr = 0;
+		WREG32(mmCP_RB1_WPTR, ring->wptr);
+
+		rptr_addr = ring->rptr_gpu_addr;
+		WREG32(mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
+		WREG32(mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
+
+		mdelay(1);
+		WREG32(mmCP_RB1_CNTL, tmp);
+		WREG32(mmCP_RB1_BASE, ring->gpu_addr >> 8);
+	}
+
+	/* ring 2 - compute only */
+	if (adev->gfx.num_compute_rings >= 2) {
+		ring = &adev->gfx.compute_ring[1];
+
+		rb_bufsz = order_base_2(ring->ring_size / 8);
+		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
+#ifdef __BIG_ENDIAN
+		tmp |= BUF_SWAP_32BIT;
+#endif
+		WREG32(mmCP_RB2_CNTL, tmp);
+
+		WREG32(mmCP_RB2_CNTL, tmp | CP_RB2_CNTL__RB_RPTR_WR_ENA_MASK);
+		ring->wptr = 0;
+		WREG32(mmCP_RB2_WPTR, ring->wptr);
+		rptr_addr = ring->rptr_gpu_addr;
+		WREG32(mmCP_RB2_RPTR_ADDR, lower_32_bits(rptr_addr));
+		WREG32(mmCP_RB2_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
+
+		mdelay(1);
+		WREG32(mmCP_RB2_CNTL, tmp);
+		WREG32(mmCP_RB2_BASE, ring->gpu_addr >> 8);
+	}
+
 	/* start the rings */
 	gfx_v6_0_cp_gfx_start(adev);
-	r = amdgpu_ring_test_helper(ring);
+
+	/* Wait for the initial packets to finish, run gfx ring test */
+	r = amdgpu_ring_test_helper(&adev->gfx.gfx_ring[0]);
 	if (r)
 		return r;
 
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
@@ -2225,66 +2294,6 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 }
 
-static int gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	u32 tmp;
-	u32 rb_bufsz;
-	int i, r;
-	u64 rptr_addr;
-
-	/* ring1  - compute only */
-	/* Set ring buffer size */
-
-	ring = &adev->gfx.compute_ring[0];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
-#ifdef __BIG_ENDIAN
-	tmp |= BUF_SWAP_32BIT;
-#endif
-	WREG32(mmCP_RB1_CNTL, tmp);
-
-	WREG32(mmCP_RB1_CNTL, tmp | CP_RB1_CNTL__RB_RPTR_WR_ENA_MASK);
-	ring->wptr = 0;
-	WREG32(mmCP_RB1_WPTR, ring->wptr);
-
-	rptr_addr = ring->rptr_gpu_addr;
-	WREG32(mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32(mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
-
-	mdelay(1);
-	WREG32(mmCP_RB1_CNTL, tmp);
-	WREG32(mmCP_RB1_BASE, ring->gpu_addr >> 8);
-
-	ring = &adev->gfx.compute_ring[1];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
-#ifdef __BIG_ENDIAN
-	tmp |= BUF_SWAP_32BIT;
-#endif
-	WREG32(mmCP_RB2_CNTL, tmp);
-
-	WREG32(mmCP_RB2_CNTL, tmp | CP_RB2_CNTL__RB_RPTR_WR_ENA_MASK);
-	ring->wptr = 0;
-	WREG32(mmCP_RB2_WPTR, ring->wptr);
-	rptr_addr = ring->rptr_gpu_addr;
-	WREG32(mmCP_RB2_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32(mmCP_RB2_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
-
-	mdelay(1);
-	WREG32(mmCP_RB2_CNTL, tmp);
-	WREG32(mmCP_RB2_BASE, ring->gpu_addr >> 8);
-
-
-	for (i = 0; i < 2; i++) {
-		r = amdgpu_ring_test_helper(&adev->gfx.compute_ring[i]);
-		if (r)
-			return r;
-	}
-
-	return 0;
-}
-
 static void gfx_v6_0_cp_enable(struct amdgpu_device *adev, bool enable)
 {
 	gfx_v6_0_cp_gfx_enable(adev, enable);
@@ -2334,9 +2343,6 @@ static int gfx_v6_0_cp_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = gfx_v6_0_cp_gfx_resume(adev);
-	if (r)
-		return r;
-	r = gfx_v6_0_cp_compute_resume(adev);
 	if (r)
 		return r;
 
-- 
2.55.0

