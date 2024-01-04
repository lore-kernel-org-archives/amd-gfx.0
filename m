Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE14C4707B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04B110E4C7;
	Thu,  4 Jan 2024 15:53:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C90410E4C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNriNkqBezjHREUWCavp1mTcvLDPWELnsxpGa8fLJIbXY4b2oVL/Kxi2XOgf2pVRGr6Wc0VqIy7AQdKd27xdVnz90jUPZDds9QcezeFiHlfBdek/QTv4mVkidMosmPqHSUcX/nIIPQ1x/7MclmoZf058SqJtemnsyKifhRuF4olXeElnqh6j+TnQibql3KMzLCZIPdygdJ/HGNK6gqwiE8iz+jeK4MrQ8BEqq9equlKQkX963oZ29/M7LfgQ079sTpwKRRgxuKTK5Je7sn5XHoyw7TQ3rEXZI6etIcSHNbKTS5QgGUgWD2EtVjSQepbNzKwjUKjbKqwEe0/o4zlUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28N9z51lfvzwoFArVIHbp7WD5TEhsZDy2/2SHNRAT2I=;
 b=FtRTI4Nj+TTA4FeCIifVlZ9pFxQWT58mLSQYLbqpO81e5nzJOGm4QuZURarbsrQq3+woGejT30tgq/O2/7QYH1XOhS39AXgj8jeXpZ7L8iMXzq4lcWPqfKKveSHi/nIXyc9N7OQ8xp+RA31k5MUkapkijqgsGL09XXxNevWwS+2y0AAUbl4a66rYWg/aoknLf0JWJM78fNhpF9CImghDK36zqn2vDpWuIKLHfjXx5PkprPpkLXhMHH8X1nS6v5xY5nKL/5NpMHMh+Xve822uTzMJhBsnyXELsYG4R6CUQDhg7M6K37s/9IVr7GG2rrNirMwUdeV9c/pmTOgluZzH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28N9z51lfvzwoFArVIHbp7WD5TEhsZDy2/2SHNRAT2I=;
 b=bK7Wwjpv6h1BOzbx9lz/O5uZrzcSx1sBi5Tb2D4DnMcD2quhnmRsVSDaXtmy4hJeIvHcHFTguxgDoovmS9YnNOaA25vGp+E3puqXWgaPZ/kNXua6SKs9Dmg4ErIwKZd1yQWEkKTrd+aDY7xYqCdIqFDQnZK3x0Ozk98dNpeaTdU=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 15:53:20 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::80) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amd/display: To adjust dprefclk by down spread
 percentage
Date: Thu, 4 Jan 2024 08:50:58 -0700
Message-ID: <20240104155238.454117-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 3074f5ed-e9a4-41ba-767f-08dc0d3d45cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X30HQpxS88vGt2TWsbCHp2go9et+WUYEWvvg2nuW6YiyIy+nf01eebmEVldo4AktzRJ2xX3PtJCkqmdo89UYnwDJhbEErHTrpqlrkCUf5N2RzPoaBpOR74lNR+XKoLKm9JdjVZtr+gmuohlqU7WlSnnCwu9ONuzyS6FJQqebhEnKX1Jkp2oVTLHsW/1v1R7s3ECrBf2Zq5ljmhAMh3OH6rLxbIeELO4ggIqcS2JT6D3c15y8wR5qxbwzFU632An3N/rwGvYQPT9RvTekEYEUksw7vmzwAoUjI7EkEbFsuYiMfTq7iBy/+roimWV1S7Vn5p5gjdkM0M/7NECH3D/ps8mL3rh2kO+KZXx5Agudjq3yZWyPwydN4TslXuxk3Rx30xdvt5gEbSL1XjWNiEVWK9t7cD83BaNCPodQOkKZNlYwVCNZ49M6ofcNaFa0yiho6z4NOcJZzeCRX0Xw16SWLRQ5nZDfUJWRD7T4/HVfIJd6pCFWKaPnZOZXPQYoNSuGt+EOQnL5MSeTIDlvxkrNUP0OZZ7SHX3FRXa0blOd/PvDHnAIHzlgmTqVCdjo2/HWUOEPyRZSMRxONjL5PS2OcUV9Bj3kQACYBD4K7V3C/Lfz1QmKLxJcVa2dVxmQW6OBX/7JAxB7JfAVE+7syHb4ejENIklwkYEqAwAUTPzb4piHZXNFzNz0S1FXPNRfWPEbniXnLJVGVDHtA72zlEkjwU231rsc/Ubfk0YZPklXkduuMwgB6+EWh+0pHYYWysJoGAL3UlQx+AYyXTnCmHPplA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(36840700001)(46966006)(6916009)(19627235002)(70206006)(70586007)(8676002)(8936002)(54906003)(316002)(478600001)(5660300002)(2906002)(30864003)(6666004)(36756003)(41300700001)(426003)(4326008)(40480700001)(36860700001)(40460700003)(16526019)(356005)(82740400003)(81166007)(336012)(83380400001)(47076005)(2616005)(86362001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:18.6901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3074f5ed-e9a4-41ba-767f-08dc0d3d45cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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
Cc: stylon.wang@amd.com, Martin Tsai <martin.tsai@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com, Nicholas
 Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Panels show corruption with high refresh rate timings when ssc is
enabled.

[How]
Read down-spread percentage from lut to adjust dprefclk. Issues come
from S0i3 with this commit has been fixed by SMU.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 71 ++++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        | 11 +++
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  9 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 .../gpu/drm/amd/display/include/audio_types.h |  2 +-
 7 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 757528256326..878c0e7b78ab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -87,6 +87,20 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
+#define regCLK1_CLK2_BYPASS_CNTL			0x029c
+#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
+
+#define regCLK6_0_CLK6_spll_field_8				0x464b
+#define regCLK6_0_CLK6_spll_field_8_BASE_IDX	0
+
+#define CLK6_0_CLK6_spll_field_8__spll_ssc_en__SHIFT	0xd
+#define CLK6_0_CLK6_spll_field_8__spll_ssc_en_MASK		0x00002000L
+
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -160,6 +174,37 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 	}
 }
 
