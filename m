Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03310C04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0A010E4D0;
	Wed,  2 Aug 2023 07:20:09 +0000 (UTC)
Received: from out28-107.mail.aliyun.com (out28-107.mail.aliyun.com
 [115.124.28.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1EE10E487;
 Wed,  2 Aug 2023 02:52:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1871421|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.114493-0.00247554-0.883031; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047212; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6NOoqR_1690944723; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6NOoqR_1690944723) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:52:05 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dce110_timing_generator.c
Date: Wed,  2 Aug 2023 02:52:02 +0000
Message-Id: <20230802025202.10282-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 27cbb5b42c7e..6424e7f279dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -288,7 +288,7 @@ bool dce110_timing_generator_program_timing_generator(
 
 	uint32_t vsync_offset = dc_crtc_timing->v_border_bottom +
 			dc_crtc_timing->v_front_porch;
-	uint32_t v_sync_start =dc_crtc_timing->v_addressable + vsync_offset;
+	uint32_t v_sync_start = dc_crtc_timing->v_addressable + vsync_offset;
 
 	uint32_t hsync_offset = dc_crtc_timing->h_border_right +
 			dc_crtc_timing->h_front_porch;
@@ -603,7 +603,7 @@ void dce110_timing_generator_program_blanking(
 {
 	uint32_t vsync_offset = timing->v_border_bottom +
 			timing->v_front_porch;
-	uint32_t v_sync_start =timing->v_addressable + vsync_offset;
+	uint32_t v_sync_start = timing->v_addressable + vsync_offset;
 
 	uint32_t hsync_offset = timing->h_border_right +
 			timing->h_front_porch;
-- 
2.17.1

