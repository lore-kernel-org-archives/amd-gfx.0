Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400F7C677F1
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 15:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2ED10E370;
	Sun, 15 Jan 2023 15:29:41 +0000 (UTC)
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAAC10E284;
 Sat, 14 Jan 2023 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
 t=1673731300; bh=EkdauZCzQ1cK93hqglTGGg1XeEnBheNqHiWtPXNdtH8=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=XhaDOnDIboT6HCOBi1Ymfsr1Y6Thl/XtXDfsJo0awOhjDpzE0YGLvpx7PZv9j6ILh
 F7ssoq7ABRMbWJVVbK+jNVcpD92miRRgcBenViQa/EDXB0PMgu5ElN5Liur2opihuC
 /l8bLK4o8/Qadrmo97MrkgVISH/z0KdN0C8yDL+E=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sat, 14 Jan 2023 22:21:40 +0100 (CET)
X-EA-Auth: wo+VQO9ffl4BHSNsx5JlMnia2RZdbHBhkeMPohaTckEHMhLVrBSduq54Ewvo2nRbQ50i0bdeCxQfsQUaF/76y+PJLAqy/qhx
Date: Sun, 15 Jan 2023 02:51:35 +0530
From: Deepak R Varma <drv@mailo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/amd/display: dcn32: Use min()/max() helper macros
Message-ID: <85526bdbb34b6f9bff0118170578cea29755354d.1673730293.git.drv@mailo.com>
References: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673730293.git.drv@mailo.com>
X-Mailman-Approved-At: Sun, 15 Jan 2023 15:29:29 +0000
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
Cc: Praveen Kumar <kumarpraveen@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the standard min() / max() helper macros instead of direct variable
comparison using if/else blocks or ternary operator. Change identified
using minmax.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f94abd124021..80820f012891 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -908,7 +908,7 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	stretched_drr_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
 	drr_stretched_vblank_us = (drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
 			(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us);
-	max_vblank_mallregion = drr_stretched_vblank_us > mall_region_us ? drr_stretched_vblank_us : mall_region_us;
+	max_vblank_mallregion = max(drr_stretched_vblank_us, mall_region_us);
 
 	/* We consider SubVP + DRR schedulable if the stretched frame duration of the DRR display (i.e. the
 	 * highest refresh rate + margin that can support UCLK P-State switch) passes the static analysis
@@ -999,7 +999,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000;
 		subvp_active_us = main_timing->v_addressable * main_timing->h_total /
 				(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
+		max_vblank_mallregion = max(vblank_blank_us, mall_region_us);
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
-- 
2.34.1