+bool dcn314_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t ssc_enable;
+
+	REG_GET(CLK6_0_CLK6_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	return ssc_enable == 1;
+}
+
+void dcn314_init_clocks(struct clk_mgr *clk_mgr)
+{
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn314_is_spll_ssc_enabled(clk_mgr))
+		clk_mgr->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+	else
+		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+}
+
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -436,6 +481,11 @@ static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
+static struct dcn314_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -708,13 +758,31 @@ static struct clk_mgr_funcs dcn314_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn314_update_clocks,
-	.init_clocks = dcn31_init_clocks,
+	.init_clocks = dcn314_init_clocks,
 	.enable_pme_wa = dcn314_enable_pme_wa,
 	.are_clock_states_equal = dcn314_are_clock_states_equal,
 	.notify_wm_ranges = dcn314_notify_wm_ranges
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
+static void dcn314_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t clock_source;
+	//uint32_t ssc_enable;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+	//REG_GET(CLK6_0_CLK6_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	if (dcn314_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+		}
+	}
+}
+
 void dcn314_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn314 *clk_mgr,
@@ -782,6 +850,7 @@ void dcn314_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
 
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 171f84340eb2..002c28e80720 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -28,6 +28,8 @@
 #define __DCN314_CLK_MGR_H__
 #include "clk_mgr_internal.h"
 
+#define DCN314_NUM_CLOCK_SOURCES   5
+
 struct dcn314_watermarks;
 
 struct dcn314_smu_watermark_set {
@@ -40,9 +42,18 @@ struct clk_mgr_dcn314 {
 	struct dcn314_smu_watermark_set smu_wm_set;
 };
 
+struct dcn314_ss_info_table {
+	uint32_t ss_divider;
+	uint32_t ss_percentage[DCN314_NUM_CLOCK_SOURCES];
+};
+
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
 
+bool dcn314_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base);
+
+void dcn314_init_clocks(struct clk_mgr *clk_mgr);
+
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 140598f18bbd..f0458b8f00af 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -782,7 +782,7 @@ static void get_azalia_clock_info_dp(
 	/*audio_dto_module = dpDtoSourceClockInkhz * 10,000;
 	 *  [khz] ->[100Hz] */
 	azalia_clock_info->audio_dto_module =
-		pll_info->dp_dto_source_clock_in_khz * 10;
+		pll_info->audio_dto_source_clock_in_khz * 10;
 }
 
 void dce_aud_wall_dto_setup(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5d3f6fa1011e..970644b695cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -975,6 +975,9 @@ static bool dcn31_program_pix_clk(
 			look_up_in_video_optimized_rate_tlb(pix_clk_params->requested_pix_clk_100hz / 10);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
 		if (e) {
@@ -1088,6 +1091,10 @@ static bool get_pixel_clk_frequency_100hz(
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int clock_hz = 0;
 	unsigned int modulo_hz = 0;
+	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
@@ -1100,7 +1107,7 @@ static bool get_pixel_clk_frequency_100hz(
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz)
 				*pixel_clk_khz = div_u64((uint64_t)clock_hz*
-					clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
+					dp_dto_ref_khz*10,
 					modulo_hz);
 			else
 				*pixel_clk_khz = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index d6260b8b476f..4078e6be8810 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1353,7 +1353,7 @@ static void build_audio_output(
 	if (state->clk_mgr &&
 		(pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)) {
-		audio_output->pll_info.dp_dto_source_clock_in_khz =
+		audio_output->pll_info.audio_dto_source_clock_in_khz =
 				state->clk_mgr->funcs->get_dp_ref_clk_frequency(
 						state->clk_mgr);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index cbba39d251e5..17e014d3bdc8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -333,6 +333,7 @@ struct clk_mgr {
 	bool force_smu_not_present;
 	bool dc_mode_softmax_enabled;
 	int dprefclk_khz; // Used by program pixel clock in clock source funcs, need to figureout where this goes
+	int dp_dto_source_clock_in_khz; // Used to program DP DTO with ss adjustment on DCN314
 	int dentist_vco_freq_khz;
 	struct clk_state_registers_and_bypass boot_snapshot;
 	struct clk_bw_params *bw_params;
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index 66a54da0641c..915a031a43cb 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -64,7 +64,7 @@ enum audio_dto_source {
 /* PLL information required for AZALIA DTO calculation */
 
 struct audio_pll_info {
-	uint32_t dp_dto_source_clock_in_khz;
+	uint32_t audio_dto_source_clock_in_khz;
 	uint32_t feed_back_divider;
 	enum audio_dto_source dto_source;
 	bool ss_enabled;
-- 
2.43.0

