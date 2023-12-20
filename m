Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50309C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E508010E235;
	Wed, 20 Dec 2023 16:36:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2088110E5BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiIa/SLy9nNKGCfP2yIEXBhc1kQQPE3aUXx4QPmPnazzKVCsJhjAVm5AtyYGxeZkaB+zD9qpZzeKF8PFhd/O8JUy+ga5NmVwxrU//4m8EJHxmuHZ8mJEP9FOSYGEv4Znlsp5sNcJqMlHb21VHyUPHHvg0CVc7DJD8pffbox4GN7okw41FGJjNAHzATqjveJP4dUQ4Y5PVAsNP9/qu6hMoWZJZSE0Snt5NmGOeYzq3lV6endXs8IQtpsGjHCRIrVJmowH79zuOeQTahzIEdhD5H/XVmSLjAoVJjfm5jdAJHg6mYcdD/CN7rqItBq+c39HCrfVWY6N6B0cMSrYHB2Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1huClN8LqZwYGdym+PnhdoMBxEnTadvZb9Z/8qPRg8=;
 b=N5JdCPX4uaHU5ih3jPLQ6wrnb07Oq/f6ZvVQ+sT+H1xn23VCywGj3RAapGl8sZJeMUgzcEDXKLeLJuj8FVJTxew7I2yKABViJxmaPSq6phETExxwsWwq1KXlWe5LwQemKxW0Xz2L0ZIfil2/gD7ZL7OJSfWWtSsJtSFd0JyH47Wejxz3gBav4sZEAmIw9yqyZrM6Q1D1LdmxkiPlGHMGy+lapSfIuw5PasW1h21vKxo347CpspXyQR6y724BeFMhoPLc3G3JTQ5keT6dEMABY2eDENphpeaw7lBLWU4zIaZI6EVELIHTcJj+krHYp+SuxlGJ7rNgCcIprM3PxibD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1huClN8LqZwYGdym+PnhdoMBxEnTadvZb9Z/8qPRg8=;
 b=ekOV3TL1CN1KWGT7rIm+h8lboFkz9M9ooHEOk6AMAG8MkLJocNriRHFzQmc6SyRyaRY2BsYxd9vaoyL77ne0pBctmXXFybIxHeVqcV1/a46fyu4R7ejOlxavgeWLI06bTjDPW5/k7jqb+uemnm9MhCmaO+i9ViZz2ldjGWZ+npA=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 16:36:47 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::f9) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 16:36:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:44 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/20] drm/amd/display: Add more mechanisms for tests
Date: Wed, 20 Dec 2023 09:33:35 -0700
Message-ID: <20231220163538.1742834-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 69264081-49b6-439e-5852-08dc0179dc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ks7LuN9CFo0npLH5MPqgjj4jI/c5oSff/YRt+UyO0YtDzAJWYddb3x9ZxSwvMn3ECdxGamXgXSRZA8PoeO31E4vcXznMxO1xxUkyghMXIFrsZdjCFvPxUc1/3JD3ZriGQuh/DfjqaP2cZCF1bM60G+WopK/ksh1CJCVL92KxC1/rYJnHsDcI0yjT7qmynW+mYybrWTOtUzz1EKxrz4EQr6qToT67O5FwvY6tTZFk+4IzeElKhWjfO5K7wzds7qxMNAky46KPKyIEdoZj5PwO2nMzXNmLA/2nJ3Q5ZhiEUGxgk9LZ8WtfeEAawrtqMgFK6bBz60VoILbab9oLU/YDaTwvsYU8GbfHV5xEdCVOP1uaRgXrFyW3lZs4lKCqmUmPNlMUucNOA29AgeheaNXoSFYlHn644ku0rmr1MuLuO9zsaX+PLfXGXTXqAa/R2ZeJ47+0tG1oRE2ahxtPhPJDdreaUimb7OLjynzUMqxEzQR8BrTVYR3wyeDoDHgGfD2n8z6pQnkXVyrO7b29I2T1fVch+vez5E3x7EoPO6sIGjdMfF6X2TOlSSglFa8aqyGroGNCR8XVAhzxz/qofPt/xQCx5tmCLCYmubgZyl0OCLntfkHH948yAINQgxqEfnJreMcyC+yAV4OnO4HP1C0PhkUdC36Atqrxj+wFU4rp/7KasopSJHGoJlFds8XygOCCOVhPqopW7XCnriez96e+ZehGLz45RqrjmE5dmCVMQCZ3R8RANvwdrh0IKcceEivvlwquzvzpoLjThVNsCrKNVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(2616005)(83380400001)(426003)(336012)(1076003)(16526019)(26005)(86362001)(36756003)(8676002)(8936002)(41300700001)(30864003)(2906002)(4326008)(5660300002)(316002)(70206006)(70586007)(54906003)(6916009)(6666004)(478600001)(81166007)(47076005)(82740400003)(356005)(36860700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:47.5142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69264081-49b6-439e-5852-08dc0179dc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Cc: stylon.wang@amd.com, Relja
 Vojvodic <relja.vojvodic@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Relja Vojvodic <relja.vojvodic@amd.com>

[Why]
More information is desired for the test tools.

[How]
Refactored get_subvp_visual_confirm_color and
get_mclk_switch_visual_confirm_color to support the new method of
storing the p_state type, which was changed so that it could also be
saved and output by the DPM log. Ensured that the p_state type is kept
updated by looping through the pipes within commit_planes_for_stream.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  90 ++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  37 ++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 172 +++++++++++-------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 ++
 5 files changed, 229 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 95c0b49b531a..51adb13b3b80 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -25,7 +25,6 @@
 
 #include "dccg.h"
 #include "clk_mgr_internal.h"
-
 #include "dcn32/dcn32_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
@@ -34,7 +33,7 @@
 #include "core_types.h"
 #include "dm_helpers.h"
 #include "link.h"
-
+#include "dc_state_priv.h"
 #include "atomfirmware.h"
 #include "smu13_driver_if.h"
 
@@ -458,13 +457,43 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	return 0;
 }
 
