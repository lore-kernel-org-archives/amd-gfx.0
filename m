Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72538C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A721126ED;
	Fri, 22 Jul 2022 20:41:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C382BD20
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7UiJ0CnRlyFdYRx5WRKIcxZF/O1yvOSPebQE10/LVfiA/ScSp60WGw94t6ujCeBqY8qbE7uH9HSGtTc3j7xoUZxScprBrUvNQsoWfMHlqTarBeCO+jURNGGZD14mqNr8yTeg1/ghA4XJyuySNod4fIe0o5FY2eW/aEOSMO2sChz8Ga3tBVBJjcQYvAMKZzxbtLuLokUdOW11bE4rV7l7Iulm+FoNOBq4SDstjxeO9h1MHQl+Lp77Nsa0/+0gB1I3aEvWTTijGZVSsX7PORIijaBzsB4YgOJsHzAyzM/Wz90zqgXR+DzYut2lO5lvvzvU/qf1S4gthyxlbKzhK3yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC721/lg6aHhaDgHzsFafaWF1ejMVslCDmV7epJS0TQ=;
 b=BL37/mUIJKw7XtnVYR1MUp2AI8AmSDEfNlseXhLUEm+BuIPpMQFj6Jh4KedNB1+KAlorGQJsKwousLRYUz1wylEtP7DixzzdSBt7jBiT4RcwZaTQ7P28gOPFN78niTt0W7gPJ8JPNzG393x+xAc/CrNodQhvgwTjQva9fdUIOyMsR4R3IYiXo5neFL+YkjPa64SVXXeHw0hih+P22YGGLyG4rl+iICTRSXJzvKg33P17Myp7fZ0ZpVH84G8UqkTxekKzpmeNFCBAnkCz7fLvRBlv5+K7VvyyhWx1sOjmfxtG8YK7BYSisv6d4qWAWsMV3NNZQVhTKMECw79rEHzfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC721/lg6aHhaDgHzsFafaWF1ejMVslCDmV7epJS0TQ=;
 b=GuaZZkDCF47mM7A3P5A2SEQzj0SqiDBTAHZRqPRbjhsQtAerId+mPmQz33rymQo6q039zC9lOcY6diZHIFeG1eCBjMnUGkIe72tpKw3bEllS7ACIvD3gCMotp0WesmAVS6iBlznNXAbLYaugFSCZwUnnepVmwktB/GJIZu5Sm7I=
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:41:18 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::a8) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Fri, 22 Jul 2022 20:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:41:18 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:41:12 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/31] drm/amd/display: Use correct DTO_SRC_SEL for 128b/132b
 encoding
Date: Fri, 22 Jul 2022 14:31:23 -0600
Message-ID: <20220722203137.4043516-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd113461-d195-477e-3c17-08da6c22877e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzsqxDOCucVEYXgjGMf1fpV7uXxvvgTX0fe7wGYDd5BIcbXqhzLrPMATunXhfCC4qTtYsblIIQcZUb3sEtE7H1lPjo4qzyJASutpVXWtCynvf99R04xosJcPKnVp1mW4DrlOJJ/lIkvBd0Zh7xYTrQ0IZx/NIE6eX9uSMnoBE23k5iaWjtwohA4PLxLzwWWB8junzWeX1igQe2//4/avatuC3Ny0pSB0RTCiVFKG2Ass3PDsDnnQhH1eUOWPe7eLkFAUE/nplsgAxEg72jZVdSTpDZXaRYqBcU6fhxtJJrGJ4GSvGh/Vmx/ibGgL6AGZcQTUSOohJ9WDfnx8bvfvZbNXYYsD5mXK1lz2tpvEI6FN29ppqhcXmz/+k/k9qx6XNp6BF0CeTEq6tGch7zo1/GTyM34tOQT3qN9CuUGx7Qc+2ityPitK4EdtzCQAzXhXFDEJiUx/r2Z2pZGNWawmcz/6IMrSeH5uFgVzbnWQ85/nsJI5GyDbMNHdYYwtyPWI9TKkS8pOg17xTnGm+IcMatgRPYkHzo32WaJKWivV+dqcYoRDk+7DWezi5UBU/i98hknaL5wBFLXNpZe+JVChzjTnflG9t2KkC0jzydUjWq7rGtASqFNCKXuFbxRdT8F8Ks3/4dTpmH975tHDRbrL8OHHxxixA8VA6Msy+MFk7Dm2lo5XsI6FIflm4c5gIwfodFTPN/MSdOscODFLxixmN6vEy6fuoUKX/iW24Isnp6I4pgIltgvxTY0MKPJGRnzW7ynr0vpPZVOMXCe3b5ic8hlIMlTkV/jvzJ8SODvLlK5EJGHz4m4Pc11znTz3wfA45UyOx1x8OwSPPYh/L9V0Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(356005)(86362001)(83380400001)(81166007)(4326008)(36860700001)(54906003)(82740400003)(70206006)(40460700003)(6916009)(40480700001)(316002)(70586007)(44832011)(26005)(8676002)(336012)(5660300002)(8936002)(2906002)(47076005)(1076003)(41300700001)(2616005)(16526019)(36756003)(426003)(186003)(478600001)(82310400005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:41:18.2356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd113461-d195-477e-3c17-08da6c22877e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
DP DTO isn't used for 128b/132b encoding

