Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A70CC30658
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784C610E99F;
	Wed, 26 Jun 2024 18:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fWRkdn8C";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD1510E99F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:12 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-79d5495fe01so51273885a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426731; x=1720031531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INHm/jPqzvUdwOXxfhIIb6A9nZm7DGduu2bNcPDKqe0=;
 b=fWRkdn8CwfTqPlwu34q4SL7gvUgUuxrKbbNAaiXX3eAh2hEn1ct0ZJ6RtVkduAr3wP
 jw5kkA4m5jQmojwrN5abMUJ4fIRNidse231wJD/DhnwqSWOZcfo+zh8gHp2dKfb7Txus
 1htwS5h8tdLWIYw2nCDqHClKT08IDCoPPNc/9MvYCD4xFZfoAVbkzQMomfLEAGD/D3r0
 n7dFrIJpRQL0VW+y3b5MthcC+/DDaQ3hW2dPgwim687QXtf6jXWFVYb9dYH49LBpAbO3
 b1sBcqSeKHU4rYyzb/4aZRYup2JfCx0UVQ2gZMBrgINag1yA8IlhTxu+recQG4Sjvn8I
 C7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426731; x=1720031531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INHm/jPqzvUdwOXxfhIIb6A9nZm7DGduu2bNcPDKqe0=;
 b=dwYc/TyKYJDJRfY4mG2Xyz8xeagSyTvOCb/w2WmfXtMWLMKPanknIbMDAQRwYN9so6
 eCncgyoqPX+1O+S+atiBx5hYid0U5nRFMWHiqJ1SNdHoxF2OIDrpWFMit6iQWkAWook3
 warBKY0PtzZARVu54z+eC/dtCoeRwV3M1U8HYBf7sJrwCyEw66KFaBDDB0n5yu95SbzB
 B1jgU2iTYcRMx38dI07jMWrjRIVsM1pNE0xSThEIgPdkMCNqB+LYV19TEfT1S+e+Gc87
 M0vZDJ+P82jNry+yWNysxvo7KW0y8+kuDeakT0L86Iu+Du+9bFNF7iKHBvZQ50TExoIH
 VC+A==
X-Gm-Message-State: AOJu0YxEsn6ojAELr1+FIYY9k/WZPT7ztVMihLPZ07kns3kOg84EnurD
 omtCjxGX4IiK94tmvhsCWC/PDRtS5IiLBsBELEW6Ks+gD2Uc8Un9xjWR5w==
X-Google-Smtp-Source: AGHT+IHBVrpc7Zel8K20ewPFqFPWvvRteWQYrNhdjcHQ4wrsirw0wkJGQFBGCNCbelcOlkqA3IX/kg==
X-Received: by 2002:ad4:50a9:0:b0:6b4:f761:f0b8 with SMTP id
 6a1803df08f44-6b54099938amr118436516d6.8.1719426730781; 
 Wed, 26 Jun 2024 11:32:10 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:10 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: rewrite
 convert_tiling_flags_to_modifier_gfx12
Date: Wed, 26 Jun 2024 14:31:35 -0400
Message-Id: <20240626183135.8606-13-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

There were multiple bugs, like checking SWIZZLE_MODE before checking
GFX12_SWIZZLE_MODE, which has undefined behavior.

The function had no effect before (it always returned -EINVAL).

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 45 +++++++++------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index ec0299c5918e..092ec11258cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -724,32 +724,25 @@ extract_render_dcc_offset(struct amdgpu_device *adev,
 
 static int convert_tiling_flags_to_modifier_gfx12(struct amdgpu_framebuffer *afb)
 {
-	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
-	const struct drm_format_info *format_info;
 	u64 modifier = 0;
-	int tile = 0;
-	int swizzle = 0;
+	int swizzle_mode = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
-		tile = AMD_FMT_MOD_TILE_VER_GFX12;
-		swizzle =  AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE);
+	if (!swizzle_mode) {
+		modifier = DRM_FORMAT_MOD_LINEAR;
+	} else {
+		int max_comp_block =
+			AMDGPU_TILING_GET(afb->tiling_flags, GFX12_DCC_MAX_COMPRESSED_BLOCK);
+
+		modifier =
+			AMD_FMT_MOD |
+			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+			AMD_FMT_MOD_SET(TILE, swizzle_mode) |
+			AMD_FMT_MOD_SET(DCC, afb->gfx12_dcc) |
+			AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block);
 	}
 
-	modifier =
-		AMD_FMT_MOD |
-		AMD_FMT_MOD_SET(TILE, swizzle) |
-		AMD_FMT_MOD_SET(TILE_VERSION,  tile) |
-		AMD_FMT_MOD_SET(DCC, 0) |
-		AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 0);
-
-	format_info = amdgpu_lookup_format_info(afb->base.format->format,
-						modifier);
-	if (!format_info)
-		return -EINVAL;
-
 	afb->base.modifier = modifier;
 	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
-
 	return 0;
 }
 
@@ -777,12 +770,6 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		int pipes = ilog2(num_pipes);
 		uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags, DCC_OFFSET_256B);
 
-
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
-			convert_tiling_flags_to_modifier_gfx12(afb);
-			return 0;
-		}
-
 		switch (swizzle >> 2) {
 		case 0: /* 256B */
 			block_size_bits = 8;
@@ -1281,7 +1268,11 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 
 	if (!dev->mode_config.fb_modifiers_not_supported &&
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
-		ret = convert_tiling_flags_to_modifier(rfb);
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0))
+			ret = convert_tiling_flags_to_modifier_gfx12(rfb);
+		else
+			ret = convert_tiling_flags_to_modifier(rfb);
+
 		if (ret) {
 			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
 				    rfb->tiling_flags);
-- 
2.34.1

