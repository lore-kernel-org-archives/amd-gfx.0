Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6604AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339F3604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 339F3604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0AF6EE81;
	Fri, 17 Sep 2021 19:26:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB2C6EE84
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3l9HH+B9R9BsvERsLZwarXzEZO0ID6xayDNEIKtLVeo2HH3hJeiEyzgf49/7NXIKiSHvtFt05wzKgd2bu3YRY0uBWGadP14l/hyqU6yAXYJFRQJSh5Hgik1TaXNl9/PH8gwfHPb1mwX8T9ryPfTiwbWds3Yutc1NtyUF1YMIkBWQiL2twJMnJgH81AQCPlw/GRmi6E5PP+hSkdwq14IaGg7o24F/S43mv+eenpdHQ7DjqHK8GbonV+7/oJYxAfpNaew6inn+TUXMquPWqJd2iPtxV75DrM5DgZpCXhhqtP+ClY1Je2PE8nwXARYSlzfi8r6NW2JUFKV25Qom85cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LVbu1hAomsG0K5+zMcIQjW7zX3KmHR3gI3b5v8m97E4=;
 b=HAXSdpApMAVfQF5xp7uTP4rXvF4EtegRbN6JP/MBmXqwMuEUQQ/z/SdyJGmuQYqdXxe6AihIgNQ6GrNy3SstK3VB7BtFURMvU2acS8dMzWgKqiBWGBKmVQXG4fp3hn2cojmjKPh7h3qce+oNeU6//B9CwUKy0BP5ZvSOklsvNyIFeagskGz0Vls9yh0sLqjUMKjMFyPfvYdrenYmmr2mO8yuTZtFQGqbnn85r1ZuofyqYEZfHrsOlBlgoliI0OdSwR8PQ/cmeu0E69o1C8Gx7bQ5f7MhrhbKRCwutSJ1ySloToAHHzEJ0I3CSStjbx7Tor3Z5nZAUw/4qCS06p7uAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVbu1hAomsG0K5+zMcIQjW7zX3KmHR3gI3b5v8m97E4=;
 b=jZZ9SroT3cSEue4F5dDkvb2KXwup2r0yTK4kvi72mHdbg1ITDBojmRab24wmKAVMIX3hlAjnXllm3CyM6hqsQy0FLjyE/xuAmIKzLp4anffHhUbjsKR+79bEaTSAx3WW72fYS4C4ialsurg42OjAO4JGxeUS+NH/zoST9CBUkSk=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:56 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::1d) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:55 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Nikola Cornij
 <nikola.cornij@amd.com>, Zhan Liu <zhan.liu@amd.com>