-static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr_internal *clk_mgr)
+static bool dcn32_check_native_scaling(struct pipe_ctx *pipe)
+{
+	bool is_native_scaling = false;
+	int width = pipe->plane_state->src_rect.width;
+	int height = pipe->plane_state->src_rect.height;
+
+	if (pipe->stream->timing.h_addressable == width &&
+			pipe->stream->timing.v_addressable == height &&
+			pipe->plane_state->dst_rect.width == width &&
+			pipe->plane_state->dst_rect.height == height)
+		is_native_scaling = true;
+
+	return is_native_scaling;
+}
+
+static void dcn32_auto_dpm_test_log(
+		struct dc_clocks *new_clocks,
+		struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context)
 {
 	unsigned int dispclk_khz_reg, dppclk_khz_reg, dprefclk_khz_reg, dcfclk_khz_reg, dtbclk_khz_reg,
-				 fclk_khz_reg;
+				 fclk_khz_reg, mall_ss_size_bytes;
 	int dramclk_khz_override, fclk_khz_override, num_fclk_levels;
 
-	msleep(5);
+	struct pipe_ctx *pipe_ctx_list[MAX_PIPES];
+	int active_pipe_count = 0;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+			pipe_ctx_list[active_pipe_count] = pipe_ctx;
+			active_pipe_count++;
+		}
+	}
+
+	mall_ss_size_bytes = context->bw_ctx.bw.dcn.mall_ss_size_bytes;
 
     dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
     dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
@@ -494,16 +523,49 @@ static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr
 	//
 	//				AutoDPMTest: clk1:%d - clk2:%d - clk3:%d - clk4:%d\n"
 	////////////////////////////////////////////////////////////////////////////
