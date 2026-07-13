Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD843C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C4D10E965;
	Mon, 13 Jul 2026 12:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sx9YFJhb";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962BC10E965
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:52 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so1627931f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947531; x=1784552331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eEz+EYVz9J++diS0Srd2Kz1MvSYb3U+TurhJtOTC0+U=;
 b=Sx9YFJhbFiJ9OfAAASfDIZofCP0vN6PKgLiCwTbnmkypLN5M8cD2FKs3VUacS5rRpY
 Uv1eZv3Gr3h3v7SHAxX2ZrihzmtQF8ntC7/J9+ONlEH3Vytpl6VVVlm7QeV8jCV/dizj
 q0ymkdfLLoA3MxKYCbdNBzEhDdcBBPWw24eucRP2lBrupJiIo9VfzM4j7Z3K1cKI5bwc
 +zbHVVOe+GxSh8b5cEPr64ciXkLyq6oCcfVEHTRrEHm93SwEWOSPTHv7dBSw80s0rpOM
 oI3U6a8nu4rDuVBqaLsr6l9TtqyPyhqZt+NrID9Zs46oxVaVNdz5CcxLGvlfcSL0JgLZ
 hNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947531; x=1784552331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eEz+EYVz9J++diS0Srd2Kz1MvSYb3U+TurhJtOTC0+U=;
 b=PTrttapLUq3ZQDgxFD69KP0clZQVj7XrzNVDLeVwKMY1cUS2ZFOcI7/9Yw4cM0bzkX
 susBKxX+18ERE2o7W+Lrp0bR/+Q9gTIBe094ZLKRjIOrSRhlXSvxmHiHYkr5wCe6q/1+
 uOvwGrD3b9ametC1RkfoMKI5mfXve3YTWMto8hx+/+aHbLySySBRobnuiDT32T32pvhh
 tOQNJQpS92uvZdVHwzVfBR8y3vtD+W8CyT4sDCxMJVmo6fNzuBNJirxHjbrwrjHqqm69
 md75yurMd9BdoW2CinvnTIeQEUy97FcNM7GiQbB5eieQ4nb/zbpl3V8TZCKLTKVb0oLb
 H8wA==
X-Gm-Message-State: AOJu0YwOTQIZrO6lGj1s5epsJd7qYmRdCglPlQcK26oYXwSWYFfuQCv6
 ImWQ/NG5AyzSvGHEQqjVk7bgpuugvl5bdQ4U41PyojbRbVRxjTSvOB+Dz/CRcQ==
X-Gm-Gg: AfdE7clES12iHaCs0jX4P+GpZ2iP1v3zG8PkQXfEUQR52GaDM2WQLtrw8S61w8ivZ84
 IGxB0SXXycwkPE4NuochxmiRZT8JrwriA0Iopd2mf7p/22nnj/muUgz29AJeUKosO/1lsM+8VLN
 PCqBsAnCVEU7P5yveFZildHVfaI2XHdf9qy/Sy4ljvH/dudAxHbaoHQz25ktuN4YaQimrVS52pd
 7gsB7KC/p7TTgTTKpurB8z+2WcyqO3NE9Cq0OS7+zE9fbF8w6oHlvyO+jkROAnpJ5nLk66s5Xww
 DfaDfVfxx5AK/qjm7XymUPp5ziGCNLqHjg7DgdFdiEN0AP6NeLnOATJhFUIGaWc2ax71PCCK+nj
 YY6rqDBJeBGmmJ/vtEnVJfui1l2t8Kabm4Fs9nDRb9haYuakjcIWsiBKyH19vgBM5rFfCs5Oelu
 Kw1E86xMsjIIqvTQU2Hew1KLw+VPCQobVZx1HdPmtq/nQPT9vHwOZIcgN/CDw9MyTy
X-Received: by 2002:a5d:5c84:0:b0:46e:27ed:6d0d with SMTP id
 ffacd0b85a97d-47f2dc7d213mr9932670f8f.8.1783947530861; 
 Mon, 13 Jul 2026 05:58:50 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
Date: Mon, 13 Jul 2026 14:58:34 +0200
Message-ID: <20260713125838.30607-6-timur.kristof@gmail.com>
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

Implement the emit_switch_buffer() function instead of emitting
them duing emit_ib, emit_pipeline_sync and emit_vm_flush.

Note that it isn't necessary to emit these in both
emit_pipeline_sync() and emit_vm_flush() because
amdgpu_vm_flush() already calls these when calling
either of those functions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 32 +++++++++------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0ceadb107d26..a93cc02c3400 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
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
@@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, control);
 }
 
+static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
+	amdgpu_ring_write(ring, 0);
+}
+
 static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
@@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, seq);
 	amdgpu_ring_write(ring, 0xffffffff);
 	amdgpu_ring_write(ring, 4); /* poll interval */
-
-	if (usepfp) {
-		/* sync CE with ME to prevent CE fetch CEIB before context switch done */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-	}
 }
 
 /*
@@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
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
 
@@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
-		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
+		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v7_0_ring_emit_vm_flush */
+		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
 		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
 		5, /* SURFACE_SYNC */
 	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
@@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.test_ib = gfx_v7_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
-- 
2.55.0

