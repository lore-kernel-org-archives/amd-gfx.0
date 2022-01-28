Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D59010EE84;
	Fri, 28 Jan 2022 14:05:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACD010EE77
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTyYkQ8kQajNYLMRKAY+SQTUdz02iF/LJA/8jJ5uwoOEVMyU0oJv5oAeo05xPh+oDOnNUO7IYpMizbqdArrsWTTLybTkndhM8jXZuYO/8MYkQN/PayXLg9T4yl7QQ3zyPnz7v8u3C40TNMY1p7crLJa5PupApkemVlTZYNQszWpx114WSyzkS60//tQAiBnoUzfHABKgr2kkeXEgufMKcfB+ZyOsxMUcP0vTbyZIeCcEKrZBktqFNJr0Zx9l80PLPivUFupFxRzrqZgWo06HpCSJ7OEmdIlXn5h7q6kG/XBmQh3J27cgzKjP1EtC4mfR6FX4pIon+mJl0RCnj4mALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p06vlJd+QRjyn6Vz0JPCxaXXLy5R1urSc6BgqAEdlqI=;
 b=XmbYC/5A0qtBfYc2BdEv9ZadHW4lX9/2/mZIvvCxlontnQ5Uxr0nyIWRkZX8ANF66uVR7b55FDmljgM1qrwyqvieIEmXR/e0oEp6GMl1DukUuLg2GgrwG3LgjL8F//0blmdlWm5jzHgoYFVtNiCIMJk0lY0XlhmmSSI9LR68KnuxkyZYdi9ulDUBY9cW6js6EgWqY4olnUehh+gzsEZnBWRVkPeDIAU4xJxTKC0edponDn0szgpkeA5RndFuce4y8TQ1HK5oUv1vW67lCXLhqEUAEW3n9OchqulhJKgovMWB+DW2NpLtxLNvqpq2ujbD7f8Ntd6rgtcAhZVTO4RsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p06vlJd+QRjyn6Vz0JPCxaXXLy5R1urSc6BgqAEdlqI=;
 b=NS6AqK7GP4QXn0VgOy7LTjtBfOVfr20gagff/lllNgEyesvdCpfutENsxWP6PRwtvrafxHgJQH9yPgimKOCAlMoy8S5l5xl1E774jst64YQhChvuzE4N1+dWCSZZtX0fFR5xlejxqjFAatbsTMrCdg1wkPzfNrTzW0mz8ZhV7XM=
Received: from MWHPR10CA0008.namprd10.prod.outlook.com (2603:10b6:301::18) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.13; Fri, 28 Jan 2022 14:05:32 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::74) by MWHPR10CA0008.outlook.office365.com
 (2603:10b6:301::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:31 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:27 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/17] drm/amd/display: add enable/disable dp link output to
 link_hwss
