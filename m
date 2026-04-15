Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2FEF433CD
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 22:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1322A10E765;
	Wed, 15 Apr 2026 22:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5txCJLa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A0C10E765
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 22:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/WRqg9M3e3Sx8EwhqFO+m2dojz7JYHB4gcASh2NbwXns9A8LwHrSHejLCsGPCfLhJ8nWob6WgMEKz03ziv3xOFd0ePKvOZLTJj0emjTDpsbg3Y0QnaJUqG7VWxbnoA3LYXv3ryb+dplxtXcdgiaUxkld3g8ieMDJYuEA6Ye2nphaRGVGy5tP9RAQt+e0LbkOZ9yJudqfIoiIBklcs+x57vDLzt/c3RGZM0vC8zp90ykocV/+dk50HJdm/kj0Yc1732xtNANIj3INAn7ZWpSSpylJXSDvIXANKBCh6WpV+Kc+KX9VU5aSitQPd39qBlPdc54x+V0OglPBjS71pqJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCZj0k40v3oFJxwwfDow6SXxncjyHjHze8/Nxj2Aw/g=;
 b=CA1kl/EqbZ9evfg7uW0qqsCN0X00LLfDfbpMwy9aOeI2o3Ozm8tzlFn6VS1wcGPiioJzeiJPSDLqgAhPs5Rmm5U0YiF+irHUnFzxNiVatjZibvBSGYg1j+eLYKnPHsfVX++uKG4tBX+J5n/MVebHK2d10I7aANasHVe/pHnRo+z06DXsMutoeATd7+n7oiFeb+SA+attuYxaEoWErJ2sKoIGg7IdOwyCh98ptgdweTRKhwKb2fPUk+yjTJ1saqSd7RKVKrJk4t7k3mGalLww7GN/aqRVn2Ugl7HaK+kA9yFev0wM0O+BDIJ7SqrR/9I+3V69kfOiqgFzR4dsmYu7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCZj0k40v3oFJxwwfDow6SXxncjyHjHze8/Nxj2Aw/g=;
 b=U5txCJLaQBofoMSNTp+hoIOLZvY+FST+Z+V34yDuzowQuFPsgfIsjfdz7pFsuQ02d2PwC+7pYxm4oZveXvZ31+RyDSESpkJUDqX/PZjJL6c2wOBLXL9Cv5+0SQxtW+Zeub+Nz+SBCc1UuwGkCqR9At/mrYGHqBlAAJeK7bDH2Zg=
