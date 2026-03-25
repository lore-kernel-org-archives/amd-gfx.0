Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93EFFEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BDA10E79F;
	Wed, 25 Mar 2026 07:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eWd6GyjW";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F32D10E79F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMZqNmT+6CcC9NU8LAqUHut8+A5ywU5T+fkccQQK2sCbcMzbDcxpyYvjCSDhKaqK+E6kc9GBT5JzegZGpTR22O84G/kZ0T52jTXmhJkSnZtDdZsPpV2cjjCZhhRmZVdOmLexLJsXZ/O6CIj3dDyhkhQzSkZLkR4BbpuXcFAXMIf1/XEQ845qk9J2MlBjdNyqVTHDHM8rEuz71ZlAfdkzvaS/JiIsYmaXa1axlNudqUMm2x9BRHV2xxIS06PS6SKKX+iicPkoJdRfVQSWOb5YnSQrRPYJKy2B3OW2cqvVPrMzGoRhrUxDNNhdu/VOCmZdghbdeh2CCZqTwYE7WHrumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anr/t9LcWfJ7o3B/IqvAyWHXb7Xsp39WQgC50HzamLk=;
 b=mkTFEBetRLs8zsLOXlIqcSTvgpXh378fRot9GKtijcs3fX5YvNwTQ9QMKbFyeOhti5wG9L5vB/JvTf4GK8KVmbnR9yhO/7c+P997gZjE80cDorQt37C9adTWBwSkIfseyIyH+oJj3A15EQiLjlxF8VnomKWU2eW/iuG4cvputsxhfw30oe3f3RQtuIZYCQFMvGOqgktW6D7QaSoX5cT7mn22F5iXvNb57omW91cf3mQf+582/4vKdXB+7Ibd0urJyFlm0S2DvSHCMItU1LPifpDY/XC7JVCT5vrWlACs5vphqdwM2oFyWuzUMHrqPvN774K3zI33vXh7KzgbhkX/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anr/t9LcWfJ7o3B/IqvAyWHXb7Xsp39WQgC50HzamLk=;
 b=eWd6GyjWftUN0rimQh/HhvciwmdP/qbgDmfOuB3weLTxNzymOrJpnCfHIzJ9llC4pQTo7B9LUu2Az0g4v4KLhlHQQZP9ap1UNZMph5t7NHNO5srZaD+9R0NsHstChyzttKWNOXZ9v2X6OGq/TCSSmpI5K2ZvPEZdrUCXjwkJU2Y=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::83) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:25 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:20 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 13/29] drm/amd/display: Fixed silence signed/unsigned mismatch
 warnings
Date: Wed, 25 Mar 2026 15:06:19 +0800
Message-ID: <20260325071003.4022594-14-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: a43a6be1-ea08-4b3c-db21-08de8a3d72d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: g7SzqGuSUBnqVjcDUtiAo5UStq9d6PiugisW9Y2W7kSEW9Lou3TkqYzq731CCnvfLnLnZVfRbt3peBicPebL8yi8dkeqZ7OXq4LWcHUmv+16kPltgHSNFlGzI30RgaCGLVQsn5PlnSIXWg4wCcG41nP2z0npbPhOfuJLPFu21v3Ph8DUoG5vsv91tvNc9F4Jl24QtvK0xxiB3XrQcPHuO3sdVY6l9OiQ0hRc9VYPy7EjYs5n3rW4zbqiqci/kyl7pab8b2L5iG1TyBDZAONjojnOUznk5EYy063vjL+p2nUaEri+cIeOEDQXDEb9G6H1HgnOp1IZ2ThaS28P0C8Iylcwo1VGz2eyd8PDLFEz5vn8QLBDbxy7VdmjxLQ8yt7vzlGBZZlwxXgCyx7onyl/2Cm4iPhRKLWyTZJa71UJ+YwEOo1Qk6JorfDy0iqnyYPmH0iOfvZHu4lYvVUX9QgeBU215mBYz39q6wyh6xnuWsqOcSa+5JolHlRX41q89xtmT6Q8FvJw0WVHGNwyVacquQpWVvewGSbES8hS5UJdgOi61FPYQyfwhh/pnewhFfi+fyNcyllZTFQ06Brlay7KOFZ8ToWZIj4OXW4qqrN0zrlq+7jtwlW9/Fa9uVnf1flp1QfpTolFbpRaRK6GgdGtOaYSiF7vY1talx3VRZfpKNuKTWUKHYby0idJXik9fukRo47Zwqnl4D+F7xeLoM3yf3uJE0VgqCuNWVz6UZBtsaNdhhiqCFIjhIEmSORaZR6Y8Wpru1as3A57pM9yZup2SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C8Cfr3PfgYuFxLRZbioKMyZFLz/vNWjGlr6TtWFrJOuYs4L55foDzbtCcVtYlBj28oPe5XmuxlB+3FLgRymjRprT0FVFfamPU8UlytfRjG64qgRK7u4mbFknnEbf3QX6T6/2uaBq/uW32TW0wGn6kdETNBM1NuZ7gZTwzwD7UP09vXafMya/wwnTnahpm5184xR1p4bbPYuJ02NAInSnHZuBtWWDBVu2jLFjj6KYflGpY0zyk+zoSu8DEiI11jycLtyPsPyiPyyANlI9NGqbYJsSfSFMtdqlGHixNMdGXFcAgYcDps027U8kB1lBO8tBTrb6U5t10TAsq5SGFsYJZDNYvdciGMnh9PRm2DLYHgWSO82XVaHXH0Sx6MSKpDHMHW6pCL7L7yUHgykOC6oGvOgDVqdEnVHxeaby/pb1P91XBrO7i7IBTtPYRGRfu3d2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:25.6819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a6be1-ea08-4b3c-db21-08de8a3d72d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
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

