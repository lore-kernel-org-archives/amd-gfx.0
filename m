Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA997C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0143110E6FC;
	Fri, 28 Jan 2022 14:05:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3E510E3DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf1prD14NPpfPADpVpbXCBSXvTX7dwlH8hRr0MeTodMo1ZlZbMtmHM2WmtoIyRrHNiGiWu27TJOGcXG1S5/EYxr0u/Qdq/Qv1tI+u97TkJ2Zchs9Y10QBEzck8PvbTREJdRBcE7PT40GwkewpYQGm326sGq6nTqEysu1JHCm2WcFNZsAiCkswjCSyFwJ2MMd1rXGc9c/ZtmFaRQkwS6PYvYmNOx7GxrmWQgF3HE1PP4urn49VtZDZdNiDXT2b7uKlZfaRtFgqoUkD5bGW/3981Wl+R9M37jmiQgiusLZjP5jhIAaFurl1S19mCopA8DfqmJjHZbAA2D2wIkcj3h+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbEcpu+lPzVOMxRF2prSwYtzZRGvijGnVtZNiaRk6RU=;
 b=QrG44Pshncqzoe3cbcIVNx0JEX+GKJ8pwmvlG2fz8WtfC2w3QTYjtUCdwX4Id0h4swPk+cnaAbXCH7ug5IyCdryGTG69adwOmcyL1z6uzPH5t+nucUUY5btQ1hkCKbL8LtYK8bZDkrcDa7wB0l+DAuYVrQ+CZ611QVv05WyeFdwP4b7OJpUUaHQm1GnYFjWcL+rVNVWHSLeMF9O0s6z5pD/FEtq5K855+4yxignmpcwfBfDsJVTMEsrJGz8KCFlNM5TnMyONnPJY/JdftRCHL2WyIW/+zQE85650t8336BVYb8lRt+kTE3kN/wPQn8E938LbtWMCqb54j8hU+9aemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbEcpu+lPzVOMxRF2prSwYtzZRGvijGnVtZNiaRk6RU=;
 b=cXDoBKmLDdMzHkql+Z3vvEQWmZj6c8OX8APHlFpjN5gARdYhOl1ucfjClMk09736tBrK797IWt/AXcTiiXhjUyT5LFcZw1j28JI+BG3YJ/mXnomN2NdbChAJnS33/CAIUAE3KQbrpDqXFBcOnCgLCHyaY6RFVco80oCYvSxiDYY=
Received: from DM5PR04CA0066.namprd04.prod.outlook.com (2603:10b6:3:ef::28) by
 CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 14:05:47 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::4b) by DM5PR04CA0066.outlook.office365.com
 (2603:10b6:3:ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:46 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:41 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/17] drm/amd/display: temporarly move non link_hwss code to
 dc_link_dp
