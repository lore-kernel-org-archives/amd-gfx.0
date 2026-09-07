Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BC8C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7EA10E909;
	Mon,  7 Sep 2026 20:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpLaotJi";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95A110E909
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:34 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso4031429f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813213; x=1789418013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hB6KNyK2BH5CvAmTa5nQ78XUdMlOO/Yk3joK5nQWxqw=;
 b=RpLaotJiaMoox1lF+l0faRCX2TZ+K3qKIPP0AwfatI54Hlj4WVOMlUFuo5xFSEMm+T
 tMseH9zeW5OoJ7wOXwPUBI280h71WSSGOQo36/GO0+CQfKECiEYN8bHZQXtnC3CxAxiy
 NE5jC4UGPu3AiVSup4ObXYZ3Gmx+Q4ujb3v72SzFnT03fmAI3GvXqXMwjf3AyKyMy7Wg
 hqQIBewAy7ybyhqD5M2lNDDJbNqzSNsUJfEMeWeeLZMztIgmBwievvF9ZZixYACJNpFK
 XhDmNAlmxfttZ6L8cGwQE3G2WzZrlcE9VLzgBLzg+37WzIzfzgf08Y0fD0RLJA0l8C+K
 C0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813213; x=1789418013;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hB6KNyK2BH5CvAmTa5nQ78XUdMlOO/Yk3joK5nQWxqw=;
 b=iDop1vHutFtBi0R4ip4ngngWE1V3fbqmdcc3fmmnO8IesZV1S0s3y+PCOND4aZX00h
 sbEx6Y6g5Tm4rERZAqHbJ7Ku8X4nNZzRjl81todVC6GAnyr1EsyCKfm6NVbjc3xsCjFk
 FrxJXMhZaMQ8DftTMPXfHIYq832HQ4EtjQCfmTptFgLpOZ7TEp3omZrkLiIqd/lduEnQ
 9i3jJ06/eztIJW4NOG13jy5OZ+NTRwH8dLuCV8FNpN8ywLklxRAqV6efgMe4rMySv+vH
 cOuhaSSlncDf7u+jw1CJ2wE4Q0Qhg7f5QRUwzHGl9OOlaeFmA+xl93gNsrjVVls2RXj5
 BQZg==
X-Gm-Message-State: AFuF++l7pvUXqnOkv4XfwBpR+Czf1ij80t8h/c2zAyq/bjkcW91O8WJU
 8MDxAsa/VzHdUZHMjn8A1wJMP8Inam/wv/JvBLOCBU5LlMP9tAhfQZ+dKBDsivg9
X-Gm-Gg: AYBFou0CX2B9+8FIB1nx14Z2Q+1F/2HpSvLValxgDSD2NE+CU0nQDEd3w0TKa4++7QK
 0wNvkDF5NK9c1l8sw70Gy6YkD0JhxTXzDAmVVfkhYx+vcSWbO3Gvw6LOBFCMFQY/xqwCksoN1o2
 hr9mmVj4NcggGLRsWMvjOLQcrgHvblRuO3EOj52XVhnE52c+pJDMoyy6KvDL6JaGYiFNOkPDE5S
 q0zkcbjZZpFSd67qFueAfTBG3xCq66oKBOIWAREo/J3/LPuT6zyT+ay0LV7XO0NeOgIZv5JvFtK
 0rtfJxCo6ziz3ojUt0YAuMVk+0hqInUKFXXrKy50Efa4HeiLg1azALzWkMC8ovZKWj/Gp5WJ7Cy
 8Cp8wXnC6bPQJmp4Kw0Pd0fDW91ba5l1OAv6bQq6mlMEVZBRLf9Kc1/gwPkQ3wYSgppAe1AR10i
 t1NVvrfraVMtOj4bM3P4D+NTw8KhJ76WmF7bN0GA8w7jKuUmYhCcfMYc3F+UDz8ZtryQaOAtXjW
 zpXJmKpmKN95PONfduB
X-Received: by 2002:a5d:6f1e:0:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-4858c166129mr23566552f8f.42.1788813213163; 
 Mon, 07 Sep 2026 13:33:33 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/12] drm/amdgpu/sdma: Refactor SI DMA functions to be per
 instance
Date: Mon,  7 Sep 2026 22:33:05 +0200
Message-ID: <20260907203316.159103-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203316.159103-1-timur.kristof@gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
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

This prepares the code for implementing recovery for SI DMA.

Reorganize the SI DMA code so that the functions that are
responsible for managing the DMA engines take an instance ID
as an argument.

This makes it possible to manage the two DMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 97 ++++++++++++++---------------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 31ab701d45d3..483a0cfb7c8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -125,74 +125,64 @@ static void si_dma_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 	amdgpu_ring_write(ring, DMA_PACKET(DMA_PACKET_TRAP, 0, 0, 0, 0));
 }
 
