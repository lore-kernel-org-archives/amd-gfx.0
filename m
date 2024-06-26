Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8357C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A2910E038;
	Wed, 26 Jun 2024 18:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4a0aUi5";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DEB10E999
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:08 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6b51ae173ceso27826436d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426727; x=1720031527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwKa6U2BOy+5HqQ4yRfe7s9arFRquqQA8SKbpyrPBV8=;
 b=S4a0aUi5GvvoVMGsG7lTuNNuXfB7kl1EN1kdUBum2aMMudca9RxmNoPACxdq49oqo4
 u4/FDksBUySyUDjOn5SBNEEbwQE1J1rqAEwFN4gO4URfXLYKo+wRdW7KNjmN5pqi5DFB
 zDaZTV5LQqsexe0nZxmbJhxUS6xan6CgnaCAUs9RiAi10+MLBFZgSmF0/KSCxWqhetWE
 xMrP745L3OgkUqIBV7gkfZAHZFerFhbuE8G07rnqwGJ2aLtnAmWauoyJ0/6rSueKmwS3
 xKsvZ6bfeicDVTx4Vyydt4g0CpGsvAJq5Lmy4IR/tnKDJ76uEKlM5g/aQqx12z4FYqLX
 +cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426727; x=1720031527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwKa6U2BOy+5HqQ4yRfe7s9arFRquqQA8SKbpyrPBV8=;
 b=QTkPiFawx1TRWqITR6i9IYcZyjvrYSceRiFtpg24GWy4eAn1YcA1CLuAK8zKVu8TIC
 orX/ZLtbdscncd6jUJJnfGGItzof1AFSDMl0cZtBhpzuY9ZUPkmp4JUSRRbGCbGApcHb
 aWr1LUh52SA3H2J0vZo7TaG87cIFRPY80TMgCZ1aA9TpnPAaxBKXRORH0k5okYwECGZw
 24oo3Dp5KW9CxAe6Pqqc9EO0zYZNQ2kKBxP7ACJvmxFwge3zRWGiFgSEAjyabS32+CnR
 7SRelFeEDd/cKJddCp26s+/QcBazvgWXmOPkKQkdbYmnKEoL5H6L/5DWauKiwFx0sKIz
 vYvg==
X-Gm-Message-State: AOJu0Yw2kag1ASVeqQLGrQLfHtxdIwOTEqVPAPI5lRACs9+n9kGf8fcn
 SPnS+8COGaA8ltVi9g+ZiXPCr5Aqta4GGwlcl2ZtNdKdYaZmCY3h7h0CWA==
X-Google-Smtp-Source: AGHT+IGSASPoaXC3H07hiWluWXVZsVXYiTxjyNY236xMgKn60PmpayB42OLJ73wf+XhmZRQA6GFcKQ==
X-Received: by 2002:a0c:f30f:0:b0:6b0:81c8:9f54 with SMTP id
 6a1803df08f44-6b53c00c5bfmr124167356d6.61.1719426727438; 
 Wed, 26 Jun 2024 11:32:07 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:06 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 10/13] drm/amdgpu/display: handle gfx12 in
 amdgpu_dm_plane_format_mod_supported
Date: Wed, 26 Jun 2024 14:31:32 -0400
Message-Id: <20240626183135.8606-10-marek.olsak@amd.com>
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

All this code has undefined behavior on GFX12 and shouldn't be executed.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 47 ++++++++++---------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index bb534b2b0b71..5a6a21e28548 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1419,8 +1419,6 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 	const struct drm_format_info *info = drm_format_info(format);
 	int i;
 
-	enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
-
 	if (!info)
 		return false;
 
@@ -1442,29 +1440,34 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 	if (i == plane->modifier_count)
 		return false;
 
-	/*
-	 * For D swizzle the canonical modifier depends on the bpp, so check
-	 * it here.
-	 */
-	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
-	    adev->family >= AMDGPU_FAMILY_NV) {
-		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
-			return false;
-	}
-
-	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
-	    info->cpp[0] < 8)
-		return false;
+	/* GFX12 doesn't have these limitations. */
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11) {
+		enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
 
-	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
-		/* Per radeonsi comments 16/64 bpp are more complicated. */
-		if (info->cpp[0] != 4)
-			return false;
-		/* We support multi-planar formats, but not when combined with
-		 * additional DCC metadata planes.
+		/*
+		 * For D swizzle the canonical modifier depends on the bpp, so check
+		 * it here.
 		 */
-		if (info->num_planes > 1)
+		if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
+		    adev->family >= AMDGPU_FAMILY_NV) {
+			if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
+				return false;
+		}
+
+		if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
+		    info->cpp[0] < 8)
 			return false;
+
+		if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
+			/* Per radeonsi comments 16/64 bpp are more complicated. */
+			if (info->cpp[0] != 4)
+				return false;
+			/* We support multi-planar formats, but not when combined with
+			 * additional DCC metadata planes.
+			 */
+			if (info->num_planes > 1)
+				return false;
+		}
 	}
 
 	return true;
-- 
2.34.1