Subject: [PATCH 09/18] drm/amd/display: Use adjusted DCN301 watermarks
Date: Fri, 17 Sep 2021 15:25:15 -0400
Message-ID: <20210917192524.3020276-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b4c1b99-a194-4194-8a86-08d97a10f864
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR12MB166372BFCA2B7C2F3CB4BC3F98DD9@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knPwr9o/TawkP0IgWd/f27lSGVr5NGHcEn9f3MCcM37UC4u7CHsNhw1yLad8LnuCcvkDrKZebX7l94sOor1lJ1k2X0Lvz68mbQKyh6swhAg7iETLI6qlnltio0E16PZgYy+VbD8GcObv5g/LAuy9Yym5Ou1TUfnk182N1hELJzYaA79uFF/CW+a+Gz5BdVzBoI4O2APKPQGSR5E8kSdmPZepmcj/1+JLmX+KdkR/Y4NrtVF8q/5v0RWouREm1ngVTEJGouNInVn0AvST18P+4l9vcKSJlAWh/dbzRSJUZUpdW9q+QSCVTYIWC/mZrc/SOuS/nZ5weENTIEe37OYGZVtF/i7DqrEk5Rtiak921xpRkk0QargqHs0GYWh5ORp7nkEwYb3xzF4RiVGVhr9LGtE3830TRRtLRCdf1QmtOw4eXmFPstBSPeXyWi+R0tk+mcxnh+Pkr3UvW8cjBr16GUhmB1w+Eawcv8Z9Xs8oP4IYFhXceiXycbeWzCUi6qT8IH9c7ehxIUVUbuty9OnvxWKsCIKOyrpcj7EHobDwHs5lfL1S349t4aCEGGGqZhVCB6sAipIoOU8Vx9iWbx8hAT2nQK9YguQMqRCnRVcNjZ41N++n0j7GWBHPhEDC3soeDTxSXbujHJhgnd2B4XbyQGfCCWJzfk4EaIcgbztAJ9YWvR8jWDgCyxphRr/bBjZQBSxJ3TmZV5XrwbApAy4ZmlJGzu6eJXA8h+rOKheYzyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(82310400003)(8936002)(356005)(8676002)(81166007)(6916009)(54906003)(316002)(2906002)(83380400001)(36756003)(86362001)(82740400003)(47076005)(5660300002)(70586007)(36860700001)(70206006)(1076003)(2616005)(336012)(4326008)(6666004)(426003)(186003)(478600001)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:55.4600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4c1b99-a194-4194-8a86-08d97a10f864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
If DCN30 watermark calc is used for DCN301, the calculated values are
wrong due to the data structure mismatch between DCN30 and DCN301.
However, using the original DCN301 watermark values causes underflow.

[how]
- Add DCN21-style watermark calculations
- Adjust DCN301 watermark values to remove the underflow

Reviewed-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  4 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   | 96 ++++++++++++++++++-
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 7046da14bb2a..3eee32faa208 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -582,8 +582,8 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 5.32,
-			.sr_enter_plus_exit_time_us = 6.38,
+			.sr_exit_time_us = 7.95,
+			.sr_enter_plus_exit_time_us = 9,
 			.valid = true,
 		},
 		{
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 73b8fcb3c5c9..5350c93d7772 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1626,12 +1626,106 @@ static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 }
 
+static void calculate_wm_set_for_vlevel(
+		int vlevel,
+		struct wm_range_table_entry *table_entry,
+		struct dcn_watermarks *wm_set,
+		struct display_mode_lib *dml,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt)
+{
+	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
+
+	ASSERT(vlevel < dml->soc.num_states);
+	/* only pipe 0 is read for voltage and dcf/soc clocks */
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
+	pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
+
+	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
+	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
+	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
+
+	wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
+	wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
+	wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
+	wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
+	wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
+	dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
+
+}
+
+static void dcn301_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel_req)
+{
+	int i, pipe_idx;
+	int vlevel, vlevel_max;
+	struct wm_range_table_entry *table_entry;
+	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
+
+	ASSERT(bw_params);
+
+	vlevel_max = bw_params->clk_table.num_entries - 1;
+
+	/* WM Set D */
+	table_entry = &bw_params->wm_table.entries[WM_D];
+	if (table_entry->wm_type == WM_TYPE_RETRAINING)
+		vlevel = 0;
+	else
+		vlevel = vlevel_max;
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+	/* WM Set C */
+	table_entry = &bw_params->wm_table.entries[WM_C];
+	vlevel = min(max(vlevel_req, 2), vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+	/* WM Set B */
+	table_entry = &bw_params->wm_table.entries[WM_B];
+	vlevel = min(max(vlevel_req, 1), vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	/* WM Set A */
+	table_entry = &bw_params->wm_table.entries[WM_A];
+	vlevel = min(vlevel_req, vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
+		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+		if (dc->config.forced_clocks) {
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
+		}
+		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
+		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
+
+		pipe_idx++;
+	}
+
+	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+}
+
 static struct resource_funcs dcn301_res_pool_funcs = {
 	.destroy = dcn301_destroy_resource_pool,
 	.link_enc_create = dcn301_link_encoder_create,
 	.panel_cntl_create = dcn301_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
-	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+	.calculate_wm_and_dlg = dcn301_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
-- 
2.25.1

