Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF8FF8D77B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E6610E8F4;
	Thu, 16 Apr 2026 20:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGxvfnhq";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF5910E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 20:26:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso82079625e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776371210; x=1776976010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrtZ0G3P3m6FoHiXlbRMLiStQ8Ff1/L18zCspG9Ce5o=;
 b=hGxvfnhqnLrSc9A0+jrLr98HMwa1YKshpNkxoftsWL2PaAHpodBjIt5oU7sVS8vTB8
 kBLg6rt5DB7PLpEzNdWAz8a1UlRm2BOpJP8ZO5sxhmiAdGEYxbnARUtIUvGIym9aUekA
 mBmuT9+wnpqcDZWSU0QnAPcMLU/xTFthcEHXSkziLkLXiBGOfI3sVSSzFf9P4rylnVvQ
 kWf1PJIriqlBbgQwAySkGtVw0xJj3eaQ7W0KFer6kpozdK+BSQAz1KhWnoSvZm4n9dVL
 RnfPCplRx/LDNHUUV5ff6sMTTud4ylf7IbLwi+WNOkzixihHrh8kQFsRI7kmdga4e6s4
 fXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776371210; x=1776976010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yrtZ0G3P3m6FoHiXlbRMLiStQ8Ff1/L18zCspG9Ce5o=;
 b=FhlkIYiht3uGzTrZ5ajY4Gi4doLHG7kcrbHOQ0oMRDpz/NOm/2vTqU+cOG1YSLHnzi
 2g7vyZJ6npM/Cnluz0+yVOVLv9mZZ/XboQ2J8eai5K7+G4dOex9DxSAoVuMeJBlQ47i0
 euxIhlQBmpvQ5BKwyRHrOeG5NmTomlRxOBTU4XJ16DdFsqZMg76yfIBidfl3oSJMPn6s
 UBWguZDLETOtS1UV38h4c40KYHQL9lwq9UDfxY8cRFOdhX2qHysKiQHJb7WghYx5K98G
 ga61RbnAucmKKJB7n9sfBMUL9USjiVoER+rwWBD8k3Dtth7JBBeou31stUq3gr/50Wj6
 xwLw==
X-Gm-Message-State: AOJu0Yzq6OdSPXBYb9FjcG5qRumaga9FwXvIY0CJECsSRKWcvA1Cibi6
 XiANrULyFsrX15rg3YhgO1bOjDCuFjnUA283ZBardVzSX6CFUFuUHtxBMELevA==
X-Gm-Gg: AeBDievxShcVGm2hsAn4QLOJIjnnsTjNtFGKfcgtCrOaNAwFjePD6E+HfLb8kDEQ8vS
 yRAXNYNGIcfDrAWe1giuVUGsdkq0iv6eqIECJB3iemiK/pR0+YXpScUqZF2kTczJwoa8gPRisK7
 xlrfWVHwZKZQpqsQEKG0V23V/dOZ0m2S0foUvpoouzBIGGnKAcOzkM/+op1Gtu/LzhEQrRlTfTE
 0tyovVQgRSYuQrkqxP9hSomZDHMuiUL+aOCQQk9538k8TO++M9qxUfHgjWh1fXT8WOMo/U0dRHb
 u6cpYTxjGU4BW3NWeKmuj0viURdJ+SnV9XoiKtRFJi3IJz9RBeU9PG1/pGATK+vfAcp7Fle6Hrr
 feXepxMPkg7K3MonNjicawxRKWMJKM5kGSnC3zOyhOD8lF+h/b2mGYVh+FPUXycehFDForKjY6C
 ISqcYviMfIGDSJJn8sikm4jgmzmNt/Q9e8SqYAqOFt0l7Fd/A8W/mvI0V++bKGzJOmEeYkwt1x2
 8Kzqw==
X-Received: by 2002:a05:600c:c118:b0:488:a82f:bb96 with SMTP id
 5b1f17b1804b1-488fb79891cmr727345e9.29.1776371209727; 
 Thu, 16 Apr 2026 13:26:49 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm76941355e9.5.2026.04.16.13.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:26:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amdgpu/vce1: Fix workaround to ensure low 32-bit VCPU
 address
Date: Thu, 16 Apr 2026 22:26:40 +0200
Message-ID: <20260416202643.25350-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416202643.25350-1-timur.kristof@gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
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

Fix a few issues, some of which were inadvertently
exposed by starting to use amdgpu_gtt_mgr_alloc_entries()
for the VCE1 workaround:

1. When the VCPU BO is already located in a low 32-bit address
in VRAM (eg. when VRAM is mapped to the low address space),
don't do the workaround.
Previously, I had assumed this was not possible
so it was OK to not handle it, but now we got a report
from a user who has a board that is configured this way.

2. Only allocate entries from the GTT manager when the
VCE GTT node is not allocated yet. This prevents the
possibility of allocating them multiple times, which
causes issues during GPU reset and suspend/resume.

3. Align the GTT address of the VCPU BO to a power-of-two,
ensuring that it doesn't cross a 256 MiB boundary.

4. Remove a useless check at the end of the function,
which is superfluous because the same thing is already
checked above.

5. Change maximum address limit to 0x7fffffff in order to
reflect how vce_v1_0_mc_resume() works.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 2fe931366985a..55ea6765c03b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -531,18 +531,29 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 {
 	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
-	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+	u64 vcpu_gart_alignment = roundup_pow_of_two(ALIGN(bo_size, PAGE_SIZE));
+	u64 max_vcpu_bo_addr = 0x7fffffff - vcpu_gart_alignment;
 	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
 	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
 	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
 	u64 vce_gart_start_offs;
 	int r;
 
-	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
-					 &adev->vce.gart_node, num_pages, 0,
-					 DRM_MM_INSERT_LOW);
-	if (r)
-		return r;
+	/*
+	 * Check if the VCPU BO already has a 32-bit address in VRAM.
+	 * Eg. if MC is configured to put VRAM in the low address range.
+	 */
+	if (amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr)
+		return 0;
+
+	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
+		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
+						 &adev->vce.gart_node, num_pages,
+						 vcpu_gart_alignment / PAGE_SIZE,
+						 DRM_MM_INSERT_LOW);
+		if (r)
+			return r;
+	}
 
 	vce_gart_start_offs = amdgpu_gtt_node_to_byte_offset(&adev->vce.gart_node);
 
@@ -553,8 +564,6 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	amdgpu_gart_map_vram_range(adev, pa, adev->vce.gart_node.start,
 				   num_pages, flags, adev->gart.ptr);
 	adev->vce.gpu_addr = adev->gmc.gart_start + vce_gart_start_offs;
-	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
-		return -EINVAL;
 
 	return 0;
 }
-- 
2.53.0

