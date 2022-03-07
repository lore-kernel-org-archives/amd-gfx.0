Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A706E10F30C;
	Mon,  7 Mar 2022 05:38:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2335C10F303
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM/Qq30aqDbAPJSuYpFOsQuStKd4RLt4tF3SRW1/AyjvCKzG8nTBeP+iK0QYUlUEMOY8/hR0YrC44r+tDgVVJjg60rhXu2RwtqUHRwNozHp0fvHYkCRBMz47HVngDUzEvEB4NPL+ooTDgbYjmnX3bI66hU64my4a1kmOr1i5UqP8tfpw3CDOfQPArwpiXhfX9DIKNPrvFLmxviPuBtUQOPxJwvn7jt8jU6xVZGRVH4JjrYqzbXTsm+Cp8e4Sws6UTwxbuAmO+XxmgfYfXZoPLbP0kvMvqGyqXYcEEx3izBTyyz2mqjtBbDL+q6A77KQlI2XzENzsVmujzbF2HDmtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrD4jXYTH5AcZET6pybshHw+cvGp0FySV5MAAWvWJSU=;
 b=cA3wLtCaS6GbbENwX1KSJbCcmrUXMvYQXmzyGutRS5i3zQty2Gp9/KZeT94TEL8LO7ayOArHieXV0QwAMFZX8yGA08wHhvVKc8Xb1gxfCJsACZqyWmuEdSrim0JFdPZPO2dxtrCTQueyHTZM3an6wRV7w3165olJQdBlTrWDEnHNjMEFc3eyBkTLgBiNAzEnrPfuJKmjLJ8gGYaaeNau0cdOhPXi0LLXDWkFd7r7DKRqp9mUnTz13ZDOuOfXDAIusrn00oxByZGZsAgfJ46HNdoPFo8Vg0Ii8TKWBcN6LBlTNqFuR6+STa/WRgDwN9k/jcT5LD1yVcop44VQdTkA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrD4jXYTH5AcZET6pybshHw+cvGp0FySV5MAAWvWJSU=;
 b=hJVpDM3I0s+POrZMewLUET9k+7cBn5nJfY36ORcaKYCwePBKKlkVzb0LbaqRvDK8QVkDqX+PO/OC6OpT6K2Rn+oIj+A1QXLjUDTa2zpeNsSiYpc7/7vqgbVeuSREmq4hx7JSyGdha5ZDicdYbsmm1SI11kixVAr3KUZyQ95vli0=
