Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D9AE73154
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C6F10E3E9;
	Mon,  2 Feb 2026 10:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VcWsVGJ7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8EF10E3F5;
 Mon,  2 Feb 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026854; x=1801562854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tVBxMwmyrvdsRQDP8mjPipyih2FzPy/4vofEOhkA6Zc=;
 b=VcWsVGJ782vQMANjVTVT9KJoNpMnHTkp3bbx1OSll7W4k40C6BlDDScj
 lC1d35KYvDM29MvrycBpLgNRda8k9CtcgzZaVEzrlHWYJgDLlay72A1QM
 ydiV9/ficq7ZeMMO8Gnhg09+SDF5nZJSym7Z0bYT3Fgdd4EXnFpzlb0eJ
 E+uls2pnGMxZZ9BXeZFoRjNGEzEmN4tDMEcmALvt8y0qBosy9CZlRHHUf
 bcuUqeeg+LiyMx9p7YKqjqdt6Z6hZSSRQUQrsOGk/ohCYwq80RWYZ3PTn
 Me2ocXChchgfWjo6kzkrPYXu11B+7/o6EiKPyNskMKp5YN63JjvhwM51m g==;
X-CSE-ConnectionGUID: KZ+5yehwSPizp10ODjAJPw==
X-CSE-MsgGUID: Rc4p8Ew6RXaP1v/XbemEBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163361"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163361"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:34 -0800
X-CSE-ConnectionGUID: 8zPT1m+cTyihwynQvVwXlw==
X-CSE-MsgGUID: VkbvS10dROugBK/wU5pysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984829"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:29 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 3/9] drm/amd/display: Hook up colorop destroy helper for
 plane pipelines
Date: Mon,  2 Feb 2026 15:11:56 +0530
Message-Id: <20260202094202.2871478-4-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260202094202.2871478-1-chaitanya.kumar.borah@intel.com>
References: <20260202094202.2871478-1-chaitanya.kumar.borah@intel.com>
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

Provide a drm_colorop_funcs instance for amdgpu_dm color pipeline
objects and hook up the common drm_colorop_destroy() helper as the
destroy callback.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index dfdb4fb4219f..5130962193d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -55,6 +55,10 @@ const u64 amdgpu_dm_supported_blnd_tfs =
 
 #define LUT3D_SIZE		17
 
+static const struct drm_colorop_funcs dm_colorop_funcs = {
+	.destroy = drm_colorop_destroy,
+};
+
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
 {
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
@@ -72,7 +76,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, NULL,
+	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
 					      amdgpu_dm_supported_degam_tfs,
 					      DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
@@ -89,7 +93,8 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_mult_init(dev, ops[i], plane, NULL, DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = drm_plane_colorop_mult_init(dev, ops[i], plane, &dm_colorop_funcs,
+					  DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
@@ -104,7 +109,8 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, NULL,
+	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane,
+					     &dm_colorop_funcs,
 					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
@@ -121,7 +127,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, NULL,
+		ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
 						amdgpu_dm_supported_shaper_tfs,
 						DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
@@ -138,7 +144,8 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane, NULL,
+		ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane,
+							&dm_colorop_funcs,
 							MAX_COLOR_LUT_ENTRIES,
 							DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 							DRM_COLOROP_FLAG_ALLOW_BYPASS);
@@ -156,7 +163,8 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_3dlut_init(dev, ops[i], plane, NULL, LUT3D_SIZE,
+		ret = drm_plane_colorop_3dlut_init(dev, ops[i], plane,
+					&dm_colorop_funcs, LUT3D_SIZE,
 					DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
 					DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
@@ -174,7 +182,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, NULL,
+	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
 					      amdgpu_dm_supported_blnd_tfs,
 					      DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
@@ -191,7 +199,8 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane, NULL, MAX_COLOR_LUT_ENTRIES,
+	ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane, &dm_colorop_funcs,
+						  MAX_COLOR_LUT_ENTRIES,
 						  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
-- 
2.25.1

