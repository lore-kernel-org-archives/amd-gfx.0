Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C24CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D30910EE6D;
	Thu, 11 Jun 2026 10:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFhYfg28";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E02010E7CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 08:33:23 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso5195058f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781080401; x=1781685201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
 b=jFhYfg280sYZ1JOeR+tyM2EPV/OLIi3zLKCYzDA5RoxARblV6Cg5QeXQkHtXDe8KPW
 O9R+FFDyVdzQejH6Lef6yh++4uDXjLTcmj340iMTnbEbetrYiqElnKE8e1vXwX4dIdR5
 qSoH7pM2sxvVSg5L/Gyx9e+sgx0uO+SVa/eXe7UGRwssBG9YBONPOyfCoJ1tWjQu7cmR
 jXmiRgxNwz5LDy7GxnQ8tTqf18zybdzuEr9eXhv73vMZurA3lRFTM15YRQbQVZYYYVs1
 RA/TXPKPVMBlnj/tb7HePaawQLzHY1Kux1A3XDnB5OPTOcnAa5QiMOiJdhI7j6su7GA7
 5Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781080401; x=1781685201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
 b=okPDJGuMvq71Cwr3pzKP3jDPEbatelcM3TFrwK+nkMQiXwxDSPBDIw3mbfOsQ0fpOz
 Tg2szDR3P2HbBsALbLC+usqEPD6sEX+QVlUvrnX3HfxTzLvotxXrWdCzf2Kg3cGCjY/o
 OpLhM9boSRfOOGv0aOU/Qy9pFxDimzr4P7faXC0k7LxD9hONC+Js3T+ZhYdF+D89K3TR
 wvlKKfCb/dVCepKIw1tNosj5kJeer0nGSiy4iKMWOgof11HspL9KYJeOcQ4P/dxi0WPa
 fUg2r71WHGS65w8d1PQ0DAUNxVrmiacHcp+iXs/tjE0VunqADfe18aH07crEeXuOVdZD
 WReg==
X-Gm-Message-State: AOJu0YxZzWQv/oxe0mvMONmnUXVd24Bv7dXntd8GfuUgnuVOk9LGLgqp
 v67qD6UW0h/UuQi5f6Fo62q8+AkVy6ltmTxjniqMZYxtLtUCVc88NleX9/owtJOTn1E=
X-Gm-Gg: Acq92OG9una9/l6+3F2eg9znwAwTj3khR666oLXVjMcBAwMvw5DOY7k+BDOKL0qNYzV
 EhS292949p2XaWkzSGXZUzw8qsjCrynXVq9lXwX22FbZZoEMFNn6YhxHYwf17TN5++5EuXEohaf
 MK14mhJQkcZ7pxvskZo8fXy+Ninh6keV8+CuGvmzmsXNwChxE6U5yAYT29G6Fxgv+IcQm+yIvAY
 lgLHPs+kzBpIS0qcNmMoeqps1UY/whLUzSlSGiMR8GB0z38HQR7i45xUybl1CaSpjZKdvWzWdr+
 wg0AN6YVKMegcZ/510txqKxaa0gnsZKv9t8MDuSvwkNK30Sc/xWkAHvr617H58KaXmXX7yjlJD8
 +OIRehqFCnxyytq44G7bI2NH5ZpojmYTa9gtV2++YKwpUif8rRigrvKFADDxtekNSaYldphnvlk
 tFxNcr4JdLfoZf5i6fInvV8vfIKcqNwUv53h8EVsEDmgE55y4ucEkGGKyvkRJLh7+6ag/H42c=
X-Received: by 2002:a05:6000:2b0b:b0:45e:ea2a:dd79 with SMTP id
 ffacd0b85a97d-460302e0a31mr24547521f8f.4.1781080401290; 
 Wed, 10 Jun 2026 01:33:21 -0700 (PDT)
Received: from aldebaran ([193.165.157.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm76213092f8f.35.2026.06.10.01.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 01:33:20 -0700 (PDT)
From: =?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, stable@vger.kernel.org,
 =?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
Subject: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
Date: Wed, 10 Jun 2026 10:32:45 +0200
Message-ID: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:23 +0000
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

r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
GPU page becomes one blit row. Large copies are split into chunks of at
most 8191 rows.

The kernel register header names the packet coordinate dwords SRC_Y_X
and DST_Y_X. In the BITBLT_MULTI description in
R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
-8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO base
and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
exceed that coordinate range.

Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
destination coordinates. r100_copy_blit() already packs
SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresses
belong there rather than in the coordinate fields.

This fixes Prison Architect corruption with 4096x4096 mipped textures
after they are evicted to GTT under memory pressure on RV530.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Ondračka <pavel.ondracka@gmail.com>
---
 drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 3ac1a79b6f13..533215d6e9cb 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 {
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	struct radeon_fence *fence;
+	uint64_t cur_src_offset, cur_dst_offset;
 	uint32_t cur_pages;
 	uint32_t stride_bytes = RADEON_GPU_PAGE_SIZE;
 	uint32_t pitch;
@@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 			cur_pages = 8191;
 		}
 		num_gpu_pages -= cur_pages;
+		cur_src_offset = src_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
+		cur_dst_offset = dst_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
 
 		/* pages are in Y direction - height
 		   page width in X direction - width */
@@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 				  RADEON_DP_SRC_SOURCE_MEMORY |
 				  RADEON_GMC_CLR_CMP_CNTL_DIS |
 				  RADEON_GMC_WR_MSK_DIS);
-		radeon_ring_write(ring, (pitch << 22) | (src_offset >> 10));
-		radeon_ring_write(ring, (pitch << 22) | (dst_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_src_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset >> 10));
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
 		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
-		radeon_ring_write(ring, num_gpu_pages);
-		radeon_ring_write(ring, num_gpu_pages);
+		radeon_ring_write(ring, 0);
+		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, cur_pages | (stride_pixels << 16));
 	}
 	radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
-- 
2.52.0