Received: from BN8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:60::24)
 by DM5PR12MB1817.namprd12.prod.outlook.com (2603:10b6:3:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 05:37:58 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::de) by BN8PR12CA0011.outlook.office365.com
 (2603:10b6:408:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 05:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:37:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:37:56 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:37:52 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: fix deep color ratio
Date: Tue, 8 Mar 2022 04:59:03 +0800
Message-ID: <20220307205923.444306-2-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307205923.444306-1-HaoPing.Liu@amd.com>
References: <20220307205923.444306-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c2c50a-524d-4bcc-410f-08d9fffca2be
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1817392C60363A179CFECF4BF5089@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThqI+3YfITOB4e3uiBFaxC1aXyu6VGp7K2qejPeSDALEjch90dS6Nq3ijyCsEt7DuaWZMO6nJAMpCigKsMvLK+X7yJbuhJqA/E9YPM0OvzK/M8PvvKxla2M1T1iLPWEEbJ830DpDOhEcRjYaJGfTic0vhRxjVF7EZ0A+GbbW02ZHjSMSV1BUzlMRHjfMQwcveDiYeQJSxDXb8N3u3Iy3kKrKnZ73ykHn3B0mH6gHjHapK/Xb4CKOhAPlrTGBY9CeUbRG2AEBHUIR/CszncV9iW+YgFoApxJuAfQn+p7ODoA42fcGURYS5X5lnr9LkLcBRa1sMXD2gkw97vhpoAwO/Q2Hbr7cfveEBMd8hovG7XrBMcVywLsx9oE1jz//oTle3trOlKcHagcxTyDKc3wA8U8AU4j4PCSGJEYLvA7Kzo3uXXduKeMVenc+wtBvSkt70g12clDfXmgoxME9NCVsS3jsXjKOnDsdKFI++QendpO5Eu4R45BD7T63772bDkMW1xuld9xr4/q2ILtNeAef1/6CjI1IeKVtKhqOJHqn7PJWC37aa9kaGQtboIWgpgiGYp+cSwlU7/NRskrbtkO0YjK8ITDxyltrr3/BJJvEvzYEq1JuevPv101c+dnXwKV4mg1QRCYFr5Nqy8dg3tHEOc4jYHayYFvjxfAxD0j/A2M1iUom/f0T4LZzmyKGexxqUEdw/Kt/FW2XR0c1pV/z7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(47076005)(36860700001)(7696005)(6666004)(8676002)(6916009)(70586007)(82310400004)(70206006)(54906003)(4326008)(316002)(40460700003)(356005)(36756003)(508600001)(2906002)(81166007)(83380400001)(2616005)(5660300002)(336012)(1076003)(426003)(8936002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:37:57.6229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2c50a-524d-4bcc-410f-08d9fffca2be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
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
 Hansen Dsouza <Hansen.Dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

Fix enum mapping for deep color ratio

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 100 ++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_clock_source.h |   9 ++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2 +-
 4 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 2c7eb982eabc..9285bdeca270 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -971,6 +971,81 @@ static bool dce112_program_pix_clk(
 	return true;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+static bool dcn31_program_pix_clk(
+		struct clock_source *clock_source,
+		struct pixel_clk_params *pix_clk_params,
+		struct pll_settings *pll_settings)
+{
+	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
+	struct bp_pixel_clock_parameters bp_pc_params = {0};
+	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+
+	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
+		unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
+		unsigned dp_dto_ref_100hz = 7000000;
+		unsigned clock_100hz = pll_settings->actual_pix_clk_100hz;
+
+		/* Set DTO values: phase = target clock, modulo = reference clock */
+		REG_WRITE(PHASE[inst], clock_100hz);
+		REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
+
+		/* Enable DTO */
+		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+		return true;
+	}
+
+	/*ATOMBIOS expects pixel rate adjusted by deep color ratio)*/
+	bp_pc_params.controller_id = pix_clk_params->controller_id;
+	bp_pc_params.pll_id = clock_source->id;
+	bp_pc_params.target_pixel_clock_100hz = pll_settings->actual_pix_clk_100hz;
+	bp_pc_params.encoder_object_id = pix_clk_params->encoder_object_id;
+	bp_pc_params.signal_type = pix_clk_params->signal_type;
+
+	// Make sure we send the correct color depth to DMUB for HDMI
+	if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
+		switch (pix_clk_params->color_depth) {
+		case COLOR_DEPTH_888:
+			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+			break;
+		case COLOR_DEPTH_101010:
+			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_30;
+			break;
+		case COLOR_DEPTH_121212:
+			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_36;
+			break;
+		case COLOR_DEPTH_161616:
+			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_48;
+			break;
+		default:
+			bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+			break;
+		}
+		bp_pc_params.color_depth = bp_pc_colour_depth;
+	}
+
+	if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
+		bp_pc_params.flags.SET_GENLOCK_REF_DIV_SRC =
+						pll_settings->use_external_clk;
+		bp_pc_params.flags.SET_XTALIN_REF_SRC =
+						!pll_settings->use_external_clk;
+		if (pix_clk_params->flags.SUPPORT_YCBCR420) {
+			bp_pc_params.flags.SUPPORT_YUV_420 = 1;
+		}
+	}
+	if (clk_src->bios->funcs->set_pixel_clock(
+			clk_src->bios, &bp_pc_params) != BP_RESULT_OK)
+		return false;
+	/* Resync deep color DTO */
+	if (clock_source->id != CLOCK_SOURCE_ID_DP_DTO)
+		dce112_program_pixel_clk_resync(clk_src,
+					pix_clk_params->signal_type,
+					pix_clk_params->color_depth,
+					pix_clk_params->flags.SUPPORT_YCBCR420);
+
+	return true;
+}
+#endif
 
 static bool dce110_clock_source_power_down(
 		struct clock_source *clk_src)
@@ -1205,6 +1280,13 @@ static const struct clock_source_funcs dcn3_clk_src_funcs = {
 	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
 	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
 };
+
+static const struct clock_source_funcs dcn31_clk_src_funcs = {
+	.cs_power_down = dce110_clock_source_power_down,
+	.program_pix_clk = dcn31_program_pix_clk,
+	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
+	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+};
 #endif
 /*****************************************/
 /* Constructor                           */
@@ -1609,6 +1691,24 @@ bool dcn3_clk_src_construct(
 }
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+bool dcn31_clk_src_construct(
+	struct dce110_clk_src *clk_src,
+	struct dc_context *ctx,
+	struct dc_bios *bios,
+	enum clock_source_id id,
+	const struct dce110_clk_src_regs *regs,
+	const struct dce110_clk_src_shift *cs_shift,
+	const struct dce110_clk_src_mask *cs_mask)
+{
+	bool ret = dce112_clk_src_construct(clk_src, ctx, bios, id, regs, cs_shift, cs_mask);
+
+	clk_src->base.funcs = &dcn31_clk_src_funcs;
+
+	return ret;
+}
+#endif
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dcn301_clk_src_construct(
 	struct dce110_clk_src *clk_src,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 692fa23ca02b..069de7649c8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -292,6 +292,15 @@ bool dcn301_clk_src_construct(
 	const struct dce110_clk_src_regs *regs,
 	const struct dce110_clk_src_shift *cs_shift,
 	const struct dce110_clk_src_mask *cs_mask);
+
+bool dcn31_clk_src_construct(
+	struct dce110_clk_src *clk_src,
+	struct dc_context *ctx,
+	struct dc_bios *bios,
+	enum clock_source_id id,
+	const struct dce110_clk_src_regs *regs,
+	const struct dce110_clk_src_shift *cs_shift,
+	const struct dce110_clk_src_mask *cs_mask);
 #endif
 
 /* this table is use to find *1.001 and /1.001 pixel rates from non-precise pixel rate */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 2ecd7bbfa0d4..3c5efa61dff9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2177,7 +2177,7 @@ static struct clock_source *dcn30_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 72d581c6092f..2e378d9cd00d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1759,7 +1759,7 @@ static struct clock_source *dcn31_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
-- 
2.25.1

