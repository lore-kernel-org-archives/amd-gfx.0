Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A75CC77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F15810E187;
	Wed,  3 May 2023 01:41:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3AB10E187
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg483csfLUFAd8Z/KoAP4Fe5XqedkMBIGFQI7A0Nt8FxXE/pIUk99T29oP7t9UUCDtzT4sZ52WciEFZ7oMGL/YkVvji+2E4tOcsyGkNTXaLf8192uITt1xA73zZE+QlqxvJ3U5J3/uDJI06X/v1Cu9cDGMmDCaaRO8/k8QaYTZEuDgP96jzuGKuGSsDfnRwjmHJ+Dy8Slx7V8i51EomJ5MpmS0A5hP9oznJ2FvhbwmBkkoE1+c1uTEdvjcce5O9ZE61kDr6/EIrVW5W6Z9ebZOB5Hv53KWhbsvDfl//zP/66Sfh88JJARQTC4z69tbo0smiJHoktBo/mld70coFfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmHoJgnU3k9WbGo07ig1EOTNul1j4Z2BAHScIBBRM74=;
 b=nS/jpL9HyBqmMvgnjavG2nOZ03m7HK4lZC32qSyYyYEiLD/88ZZuU4pRckCZ0NOOVE49jX1VZPVQbNLxVNIdhZWlwwFcq6YYD4KHbZ5QbMY6LfKhrrIzcq6HeT0dJfHP8vGWFT7/G+IwAEnCaVsSr1wpRypu3VoiJkSpKUX8pXs1p60rYEzRXz7JmuqJe0/oUs2eYV6S5BgCg7LD7+d1jChNXE9Ltjgvr9ZCr/dRE3GM6u/Gz9C/4vfGUh/SK377pq1ffbCsNUaGIoqBBFtpfiMSnpDa2CJ69hbZjlxzVb5FIkQhKdHB5CMRL2Lr8G0lxByVj/qb0WQKHz1eCQIQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmHoJgnU3k9WbGo07ig1EOTNul1j4Z2BAHScIBBRM74=;
 b=A0LeeLZ2xlYEx7y6vgyucG3jIp0orKKKRMTrR5SJk+NblFDX+/Vh3RuXyN3qb7TcFFn2pa410GNBg5cCF9vzZvOvvjim1nfz2JAp3gjR6rh1VpC4l9dbAIA1p4oVJ5wVkgsPyAOtRvU4Emz0UOMLVuDRYmBI2NIGysWjbo9hnEU=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 01:40:55 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::2) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 01:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 01:40:13 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:40:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/display: Add symclk workaround during disable
 link output
Date: Tue, 2 May 2023 19:38:48 -0600
Message-ID: <20230503013853.2266793-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b594ea-6b72-4383-a90f-08db4b776fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvwJZdFKXFVJSfm8qUazZIN8I51epKxAI03ppKFOLskSuddd4VXQMaqUawdUp7R+5DIbQ7hixDBsD2AybmZAGxsqCIMpv3ymBveMDmwxjP86OVcyTDRBKm9bY1JANMw8dshJVHy0KB7QYMB16C83Rtj3/a3abNUZscSy9lbv7TMD3yndmsMf1FlRYzLhP/cg/1IJskOzv2tVKusL9qbrV/osi4wbEFIXbDhgDdBlzTrrynh33rlwRB5kAEmhup07HOmc4JSwwXVmJwR9dxLhVgRKiqswC5OQBJd4b2XOyzeyfXuB6MMPmlfjwOiZBLULxFVfNwJwwR845D8XSA35ov5N1XQBcseBH5yFP/Wo+Tp1Z2L//ZiUobML3wvBnFP7246hO34PMh5NCTn/vRx4pJVdRGN4HSd3VTvnFMpnoVH7oToeTSMiIBotwejx58+R5QIh1syoviZiAxUS2TFcs8bY8CJyUvIE6d/Bmgf/TOvcQrwT0uj2SPW3Kf86+VhmF6KdN2svBjhwtNr7MtnsgG7PY3vPrWqJykZg6qIaOE5xVkN03SZr8GwMmxzDO3vqqMtRtzn34PZ+cH61+TEXDqDEMlBCTkefWY0u5u2pecrGHXa7F7u53PWigDqxlcwyDClmxUxbYLBVqcCN4OmVLSc5uoRbZjfWZTDEPOHgBWGhtlaZZYY3BU0+R9n5pIrZnKT5FVX/pnRzxgfWqgomS6CKn0ouOwIa+Xd5jTwlxE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(82310400005)(316002)(1076003)(26005)(36860700001)(336012)(47076005)(41300700001)(83380400001)(4326008)(54906003)(426003)(186003)(2616005)(70586007)(70206006)(7696005)(6666004)(6916009)(82740400003)(36756003)(356005)(81166007)(2906002)(86362001)(5660300002)(8936002)(8676002)(16526019)(44832011)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:40:13.2188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b594ea-6b72-4383-a90f-08db4b776fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex
 Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
This is originally a change (9c75891f) in DCN32 because of the lack
of interface to set TX while keeping symclk on. Adding this workaround
to DCN314 will resolve the current issue.

Fixes: 9c75891feef0 ("drm/amd/display: rework recent update PHY state commit")
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 65 +++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 6fb3f64e3057..f7a3e0d71d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -421,3 +421,68 @@ void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool
 
 	PERF_TRACE();
 }
+static void apply_symclk_on_tx_off_wa(struct dc_link *link)
+{
+	/* There are use cases where SYMCLK is referenced by OTG. For instance
+	 * for TMDS signal, OTG relies SYMCLK even if TX video output is off.
+	 * However current link interface will power off PHY when disabling link
+	 * output. This will turn off SYMCLK generated by PHY. The workaround is
+	 * to identify such case where SYMCLK is still in use by OTG when we
+	 * power off PHY. When this is detected, we will temporarily power PHY
+	 * back on and move PHY's SYMCLK state to SYMCLK_ON_TX_OFF by calling
+	 * program_pix_clk interface. When OTG is disabled, we will then power
+	 * off PHY by calling disable link output again.
+	 *
+	 * In future dcn generations, we plan to rework transmitter control
+	 * interface so that we could have an option to set SYMCLK ON TX OFF
+	 * state in one step without this workaround
+	 */
+
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+	uint8_t i;
+
+	if (link->phy_state.symclk_ref_cnts.otg > 0) {
+		for (i = 0; i < MAX_PIPES; i++) {
+			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+				pipe_ctx->clock_source->funcs->program_pix_clk(
+						pipe_ctx->clock_source,
+						&pipe_ctx->stream_res.pix_clk_params,
+						dc->link_srv->dp_get_encoding_format(
+								&pipe_ctx->link_config.dp_link_settings),
+						&pipe_ctx->pll_settings);
+				link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+				break;
+			}
+		}
+	}
+}
+
+void dcn314_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+
+	apply_symclk_on_tx_off_wa(link);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index c786d5e6a428..6d0b62503caa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -45,4 +45,6 @@ void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
+void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index ce53339b2e10..ed8a1b94c006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -106,7 +106,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.disable_link_output = dcn314_disable_link_output,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
-- 
2.40.0