-static void si_dma_stop(struct amdgpu_device *adev)
+static void si_dma_stop(struct amdgpu_device *adev, const u32 instance_id)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl;
-	unsigned i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		/* dma0 */
-		rb_cntl = RREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i]);
-		rb_cntl &= ~DMA_GFX_RB_CNTL__RB_ENABLE_MASK;
-		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
-	}
+	rb_cntl = RREG32(mmDMA_GFX_RB_CNTL + reg_offset);
+	rb_cntl &= ~DMA_GFX_RB_CNTL__RB_ENABLE_MASK;
+	WREG32(mmDMA_GFX_RB_CNTL + reg_offset, rb_cntl);
 }
 
-static int si_dma_start(struct amdgpu_device *adev)
+static int si_dma_start(struct amdgpu_device *adev, const u32 instance_id)
 {
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl, dma_cntl, ib_cntl, rb_bufsz;
-	int i, r;
 	uint64_t rptr_addr;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-
-		WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+	WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + reg_offset, 0);
+	WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + reg_offset, 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = rb_bufsz << 1;
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = rb_bufsz << 1;
 #ifdef __BIG_ENDIAN
-		rb_cntl |= DMA_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK | DMA_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK;
+	rb_cntl |= DMA_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK |
+		   DMA_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK;
 #endif
-		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
+	WREG32(mmDMA_GFX_RB_CNTL + reg_offset, rb_cntl);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32(mmDMA_GFX_RB_RPTR + sdma_offsets[i], 0);
-		WREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[i], 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32(mmDMA_GFX_RB_RPTR + reg_offset, 0);
+	WREG32(mmDMA_GFX_RB_WPTR + reg_offset, 0);
 
-		rptr_addr = ring->rptr_gpu_addr;
+	rptr_addr = ring->rptr_gpu_addr;
 
-		WREG32(mmDMA_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i], lower_32_bits(rptr_addr));
-		WREG32(mmDMA_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i], upper_32_bits(rptr_addr) & 0xFF);
+	WREG32(mmDMA_GFX_RB_RPTR_ADDR_LO + reg_offset, lower_32_bits(rptr_addr));
+	WREG32(mmDMA_GFX_RB_RPTR_ADDR_HI + reg_offset, upper_32_bits(rptr_addr) & 0xFF);
 
-		rb_cntl |= DMA_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
+	rb_cntl |= DMA_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
 
-		WREG32(mmDMA_GFX_RB_BASE + sdma_offsets[i], ring->gpu_addr >> 8);
+	WREG32(mmDMA_GFX_RB_BASE + reg_offset, ring->gpu_addr >> 8);
 
-		/* enable DMA IBs */
-		ib_cntl = DMA_GFX_IB_CNTL__IB_ENABLE_MASK | DMA_GFX_IB_CNTL__CMD_VMID_FORCE_MASK;
+	/* enable DMA IBs */
+	ib_cntl = DMA_GFX_IB_CNTL__IB_ENABLE_MASK | DMA_GFX_IB_CNTL__CMD_VMID_FORCE_MASK;
 #ifdef __BIG_ENDIAN
-		ib_cntl |= DMA_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK;
+	ib_cntl |= DMA_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK;
 #endif
-		WREG32(mmDMA_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-
-		dma_cntl = RREG32(mmDMA_CNTL + sdma_offsets[i]);
-		dma_cntl &= ~DMA_CNTL__CTXEMPTY_INT_ENABLE_MASK;
-		WREG32(mmDMA_CNTL + sdma_offsets[i], dma_cntl);
+	WREG32(mmDMA_GFX_IB_CNTL + reg_offset, ib_cntl);
 
-		ring->wptr = 0;
-		WREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
-		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_GFX_RB_CNTL__RB_ENABLE_MASK);
+	dma_cntl = RREG32(mmDMA_CNTL + reg_offset);
+	dma_cntl &= ~DMA_CNTL__CTXEMPTY_INT_ENABLE_MASK;
+	WREG32(mmDMA_CNTL + reg_offset, dma_cntl);
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	ring->wptr = 0;
+	WREG32(mmDMA_GFX_RB_WPTR + reg_offset, ring->wptr << 2);
+	WREG32(mmDMA_GFX_RB_CNTL + reg_offset, rb_cntl | DMA_GFX_RB_CNTL__RB_ENABLE_MASK);
 
-	return 0;
+	return amdgpu_ring_test_helper(ring);
 }
 
 /**
@@ -548,11 +538,14 @@ static int si_dma_sw_fini(struct amdgpu_ip_block *ip_block)
 static int si_dma_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r;
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		r = si_dma_start(adev, i);
+		if (r)
+			return r;
+	}
 
-	r = si_dma_start(adev);
-	if (r)
-		return r;
 	si_dma_set_buffer_funcs(adev);
 
 	return 0;
@@ -560,7 +553,11 @@ static int si_dma_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int si_dma_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	si_dma_stop(ip_block->adev);
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; ++i)
+		si_dma_stop(adev, i);
 
 	return 0;
 }
-- 
2.55.0

