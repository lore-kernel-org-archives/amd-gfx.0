Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0722C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561D010ED17;
	Mon,  7 Mar 2022 05:50:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4010610ED17
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8DxKdqbYo6XUOr6q5PPzdkUGeitPwxFrmpP72ob0IVbyELwK6kUlW8/S7zf6zFMdWko6Mtx1ssb/oxOgC3SRWEEz2ehh3VkHVUmB+yd5sGEWmC9OCZufPzfL3UKn0ifkSUFebFWMB4Q0a07MNHHVeDDfNt71RLhfSZ+vWEUmqqHHu5aWMAei3N5xgDuzYEyT67dEA0NRGAMHezM1hOIG5RVnTAcSBjpQHTDcpD9Wi4vYrgFLXjxm9WvcfIGq/48pv6xn9Kn76I83n2xBkCnmTgk5ANSxcANlOlXqr2BtMlKQ3zL5ZCrDphwkzXWXs6otYfQKbDdt10DIJjarSlVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8QL2RsA6kGO4uksQy+pK21Yf0Qwqx3ciSqcBmmdc5o=;
 b=c7dxIGUwEjgdX5J5yRjS/nRRnG8zbqM01p6KkxFtloEWdlnTFc/GP8TGnuaF1O1c3WO3g36IP9THqXiGr/c2vhNdT7wyxy9WFqulFnSEWDAbBdnJvBT4dvUk35jzQcQBctkptl5jUql3Zl3N9D8jD+IlBH+rhRuse/zbEVWwKnQuwd7Pu3hjV8ebk4aBZzc9lDfxOKi35hb7BixmX3MSdnRXIlvR0wFQd2CN2xJvjs5UpkIs9fKEvXLkGc1Gis4Foqur/UZqWk2uBTXCmOC7Bu7zA+XDaCSFCp9nrRPE7/4vjcJELNS/NeVppKFIs33huwKmqWTmuSyvIkvvRcu7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8QL2RsA6kGO4uksQy+pK21Yf0Qwqx3ciSqcBmmdc5o=;
 b=jfr2VitaXn1T67mCiKHuk+s2K4j4wJHR6O49nJsJMBCq/oy+a5pEQgzfDAPuTK/6nwtGHFlXMtZ22HD4Vbdzs4PL9sDyxARpm/oaPkrsNu/yPF5CP+9k6AvelbWLfFpw0Ov1sqsDAjkUX/uNrcC0ZHfrAqyx29Dld6uJ5HPvKa8=