Date: Fri, 28 Jan 2022 22:04:05 +0800
Message-ID: <20220128140411.3683309-12-stylon.wang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 010bf6d9-6516-4e5c-bb99-08d9e2674836
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475C7283F97A74C2F032C33FF229@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW5SScPablN7dmjNXLuz/uhjnzLjdhQZ08ov8ZwZPfiLrdpPEe7xYwnWrRhTBDMV7PB61dkxCF5k8F3eSzBQ/Z7pi0tHpHuRrf0/8RYYdrViX/yTnooZeFc0NvJziVcFDJGw5nYm1jzER3EZEf83yzT6wLr29UuzXqmxVEdoyvgQeRJTpGF035p22dzRrttzwh50ZDV8h7DLFNjji9X+KtxmqKPqmTYeX+z05rhQcoeLICRs93/0VEjh8jQlMaHwBkReFooN+O2oqZ5CQokZnL4pf+vPApOulzFDo2ltF8SF9OzKWTg2hYqSlIuqLerN5Mpw1aEOVsVI6wXocumhXsAJKCd6KmGa+yOp80iyHNp+b1av8eQbSH4GE0H7Ae9HVmqbRorcGgF+EPh4cehyAM/8LxdSqqiyT/f/G4IdOSN04FrcK9xmojg7pJvZON8iPtg/GSlob51PknnnLfNkbZsMBtEcywwEU050v43h8iOSKdeK20/XvqS09DiAKGL+4tl78bZurzkLUG/ZZ9a6tBNJ4yu23/WaFGMGC20ls8n/Ly9kHpTqHqzq/6wdsXfrn+x6RY4GZ7BXuCZgkhT6P4OJX1hMpJL4/HLFhHRL6ZS4j5c4TX63bp0A5BIXxsSxQCtzh50HoEKWQHyyTg8FfxczoCNXZAPL/44HeF/E4uduF9O2MlwwaptA/uQV47x+ab5C9ROlsHWN/+Z2letSzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(30864003)(44832011)(82310400004)(8936002)(4326008)(36756003)(70206006)(70586007)(8676002)(16526019)(2616005)(86362001)(26005)(186003)(426003)(336012)(1076003)(81166007)(83380400001)(2906002)(40460700003)(47076005)(36860700001)(356005)(6666004)(7696005)(508600001)(54906003)(316002)(6916009)(36900700001)(579004)(559001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:46.9753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010bf6d9-6516-4e5c-bb99-08d9e2674836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Clean up dc_link_hwss file in the preparation of breaking it down to file for
each encoder type. We temporarly move the original dp link functions in link_hwss
back to dc_link_dp. We will break dc_link_dp down after link_hwss is in good shape.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 613 ++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 653 +-----------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  40 ++
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    |   2 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  56 +-
 7 files changed, 682 insertions(+), 687 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index abec79e80eed..51347e1d3d95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -27,6 +27,7 @@
 #include "dm_helpers.h"
 #include "opp.h"
 #include "dsc.h"
+#include "clk_mgr.h"
 #include "resource.h"
 
 #include "inc/core_types.h"
@@ -6713,3 +6714,615 @@ void dc_link_dp_clear_rx_status(struct dc_link *link)
 {
 	memset(&link->dprx_status, 0, sizeof(link->dprx_status));
 }
+
+void dp_receiver_power_ctrl(struct dc_link *link, bool on)
+{
+	uint8_t state;
+
+	state = on ? DP_POWER_STATE_D0 : DP_POWER_STATE_D3;
+
+	if (link->sync_lt_in_progress)
+		return;
+
+	core_link_write_dpcd(link, DP_SET_POWER, &state,
+						 sizeof(state));
+
+}
+
+void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
+{
+	if (link != NULL && link->dc->debug.enable_driver_sequence_debug)
+		core_link_write_dpcd(link, DP_SOURCE_SEQUENCE,
+					&dp_test_mode, sizeof(dp_test_mode));
+}
+
+
+static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
+{
+	switch (lttpr_repeater_count) {
+	case 0x80: // 1 lttpr repeater
+		return 1;
+	case 0x40: // 2 lttpr repeaters
+		return 2;
+	case 0x20: // 3 lttpr repeaters
+		return 3;
+	case 0x10: // 4 lttpr repeaters
+		return 4;
+	case 0x08: // 5 lttpr repeaters
+		return 5;
+	case 0x04: // 6 lttpr repeaters
+		return 6;
+	case 0x02: // 7 lttpr repeaters
+		return 7;
+	case 0x01: // 8 lttpr repeaters
+		return 8;
+	default:
+		break;
+	}
+	return 0; // invalid value
+}
+
+static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset)
+{
+	return (convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == offset);
+}
+
+void dp_enable_link_phy(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum signal_type signal,
+	enum clock_source_id clock_source,
+	const struct dc_link_settings *link_settings)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct pipe_ctx *pipes =
+			link->dc->current_state->res_ctx.pipe_ctx;
+	struct clock_source *dp_cs =
+			link->dc->res_pool->dp_clock_source;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	unsigned int i;
+
+	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		link->dc->hwss.edp_power_control(link, true);
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	}
+
+	/* If the current pixel clock source is not DTO(happens after
+	 * switching from HDMI passive dongle to DP on the same connector),
+	 * switch the pixel clock source to DTO.
+	 */
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream != NULL &&
+			pipes[i].stream->link == link) {
+			if (pipes[i].clock_source != NULL &&
+					pipes[i].clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
+				pipes[i].clock_source = dp_cs;
+				pipes[i].stream_res.pix_clk_params.requested_pix_clk_100hz =
+						pipes[i].stream->timing.pix_clk_100hz;
+				pipes[i].clock_source->funcs->program_pix_clk(
+							pipes[i].clock_source,
+							&pipes[i].stream_res.pix_clk_params,
+							&pipes[i].pll_settings);
+			}
+		}
+	}
+
+	link->cur_link_settings = *link_settings;
+
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (dc->clk_mgr->funcs->notify_link_rate_change)
+			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+	}
+
+	if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (link_hwss->ext.enable_dp_link_output)
+		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
+				clock_source, link_settings);
+
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
+	dp_receiver_power_ctrl(link, true);
+}
+
+void edp_add_delay_for_T9(struct dc_link *link)
+{
+	if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
+		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
+}
+
+bool edp_receiver_ready_T9(struct dc_link *link)
+{
+	unsigned int tries = 0;
+	unsigned char sinkstatus = 0;
+	unsigned char edpRev = 0;
+	enum dc_status result = DC_OK;
+	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
+
+	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		do {
+			sinkstatus = 1;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 0)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(100); //MAx T9
+		} while (++tries < 50);
+	}
+
+	return result;
+}
+bool edp_receiver_ready_T7(struct dc_link *link)
+{
+	unsigned char sinkstatus = 0;
+	unsigned char edpRev = 0;
+	enum dc_status result = DC_OK;
+
+	/* use absolute time stamp to constrain max T7*/
+	unsigned long long enter_timestamp = 0;
+	unsigned long long finish_timestamp = 0;
+	unsigned long long time_taken_in_ns = 0;
+
+	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
+
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+		enter_timestamp = dm_get_timestamp(link->ctx);
+		do {
+			sinkstatus = 0;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 1)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(25);
+			finish_timestamp = dm_get_timestamp(link->ctx);
+			time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
+		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
+	}
+
+	if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
+		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
+
+	return result;
+}
+
+void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+
+	if (!link->wa_flags.dp_keep_receiver_powered)
+		dp_receiver_power_ctrl(link, false);
+
+	if (signal == SIGNAL_TYPE_EDP) {
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, false);
+		if (link_hwss->ext.disable_dp_link_output)
+			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
+		link->dc->hwss.edp_power_control(link, false);
+	} else {
+		if (dmcu != NULL && dmcu->funcs->lock_phy)
+			dmcu->funcs->lock_phy(dmcu);
+		if (link_hwss->ext.disable_dp_link_output)
+			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
+		if (dmcu != NULL && dmcu->funcs->unlock_phy)
+			dmcu->funcs->unlock_phy(dmcu);
+	}
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+
+	/* Clear current link setting.*/
+	memset(&link->cur_link_settings, 0,
+			sizeof(link->cur_link_settings));
+
+	if (dc->clk_mgr->funcs->notify_link_rate_change)
+		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+}
+
+void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	/* MST disable link only when no stream use the link */
+	if (link->mst_stream_alloc_table.stream_count > 0)
+		return;
+
+	dp_disable_link_phy(link, link_res, signal);
+
+	/* set the sink to SST mode after disabling the link */
+	dp_enable_mst_on_sink(link, false);
+}
+
+bool dp_set_hw_training_pattern(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum dc_dp_training_pattern pattern,
+	uint32_t offset)
+{
+	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
+
+	switch (pattern) {
+	case DP_TRAINING_PATTERN_SEQUENCE_1:
+		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN1;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_2:
+		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN2;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_3:
+		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN3;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_4:
+		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN4;
+		break;
+	case DP_128b_132b_TPS1:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE;
+		break;
+	case DP_128b_132b_TPS2:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE;
+		break;
+	default:
+		break;
+	}
+
+	dp_set_hw_test_pattern(link, link_res, test_pattern, NULL, 0);
+
+	return true;
+}
+
+void dp_set_hw_lane_settings(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	const struct link_training_settings *link_settings,
+	uint32_t offset)
+{
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+
+	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
+		return;
+
+	if (link_hwss->ext.set_dp_lane_settings)
+		link_hwss->ext.set_dp_lane_settings(link, link_res,
+				&link_settings->link_settings,
+				link_settings->hw_lane_settings);
+
+	memmove(link->cur_lane_setting,
+			link_settings->hw_lane_settings,
+			sizeof(link->cur_lane_setting));
+}
+
+void dp_set_hw_test_pattern(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum dp_test_pattern test_pattern,
+	uint8_t *custom_pattern,
+	uint32_t custom_pattern_size)
+{
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
+
+	pattern_param.dp_phy_pattern = test_pattern;
+	pattern_param.custom_pattern = custom_pattern;
+	pattern_param.custom_pattern_size = custom_pattern_size;
+	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
+
+	if (link_hwss->ext.set_dp_link_test_pattern)
+		link_hwss->ext.set_dp_link_test_pattern(link, link_res, &pattern_param);
+}
+
+void dp_retrain_link_dp_test(struct dc_link *link,
+			struct dc_link_settings *link_setting,
+			bool skip_video_pattern)
+{
+	struct pipe_ctx *pipes =
+			&link->dc->current_state->res_ctx.pipe_ctx[0];
+	unsigned int i;
+
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream != NULL &&
+			!pipes[i].top_pipe && !pipes[i].prev_odm_pipe &&
+			pipes[i].stream->link != NULL &&
+			pipes[i].stream_res.stream_enc != NULL &&
+			pipes[i].stream->link == link) {
+			udelay(100);
+
+			pipes[i].stream_res.stream_enc->funcs->dp_blank(link,
+					pipes[i].stream_res.stream_enc);
+
+			/* disable any test pattern that might be active */
+			dp_set_hw_test_pattern(link, &pipes[i].link_res,
+					DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
+
+			dp_receiver_power_ctrl(link, false);
+
+			link->dc->hwss.disable_stream(&pipes[i]);
+			if ((&pipes[i])->stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
+				(&pipes[i])->stream_res.audio->funcs->az_disable((&pipes[i])->stream_res.audio);
+
+			if (link->link_enc)
+				link->link_enc->funcs->disable_output(
+						link->link_enc,
+						SIGNAL_TYPE_DISPLAY_PORT);
+
+			/* Clear current link setting. */
+			memset(&link->cur_link_settings, 0,
+				sizeof(link->cur_link_settings));
+
+			perform_link_training_with_retries(
+					link_setting,
+					skip_video_pattern,
+					LINK_TRAINING_ATTEMPTS,
+					&pipes[i],
+					SIGNAL_TYPE_DISPLAY_PORT,
+					false);
+
+			link->dc->hwss.enable_stream(&pipes[i]);
+
+			link->dc->hwss.unblank_stream(&pipes[i],
+					link_setting);
+
+			if (pipes[i].stream_res.audio) {
+				/* notify audio driver for
+				 * audio modes of monitor */
+				pipes[i].stream_res.audio->funcs->az_enable(
+						pipes[i].stream_res.audio);
+
+				/* un-mute audio */
+				/* TODO: audio should be per stream rather than
+				 * per link */
+				pipes[i].stream_res.stream_enc->funcs->
+				audio_mute_control(
+					pipes[i].stream_res.stream_enc, false);
+			}
+		}
+	}
+}
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+	dsc->ctx->logger
+static void dsc_optc_config_log(struct display_stream_compressor *dsc,
+		struct dsc_optc_config *config)
+{
+	uint32_t precision = 1 << 28;
+	uint32_t bytes_per_pixel_int = config->bytes_per_pixel / precision;
+	uint32_t bytes_per_pixel_mod = config->bytes_per_pixel % precision;
+	uint64_t ll_bytes_per_pix_fraq = bytes_per_pixel_mod;
+
+	/* 7 fractional digits decimal precision for bytes per pixel is enough because DSC
+	 * bits per pixel precision is 1/16th of a pixel, which means bytes per pixel precision is
+	 * 1/16/8 = 1/128 of a byte, or 0.0078125 decimal
+	 */
+	ll_bytes_per_pix_fraq *= 10000000;
+	ll_bytes_per_pix_fraq /= precision;
+
+	DC_LOG_DSC("\tbytes_per_pixel 0x%08x (%d.%07d)",
+			config->bytes_per_pixel, bytes_per_pixel_int, (uint32_t)ll_bytes_per_pix_fraq);
+	DC_LOG_DSC("\tis_pixel_format_444 %d", config->is_pixel_format_444);
+	DC_LOG_DSC("\tslice_width %d", config->slice_width);
+}
+
+bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	bool result = false;
+
+	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+		result = true;
+	else
+		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
+	return result;
+}
+
+/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
+ * i.e. after dp_enable_dsc_on_rx() had been called
+ */
+void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct pipe_ctx *odm_pipe;
+	int opp_cnt = 1;
+
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		opp_cnt++;
+
+	if (enable) {
+		struct dsc_config dsc_cfg;
+		struct dsc_optc_config dsc_optc_cfg;
+		enum optc_dsc_mode optc_dsc_mode;
+
+		/* Enable DSC hw block */
+		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
+		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
+		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
+		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+
+		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
+		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
+			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
+		}
+		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
+		dsc_cfg.pic_width *= opp_cnt;
+
+		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+
+		/* Enable DSC in encoder */
+		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)
+				&& !is_dp_128b_132b_signal(pipe_ctx)) {
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
+			dsc_optc_config_log(dsc, &dsc_optc_cfg);
+			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
+									optc_dsc_mode,
+									dsc_optc_cfg.bytes_per_pixel,
+									dsc_optc_cfg.slice_width);
+
+			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
+		}
+
+		/* Enable DSC in OPTC */
+		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+		dsc_optc_config_log(dsc, &dsc_optc_cfg);
+		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
+							optc_dsc_mode,
+							dsc_optc_cfg.bytes_per_pixel,
+							dsc_optc_cfg.slice_width);
+	} else {
+		/* disable DSC in OPTC */
+		pipe_ctx->stream_res.tg->funcs->set_dsc_config(
+				pipe_ctx->stream_res.tg,
+				OPTC_DSC_DISABLED, 0, 0);
+
+		/* disable DSC in stream encoder */
+		if (dc_is_dp_signal(stream->signal)) {
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL,
+										true);
+			else if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+						pipe_ctx->stream_res.stream_enc,
+						OPTC_DSC_DISABLED, 0, 0);
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+							pipe_ctx->stream_res.stream_enc, false, NULL, true);
+			}
+		}
+
+		/* disable DSC block */
+		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+	}
+}
+
+bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	bool result = false;
+
+	if (!pipe_ctx->stream->timing.flags.DSC)
+		goto out;
+	if (!dsc)
+		goto out;
+
+	if (enable) {
+		{
+			dp_set_dsc_on_stream(pipe_ctx, true);
+			result = true;
+		}
+	} else {
+		dp_set_dsc_on_rx(pipe_ctx, false);
+		dp_set_dsc_on_stream(pipe_ctx, false);
+		result = true;
+	}
+out:
+	return result;
+}
+
+/*
+ * For dynamic bpp change case, dsc is programmed with MASTER_UPDATE_LOCK enabled;
+ * hence PPS info packet update need to use frame update instead of immediate update.
+ * Added parameter immediate_update for this purpose.
+ * The decision to use frame update is hard-coded in function dp_update_dsc_config(),
+ * which is the only place where a "false" would be passed in for param immediate_update.
+ *
+ * immediate_update is only applicable when DSC is enabled.
+ */
+bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+
+	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
+		return false;
+
+	if (enable) {
+		struct dsc_config dsc_cfg;
+		uint8_t dsc_packed_pps[128];
+
+		memset(&dsc_cfg, 0, sizeof(dsc_cfg));
+		memset(dsc_packed_pps, 0, 128);
+
+		/* Enable DSC hw block */
+		dsc_cfg.pic_width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
+		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
+		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+
+		DC_LOG_DSC(" ");
+		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
+		if (dc_is_dp_signal(stream->signal)) {
+			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.stream_enc->id);
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										true,
+										&dsc_packed_pps[0],
+										immediate_update);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+						pipe_ctx->stream_res.stream_enc,
+						true,
+						&dsc_packed_pps[0],
+						immediate_update);
+		}
+	} else {
+		/* disable DSC PPS in stream encoder */
+		if (dc_is_dp_signal(stream->signal)) {
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL,
+										true);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+						pipe_ctx->stream_res.stream_enc, false, NULL, true);
+		}
+	}
+
+	return true;
+}
+
+
+bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+
+	if (!pipe_ctx->stream->timing.flags.DSC)
+		return false;
+	if (!dsc)
+		return false;
+
+	dp_set_dsc_on_stream(pipe_ctx, true);
+	dp_set_dsc_pps_sdp(pipe_ctx, true, false);
+	return true;
+}
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+	link->ctx->logger
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 3b7ab2ca34c6..96414f99c671 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -1,640 +1,11 @@
 /* Copyright 2015 Advanced Micro Devices, Inc. */
 
