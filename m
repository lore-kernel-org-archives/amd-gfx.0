Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1603109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECE310E933;
	Thu, 26 Mar 2026 03:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ij/1n33Y";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D85610E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuJp91juGojAsxpytr8cl3ZV4n+yCAxMMF2kb5eAO7LH9pX9nGcz9v+JARFOrLGWkXh+raGhrTjh61s4ow5slisGJuGP5mP/7Dy6gn/9oR8nzbaVPK/7f/bbkyBHKVmdmb6J12K+HSmGAEfVCqpEGWLlnXtE+6Xmq2hXY4mUhaM5FCgabTTpNEoKzXlN2yXHafPHVIkkmA2FQI8eUt/sqXrxHaUljFNDpFRQTFBRBD4Fnk9PNy9pMT2+ile8/I76h/WSDl/T05NMJ6PuHD46pkGn4JO8PwZOOIVOskuy9JVVIE9s1xMHQLtuwzTU6LPiITEYCi7L4IW5o2Ocoo7FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anr/t9LcWfJ7o3B/IqvAyWHXb7Xsp39WQgC50HzamLk=;
 b=EG+EAysUFNgU8Ax+cjlmS3p10lNRAiuDA5t1TBJ8gmpiodhL7bKjI7i0s+Co0MLI1b2kq8mkztYLMelRBhj5leRq33iiiDTsuTtWwveJFP05R+thMgrznMbR2FWs42EjCCjIA1OgoOQn3zR68KG+4Jm/e/Hgj6lGnhw5/O8CJTDoIYZ7zKQAiZHs2ipKO4Vdf77iQBYgAH+M4K3eaulF9FPwTg31jVWZclpNz94QAR83sThw2h6+sKp03x2WUCmmlxoMFdKBCKz+huIt9bl2U5wQf9GG2GIllK32LLUTMGXMs0CF3vVIN3SGal9+uLGxQAZhUUxnlVxNEPfyZZZZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anr/t9LcWfJ7o3B/IqvAyWHXb7Xsp39WQgC50HzamLk=;
 b=ij/1n33Yw9UQ9bJ2/t17ehdq2vOFfQ/UXWj6F8Q/oHZcUsDNXd12ToyOkVtCY/bYpBT7oNnHQN0SFnFMw3fu5sYnOSQAwMJcm4qf1vOE9kBEGWTLaL8EHJKlVAwycG4B7zWo5+pfviQpkO8bVzf0awMTug3q5+zeHV940+Dkq00=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:23 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::42) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:22 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:18 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 14/30] drm/amd/display: Fixed silence signed/unsigned
 mismatch warnings
Date: Thu, 26 Mar 2026 10:57:05 +0800
Message-ID: <20260326030153.406612-15-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fa2f6e-b067-4c01-a5e9-08de8ae3f669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nqTJ65gbkJ7qMrBbCEoFYhLB37C4N4f5uB4UVOKQR9cZUuxCVuQay1pEd4xkKrTCKv/kg3Z8CyEqagiNAc6BpIwHQHAgLy2Ol2AkiJystwnLPdQ6GM839xebp6Pr3j5ccqBLHMgV8RHW9VH4SOO0Iofd2Pj4JB7FM6t7VByDAS/5/VUUdzwbd4rq+g/UXde40Tvm2R4LKe7zAcBZZjY8qBy4py9l+k4nSXK8EGW3CTt+JBH4OEIuPuux98a2ITaoE8Okf8oGH86idyfhLF1+6g1EFL1PLXBuZ6ET22Kwm5/ETKcGtKzkGed5qKlhPZjazOW52KnP+HnjWzQze4ol+ebQN0cfOh3g87K2m7xg1Euz57VauuAiZxG1ETCXRV4wGYryIN2PGbqgwBAFZAaYdvnho/NXFNoq1myleLSAoP8LA94F/HJelvq999/XXoVyDak5MgCWfefL56PpJp7XJolMERA5fk8gOrMe0CSqotRK9jxshIIfNDBwGsgA/D8ejRPVzvESZJA8M2iMuJ52aGfeMb9RGqEDPgyPh+qbAXPHYNacFFWZ3j2LOC1FFDI5nFV+gsBgDy8yfRpgkXrBSzXjc2RJLco9jxaYrj8yq7NQOKZ1JvBM9ylIlYwJWqu/JmtawXZOOxIFMbC2ij7Z55E6gQX+Q47US7uGHBD83XP4NNlR/7nsfZhsUKhhLc7w0vtwYguXyPfqIlqGGy1sA26D3HDIoDJLnQG7dpAkn7GxZvZttj81jIaInlR9gtPz3KFbgzi0mFld/Q9EEZKvfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GqsPJlvcCQXT4uH6usY6pB66nHwo6skIAIoNP674HfDfQxSOFhY6f1ZYs9CwMeFlbf+ukYmtJF4+5RIA09LeShz/XzIn0TG/jE9J+5ckkIp93azJC4y3UDub9Qscq220lRxtOFbI/Qfs8W4YtB6UyDYSFfcOc5KAOOzRzvs0hs/KAolIxRa955/ztypPhKRe1ldkvYjZTaJLY1S3dWIgbmPJ6RhhMM6P80MukFXGOBYoKt4BoEB0Y0gttwbc/f9seZQNK/bfsqG5PBiASyyom0jPlElYC6/kbOQnNi6X35oFDG43vsk7QGQSnJzA47OFT07q6V1sXZnlr1PgSVLRMloB0147RwAA2upvPQz62PaaLKPwOMl2tuC0H+pZtzcR1g2OM05cHPo7D7mv/LHpbiZDOMTY9X4wYL9IdMwH+dxhAE4YMZERGJ8Mc6lM+ZaZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:22.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fa2f6e-b067-4c01-a5e9-08de8ae3f669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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

