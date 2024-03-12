Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B806C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E80E112D3A;
	Tue, 12 Mar 2024 09:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sen1p83J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A343B112D45
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxmdA+qOmvaJA4XaIGYyhum0UdSDwKFR0lNtgooyZut02uakMNzBtzXTaEti2xwRta/abBtMDaazUeXgKqIf98mLfsd9CfXxy+shtZBnttImKKC2p+CgSUS+f2GUHeyghsMUOikq2pT24dAQlS6TaZXTwBSqCqYn6g+edhU1ZmO0JSJKCx1EE6qZ0JpFme3tkcOfjSTFkW0Wmf+zK8mziO8XSdPlfxrjgQona/jrrJdgkM1EA+zN7qj6xL125As2RzV+jFVSH7YkDdgxbh+bZhxfRUIjcDKNlMEOZLuA1LZ0k1/uAeRxEG/4UT6YmP+MNZCJwfebB7OUHmTGVfc2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnmRdn9yhRirRF/6yqjiYWMJ4klDbin1BvJCmiW18Pw=;
 b=aQqtqWTmGxz5O0QKhMCvSo+h3PYekOOp9aaph2WJ5UUfSPyQKClBbCVOkySuIbwIG33AhshV4FYnckCz7CTOmgytJUQAr0FI7TyDPi6n6I07afVHx678HiZlLpnK/0LE0lfKgXk1fyRO8u/nyAbcit7oVlzIl5J1mTEX13liEr35qbWLICjJXFLhSPGa+WEHbbEIVQOfJTwdEF4ECGxIELaIgxUp/8B/rP2G03Sxaur3mjzZG+Hg1QZAO1mtVtiGlX8xDyUZi2qsSMx4G7Wnzbp5syMFORlarPsREDKp/KOTSq+War+7BWxoNx6LKcoS5gup9eE88EPC38O05fik3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnmRdn9yhRirRF/6yqjiYWMJ4klDbin1BvJCmiW18Pw=;
 b=sen1p83JQqMygo0d5+rdc75TB1lub5peEP5I4QEOgEnnbtoRPvn8NmA6NaAoqeb3K1S5hRxg8ib91x8Lr1laHzur27wI8lIxgou8CsZoFfPJRCWVP1iBi7/9z8ivWjxC5EoxnlPtO92Y9PJa6DzIHlDqh4DQHjlmbZk9L32xXEY=
Received: from CY8PR10CA0012.namprd10.prod.outlook.com (2603:10b6:930:4f::28)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.32; Tue, 12 Mar
 2024 09:24:57 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::2e) by CY8PR10CA0012.outlook.office365.com
 (2603:10b6:930:4f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:55 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 39/43] drm/amd/display: Enable new interface design for
 alternate scrambling
