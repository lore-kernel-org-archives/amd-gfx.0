Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5638C55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD0810E5FA;
	Mon,  3 Aug 2026 13:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNnu5Jxx";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C43310E6D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:19 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c1c4db7ca93so448007666b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763397; x=1786368197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ipu0clXnQTY0zLZbPjyEqrOwnNF9ZwWn6BUJXkR4kGE=;
 b=aNnu5JxxlfO3LpiiAeGw9UPXkK59sFo2WzxdQTC+i6lxCH3u79ljk3nOi4QGsvLGxZ
 VwmwUWKkcjXvGG03plkR7B93qBp5h50jrALi4EWQ0AkO9oOjYB2cjO/K7q26l53JP795
 Xr+UpfbS6F9nI03QWEMyzpFsz9jYoxVzOwxc2WDcaqSwo44eJ4rS0nk1JSAAH6+AtK7P
 9BEvCHaaCtqdGE8onHDZXX5/dl8kh4gWDLyV3sYoj81d+2WxljNZlplO8TsmBw0zxXh3
 8e7dh9L0HP4JqNbQlLtJmotTIQ8uv9NxEuF2vEQGzpXMFnz6zed9bW/nynyLv2/Qieeb
 3EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763397; x=1786368197;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ipu0clXnQTY0zLZbPjyEqrOwnNF9ZwWn6BUJXkR4kGE=;
 b=tRH+SJiuiS4ZGfscC9KzSx81FPaw1tPsl1Cp+g5uNcRbdeq1Fq2kRtZ5IqqCtjHucy
 xcvu4y7KkzvqPgQRT8gCudLTgxqHMNDeXkjFuwDwHybpov3ETspa+929ZRkhhoJMYABq
 TRHtNWL7ODwVSJB0LqS/1fCw7qvMWNdgwgAbgMTNyWuaOTRkFJCHoNwUl6c0HziP5s/a
 UR/AbRUfLB2ysNYUDF/3uLm1jaqol3jTpTxjCq72lz7tw1IM8sW01ojFfDeXbfIxFDa5
 HSoxl62kiXP6EfVGYiGdodfcaNd+navRqQGPpiNjH+9cviMx7Td5bABvpqNfmXxJoHfq
 Y4+Q==
X-Gm-Message-State: AOJu0YzpBC5gQZm3nava/ItoVWc9XiYm4tDyWp2pDFVnYbqqiI82u7kD
 2pOLUNL0EoAFLXJrsNxslHOBJnFY6eKXjLRT3E0aPjF2wPwuPy1tHIZENDL6unqK
X-Gm-Gg: AR+sD13YkEUE9tA/XIH8D8uknH5JliGyZJHgRjQVWxT6rjTx17znJl9CfJvPPlCO89T
 5KywMWjPmwl3+McuWlvQ6dDh9o5jL9MgqbYy8dUyyguTa/TQ25oiPJc4g+AzNiLAg5sMpErWV33
 NyrIlJDPa0/QVv+ErQA7RU/Sv234jFiMr7p0LQ+XjNBfGANKy7e3kBZTEW7EYON+Z2FHgXrKGmX
 1Ls4DdzRltWEL92y3qiRLnItNnb4IfZ08V7va2Er0O/LENEiUFkrQEjtIa0XmQYYDveFutbnm+Y
 LTXURdkHyL8U1eik33TXMmQVCT7qgEYkRKhVBF61kZNNTsQ0QM+V2ES+iTfvGtxA0BEEVtZezqp
 ZdTpGrECUB5uV20+qaIDVWkMxOINkxGV1OnvxASSa+3f3vXbjHeEyVx5BNk2FJwuWEw9go80OLT
 XfD3FrTXD39e7VOuYMDeVxWv3bd3KnQ8gzSgMgQlrAb9RChEf+ucfmdpYauMwDiH7WDsRzjFSDk
 ZuH663YWCrz/6/iHDHOoJ9KyKqCWHY=
X-Received: by 2002:a17:906:38c7:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c1fe7f389ccmr573770666b.18.1785763397421; 
 Mon, 03 Aug 2026 06:23:17 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/10] drm/amdgpu/gfx6: Clean up rings during reset
Date: Mon,  3 Aug 2026 15:23:04 +0200
Message-ID: <20260803132309.36326-6-timur.kristof@gmail.com>
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

Clear the WPTR and RPTR at ring initialization.
Additionally clear the ring contents too.
This is necessary so that the IP block soft reset can
bring the rings back to a clean state.

After a reset, the ring contents could contain packets
emitted before the reset, and thus need to be cleared
to prevent the command processor from executing packets
left over in the ring from before the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index cd8a34d87c6d..ce63417ae17e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2159,8 +2159,12 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmSCRATCH_ADDR, 0);
 
 	/* ring 0 - compute and gfx */
-	/* Set ring buffer size */
 	ring = &adev->gfx.gfx_ring[0];
+	*ring->wptr_cpu_addr = 0;
+	*ring->rptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	/* Set ring buffer size */
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
 
@@ -2172,7 +2176,8 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* Initialize the ring buffer's read and write pointers */
 	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
 	ring->wptr = 0;
-	WREG32(mmCP_RB0_WPTR, ring->wptr);
+	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
+	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
 
 	/* set the wb address whether it's enabled or not */
 	rptr_addr = ring->rptr_gpu_addr;
@@ -2189,6 +2194,9 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* ring 1  - compute only */
 	if (adev->gfx.num_compute_rings >= 1) {
 		ring = &adev->gfx.compute_ring[0];
+		*ring->wptr_cpu_addr = 0;
+		*ring->rptr_cpu_addr = 0;
+		amdgpu_ring_clear_ring(ring);
 
 		rb_bufsz = order_base_2(ring->ring_size / 8);
 		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
@@ -2199,7 +2207,8 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 		WREG32(mmCP_RB1_CNTL, tmp | CP_RB1_CNTL__RB_RPTR_WR_ENA_MASK);
 		ring->wptr = 0;
-		WREG32(mmCP_RB1_WPTR, ring->wptr);
+		WREG32(mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
+		WREG32(mmCP_RB1_RPTR, lower_32_bits(ring->wptr));
 
 		rptr_addr = ring->rptr_gpu_addr;
 		WREG32(mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
@@ -2213,6 +2222,9 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* ring 2 - compute only */
 	if (adev->gfx.num_compute_rings >= 2) {
 		ring = &adev->gfx.compute_ring[1];
+		*ring->wptr_cpu_addr = 0;
+		*ring->rptr_cpu_addr = 0;
+		amdgpu_ring_clear_ring(ring);
 
 		rb_bufsz = order_base_2(ring->ring_size / 8);
 		tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE / 8) << 8) | rb_bufsz;
@@ -2223,7 +2235,9 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
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

