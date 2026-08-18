Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D6AC5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7262710EC89;
	Tue, 18 Aug 2026 20:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5gB/CPz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56EE10EC89
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZp/HCc8b1mUZAu2Tf8ku0uRRF5ECPHwYGz5a0LZ2oYQoOoMNACUKQBGwLBZfXmS7NKuvijhDcVwG4gIrBC5bSgrkpAEjncl4liMJ8jZB2DojG95u7HOOclK6rCIleJniyZvNzyO1cWEeF6EV6MQTXcNPAR6TFUYqPQ5j8qBkTdB/2bNWICUzh/36QI7FLDYhVLMbKuEfwprW1SKj15GdP18Oaxk32ce0ndPWgbRQ/N08Wh5MMHNnYiDdZ64sSokd0rwUGobokc0a9yYPjyS2ceooeGCtz1eW9//4ek0ERcv8bSsAOfscAAMRPcdBekk79yLw9IwYOsAWsh9yO8vhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMgMqu1gjHu5JkbZSpjtbhDkYDUG8ZvjMrrLXCYrbIc=;
 b=rV1XsncINv2lgcUXNOnsjFmZckMvAva3AcEakH+Y448Q1tmAiTCCKStYQnry/ZW3iLgFn5KDIpXLL0qIKzLiGk0rk8fascSR6m9eP+792dLnJ857rgZLBFwVondmJNoHViAo96lL3E31Wo/PPv9Oi65jNozWGxlFy+Srvo9S8IVzvu/nBVFDPHnllACrtvpKRMTo4eNL5zaHMBPAgI7/Bd3DAkMyJ66uw/8eWaA4s0i4QA5cLVgqzEIe344Qqd5jho3AmJEc6DRj9oQuZUUWly7PlFRkd33FWIjDZl8EDFD0AvzCUj4CLb7ggGJcv6+M395Ea0559stDDskoHd/SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMgMqu1gjHu5JkbZSpjtbhDkYDUG8ZvjMrrLXCYrbIc=;
 b=Q5gB/CPzpMGnYNPa5fEYnG3rHvkyriA/l3ggXfsEZ2bII5zTw79IEqr0zVp/8Lb7g4nfbUkQt48gkVSVFMixkoVQ90dzUR9pTQGR3usxvwCo/dIhKVoP6hrtLZ/+jDj1QxcgaxGPkMVa4gPoMSSJhEVNqkNCrYYaoHHPNDhkudQ=
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:21:56 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::6d) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:21:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:49 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 02/82] drm/amd/display: Fixes for HPO test regressions
Date: Tue, 18 Aug 2026 16:14:54 -0400
Message-ID: <20260818202139.4172592-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: bac73f18-cec9-4def-8e8d-08defd665618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wbs32CCBvxTsJ+x/No21ZVuO9QHSHDTmMxXlGBnywyroh+U26/Wo8TAaW9n6S9FbVtCcb/7ooy4HXlinj5kGHvxmD3a1BvR1KMPO2y3sGscXOcWLugrGfE6sMfnm5hkXCn8L0sc6cNME2/UQeDJohifB6nenzvSF9Uv5bIJKuk88bBWb3i7R9EHDT2bHyBHt9OhEVz4jLOHn51IHqWAT2if3li5YGKRfA/i5zgZv25rIYP5CKyC5FOlRoVk4Px2OxGjD/A7oTz7sS41aFgKdbXHLRlbZ1mT6COFiZzJkuYsar4ByOVtkvp0gc98rKNLQ+zjr/UbFCmIuFWn6L3BoIxR8rjMX477Y8a6GRE1KPklKKbki7pmKRrsskigB0/dH9+iD6Ryy8dAMjGRns9gPaGgEWjQFzCn+NJdrM8Ioovmx3k4zW8cazLIn26V5qaduV/PzdQV0HJlzhgn5GwxYy4aV89LGYHKnfGKpKV9pLHLb4uwaS8MKzl4T5NaZbUG3T/zdxQk9XaF0+TZ2ffwIj+sruTb2HoQ+N5/mWRy87akMIGLizqdR4WhaiB8FRzhKMbzu5/cmVzpX9SJ3UPGUk3NkhM1k1LY3zwJBHLcSGVyK/H0XR0TU+ZpMd5D1J5hhgWVgfWH0AC0TZG86LzPRwPt6MAzZdgY9AXzB/OTEtB+LbYNpMibXVvZjdnjBufe+gZyxWvJNNOYrFTq6AKLfyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ptas/fxOtsabIoT22ch9w1L+A6wdZIZizFEPRUti+LS8BPghCDQXWrYQ6WX1i3fFA5USfDzwZklbeh46zpDDFxLIi8uAW2RLnUkJbEiB/ZBduHm0bsBUb9ARCo46SoLYMNx2xpW+MIZLIDWiSd4L+UxhYF8Di8Hd1gryvJeVXVt3a+yZVUCMyFL/mU8X1orKscNHY15Cez2y6s3gJYFVnfTSmvvJqTSxNjsayWudIx8ntXPjkSXu91wyu/LYkIbM+Sify16GsvW2OrWGkuXAfUiO7SfgOecnU+cH2zzTkm9OM3M01RSJqiQvklyzRXjpD25T9EhqNVvXqIxN54qFRDL3yBaIOwt3yYDYj6x+xAWqsQ+uOD6FfSNtbyHvDKVzNT6TbYyJvXJwcSKv8G6T5mxNBotnUbn4wf5BduqylAoycT7kqErlJEP1gAglow7w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:50.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac73f18-cec9-4def-8e8d-08defd665618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why&How]
Updates and fixes to HPO functionality, initialization, encoder
configuration and platform-specific behavior.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 ++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 12 +++++++++-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |  7 +++---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  6 +++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +++-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   | 23 ++++++++++---------
 .../dc/link/protocols/link_dp_capability.c    |  3 ++-
 7 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e019db3dc8226..837af136464ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3002,6 +3002,11 @@ static inline int find_acquired_dio_link_enc_for_link(
 
 static inline int find_fixed_dio_link_enc(const struct dc_link *link)
 {
+	/* virtual links own their link encoder directly and are never
+	 * registered into pool->link_encoders[]. */
+	if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+		return -1;
+
 	/* the 8b10b dp phy can only use fixed link encoder */
 	return link->eng_id;
 }
@@ -3147,6 +3152,8 @@ static bool add_dio_link_enc_to_ctx(const struct dc *dc,
 
 	if (enc_index >= 0)
 		pipe_ctx->link_res.dio_link_enc = pool->link_encoders[enc_index];
+	else
+		pipe_ctx->link_res.dio_link_enc = stream->link->link_enc;
 
 	return pipe_ctx->link_res.dio_link_enc != NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 6cb5e8152cf10..4abf51c8ab52c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -432,14 +432,24 @@ static bool acquire_aux_engine_without_ddc_pin(
 	struct dce_aux *engine,
 	struct ddc *ddc)
 {
-	(void)ddc;
 	if ((engine == NULL) || !is_engine_available(engine))
 		return false;
 
+	/* Open the DDC in AUX mode so the I3C PAD set_config hook runs and
+	 * enables the PAD RX (disabled by default); otherwise DPCD reads time
+	 * out even though the connector has no native I2C/DDC pin. */
+	if (ddc != NULL &&
+		dal_ddc_open(ddc, GPIO_MODE_HARDWARE,
+			GPIO_DDC_CONFIG_TYPE_MODE_AUX) != GPIO_RESULT_OK)
+		return false;
+
 	if (!acquire_engine(engine)) {
+		engine->ddc = ddc;
 		release_engine(engine);
 		return false;
 	}
+
+	engine->ddc = ddc;
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index b75bfea635fd4..bbfdcfc5b48fe 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -469,10 +469,11 @@ static enum gpio_result dal_hw_ddc_set_config_i3cpad(
 	switch (config_data->config.ddc.type) {
 	/* For ASICs with i3cpad module there is no dual pad mode for i3cpads */
 	case GPIO_DDC_CONFIG_TYPE_MODE_I2C:
-		/* Enable the RX for the PAD (it is disabled by default). */
-		REG_UPDATE(dc_i3cpad_control1, DC_I3CPAD_RXSEL, 0);
-		return GPIO_RESULT_OK;
 	case GPIO_DDC_CONFIG_TYPE_MODE_AUX:
+		/* Enable the RX for the PAD (it is disabled by default). Required for
+		 * both I2C (EDID) and AUX (DPCD); without it the sink reply is never
+		 * received and the transaction times out. */
+		REG_UPDATE(dc_i3cpad_control1, DC_I3CPAD_RXSEL, 0);
 		return GPIO_RESULT_OK;
 
 	case GPIO_DDC_CONFIG_TYPE_POLL_FOR_CONNECT:
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index cb163902e12e7..8c29aa2cd2c92 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -966,6 +966,12 @@ enum dc_status dcn30_setup_hdmi_frl_link(
 		frl_phy_clock_source_id,
 		link->frl_link_settings.frl_link_rate);
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+
+	/* Enable HPO link encoder */
+	link->hpo_frl_link_enc->funcs->setup_link_encoder(
+			link->hpo_frl_link_enc,
+			link->frl_link_settings.frl_num_lanes);
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 42b2fbb8a4ae4..bdefe699f8ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1847,7 +1847,10 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 	}
 
 	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
-		if (link->link_status.link_active && link->frl_link_settings.frl_link_rate != 0)
+		bool unblank_required =
+			link->link_status.link_active && link->frl_link_settings.frl_link_rate != 0;
+
+		if (unblank_required)
 			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_unblank(
 					pipe_ctx->stream_res.hpo_frl_stream_enc,
 					pipe_ctx->stream_res.tg->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index 04df75114dd5b..8110481234012 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -117,16 +117,18 @@ void enable_hpo_dp_link_output(struct dc_link *link,
 		return;
 	}
 
-	if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
-		link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
-				link->dc->res_pool->dccg,
-				link_res->hpo_dp_link_enc->inst,
-				true);
-	link_res->hpo_dp_link_enc->funcs->enable_link_phy(
-			link_res->hpo_dp_link_enc,
-			link_settings,
-			link->link_enc->transmitter,
-			link->link_enc->hpd_source);
+	{
+		if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
+			link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
+					link->dc->res_pool->dccg,
+					link_res->hpo_dp_link_enc->inst,
+					true);
+		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
+				link_res->hpo_dp_link_enc,
+				link_settings,
+				link->link_enc->transmitter,
+				link->link_enc->hpd_source);
+	}
 }
 
 void disable_hpo_dp_link_output(struct dc_link *link,
@@ -231,4 +233,3 @@ const struct link_hwss *get_hpo_dp_link_hwss(void)
 {
 	return &hpo_dp_link_hwss;
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 24e3bbec15ffb..ad1a499b0d9d2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -997,7 +997,8 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		 * TODO: add MST specific link training routine
 		 */
 		decide_mst_link_settings(link, link_setting);
-	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+	} else if (dc_is_virtual_signal(stream->signal)) {
+		/* virtual signals skip link training; use a valid dummy setting. */
 		link_setting->lane_count = LANE_COUNT_FOUR;
 		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
-- 
2.43.0