Date: Fri, 28 Jan 2022 22:04:02 +0800
Message-ID: <20220128140411.3683309-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ebfd1e-a93f-45d7-abe4-08d9e2673f42
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB267932F1AC1A33DD39081F7EFF229@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rALtIWx+Y5vibyQcd0jNrcnjuGH7pV17sriSsjreurxkxw8z1l9afL3sldh/T1+DyWMiU3qxk1Te2LKxz8sXeABhYBvvlklhci4eS9NvO4tsVAhWF3Luu2oaVZ2lKOSrZsefOqCKbcmBH6X7bDX3a6sU6YaZ7qkN50ObJ+fUGRtCfs5A4dlwq5SQAUrP6GfxnoFfiC+00NPsoQMW4Gnjpqpe12KHSvjFaV65d93fyevB9ahdcrEW7PCbU780RQDUYH7nnltnr6zN6mDjSj59aT5T4XjpoHXQPt/GKdML0XUF9CIp/g9bdfSMU+MPY0WS1he2eOFdGFHo9tPBiQItY/SMRvaxaVHI8ahTFfSnD3GMMN+1fd+6gle7gLo7QA43mZZyacAwllpbvElD5Mh1se/VkyyXeqKrjlsOzifjV5Gv/UOiaTddCXH3FiOTvjo5+4NxaLo5k/YDvqkEpa6SLRGEn7a2BeS9Wc2SamLcmCRGGqP67rrJEV4+7CB+SGN+yczA6cLFM3UH5tW4MnONa2/Rh47FlqwzCRxJ71KmFzKgeqHI+4YTJB2fkhuvFom/hqiFAcAeul4WXLn541WUsFgOhoIkQTYs720SuMX04U9mzh2slGPn//pEW8qJK2PtG7noCUG1RrTUJyXS4HufMX+vydyknDu5xc7Bzm5CdcR8JeVW1bt9pc76+Hx/uj5u7dS+N4L8Dp4yJ1FEBCgjFFJJQBCNGxK0MqwvEIwqulxeP98jTXJA/HJmQ7iKDU6Cgz8y1lltQYtFJ5QkOtuDQJM9oDfaCI66hzSrjPOJHP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(508600001)(2906002)(70586007)(4326008)(6916009)(7696005)(8676002)(8936002)(36860700001)(86362001)(83380400001)(316002)(1076003)(186003)(82310400004)(40460700003)(16526019)(47076005)(2616005)(426003)(6666004)(336012)(36756003)(356005)(5660300002)(81166007)(44832011)(26005)(70206006)(54906003)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:31.8603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ebfd1e-a93f-45d7-abe4-08d9e2673f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Factor enable/disable dp link output to link hwss.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   6 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 256 +++++++++---------
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   8 +
 3 files changed, 139 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c99e06afc769..cb6c91cd6e83 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4016,8 +4016,10 @@ static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pi
 	decide_link_settings(stream, &link_settings);
 	stream->link->cur_link_settings = link_settings;
 
