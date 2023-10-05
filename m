Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37891E9271C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 17:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B2710E45C;
	Thu,  5 Oct 2023 17:16:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BFA10E458;
 Thu,  5 Oct 2023 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m3bVD2CoGKk8m8IYYWKp1cJsDjPX9P2wVjICfPUHyTE=; b=DRymcGcjlDGOzpWXtormg1ALgO
 T8X62qQyajm8JPO3NolyD/nCUEs6DizNqSjDHIT5ClyNeNbTQNba2PCPtpdw4MX4fOyuSkpBxywSR
 1T5l0gOcMIoRNNhVroSd4fIpXjgb7/mrv4gwfxKuIjTn9H0QCjin2gtpRv7NArOm3fncxOg+oSvQT
 scRgN/CAZ2ococHAWuUqSjXmPQxhn06FbHmu0yAxPMW1DuMgdgBniED+fE0Lb7YWY2ihEn8TS+QeR
 +01xLMbfT1rGnvqsN4pOBR2sb440P219WRGoN0xowWRIZwr2pvFn4p7W2DUFnWcI0ei/claC8totY
 WsqwsCxA==;
Received: from [102.213.205.115] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qoRxN-00CFJN-Hz; Thu, 05 Oct 2023 19:16:13 +0200
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [PATCH v4 20/32] drm/amd/display: reject atomic commit if setting
 both plane and CRTC degamma
Date: Thu,  5 Oct 2023 16:15:15 -0100
Message-Id: <20231005171527.203657-21-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005171527.203657-1-mwen@igalia.com>
References: <20231005171527.203657-1-mwen@igalia.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 kernel-dev@igalia.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC only has pre-blending degamma caps (plane/DPP) that is currently in
use for CRTC/post-blending degamma, so that we don't have HW caps to
perform plane and CRTC degamma at the same time. Reject atomic updates
when serspace sets both plane and CRTC degamma properties.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 6acc9ebc52da..354ab46894d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -943,9 +943,20 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 	has_crtc_cm_degamma = (crtc->cm_has_degamma || crtc->cm_is_degamma_srgb);
 
 	ret = __set_dm_plane_degamma(plane_state, dc_plane_state);
-	if (ret != -EINVAL)
+	if (ret == -ENOMEM)
 		return ret;
 
+	/* We only have one degamma block available (pre-blending) for the
+	 * whole color correction pipeline, so that we can't actually perform
+	 * plane and CRTC degamma at the same time. Explicitly reject atomic
+	 * updates when userspace sets both plane and CRTC degamma properties.
+	 */
+	if (has_crtc_cm_degamma && ret != -EINVAL){
+		drm_dbg_kms(crtc->base.crtc->dev,
+			    "doesn't support plane and CRTC degamma at the same time\n");
+			return -EINVAL;
+	}
+
 	/* If we are here, it means we don't have plane degamma settings, check
 	 * if we have CRTC degamma waiting for mapping to pre-blending degamma
 	 * block
-- 
2.40.1

