Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B7AC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 00:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1610EFB0;
	Mon, 20 Jun 2022 00:37:07 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C37B10EFB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 00:37:06 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id eo8so13017454edb.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jun 2022 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IDeXIB88wF1IP6KA4F9e1pN5luOw7R8CAh9NSpdjcO0=;
 b=c26HIfsCjOrTLLmWMfCDFpdQ9fnO0bE8CCSUtMe+a422CZIk8HjQwquVoE3VLXAvMs
 jmnF1E+BKOgdaD0NFpU/xr72TY6uLZhFRF2Zg2WiyTokF57PlWEBkh9sXwfgCN8C4Dmu
 inB30nscWqHDUD3Js0/7UWpGsV4jdnvffIuM6gjChTEvvxN7FLHQD43VZvqOec0fxcxO
 i3+jw+dPH/4l4adV1JGZdqvr31du/2Z1zfteqhoz97GdHQapBGD74tEMx3wXfObWohGc
 giQntv0FAR0z1smq1gFqwAP9xPzC7lS+4AfXEmMsvkAruEMU02KNdL7acIHqpcc2kWix
 NZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IDeXIB88wF1IP6KA4F9e1pN5luOw7R8CAh9NSpdjcO0=;
 b=ekqWDPgwqDZhwYdzodalG7Tq62oZa+2eQNq93dRL7fexxfoF29mSoNchfgzEux8GQ0
 MSnYQj/ksV2TttcuPEc9OWMpg/KeLMXg2RYMaGEKIo3H5Hm5a7qGRZWK4g3/uE4l5f9c
 JGq8mNsoNZASEDv6DJoShrlXlkhXtGjK1H9v4KJaAI32IRrr07v5V638F9LPuVzkqzr9
 05OjL6NSB5eAjQHrJGAldN4GSZBuut1yN0boq3jB2BAk2eIXYC7atVlReU5jRlydScRv
 vF7u1UFLpvavzhoqd7SpixaIWnXiFbDL1MzThRCBL1WXK9kMVrycCI6WA6ytk56Ks3Ou
 wEJA==
X-Gm-Message-State: AJIora9YZu3+QIadaIdegm9uRmRuIfPs2tiW31raso20jeTJ0B19Eadj
 KD48T+b1bd+yAAIHpPySsMOubduIctsX3nzN
X-Google-Smtp-Source: AGRyM1tW6DYMABUlxi5Ujcd8BU2xm+9M8T9JgcLVbzufVc77Kt4twPVEKbNll+M0Lu0Ts4bbTUgGzg==
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id
 b97-20020a509f6a000000b0043558040e07mr21558942edf.178.1655685424970; 
 Sun, 19 Jun 2022 17:37:04 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id
 d18-20020aa7d5d2000000b0043572ffafe0sm3602237eds.92.2022.06.19.17.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jun 2022 17:37:04 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: ignore modifiers when checking for
 format support"
Date: Mon, 20 Jun 2022 02:37:20 +0200
Message-Id: <20220620003720.2049653-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, marek.olsak@amd.com, aurabindo.pillai@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 5089c4a8ebea3c3ad9eedf038dad7098ebc06131.

This breaks validation and enumeration of display capable modifiers.

The early return true means the rest of the validation code never gets
executed, and we need that to enumerate the right modifiers to userspace
for the format.

The modifiers that are in the initial list generated for a plane are the
superset for all formats and we need the proper checks in this function
to filter some of them out for formats with which they're invalid to be
used.

Furthermore, the safety contract here is that we validate the incoming
modifiers to ensure the kernel can handle them and the display hardware
can handle them. This includes e.g. rejecting multi-plane images with DCC.

Note that the legacy swizzle mechanism allows encoding more swizzles, and
at fb creation time we convert them to modifiers and reject those with
no corresponding modifiers. If we are seeing rejections I'm happy to
help define modifiers that correspond to those, or if absolutely needed
implement a fallback path to allow for less strict validation of the
legacy path.

However, I'd like to revert this patch, since any of these is going to
be a significant rework of the patch, and I'd rather not the regression
gets into a release or forgotten in the meantime.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++----------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60fb99b74713..698741fd39f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4936,7 +4936,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
-	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
+	int i;
+
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
 	if (!info)
@@ -4952,53 +4953,13 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return true;
 	}
 
-	/* check if swizzle mode is supported by this version of DCN */
-	switch (asic_id.chip_family) {
-		case FAMILY_SI:
-		case FAMILY_CI:
-		case FAMILY_KV:
-		case FAMILY_CZ:
-		case FAMILY_VI:
-			/* asics before AI does not have modifier support */
-			return false;
-			break;
-		case FAMILY_AI:
-		case FAMILY_RV:
-		case FAMILY_NV:
-		case FAMILY_VGH:
-		case FAMILY_YELLOW_CARP:
-		case AMDGPU_FAMILY_GC_10_3_6:
-		case AMDGPU_FAMILY_GC_10_3_7:
-			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_D:
-					return true;
-					break;
-				default:
-					return false;
-					break;
-			}
-			break;
-		case AMDGPU_FAMILY_GC_11_0_0:
-			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-				case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-				case AMD_FMT_MOD_TILE_GFX9_64K_D:
-					return true;
-					break;
-				default:
-					return false;
-					break;
-			}
-			break;
-		default:
-			ASSERT(0); /* Unknown asic */
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
 			break;
 	}
+	if (i == plane->modifier_count)
+		return false;
 
 	/*
 	 * For D swizzle the canonical modifier depends on the bpp, so check
-- 
2.36.1