Received: from DM3PR12CA0108.namprd12.prod.outlook.com (2603:10b6:0:55::28) by
 MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 05:50:45 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::29) by DM3PR12CA0108.outlook.office365.com
 (2603:10b6:0:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:50:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:43 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:39 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: merge two duplicated
 clock_source_create
Date: Tue, 8 Mar 2022 05:09:32 +0800
Message-ID: <20220307210942.444808-10-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003c5167-0cb0-430b-bb11-08d9fffe6be2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13415277EFE4A81BC1B33E2DF5089@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPwyJLTULV+7hJN4Xd1Mmq1j47HdspO9btXLOqSxQ3mzpjH+2/p4BdkuwamtKdZ9EtNxFz9t+2iRtTJJ4/jX8kGfP61vPYcpTTPRt4BZ2wctPIXspI5f4YboIpam6M1Q9TQKkiNCYMRzFRn35KlA6Bu/mQLB3HDwdMOOfdEjnwULu7BEcM221fj0DA1PlDKSYo7JTq/9MqasE9dHVjSFZu6CaG5SAOs1XhRXAbL68S4WgBoQgJXJDfbE/SmebVOjOd+YB4cRgVNU42Przi+uXCv9/h2k/hQ/CpSsLW9TX2jQWRSNuJUvFbIG9aTU+cGNadDr+KKUbMfKbHx3Ry797vhObG+dlR1JHkEzjiJms4V0s4h9nRWcWJ8AoxkVCQtv6bpNCj1xtNrQ/MxQFla0UbRjuEQcYD0/U1wsRYaqfxZhstLvMx69OjJhYX5ri/W7uhe7X1X2uscHBfR5YbdLEUm1V6UKTmRvPcbxkBSkv1/Ex1p+0bb38sVAuxqwmZF6RbKx7JDgQvNEf8vX0Uwf8HJqWPi08DcGvU8tlbo2YhoIFseteu3X4djAN9YXFMDNkEMbwmLDXjlmljkHjDB+7pN/WFqhmOmb9JmqKYRDw1afcRole7sYiQcr2Z8rgjPpbJKCUqUEJuSARThe5lq8M6m/uOxiMjdWfx2Ns8K0c3tVBvr4GlxR+HmWx4bcFOxvTbIsM0qnbrKvEPL7A/MpiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(6666004)(47076005)(316002)(8676002)(70586007)(70206006)(4326008)(7696005)(30864003)(336012)(5660300002)(1076003)(40460700003)(2906002)(2616005)(356005)(426003)(26005)(186003)(83380400001)(8936002)(86362001)(36860700001)(508600001)(36756003)(81166007)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:50:44.5493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003c5167-0cb0-430b-bb11-08d9fffe6be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Hansen
 Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
dcn31x could use dcn31 sepcific which contains deep_color_ratio for dmub

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 127 ++++++++++--------
 .../amd/display/dc/dcn315/dcn315_resource.c   |  33 +----
 .../amd/display/dc/dcn316/dcn316_resource.c   |  33 +----
 3 files changed, 82 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 9285bdeca270..cc5128e67daf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -978,70 +978,87 @@ static bool dcn31_program_pix_clk(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
+	unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
+	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+	const struct pixel_rate_range_table_entry *e =
+			look_up_in_video_optimized_rate_tlb(pix_clk_params->requested_pix_clk_100hz / 10);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
-
-	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
-		unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
-		unsigned dp_dto_ref_100hz = 7000000;
-		unsigned clock_100hz = pll_settings->actual_pix_clk_100hz;
-
-		/* Set DTO values: phase = target clock, modulo = reference clock */
-		REG_WRITE(PHASE[inst], clock_100hz);
-		REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
-
-		/* Enable DTO */
+	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
+	if (dc_is_dp_signal(pix_clk_params->signal_type)) {
+		if (e) {
+			/* Set DTO values: phase = target clock, modulo = reference clock*/
+			REG_WRITE(PHASE[inst], e->target_pixel_rate_khz * e->mult_factor);
+			REG_WRITE(MODULO[inst], dp_dto_ref_khz * e->div_factor);
+		} else {
+			/* Set DTO values: phase = target clock, modulo = reference clock*/
+			REG_WRITE(PHASE[inst], pll_settings->actual_pix_clk_100hz * 100);
+			REG_WRITE(MODULO[inst], dp_dto_ref_khz * 1000);
+		}
 		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
-		return true;
-	}
+	} else {
+		if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
+			unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
+			unsigned dp_dto_ref_100hz = 7000000;
+			unsigned clock_100hz = pll_settings->actual_pix_clk_100hz;
+
+			/* Set DTO values: phase = target clock, modulo = reference clock */
+			REG_WRITE(PHASE[inst], clock_100hz);
+			REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
+
+			/* Enable DTO */
+			REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+			return true;
+		}
 
-	/*ATOMBIOS expects pixel rate adjusted by deep color ratio)*/
-	bp_pc_params.controller_id = pix_clk_params->controller_id;
-	bp_pc_params.pll_id = clock_source->id;
-	bp_pc_params.target_pixel_clock_100hz = pll_settings->actual_pix_clk_100hz;
-	bp_pc_params.encoder_object_id = pix_clk_params->encoder_object_id;
-	bp_pc_params.signal_type = pix_clk_params->signal_type;
+		/*ATOMBIOS expects pixel rate adjusted by deep color ratio)*/
+		bp_pc_params.controller_id = pix_clk_params->controller_id;
+		bp_pc_params.pll_id = clock_source->id;
+		bp_pc_params.target_pixel_clock_100hz = pll_settings->actual_pix_clk_100hz;
+		bp_pc_params.encoder_object_id = pix_clk_params->encoder_object_id;
+		bp_pc_params.signal_type = pix_clk_params->signal_type;
 
-	// Make sure we send the correct color depth to DMUB for HDMI
-	if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
-		switch (pix_clk_params->color_depth) {
-		case COLOR_DEPTH_888:
-			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
-			break;
-		case COLOR_DEPTH_101010:
-			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_30;
-			break;
-		case COLOR_DEPTH_121212:
-			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_36;
-			break;
-		case COLOR_DEPTH_161616:
-			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_48;
-			break;
-		default:
-			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
-			break;
+		// Make sure we send the correct color depth to DMUB for HDMI
+		if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
+			switch (pix_clk_params->color_depth) {
+			case COLOR_DEPTH_888:
+				bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+				break;
+			case COLOR_DEPTH_101010:
+				bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_30;
+				break;
+			case COLOR_DEPTH_121212:
+				bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_36;
+				break;
+			case COLOR_DEPTH_161616:
+				bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_48;
+				break;
+			default:
+				bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+				break;
+			}
+			bp_pc_params.color_depth = bp_pc_colour_depth;
 		}
-		bp_pc_params.color_depth = bp_pc_colour_depth;
-	}
 
