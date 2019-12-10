Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3017C2D0C8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BAD206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXDrGBeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BAD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB4A6E988;
	Tue, 10 Dec 2019 21:17:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570036E968
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CDEC3246AC;
 Tue, 10 Dec 2019 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012210;
 bh=zOQHlGxGlD22dSvYMFWP0Utebo3AOdsp8NUI2OFX6hE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sXDrGBeqthkGBjlGUh69UlxOW0lFWJhMpVyVOosAagD3JsbB82cEfOCv2WG6m/zIv
 5ancxEiEW0g4ThZvGrukmv8QBBKKjFFi6J+Rqa3LrWn1hnTpliR7+6Eif5nuDUldkL
 HBVvfWxSy1BcQa4WXYHVGnAxrNpERda8hQtpuPwM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 162/350] drm/amd/display: correctly populate dpp
 refclk in fpga
Date: Tue, 10 Dec 2019 16:04:27 -0500
Message-Id: <20191210210735.9077-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Leo Li <sunpeng.li@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit 952f6c4b5d72d40f93f3deb61239290b357d434e ]

[Why]
In diags environment we are not programming the DPP DTO
correctly.

[How]
Populate the dpp refclk in dccg so it can be used to correctly
program DPP DTO.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 3e8ac303bd526..23ec283eb07b6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -320,6 +320,8 @@ void dcn2_update_clocks_fpga(struct clk_mgr *clk_mgr,
 		struct dc_state *context,
 		bool safe_to_lower)
 {
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	/* Min fclk = 1.2GHz since all the extra scemi logic seems to run off of it */
 	int fclk_adj = new_clocks->fclk_khz > 1200000 ? new_clocks->fclk_khz : 1200000;
@@ -357,14 +359,18 @@ void dcn2_update_clocks_fpga(struct clk_mgr *clk_mgr,
 		clk_mgr->clks.dispclk_khz = new_clocks->dispclk_khz;
 	}
 
-	/* Both fclk and dppclk ref are run on the same scemi clock so we
-	 * need to keep the same value for both
+	/* Both fclk and ref_dppclk run on the same scemi clock.
+	 * So take the higher value since the DPP DTO is typically programmed
+	 * such that max dppclk is 1:1 with ref_dppclk.
 	 */
 	if (clk_mgr->clks.fclk_khz > clk_mgr->clks.dppclk_khz)
 		clk_mgr->clks.dppclk_khz = clk_mgr->clks.fclk_khz;
 	if (clk_mgr->clks.dppclk_khz > clk_mgr->clks.fclk_khz)
 		clk_mgr->clks.fclk_khz = clk_mgr->clks.dppclk_khz;
 
+	// Both fclk and ref_dppclk run on the same scemi clock.
+	clk_mgr_int->dccg->ref_dppclk = clk_mgr->clks.fclk_khz;
+
 	dm_set_dcn_clocks(clk_mgr->ctx, &clk_mgr->clks);
 }
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
