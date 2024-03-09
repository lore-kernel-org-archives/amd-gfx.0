Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D225C54E58
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Mar 2024 11:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB1D10E10C;
	Sun, 10 Mar 2024 11:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="HmWNhxv6";
	dkim-atps=neutral
X-Greylist: delayed 591 seconds by postgrey-1.36 at gabe;
 Sat, 09 Mar 2024 01:58:13 UTC
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de
 [129.70.45.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD1410FA57
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Mar 2024 01:58:13 +0000 (UTC)
Received: from localhost (dslb-094-217-220-071.094.217.pools.vodafone-ip.de
 [94.217.220.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id A894F60AB6;
 Sat,  9 Mar 2024 02:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=math.uni-bielefeld.de; s=default; t=1709948899;
 bh=PCk2Dugx8SMjdQeWG4SwcfaPM24toHIy+7Yggf23EOY=;
 h=From:To:Cc:Subject:Date:From;
 b=HmWNhxv6lEJ0BxRBPxi3BqczESunuyX/oRe8UOU906evQpJNg2abwr8q2R+7+/3h6
 V+0Jwdmec+Y6s1Z0fC2NwAqdJxkrCSQETryA4JqZ1WNoRf/NOzExQrOCNoXc8fRlms
 f7rJvNbb1ggX355y2jSfRvGfvX0jDjFVocAUkOFutOFUKxbvpClKmffAkKQYHh8rxD
 rh8x9zzIQ7pYIYnKPiAK+GHlofVK3xfLs3vNmlzeypwIQYwV+SIlHA6aA/QX4SukvS
 GwrtBe8YywjnU07+O0LLbBOUsZB0EyaUK64KnCosu0IzGPEOGplrk0RdQoSyAzDk+s
 csqu4d8iRgJzw==
From: tjakobi@math.uni-bielefeld.de
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Add MSF panel to DPCD 0x317 patch list
Date: Sat,  9 Mar 2024 02:47:32 +0100
Message-ID: <20240309014732.722139-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 11:32:02 +0000
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

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

This 8.4 inch panel is integrated in the Ayaneo Kun handheld
device. The panel resolution is 2560×1600, i.e. it has
portrait dimensions.

Decoding the EDID shows:
Manufacturer: MSF
Model: 4099
Display Product Name: 'TV080WUM-NL0 '

Judging from the product name this might be a clone of a
BOE panel, but with larger dimensions.

Panel frequently shows non-functional backlight control. Adding
some debug prints to update_connector_ext_caps() shows that
something the OLED bit of ext_caps is set, and then the driver
assumes that backlight is controlled via AUX.

Forcing backlight control to PWM via amdgpu.backlight=0 restores
backlight operation.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 7a09a72e182f..5a017ba94e3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -68,6 +68,7 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
 	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
 	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
+	case drm_edid_encode_panel_id('M', 'S', 'F', 0x1003):
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
-- 
2.43.0