Received: from CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 22:41:56 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::ef) by CH0PR03CA0065.outlook.office365.com
 (2603:10b6:610:cc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 22:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 22:41:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 17:41:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 17:41:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Aurabindo.Pillai@amd.com>, <alex.hung@amd.com>,
 <timur.kristof@gmail.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: Restore analog connector support
Date: Wed, 15 Apr 2026 18:41:50 -0400
Message-ID: <20260415224150.1807020-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2895361d-7170-4b7f-3e3e-08de9b40326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: C0QAACbak8UQnu3yhXy9e4L2DuWz0ouEzOef93Zs8eTDYoq0gDc6ois92iNrM37Gq652knScX8vBcf7c+ozrD94hu8UsdWidVGI3Okp3lvJWBfFef+9dYqmur1ntWYKNwK5BaAPoFZKzocmkeBzEITh7YAzFnw63vnwc80w8FwlEcWuxg0P8ezMFRYHSakgJKsQaii+Zvsq8N1Ht+vl2RfNYnlotHGvNXErBQZMbJZYiZdnaa2b/c3inioEZwQZwmf0NOOWRniM0pv045+zSIpczD05sKydjbHq22nkHQCPBzJiLtrrhYyFHhRFfy4duqxr7waIGKGWZoOgmwM1X1SOr2ZkZn+m/YNXlNN5G28GsKyrfEPe/TR8x/gR+eSXoz1czwrUDR9kXSzpozHPRIEgcsuSDA/RY2gzwnMsixN259kdSfdlALK3fHzc21ejyPholXGGyPskT6Qz8bKhSNCu+1niQ0Fopv4PqkvUeiwHyCLrYdfUnZXOHWPhpnAWbTzEz25/ohPmCOeYHg2WztZbs2iLc6FOzeLUm2tB4B0LOb8pjUNKZjUHEChCThU9Vlw9Yw+pfAIqrJz1ApMnNmnthiJyB8lKyNhMCjf2gm81rQDH3svfLtdthZa+83AIx/m+mk/25mDY3mz7ChYVmuHkdBK78myulo8873NRMsl8pOy8f3d+rH46tVBP8WaAyrU8rG9Y2ZWqEGO5Ik69jyQH+7VpMpTgP2i78KcxqfdMMMhoj+YmKpSo1902plIOU4IuqbiVwTb1zSLDou4VxVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3woR7gYFlsqp79g/uKqIHCuxxCju017PJvYMDD6x6SMbf9aD1DPz+bNiCkhqpowEXvpUJmMELT6ppLjzIfzWEF/AuLZTHIld2cF6oi/aD0XEArzQdr+NP/TPRBM+VaAMe4g1m0bS2Riob8fLCqkfJjiMv+eS8ZmZ4dQ9CLHbhJo3RqqHCu46MaEcSZghnAEXvleq4n3PqhUnTkVLDAZErDCrGlwMQntoTatJdMTrHlXLmUqlBxhc1sRnhc/BbiBLSnnVWRv7rL+uQKaFs6ErfF8tnXm2Xxll2A9PFCGxjSDBJE1Fz7RsXwvhiARDvq5UKgBjI+XzuEbgskIfXLqhZDa7N/TaWtD8h/zeA9fqIpR7CxTq6lw7rlJ+o06B32CllEknhVaN5w0tqAPJSUQv3aR1TVSIBJAamqni1eBs2axIZ6X7rxBNiv+KR2PsgSyA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 22:41:55.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2895361d-7170-4b7f-3e3e-08de9b40326c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
The analog connector support was accidentally removed,
causing a crash when connecting an analog monitor.

[How]
This patch restores the functions and pointers required for proper analog
and DP bridge encoder support on legacy GPUs.

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5273ca09fe12..e76abc877f4a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
 	bios->funcs->encoder_control(bios, &encoder_control);
 }
 
+static void
+dce110_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	const struct dc_link_settings *link_settings = &link->cur_link_settings;
+	enum bp_result bp_result = BP_RESULT_OK;
+	struct bp_external_encoder_control ext_cntl = {
+		.action = action,
+		.connector_obj_id = link->link_enc->connector,
+		.encoder_id = link->ext_enc_id,
+		.lanes_number = link_settings->lane_count,
+		.link_rate = link_settings->link_rate,
+
+		/* Use signal type of the real link encoder, ie. DP */
+		.signal = link->connector_signal,
+
+		/* We don't know the timing yet when executing the SETUP action,
+		 * so use a reasonably high default value. It seems that ENABLE
+		 * can change the actual pixel clock but doesn't work with higher
+		 * pixel clocks than what SETUP was called with.
+		 */
+		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
+		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
+	};
+	DC_LOGGER_INIT(dc->ctx);
+
+	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
+
+	if (bp_result != BP_RESULT_OK)
+		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
+}
+
+static void
+dce110_prepare_ddc(struct dc_link *link)
+{
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
+}
+
 static bool
 dce110_dac_load_detect(struct dc_link *link)
 {
@@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 }
 
+static void dce110_enable_analog_link_output(
+		struct dc_link *link,
+		uint32_t pix_clk_100hz)
+{
+	link->link_enc->funcs->enable_analog_output(
+			link->link_enc,
+			pix_clk_100hz);
+}
+
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_analog_link_output = dce110_enable_analog_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.dac_load_detect = dce110_dac_load_detect,
+	.prepare_ddc = dce110_prepare_ddc,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
-- 
2.34.1

