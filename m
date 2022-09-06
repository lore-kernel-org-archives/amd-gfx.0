Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D7ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4582710E090;
	Tue,  6 Sep 2022 16:47:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6172010E6FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LKOUDLK0h5rmRF5IzlxK/AsbhiwuojpuciWhmyigLx4=; b=ZhAj4TrdUplUC0A5YiQCAM8ga0
 87bZhM1hBPLA9+Z6k0BDqyUdJOXZQCX6pHhYxP+fMlAuB3YJS7+NYAZdqAB+4zgeyot9PJ+b2YC3q
 Zl1dgVU0XKwqKAL5v2TJTySOdUtULzPKcY07EC482swcC02t368wpn78oX1HUr+QVKhXLW1byKmsK
 Y/DDj1b8kxpFTlbPs7G1jqLGLSAPCnZg+fgPHC3k4srwRcDvBQPTj+WAp0AOphwmxYmpzI0f/vjB+
 fj+CrVulM4YvzCJuoU2bS2pggWLxYXwfsMTS8ACu+Dxo2CqpvsM45INUReq7Ag9lMmdh4bSP5esy1
 yWYwpasA==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbjI-00CALM-KE; Tue, 06 Sep 2022 18:47:16 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 9/9] drm/amd/display: enable DRM shaper and 3D LUT
 properties
Date: Tue,  6 Sep 2022 15:46:28 -0100
Message-Id: <20220906164628.2361811-10-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shaper LUT and 3D LUT programming is done, so make the DRM color
properties available.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index c89594f3a5cb..b165a0c269fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -452,6 +452,12 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	dm->adev->mode_info.crtcs[crtc_index] = acrtc;
 	drm_crtc_enable_color_mgmt(&acrtc->base, MAX_COLOR_LUT_ENTRIES,
 				   true, MAX_COLOR_LUT_ENTRIES);
+
+	if (dm->dc->caps.color.mpc.num_3dluts)
+		drm_crtc_enable_lut3d(&acrtc->base,
+				      MAX_COLOR_LUT_ENTRIES,
+				      MAX_COLOR_3DLUT_ENTRIES);
+
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
 
 	return 0;
-- 
2.35.1

