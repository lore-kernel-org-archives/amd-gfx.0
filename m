Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A638BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7806860E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7806860E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D100F6E1F2;
	Wed,  8 Sep 2021 14:55:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB0E6E1F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9KYGrj78Z0TRWRkQ2arBLq4dyTZpzVALctdqBrmRZY958O53wqm3RZSNSa3XFHb4SeePy2Z5iCSqscTbwl7iKxxO9k9C+HcLEaxJZi3V7aGBNe/5E1cEs37hJiBaaUpgjDvzy+xHTainoiLKicBkV2eRdf4ULdzxssikB2skWphLsXGrBIMW5cusLw7Y3dKEOs1Ay5uYfat1S5QkfSQukvrByA8pBvJsNDuxOZl30VDzqkplGBCGwQ2TYnRHuuKKlEdm13mqCRtJZuE8lzCMpXxmHiP+8kFD7FdSazKwgX4B0VabDaCI4Z/DwfKACFfio5StRjcO0rVZ+8VUEuppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+0iLXlTDzPvj+PQ8dt5dd37PRN5fWgFTs7nJmrE2/hU=;
 b=AxYy3dVKTgtPaqsQDUYzK4iDLkAt9/NrtVUX1ZtQnIfxl1n/+W2JuB7l80gYpmMe39JHyzHCEV1fz+mpIp+N/oJnGyGsHFGxbuukLuMx/LN3R25xTVaWzqowFDURQBWG+2jmzNwKxN6uL2FvvYgybyiInabNKCjIk6uZQV7FnKW5W2V4bhQOQ20CrRJK0DZ3Gjojgly7UkJmNYYAemsPKIev6JLEgUXUrnTEZ+P4oR++ngAWJlbKpZSwEIq6yPnHWmGU4e26CdUoYbUiWvKpdyzdCzpRsuBdWuAIm+5uNetRC5vGmCxlNyb98bqWbV89zj3VL9ZqAwd4q8atshyHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0iLXlTDzPvj+PQ8dt5dd37PRN5fWgFTs7nJmrE2/hU=;
 b=V/cimRkQo2INnJAg13Bvtoy+GSvGPZ7hUZdpAmWU3VNV+VUlos+kcRj6oFS/8igWYvySSsLSY0U6imNk+n5bo6dVjfaDvvXvjfE+ITG7gmInYS4g35v1YtwofVSbraVdnAM9BAjoMQd5fzRQtQn9JpueJiFHBRwNPh3X1YfkUHU=
Received: from DM5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:3:13f::25)
 by BYAPR12MB3208.namprd12.prod.outlook.com (2603:10b6:a03:13b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:55:05 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::6b) by DM5PR17CA0063.outlook.office365.com
 (2603:10b6:3:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:04 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:03 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Leo (Hanghong) Ma"
 <hanghong.ma@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 24/33] drm/amd/display: Add helper for blanking all dp displays
Date: Wed, 8 Sep 2021 10:54:15 -0400
Message-ID: <20210908145424.3311-25-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0efc2df-8a4b-45e6-afbd-08d972d8a496
X-MS-TrafficTypeDiagnostic: BYAPR12MB3208:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3208E6626DC7A2FE7FA2A878E4D49@BYAPR12MB3208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeHHF5bK5InOP8dEyJCJIro1UouFFL1jUvO2E0Qt0VZxcrAsOuZPq0OdyrtXX0yvmSKPnUsbO1P1DtvoTIYyVfdX0jsN9srXmxtMYgpmpaOb7rgzRTa2A76Fj5pF9hfxTx3GtXh82xzJqiVEv+S9HyfIVXHl5GpcuB2q8pO751zL+1AnddCaXt0abKGzwPHtkKZPn2eBApuX3lQexmBa1v4q80JSCiVPruflWGDbECWQ4uwQSsfjn4dQSnlBcrWojaBmjo/ALfs8qWUN83mHKYu+XcIANygYiCQqRJ+PX9wApgOk0C/k68RGB9CjrspRrfYa+jxXGsnCwY+wsCJqV23+RENsLzAB+roy7tSPEK5TSRzwb1WEYavLMybwfbY8qOOODPgN5WaWCxmcGIMad+ypfn071KUpR63Zgv4zKqIy/st+JTPEQReBMvBQTohCgDSpk9TgyHZy8ojHJMoEZiSiJjulzfPTh4jy6ebz36t/LTPW3h0PxW7n5NNY1OXTOX/B0PNQWpaKenobgnw5kGV9ozKDtWauDxA1RJPMS4tEltYgw1MOtzK2JRGFphTNt/hSFcDYp8D0YCYifa8L+yNSDSFcpf98U2N3ULv3Z2uLa/2p2P073vDb2pX/UUJRMYAI1sVF8bM5d5XXcXWy2FHFGZEY0n14qhtnesB6ZZshkuPg1WW1asiIuEf7PJWxrCBRdrVadtfcvqjW4+vj56zp4ZsPigvYyuGxcMgcwBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(2616005)(47076005)(356005)(54906003)(2906002)(36756003)(36860700001)(1076003)(30864003)(6666004)(4326008)(8936002)(316002)(86362001)(26005)(70586007)(70206006)(82740400003)(5660300002)(6916009)(336012)(478600001)(8676002)(81166007)(186003)(83380400001)(16526019)(426003)(44832011)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:04.8557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0efc2df-8a4b-45e6-afbd-08d972d8a496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why & How]
The codes to blank all dp display have been called many times,
so add a helper in dc_link to make it more concise.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 ++---------------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++--------------
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 38 ++--------------
 7 files changed, 59 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7a1f910d711e..8bebfb0ca206 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1,4 +1,4 @@