-	if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
-		bp_pc_params.flags.SET_GENLOCK_REF_DIV_SRC =
-						pll_settings->use_external_clk;
-		bp_pc_params.flags.SET_XTALIN_REF_SRC =
-						!pll_settings->use_external_clk;
-		if (pix_clk_params->flags.SUPPORT_YCBCR420) {
-			bp_pc_params.flags.SUPPORT_YUV_420 = 1;
+		if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
+			bp_pc_params.flags.SET_GENLOCK_REF_DIV_SRC =
+							pll_settings->use_external_clk;
+			bp_pc_params.flags.SET_XTALIN_REF_SRC =
+							!pll_settings->use_external_clk;
+			if (pix_clk_params->flags.SUPPORT_YCBCR420) {
+				bp_pc_params.flags.SUPPORT_YUV_420 = 1;
+			}
 		}
+		if (clk_src->bios->funcs->set_pixel_clock(
+				clk_src->bios, &bp_pc_params) != BP_RESULT_OK)
+			return false;
+		/* Resync deep color DTO */
+		if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO)
+			dce112_program_pixel_clk_resync(clk_src,
+						pix_clk_params->signal_type,
+						pix_clk_params->color_depth,
+						pix_clk_params->flags.SUPPORT_YCBCR420);
 	}
-	if (clk_src->bios->funcs->set_pixel_clock(
-			clk_src->bios, &bp_pc_params) != BP_RESULT_OK)
-		return false;
-	/* Resync deep color DTO */
-	if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO)
-		dce112_program_pixel_clk_resync(clk_src,
-					pix_clk_params->signal_type,
-					pix_clk_params->color_depth,
-					pix_clk_params->flags.SUPPORT_YCBCR420);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index d161b8197631..a9dc84b65260 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1963,29 +1963,6 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 };
 
-static struct clock_source *dcn30_clock_source_create(
-		struct dc_context *ctx,
-		struct dc_bios *bios,
-		enum clock_source_id id,
-		const struct dce110_clk_src_regs *regs,
-		bool dp_clk_src)
-{
-	struct dce110_clk_src *clk_src =
-		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
-
-	if (!clk_src)
-		return NULL;
-
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
-			regs, &cs_shift, &cs_mask)) {
-		clk_src->base.dp_clk_src = dp_clk_src;
-		return &clk_src->base;
-	}
-
-	BREAK_TO_DEBUGGER();
-	return NULL;
-}
-
 static bool dcn315_resource_construct(
 	uint8_t num_virtual_links,
 	struct dc *dc,
@@ -2091,23 +2068,23 @@ static bool dcn315_resource_construct(
 
 	/* Clock Sources for Pixel Clock*/
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL0] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL0,
 				&clk_src_regs[0], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL1] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL1,
 				&clk_src_regs[1], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL2] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL2,
 				&clk_src_regs[2], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL3] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL3,
 				&clk_src_regs[3], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL4] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL4,
 				&clk_src_regs[4], false);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 2e378d9cd00d..936803721cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1964,29 +1964,6 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 };
 
-static struct clock_source *dcn30_clock_source_create(
-		struct dc_context *ctx,
-		struct dc_bios *bios,
-		enum clock_source_id id,
-		const struct dce110_clk_src_regs *regs,
-		bool dp_clk_src)
-{
-	struct dce110_clk_src *clk_src =
-		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
-
-	if (!clk_src)
-		return NULL;
-
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
-			regs, &cs_shift, &cs_mask)) {
-		clk_src->base.dp_clk_src = dp_clk_src;
-		return &clk_src->base;
-	}
-
-	BREAK_TO_DEBUGGER();
-	return NULL;
-}
-
 static bool dcn316_resource_construct(
 	uint8_t num_virtual_links,
 	struct dc *dc,
@@ -2092,23 +2069,23 @@ static bool dcn316_resource_construct(
 
 	/* Clock Sources for Pixel Clock*/
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL0] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL0,
 				&clk_src_regs[0], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL1] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL1,
 				&clk_src_regs[1], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL2] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL2,
 				&clk_src_regs[2], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL3] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL3,
 				&clk_src_regs[3], false);
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL4] =
-			dcn30_clock_source_create(ctx, ctx->dc_bios,
+			dcn31_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL4,
 				&clk_src_regs[4], false);
 
-- 
2.25.1

