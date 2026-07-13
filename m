Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B4C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D632810E5FC;
	Mon, 13 Jul 2026 12:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IhejRE4+";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07C210E5FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:54 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso3057197f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947533; x=1784552333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oJOb6BAC0cez3rS5MVtUh5rneKdBGYJmpPGOArzVMYo=;
 b=IhejRE4+hsZlkvNs2rc7QNtuEHBR/N73veuTMCRFXVgyWDf+6QqJdRA+J/o4pCqkAt
 bOTDb8lfibuve2x50IIj2cNE5hUyhmEM3TFG6MKs+BPXV/lKMw/Ydp6qxVPcp3RF+ISR
 3hJyHTSCTMStLVfXqH0lbUoQ32Mz2Jry1L70DhSRV72VOWhHGT6pBX+ahNzDHk0Bnk/W
 /lQSt+uDX26eMee51O3NQf+gO14BR5mp2wbHiPjXbsv/JUATanb58LNNoXirfgT/UkUb
 1yYItkZqJkxqqoNthlUuxTPJp5G5E7+g2gSOoJyee8RVh3M3vjPFK2zwNxr+JZRTE0rx
 4OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947533; x=1784552333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oJOb6BAC0cez3rS5MVtUh5rneKdBGYJmpPGOArzVMYo=;
 b=dbGUgUrXQmyvBEK8Ytryrtsa8SfExtGUXDb7BNDbfgFU3WrLAB5Ym8pYJrqmN0x9PZ
 /WmLI5QpDRD2Ew5pIsgVoQt19fK42tSbMy8p4a6or+TXX578K3Kbbve6EzAdeqGX0tLI
 Z4EFuDI6nUS4XBEmxBnAC1umGObIbYw7coyyicXZN2lBK8tMZjiw0B3OK+frlG2q2Qb1
 DHQ0qQjQousRvHUbt2PiF2W0QvShPMNqdIxxAzgjdRxYPAx0PTRI9Yobgp+eXDndvdr1
 i6O77Q48lqbc5L1gMVQW3vMA/i1KuVPzbv8yoto32E8FBf06rz7NHGl4DPMiI97NkO9D
 yi7w==
X-Gm-Message-State: AOJu0YwwBxHLWIQLsBedFuB0xsQUXj37cGOooJgY38Hg3+gSf21L1mRM
 6wMKT1pMbe1ndFwUon6cTUV+Jq6D+3cN/rD2yew0fsOlRWhW5LTXyTacgpxGnA==
X-Gm-Gg: AfdE7ck8RHcAskxFnnI9r8wPO5a4Cv1isqp87B43022XJiwxGWM6j3CoU7+u3H28asU
 22SZyPMaBWfFuD7g6no/0VN4gnH3zA+OZGxeiTTpSy8P7oQZqjwmTPD2VktDn+I2fn3H6fwcJba
 Wp+eQwHpH2UffzG5Z78JFx/vQ3E/R+XCq/I3NEmILg8rJRo/7rmUd23pXfZcsWV/nQsT31z8Ug8
 lcPSgXKRj83OIDFYr49Cw2aCJqnpNAazooZYRx+n34odl02kyLODR8kO6TRQoZCkB41WhyQKLBm
 HOgT70Rkyz7fWg51cWXlOdpIyJ7w1LeMEOHgUEBKF37KPKFrNOaUrUVzxTgLH/Grd3Qda1LO4xJ
 PBJKEeyIJ5NQ6188DjZmdzOye9g3XSkkZiF2cbr47Qhtenv66bxVlgOoqfz9qB6qc9Vuy4ucU29
 Of19AVt8+S7eNC6QegNYTT9sx/8O09p84BHGEWWN/LB/TEm7FD2FkaV6uB9cRPxF4j
X-Received: by 2002:a5d:64ee:0:b0:47d:e549:38d3 with SMTP id
 ffacd0b85a97d-47f2dca7e69mr9416703f8f.8.1783947532978; 
 Mon, 13 Jul 2026 05:58:52 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/9] drm/amdgpu/gfx7: Clean up gfx ring during reset
Date: Mon, 13 Jul 2026 14:58:35 +0200
Message-ID: <20260713125838.30607-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index a93cc02c3400..915612628f9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2546,8 +2546,14 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
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
 #ifdef __BIG_ENDIAN
@@ -2559,6 +2565,7 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
 	ring->wptr = 0;
 	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
+	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
 
 	/* set the wb address whether it's enabled or not */
 	rptr_addr = ring->rptr_gpu_addr;
-- 
2.55.0

