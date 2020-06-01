Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0ECC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45AD2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjK3CbTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45AD2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748906E37F;
	Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5056B6E37F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:23:01 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id n11so10003713qkn.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6QLmlmI2GrYT3f8+SiSGQRkRucdDmpbGBgg1JP/n3OI=;
 b=VjK3CbTSEMSmErz/wXBqwRKcMBK0ReTytzNZ1qq0TU71fu2ee1HqNUJiXHn/j+iyu9
 X0EkpHszBU7d1pYGxS2MuhlS3i4/AzJojsPoAYOG7/qqrQzyYIR24s/hMDEhkaWWbEHR
 EnX9rwAv5A8hLgY7Idy6c3GxU/RPZIiPuqRattRJyMbJRTb7a/porSh/J6WrubVkWoBR
 Yy/NygqEr/Wfr1097SFSnkDQ2Zuc/icNybU7fAbjUkKJrRX+LA4AeW9JfoJ8MBD+9TGR
 yIjEHB6iuge0boUAsm58pvMwzB3VCjIe6h0m8AOJfl+bFuHNXeMW4ifoon14L8St17fH
 MiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6QLmlmI2GrYT3f8+SiSGQRkRucdDmpbGBgg1JP/n3OI=;
 b=Pi7VTAusCz1LpLSyrTNzeUmnDPyVA0msqXCcN+BP+NoOnfy+jsj8Z30o7KWBI3sI2o
 J6G1hQxiJe/S1VsGNxM5+nsy1rN8wHi552LQq8BAsDz3+3sqxvqMPn3XV/42sESwQdP6
 +tiPZgR/KlXesezynNojCU3l7qCa+RHwDpcLcXRZm2Eyx+7hUyqg7wGAvzH7+551Bvjb
 BsoniYuKqw7gp8II3T6HFm9FSDXLTxTG4o+M270v+d2U1e3rEDiLLijy4JlTRUIzn+n8
 z8v3QEyIfceUXX/ZWnahWL7FeFTog7yNBUU+8AqYY4YgKhUEAKa9449KfsDEcYsD0r7i
 Z0KQ==
X-Gm-Message-State: AOAM531bRT6WL6BP9PONMBMhf2uR0Eg+oBmP0Rww0BrLR/W+ZrJlzVYe
 S3WZzjCwQtXTj9uxXaSAYG9B1VMD
X-Google-Smtp-Source: ABdhPJx9f4eGPMeApmPD5aXGtbL5siPp/Re1f9KBlize5wmH4fSY/pZHBRb3Td5sIe6hBD3XMEBjWQ==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr21158158qke.128.1591035780193; 
 Mon, 01 Jun 2020 11:23:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 178/207] drm/amdgpu: bypass tmr when reserve c2p memory
Date: Mon,  1 Jun 2020 14:20:25 -0400
Message-Id: <20200601182054.1267858-89-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

C2P memory reserved should not in tmr memory range.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 48 ++++++++++---------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d968e38d475b..5b42c50366c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1823,14 +1823,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
-{
-       if ((vram_size & (SZ_1M - 1)) < (SZ_4K + 1) )
-               vram_size -= SZ_1M;
-
-       return ALIGN(vram_size, SZ_1M);
-}
-
 static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
@@ -1838,7 +1830,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->c2p_train_data_offset =
-		amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
+		ALIGN((adev->gmc.mc_vram_size - adev->discovery_tmr_size - SZ_1M), SZ_1M);
 	ctx->p2c_train_data_offset =
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
@@ -1862,10 +1854,9 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		ret = amdgpu_mem_train_support(adev);
-		if (ret == 1) {
+		if (ret == 1)
 			mem_train_support = true;
-			amdgpu_ttm_training_data_block_init(adev);
-		} else if (ret == -1)
+		else if (ret == -1)
 			return -EINVAL;
 		else
 			DRM_DEBUG("memory training does not support!\n");
@@ -1880,22 +1871,24 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	 */
 	adev->discovery_tmr_size =
 		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!adev->discovery_tmr_size) {
+	if (!adev->discovery_tmr_size)
 		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
-		if (mem_train_support) {
-			/* reserve vram for mem train indepently */
-			ret = amdgpu_bo_create_kernel_at(adev,
-						 ctx->c2p_train_data_offset,
-						 ctx->train_data_size,
-						 AMDGPU_GEM_DOMAIN_VRAM,
-						 &ctx->c2p_bo,
-						 NULL);
-			if (ret) {
-				DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-				amdgpu_ttm_training_reserve_vram_fini(adev);
-				return ret;
-			}
+
+	if (mem_train_support) {
+		/* reserve vram for mem train according to TMR location */
+		amdgpu_ttm_training_data_block_init(adev);
+		ret = amdgpu_bo_create_kernel_at(adev,
+					 ctx->c2p_train_data_offset,
+					 ctx->train_data_size,
+					 AMDGPU_GEM_DOMAIN_VRAM,
+					 &ctx->c2p_bo,
+					 NULL);
+		if (ret) {
+			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
+			amdgpu_ttm_training_reserve_vram_fini(adev);
+			return ret;
 		}
+		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
 	ret = amdgpu_bo_create_kernel_at(adev,
@@ -1910,9 +1903,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	if (mem_train_support)
-		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
-
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