-	if (new_clocks &&
+	if (new_clocks && active_pipe_count > 0 &&
 		new_clocks->dramclk_khz > 0 &&
 		new_clocks->fclk_khz > 0 &&
 		new_clocks->dcfclk_khz > 0 &&
 		new_clocks->dppclk_khz > 0) {
 
+		uint32_t pix_clk_list[MAX_PIPES] = {0};
+		int p_state_list[MAX_PIPES] = {0};
+		int disp_src_width_list[MAX_PIPES] = {0};
+		int disp_src_height_list[MAX_PIPES] = {0};
+		uint64_t disp_src_refresh_list[MAX_PIPES] = {0};
+		bool is_scaled_list[MAX_PIPES] = {0};
+
+		for (int i = 0; i < active_pipe_count; i++) {
+			struct pipe_ctx *curr_pipe_ctx = pipe_ctx_list[i];
+			uint64_t refresh_rate;
+
+			pix_clk_list[i] = curr_pipe_ctx->stream->timing.pix_clk_100hz;
+			p_state_list[i] = curr_pipe_ctx->p_state_type;
+
+			refresh_rate = (curr_pipe_ctx->stream->timing.pix_clk_100hz * (uint64_t)100 +
+				curr_pipe_ctx->stream->timing.v_total * curr_pipe_ctx->stream->timing.h_total - (uint64_t)1);
+			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.v_total);
+			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.h_total);
+			disp_src_refresh_list[i] = refresh_rate;
+
+			if (curr_pipe_ctx->plane_state) {
+				is_scaled_list[i] = !(dcn32_check_native_scaling(curr_pipe_ctx));
+				disp_src_width_list[i] = curr_pipe_ctx->plane_state->src_rect.width;
+				disp_src_height_list[i] = curr_pipe_ctx->plane_state->src_rect.height;
+			}
+		}
+
 		DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk:%d - fclk:%d - "
 			"dcfclk:%d - dppclk:%d - dispclk_hw:%d - "
 			"dppclk_hw:%d - dprefclk_hw:%d - dcfclk_hw:%d - "
-			"dtbclk_hw:%d - fclk_hw:%d\n",
+			"dtbclk_hw:%d - fclk_hw:%d - pix_clk_0:%d - pix_clk_1:%d - "
+			"pix_clk_2:%d - pix_clk_3:%d - mall_ss_size:%d - p_state_type_0:%d - "
+			"p_state_type_1:%d - p_state_type_2:%d - p_state_type_3:%d - "
+			"pix_width_0:%d - pix_height_0:%d - refresh_rate_0:%lld - is_scaled_0:%d - "
+			"pix_width_1:%d - pix_height_1:%d - refresh_rate_1:%lld - is_scaled_1:%d - "
+			"pix_width_2:%d - pix_height_2:%d - refresh_rate_2:%lld - is_scaled_2:%d - "
+			"pix_width_3:%d - pix_height_3:%d - refresh_rate_3:%lld - is_scaled_3:%d\n",
 			dramclk_khz_override,
 			fclk_khz_override,
 			new_clocks->dcfclk_khz,
@@ -513,7 +575,14 @@ static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr
 			dprefclk_khz_reg,
 			dcfclk_khz_reg,
 			dtbclk_khz_reg,
-			fclk_khz_reg);
+			fclk_khz_reg,
+			pix_clk_list[0], pix_clk_list[1], pix_clk_list[3], pix_clk_list[2],
+			mall_ss_size_bytes,
+			p_state_list[0], p_state_list[1], p_state_list[2], p_state_list[3],
+			disp_src_width_list[0], disp_src_height_list[0], disp_src_refresh_list[0], is_scaled_list[0],
+			disp_src_width_list[1], disp_src_height_list[1], disp_src_refresh_list[1], is_scaled_list[1],
+			disp_src_width_list[2], disp_src_height_list[2], disp_src_refresh_list[2], is_scaled_list[2],
+			disp_src_width_list[3], disp_src_height_list[3], disp_src_refresh_list[3], is_scaled_list[3]);
 	}
 }
 
@@ -686,6 +755,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* DCCG requires KHz precision for DTBCLK */
 		clk_mgr_base->clks.ref_dtbclk_khz =
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
+
 		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 	}
 
@@ -713,8 +783,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		dmcu->funcs->set_psr_wait_loop(dmcu,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 
-	if (dc->config.enable_auto_dpm_test_logs && safe_to_lower) {
-	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr);
+	if (dc->config.enable_auto_dpm_test_logs) {
+	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr, context);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 043913d65b16..d55de3f5115d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1088,7 +1088,7 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 	}
 }
 
-static void dc_update_viusal_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
+static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
 	if (dc->ctx->dce_version >= DCN_VERSION_1_0) {
 		memset(&pipe_ctx->visual_confirm_color, 0, sizeof(struct tg_color));
@@ -1108,9 +1108,9 @@ static void dc_update_viusal_confirm_color(struct dc *dc, struct dc_state *conte
 			if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
 				get_mpctree_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP)
-				get_subvp_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
+				get_subvp_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MCLK_SWITCH)
-				get_mclk_switch_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
+				get_mclk_switch_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		}
 	}
 }
