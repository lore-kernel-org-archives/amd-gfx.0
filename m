Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86378C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B6010E99A;
	Mon, 13 Jul 2026 13:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4V9AljO";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEED10E9A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso26183875e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948057; x=1784552857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nPfxjSC1WcSuFyZhTFxQyVNKwFVClld6ukssqan1UCA=;
 b=S4V9AljObT/lL+8sqhMA2qlSA4Z3o7zylP3RjV+QPIHVO1b0U18y576UgkN0yzzAYM
 6mREtW5dfNspQcfAq/aRZgloINji3o7R/K5FlMIB6GifPfqz8nayI5gM5hNlitBYy94v
 HbVziOAaC9vjnsJ/Zi1sPmI4RGFUo+SLVtCSx4ocbl2rbULhH/2edrzw28IsnfYyFK12
 aYuoVtcEQRklcNwgnXUeA6kegj85sJXoLIKgOifEzD/YWetOTQTz/pAvXvNrsMqDja8T
 TtRo8VA6g5fZzPO88bHiIAOHh586ryWkwCSDLmduu4wS2/eCcsHZ09R72O64tRkwUKKe
 dihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948057; x=1784552857;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPfxjSC1WcSuFyZhTFxQyVNKwFVClld6ukssqan1UCA=;
 b=Yureo22KSDR5b8+WSO4dtozXO/l0UTzKG+iQKY1v6UUkJrMJ8+d+dLVTtEbHkx3pjo
 4H41tRY9tik7U4Qh9Z5VH8Cla2w/KM8rhe1v3YwTqUD7JJIDFFZRAQR2Ajbr4UDf5Pyv
 gMMMBJaFY4hItT61FaXvtaNlqkFrpQqt8vTkicgH/9QqYqmvMjH6haJJF3MPx3XA0u6c
 DBJcefw99jtlLaV20TWaCcZNvwbSvX7UmJjbY5sB5KApTusHY4sMYcaMkA/xkOIFIFDc
 VS5G2to+vlzbZh9p1GBzbc+Z5btKCH7yYFKPWBL/CVeTiy8Lt/yDeyVeKQBtlotzPKF1
 DEdQ==
X-Gm-Message-State: AOJu0YxAoURNKGYhNKyZqAvvAvrLL2HZz24cNuEonP/9hvpR2Cujzn7q
 AJvVRPws4Z9YJca/wVRsJh7RW3pA9XZrn61lI8iwOukzhC1X5RIeLpmAjivD4A==
X-Gm-Gg: AfdE7cmMuKCAEr1OGOTDKoKOcuezseM0bNilwUVGnFXB9VvBQ0OoyRKkaTFvsMXbUIh
 6JhYRWvizkLgG/4x0F+zwWVV1iTVkLMsQkydparLd7j2273KXUut1OcBhjjbfzu0eg3rdqF6dyS
 +cInfPeDmxGX54sCAwNI4YBJb4y/4lVfPdG86Dx2H5VC8tctb0itf94ijgIbWPqoczCaV2e8uPE
 N+Q7Kj+Lrf+5OPS79HnPN9VaVAFt3eNdD7rfVWv8GA10ptH0bT7DavwSdvG8QCbGxWbuLymQ8W9
 31XMvgkjy0pezvuF4M1sfbRkRDCJ0xi3hMtdPwseP0v5mQbaypDTNzB+U6RVsUb0xWa2GtiKgmx
 9NI4/y/zmpl604XzjbaoX3qYYBP9wrQ5MYPJ62LlYecpcsCqhkPm5HpCCZxEL7RWYEfRWO4MY6C
 ez1gWI6bezv4zlGGacNUSx4wjSCaBh/uTuZ8uoibCVHWGW3mgB0BZ7NDz7rQh0jT7Y
X-Received: by 2002:a05:600c:1f87:b0:493:f870:fbf0 with SMTP id
 5b1f17b1804b1-493f88b3693mr114901345e9.34.1783948056654; 
 Mon, 13 Jul 2026 06:07:36 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/11] drm/amdgpu/gfx6: Use COND_EXEC
Date: Mon, 13 Jul 2026 15:07:07 +0200
Message-ID: <20260713130709.34262-10-timur.kristof@gmail.com>
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

COND_EXEC tells the CP to discard the dwords following it
when its condition is zero (false).

This is useful for GPU recovery because it can help reduce
collateral damage during GFX IP block soft reset, meaning
that it reduces the likelyhood that we fail some jobs which
are not guilty of the hang as the IP block soft reset
mechanism clears the condition before doing the reset.

Note that this packet is only 4 DW on GFX6 (as opposed
to GFX7 and newer where it's 5 DW).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 3e0cd46cd091..7f7b81c3919a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2423,6 +2423,24 @@ static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0x20); /* poll interval */
 }
 
+static unsigned int gfx_v6_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						  uint64_t gpu_addr)
+{
+	unsigned int ret;
+
+	/*
+	 * Discard following DWs after this packet when gpu_addr==0
+	 * The packet is only 4 DW on GFX6 (as opposed to GFX7+).
+	 */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 2));
+	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
+	ret = ring->wptr & ring->buf_mask;
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
+	return ret;
+}
+
 static void gfx_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
 				    uint32_t reg, uint32_t val)
 {
@@ -3579,6 +3597,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v6_0_ring_get_wptr,
 	.set_wptr = gfx_v6_0_ring_set_wptr_gfx,
 	.emit_frame_size =
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		5 + 5 + /* hdp flush / invalidate */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
@@ -3596,6 +3616,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v6_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v6_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
@@ -3608,6 +3629,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.get_wptr = gfx_v6_0_ring_get_wptr,
 	.set_wptr = gfx_v6_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		5 + 5 + /* hdp flush / invalidate */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v6_0_ring_emit_vm_flush */
@@ -3623,6 +3646,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.test_ib = gfx_v6_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
+	.init_cond_exec = gfx_v6_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
-- 
2.55.0

