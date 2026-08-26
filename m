Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F97DC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE26710EE3D;
	Wed, 26 Aug 2026 23:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NyHSDMYG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AD310EE3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACNH+PxcKvxLHEb12pNgg0FLLXsvsLRsbhbxCJ7sHVftmG5Bjf79a4PHFxxQmSvxDKuUJOwc9phn5wNRYwofRQzZcSfhSP7mSHuIEcHaauSFfQCBnlDX/r0TZudjm8wcw/GxL0lo7Lc2jlLm/2+AVMdhJQEkbN8Z4KexTaqNzsWOpLd7VTFJynd68jbFq8I4Sf5AMXSolyhlxX/3gYyExLsWH40Xmrs01je0su6FVpPZv0nioSJoTGuxH3b+/esXtqIRicFOo63zBNsPJUXt3qmnGwubvkZEQA7/ya6PNWxfUTdo1II5CqhRAm3hdOs8baSWVTnpoK7IbpTf38cSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju5vMED5hfXA/udwT/RqWcVaBUmoqV/QTktAiOAXL4A=;
 b=e+fTceq85pzs1TodqYeN998IXOmJRSmmYLS4KlOZ8c700YZZ/DMt6wtvXy4nRK4lghu0Y5AUnz0DeNfY84JmkX2RJLB0s7JTxFJn7qKJusYvdQw5h93BGRklfj55dTlZ08dEaxD+FCFX3gscpyatWSxeaaUZjVyXwbOPqGI7W1JXvCUxqANxOPHlUGq78euWkacR1PdMclaqsao9uLR3d36+/PNqRxYh54zJerLkaSfmZrHwL8VivMF+plFRlb2rZZgmg5EMMCjfDrR2G2UuBIttrkJIX39Hx0KQ7DjWXDJ34VEZRGuftQlav6DKXpkHhnloVNGMdfLrSD9AgzTMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju5vMED5hfXA/udwT/RqWcVaBUmoqV/QTktAiOAXL4A=;
 b=NyHSDMYGnFarUXLjPuDgHMuZABDhW/KHHUmvZW+ewxh9e/A0u0Ai+2l8Ai36CC5a4O2ZZiaF8mw8UGPvfIz4pgYdt1esfd1nsfGgcFecHYxjerMTgOoPyEByT3itGhzbxp0poMzGPTTAAUrlzHz1wAsWmLwbNAUGNAviV5MYMow=
