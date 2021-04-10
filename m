Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E239C433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A4D61029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A4D61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DBE6E0E9;
	Sat, 10 Apr 2021 02:04:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117B56E4E6
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLdDFtn1vdfpANmhp2MmVejxb7VaWi/laWHaxyuupZ/jn5rnyvXKwH4QrdMh8Y7UZaY3Z5SgO569DdXZTBDKaQPIn3utDaOr31Ko9o6hYv9n0IOcIxLziTn+kJOJSKoAaT5A2yd78gcovun+K4T6FrQ9+lrpEiaM8KBON+Ormy55tx70kr0O82okVK6oW3w9CdEr0KG0Z5bIyoMsVgoeKFi0jdjpEuT6hvkMi+p++uMFxR3pmTYmNxiNhTdHvtM2YdFM0JGCuMMelm4JlxaQ383AkAAHgnlQJjnQKHwn3WPMGELbQoUDPFBB2NvgNkAxs1nTGZ0kzB0ifpGubrhizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtfeWpNlIlruzQfQCtwyz2asfC6JVY5PonZ5UdkjfmM=;
 b=YWLVoE37LuwDMpzbnjcL+61j0q3gErwhBvGAltrvXXSwDKhMAoQFvLo9Fm+WB5jGFq6Gz22bMpmQa/64jV0pzzZVL38n5gyq1VvYu0qpzki3BmfVAODFKvnet5rarPRBLJh/lwrNNhZ9GouhaOaXth9/+//3prqds/Nyius6t3HUdnGJdjPg7S6Oj0jH7U3Yr93dBOK5IfISyr8Aj+BkmXOg40/Gxjksvi1kQJ8x2C/vTXvTqXILw9UDd9S5x7pxd7XD6E/t8/qnTP/rTVc8FIQIszSHkQmBLa12B2EkQGel2kcNj1BcybI1o4cYxhq11kxK+RCyT33H/ip9P10WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtfeWpNlIlruzQfQCtwyz2asfC6JVY5PonZ5UdkjfmM=;
 b=AnGnak54SxcoQcTG3vQw46LAzujJmNf/ADJtCILrKLpXNqhJE9SK2wF1uNQFzPmXe6VN2UWIjhhSGooY0S274mDhE4dod+49NNRYfheg2IMPNiBUp75++dfZbh25n8rvp1fdL6+MOE4G4yI40QlZZze3P/KKu3pB25ck5DEoVQY=
