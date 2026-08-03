Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C76C5518F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125E210E6D8;
	Mon,  3 Aug 2026 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnV+YvIn";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3A310E6D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:18 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso402631266b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763396; x=1786368196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i0MGPPfjdDPR1lDATkMK/jYma9MEWaFiaZOP4VdIHsA=;
 b=PnV+YvInnUaAAHgGN/c2ZWBX0PDu9gotIOA1PIKNC+m3thl6NE2pwdim8YJooMHLV+
 IMrhrrqarwT/9VVMm2OQbkmUJ8pmXYcebPc0V2K44g1UVIeAYAQhn6mpGfUfr8lFKScs
 7wHdGOc7mehNJOJQ+LioSP53pJKwdaZFKqpCDD8IA8la3+CNl0Mi5PhRDVuxWqwig69h
 ASvE+WxJ9AIOs3yRcnwSFvveo64xcfxYiZat0z2FJL23ZWgm0lPchyhGduTZx2m0L3Yq
 kvtN14pW0UsXhBm116M1SsuPxUk/PbiBU6X+b/NP0ccAlj2UhrG8WVCr6PiA3s/KwlJE
 sWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763396; x=1786368196;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i0MGPPfjdDPR1lDATkMK/jYma9MEWaFiaZOP4VdIHsA=;
 b=NgJ0htojRPANOWpNTGjt28V67yFE5gmrnHxhRT1f8/TFDgxii3ZqUuk7TPc72Ufzzj
 8tK5RXM0IFCzs6zEgLYT3ETkCxQsyMNt7d681O81tKJ+eE6Pu+OWtiWjpXrg9EcskXgQ
 ek2ydNyOvJa0MT5VYznOPLGSgddhNhVIPd+4irktmmoCkX3dWnoTRYXk8G1y1gj7gNXj
 c+WOu7yx+zDHrzUNLgZtxzyZroMzlCViL/Pcugf/oK8DcwSzwnIv/bpmaObV90rpVtxD
 hQtQ4S6HObpKHIL/6U6kIkxRwwtN11328kOzYz1rJ6PvHHxhXrIbPbePqX4XiLE2b/Le
 ph/A==
X-Gm-Message-State: AOJu0YxfOyY43db5QQ271O4q4aleo41POnafh+VVX6M7gwqpmuFkJdtv
 focKLOlVvtHgnU+bSezVl6PLEZqCgaKa/J+N8ypTtY2I0Yj31HCgMz6FSZJzwMna
X-Gm-Gg: AR+sD13l4VhNvKSEOqMU4BOOHJnaiPQsCoNDLhw+hRYcJ5cJ/+CLDkjRWMSkzo0z49u
 Reu8GrO3XbykuZs3f4nwsrgCDUf9Jd08tKKlVZmQhY28XrJHM2ywkJxO3tlGcfOuGHNm1afAv/h
 HCcSDMnCImVQy8+l8fuDpZ9697eDM/xsM6RAK8L5lW82i/51an0CF1bzplBErpN5mLcEFp9Pj0R
 a9IHLqMGQmfQnRfof3KX69TYT8xqWlHqEkWEtCbJM4XyjnJCZQPuSQPz22Tx5oahtsIXobiAxYN
 S+z103ykaccH4So6NcvUwLtuaLVa0eeuTxTlPRm0L7IHuY6GGYhtpgz87Glc4JtzcuQXalIlEU8
 o3eBznde6jnykKXQgwTJFIVq+YeaglNjnvD+JUX4pseF1VfQskC0IiCtV6fhNoqcoT42pk+YIAH
 +LyL369tfJ87Z9O9PqKhvM4HQoecj3Ala8AUttVnSkiaLlkYJ+rIaNHa0uU4UQ7j57vy3OMP67+
 9QP+LLUPlXjho+t0Jc1HsLXhGNaYiQ=
X-Received: by 2002:a17:907:d08:b0:c20:1c9c:b36f with SMTP id
 a640c23a62f3a-c201c9cbabcmr136456966b.8.1785763396179; 
 Mon, 03 Aug 2026 06:23:16 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/10] drm/amdgpu/gfx6: Initialize compute rings before CP
 start
Date: Mon,  3 Aug 2026 15:23:03 +0200
Message-ID: <20260803132309.36326-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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
index 9b18ddcd597b..cd8a34d87c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2129,12 +2129,24 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
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
@@ -2174,12 +2186,69 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
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
 
@@ -2224,66 +2293,6 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
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
@@ -2333,9 +2342,6 @@ static int gfx_v6_0_cp_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = gfx_v6_0_cp_gfx_resume(adev);
-	if (r)
-		return r;
-	r = gfx_v6_0_cp_compute_resume(adev);
 	if (r)
 		return r;
 
-- 
2.55.0