@@ -1190,8 +1190,10 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				dc_state_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
 
-			if (pipe->stream && pipe->plane_state)
-				dc_update_viusal_confirm_color(dc, context, pipe);
+			if (pipe->stream && pipe->plane_state) {
+				set_p_state_switch_method(dc, context, pipe);
+				dc_update_visual_confirm_color(dc, context, pipe);
+			}
 
 			if (dc->hwss.apply_ctx_for_surface) {
 				apply_ctx_interdependent_lock(dc, dc->current_state, old_stream, true);
@@ -3377,12 +3379,14 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 			&context->res_ctx,
 			stream);
 
-	if (dc->debug.visual_confirm) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->plane_state) {
+			set_p_state_switch_method(dc, context, pipe);
 
-			if (pipe->stream && pipe->plane_state)
-				dc_update_viusal_confirm_color(dc, context, pipe);
+			if (dc->debug.visual_confirm)
+				dc_update_visual_confirm_color(dc, context, pipe);
 		}
 	}
 
@@ -3531,13 +3535,16 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (dc->debug.visual_confirm)
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (pipe->stream && pipe->plane_state)
-				dc_update_viusal_confirm_color(dc, context, pipe);
+		if (pipe->stream && pipe->plane_state) {
+			set_p_state_switch_method(dc, context, pipe);
+
+			if (dc->debug.visual_confirm)
+				dc_update_visual_confirm_color(dc, context, pipe);
 		}
+	}
 
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 48fdfacc413a..9c05b1a07142 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -426,44 +426,130 @@ void get_hdr_visual_confirm_color(
 }
 
 void get_subvp_visual_confirm_color(
-		struct dc *dc,
-		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
 {
 	uint32_t color_value = MAX_TG_COLOR_VALUE;
-	bool enable_subvp = false;
-	int i;
-
-	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !context)
-		return;
+	if (pipe_ctx) {
+		switch (pipe_ctx->p_state_type) {
+		case P_STATE_SUB_VP:
+			color->color_r_cr = color_value;
+			color->color_g_y  = 0;
+			color->color_b_cb = 0;
+			break;
+		case P_STATE_DRR_SUB_VP:
+			color->color_r_cr = 0;
+			color->color_g_y  = color_value;
+			color->color_b_cb = 0;
+			break;
+		case P_STATE_V_BLANK_SUB_VP:
+			color->color_r_cr = 0;
+			color->color_g_y  = 0;
+			color->color_b_cb = color_value;
+			break;
+		default:
+			break;
+		}
+	}
+}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+void get_mclk_switch_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
 
-		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
-			/* SubVP enable - red */
-			color->color_g_y = 0;
+	if (pipe_ctx) {
+		switch (pipe_ctx->p_state_type) {
+		case P_STATE_V_BLANK:
+			color->color_r_cr = color_value;
+			color->color_g_y = color_value;
 			color->color_b_cb = 0;
+			break;
+		case P_STATE_FPO:
+			color->color_r_cr = 0;
+			color->color_g_y  = color_value;
+			color->color_b_cb = color_value;
+			break;
+		case P_STATE_V_ACTIVE:
 			color->color_r_cr = color_value;
-			enable_subvp = true;
-
-			if (pipe_ctx->stream == pipe->stream)
-				return;
+			color->color_g_y  = 0;
+			color->color_b_cb = color_value;
+			break;
+		case P_STATE_SUB_VP:
+			color->color_r_cr = color_value;
+			color->color_g_y  = 0;
+			color->color_b_cb = 0;
+			break;
+		case P_STATE_DRR_SUB_VP:
+			color->color_r_cr = 0;
+			color->color_g_y  = color_value;
+			color->color_b_cb = 0;
+			break;
+		case P_STATE_V_BLANK_SUB_VP:
+			color->color_r_cr = 0;
+			color->color_g_y  = 0;
+			color->color_b_cb = color_value;
+			break;
+		default:
 			break;
 		}
 	}
+}
 
