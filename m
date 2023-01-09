Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF40C5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 14:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADFF10E4A1;
	Mon,  9 Jan 2023 14:44:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7091310E451;
 Mon,  9 Jan 2023 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2zK6khS89ThpmVaHiRDcsbcddbtTFdwhm1vSRQdPNqQ=; b=f1FH40gSKxdQJGhbFNvdkdwPo2
 2X2NSIOskXk+ypl8si36Usf3NWqtJqUwuak0ujIcj1akVquJuy5uooBVl5gdOtYW15GVUP5eQl4Rv
 41f/Ukbr7PJ6dGpgqi4hcQd4siyK38kSRKkaIenpC0PszhAy5cXygnEYs1RdODCMHI/rC+qeqVFNF
 9rcB8IeJ7za8s1OKx6lQTdK/b5dI9hw/gqb7TIEkJkWkkO0K0TAnH2RhdO6wgC4lqa8ss2yH0avGO
 gNuDzcLqnZbA/WVl+FD5QCfdavInGcUBEFB4eLZBPFJxQO/b4qB0WYroX+S9NM07+VHO3qZah/O2g
 JI1IZbZA==;
Received: from [41.74.137.107] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pEtO7-003TyM-73; Mon, 09 Jan 2023 15:44:35 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [RFC PATCH v2 17/18] drm/amd/display: decouple steps to reuse in
 shaper LUT support
Date: Mon,  9 Jan 2023 13:38:45 -0100
Message-Id: <20230109143846.1966301-18-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
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
Cc: laurent.pinchart+renesas@ideasonboard.com, kernel-dev@igalia.com,
 Shashank Sharma <shashank.sharma@amd.com>, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 linux-kernel@vger.kernel.org, mripard@kernel.org,
 Melissa Wen <mwen@igalia.com>, seanpaul@chromium.org,
 ville.syrjala@linux.intel.com, tzimmermann@suse.de,
 amd-gfx@lists.freedesktop.org, bhawanpreet.lakha@amd.com,
 nicholas.kazlauskas@amd.com, Joshua Ashton <joshua@froggi.es>,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Decouple steps of shaper LUT setup and LUT size validation according to
HW caps as a preparation for shaper LUT support.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 0fb1244c8aef..8a930f9bce60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -497,6 +497,19 @@ static void amdgpu_dm_atomic_lut3d(struct dc_stream_state *stream,
 	stream->lut3d_func = lut;
 }
 
+static int amdgpu_dm_atomic_shaper_lut(struct dc_stream_state *stream,
+				       struct dc_transfer_func *func_shaper_new)
+{
+	/* We don't get DRM shaper LUT yet. We assume the input color space is already
+	 * delinearized, so we don't need a shaper LUT and we can just BYPASS
+	 */
+	func_shaper_new->type = TF_TYPE_BYPASS;
+	func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
+	stream->func_shaper = func_shaper_new;
+
+	return 0;
+}
+
 /* amdgpu_dm_atomic_shaper_lut3d - set DRM CRTC shaper LUT and 3D LUT to DC
  * interface
  * @dc: Display Core control structure
@@ -519,18 +532,11 @@ static int amdgpu_dm_atomic_shaper_lut3d(struct dc *dc,
 	lut3d_func_new = (struct dc_3dlut *) stream->lut3d_func;
 	func_shaper_new = (struct dc_transfer_func *) stream->func_shaper;
 
-	/* We don't get DRM shaper LUT yet. We assume the input color space is
-	 * already delinearized, so we don't need a shaper LUT and we can just
-	 * BYPASS.
-	 */
-	func_shaper_new->type = TF_TYPE_BYPASS;
-	func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
-	stream->func_shaper = func_shaper_new;
 
 	amdgpu_dm_atomic_lut3d(stream, drm_lut3d, drm_lut3d_size,
 			       mode, lut3d_func_new);
 
-	return 0;
+	return amdgpu_dm_atomic_shaper_lut(stream, func_shaper_new);
 }
 
 static const struct drm_mode_lut3d_mode *
-- 
2.35.1