Date: Tue, 12 Mar 2024 17:20:32 +0800
Message-ID: <20240312092036.3283319-40-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc9c303-8470-43bc-04fd-08dc427648ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xmz3jZnDoK9UdW6jdJh0FT0Z22liHD9HcPwy84j6c8x61sJLfZwnQtheBy/rR+1+GiXYAKzEwuelHkQ6lX48g56mHgeJkT6W/wQfZRZ7XX4co+hzlBy8e/3Eo2YrFM4OaPAndELJFOyJE34U2mC5KnKJhjanwy4oTq3+t0O3qMayX5tVHjD83/HzmM0XKTcGk5kSRQLu+CRY8+D+IwpI3slEh8k2ppbYRVOZOvF1866757hahFK8Q+KY9X97LpXxQoGzG06r/w0NEz/tKS/TTtB/ABrbu9KGf1u3lG8bLdlP/F3wwtnKn+VrrfJG2AuCNjmqc0vuF3Uc2gJMDm6HH9B+XD8sGiY3xnZIk0cJUZM0zYREOtVtFwZmDLpJ52AekDwt26+5KvCHpntiP2WI761Kf2wQsb1VQJpL87+h3r3mk8/zaOyPC8BbzMKgIvVAqSpiC6DTElalOlGeXLDmmqhOe8/bDjXlN9wnt/eGfq8Hyht0Pn9jktYP9CRUnPZzLP0uJsdtwlVzUnVgvcVMAV+5EHE3cT+2edZbNeGC6at+pbqLZIFQy4vCq3+fVzcTXKXZVyvKT8SKJobJ2Fq5YAymOYl5YJ4XR/EJF3jBlxBI+2XKw3naawr6mWN0iLVU9D+yIjZNQEkSc6Jj+aUgSVzXq5t7CVkVr0yFzigXyqv+aJkdAIL4cRK5FVJV58T6Uo11dKbijriIgRB6CQ1F4JT8xa1HcYLco1RjdytW5ov+9a9E8tCAqblA3FlIisDd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:57.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc9c303-8470-43bc-04fd-08dc427648ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
To enable a new interface so alternate scrambling can be done via
security module.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
 .../dc/link/protocols/link_dp_training.c      | 16 +----
 .../link/protocols/link_edp_panel_control.c   | 64 +++++++++++++++++
 .../link/protocols/link_edp_panel_control.h   |  2 +
 .../dc/resource/dcn351/dcn351_resource.c      |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 68 +++++++++++++++++++
 7 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d280f55ebe50..673f36543f6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -436,6 +436,7 @@ struct dc_config {
 	unsigned int disable_ips_in_vpb;
 	bool usb4_bw_alloc_support;
 	bool allow_0_dtb_clk;
+	bool use_assr_psp_message;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index a72de44a5747..9c0e2b9cffc9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2285,6 +2285,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->sink->link;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+	enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
@@ -2311,6 +2312,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
+	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
+
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index e538c67d3ed9..9de5380757e0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1587,21 +1587,7 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
-		if (panel_mode == DP_PANEL_MODE_EDP) {
-			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
-
-			if (cp_psp && cp_psp->funcs.enable_assr) {
-				/* ASSR is bound to fail with unsigned PSP
-				 * verstage used during devlopment phase.
-				 * Report and continue with eDP panel mode to
-				 * perform eDP link training with right settings
-				 */
-				bool result;
-				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
-				if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
-					panel_mode = DP_PANEL_MODE_DEFAULT;
-			}
-		}
+		edp_set_panel_assr(link, pipe_ctx, &panel_mode, true);
 
 		dp_set_panel_mode(link, panel_mode);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 3baa2bdd6dd6..0682dbbad448 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -38,6 +38,7 @@
 #include "dc/dc_dmub_srv.h"
 #include "dce/dmub_replay.h"
 #include "abm.h"
+#include "resource.h"
 #define DC_LOGGER \
 	link->ctx->logger
 #define DC_LOGGER_INIT(logger)
@@ -1145,3 +1146,66 @@ int edp_get_target_backlight_pwm(const struct dc_link *link)
 
 	return (int) abm->funcs->get_target_backlight(abm);
 }