-	if (enable_subvp && dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_NONE) {
-		color->color_r_cr = 0;
-		if (pipe_ctx->stream->allow_freesync == 1) {
-			/* SubVP enable and DRR on - green */
-			color->color_b_cb = 0;
-			color->color_g_y = color_value;
+void set_p_state_switch_method(
+		struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	bool enable_subvp;
+
+	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba || !context)
+		return;
+
+	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
+			dm_dram_clock_change_unsupported) {
+		/* MCLK switching is supported */
+		if (!pipe_ctx->has_vactive_margin) {
+			/* In Vblank - yellow */
+			pipe_ctx->p_state_type = P_STATE_V_BLANK;
+
+			if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+				/* FPO + Vblank - cyan */
+				pipe_ctx->p_state_type = P_STATE_FPO;
+			}
 		} else {
-			/* SubVP enable and No DRR - blue */
-			color->color_g_y = 0;
-			color->color_b_cb = color_value;
+			/* In Vactive - pink */
+			pipe_ctx->p_state_type = P_STATE_V_ACTIVE;
+		}
+
+		/* SubVP */
+		enable_subvp = false;
+
+		for (int i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe->stream && dc_state_get_paired_subvp_stream(context, pipe->stream) &&
+					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
+				/* SubVP enable - red */
+				pipe_ctx->p_state_type = P_STATE_SUB_VP;
+				enable_subvp = true;
+
+				if (pipe_ctx->stream == pipe->stream)
+					return;
+				break;
+			}
+		}
+
+		if (enable_subvp && dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_NONE) {
+			if (pipe_ctx->stream->allow_freesync == 1) {
+				/* SubVP enable and DRR on - green */
+				pipe_ctx->p_state_type = P_STATE_DRR_SUB_VP;
+			} else {
+				/* SubVP enable and No DRR - blue */
+				pipe_ctx->p_state_type = P_STATE_V_BLANK_SUB_VP;
+			}
 		}
 	}
 }
@@ -815,42 +901,6 @@ void hwss_subvp_save_surf_addr(union block_sequence_params *params)
 	dc_dmub_srv_subvp_save_surf_addr(dc_dmub_srv, addr, subvp_index);
 }
 
-void get_mclk_switch_visual_confirm_color(
-		struct dc *dc,
-		struct dc_state *context,
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
-{
-	uint32_t color_value = MAX_TG_COLOR_VALUE;
-	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
-
-	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba || !context)
-		return;
-
-	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
-			dm_dram_clock_change_unsupported) {
-		/* MCLK switching is supported */
-		if (!pipe_ctx->has_vactive_margin) {
-			/* In Vblank - yellow */
-			color->color_r_cr = color_value;
-			color->color_g_y = color_value;
-
-			if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
-				/* FPO + Vblank - cyan */
-				color->color_r_cr = 0;
-				color->color_g_y  = color_value;
-				color->color_b_cb = color_value;
-			}
-		} else {
-			/* In Vactive - pink */
-			color->color_r_cr = color_value;
-			color->color_b_cb = color_value;
-		}
-		/* SubVP */
-		get_subvp_visual_confirm_color(dc, context, pipe_ctx, color);
-	}
-}
-
 void get_surface_tile_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6ca8c5488d50..a54399383318 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -455,17 +455,18 @@ void get_mpctree_visual_confirm_color(
 		struct tg_color *color);
 
 void get_subvp_visual_confirm_color(
-	struct dc *dc,
-	struct dc_state *context,
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
 
 void get_mclk_switch_visual_confirm_color(
-		struct dc *dc,
-		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 
+void set_p_state_switch_method(
+		struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx);
+
 void hwss_execute_sequence(struct dc *dc,
 		struct block_sequence block_sequence[],
 		int num_steps);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c3b973abb89a..f74ae0d41d3c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -381,6 +381,16 @@ union pipe_update_flags {
 	uint32_t raw;
 };
 
+enum p_state_switch_method {
+	P_STATE_UNKNOWN						= 0,
+	P_STATE_V_BLANK						= 1,
+	P_STATE_FPO,
+	P_STATE_V_ACTIVE,
+	P_STATE_SUB_VP,
+	P_STATE_DRR_SUB_VP,
+	P_STATE_V_BLANK_SUB_VP
+};
+
 struct pipe_ctx {
 	struct dc_plane_state *plane_state;
 	struct dc_stream_state *stream;
@@ -429,6 +439,7 @@ struct pipe_ctx {
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
 	union pipe_update_flags update_flags;
+	enum p_state_switch_method p_state_type;
 	struct tg_color visual_confirm_color;
 	bool has_vactive_margin;
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
-- 
2.42.0

