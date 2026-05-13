Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DBCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE83B10F063;
	Wed, 13 May 2026 20:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="leOYf8Yh";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057AB10F063
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:43:32 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso4679014f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778705010; x=1779309810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP3f76GD0ZHV/3ViPToVlxZc75dP9ukWETDGRtcVFoo=;
 b=leOYf8Yhx7vDe1GxxWkV/UD9ss/CdzQKQANgrUlXTGTz5KgW6p3DU5PsouKorcONFV
 DcuGjGH0yMlU0Q+NE8+pAPIJswB8d0XC0z1HBQ1YG+iJ/9fD4rW1QW5Auo3weWicoyKh
 DaMHpQs96DLBFd+34LRR1kNfRvDpjQF7c/ktwPCQREyA1Y+Hu+Z+wwZbm1Uvmryfr+e8
 fgFi6MrD66RA+awpW+7l/LZExITyLrmnZB6+Fo5TpMRuwG/xTY5qMEP8QNyP7xUndw7G
 4CXts2Zoem/WsVlbufC30d808uESdEmetW6lVBx08iI9oO/eYRshC7qWfBTEi6j/cV7/
 DhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705010; x=1779309810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kP3f76GD0ZHV/3ViPToVlxZc75dP9ukWETDGRtcVFoo=;
 b=irQCJcALLYWfhieCfRFU7bax/nDNZYe3O5Zu5bYhOwmfCNbVyFtzurLSW8xQ44EwKT
 7XL67Ei1EEv4eeFnV66NdLZKszu+1V7J4VgX58YWeTvRfTKeeatxI+NsbpDFF/0pHOGT
 el0MR7Rmf7dxIXJ2yUrRmpjLP1S8WBh4Wm2XmbYuub9nmOq1fNcNk2ZtU4BVe+dozIDK
 WA1tMISYwRV0jdWhoEhYuPiTQlKTjxK9nWKPAMVMTZLtrXWUIPoHChrkc/vti5/PCIss
 1qeMPdu85Jluyz7OSFbJCspYLwRFEPW9ANqsa5b+Sbv2rbZCeTIMKM+zFBamzl/gurlq
 yzww==
X-Gm-Message-State: AOJu0Yx4fHXYskmvLfR6MW6HkFudkCEA2fVJI7dW6tBYGzczZL0VAIO5
 z8GWrZxSYn9+HOMJesgK0d8liCbeaTWLm+Y6ShzNg/Oex+emzXwbKLZSPmryID6K
X-Gm-Gg: Acq92OHuxunxEMawqVwcRZC7rnXaUgHBppy3YrpAuIFXgkQpFjSkeOFADauk7hCjVi+
 iKBHYSpx/+pY6kw3FQQRsQ7CKpX6+YtryWnMztJidnUU/BH5/MLgeyhJC6W9M6CN7s2P47mYIiq
 Us5U4/dK8fQ/RsyJ3wyL+WPcX2D7LjGVC1ETlq5Qb3vJWy6+DANLrwgT0QmYPzmw+bfMdcB3jTj
 cdI5/NFMkrxsWP6FcRrBYddr+zZznhNHVy4CVpSvOY+74y5JL8QKDlR0aMXZcEeLIbzCvoC24gq
 Bkr7Ox1hJXmlF4TlWHsbdDrzjcbhdXIi5ltBbW1fKL0inx3d2kVZQjkomFF/9wLaFbRzJwLyp8p
 KxjAB0QVWfEuwndbZmJf9k6YLtkLljp0gVyAPP3sS7MlMEmCemc/sItYg2f2jngG8jclt2MR27C
 V/IlCwqSSs3I4CsOUbgxpwut/qEYCoeT9KoHlzsfZEGk7wZivj2ZQDh3TmxYIZ+glxVFBxLl7Qq
 A8=
X-Received: by 2002:a05:6000:26c2:b0:45a:1b61:9f9a with SMTP id
 ffacd0b85a97d-45c580cdfccmr7756180f8f.1.1778705010474; 
 Wed, 13 May 2026 13:43:30 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm1308356f8f.21.2026.05.13.13.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:43:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
Date: Wed, 13 May 2026 22:43:22 +0200
Message-ID: <20260513204322.73542-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204322.73542-1-timur.kristof@gmail.com>
References: <20260513204322.73542-1-timur.kristof@gmail.com>
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

