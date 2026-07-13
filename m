Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B2C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D28110E999;
	Mon, 13 Jul 2026 13:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dZhJqdMn";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB1210E999
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:27 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso26182595e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948046; x=1784552846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3g26arxWsWD3zIS+EWpmbSbi7VOpUOWc1XLDfoFHcaY=;
 b=dZhJqdMnz3tnDt7m+gCdN2Ob4fogb+PZcTyIgazN0wA+CPQopmHF8gyMdxb8sQpje5
 jut8qENQfsoWBCSza0QZb+X8aB+0Vj262+wHTgrtEXuKhmU0Dr0ZU+eMe25b4eP/Svz1
 fm/Wi63dWidK0GCkw5+Fdd87jiOZxn+Kjw1yLqCIDei1o+fSuYIi9VBw5h8DG5YCzGOW
 XZAOx8n35c9X50i8tXPMjfEiyk165SyqpZDsUpWYRTZQ6Hk21h7Fvg9XUS30MNxxf6Fx
 zfM5Ms16N6m8iaTROb8nAVInG+krjdtHtgSLSbuYBB1VMw12sl8WG4PDWVm/k0e82kCQ
 +XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948046; x=1784552846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3g26arxWsWD3zIS+EWpmbSbi7VOpUOWc1XLDfoFHcaY=;
 b=FcoSQvRYGHADOA8iM/CsZiDnJTLg8gxALMqD6wmsYW5lJ7QEDX/i5dZXPs2xzUwy7U
 N6lkNHKYgL7SIUZlcuu35CmuGTQaSlKpdZCLq6AdaczvJLzefwyo9WMe/kDbH/xs9zS2
 8gh6gJpY8pmUjkUviE3rB6ed56e1BuSFlIUnYSYLQ85SBQZbWIMOb9tmld7skeUm1m9o
 jtsQhHrW6HR/vHZo9TxHmfTQ2uSSGazIv0dsXAW1eBzWAmPftVGEagol45KkOFwNHc92
 KwMZAzNuXcfPBeDyFdQ52wwSIVQnVY0BFQs2J3IKB/3XqTZHPdBzRCxZA2jVZxszwDrm
 wj7g==
X-Gm-Message-State: AOJu0YxFGwtsnJ9YwgIwcl3nFbfMrqfHn4apsK0fyFogiVgPtnwB4iDK
 tIRzi9TO9LF88tniZVBWUdELaJKWwyn0woOfsGTPz4SJK9xAl+Z7DyHvNrkOEQ==
X-Gm-Gg: AfdE7cmbTq06Q2DUD11I+P51PbinMFzx36oWi68GVYqoC5KCQYEfQ7cXDKmOk5ePHHG
 PfA4kldANelDXXVaCEZMZ8ZoTeq/SunWhcszqxNhkSmU9m4qUNh1f8yVN3X5fxjKlcDkQALWass
 hXw12xlRKovgWvT9pMSbzv/GvPglDR3HxFNT0vX1e5VU4Yox5gnHkEg9nfDedKsFsSrG4PtstkS
 saCwK7U10HKyEzBRzRijgl94ii+TdfjhEr7VDB1JtdwX21l9o6hPeZ03oj/mbJr0mQ9oyDLpvoP
 AMVGcwoBvrEBHrB1hO4gXWLjh51x5aybdqv8+8QrzYJ13RITCdm8/YPR1FOWxSHukV+Y7PA89cC
 JB3oBxiLl0Si3f14ehtjBBETosOvhIcX8b8+FNvTdmAjsOWFSBRptL2vrVW5AvjfqWYno3qyZLC
 DbUtO6f6fUoY32TYeLlUPYEi8dnQURgf45viNlmlDijlswRinj2PFGpfsqfW6nuKGz
X-Received: by 2002:a05:600c:8284:b0:493:b647:1acd with SMTP id
 5b1f17b1804b1-493f8845b3amr99450355e9.36.1783948045457; 
 Mon, 13 Jul 2026 06:07:25 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/11] drm/amdgpu/gfx6: Clean up rings during reset
Date: Mon, 13 Jul 2026 15:07:03 +0200
Message-ID: <20260713130709.34262-6-timur.kristof@gmail.com>
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

Clear the WPTR and RPTR at ring initialization.
Additionally clear the ring contents during reset.

This is necessary so that the IP block soft reset can
bring the rings back to a clean state.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ca6a62e822b1..eeada89bb31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2158,8 +2158,14 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmSCRATCH_ADDR, 0);
 
 	/* ring 0 - compute and gfx */
-	/* Set ring buffer size */
 	ring = &adev->gfx.gfx_ring[0];
+	atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+	atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+
+	if (amdgpu_in_reset(adev))
+		amdgpu_ring_clear_ring(ring);
+
+	/* Set ring buffer size */
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
 
@@ -2171,7 +2177,8 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* Initialize the ring buffer's read and write pointers */
 	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
 	ring->wptr = 0;
-	WREG32(mmCP_RB0_WPTR, ring->wptr);
+	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
+	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
 
 	/* set the wb address whether it's enabled or not */
 	rptr_addr = ring->rptr_gpu_addr;
@@ -2188,6 +2195,11 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* ring 1  - compute only */
 	if (adev->gfx.num_compute_rings >= 1) {
 		ring = &adev->gfx.compute_ring[0];
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+
+		if (amdgpu_in_reset(adev))
+			amdgpu_ring_clear_ring(ring);
 
 		rb_bufsz = order_base_2(ring->ring_size / 8);
 		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
@@ -2198,7 +2210,8 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 		WREG32(mmCP_RB1_CNTL, tmp | CP_RB1_CNTL__RB_RPTR_WR_ENA_MASK);
 		ring->wptr = 0;
-		WREG32(mmCP_RB1_WPTR, ring->wptr);
+		WREG32(mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
+		WREG32(mmCP_RB1_RPTR, lower_32_bits(ring->wptr));
 
 		rptr_addr = ring->rptr_gpu_addr;
 		WREG32(mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
@@ -2212,6 +2225,11 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* ring 2 - compute only */
 	if (adev->gfx.num_compute_rings >= 2) {
 		ring = &adev->gfx.compute_ring[1];
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+
+		if (amdgpu_in_reset(adev))
+			amdgpu_ring_clear_ring(ring);
 
 		rb_bufsz = order_base_2(ring->ring_size / 8);
 		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
@@ -2222,7 +2240,9 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 		WREG32(mmCP_RB2_CNTL, tmp | CP_RB2_CNTL__RB_RPTR_WR_ENA_MASK);
 		ring->wptr = 0;
-		WREG32(mmCP_RB2_WPTR, ring->wptr);
+		WREG32(mmCP_RB2_WPTR, lower_32_bits(ring->wptr));
+		WREG32(mmCP_RB2_RPTR, lower_32_bits(ring->wptr));
+
 		rptr_addr = ring->rptr_gpu_addr;
 		WREG32(mmCP_RB2_RPTR_ADDR, lower_32_bits(rptr_addr));
 		WREG32(mmCP_RB2_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
-- 
2.55.0