+
+static void edp_set_assr_enable(const struct dc *pDC, struct dc_link *link,
+		struct link_resource *link_res, bool enable)
+{
+	union dmub_rb_cmd cmd;
+	bool use_hpo_dp_link_enc = false;
+	uint8_t link_enc_index = 0;
+	uint8_t phy_type = 0;
+	uint8_t phy_id = 0;
+
+	if (!pDC->config.use_assr_psp_message)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	link_enc_index = link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+
+	if (link_res->hpo_dp_link_enc) {
+		link_enc_index = link_res->hpo_dp_link_enc->inst;
+		use_hpo_dp_link_enc = true;
+	}
+
+	if (enable)
+		phy_type = ((dp_get_panel_mode(link) == DP_PANEL_MODE_EDP) ? 1 : 0);
+
+	phy_id = resource_transmitter_to_phy_idx(pDC, link->link_enc->transmitter);
+
+	cmd.assr_enable.header.type = DMUB_CMD__PSP;
+	cmd.assr_enable.header.sub_type = DMUB_CMD__PSP_ASSR_ENABLE;
+	cmd.assr_enable.assr_data.enable = enable;
+	cmd.assr_enable.assr_data.phy_port_type = phy_type;
+	cmd.assr_enable.assr_data.phy_port_id = phy_id;
+	cmd.assr_enable.assr_data.link_enc_index = link_enc_index;
+	cmd.assr_enable.assr_data.hpo_mode = use_hpo_dp_link_enc;
+
+	dc_wake_and_execute_dmub_cmd(pDC->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
+		enum dp_panel_mode *panel_mode, bool enable)
+{
+	struct link_resource *link_res = &pipe_ctx->link_res;
+	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
+
+	if (*panel_mode != DP_PANEL_MODE_EDP)
+		return;
+
+	if (link->dc->config.use_assr_psp_message) {
+		edp_set_assr_enable(link->dc, link, link_res, enable);
+	} else if (cp_psp && cp_psp->funcs.enable_assr && enable) {
+		/* ASSR is bound to fail with unsigned PSP
+		 * verstage used during devlopment phase.
+		 * Report and continue with eDP panel mode to
+		 * perform eDP link training with right settings
+		 */
+		bool result;
+
+		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
+
+		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+			*panel_mode = DP_PANEL_MODE_DEFAULT;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index a158c6234d42..eee8a4db6f85 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -76,4 +76,6 @@ bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 bool edp_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
 void edp_set_panel_power(struct dc_link *link, bool powerOn);
+void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
+		enum dp_panel_mode *panel_mode, bool enable);
 #endif /* __DC_LINK_EDP_POWER_CONTROL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 5b486400dfdb..2dfd73d5f767 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1864,6 +1864,9 @@ static bool dcn351_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+	/* Use psp mailbox to enable assr */
+	dc->config.use_assr_psp_message = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 818e5d87f0da..34cb25c6166a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1198,6 +1198,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__DPIA_HPD_INT_ENABLE = 86,
 
+	/**
+	 * Command type used for all PSP commands.
+	 */
+	DMUB_CMD__PSP = 88,
+
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -4303,6 +4308,65 @@ struct dmub_rb_cmd_secure_display {
 	} roi_info;
 };
 
+/**
+ * Command type of a DMUB_CMD__PSP command
+ */
+enum dmub_cmd_psp_type {
+	DMUB_CMD__PSP_ASSR_ENABLE = 0
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PSP_ASSR_ENABLE command.
+ */
+struct dmub_cmd_assr_enable_data {
+	/**
+	 * ASSR enable or disable.
+	 */
+	uint8_t enable;
+	/**
+	 * PHY port type.
+	 * Indicates eDP / non-eDP port type
+	 */
+	uint8_t phy_port_type;
+	/**
+	 * PHY port ID.
+	 */
+	uint8_t phy_port_id;
+	/**
+	 * Link encoder index.
+	 */
+	uint8_t link_enc_index;
+	/**
+	 * HPO mode.
+	 */
+	uint8_t hpo_mode;
+
+	/**
+	 * Reserved field.
+	 */
+	uint8_t reserved[7];
+};
+
+/**
+ * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
+ */
+struct dmub_rb_cmd_assr_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Assr data.
+	 */
+	struct dmub_cmd_assr_enable_data assr_data;
+
+	/**
+	 * Reserved field.
+	 */
+	uint32_t reserved[3];
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -4561,6 +4625,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
 	 */
 	struct dmub_rb_cmd_replay_set_pseudo_vtotal replay_set_pseudo_vtotal;
+	/**
+	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
+	 */
+	struct dmub_rb_cmd_assr_enable assr_enable;
 };
 
 /**
-- 
2.37.3