[HOW]
Check current link rate to determine whether using 8b/10b or 128/132b encoding

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c | 20 ++++++++++++++-----
 .../display/dc/dce110/dce110_hw_sequencer.c   |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |  7 +++++--
 6 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d380b8bc6f39..bdf6b8081716 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7064,6 +7064,7 @@ void dp_enable_link_phy(
 				pipes[i].clock_source->funcs->program_pix_clk(
 							pipes[i].clock_source,
 							&pipes[i].stream_res.pix_clk_params,
+							dp_get_link_encoding_format(link_settings),
 							&pipes[i].pll_settings);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index d55da1ab1ac2..213de8cabfad 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -838,6 +838,7 @@ static void dce112_program_pixel_clk_resync(
 static bool dce110_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
+		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
@@ -911,6 +912,7 @@ static bool dce110_program_pix_clk(
 static bool dce112_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
+		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
@@ -970,6 +972,7 @@ static bool dce112_program_pix_clk(
 static bool dcn31_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
+		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
@@ -993,9 +996,14 @@ static bool dcn31_program_pix_clk(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		/* Enable DTO */
 		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
-			REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
-					DP_DTO0_ENABLE, 1,
-					PIPE0_DTO_SRC_SEL, 1);
+			if (encoding == DP_128b_132b_ENCODING)
+				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+						DP_DTO0_ENABLE, 1,
+						PIPE0_DTO_SRC_SEL, 2);
+			else
+				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+						DP_DTO0_ENABLE, 1,
+						PIPE0_DTO_SRC_SEL, 1);
 		else
 			REG_UPDATE(PIXEL_RATE_CNTL[inst],
 					DP_DTO0_ENABLE, 1);
@@ -1198,12 +1206,13 @@ const struct pixel_rate_range_table_entry *look_up_in_video_optimized_rate_tlb(
 static bool dcn20_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
+		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
 
-	dce112_program_pix_clk(clock_source, pix_clk_params, pll_settings);
+	dce112_program_pix_clk(clock_source, pix_clk_params, encoding, pll_settings);
 
 	if (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
 			clock_source->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0) {
@@ -1243,6 +1252,7 @@ static const struct clock_source_funcs dcn20_clk_src_funcs = {
 static bool dcn3_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
+		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
@@ -1265,7 +1275,7 @@ static bool dcn3_program_pix_clk(
 		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
 	} else
 		// For other signal types(HDMI_TYPE_A, DVI) Driver still to call VBIOS Command table
-		dce112_program_pix_clk(clock_source, pix_clk_params, pll_settings);
+		dce112_program_pix_clk(clock_source, pix_clk_params, encoding, pll_settings);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index e69c942c8345..38a67051d470 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1435,6 +1435,7 @@ static enum dc_status dce110_enable_stream_timing(
 		if (false == pipe_ctx->clock_source->funcs->program_pix_clk(
 				pipe_ctx->clock_source,
 				&pipe_ctx->stream_res.pix_clk_params,
+				dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
 				&pipe_ctx->pll_settings)) {
 			BREAK_TO_DEBUGGER();
 			return DC_ERROR_UNEXPECTED;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7a3812604e4b..bed783747f16 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -892,6 +892,7 @@ enum dc_status dcn10_enable_stream_timing(
 	if (false == pipe_ctx->clock_source->funcs->program_pix_clk(
 			pipe_ctx->clock_source,
 			&pipe_ctx->stream_res.pix_clk_params,
+			dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
 			&pipe_ctx->pll_settings)) {
 		BREAK_TO_DEBUGGER();
 		return DC_ERROR_UNEXPECTED;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3b26962637d0..3e44b7998429 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -700,6 +700,7 @@ enum dc_status dcn20_enable_stream_timing(
 	if (false == pipe_ctx->clock_source->funcs->program_pix_clk(
 			pipe_ctx->clock_source,
 			&pipe_ctx->stream_res.pix_clk_params,
+			dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
 			&pipe_ctx->pll_settings)) {
 		BREAK_TO_DEBUGGER();
 		return DC_ERROR_UNEXPECTED;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index e2b3a2c7a927..8f8ac8e29ed0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -160,8 +160,11 @@ struct calc_pll_clock_source {
 struct clock_source_funcs {
 	bool (*cs_power_down)(
 			struct clock_source *);
-	bool (*program_pix_clk)(struct clock_source *,
-			struct pixel_clk_params *, struct pll_settings *);
+	bool (*program_pix_clk)(
+			struct clock_source *,
+			struct pixel_clk_params *,
+			enum dp_link_encoding encoding,
+			struct pll_settings *);
 	uint32_t (*get_pix_clk_dividers)(
 			struct clock_source *,
 			struct pixel_clk_params *,
-- 
2.37.1

