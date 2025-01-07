Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF0BE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3A910E1AE;
	Tue,  7 Jan 2025 15:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3e6Si2Y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AA810E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsL7+gyyh+YUotWRdbELph0IgSGTKEgbGmQD7FYilMk5pkL/ChlgQNdUfN6RMJI7A8yMbeYqEWFyosCTiwduVWhmg4JstHlRohUEmu9KNtySHiCXLEYVMSQqMwBXiifXhJ318YzfPHZDwpPFJWvosEMRGx2aH8V3wF+r/6aKP1XhBKgebXsJXp0+xDAnBwRcVTR+UPRMiBSVcjFv6VQ+bSfhFC3p4A21Br9CTVdpsIyIkWiulJN/S+91MVpQ+VnQ824UP91g/OGgN9F9roaqgww3cFbIMGx9/FBjPaa7+gZ6XmYzm9JsY4IY5Ydm5YXLApdjcP2kOxtAtrgD1O7zPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oovMY+XUedu9JLHDrdBJHrwagSkhSyFCUrGknYudeBg=;
 b=ahAiycxfySeMOn5+uzk5hR7wCF/ut0CQjPYrMij/n2Szu2oiezR7u/MzGUnlBbh5T6HkeU21v9A2S1aQ+Xsw37gwuK1e9iMcLO7hH2Vrk2p/WuawqZ0QWQRcSxsUMZH/Ck6s+qNZgKlffXRMtoVUKTr+V0iik4tfs9Ef9DpzHlu4/yta4auijKraae0sPSC4svCgP34IlTPhv1zkyxnti+dPIT9lf9tITvzWZNex2OmkkVHYfRZdIT4kkdMloKimKotpaiiE42gpO9C23zMjlrdicoBKRaCMdKBjhMLGzWkpcDsGNvN910QzOpI0O7DF9TR44JuhWoSbPUIXjskoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oovMY+XUedu9JLHDrdBJHrwagSkhSyFCUrGknYudeBg=;
 b=D3e6Si2YnU5ivP6jIPkLkNl4zVx5tW7QlYjK1+A/kuILbPA1LkcLRE421XrZggLLA+lbZLMt8wvJJMFY/dZd2QXxG07+VkE3Mu3SYFSrAsFxRwGZO39SKmz0ZF+1XmpmaKqab1gk/VN3/ZQ1mw0gNgWShq6Wgd38S5hlyjKJ6Xc=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:29:11 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::42) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Tue,
 7 Jan 2025 15:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:10 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:06 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Sung Lee
 <Sung.Lee@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 02/24] drm/amd/display: Log Hard Min Clocks and Phantom Pipe
 Status
Date: Tue, 7 Jan 2025 23:28:33 +0800
Message-ID: <20250107152855.2953302-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e331d8-f0e7-4f12-6454-08dd2f300919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iGDPUVx4EpYuJjZ288cRpbmvU4Pbf3V4ExmpcXOQOh/mFUeyh1u50L3KIb0b?=
 =?us-ascii?Q?lwzODF5WELEeKNAYp9N9RHNYashMRTARUS3CWnIkdn7WomBtZc0gGWXqvXU2?=
 =?us-ascii?Q?YQEpcJ02lbEghSI4/yiA/9y71xddXMA0t0vhpmohu6+6L8iFIWdI7K97NQei?=
 =?us-ascii?Q?1PGkC8DB2thOQymvE3PSYubHjKY6fjyGK9Z1tmbO5oaNHF09Viw4vHqe2LRr?=
 =?us-ascii?Q?iSPJ5m2dDg/mK9G3HyzYoYviXGeEHaDSXr9r5espbVg7NQXrocv6nKRrDlqB?=
 =?us-ascii?Q?NxxwiKOtoDYQm2aCudvcUWamWLQagG4vehi3jF+G0fZPb/3vR7wluLhgC/Xo?=
 =?us-ascii?Q?M9mqsp9X8ll57NXoNbmKCI4cw6x/e0jMU4ggmyHyLc7hRAxThWuNJU0QxyOY?=
 =?us-ascii?Q?a3FYzFREx1ytudcAq1aNjWHF2C98ipnXwfXgW2GdF89+tu8B9/WTUAkX14v7?=
 =?us-ascii?Q?u9QgePn42+8g1fM1mL3SZFXx/Dq1Sx8dd1MxHKNYVdLQdFvRtx27wNCmdOWf?=
 =?us-ascii?Q?BJWFlfIKb0ZeD77BTO6XTDA/0X8LRvoPhAZHvREEC6wZjVXd2ZsywaXCcRSI?=
 =?us-ascii?Q?ylGPevxOA4UH1Tw8fQEfGBhzYngNoZHusNUe5nKepeHojdWhyTt3ERZjZ2VX?=
 =?us-ascii?Q?3kMnSVFvSrQK3I+em1SZOwyxaT+BDQBloOyZQ36vh6qB7uF1RpAfSyOWg3Fa?=
 =?us-ascii?Q?ekQk73BSBA9G6NydykokyWZR8dbCJeik9V8Rpil+bHhvJoCE9EAhneeBRp00?=
 =?us-ascii?Q?ym2LstGfWLekpCEsx/NPJeyS4mN7GSy4dLGZ5N9jc1+YwFi8GZZxJ2/XiqBI?=
 =?us-ascii?Q?gy8ZpIW3gKvnekr62kHpkSQKIl6bM8PbCkBiH13UtLJDEo+VfMXcFvFqPmIH?=
 =?us-ascii?Q?mBHGABxG0a6/RR6BP6wwnM48xkQ74gnmK6880JDb+hur8/eteqC1tar8uAzD?=
 =?us-ascii?Q?2oD/WvICdt3kSx6y1kVzZ8xJXvCGQs6MDnRnnHNC7SvnDtuIRpT1dbgupU3L?=
 =?us-ascii?Q?TeJ+GE27NAYE+D5irgWx4+Pr7aF0393/694W7CnAYGNRkSVajAj7/++LsOIv?=
 =?us-ascii?Q?shRanG658xG2ll438QaT4leBboqT0d/EEBm7lqNImAzXcItdsF1+CgabyNes?=
 =?us-ascii?Q?G21nPoY1KndvmO5taKWID+DZCdF311x/vNQDJ8NoLR1nIPygZcp+guSETAQh?=
 =?us-ascii?Q?tvgEGRgMac2H+Q+H6MChPEYk9wuMDg+WX1F+YFJcYNl5mglUUIMn7SBpAU2D?=
 =?us-ascii?Q?M/7nXWxPJtF1sJSu+tAVe116iZ4Pxo12zJ48ns7gUg5iZ+rW+JIGaE3pqQqA?=
 =?us-ascii?Q?O3LuQ5IMSgjXi0Q1pF7oTkm6/blQzh5vz6Y6dxrxbKW7D/XU2caG1v4NxDtq?=
 =?us-ascii?Q?0C6TGa0e9ewPqrNctituKGgTE15V4ZQcjvnNFwBiC2rEiJgxpWPgiQc9a1M9?=
 =?us-ascii?Q?DoeHcFcqzRYqRvvdyGs4LIp4dA5PLAMcu7Q7yJg08D3mPpa/dZZHCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:11.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e331d8-f0e7-4f12-6454-08dd2f300919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