Received: from MWHPR18CA0070.namprd18.prod.outlook.com (2603:10b6:300:39::32)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Sat, 10 Apr
 2021 02:04:46 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::63) by MWHPR18CA0070.outlook.office365.com
 (2603:10b6:300:39::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:44 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:43 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Fix DSC enable sequence
Date: Fri, 9 Apr 2021 22:03:48 -0400
Message-ID: <20210410020401.1100228-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e517b0e3-c0f3-44f3-29d6-08d8fbc5035c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4205B7E30514F851880AF4DEF5729@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cdBp5TDzlM3rwzyjrbMQQDx6vtHY2YKNQAt36b/vUeAgv2zSm6NCHTQg1y44cm+k5FBExDN5Bnl0vKstRvLNp88n/ZvdDl7liczjaS/mRqaw2ibY++HAcbwNjRBbNxgexXVMSrHqaYu1WmG72JmINnxmXXnFDTUM4pwxZpqboT3L/Xm06r/VZkiwtGstt/MPqCGxMP68LIhu3BpU0LUj3ggpRd9mFJOBDgFTDzrqzYPcF9lLKcPworCow5vV+iVJ1lcDddw6x9hnrdjTWx5g2xHKHOTrosgvNA5HwKKZVvKVrwrUGMhL6qwcZnOStUzmLtkzWizz1CmZzP9LeDkUXC20WYaf288sBIr/9+r59KLFMsnhhaVN0JT4mXL7GuYASW1so/w4Oov+59HRt0MPbCa1pnJ5qc/3Ip0bKR/+megT5+YKwhwWB8kGff+hX3Dlzz9LE8Mv7kpwFNnFS0LcUqKEMxEu+f3Z1bDLIIrD8nVrDKatTDOsBG7x9IfRygX/62w3G7VAzLXHk0+spciOlrsfKBr+r/+yXZb2Tn8wMGUEiwuVOqvkP4atKUoAuylOoIkq1b/toFIWVawITyir15anBUAXdunKawlWDNZcVQz8iQ8yEz0UdNIaoOfHHc3nD8NhDaGtyaLAwCd5O+wqpJixjBxtgt9yP96vahRxhLMbO/9XG/Fslc2vWvfppHZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(4326008)(86362001)(70586007)(5660300002)(82740400003)(8936002)(36860700001)(316002)(336012)(70206006)(8676002)(81166007)(7696005)(356005)(1076003)(82310400003)(478600001)(6916009)(47076005)(36756003)(54906003)(83380400001)(26005)(2906002)(426003)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:45.4666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e517b0e3-c0f3-44f3-29d6-08d8fbc5035c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: Mike Hsieh <Mike.Hsieh@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Mike Hsieh <chun-wei.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <chun-wei.hsieh@amd.com>

[Why]
DSC is enabled before reset link and potentially cause DSC enable fail problem.
[How]
Enable DSC after link is reseted

Signed-off-by: Mike Hsieh <Mike.Hsieh@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 10 +++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                |  4 ++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |  2 ++
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 29bc2874f6a7..ac7a2b74702e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3296,7 +3296,8 @@ void core_link_enable_stream(
 
 		/* eDP lit up by bios already, no need to enable again. */
 		if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
-					apply_edp_fast_boot_optimization) {
+					apply_edp_fast_boot_optimization &&
+					!pipe_ctx->stream->timing.flags.DSC) {
 			pipe_ctx->stream->dpms_off = false;
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 			update_psp_stream_config(pipe_ctx, false);
@@ -3358,8 +3359,10 @@ void core_link_enable_stream(
 		/* Set DPS PPS SDP (AKA "info frames") */
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-					dc_is_virtual_signal(pipe_ctx->stream->signal))
+					dc_is_virtual_signal(pipe_ctx->stream->signal)) {
+				dp_set_dsc_on_rx(pipe_ctx, true);
 				dp_set_dsc_pps_sdp(pipe_ctx, true);
+			}
 		}
 
 		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
@@ -3754,7 +3757,8 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 	if ((link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
 			link->local_sink &&
 			link->local_sink->edid_caps.panel_patch.disable_fec) ||
-			link->connector_signal == SIGNAL_TYPE_EDP) // Disable FEC for eDP
+			(link->connector_signal == SIGNAL_TYPE_EDP &&
+					link->dc->debug.force_enable_edp_fec == false)) // Disable FEC for eDP
 		is_fec_disable = true;
 
 	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec && !is_fec_disable)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 48ad1a8d4a74..b426f878fb99 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -431,7 +431,7 @@ static void dsc_optc_config_log(struct display_stream_compressor *dsc,
 	DC_LOG_DSC("\tslice_width %d", config->slice_width);
 }
 
-static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
+bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -541,7 +541,7 @@ bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
 		goto out;
 
 	if (enable) {
-		if (dp_set_dsc_on_rx(pipe_ctx, true)) {
+		{
 			dp_set_dsc_on_stream(pipe_ctx, true);
 			result = true;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f9fe03cb2536..d218d665ed27 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -541,6 +541,10 @@ struct dc_debug_options {
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
 	bool optimize_edp_link_rate; /* eDP ILR */
+	/* force enable edp FEC */
+	bool force_enable_edp_fec;
+	/* FEC/PSR1 sequence enable delay in 100us */
+	uint8_t fec_enable_delay_in100us;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 28ff059aa7f3..5e99553fcdd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -284,6 +284,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
+	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
+	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index d3901403c30b..9a5ef86b2aa0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -88,5 +88,7 @@ bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
+bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
+
 
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
