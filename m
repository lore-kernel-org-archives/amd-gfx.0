Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504BC27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6919F10E99A;
	Wed, 26 Jun 2024 18:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgTBOrVY";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACFE10E98F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:04 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-79d5495fe01so51262585a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426722; x=1720031522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiAFXZq8OPgr/g5sEePqNiqKX1AvUAl1qcubsUtsyK4=;
 b=jgTBOrVYoOkkkRoHUlHNUaM2LJJDo6/8gBP92wSRs9DmhlIcj58HTkfod3ACuDlWdJ
 ZIwWKNomBDJ+cucGQe6DSxdYgIRu9r/19bJQmOGe16o1Oy8gh9pBUxRZR5/MaQ8cvfQN
 dy1t/XZEMCDVi2EaSBkPFW6m0p831sKWwaxJXwNqDVVjThYkNxN5rp56/9EJd/QyVtJE
 bBr6fglK+QB9v69nxLCS/JKHYq+Nk8ow+3UUYiFYfri0cu+rBa/JZiX5RZjg1Y+ToBO+
 SsodnfVO5eT2dOoxryPb8/ivscr7HiJLZO6lAC5wLFHr1hu4finU+XhlMKEsICKlK29t
 no2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426722; x=1720031522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiAFXZq8OPgr/g5sEePqNiqKX1AvUAl1qcubsUtsyK4=;
 b=vFnO7L7tlcng+QKsaMHVsoJfI8kBPWKl1HOIoHeGSZK1j67ikXcEHTNYcxroajEd7q
 iwq14XlFrNOJt0v/VcuC+c6FTL//08AW8mstBaXLybbvEFzI05FFeh+fw2F88EsHKnLv
 CL77ZBEx7Xd+V2JdUu3aPcDO7D0kH7VifiDJmCI8Ywmwq63BpXxWdpInBL9KQoC1YvuD
 z0Ff0pkIVmSlcElickXeKQgL7iMZquM0nOxRHd5M9AMKwgPxyuiqbm6L0SUpdXO05QaN
 AOH+sGtWk91cOql3HDaoOoqwxRdQTAT64x5MolAUn6kh/ZfdR5pMd7+vUtLp+mwPBd7Y
 MCUg==
X-Gm-Message-State: AOJu0YyNmLVBY4FALwXGHfDY/+Tz/Idbf899W3xzk040GTp8tA4KYeOS
 mGjsKzUid5SOAtrAvpLVfstu6oeq+fOGlayvU3LuUe1BsrE0CPxv5DKv2g==
X-Google-Smtp-Source: AGHT+IHuAfD1yQ0B+vhJyHE2YJ7m3Bz74oTMPlmqSZoCFD/fucPK/ZvRoKhDLk6zOWEG+6H8VAyNfg==
X-Received: by 2002:a0c:8bc2:0:b0:6b5:40c:f108 with SMTP id
 6a1803df08f44-6b5409e0ba3mr123827006d6.37.1719426722464; 
 Wed, 26 Jun 2024 11:32:02 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:01 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 06/13] drm/amdgpu/display: handle gfx12 in dm_check_cursor_fb
Date: Wed, 26 Jun 2024 14:31:28 -0400
Message-Id: <20240626183135.8606-6-marek.olsak@amd.com>
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

Checking SWIZZLE_MODE has undefined behavior on gfx12.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f99ba6aa6a7..c3347e8bee54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10666,12 +10666,14 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	 * check tiling flags when the FB doesn't have a modifier.
 	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family < AMDGPU_FAMILY_AI) {
+		if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
+		} else if (adev->family >= AMDGPU_FAMILY_AI) {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
+		} else {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
 				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
-		} else {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
 		}
 		if (!linear) {
 			DRM_DEBUG_ATOMIC("Cursor FB not linear");
-- 
2.34.1

