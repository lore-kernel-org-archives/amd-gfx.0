Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D0C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC46210E995;
	Mon, 13 Jul 2026 13:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aaMqzz7L";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B1810E995
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:17 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493b779003fso13720315e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948036; x=1784552836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D2eKo0Mzax8iXVl8/5o1wqT3AuptewHTtwIKVryOodU=;
 b=aaMqzz7Ly6gNH4r5cflGlGQCaMKbWhaV2AeOn125YjJWbcwQw4gSEw1d6L79BDjNPs
 01SOaK3WCLb2LUdd4w1B64BNLntEjPd/FgRKC2ErHG29X5EEXQ5iFxugUUDXBNUsmEZz
 MatxykJ8u9upriDur3rzxidBwuZ2hxuKb1v+ApYWc43+JiGNe91eRhdZF0b5wILoS2Sv
 yPTUmrVls7vxPw0teOGjtOxv+FLIAHr36xYx44O4Z421J8+aJP9OsBKx2DwjlhgoDzUt
 HTedHK0OCVvA8GUkCECYwNcm3GiJfjyVZIofsHHVvjDptDzB1DgU7vOZWJrjzbXIpyxW
 gSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948036; x=1784552836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D2eKo0Mzax8iXVl8/5o1wqT3AuptewHTtwIKVryOodU=;
 b=XO9oDeH5agIxBoEdlUhauKZ3M5X1Z2o/8LMF2ssCaaHdP1TjvI0DBxNG3cJZRUx3CA
 7zubwcRIjK4KlZc89/RZLko/OyqaTps5RtOHNU123sZr+zeSOLoy3VvsKlDE+JlwkzBt
 2tZJxcx/El1EWIJs0fR68Wha72ayZWYGc6Zjas26wldeEa1rHcC5eHitDb9JwzgSDnWr
 u1gx8inUt22i9kFSTp/0AI54Tq/FWZlkZcAnkqkdll+5j26dlxgZXD0sy8vn5fOPItZV
 UCMfNPTEPNz0S7WahCdSj6Bq5QFkQGgWuQ5j7pwblkqr1TaZ7AJsEHoiQE7clVy3AveE
 0EDA==
X-Gm-Message-State: AOJu0YxsXhxahPfp8aHYdCcmUYxATlN59dnKhFTrJAAdbO7hg9paj2QR
 1l6pfGG9sT5HyE3ZXFAubFRDdCHaB7OBao3nhu6RQSEXZy/sDIzLvuJ45fTu1g==
X-Gm-Gg: AfdE7cn1SKT++IXhr7PT+KLXJujZEUhZZy6sTWp1GWZ+Q5l3WiMKR53jIJ3zIyMM30K
 8yt8WhzGQW/V4ainnrw1ZTEuubXdgVq6lSnvUMqxi/6r+dn4S8JATSTXWNKnKX/dF5FAU6HQO+z
 NUBQARyU0M1bRjzVnlU4c6j1Xf1JnP2agDLSp1Gu93OYQkfwjpGxwxr6WzX8AOGCDhn4ugGrRBY
 J4yWCwivcN3NCLNAP/ic7Upm3yytJkGX3iXI9fGMPVfZcmBqonEaIw0IfzBaqEp4bqbd3MAOuSR
 eoz7N0NOEdc76WchrH2EiZtmsnUtHZ96cd3UPeeMk94EnnritvlEo8DWPhxgGu86P0BYFwlIqx8
 2o/P/cw//81MGe0bzoNTJAsxLrlgG2Kfis2lUGu29wyIYHSyWlrs07ZJMjS4byMk8767FXim+No
 5e2ffhk3dP2hKv6eGSBW36bc3G/JI2bhEX2Y122W+43Sn0lM3pfftcYA==
X-Received: by 2002:a05:600c:4ed4:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493f877fe8cmr103505735e9.0.1783948035762; 
 Mon, 13 Jul 2026 06:07:15 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/11] drm/amdgpu/gfx6: Improve emit_cntxcntl()
Date: Mon, 13 Jul 2026 15:06:59 +0200
Message-ID: <20260713130709.34262-2-timur.kristof@gmail.com>
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

Set bits on dword 2 like GFX7-8 except load_global_uconfig
which doesn't exist on GFX6.

Emit VS_PARTIAL_FLUSH before VGT_FLUSH like GFX7-8.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 28 ++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d86a..6d7baee04372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1881,11 +1881,13 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-static void gfx_v6_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
+static void gfx_v6_0_ring_emit_event_write(struct amdgpu_ring *ring,
+					   uint32_t event_type,
+					   uint32_t event_index)
 {
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
-	amdgpu_ring_write(ring, EVENT_TYPE(VGT_FLUSH) |
-		EVENT_INDEX(0));
+	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
+				EVENT_INDEX(event_index));
 }
 
 static void gfx_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
@@ -2998,10 +3000,22 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
-	if (flags & AMDGPU_HAVE_CTX_SWITCH)
-		gfx_v6_0_ring_emit_vgt_flush(ring);
+	u32 dw2 = 0x80000000; /* set load_enable otherwise this package is just NOPs */
+
+	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
+		gfx_v6_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4);
+		gfx_v6_0_ring_emit_event_write(ring, VGT_FLUSH, 0);
+
+		/* set load_global_config (load_global_uconfig doesn't exist on GFX6) */
+		dw2 |= 0x1;
+		/* set load_cs_sh_regs */
+		dw2 |= 0x01000000;
+		/* set load_per_context_state & load_gfx_sh_regs */
+		dw2 |= 0x10002;
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	amdgpu_ring_write(ring, 0x80000000);
+	amdgpu_ring_write(ring, dw2);
 	amdgpu_ring_write(ring, 0);
 }
 
@@ -3529,7 +3543,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v6_0_ring_emit_vm_flush */
-		3 + 2 + /* gfx_v6_ring_emit_cntxcntl including vgt flush */
+		3 + 2 + 2 + /* gfx_v6_ring_emit_cntxcntl including VGT flush */
 		5, /* SURFACE_SYNC */
 	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
-- 
2.55.0

