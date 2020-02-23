Return-Path: <SRS0=mgZh=4L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6CDC35669
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Feb 2020 02:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8320B20707
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Feb 2020 02:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C53XMo2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8320B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1AA6E9A5;
	Sun, 23 Feb 2020 02:21:53 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF486E9A2;
 Sun, 23 Feb 2020 02:21:51 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DAFA0214DB;
 Sun, 23 Feb 2020 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582424511;
 bh=2REOLpkCJd4hYNiNITF5nO4LqXdwtJyusVRdt6oSl5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C53XMo2VkjduZurMvNdBbfDvQwoeLR1HUTQrwyn4JPBeNcEYTkCvS/hZbn5oZGfSR
 6nOdn5bkUovA315d0G4hQ39H7+01XHQn93zftvfRhMJ0LE0XbBmr8ZuNPgEvf8bkEF
 2GZFVSnyQz6yvlg2dy5tx/7NX/f7Gb77pJ4cMDtg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 26/58] drm/amd/display: Add initialitions for PLL2
 clock source
Date: Sat, 22 Feb 2020 21:20:47 -0500
Message-Id: <20200223022119.707-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Isabel Zhang <isabel.zhang@amd.com>,
 Eric Yang <eric.yang2@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[ Upstream commit c134c3cabae46a56ab2e1f5e5fa49405e1758838 ]

[Why]
Starting from 14nm, the PLL is built into the PHY and the PLL is mapped
to PHY on 1 to 1 basis. In the code, the DP port is mapped to a PLL that was not
initialized. This causes DP to HDMI dongle to not light up the display.

[How]
Initializations added for PLL2 when creating resources.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index b29b2c99a564e..554062859866d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -57,6 +57,7 @@
 #include "dcn20/dcn20_dccg.h"
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
+#include "dce110/dce110_resource.h"
 
 #include "dcn20/dcn20_dwb.h"
 #include "dcn20/dcn20_mmhubbub.h"
@@ -866,6 +867,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 enum dcn20_clk_src_array_id {
 	DCN20_CLK_SRC_PLL0,
 	DCN20_CLK_SRC_PLL1,
+	DCN20_CLK_SRC_PLL2,
 	DCN20_CLK_SRC_TOTAL_DCN21
 };
 
@@ -1736,6 +1738,10 @@ static bool construct(
 			dcn21_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL1,
 				&clk_src_regs[1], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL2] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL2,
+				&clk_src_regs[2], false);
 
 	pool->base.clk_src_count = DCN20_CLK_SRC_TOTAL_DCN21;
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
