Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A520EC55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B3810E6A6;
	Mon,  3 Aug 2026 13:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nzGHhaP1";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FD410E6A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:15 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so590964366b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763394; x=1786368194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j8Xp79beID4r0GyrGGAyFXfSfT7vG7GH3UzbuBQSzsw=;
 b=nzGHhaP1xpyJV53lDS7Lfj9aqgOXSh0D9poiGWexmlqEYNkYUSEGJHA2ZMmFxUOUbE
 uiRK7rOUrxY9rxmg57B1fgOcaP/3h694leyjj75PM0vLnHv8qz2ZFPnuErykfR6BJdWE
 zX9HGwZTiyrmc/ryyTSlWOQ+4NingeEC1Sofrfx41dE4STLd2DB7pEthsDKP4ZE8y6Ss
 jG0w5PukblH6I7I5obRFU4zhoSHZg6HwslOUVrXNz3r/2HfDpoovdQDurvnh9oiZKYyn
 yFKmluKw/7R9f5gRHV+xn8+3jLnaJe2UH//NHaiiWa2ZtTdPKcudBhimtoJZMWB9rE+5
 YSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763394; x=1786368194;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j8Xp79beID4r0GyrGGAyFXfSfT7vG7GH3UzbuBQSzsw=;
 b=ESiwGkyFnkeVJG3kAP9Fcg3SlrMvnEDuDWBgZh1Qxqrs0OPGoDFebua7aX7J7cxO7T
 IrGnz/E7NmbRHItbIg/P4682+uCc3fKNEkvZkpX5Ddfp1jnKc2zJXu0rFKzyIZd/GhE2
 8AY3kwY1ri6dKzFZ295MsYf46HebFQMnWLHiL5BtmFkzFgpWY9gtdk/RxXMNe/zysAyL
 LZZFA/LlMDY1EZ8nni8Qt13nff+EKq6TNYWGDAysbUv4v2XBJpEUKCE9BIxjcWsOEgxK
 NZ0Aj0u8RuJln1g633Txrt1LuzqAjdLQjcwi9UUFDxrXM0MdEoHyKk/UVppn5yGYCazS
 OMTw==
X-Gm-Message-State: AOJu0YyHlCOGaBzgTZMjz0g0GdDZuIrVZ+aojVPXK29XWRaSfGPS9alp
 Wv4JiNxRfufvWxceKnTw7s+VEjXqBSPAFkQrJ7MmAMs05Tsyw/gql5o+jaNLAP+J
X-Gm-Gg: AR+sD11Rh0yy9QMOBVhKuccfcaM6iEnKEoCtQBq+4u+yCi2oObRrwjkUlRf2SyO6IV7
 PEZwDgz84ycphSQPpLrGHOWMUxDuUywuG/C+am+qh3q6/bKErxRHqFV2+yrdNAz0t5/QUhPP2Xe
 /T58SNrm18Bs4/oXWi2S4HeHJVUBH1Gg8ZeKHf/1NeRojes25LiKHnHPy1+oa0UKu9GzQu0kgCN
 3bCMPfs+nsrJQtWAm7DV/X99Px+56pnRnFy2nPQhoSWFms/wjTGkya6WxVeSonuSjjdR9hz9HC7
 qtHJ4CivAFd5oR016DOSxQu91CiXhE0WpaFrkg1nTP07bYpA7RvTcDdVj7gRzUpeqj7PlEjGt0X
 dqxuZYeGgNEZVaFdtL6uGe28kJbk9eDWRfVc6YRnKoFGpqxOv8yoQu5NHulGhmruJNUAVnPJ2+A
 Fq87eX6R3E5Esh6l3j0vKz2qgVMlNxWe6M3Shi3amoRKKlOMfgxx/D17QSx5K7ZwZaGjRUHGuQB
 RTkQQFk4OQWY25bQTy7E3nohnp8hp4=
X-Received: by 2002:a17:907:b048:10b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c1fe7ea4c47mr544390366b.9.1785763394020; 
 Mon, 03 Aug 2026 06:23:14 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:13 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/10] drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
Date: Mon,  3 Aug 2026 15:23:01 +0200
Message-ID: <20260803132309.36326-3-timur.kristof@gmail.com>
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

Implement the emit_switch_buffer() function instead of emitting
them duing emit_ib, emit_pipeline_sync and emit_vm_flush.

Note that it isn't necessary to emit these in both
emit_pipeline_sync() and emit_vm_flush() because
amdgpu_vm_flush() already calls these when calling
either of those functions.

Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 38 ++++++++++-----------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 0cbaae73a0bf..b84d05e7f09e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1927,12 +1927,6 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
-	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
-	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-	}
-
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
 		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
 	else
@@ -2365,14 +2359,6 @@ static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, seq);
 	amdgpu_ring_write(ring, 0xffffffff);
 	amdgpu_ring_write(ring, 4); /* poll interval */
-
-	if (usepfp) {
-		/* synce CE with ME to prevent CE fetch CEIB before context switch done */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-	}
 }
 
 static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
@@ -2396,12 +2382,6 @@ static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 		/* sync PFP to ME, otherwise we might get invalid PFP reads */
 		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
 		amdgpu_ring_write(ring, 0x0);
-
-		/* synce CE with ME to prevent CE fetch CEIB before context switch done */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
 	}
 }
 
@@ -2997,6 +2977,12 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	return clock;
 }
 
+static void gfx_v6_0_ring_emit_sb(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
+	amdgpu_ring_write(ring, 0);
+}
+
 static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	u32 dw2 = 0x80000000; /* set load_enable otherwise this package is just NOPs */
@@ -3539,11 +3525,12 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.emit_frame_size =
 		5 + 5 + /* hdp flush / invalidate */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
-		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v6_0_ring_emit_vm_flush */
+		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
+		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v6_0_ring_emit_vm_flush */
+		3 * 2 + /* gfx_v6_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
 		3 + 2 + 2 + /* gfx_v6_ring_emit_cntxcntl including VGT flush */
 		5, /* SURFACE_SYNC */
-	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
+	.emit_ib_size = 4, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
 	.emit_fence = gfx_v6_0_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v6_0_ring_emit_pipeline_sync,
@@ -3551,6 +3538,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.test_ring = gfx_v6_0_ring_test_ring,
 	.test_ib = gfx_v6_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
+	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v6_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
@@ -3568,8 +3556,9 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v6_0_ring_emit_vm_flush */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
+		3 * 2 + /* gfx_v6_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
 		5, /* SURFACE_SYNC */
-	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
+	.emit_ib_size = 4, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
 	.emit_fence = gfx_v6_0_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v6_0_ring_emit_pipeline_sync,
@@ -3577,6 +3566,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.test_ring = gfx_v6_0_ring_test_ring,
 	.test_ib = gfx_v6_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
+	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
-- 
2.55.0