From: Sung Lee <Sung.Lee@amd.com>

[WHY]
On entering/exiting idle power, certain parameters would be
very useful to know for power profiling purposes.

[HOW]
This commit adds certain hard min clocks and pipe types
to log output on idle optimization enter/exit.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Sung Lee <Sung.Lee@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 16 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index e4360cd6b373..204ebdd99415 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1345,6 +1345,20 @@ static void dcn401_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool curren
 	dcn401_execute_block_sequence(clk_mgr_base,	num_steps);
 }
 
+static int dcn401_get_hard_min_memclk(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return clk_mgr->base.ctx->dc->current_state->bw_ctx.bw.dcn.clk.dramclk_khz;
+}
+
+static int dcn401_get_hard_min_fclk(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return clk_mgr->base.ctx->dc->current_state->bw_ctx.bw.dcn.clk.fclk_khz;
+}
+
 /* Get current memclk states, update bounding box */
 static void dcn401_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 {
@@ -1478,6 +1492,8 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.enable_pme_wa = dcn401_enable_pme_wa,
 		.is_smu_present = dcn401_is_smu_present,
 		.get_dispclk_from_dentist = dcn401_get_dispclk_from_dentist,
+		.get_hard_min_memclk = dcn401_get_hard_min_memclk,
+		.get_hard_min_fclk = dcn401_get_hard_min_fclk,
 };
 
 struct clk_mgr_internal *dcn401_clk_mgr_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 76c36374de67..cb6293d8ba77 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5507,6 +5507,11 @@ bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips)
 
 void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const *caller_name)
 {
+	int idle_fclk_khz = 0, idle_dramclk_khz = 0, i = 0;
+	enum mall_stream_type subvp_pipe_type[MAX_PIPES] = {0};
+	struct pipe_ctx *pipe = NULL;
+	struct dc_state *context = dc->current_state;
+
 	if (dc->debug.disable_idle_power_optimizations) {
 		DC_LOG_DEBUG("%s: disabled\n", __func__);
 		return;
@@ -5531,6 +5536,23 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 		dc->idle_optimizations_allowed = allow;
 		DC_LOG_DEBUG("%s: %s\n", __func__, allow ? "enabled" : "disabled");
 	}
+
+	// log idle clocks and sub vp pipe types at idle optimization time
+	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->get_hard_min_fclk)
+		idle_fclk_khz = dc->clk_mgr->funcs->get_hard_min_fclk(dc->clk_mgr);
+
+	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->get_hard_min_memclk)
+		idle_dramclk_khz = dc->clk_mgr->funcs->get_hard_min_memclk(dc->clk_mgr);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
+	}
+
+	DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
+			__func__, allow, idle_fclk_khz, idle_dramclk_khz, subvp_pipe_type[0], subvp_pipe_type[1], subvp_pipe_type[2],
+			subvp_pipe_type[3], subvp_pipe_type[4], subvp_pipe_type[5], caller_name);
+
 }
 
 void dc_exit_ips_for_hw_access_internal(struct dc *dc, const char *caller_name)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 2d06067ff36d..c14d64687a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -306,6 +306,9 @@ struct clk_mgr_funcs {
 	 */
 	void (*set_hard_min_memclk)(struct clk_mgr *clk_mgr, bool current_mode);
 
+	int (*get_hard_min_memclk)(struct clk_mgr *clk_mgr);
+	int (*get_hard_min_fclk)(struct clk_mgr *clk_mgr);
+
 	/* Send message to PMFW to set hard max memclk frequency to highest DPM */
 	void (*set_hard_max_memclk)(struct clk_mgr *clk_mgr);
 
-- 
2.34.1

