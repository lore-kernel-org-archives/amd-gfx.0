Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F15EEE6B6A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 22:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF2210E953;
	Fri,  6 Feb 2026 22:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kPdzXVFj";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174C110E94F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 22:39:48 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso17006845e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770417586; x=1771022386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nC/CLADSz1/RKI81/8Wfm/loaE6jM2lExFPSIaWRTkQ=;
 b=kPdzXVFj+LLHgxF7htFwWMUI6oV8PJ4S5N+OIFwbtOznyl5IlNC8boBVTJnSiTAKFD
 wbXU1ZMtn/lRCCOaytQgvapLEsoiRHPSugguiXYldT0QgbxdcJD9ub0Ds6J1KMxTRd5Z
 rFQ9/D33PHby566B6eiFg6bvIvecpD/3T5sVCkZnG2f1W2HEtqtxsWJAiC6tthohbkb9
 nBAXn8DRdwUx0Cn3hqyJiljnEo1yIlYvD1CdBPTL579fGn4dlXfXFWEWs98wihGst9dP
 eV7uqt+3tm98RBEPrGc4NHVchE5uCLsDioRm5mM2hFc4ap+8rt4EpM4yqHJyy5UHgKJG
 kZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770417586; x=1771022386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nC/CLADSz1/RKI81/8Wfm/loaE6jM2lExFPSIaWRTkQ=;
 b=ue236X22EamAOOEm2wct1qhtZ1aAsycNaJMhRx7RRV64Ek2xSWiTQVN1jTSRONxA9m
 DwEbSLkJw6zu3EJr9WurrG8fEDZ5ZibdtEBdUAKrkVtVuxHKfKjt6wKmj25zB34phm7W
 6PNxITkRHI9lHWC/fXdX+h7dsG1Q2U96z0urM3V6FY8PJqmvf8RCOM3DVJf3sbsRwamX
 uZWmZgyxI5R24G9ITSc3f7/peEItWOZXk5BXYKsK4YWufZw6G4rWpwd598cPsvlPBquQ
 VuJ2/iAfcHI/BG4r++Ad1xeOVJzwAI6GpH0qvALHSy83gey9y9iYmzTE0wQofuellzLM
 G0zA==
X-Gm-Message-State: AOJu0YyiDDXaL2rD9m3lmtgbO4FiTD49EdHcHAGaFCRVe4qVoSjEOYU7
 DbDkjUGYtvVaOh9CiKBdWvtbbcd1Yc2/N1VSx+iFNrQbu7grKluMaUwtpKLVwg==
X-Gm-Gg: AZuq6aIwGwdrp9IFMiUA8IG65Oeu13yzMrWb9EYTCPRj0P3on93L4dXtAmFqf0BQL/4
 N3yHEm7xpQS8Xrykznu+Kd4AXD9sJNVMBL3UClpyGbtqd5uTZy5+Mi9WsyQXuytaRn1pirZFVbR
 rgRJc3bGnZpn22BGitU1d2B2yP7DwgZelaYvOR4iAZGXL6ZGm3jF+ZVF3pNsv0mR+8quV26SqtH
 Qq4nk5mlWicXGWtY9XpINl51mf3sK+1ynkhostaQac/TRB0LrZx3F5A/XAmezFT2OIvT1g62T7b
 vQJ+sU8rdJG2bldKz4Q9VWAXjKKrS0hOu2F3Lp9P3vn2qUyyP8T2V28XNLFIYAZPC+sDVsopEO0
 LbwKGE3qoNphqGZkokVCz8hWwxeviQHGesppx8D2RiBTAHPAmDv3xM5r2s3/L5VovQFn4MoeSZH
 N6W8NJBzoHujfy1pIlTwwRR5+Kr0WUKPGI9FFjAD/Or8WNkJJiuB3mchetNWVy0RLJp/OKfPXAO
 nTJnMmbNVA1MWj5vDnPRFc0j5wTC3evphwCj9VxsRvhuz/bAVSS6/TN
X-Received: by 2002:a05:600c:4449:b0:480:32da:f33e with SMTP id
 5b1f17b1804b1-48320216075mr70766265e9.17.1770417585968; 
 Fri, 06 Feb 2026 14:39:45 -0800 (PST)
Received: from groovy.localdomain
 (dynamic-2a02-3100-6338-cb00-9208-8a8e-8354-3ed2.310.pool.telefonica.de.
 [2a02:3100:6338:cb00:9208:8a8e:8354:3ed2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320736953sm75292715e9.15.2026.02.06.14.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:39:45 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Use same max plane scaling limits for all 64
 bpp formats
Date: Fri,  6 Feb 2026 23:38:28 +0100
Message-ID: <20260206223828.33061-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The plane scaling hw seems to have the same min/max plane scaling limits
for all 16 bpc / 64 bpp interleaved pixel color formats.

Therefore add cases to amdgpu_dm_plane_get_min_max_dc_plane_scaling() for
all the 16 bpc fixed-point / unorm formats to use the same .fp16
up/downscaling factor limits as used by the fp16 floating point formats.

So far, 16 bpc unorm formats were not handled, and the default: path
returned max/min factors for 32 bpp argb8888 formats, which were wrong
and bigger than what many DCE / DCN hw generations could handle.

The result sometimes was misscaling of framebuffers with
DRM_FORMAT_XRGB16161616, DRM_FORMAT_ARGB16161616, DRM_FORMAT_XBGR16161616,
DRM_FORMAT_ABGR16161616, leading to very wrong looking display, as tested
on Polaris11 / DCE-11.2.

So far this went unnoticed, because only few userspace clients used such
16 bpc unorm framebuffers, and those didn't use hw plane scaling, so they
did not experience this issue.

With upcoming Mesa 26 exposing 16 bpc unorm formats under both OpenGL
and Vulkan under Wayland, and the upcoming GNOME 50 Mutter Wayland
compositor allowing for direct scanout of these formats, the scaling
hw will be used on these formats if possible for HiDPI display scaling,
so it is important to use the correct hw scaling limits to avoid wrong
display.

Tested on AMD Polaris 11 / DCE 11.2 with upcoming Mesa 26 and GNOME 50
on HiDPI displays with scaling enabled. The mutter Wayland compositor now
correctly falls back to scaling via desktop compositing instead of direct
scanout, thereby avoiding wrong image display. For unscaled mode, it
correctly uses direct scanout.

Fixes: 580204038f5b ("drm/amd/display: Enable support for 16 bpc fixed-point framebuffers.")
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index d3e62f511c8f..394880ec1078 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1060,10 +1060,15 @@ static void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 		*min_downscale = plane_cap->max_downscale_factor.nv12;
 		break;
 
+	/* All 64 bpp formats have the same fp16 scaling limits */
 	case DRM_FORMAT_XRGB16161616F:
 	case DRM_FORMAT_ARGB16161616F:
 	case DRM_FORMAT_XBGR16161616F:
 	case DRM_FORMAT_ABGR16161616F:
+	case DRM_FORMAT_XRGB16161616:
+	case DRM_FORMAT_ARGB16161616:
+	case DRM_FORMAT_XBGR16161616:
+	case DRM_FORMAT_ABGR16161616:
 		*max_upscale = plane_cap->max_upscale_factor.fp16;
 		*min_downscale = plane_cap->max_downscale_factor.fp16;
 		break;
-- 
2.43.0