-
-#include "dm_services.h"
-#include "dc.h"
-#include "inc/core_types.h"
-#include "include/ddc_service_types.h"
-#include "include/i2caux_interface.h"
 #include "link_hwss.h"
-#include "hw_sequencer.h"
-#include "dc_link_dp.h"
-#include "dc_link_ddc.h"
 #include "dm_helpers.h"
-#include "dpcd_defs.h"
-#include "dsc.h"
-#include "resource.h"
-#include "link_enc_cfg.h"
-#include "clk_mgr.h"
-#include "inc/link_dpcd.h"
+#include "core_types.h"
 #include "dccg.h"
-
-static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
-{
-	switch (lttpr_repeater_count) {
-	case 0x80: // 1 lttpr repeater
-		return 1;
-	case 0x40: // 2 lttpr repeaters
-		return 2;
-	case 0x20: // 3 lttpr repeaters
-		return 3;
-	case 0x10: // 4 lttpr repeaters
-		return 4;
-	case 0x08: // 5 lttpr repeaters
-		return 5;
-	case 0x04: // 6 lttpr repeaters
-		return 6;
-	case 0x02: // 7 lttpr repeaters
-		return 7;
-	case 0x01: // 8 lttpr repeaters
-		return 8;
-	default:
-		break;
-	}
-	return 0; // invalid value
-}
-
-static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset)
-{
-	return (convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == offset);
-}
-
-void dp_receiver_power_ctrl(struct dc_link *link, bool on)
-{
-	uint8_t state;
-
-	state = on ? DP_POWER_STATE_D0 : DP_POWER_STATE_D3;
-
-	if (link->sync_lt_in_progress)
-		return;
-
-	core_link_write_dpcd(link, DP_SET_POWER, &state,
-			sizeof(state));
-}
-
-void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
-{
-	if (link != NULL && link->dc->debug.enable_driver_sequence_debug)
-		core_link_write_dpcd(link, DP_SOURCE_SEQUENCE,
-					&dp_test_mode, sizeof(dp_test_mode));
-}
-
-void dp_enable_link_phy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum signal_type signal,
-	enum clock_source_id clock_source,
-	const struct dc_link_settings *link_settings)
-{
-	struct dc  *dc = link->ctx->dc;
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	struct pipe_ctx *pipes =
-			link->dc->current_state->res_ctx.pipe_ctx;
-	struct clock_source *dp_cs =
-			link->dc->res_pool->dp_clock_source;
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-	unsigned int i;
-
-	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		link->dc->hwss.edp_power_control(link, true);
-		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
-	}
-
-	/* If the current pixel clock source is not DTO(happens after
-	 * switching from HDMI passive dongle to DP on the same connector),
-	 * switch the pixel clock source to DTO.
-	 */
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream != NULL &&
-			pipes[i].stream->link == link) {
-			if (pipes[i].clock_source != NULL &&
-					pipes[i].clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
-				pipes[i].clock_source = dp_cs;
-				pipes[i].stream_res.pix_clk_params.requested_pix_clk_100hz =
-						pipes[i].stream->timing.pix_clk_100hz;
-				pipes[i].clock_source->funcs->program_pix_clk(
-							pipes[i].clock_source,
-							&pipes[i].stream_res.pix_clk_params,
-							&pipes[i].pll_settings);
-			}
-		}
-	}
-
-	link->cur_link_settings = *link_settings;
-
-	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
-		/* TODO - DP2.0 HW: notify link rate change here */
-	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
-		if (dc->clk_mgr->funcs->notify_link_rate_change)
-			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
-	}
-
-	if (dmcu != NULL && dmcu->funcs->lock_phy)
-		dmcu->funcs->lock_phy(dmcu);
-
-	if (link_hwss->ext.enable_dp_link_output)
-		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
-				clock_source, link_settings);
-
-	if (dmcu != NULL && dmcu->funcs->unlock_phy)
-		dmcu->funcs->unlock_phy(dmcu);
-
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
-	dp_receiver_power_ctrl(link, true);
-}
-
-void edp_add_delay_for_T9(struct dc_link *link)
-{
-	if (link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
-		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
-}
-
-bool edp_receiver_ready_T9(struct dc_link *link)
-{
-	unsigned int tries = 0;
-	unsigned char sinkstatus = 0;
-	unsigned char edpRev = 0;
-	enum dc_status result;
-
-	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-
-    /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-	if (result == DC_OK && edpRev >= DP_EDP_12) {
-		do {
-			sinkstatus = 1;
-			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-			if (sinkstatus == 0)
-				break;
-			if (result != DC_OK)
-				break;
-			udelay(100); //MAx T9
-		} while (++tries < 50);
-	}
-
-	return result;
-}
-bool edp_receiver_ready_T7(struct dc_link *link)
-{
-	unsigned char sinkstatus = 0;
-	unsigned char edpRev = 0;
-	enum dc_status result;
-
-	/* use absolute time stamp to constrain max T7*/
-	unsigned long long enter_timestamp = 0;
-	unsigned long long finish_timestamp = 0;
-	unsigned long long time_taken_in_ns = 0;
-
-	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-
-	if (result == DC_OK && edpRev >= DP_EDP_12) {
-		/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-		enter_timestamp = dm_get_timestamp(link->ctx);
-		do {
-			sinkstatus = 0;
-			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-			if (sinkstatus == 1)
-				break;
-			if (result != DC_OK)
-				break;
-			udelay(25);
-			finish_timestamp = dm_get_timestamp(link->ctx);
-			time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
-		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
-	}
-
-	if (link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
-		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
-
-	return result;
-}
-
-void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	struct dc  *dc = link->ctx->dc;
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-
-	if (!link->wa_flags.dp_keep_receiver_powered)
-		dp_receiver_power_ctrl(link, false);
-
-	if (signal == SIGNAL_TYPE_EDP) {
-		if (link->dc->hwss.edp_backlight_control)
-			link->dc->hwss.edp_backlight_control(link, false);
-
-		if (link_hwss->ext.disable_dp_link_output)
-			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-		link->dc->hwss.edp_power_control(link, false);
-	} else {
-		if (dmcu != NULL && dmcu->funcs->lock_phy)
-			dmcu->funcs->lock_phy(dmcu);
-
-		if (link_hwss->ext.disable_dp_link_output)
-			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-
-		if (dmcu != NULL && dmcu->funcs->unlock_phy)
-			dmcu->funcs->unlock_phy(dmcu);
-	}
-
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
-
-	/* Clear current link setting.*/
-	memset(&link->cur_link_settings, 0,
-			sizeof(link->cur_link_settings));
-
-	if (dc->clk_mgr->funcs->notify_link_rate_change)
-		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
-}
-
-void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	/* MST disable link only when no stream use the link */
-	if (link->mst_stream_alloc_table.stream_count > 0)
-		return;
-
-	dp_disable_link_phy(link, link_res, signal);
-
-	/* set the sink to SST mode after disabling the link */
-	dp_enable_mst_on_sink(link, false);
-}
-
-bool dp_set_hw_training_pattern(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum dc_dp_training_pattern pattern,
-	uint32_t offset)
-{
-	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
-
-	switch (pattern) {
-	case DP_TRAINING_PATTERN_SEQUENCE_1:
-		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN1;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_2:
-		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN2;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_3:
-		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN3;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_4:
-		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN4;
-		break;
-	case DP_128b_132b_TPS1:
-		test_pattern = DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE;
-		break;
-	case DP_128b_132b_TPS2:
-		test_pattern = DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE;
-		break;
-	default:
-		break;
-	}
-
-	dp_set_hw_test_pattern(link, link_res, test_pattern, NULL, 0);
-
-	return true;
-}
-
-#define DC_LOGGER \
-	link->ctx->logger
-void dp_set_hw_lane_settings(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	const struct link_training_settings *link_settings,
-	uint32_t offset)
-{
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-
-	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
-		return;
-
-	if (link_hwss->ext.set_dp_lane_settings)
-		link_hwss->ext.set_dp_lane_settings(link, link_res,
-				&link_settings->link_settings,
-				link_settings->hw_lane_settings);
-
-	memmove(link->cur_lane_setting,
-			link_settings->lane_settings,
-			sizeof(link->cur_lane_setting));
-}
-
-void dp_set_hw_test_pattern(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum dp_test_pattern test_pattern,
-	uint8_t *custom_pattern,
-	uint32_t custom_pattern_size)
-{
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
-
-	pattern_param.dp_phy_pattern = test_pattern;
-	pattern_param.custom_pattern = custom_pattern;
-	pattern_param.custom_pattern_size = custom_pattern_size;
-	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
-
-	if (link_hwss->ext.set_dp_link_test_pattern)
-		link_hwss->ext.set_dp_link_test_pattern(link, link_res, &pattern_param);
-}
-#undef DC_LOGGER
-
-void dp_retrain_link_dp_test(struct dc_link *link,
-			struct dc_link_settings *link_setting,
-			bool skip_video_pattern)
-{
-	struct pipe_ctx *pipes =
-			&link->dc->current_state->res_ctx.pipe_ctx[0];
-	unsigned int i;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream != NULL &&
-			!pipes[i].top_pipe && !pipes[i].prev_odm_pipe &&
-			pipes[i].stream->link != NULL &&
-			pipes[i].stream_res.stream_enc != NULL &&
-			pipes[i].stream->link == link) {
-			udelay(100);
-
-			pipes[i].stream_res.stream_enc->funcs->dp_blank(link,
-					pipes[i].stream_res.stream_enc);
-
-			/* disable any test pattern that might be active */
-			dp_set_hw_test_pattern(link, &pipes[i].link_res,
-					DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
-
-			dp_receiver_power_ctrl(link, false);
-
-			link->dc->hwss.disable_stream(&pipes[i]);
-			if ((&pipes[i])->stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
-				(&pipes[i])->stream_res.audio->funcs->az_disable((&pipes[i])->stream_res.audio);
-
-			if (link->link_enc)
-				link->link_enc->funcs->disable_output(
-						link->link_enc,
-						SIGNAL_TYPE_DISPLAY_PORT);
-
-			/* Clear current link setting. */
-			memset(&link->cur_link_settings, 0,
-				sizeof(link->cur_link_settings));
-
-			perform_link_training_with_retries(
-					link_setting,
-					skip_video_pattern,
-					LINK_TRAINING_ATTEMPTS,
-					&pipes[i],
-					SIGNAL_TYPE_DISPLAY_PORT,
-					false);
-
-			link->dc->hwss.enable_stream(&pipes[i]);
-
-			link->dc->hwss.unblank_stream(&pipes[i],
-					link_setting);
-
-			if (pipes[i].stream_res.audio) {
-				/* notify audio driver for
-				 * audio modes of monitor */
-				pipes[i].stream_res.audio->funcs->az_enable(
-						pipes[i].stream_res.audio);
-
-				/* un-mute audio */
-				/* TODO: audio should be per stream rather than
-				 * per link */
-				pipes[i].stream_res.stream_enc->funcs->
-				audio_mute_control(
-					pipes[i].stream_res.stream_enc, false);
-			}
-		}
-	}
-}
-
-#define DC_LOGGER \
-	dsc->ctx->logger
-static void dsc_optc_config_log(struct display_stream_compressor *dsc,
-		struct dsc_optc_config *config)
-{
-	uint32_t precision = 1 << 28;
-	uint32_t bytes_per_pixel_int = config->bytes_per_pixel / precision;
-	uint32_t bytes_per_pixel_mod = config->bytes_per_pixel % precision;
-	uint64_t ll_bytes_per_pix_fraq = bytes_per_pixel_mod;
-
-	/* 7 fractional digits decimal precision for bytes per pixel is enough because DSC
-	 * bits per pixel precision is 1/16th of a pixel, which means bytes per pixel precision is
-	 * 1/16/8 = 1/128 of a byte, or 0.0078125 decimal
-	 */
-	ll_bytes_per_pix_fraq *= 10000000;
-	ll_bytes_per_pix_fraq /= precision;
-
-	DC_LOG_DSC("\tbytes_per_pixel 0x%08x (%d.%07d)",
-			config->bytes_per_pixel, bytes_per_pixel_int, (uint32_t)ll_bytes_per_pix_fraq);
-	DC_LOG_DSC("\tis_pixel_format_444 %d", config->is_pixel_format_444);
-	DC_LOG_DSC("\tslice_width %d", config->slice_width);
-}
-
-bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	bool result = false;
-
-	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		result = true;
-	else
-		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
-	return result;
-}
-
-/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
- * i.e. after dp_enable_dsc_on_rx() had been called
- */
-void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct pipe_ctx *odm_pipe;
-	int opp_cnt = 1;
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		opp_cnt++;
-
-	if (enable) {
-		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg;
-		enum optc_dsc_mode optc_dsc_mode;
-
-		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
-		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
-		dsc_cfg.color_depth = stream->timing.display_color_depth;
-		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
-		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
-		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
-		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
-		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
-
-			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
-			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
-		}
-		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
-		dsc_cfg.pic_width *= opp_cnt;
-
-		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-
-		/* Enable DSC in encoder */
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)
-				&& !is_dp_128b_132b_signal(pipe_ctx)) {
-			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
-			dsc_optc_config_log(dsc, &dsc_optc_cfg);
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
-									optc_dsc_mode,
-									dsc_optc_cfg.bytes_per_pixel,
-									dsc_optc_cfg.slice_width);
-
-			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
-		}
-
-		/* Enable DSC in OPTC */
-		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
-		dsc_optc_config_log(dsc, &dsc_optc_cfg);
-		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
-							optc_dsc_mode,
-							dsc_optc_cfg.bytes_per_pixel,
-							dsc_optc_cfg.slice_width);
-	} else {
-		/* disable DSC in OPTC */
-		pipe_ctx->stream_res.tg->funcs->set_dsc_config(
-				pipe_ctx->stream_res.tg,
-				OPTC_DSC_DISABLED, 0, 0);
-
-		/* disable DSC in stream encoder */
-		if (dc_is_dp_signal(stream->signal)) {
-			if (is_dp_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.hpo_dp_stream_enc,
-										false,
-										NULL,
-										true);
-			else if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-							pipe_ctx->stream_res.stream_enc,
-							OPTC_DSC_DISABLED, 0, 0);
-					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-								pipe_ctx->stream_res.stream_enc, false, NULL, true);
-				}
-		}
-
-		/* disable DSC block */
-		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
-	}
-}
-
-bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	bool result = false;
-
-	if (!pipe_ctx->stream->timing.flags.DSC)
-		goto out;
-	if (!dsc)
-		goto out;
-
-	if (enable) {
-		{
-			dp_set_dsc_on_stream(pipe_ctx, true);
-			result = true;
-		}
-	} else {
-		dp_set_dsc_on_rx(pipe_ctx, false);
-		dp_set_dsc_on_stream(pipe_ctx, false);
-		result = true;
-	}
-out:
-	return result;
-}
-
-/*
- * For dynamic bpp change case, dsc is programmed with MASTER_UPDATE_LOCK enabled;
- * hence PPS info packet update need to use frame update instead of immediate update.
- * Added parameter immediate_update for this purpose.
- * The decision to use frame update is hard-coded in function dp_update_dsc_config(),
- * which is the only place where a "false" would be passed in for param immediate_update.
- *
- * immediate_update is only applicable when DSC is enabled.
- */
-bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update)
-{
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-
-	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
-		return false;
-
-	if (enable) {
-		struct dsc_config dsc_cfg;
-		uint8_t dsc_packed_pps[128];
-
-		memset(&dsc_cfg, 0, sizeof(dsc_cfg));
-		memset(dsc_packed_pps, 0, 128);
-
-		/* Enable DSC hw block */
-		dsc_cfg.pic_width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
-		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
-		dsc_cfg.color_depth = stream->timing.display_color_depth;
-		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
-		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
-
-		DC_LOG_DSC(" ");
-		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
-		if (dc_is_dp_signal(stream->signal)) {
-			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.stream_enc->id);
-			if (is_dp_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.hpo_dp_stream_enc,
-										true,
-										&dsc_packed_pps[0],
-										immediate_update);
-			else
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.stream_enc,
-										true,
-										&dsc_packed_pps[0],
-										immediate_update);
-		}
-	} else {
-		/* disable DSC PPS in stream encoder */
-		if (dc_is_dp_signal(stream->signal)) {
-			if (is_dp_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.hpo_dp_stream_enc,
-										false,
-										NULL,
-										true);
-			else
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-							pipe_ctx->stream_res.stream_enc, false, NULL, true);
-		}
-	}
-
-	return true;
-}
-
-
-bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx)
-{
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-
-	if (!pipe_ctx->stream->timing.flags.DSC)
-		return false;
-	if (!dsc)
-		return false;
-
-	dp_set_dsc_on_stream(pipe_ctx, true);
-	dp_set_dsc_pps_sdp(pipe_ctx, true, false);
-	return true;
-}
-
-#undef DC_LOGGER
-#define DC_LOGGER \
-	link->ctx->logger
+#include "link_enc_cfg.h"
+#include "dc_link_dp.h"
 
 static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 {
@@ -774,8 +145,10 @@ static bool can_use_dp_hpo_link_hwss(const struct dc_link *link,
 static void set_dp_hpo_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
-	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
-	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
+	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder =
+			pipe_ctx->stream_res.hpo_dp_stream_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder =
+			pipe_ctx->link_res.hpo_dp_link_enc;
 
 	hpo_dp_link_encoder->funcs->set_throttled_vcp_size(hpo_dp_link_encoder,
 			hpo_dp_stream_encoder->inst,
@@ -786,17 +159,21 @@ static void set_dp_hpo_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
 		const struct dc_link_settings *link_settings,
 		struct fixed31_32 throttled_vcp_size)
 {
-	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
+	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder =
+			pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	struct fixed31_32 h_blank_in_ms, time_slot_in_ms, mtp_cnt_per_h_blank;
-	uint32_t link_bw_in_kbps = dc_link_bandwidth_kbps(pipe_ctx->stream->link, link_settings);
+	uint32_t link_bw_in_kbps =
+			dc_link_bandwidth_kbps(pipe_ctx->stream->link, link_settings);
 	uint16_t hblank_min_symbol_width = 0;
 
 	if (link_bw_in_kbps > 0) {
-		h_blank_in_ms = dc_fixpt_div(dc_fixpt_from_int(timing->h_total-timing->h_addressable),
+		h_blank_in_ms = dc_fixpt_div(dc_fixpt_from_int(
+				timing->h_total - timing->h_addressable),
 				dc_fixpt_from_fraction(timing->pix_clk_100hz, 10));
 		time_slot_in_ms = dc_fixpt_from_fraction(32 * 4, link_bw_in_kbps);
-		mtp_cnt_per_h_blank = dc_fixpt_div(h_blank_in_ms, dc_fixpt_mul_int(time_slot_in_ms, 64));
+		mtp_cnt_per_h_blank = dc_fixpt_div(h_blank_in_ms,
+				dc_fixpt_mul_int(time_slot_in_ms, 64));
 		hblank_min_symbol_width = dc_fixpt_floor(
 				dc_fixpt_mul(mtp_cnt_per_h_blank, throttled_vcp_size));
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 6c02244e7fe7..e7ead9e25318 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -465,6 +465,8 @@ void dc_link_get_cur_link_res(const struct dc_link *link,
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
-
 void dc_link_dp_clear_rx_status(struct dc_link *link);
+struct gpio *get_hpd_gpio(struct dc_bios *dcb,
+		struct graphics_object_id link_id,
+		struct gpio_service *gpio_service);
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 013b94c41327..20a9cbb7c0a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -55,6 +55,7 @@
 #include "inc/link_dpcd.h"
 #include "dpcd_defs.h"
 #include "inc/link_enc_cfg.h"
+#include "link_hwss.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 67286950fe5a..477c4d9a972f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -218,4 +218,44 @@ bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 
 bool dp_retrieve_lttpr_cap(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link);
+void dp_receiver_power_ctrl(struct dc_link *link, bool on);
+void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
+void dp_enable_link_phy(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum signal_type signal,
+	enum clock_source_id clock_source,
+	const struct dc_link_settings *link_settings);
+void edp_add_delay_for_T9(struct dc_link *link);
+bool edp_receiver_ready_T9(struct dc_link *link);
+bool edp_receiver_ready_T7(struct dc_link *link);
+
+void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
+		enum signal_type signal);
+
+void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
+		enum signal_type signal);
+
+bool dp_set_hw_training_pattern(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum dc_dp_training_pattern pattern,
+		uint32_t offset);
+
+void dp_set_hw_lane_settings(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct link_training_settings *link_settings,
+		uint32_t offset);
+
+void dp_set_hw_test_pattern(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum dp_test_pattern test_pattern,
+		uint8_t *custom_pattern,
+		uint32_t custom_pattern_size);
+
+void dp_retrain_link_dp_test(struct dc_link *link,
+		struct dc_link_settings *link_setting,
+		bool skip_video_pattern);
 #endif /* __DC_LINK_DP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h b/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
index 3f12b1600d2a..d561f86d503c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
@@ -27,7 +27,7 @@
 #define __LINK_DPCD_H__
 #include <inc/core_status.h>
 #include <dc_link.h>
-#include <inc/link_hwss.h>
+#include <dc_link_dp.h>
 
 enum dc_status core_link_read_dpcd(
 		struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 3400e75685aa..43c6c0e0ddd9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -26,56 +26,18 @@
 #ifndef __DC_LINK_HWSS_H__
 #define __DC_LINK_HWSS_H__
 
-struct gpio *get_hpd_gpio(struct dc_bios *dcb,
-		struct graphics_object_id link_id,
-		struct gpio_service *gpio_service);
-
-void dp_enable_link_phy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum signal_type signal,
-	enum clock_source_id clock_source,
-	const struct dc_link_settings *link_settings);
-
-void dp_receiver_power_ctrl(struct dc_link *link, bool on);
-void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
-void edp_add_delay_for_T9(struct dc_link *link);
-bool edp_receiver_ready_T9(struct dc_link *link);
-bool edp_receiver_ready_T7(struct dc_link *link);
-
-void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal);
-
-void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal);
-
-bool dp_set_hw_training_pattern(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum dc_dp_training_pattern pattern,
-	uint32_t offset);
-
-void dp_set_hw_lane_settings(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	const struct link_training_settings *link_settings,
-	uint32_t offset);
-
-void dp_set_hw_test_pattern(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum dp_test_pattern test_pattern,
-	uint8_t *custom_pattern,
-	uint32_t custom_pattern_size);
-
-void dp_retrain_link_dp_test(struct dc_link *link,
-		struct dc_link_settings *link_setting,
-		bool skip_video_pattern);
-
+/* include basic type headers only */
+#include "os_types.h"
+#include "dc_dp_types.h"
+#include "signal_types.h"
+#include "grph_object_id.h"
+#include "fixed31_32.h"
+
+/* forward declare dc core types */
 struct dc_link;
 struct link_resource;
-struct fixed31_32;
 struct pipe_ctx;
+struct encoder_set_dp_phy_pattern_param;
 
 struct link_hwss_ext {
 	/* function pointers below require check for NULL at all time
-- 
2.34.1

