Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5A7C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0952F10E13A;
	Wed, 26 Jun 2024 18:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCPrU2XP";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D6E10E13A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:10 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6b5834b3a95so3024636d6.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426728; x=1720031528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4x1B5xdCuAuDgzVWtfCxYVAIMWOAYaRyholew+Q7ss=;
 b=BCPrU2XPTS7BjPRZ07vviUvRrOHcbbdHuIouevHiBJv/vd3aisZqDKCeyAz15WpAx0
 TfZCXLs+iuaI8sZNIGBqGyfn7m7TJrS/RWykNPJkqYPYF1HYXynoEN0LCKwyAv4/7Ui4
 7KfMsH8sCKfLKS1BJHCDRiccmT0y2TTCzeTuDbfFHQzPM2tCYPLrQVYBfHLmFwYuLx6y
 v9XY2K7DOC6kWQ2DBoXTvNnKAAmH/1Vcz8yDbipPbTNkMjx/OsP7dQCe9B4Azm4VtA2p
 Jo3jxpvvBEhumvPV4U67eQtxtcpQR6VrFG0XY+P/AZc3aUJco73MoAZ1vlGGoN1uJCQN
 YhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426728; x=1720031528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4x1B5xdCuAuDgzVWtfCxYVAIMWOAYaRyholew+Q7ss=;
 b=nwdGpBCp7tXvXE+ifaLQgScmyCJgdrgi2A4bJ9Li0e/j0e6FyfuqI8sx+Tmbg80Etc
 isuEjMSG+dFEOefCo6apgtCRBPeBIBJPpXCGLmoTp8zRlptQKpTzR34acPA18ACGzuG1
 Jy3dP2hMP3AEzr0aIp5H7Lee/g4i51DhE4Kb7Xif/LngjRe+uulSilrojmKnXb6d7TzG
 6f15IoZUE4UuRCYN905AbayhDOviqFoM9J9RNCLpMFjKBah+pls+p73evdQQByG2koP6
 4HyrKN83Wh7xnspRbTq4GT0Aa2d/yXU7/3Z6hFiJBkMhngiffMDUOjVnOgcau2Wvpil5
 ehzg==
X-Gm-Message-State: AOJu0Yz0esfUL+LRjO/th5FSV1Ws8p3ISJMfAVCOVoHeqDN5Qb4RMDi3
 q6d8B7u3XZ3Lm9lMkaysGUAzg/9kv7gZmObqX9FLZt1HUTLyT9zC0VZpMw==
X-Google-Smtp-Source: AGHT+IEFS7mLNFsxozfJ3azK4LqjaWtoSnmcsrYKfCMCZF/n57ZqkUjKXpyDtkvrjdonwY7cAxHDfw==
X-Received: by 2002:ad4:5de8:0:b0:6b5:462a:fd32 with SMTP id
 6a1803df08f44-6b5462afe3bmr146284696d6.60.1719426728403; 
 Wed, 26 Jun 2024 11:32:08 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:07 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 11/13] drm/amdgpu/display: set plane attributes for gfx12
 correctly
Date: Wed, 26 Jun 2024 14:31:33 -0400
Message-Id: <20240626183135.8606-11-marek.olsak@amd.com>
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

It used gfx9 flags, which has undefined behavior on gfx12.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 5a6a21e28548..e13938e01b70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -352,6 +352,46 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 	return ret;
 }
 
+static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+								      const struct amdgpu_framebuffer *afb,
+								      const enum surface_pixel_format format,
+								      const enum dc_rotation_angle rotation,
+								      const struct plane_size *plane_size,
+								      union dc_tiling_info *tiling_info,
+								      struct dc_plane_dcc_param *dcc,
+								      struct dc_plane_address *address,
+								      const bool force_disable_dcc)
+{
+	const uint64_t modifier = afb->base.modifier;
+	int ret = 0;
+
+	/* TODO: Most of this function shouldn't be needed on GFX12. */
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, tiling_info);
+
+	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
+
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
+		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
+
+		dcc->enable = 1;
+		dcc->independent_64b_blks = max_compressed_block == 0;
+
+		if (max_compressed_block == 0)
+			dcc->dcc_ind_blk = hubp_ind_block_64b;
+		else if (max_compressed_block == 1)
+			dcc->dcc_ind_blk = hubp_ind_block_128b;
+		else
+			dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
+	}
+
+	/* TODO: This seems wrong because there is no DCC plane on GFX12. */
+	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
+	if (ret)
+		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %d\n", ret);
+
+	return ret;
+}
+
 static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
 						  uint64_t **mods,
 						  uint64_t *size,
@@ -835,7 +875,15 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	if (adev->family >= AMDGPU_FAMILY_AI) {
+	if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
+										 rotation, plane_size,
+										 tiling_info, dcc,
+										 address,
+										 force_disable_dcc);
+		if (ret)
+			return ret;
+	} else if (adev->family >= AMDGPU_FAMILY_AI) {
 		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
 										rotation, plane_size,
 										tiling_info, dcc,
-- 
2.34.1

