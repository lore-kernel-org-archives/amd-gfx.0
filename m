Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60649FAD3E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD27B10EABF;
	Thu, 23 Apr 2026 01:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKZVyWBK";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE0910E0C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:19 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488b150559bso48123555e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906978; x=1777511778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GczI94r3m8tsOaMkK0Il4ORij/OJshxN/SfiRXPSG/E=;
 b=TKZVyWBKGxZChb7UY3E6fa51tE0hj/WCuMWtSY2QKwGbFBo3+LyPbWFkBBM6CUGCAq
 eEJeCUXNV/YfgXbJAyEMLisKI9F4dk1k6a9EBxyAUz0ZnFRqCHvw1hv1B8EfsOgRlNTp
 2wxmFg9togunt6uwhWsLUlPmQyixLW7SeGq2bCf/K8DLTR3fLoTbUWNwZJavZ7viore7
 EI35bfUFaOa3OJZC6C5CUjnngUZyY3e2izlABV6zSKq6i3sTECthaGLROReByjUl90W6
 LS3dC5k5iBWVmRcTBKxDh2kX8T/u8/oLdpahL+6+QwjiZp0q7qQj3uqSueLKQ3L/xVev
 P1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906978; x=1777511778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GczI94r3m8tsOaMkK0Il4ORij/OJshxN/SfiRXPSG/E=;
 b=I6stmUNxi7mTCOiaVtntPQxDFGdbPEy/olvMfAsQ/iye86O/NkwZ36FK9Pk7DxFQlX
 9hQTjFhRB+szGGpNwaLY7oLh7F+dR6KSzRWW2Qr+eY85l/UEsqsu2YbAdc4gGwxlrcBk
 fahzGjD/utKJkleIxeIYr1Z+iBcXFYzN+/ZTy41lQMvNLlknXhtEADN8jo0xS3o4XVx/
 xmrOI+oNvTw7qlY9Fq/mZDeeuNcfLD5z5zOZeWYY3q9ZANH/dUbhcMkUK9R+U/4dOvHe
 WiVGzqycZlSMPKakc/0HJm0QeJr59UZEsySWBOaS3HyHelmb5/dAtP2n3wrBVtAEia7Y
 1pyw==
X-Gm-Message-State: AOJu0YxosgIRHQM9gwM5LaejidhWc5OAqZkkY7ZZb7WRflD2FthMTy3h
 KkjT5rjYIZPKjzYXMrNwd5V2ECI2VEZkc9Iwtsrj7bKcywmXSLTvEoLdK5MZ7A==
X-Gm-Gg: AeBDiev06pmJlihyD4MRS7p2DCRUSDoOtK7IEV89IRsvXgXcvh1CEGPSD11JB10txTJ
 WBrR7o4md32cv+yFPwiRA0fZbWlLxKQnA3Rnauqh6UlLZx6LwIx9yv5env4kI338zJvZpoHN7j9
 z5HvFEGC4E4GALr2DOjswYiyeegBs8zCm6LhQJ8G8r4oLoh+qDG3WfTIuGqHvdxDTy+QCMwyumx
 FfK8pI8pcPILZ+Tod8wGkGX5Qtyig+aNPwANODephjGboH0kuJ2TEYuRCfp3Mh2OsPxxjZQhwSG
 Q/VRsGSOHTKfvqFnGvh05sPsCib+yZAKtmuktjG3MFEj4j1e0cjL/MlTguO8FZLlNOYUN0CTSi0
 AWDk7zub4Bd0yVlvmjkXEhzMBJ5qStGbmSUDMqqRIVmPlt5/XHiZxj9C5Q6otobh0QUFBbVIn3e
 nh+0D6MSHzUSdrFCGZxqjHj9xdr5HrN/P6wIu/7TtukWaf6REkTHKMfAdUdcfx/UcAlC56CnFir
 mBRQg==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr304872765e9.26.1776906977666; 
 Wed, 22 Apr 2026 18:16:17 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/11] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on
 Tahiti
Date: Thu, 23 Apr 2026 03:16:04 +0200
Message-ID: <20260423011614.309180-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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

Fixes: 698fa62f56aa ("drm/amdgpu: Add helper to alloc GART entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 9b0bcf6aca445..673e9e08c66a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -198,12 +198,19 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 u64 num_pages,
 				 enum drm_mm_insert_mode mode)
 {
+	u32 alignment = 0;
 	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 	int r;
 
+	/* Align to TLB size on Tahiti */
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
2.53.0