-	/*  Enable clock, Configure lane count, and Enable Link Encoder*/
-	enable_dp_hpo_output(stream->link, &pipe_ctx->link_res, &stream->link->cur_link_settings);
+	if (link_hwss->ext.enable_dp_link_output)
+		link_hwss->ext.enable_dp_link_output(stream->link, &pipe_ctx->link_res,
+				stream->signal, pipe_ctx->clock_source->id,
+				&link_settings);
 
 #ifdef DIAGS_BUILD
 	/* Workaround for FPGA HPO capture DP link data:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index c26df0a78664..364fa77b85f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -76,19 +76,15 @@ void dp_enable_link_phy(
 	enum clock_source_id clock_source,
 	const struct dc_link_settings *link_settings)
 {
-	struct link_encoder *link_enc;
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
-
 	struct pipe_ctx *pipes =
 			link->dc->current_state->res_ctx.pipe_ctx;
 	struct clock_source *dp_cs =
 			link->dc->res_pool->dp_clock_source;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 	unsigned int i;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
-
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
@@ -126,21 +122,9 @@ void dp_enable_link_phy(
 	if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
-		enable_dp_hpo_output(link, link_res, link_settings);
-	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
-		if (dc_is_dp_sst_signal(signal)) {
-			link_enc->funcs->enable_dp_output(
-					link_enc,
-					link_settings,
-					clock_source);
-		} else {
-			link_enc->funcs->enable_dp_mst_output(
-					link_enc,
-					link_settings,
-					clock_source);
-		}
-	}
+	if (link_hwss->ext.enable_dp_link_output)
+		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
+				clock_source, link_settings);
 
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
@@ -221,11 +205,7 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
-	struct hpo_dp_link_encoder *hpo_link_enc = link_res->hpo_dp_link_enc;
-	struct link_encoder *link_enc;
-
-	link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 
 	if (!link->wa_flags.dp_keep_receiver_powered)
 		dp_receiver_power_ctrl(link, false);
@@ -234,20 +214,15 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 		if (link->dc->hwss.edp_backlight_control)
 			link->dc->hwss.edp_backlight_control(link, false);
 
-		if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING)
-			disable_dp_hpo_output(link, link_res, signal);
-		else
-			link_enc->funcs->disable_output(link_enc, signal);
+		if (link_hwss->ext.disable_dp_link_output)
+			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
 		link->dc->hwss.edp_power_control(link, false);
 	} else {
 		if (dmcu != NULL && dmcu->funcs->lock_phy)
 			dmcu->funcs->lock_phy(dmcu);
 
-		if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING &&
-				hpo_link_enc)
-			disable_dp_hpo_output(link, link_res, signal);
-		else
-			link_enc->funcs->disable_output(link_enc, signal);
+		if (link_hwss->ext.disable_dp_link_output)
+			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
 
 		if (dmcu != NULL && dmcu->funcs->unlock_phy)
 			dmcu->funcs->unlock_phy(dmcu);
@@ -702,88 +677,6 @@ static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 	}
 }
 
-void enable_dp_hpo_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		const struct dc_link_settings *link_settings)
-{
-	const struct dc *dc = link->dc;
-	enum phyd32clk_clock_source phyd32clk;
-
-	/* Enable PHY PLL at target bit rate
-	 *   UHBR10 = 10Gbps (SYMCLK32 = 312.5MHz)
-	 *   UBR13.5 = 13.5Gbps (SYMCLK32 = 421.875MHz)
-	 *   UHBR20 = 20Gbps (SYMCLK32 = 625MHz)
-	 */
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		switch (link_settings->link_rate) {
-		case LINK_RATE_UHBR10:
-			dm_set_phyd32clk(dc->ctx, 312500);
-			break;
-		case LINK_RATE_UHBR13_5:
-			dm_set_phyd32clk(dc->ctx, 412875);
-			break;
-		case LINK_RATE_UHBR20:
-			dm_set_phyd32clk(dc->ctx, 625000);
-			break;
-		default:
-			return;
-		}
-	} else {
-		/* DP2.0 HW: call transmitter control to enable PHY */
-		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
-				link_res->hpo_dp_link_enc,
-				link_settings,
-				link->link_enc->transmitter,
-				link->link_enc->hpd_source);
-	}
-
-	/* DCCG muxing and DTBCLK DTO */
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->res_pool->dccg->funcs->set_physymclk(
-				dc->res_pool->dccg,
-				link->link_enc_hw_inst,
-				PHYSYMCLK_FORCE_SRC_PHYD32CLK,
-				true);
-
-		phyd32clk = get_phyd32clk_src(link);
-		dc->res_pool->dccg->funcs->enable_symclk32_le(
-				dc->res_pool->dccg,
-				link_res->hpo_dp_link_enc->inst,
-				phyd32clk);
-		link_res->hpo_dp_link_enc->funcs->link_enable(
-				link_res->hpo_dp_link_enc,
-				link_settings->lane_count);
-	}
-}
-
-void disable_dp_hpo_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	const struct dc *dc = link->dc;
-
-	link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
-
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->res_pool->dccg->funcs->disable_symclk32_le(
-					dc->res_pool->dccg,
-					link_res->hpo_dp_link_enc->inst);
-
-		dc->res_pool->dccg->funcs->set_physymclk(
-					dc->res_pool->dccg,
-					link->link_enc_hw_inst,
-					PHYSYMCLK_FORCE_SRC_SYMCLK,
-					false);
-
-		dm_set_phyd32clk(dc->ctx, 0);
-	} else {
-		/* DP2.0 HW: call transmitter control to disable PHY */
-		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
-				link_res->hpo_dp_link_enc,
-				signal);
-	}
-}
-
 static void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
 static void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
 
@@ -804,21 +697,10 @@ static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 				throttled_vcp_size);
 }
 
-static struct link_encoder *get_dio_link_encoder(const struct dc_link *link)
-{
-	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign)
-		return link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-	else
-		return link->link_enc;
-}
-
 static void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct link_encoder *link_enc = get_dio_link_encoder(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 
-	ASSERT(link_enc);
 	link_enc->funcs->connect_dig_be_to_fe(link_enc,
 			pipe_ctx->stream_res.stream_enc->id, true);
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
@@ -828,7 +710,7 @@ static void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 
 static void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct link_encoder *link_enc = get_dio_link_encoder(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 
 	link_enc->funcs->connect_dig_be_to_fe(
 			link_enc,
@@ -840,11 +722,45 @@ static void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 
 }
 
+static void enable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (dc_is_dp_sst_signal(signal))
+		link_enc->funcs->enable_dp_output(
+				link_enc,
+				link_settings,
+				clock_source);
+	else
+		link_enc->funcs->enable_dp_mst_output(
+				link_enc,
+				link_settings,
+				clock_source);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
+}
+
+
+static void disable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	link_enc->funcs->disable_output(link_enc, signal);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
+
 static const struct link_hwss dio_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+		.enable_dp_link_output = enable_dio_dp_link_output,
+		.disable_dp_link_output = disable_dio_dp_link_output,
 	},
 };
 