-/*
+ /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 46933a43ef2e..a87a71b815ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1904,6 +1904,51 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
+void blank_all_dp_displays(struct dc *dc, bool hw_init)
+{
+	unsigned int i, j, fe;
+	uint8_t dpcd_power_state = '\0';
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	for (i = 0; i < dc->link_count; i++) {
+		enum signal_type signal = dc->links[i]->connector_signal;
+
+		if ((signal == SIGNAL_TYPE_EDP) ||
+			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
+			if (hw_init && signal != SIGNAL_TYPE_EDP) {
+				/* DP 2.0 spec requires that we read LTTPR caps first */
+				dp_retrieve_lttpr_cap(dc->links[i]);
+				/* if any of the displays are lit up turn them off */
+				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+			}
+
+			if ((signal != SIGNAL_TYPE_EDP && status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) ||
+				(!hw_init && dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
+				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
+						dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
+					if (fe == ENGINE_ID_UNKNOWN)
+						continue;
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+									dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+
+				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
+					(hw_init && signal != SIGNAL_TYPE_EDP))
+					dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
+
+}
+
 static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 		enum engine_id eng_id,
 		struct ext_hdmi_settings *settings)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 56340a176554..899e20725d87 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -277,6 +277,7 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		struct psr_context *psr_context);
 
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
+void blank_all_dp_displays(struct dc *dc, bool hw_init);
 
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 102f76462752..48f540f9d1d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1649,31 +1649,13 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 static void power_down_encoders(struct dc *dc)
 {
-	int i, j;
+	int i;
+
+	blank_all_dp_displays(dc, false);
 
 	for (i = 0; i < dc->link_count; i++) {
 		enum signal_type signal = dc->links[i]->connector_signal;
 
-		if ((signal == SIGNAL_TYPE_EDP) ||
-			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
-				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
-				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-									dc->links[i]->link_enc);
-
-				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-					if (fe == dc->res_pool->stream_enc[j]->id) {
-						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-									dc->res_pool->stream_enc[j]);
-						break;
-					}
-				}
-			}
-
-			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
-				dp_receiver_power_ctrl(dc->links[i], false);
-		}
-
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e1edbfa761f1..97dd2c418aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1366,7 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i, j;
+	int i;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1462,43 +1462,8 @@ void dcn10_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* DP 2.0 requires that LTTPR Caps be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/*
-			 * If any of the displays are lit up turn them off.
-			 * The reason is that some MST hubs cannot be turned off
-			 * completely until we tell them to do so.
-			 * If not turned off, then displays connected to MST hub
-			 * won't light up.
-			 */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-							&dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index b132ebed09d4..01a90badd173 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -437,7 +437,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i, j;
+	int i;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
@@ -534,41 +534,8 @@ void dcn30_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-			/* DP 2.0 states that LTTPR regs must be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index d3598ce1f5de..3dbaf0f30388 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -70,7 +70,7 @@ void dcn31_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
-	int i, j;
+	int i;
 	int edp_num;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -174,40 +174,8 @@ void dcn31_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
-						dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
-- 
2.25.1

