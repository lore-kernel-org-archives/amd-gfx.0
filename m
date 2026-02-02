Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27D9E73154
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD8710E3FE;
	Mon,  2 Feb 2026 10:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZuK04fpY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BCF10E3F3;
 Mon,  2 Feb 2026 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026864; x=1801562864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PzPjAdJEfKrmv6HxPebVf9x8sFqlkyOCv6/jRAU5Whk=;
 b=ZuK04fpYrqwmeBqnlirLkCeciFoVEPgmvh6VB77XcxQpSde2Srir4fRj
 MNkIxbG939HgXmBBkiPyr+Y44WO52+fQzoR7YxHVoGNiM5pMv62x+Lv7x
 PSUlD9z3+LLCQzWqFeyHg+Ll3aDedYbg71se90V19t/UOQtmkSkjZlQO2
 mAEr/4t3LqkKxRdkrnr2UNmKVR2zxmRoKsFUQGpgtJ9fPMp8P8eVpyrwL
 MV8Z+RWcJhrC2A1ZQt5W2g/Xx5cI5N4uqfxS01yG6NDEsmcAdSyF5nMu2
 cKBZWitIgOFY4kBDrEm54aX9nrFZ1QCBwuS3f4gqqxKORZwvzp3WRLK6H w==;
X-CSE-ConnectionGUID: 6m24qNI9S/KyL8qSF6jTWw==
X-CSE-MsgGUID: cihGLE6/QEu+BHw3c8LS/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163387"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163387"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:43 -0800
X-CSE-ConnectionGUID: Xb+fytWoToKVc8zdtnJGsw==
X-CSE-MsgGUID: gwGgbyL2RUOwkk8+WDW21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984851"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:39 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 5/9] drm/i915/display: Hook up intel_colorop_destroy
Date: Mon,  2 Feb 2026 15:11:58 +0530
Message-Id: <20260202094202.2871478-6-chaitanya.kumar.borah@intel.com>
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

i915 embeds struct drm_colorop inside struct intel_colorop, so the
default drm_colorop_destroy() helper cannot be used. Add an
intel_colorop_destroy() helper that performs common DRM cleanup and
frees intel_colorop object.

This ensures correct teardown of plane color pipeline objects.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 13 +++++++++----
 drivers/gpu/drm/i915/display/intel_colorop.c        |  6 ++++++
 drivers/gpu/drm/i915/display/intel_colorop.h        |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index d3d73d60727c..8fecc53540ba 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -13,6 +13,10 @@
 #define PLANE_DEGAMMA_SIZE 128
 #define PLANE_GAMMA_SIZE 32
 
+static const struct drm_colorop_funcs intel_colorop_funcs = {
+	.destroy = intel_colorop_destroy,
+};
+
 static
 int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_enum_list *list,
 				     enum pipe pipe)
@@ -25,7 +29,7 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 
 	colorop = intel_colorop_create(INTEL_PLANE_CB_PRE_CSC_LUT);
 
-	ret = drm_plane_colorop_curve_1d_lut_init(dev, &colorop->base, plane, NULL,
+	ret = drm_plane_colorop_curve_1d_lut_init(dev, &colorop->base, plane, &intel_colorop_funcs,
 						  PLANE_DEGAMMA_SIZE,
 						  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
@@ -39,7 +43,7 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	prev_op = &colorop->base;
 
 	colorop = intel_colorop_create(INTEL_PLANE_CB_CSC);
-	ret = drm_plane_colorop_ctm_3x4_init(dev, &colorop->base, plane, NULL,
+	ret = drm_plane_colorop_ctm_3x4_init(dev, &colorop->base, plane, &intel_colorop_funcs,
 					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		return ret;
@@ -52,7 +56,8 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	    plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		colorop = intel_colorop_create(INTEL_PLANE_CB_3DLUT);
 
-		ret = drm_plane_colorop_3dlut_init(dev, &colorop->base, plane, NULL, 17,
+		ret = drm_plane_colorop_3dlut_init(dev, &colorop->base, plane,
+						   &intel_colorop_funcs, 17,
 						   DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
 						   true);
 		if (ret)
@@ -64,7 +69,7 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	}
 
 	colorop = intel_colorop_create(INTEL_PLANE_CB_POST_CSC_LUT);
-	ret = drm_plane_colorop_curve_1d_lut_init(dev, &colorop->base, plane, NULL,
+	ret = drm_plane_colorop_curve_1d_lut_init(dev, &colorop->base, plane, &intel_colorop_funcs,
 						  PLANE_GAMMA_SIZE,
 						  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
diff --git a/drivers/gpu/drm/i915/display/intel_colorop.c b/drivers/gpu/drm/i915/display/intel_colorop.c
index 1d84933f05aa..9e54f51cfad8 100644
--- a/drivers/gpu/drm/i915/display/intel_colorop.c
+++ b/drivers/gpu/drm/i915/display/intel_colorop.c
@@ -35,3 +35,9 @@ struct intel_colorop *intel_colorop_create(enum intel_color_block id)
 
 	return colorop;
 }
+
+void intel_colorop_destroy(struct drm_colorop *colorop)
+{
+	drm_colorop_cleanup(colorop);
+	kfree(to_intel_colorop(colorop));
+}
diff --git a/drivers/gpu/drm/i915/display/intel_colorop.h b/drivers/gpu/drm/i915/display/intel_colorop.h
index 9276eee6e75a..638baf67d98d 100644
--- a/drivers/gpu/drm/i915/display/intel_colorop.h
+++ b/drivers/gpu/drm/i915/display/intel_colorop.h
@@ -13,5 +13,6 @@ struct intel_colorop;
 struct intel_colorop *to_intel_colorop(struct drm_colorop *colorop);
 struct intel_colorop *intel_colorop_alloc(void);
 struct intel_colorop *intel_colorop_create(enum intel_color_block id);
+void intel_colorop_destroy(struct drm_colorop *colorop);
 
 #endif /* __INTEL_COLOROP_H__ */
-- 
2.25.1