Received: from PH7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::10)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:21:03 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::5) by PH7P220CA0023.outlook.office365.com
 (2603:10b6:510:326::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:20:59 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:20:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Leon Huang
 <leon.huang1@amd.com>
Subject: [PATCH 15/59] drm/amd/display: Do not use panel_inst in pr
Date: Wed, 26 Aug 2026 17:04:46 -0600
Message-ID: <20260826231519.881949-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: e154169a-b359-4283-7df3-08df03c8b025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|10067099003|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oK6XlB8W0oontX0y8a3nbBjpVmBsVRVaW1LcajxAi4J+dHGqamoQr88cH2RdbzZGfQ43KkMV+qRTrsBQt1F712gQ9REfnz9tGD9zbXXEigOvioZm4mn6NBfbrtOWaYKUhs3oPZJCbzsOkyuzMtQZ5qLfcNzDh9jGx/j3mERpMUYR7Em/HdTmdxrJb71dRWF6MEV8zivAddLwohpzZJLIDO8+gU16jgB/juHj5y4MWnix67FM1XoA+j6EpSARUJ9xUEmGwLICjXJ7HQhEHRCfJIziFMiTRWi4ur3sBlvZsscFyQLOgsnNwcwEwuXWv+ZQ1dzjC0qp8wKq4xEZfAnNI7GVapcyQYD9Z3Kik+iMwJ8I9e6nMG120pDpiCHtZcg8d98BaiT/CKd8y0Ft91/qFI56QfyguVFJTKF5ir8nsDTF4JTX5XKEMZPhbo2/CKmjrSjBoP54tW+bDkXXTzJTaC/AdwrzZykWBzHfEH/ICOAi6XsktyWIRus4KG1gRxVh+atpmloi0BCk4JAS0nhVjGSPIu652xaSSQOVmbJl2915f42R/gcXGqW3MUPTagXOV3Is3Xx2QKdu430YUcqam2XS9su93rPUfB5q2nkAdBe9D+1wB3Rsmxhq41s4F4VW9rbH+VvDSR9l5AISdKUcxD6sq5O6BeYpV098nx84WOveZn/8cuprHf9FNvI9zX900mrBbyMh5iouSeFT2dtFQQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GkSvh/rsAsPgRpwpz2Vf1/eOdvPP0MuoQdLP+4tLGUT3JB5gilKuGVkMs7yNCAUwpTcpAcjN//DRLyiMh5rkPjBJMFSygVMMGqOLgv5AYAgxRQsmP05iL729vSgzh9f9j/z7Ssveqx+apkYozHvnO1ft/q2ERa+ClkQsHRbjR69pae7x+i073qTOVDzoYdb5qX/m8kJFJlSURtR5eBzm4xvsxmPXb5Yziw+tkNmF1CE3owA7BRH6prfirVtO+S8RTFPcjcCmbLnJFV1rGb3uLmeD5/Njqm70OH847SHsc3vMLQVTcl9gCNR8g+YaPMeSL2fenJV8gpfnRa0x8yJcrFLfQavajmOfw90fopCGTm32pV/+nutKu0nu97jntfMGKyQWF5/XUpcoed05gjWpbIvuI82duURCy0Shcsj2XZBBe3Je27x0YGSo31LyxgwZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:20:59.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e154169a-b359-4283-7df3-08df03c8b025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Panel Replay has different index definition from other
eDP features. So we should avoid using panel_index in
pr.

[HOW]
Rename the it to pr_panel_inst

Reviewed-by: Leon Huang <leon.huang1@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/link_service.h |  2 +-
 .../drm/amd/display/dc/link/link_factory.c    |  2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  | 36 +++++++--------
 .../dc/link/protocols/link_dp_panel_replay.h  |  2 +-
 .../link/protocols/link_edp_panel_control.c   | 44 +++++++++----------
 5 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index f87dfe63227d..eaf20ca14bcc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -309,7 +309,7 @@ struct link_service {
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
 	bool (*dp_setup_replay)(struct dc_link *link, const struct dc_stream_state *stream);
-	bool (*dp_pr_get_panel_inst)(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
+	bool (*dp_pr_get_pr_panel_inst)(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
 	bool (*dp_pr_enable)(struct dc_link *link, bool enable);
 	bool (*dp_pr_update_state)(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
 	bool (*dp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index a83693ea43c0..fa281de1d566 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -245,7 +245,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 static void construct_link_service_dp_panel_replay(struct link_service *link_srv)
 {
 	link_srv->dp_setup_replay = dp_setup_replay;
-	link_srv->dp_pr_get_panel_inst = dp_pr_get_panel_inst;
+	link_srv->dp_pr_get_pr_panel_inst = dp_pr_get_pr_panel_inst;
 	link_srv->dp_pr_enable = dp_pr_enable;
 	link_srv->dp_pr_update_state = dp_pr_update_state;
 	link_srv->dp_pr_set_general_cmd = dp_pr_set_general_cmd;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 0d4f88ff844d..65a791ccf6b2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -82,7 +82,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	struct dc *dc;
 	struct dmub_replay *replay;
 	int i;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 	struct replay_context replay_context = { 0 };
 	unsigned int lineTimeInNs = 0;
 
@@ -117,7 +117,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	if (!replay)
 		return false;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	replay_context.aux_inst = (enum channel_id) link_get_ddc_aux_inst(link);
@@ -202,7 +202,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 }
 
 
-bool dp_pr_get_panel_inst(const struct dc *dc,
+bool dp_pr_get_pr_panel_inst(const struct dc *dc,
 		const struct dc_link *link,
 		unsigned int *inst_out)
 {
@@ -246,10 +246,10 @@ bool dp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
 bool dp_pr_enable(struct dc_link *link, bool enable)
 {
 	struct dc *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
+	unsigned int pr_panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	if (link->replay_settings.replay_allow_active == enable)
@@ -264,7 +264,7 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 	cmd.pr_enable.header.type = DMUB_CMD__PR;
 	cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
 	cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
-	cmd.pr_enable.data.panel_inst = (uint8_t)panel_inst;
+	cmd.pr_enable.data.panel_inst = (uint8_t)pr_panel_inst;
 	cmd.pr_enable.data.enable = enable ? 1 : 0;
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
@@ -276,11 +276,11 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context)
 {
 	struct dc *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
+	unsigned int pr_panel_inst = 0;
 	union dmub_rb_cmd cmd;
 	struct pipe_ctx *pipe_ctx = NULL;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	for (unsigned int i = 0; i < MAX_PIPES; i++) {
@@ -301,7 +301,7 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 	cmd.pr_copy_settings.header.type = DMUB_CMD__PR;
 	cmd.pr_copy_settings.header.sub_type = DMUB_CMD__PR_COPY_SETTINGS;
 	cmd.pr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_pr_copy_settings_data);
-	cmd.pr_copy_settings.data.panel_inst = (uint8_t)panel_inst;
+	cmd.pr_copy_settings.data.panel_inst = (uint8_t)pr_panel_inst;
 	// HW inst
 	cmd.pr_copy_settings.data.aux_inst = replay_context->aux_inst;
 	cmd.pr_copy_settings.data.digbe_inst = replay_context->digbe_inst;
@@ -359,10 +359,10 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data)
 {
 	struct dc *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
+	unsigned int pr_panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -371,7 +371,7 @@ bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_da
 	cmd.pr_update_state.header.type = DMUB_CMD__PR;
 	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
 	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
-	cmd.pr_update_state.data.panel_inst = (uint8_t)panel_inst;
+	cmd.pr_update_state.data.panel_inst = (uint8_t)pr_panel_inst;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
@@ -380,10 +380,10 @@ bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_da
 bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
 {
 	struct dc *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
+	unsigned int pr_panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -392,7 +392,7 @@ bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_
 	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
 	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
 	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
-	cmd.pr_general_cmd.data.panel_inst = (uint8_t)panel_inst;
+	cmd.pr_general_cmd.data.panel_inst = (uint8_t)pr_panel_inst;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
@@ -401,16 +401,16 @@ bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_
 bool dp_pr_get_state(const struct dc_link *link, uint64_t *state)
 {
 	const struct dc *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
+	unsigned int pr_panel_inst = 0;
 	uint32_t retry_count = 0;
 	uint32_t replay_state = PR_STATE_INVALID;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	do {
 		// Send gpint command and wait for ack
-		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, (uint16_t)panel_inst,
+		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, (uint16_t)pr_panel_inst,
 					       &replay_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
 			// Return invalid state when GPINT times out
 			replay_state = PR_STATE_INVALID;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
index 5522d5911fd1..e669053e1a8f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
@@ -28,7 +28,7 @@
 #include "link_service.h"
 
 bool dp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream);
-bool dp_pr_get_panel_inst(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
+bool dp_pr_get_pr_panel_inst(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
 bool dp_pr_enable(struct dc_link *link, bool enable);
 bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context);
 bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5a8b480bb9dc..c7fc875c865d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -938,19 +938,19 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 
 	if (replay == NULL && force_static)
 		return false;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	/* Set power optimization flag */
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
 		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
 			replay->funcs->replay_set_power_opt) {
-			replay->funcs->replay_set_power_opt(replay, *power_opts, (uint8_t)panel_inst);
+			replay->funcs->replay_set_power_opt(replay, *power_opts, (uint8_t)pr_panel_inst);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 		}
 	}
@@ -960,7 +960,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 		// TODO: Handle mux change case if force_static is set
 		// If force_static is set, just change the replay_allow_active state directly
 		if (replay != NULL && link->replay_settings.replay_feature_enabled)
-			replay->funcs->replay_enable(replay, *allow_active, wait, (uint8_t)panel_inst);
+			replay->funcs->replay_enable(replay, *allow_active, wait, (uint8_t)pr_panel_inst);
 		link->replay_settings.replay_allow_active = *allow_active;
 	}
 
@@ -971,14 +971,14 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 	enum replay_state pr_state = REPLAY_STATE_0;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
-		replay->funcs->replay_get_state(replay, &pr_state, (uint8_t)panel_inst);
+		replay->funcs->replay_get_state(replay, &pr_state, (uint8_t)pr_panel_inst);
 	*state = pr_state;
 
 	return true;
@@ -991,7 +991,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	struct dc *dc;
 	struct dmub_replay *replay;
 	int i;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 	struct replay_context replay_context = { 0 };
 	unsigned int lineTimeInNs = 0;
 
@@ -1021,7 +1021,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	if (!replay)
 		return false;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	replay_context.aux_inst = link_get_ddc_aux_inst(link);
@@ -1049,7 +1049,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	replay_context.os_request_force_ffu = link->replay_settings.config.os_request_force_ffu;
 
 	link->replay_settings.replay_feature_enabled =
-			replay->funcs->replay_copy_settings(replay, link, &replay_context, (uint8_t)panel_inst);
+			replay->funcs->replay_copy_settings(replay, link, &replay_context, (uint8_t)pr_panel_inst);
 	if (link->replay_settings.replay_feature_enabled) {
 
 		replay_config.bits.FREESYNC_PANEL_REPLAY_MODE = 1;
@@ -1094,13 +1094,13 @@ bool edp_send_replay_cmd(struct dc_link *link,
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 
 	if (!replay)
 		return false;
 
-	if (dp_pr_get_panel_inst(dc, link, &panel_inst))
-		cmd_data->panel_inst = (uint8_t)panel_inst;
+	if (dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
+		cmd_data->panel_inst = (uint8_t)pr_panel_inst;
 	else {
 		DC_LOG_DC("%s(): get edp panel inst fail ", __func__);
 		return false;
@@ -1115,17 +1115,17 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uin
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 
 	if (!replay)
 		return false;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	if (coasting_vtotal && (link->replay_settings.coasting_vtotal != coasting_vtotal ||
 		link->replay_settings.frame_skip_number != frame_skip_number)) {
-		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, (uint8_t)panel_inst, frame_skip_number);
+		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, (uint8_t)pr_panel_inst, frame_skip_number);
 		link->replay_settings.coasting_vtotal = coasting_vtotal;
 		link->replay_settings.frame_skip_number = frame_skip_number;
 	}
@@ -1138,16 +1138,16 @@ bool edp_replay_residency(const struct dc_link *link,
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	if (!residency)
 		return false;
 
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
-		replay->funcs->replay_residency(replay, (uint8_t)panel_inst, residency, is_start, mode);
+		replay->funcs->replay_residency(replay, (uint8_t)pr_panel_inst, residency, is_start, mode);
 	else
 		*residency = 0;
 
@@ -1159,9 +1159,9 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
-	unsigned int panel_inst;
+	unsigned int pr_panel_inst;
 
-	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_pr_panel_inst(dc, link, &pr_panel_inst))
 		return false;
 
 	/* Only both power and coasting vtotal changed, this func could return true */
@@ -1172,7 +1172,7 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 		if (link->replay_settings.replay_feature_enabled &&
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal) {
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal(replay,
-				*power_opts, (uint8_t)panel_inst, coasting_vtotal, frame_skip_number);
+				*power_opts, (uint8_t)pr_panel_inst, coasting_vtotal, frame_skip_number);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 			link->replay_settings.coasting_vtotal = coasting_vtotal;
 			link->replay_settings.frame_skip_number = frame_skip_number;
-- 
2.43.0

