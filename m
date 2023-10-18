Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C76CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F5010E450;
	Wed, 18 Oct 2023 17:44:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC87410E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApbVHIdIU2ExHCLs1AT+HKqN8OPZgUtDljn2XmBkAv8VKeJxEf1OY4KZZJN0BQriYf3aK53IEZsXVwRjc4T06aF0ojCAOHDy2Hy0Coc80jdZl1zlC2bWmx9jsnSMAISCZOJ+7W97YxLP9zwHjg6XiW1R8CrTp/R+WHBiXEkgAABnJZ9Us3s5DIE/jWCIpLVOu10GIxMUEhDD2m+d3ndMYUZFbqrYnnDasB3mf5bCV8D6hUKqgjMlF33EkhPWnquxQewoi42iQuGOFYJR0UNZeblIZN2VcBC/2NNefCg3JAZwAZIhwP2FgNuAuzPSgAP+W4rsQeMjZCPFYcA60ubqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu+BZHry+AxR+QBcYhVfbp7h+Fd62ENvnlhG8Pt9iNg=;
 b=TGUfnWm06cAnRcISFgdpuY2FqbuiLNAZK2LZnmybXt96oXreTjfeUEp4iJN/oxbSIYdNZnHE3tyZDBLkrQ6L9VfTpTfm4JFv4mfx6+/b+jmf5GpxWPIzvsy7bPRrK3f1wjPreX05O+Y8Z7XsPYVI+VbvQ1SJZ+tD3cbKcp1AA4ogfFtlxb/GqXzXiEzvC+5Yo/cFSqUCV68n9fQjI3bR6MJIipql0NdGmWye7uQl6LvtMRYdSGv6wmTaoRV5xBfQSWZ7kZYOzL8hBIDZG9vrd+kIajwzyrBYRX5+Nz95hXaXnzpD0sS5FIY569T+YudmT1vdF9ylcsoGyitmnhnAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu+BZHry+AxR+QBcYhVfbp7h+Fd62ENvnlhG8Pt9iNg=;
 b=gppDzgt/cqAnSiQiUpwaHdIp5LRQeBgKA7A18a8GUk1cEkcbUCEUQ/5SeMHP9Y6Tr5U6o1DNXidOqKOiKjdrEPxKVj2WWTk89Q7Hy2MMW6tpvZMyCV8eFqvBptFz+hFJEOO6aLy/MWtV4CcktOuLMOkYqhfpHXgFytWpUZxvMa4=
Received: from DM6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:5:174::15)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Wed, 18 Oct
 2023 17:43:59 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::e5) by DM6PR21CA0005.outlook.office365.com
 (2603:10b6:5:174::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3 via Frontend
 Transport; Wed, 18 Oct 2023 17:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:43:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:43:08 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/26] drm/amd/display: Update FAMS sequence for DCN30 & DCN32
Date: Wed, 18 Oct 2023 13:41:26 -0400
Message-ID: <20231018174133.1613439-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: c02cc6eb-0b33-4564-32c1-08dbd001cf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etEUrT10kS6YNVzjRHr41M0BiIkr4jWGtT+Jy/eo6bd9OQqTuXhgMEs8Zkax+1iEo14EBnGIOCZd/ZEZ1j2YRKcVBs6Vcktc97pZmtVxU2x+XGMi8hCedMAuOaawwoQW38+AGWv65J1LQKwvadYsJgT95Bszp/ku5FtCHNsnlqq6wBnyYwLHTdgM3w4QyyJLvVyCkUlmZPdK+b+PMrdK8ttGEzV4eggnhRk5V4XEpSMhyyjQrBpyu+KBt1q2wRa7NB4Ww3fkv9ln59xDHgH/Tu1tRG9Wu9sODfYT3vFiUcy1RccKx8ggPewcit7xGy+NSHXiQNO3UWmMEmOvie+ntE+PvIS+cPCjfPAgxkGG0osy3WwR0ur+et7+tKSOe4jYSTGu129L5ReKr/eI76dqR5f4sWr4rNROc+JwnUrnC+D8Kz8Ki2seeWGN77LUhLieQK8w/B5hSmNIvT2SAYCpZ7MXVaWpLJIqTwJw5+Mu3MYAqkmadbx2BI8xPcRaH4DJ6FbPgVNuQaHtq4pNAWM8J3fe/gsAloHNErdxJpq0wwp3vnJp5ABCrqG1U9oSFBqsmPshakqDbKlaDH4gFQ7psgeElpnQTzEV0bZxhkcJptwYT2cymdGQ1rbeAhGwmK8dIZud2U7bTxFUXif+iGSUGMidfPTvFog15IU7+f6Ha+dnEEHbP6X1X/6hP+H5ezZNkZhyewTGO6pFoQAkD8vWsFLXrp/PjCnwlGLKji27m9fzQpJauK82s+1QYx/fOOyVevyllfQ+fuOyGGGbAza/Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(2876002)(47076005)(15650500001)(36860700001)(40460700003)(6666004)(7696005)(83380400001)(70206006)(70586007)(40480700001)(54906003)(6916009)(316002)(2906002)(41300700001)(8676002)(8936002)(4326008)(26005)(356005)(81166007)(82740400003)(478600001)(86362001)(5660300002)(336012)(36756003)(2616005)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:59.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02cc6eb-0b33-4564-32c1-08dbd001cf57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Provide DCN32 specific sequence and update DCN30 sequence

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 21 ++-----------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 31 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  3 ++
 4 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 90f061edb64c..427cfc8c24a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -60,7 +60,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
-	.prepare_bandwidth = dcn30_prepare_bandwidth,
+	.prepare_bandwidth = dcn32_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 9247a8ed5570..fd8a8c10a201 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -997,11 +997,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context)
 {
-	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
-	/* Any transition into an FPO config should disable MCLK switching first to avoid
-	 * driver and FW P-State synchronization issues.
-	 */
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !dc->clk_mgr->clks.fw_based_mclk_switching) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -1012,20 +1008,9 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-	/*
-	 * enabled -> enabled: do not disable
-	 * enabled -> disabled: disable
-	 * disabled -> enabled: don't care
-	 * disabled -> disabled: don't care
-	 */
-	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
-		dc_dmub_srv_p_state_delegate(dc, false, context);
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
-		/* After disabling P-State, restore the original value to ensure we get the correct P-State
-		 * on the next optimize. */
-		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
-	}
+	if (!dc->clk_mgr->clks.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
 void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 2173d84e4953..e837554b8a28 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -50,6 +50,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn32/dcn32_resource.h"
 #include "link.h"
+#include "../dcn20/dcn20_hwseq.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1677,3 +1678,33 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 
 	return is_seamless;
 }
+
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context)
+{
+	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	/* Any transition into an FPO config should disable MCLK switching first to avoid
+	 * driver and FW P-State synchronization issues.
+	 */
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+
+	dcn20_prepare_bandwidth(dc, context);
+
+	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
+
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		/* After disabling P-State, restore the original value to ensure we get the correct P-State
+		 * on the next optimize.
+		 */
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 9992e40acd21..cecf7f0f5671 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -124,4 +124,7 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx);
 
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context);
+
 #endif /* __DC_HWSS_DCN32_H__ */
-- 
2.34.1

