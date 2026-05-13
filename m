Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A160CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F90510F03F;
	Wed, 13 May 2026 20:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZIxWryt5";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BAC10E177
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:21 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-44a14580111so5305446f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702660; x=1779307460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UV9dhFzOhqHHFqntkTTzoREoKPjaNNQu+RK9Jcs3udM=;
 b=ZIxWryt5T3m+9OWol8J5q7lqQ/0/Dz+xlMtrkjWHMI5UrcRnWtFzU6tB/v8oRw0/nB
 CuY5P+sWOKAvLzVu2Gyalz8IuMagRYlVKXQxRgdL1podY0rwDRgc9uyYD49dldCYs+bE
 AspnU+cGXdyx0mMzN9yUGIIHgL9H8yLhN3aU1aMcm8B47cl89Tpg05u+EUGi3Axisehp
 XxI4INTFZ54R94VU+KfJBWg1B8pW6AZSW7gZ3iqr0F6gu5leWKl30wK0s2JV0BxYZJnl
 K49oH6cx28q4fiSeHGV0AlJdIbWzG9TZ70bwQ7H1aHmDiOXFJl3fV3EBrM/G754HN6il
 qnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702660; x=1779307460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UV9dhFzOhqHHFqntkTTzoREoKPjaNNQu+RK9Jcs3udM=;
 b=T3UKk/zRWK+dnq3GGM5F36Pib93VD2w2KNYulh6TJWKCluuWH1TPAA8bl7hvss66XV
 fDf0guLM/NEE10kza1L7Mbd7IMA7y81jQ1NUQa+1vwfXCRq+HqPBjdXtLP7/LGjYflt4
 KAVWjyambqNVQ66ftzSldvXCBs/JEJLY+RPgsfhomMfRZxxK8xuYQgvIkipnZsDvWCn9
 sPQCD4yPAyJOSG15c39C5FhOZahuA97BUzfd85DwkynpBuLECz8ZS1mlPXBaKq6Ktqkx
 EzjJ6fvstl85b3ACGBafUIDQRw/41ivRNXvN/aYQDvKdlW8mtvCuROdo3LjmRyRJRf1p
 9KpQ==
X-Gm-Message-State: AOJu0YxswJAkVut2WbVzqyGLbJVlM6bkOT+3DsBGtP6PX8dHEC+KtvzY
 phPbIGp8WQTgAOFqXRqtGnAp/yN5UhdfRjeRjtM7Cpqtax2HK0NhN2e/aL5ZpQ==
X-Gm-Gg: Acq92OG+UFj/0RphTRYgcvjaVMX+PGJNddALbHOvzCI9zR/FgEyu4DJxA0vVqbYrtjH
 Ym8gHfjmTlaGvfpSkNtkD3qkeSaTXbpIVAJg1WgsS/Kdo9LUyJlZ0LmMAzc+exvwa6dHF7KJZ/z
 HZXYzbTrspOTMQznmp9OGpNYJCWsxZOUEW+2dfQfiwdo45nUzpaEsXamXZndZJ90aB9qemLRcsR
 GGJh0RRuQZtQ8aLq2dJ2dhi8+u2X46OTsNASTuelTKX1vU6hoJ0s7rQNcmQnDXT19RMf67bHEuR
 rRpQvzKdpxC+U1BV+0Y17z2zk7h55ygew7YlzcOSN+n2lm2NnpLxe+/C8LaG/y4IwCwEFSArHDl
 oTILmhmV1nq3DLWIRYpRiCCsKzz5nSdFj0oVP0myracVlygsOdnJy1V1wQuhrSyvfG7IASRsYz0
 ycfD01q4tGoIN13QpoEkLXhk4zXK/G0uob3xC23oyiCsz+BEj30GMZYWdmb9urjA8q
X-Received: by 2002:a05:6000:24c1:b0:43d:77c6:be78 with SMTP id
 ffacd0b85a97d-45c7a8d3952mr7593876f8f.39.1778702659791; 
 Wed, 13 May 2026 13:04:19 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:19 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/9] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on
 Tahiti (v2)
Date: Wed, 13 May 2026 22:04:08 +0200
Message-ID: <20260513200416.35631-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
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

The TLB is organized in groups of 8 entries, each one is 4K.
On Tahiti, the HW requires these GART entries to be 32K-aligned.

This fixes a VCE 1 firmware validation failure that can happen
after suspend/resume since we use amdgpu_gtt_mgr for VCE 1.

v2:
- Change variable declaration order
- Add comment about "V bit HW bug"

Fixes: 698fa62f56aa ("drm/amdgpu: Add helper to alloc GART entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 9b0bcf6aca44..02f85802f579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -199,11 +199,18 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 enum drm_mm_insert_mode mode)
 {
 	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
+	u32 alignment = 0;
 	int r;
 
+	/* Align to TLB L2 cache entry size to work around "V bit HW bug" */
+	if (adev->asic_type == CHIP_TAHITI) {
+		alignment = 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
+		num_pages = ALIGN(num_pages, alignment);
+	}
+
 	spin_lock(&mgr->lock);
 	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
-					0, GART_ENTRY_WITHOUT_BO_COLOR, 0,
+					alignment, GART_ENTRY_WITHOUT_BO_COLOR, 0,
 					adev->gmc.gart_size >> PAGE_SHIFT,
 					mode);
 	spin_unlock(&mgr->lock);
-- 
2.54.0