All supported GPU generations now support DRM format modifiers.
Remove all code from amdgpu_dm that dealt with tiling flags.

Note that the legacy non-DC display code still relies on
tiling flags, so we can't remove them outside of DC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +---------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 53 +++----------------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  1 -
 3 files changed, 8 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c41f017fe8f2..a9cb085d7029 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6299,7 +6299,6 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface)
@@ -6397,7 +6396,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 		return ret;
 
 	ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, plane_info->format,
-					   plane_info->rotation, tiling_flags,
+					   plane_info->rotation,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
 					   &plane_info->dcc, address,
@@ -6433,7 +6432,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
-					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
 					  afb->tmz_surface);
@@ -10221,7 +10219,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
-			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
@@ -12123,8 +12120,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
 
 		/* Tiling and DCC changes also require bandwidth updates. */
-		if (old_afb->tiling_flags != new_afb->tiling_flags ||
-		    old_afb->base.modifier != new_afb->base.modifier)
+		if (old_afb->base.modifier != new_afb->base.modifier)
 			return true;
 	}
 
@@ -12136,9 +12132,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 			      struct drm_framebuffer *fb)
 {
 	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
-	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
 	unsigned int pitch;
-	bool linear;
 
 	if (fb->width > new_acrtc->max_cursor_width ||
 	    fb->height > new_acrtc->max_cursor_height) {
@@ -12173,25 +12167,6 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 		return -EINVAL;
 	}
 
-	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier.
-	 */
-	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
-		} else if (adev->family >= AMDGPU_FAMILY_AI) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
-		} else {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
-		}
-		if (!linear) {
-			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
-			return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 24e3510613ce..c5203d7b1a44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -190,39 +190,6 @@ static unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
 
-static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
-							     uint64_t tiling_flags)
-{
-	/* Fill GFX8 params */
-	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
-		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
-
-		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
-		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
-		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
-		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
-		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
-
-		tiling_info->gfxversion = DcGfxVersion8;
-		/* XXX fix me for VI */
-		tiling_info->gfx8.num_banks = num_banks;
-		tiling_info->gfx8.array_mode =
-				DC_ARRAY_2D_TILED_THIN1;
-		tiling_info->gfx8.tile_split = tile_split;
-		tiling_info->gfx8.bank_width = bankw;
-		tiling_info->gfx8.bank_height = bankh;
-		tiling_info->gfx8.tile_aspect = mtaspect;
-		tiling_info->gfx8.tile_mode =
-				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
-	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
-			== DC_ARRAY_1D_TILED_THIN1) {
-		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
-	}
-
-	tiling_info->gfx8.pipe_config =
-			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
-}
-
 static int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(struct dc_tiling_info *tiling_info,
 							       uint64_t modifier)
 {
@@ -1127,7 +1094,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
 			     const enum surface_pixel_format format,
 			     const enum dc_rotation_angle rotation,
-			     const uint64_t tiling_flags,
 			     struct dc_tiling_info *tiling_info,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
@@ -1188,28 +1154,22 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
+	if (adev->family == AMDGPU_FAMILY_GC_12_0_0)
 		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
 										 address);
-		if (ret)
-			return ret;
-	} else if (adev->family >= AMDGPU_FAMILY_AI) {
+	else if (adev->family >= AMDGPU_FAMILY_AI)
 		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
 										rotation, plane_size,
 										tiling_info, dcc,
 										address);
-		if (ret)
-			return ret;
-	} else if (!afb->base.modifier) {
-		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
-	} else {
+	else
 		ret = amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info,
 									  afb->base.modifier);
-		if (ret)
-			return ret;
-	}
+
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -1296,7 +1256,6 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 
 		amdgpu_dm_plane_fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
-			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
 			afb->tmz_surface);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index ea2619b507db..91c05b744b98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -46,7 +46,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 				 const struct amdgpu_framebuffer *afb,
 				 const enum surface_pixel_format format,
 				 const enum dc_rotation_angle rotation,
-				 const uint64_t tiling_flags,
 				 struct dc_tiling_info *tiling_info,
 				 struct plane_size *plane_size,
 				 struct dc_plane_dcc_param *dcc,
-- 
2.54.0

