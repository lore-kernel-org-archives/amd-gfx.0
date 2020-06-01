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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E7C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6012073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL5gPRXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6012073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFF96E379;
	Mon,  1 Jun 2020 18:22:59 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A4C6E0E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:58 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id u17so7372384qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iIvegJSnn4193vTZJ/wd6CYK8+jtPozSG2INnAuS3RU=;
 b=EL5gPRXeSGeT+grPgDKHnvm2wkxcCYqtdYvFqDy/IeABJmBdp2wE+wn0jMffwz+q9s
 QR7mLsfolWhlKnzY3XOQRy3hdox+K5CUPnm+LsuaD/bETIfeR6acle5ulVhvlhek0Z8G
 wkojOGq5VaLUgnmkUVi1dSg70w7YfJeyh/SUuQBoid55Au4c7vbGEcDMbYE8hVLQhUMN
 gTMlnFlT9R0zgl8dWgSbfvVxP7y9TqTz0wSXr9Q6uLX6JGp5rG+jcVHn2R1sQwMTJobQ
 nMn4mrVbcc9+S7uWyNfcN7Wi7NgHw2fhAlTDFNzFCKgmBYUjkFp8/ER2L0KyeRrKSykY
 FgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iIvegJSnn4193vTZJ/wd6CYK8+jtPozSG2INnAuS3RU=;
 b=gnOoq5YaMQ6k/icqtDUhMdoS7kMj9XdEYoTJet7REzgkcUUxNO6kmNZ8IhE4N4+cj2
 GkES0/Cd3hVal0ZeXCSKiUoC/1MMF3Uj4bbXn+Tw8LoGnjW7I9LWvyK1zc0UrJSszFuv
 Jwvb2Dzqvoia+4+h2M9/NwtR/C6l8fhOhptIvK/ZywEBXmeaam+luHkJ5J5iglUAQt8l
 Yt0jOdDHlAyvh7sYwju8JLdyKCMBmZGuO6ViyTLybb55817z9Pmt18xrq0e4FATUsHg9
 kTe3dabLDO3fPvh+Jp9WZx/LmXjqQeGuAQVS+zlURny1VHgv0JNqAmXy6mjbzYsmfeFV
 NkuA==
X-Gm-Message-State: AOAM531bNP1Ar6HubWV/xSiMizCUpq6GizTtwJR/U1u5uVBFVuiRW69s
 rfJMB54rqDsmjUxLnrm9bHDhwIIk
X-Google-Smtp-Source: ABdhPJzFsrkNSUY6uUR44GUaq/AXpZB8Q6Bo+2xAxGwTUn22xCkpg20+PA813h5+0xXqevQitaLTgA==
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr15950171qtb.158.1591035776697; 
 Mon, 01 Jun 2020 11:22:56 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 175/207] drm/amdgpu: reserve fb according to return value from
 vbios
Date: Mon,  1 Jun 2020 14:20:22 -0400
Message-Id: <20200601182054.1267858-86-alexander.deucher@amd.com>
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

Query reserved tmr size through atom firmwareinfo for Sienna_Cichlid and onwards
for all the use cases (IP discovery/G6 memory
training/profiling/diagnostic data.etc), otherwise, fallback to legacy
approach to check and reserve tmr block for ip discovery data and G6
memory training data respectively

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 127 +++++++++++++-----------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b5e050b82172..12675cb7dde4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1831,46 +1831,85 @@ static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
        return ALIGN(vram_size, SZ_1M);
 }
 
-/**
- * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
- *
- * @adev: amdgpu_device pointer
- *
- * create bo vram reservation from memory training.
+static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
+{
+	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->c2p_train_data_offset =
+		amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
+	ctx->p2c_train_data_offset =
+		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
+	ctx->train_data_size =
+		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
+	
+	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+			ctx->train_data_size,
+			ctx->p2c_train_data_offset,
+			ctx->c2p_train_data_offset);
+}
+
+/*
+ * reserve TMR memory at the top of VRAM which holds
+ * IP Discovery data and is protected by PSP.
  */
-static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
+static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 {
 	int ret;
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
+	bool mem_train_support = false;
 
-	memset(ctx, 0, sizeof(*ctx));
-	if (!adev->fw_vram_usage.mem_train_support) {
-		DRM_DEBUG("memory training does not support!\n");
-		return 0;
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->fw_vram_usage.mem_train_support) {
+			mem_train_support = true;
+			amdgpu_ttm_training_data_block_init(adev);
+		} else
+			DRM_DEBUG("memory training does not support!\n");
 	}
 
-	ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
-	ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
-	ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
-
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
-		  ctx->train_data_size,
-		  ctx->p2c_train_data_offset,
-		  ctx->c2p_train_data_offset);
+	/*
+	 * Query reserved tmr size through atom firmwareinfo for Sienna_Cichlid and onwards for all
+	 * the use cases (IP discovery/G6 memory training/profiling/diagnostic data.etc)
+	 *
+	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
+	 * discovery data and G6 memory training data respectively
+	 */
+	adev->discovery_tmr_size =
+		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+	if (!adev->discovery_tmr_size) {
+		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+		if (mem_train_support) {
+			/* reserve vram for mem train indepently */
+			ret = amdgpu_bo_create_kernel_at(adev,
+						 ctx->c2p_train_data_offset,
+						 ctx->train_data_size,
+						 AMDGPU_GEM_DOMAIN_VRAM,
+						 &ctx->c2p_bo,
+						 NULL);
+			if (ret) {
+				DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
+				amdgpu_ttm_training_reserve_vram_fini(adev);
+				return ret;
+			}
+		}
+	}
 
 	ret = amdgpu_bo_create_kernel_at(adev,
-					 ctx->c2p_train_data_offset,
-					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
-					 &ctx->c2p_bo,
-					 NULL);
+				adev->gmc.real_vram_size - adev->discovery_tmr_size,
+				adev->discovery_tmr_size,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&adev->discovery_memory,
+				NULL);
 	if (ret) {
-		DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-		amdgpu_ttm_training_reserve_vram_fini(adev);
+		DRM_ERROR("alloc tmr failed(%d)!\n", ret);
+		amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
 		return ret;
 	}
 
-	ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
+	if (mem_train_support)
+		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
+
 	return 0;
 }
 
@@ -1938,11 +1977,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	}
 
 	/*
-	 *The reserved vram for memory training must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
+	 * only NAVI10 and onwards ASIC support for IP discovery.
+	 * If IP discovery enabled, a block of memory should be
+	 * reserved for IP discovey.
 	 */
-	if (!amdgpu_sriov_vf(adev)) {
-		r = amdgpu_ttm_training_reserve_vram_init(adev);
+	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_discovery) {
+		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
 	}
@@ -1958,31 +1998,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/*
-	 * reserve TMR memory at the top of VRAM which holds
-	 * IP Discovery data and is protected by PSP.
-	 */
-	adev->discovery_tmr_size =
-		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!adev->discovery_tmr_size &&
-	    adev->asic_type >= CHIP_NAVI10 &&
-	    amdgpu_discovery) {
-		/* if fw_reserved_fb_size is 0 from vbios,
-		 * then fallback to the default tmr_size */
-		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
-	}
-
-	if (adev->discovery_tmr_size > 0) {
-		r = amdgpu_bo_create_kernel_at(adev,
-					adev->gmc.real_vram_size - adev->discovery_tmr_size,
-					adev->discovery_tmr_size,
-					AMDGPU_GEM_DOMAIN_VRAM,
-					&adev->discovery_memory,
-					NULL);
-		if (r)
-			return r;
-	}
-
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
