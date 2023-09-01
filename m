Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604ACA0FF8
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Sep 2023 19:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5895E10E1F3;
	Fri,  1 Sep 2023 19:03:59 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4295510E710;
 Fri,  1 Sep 2023 01:29:37 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0Vqzer6v_1693531772; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0Vqzer6v_1693531772) by smtp.aliyun-inc.com;
 Fri, 01 Sep 2023 09:29:33 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com
Subject: [PATCH -next 4/5] drm/amd/display: clean up some inconsistent
 indentings
Date: Fri,  1 Sep 2023 09:29:23 +0800
Message-Id: <20230901012924.120196-4-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
References: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Sep 2023 19:03:54 +0000
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
Cc: Yang Li <yang.lee@linux.alibaba.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:288 dcn35_update_clocks() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 9314e75195cd..98d6a1f8af60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -288,8 +288,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-		if (new_clocks->dppclk_khz < 100000)
-			new_clocks->dppclk_khz = 100000;
+	if (new_clocks->dppclk_khz < 100000)
+		new_clocks->dppclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -901,21 +901,21 @@ void dcn35_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-		clk_mgr->base.smu_ver = dcn35_smu_get_smu_version(&clk_mgr->base);
+	clk_mgr->base.smu_ver = dcn35_smu_get_smu_version(&clk_mgr->base);
 
-		if (clk_mgr->base.smu_ver)
-			clk_mgr->base.smu_present = true;
+	if (clk_mgr->base.smu_ver)
+		clk_mgr->base.smu_present = true;
 
-		/* TODO: Check we get what we expect during bringup */
-		clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
+	/* TODO: Check we get what we expect during bringup */
+	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
-			dcn35_bw_params.wm_table = lpddr5_wm_table;
-		} else {
-			dcn35_bw_params.wm_table = ddr5_wm_table;
-		}
-		/* Saved clocks configured at boot for debug purposes */
-		 dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
+	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+		dcn35_bw_params.wm_table = lpddr5_wm_table;
+	} else {
+		dcn35_bw_params.wm_table = ddr5_wm_table;
+	}
+	/* Saved clocks configured at boot for debug purposes */
+	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn35_smu_get_dtbclk(&clk_mgr->base);
-- 
2.20.1.7.g153144c

