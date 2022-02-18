Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E259C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 10:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A5B10EBEA;
	Fri, 18 Feb 2022 10:04:27 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D82710EB0B;
 Fri, 18 Feb 2022 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645178665; x=1676714665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FHSq9nku0ZBtLOFiRYG5HZlgIPCvJSiPaHrpwRGI1dI=;
 b=YsqILzAc1dSQrv5bT28AhdIV/duCDVISCuO46gXOBdoxShCeS8JJkEwu
 CgpCMAH3Z291ey6ekfFBhrJZZtnqFPn03CKOH25zmX+OYDkGRIomsnigX
 +XQxGn8/TSsR5KSjkJUrxoM434bsgeUxVKaeb0Xq2EQ08MHhyVdwY6T69
 55i5NPwkhXvav5M9Rnv5jp4hBLUCQhQ3yynWsjlVXl8gat7tdZAPDRL+G
 HpTtQjnTqy3xyvpzqGs3cbii2sMRISxbCA8LTLEwQd9fFb9z5kh7zi1Uz
 srWFgMHwXnKYvPBGJCL1XU2SvFXm5Qxlz5rqYPTI2kvlaAgWJUYiNF7zQ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234628567"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; d="scan'208";a="234628567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 02:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; d="scan'208";a="530863247"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
 by orsmga007.jf.intel.com with SMTP; 18 Feb 2022 02:04:18 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 18 Feb 2022 12:04:17 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 02/22] drm/amdgpu: Remove pointless on stack mode copies
Date: Fri, 18 Feb 2022 12:03:43 +0200
Message-Id: <20220218100403.7028-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218100403.7028-1-ville.syrjala@linux.intel.com>
References: <20220218100403.7028-1-ville.syrjala@linux.intel.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Nikola Cornij <nikola.cornij@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

These on stack copies of the modes appear to be pointless.
Just look at the originals directly.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Nikola Cornij <nikola.cornij@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 21dba337dab0..65aab0d086b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10139,27 +10139,27 @@ static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state)
 {
-	struct drm_display_mode old_mode, new_mode;
+	const struct drm_display_mode *old_mode, *new_mode;
 
 	if (!old_crtc_state || !new_crtc_state)
 		return false;
 
-	old_mode = old_crtc_state->mode;
-	new_mode = new_crtc_state->mode;
+	old_mode = &old_crtc_state->mode;
+	new_mode = &new_crtc_state->mode;
 
-	if (old_mode.clock       == new_mode.clock &&
-	    old_mode.hdisplay    == new_mode.hdisplay &&
-	    old_mode.vdisplay    == new_mode.vdisplay &&
-	    old_mode.htotal      == new_mode.htotal &&
-	    old_mode.vtotal      != new_mode.vtotal &&
-	    old_mode.hsync_start == new_mode.hsync_start &&
-	    old_mode.vsync_start != new_mode.vsync_start &&
-	    old_mode.hsync_end   == new_mode.hsync_end &&
-	    old_mode.vsync_end   != new_mode.vsync_end &&
-	    old_mode.hskew       == new_mode.hskew &&
-	    old_mode.vscan       == new_mode.vscan &&
-	    (old_mode.vsync_end - old_mode.vsync_start) ==
-	    (new_mode.vsync_end - new_mode.vsync_start))
+	if (old_mode->clock       == new_mode->clock &&
+	    old_mode->hdisplay    == new_mode->hdisplay &&
+	    old_mode->vdisplay    == new_mode->vdisplay &&
+	    old_mode->htotal      == new_mode->htotal &&
+	    old_mode->vtotal      != new_mode->vtotal &&
+	    old_mode->hsync_start == new_mode->hsync_start &&
+	    old_mode->vsync_start != new_mode->vsync_start &&
+	    old_mode->hsync_end   == new_mode->hsync_end &&
+	    old_mode->vsync_end   != new_mode->vsync_end &&
+	    old_mode->hskew       == new_mode->hskew &&
+	    old_mode->vscan       == new_mode->vscan &&
+	    (old_mode->vsync_end - old_mode->vsync_start) ==
+	    (new_mode->vsync_end - new_mode->vsync_start))
 		return true;
 
 	return false;
-- 
2.34.1