@@ -933,12 +849,92 @@ static void reset_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	dccg->funcs->disable_symclk32_se(dccg, stream_enc->inst);
 	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst);
 }
+
+static void enable_hpo_dp_fpga_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	const struct dc *dc = link->dc;
+	enum phyd32clk_clock_source phyd32clk = get_phyd32clk_src(link);
+	int phyd32clk_freq_khz = link_settings->link_rate == LINK_RATE_UHBR10 ? 312500 :
+			link_settings->link_rate == LINK_RATE_UHBR13_5 ? 412875 :
+			link_settings->link_rate == LINK_RATE_UHBR20 ? 625000 : 0;
+
+	dm_set_phyd32clk(dc->ctx, phyd32clk_freq_khz);
+	dc->res_pool->dccg->funcs->set_physymclk(
+			dc->res_pool->dccg,
+			link->link_enc_hw_inst,
+			PHYSYMCLK_FORCE_SRC_PHYD32CLK,
+			true);
+	dc->res_pool->dccg->funcs->enable_symclk32_le(
+			dc->res_pool->dccg,
+			link_res->hpo_dp_link_enc->inst,
+			phyd32clk);
+	link_res->hpo_dp_link_enc->funcs->link_enable(
+			link_res->hpo_dp_link_enc,
+			link_settings->lane_count);
+
+}
+
+static void enable_hpo_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment))
+		enable_hpo_dp_fpga_link_output(link, link_res, signal,
+				clock_source, link_settings);
+	else
+		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
+				link_res->hpo_dp_link_enc,
+				link_settings,
+				link->link_enc->transmitter,
+				link->link_enc->hpd_source);
+}
+
+
+static void disable_hpo_dp_fpga_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	const struct dc *dc = link->dc;
+
+	link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
+	dc->res_pool->dccg->funcs->disable_symclk32_le(
+			dc->res_pool->dccg,
+			link_res->hpo_dp_link_enc->inst);
+	dc->res_pool->dccg->funcs->set_physymclk(
+			dc->res_pool->dccg,
+			link->link_enc_hw_inst,
+			PHYSYMCLK_FORCE_SRC_SYMCLK,
+			false);
+	dm_set_phyd32clk(dc->ctx, 0);
+}
+
+static void disable_hpo_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment)) {
+		disable_hpo_dp_fpga_link_output(link, link_res, signal);
+	} else {
+		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
+		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
+				link_res->hpo_dp_link_enc, signal);
+	}
+}
+
 static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
 	.ext = {
 		.set_throttled_vcp_size = set_dp_hpo_throttled_vcp_size,
 		.set_hblank_min_symbol_width = set_dp_hpo_hblank_min_symbol_width,
+		.enable_dp_link_output = enable_hpo_dp_link_output,
+		.disable_dp_link_output = disable_hpo_dp_link_output,
 	},
 };
 /*********************** below goes to dpia_link_hwss *************************/
@@ -954,6 +950,8 @@ static const struct link_hwss dpia_link_hwss = {
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+		.enable_dp_link_output = enable_dio_dp_link_output,
+		.disable_dp_link_output = disable_dio_dp_link_output,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index e9cad1c78b5e..8fe20ee02d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -86,6 +86,14 @@ struct link_hwss_ext {
 			struct fixed31_32 throttled_vcp_size);
 	void (*set_throttled_vcp_size)(struct pipe_ctx *pipe_ctx,
 			struct fixed31_32 throttled_vcp_size);
+	void (*enable_dp_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal,
+			enum clock_source_id clock_source,
+			const struct dc_link_settings *link_settings);
+	void (*disable_dp_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal);
 };
 
 struct link_hwss {
-- 
2.34.1