From: Clay King <clayking@amd.com>

Fix compiler warnings by consistently use the same signedness for
a given value

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c                 | 9 +++------
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                      | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c            | 3 +--
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c    | 2 +-
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c  | 4 ++--
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c  | 4 ++--
 13 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index d2e2e8f29967..f1a639328ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -97,7 +97,7 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
-	int edp_num;
+	unsigned int edp_num;
 	unsigned int panel_inst;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
@@ -123,7 +123,7 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
-	int edp_num;
+	unsigned int edp_num;
 	unsigned int panel_inst;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d27666bbc7f..6ff1377c4dc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1563,8 +1563,7 @@ static void detect_edp_presence(struct dc *dc)
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
 	enum dc_connection_type type;
-	int i;
-	int edp_num;
+	unsigned int i, edp_num;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
 	if (!edp_num)
@@ -6264,8 +6263,7 @@ void dc_disable_accelerated_mode(struct dc *dc)
  */
 void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable)
 {
-	int i;
-	int edp_num;
+	unsigned int i, edp_num;
 	struct pipe_ctx *pipe = NULL;
 	struct dc_link *link = stream->sink->link;
 	struct dc_link *edp_links[MAX_NUM_EDP];
@@ -6319,8 +6317,7 @@ bool dc_abm_save_restore(
 		struct dc_stream_state *stream,
 		struct abm_save_restore *pData)
 {
-	int i;
-	int edp_num;
+	unsigned int i, edp_num;
 	struct pipe_ctx *pipe = NULL;
 	struct dc_link *link = stream->sink->link;
 	struct dc_link *edp_links[MAX_NUM_EDP];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 7bb4504889be..f4e99ca7918f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -46,7 +46,7 @@ struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 
 void dc_get_edp_links(const struct dc *dc,
 		struct dc_link **edp_links,
-		int *edp_num)
+		unsigned int *edp_num)
 {
 	int i;
 
@@ -68,7 +68,7 @@ bool dc_get_edp_link_panel_inst(const struct dc *dc,
 		unsigned int *inst_out)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
-	int edp_num, i;
+	unsigned int edp_num, i;
 
 	*inst_out = 0;
 	if (link->connector_signal != SIGNAL_TYPE_EDP)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 41b5dedb6eff..48b523fabbbe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2062,7 +2062,7 @@ bool dc_get_edp_link_panel_inst(const struct dc *dc,
 /* Return an array of link pointers to edp links. */
 void dc_get_edp_links(const struct dc *dc,
 		struct dc_link **edp_links,
-		int *edp_num);
+		unsigned int *edp_num);
 
 void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 				 bool powerOn);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 3b9011ef9b68..2764125d63b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -41,8 +41,7 @@ static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst
 {
 	struct dc_context *dc = abm->ctx;
 	struct dc_link *edp_links[MAX_NUM_EDP];
-	int i;
-	int edp_num;
+	unsigned int i, edp_num;
 	unsigned int ret = ABM_FEATURE_NO_SUPPORT;
 
 	dc_get_edp_links(dc->dc, edp_links, &edp_num);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index d0ffa99f1fe0..52673e2f504c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -82,7 +82,7 @@ bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct d
 
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
 		struct dc_link *edp_links[MAX_NUM_EDP];
-		int edp_num;
+		unsigned int edp_num;
 
 		dc_get_edp_links(dc, edp_links, &edp_num);
 		if (edp_num == 1)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e4bd6089026b..8f56f164d567 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1986,7 +1986,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct pipe_ctx *pipe_ctx = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
-	int edp_num;
+	unsigned int edp_num;
 	int edp_stream_num;
 	int i;
 	bool can_apply_edp_fast_boot = false;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index ffeec61824f5..29673a7b92ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1904,7 +1904,7 @@ void dcn10_power_down_on_boot(struct dc *dc)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
-	int edp_num;
+	unsigned int edp_num;
 	int i = 0;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index d04cfd403b7e..34d4519b3a17 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -645,7 +645,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	int i;
-	int edp_num;
+	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index e5d93dd348dd..ef08c98b11e9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -793,7 +793,7 @@ void dcn32_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	int i;
-	int edp_num;
+	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index b5f60f59382e..7c25911089b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -520,7 +520,7 @@ void dcn35_power_down_on_boot(struct dc *dc)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
-	int edp_num;
+	unsigned int edp_num;
 	int i = 0;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
@@ -921,7 +921,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
-	int edp_num = 0;
+	unsigned int edp_num = 0;
 	struct dc_link *edp_links[MAX_NUM_EDP] = { NULL };
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ca611b3c22d3..56d4c350d8c9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -140,7 +140,7 @@ void dcn401_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	int i;
-	int edp_num;
+	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	int current_dchub_ref_freq = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 7f9c121c00e6..ba1813eb3c6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -66,7 +66,7 @@ void dcn42_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	int i;
-	int edp_num;
+	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	bool dchub_ref_freq_changed;
@@ -1063,7 +1063,7 @@ void dcn42_power_down_on_boot(struct dc *dc)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
-	int edp_num;
+	unsigned int edp_num;
 	int i = 0;
 
 	dc_get_edp_links(dc, edp_links, &edp_num);
-- 
2.43.0

