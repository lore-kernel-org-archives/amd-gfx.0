Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5747CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F1710ECD8;
	Wed,  6 May 2026 07:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="115u0VkK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB3B10ECD8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulYW1ChmFnRH2HAm8sD0aoDVGqn7Db9zvlcGsc+XGpgwydNE0fgQY8NvrsCwiPgQmBLrIQyUhJFtc6FQ9OW3UvctU34ciFojLJfE8ehTAFu1WsWI9v9tFeHPXy6mJFbid7fZpYAurxIu83lfBTchKMIQpULwE793Uxg2hihBwkBA2cNy7+sz2lrdWoR3skaawjsjGzfn3Vjn4EpMPt/E+CMxeWQw4B1zztpFZM1r9I6ftfubBRWMVDS8Du85peIB9Ya8J5eUvhtRYT/LRM950IlcInBP5x51vyZvrUCVISvI0Is82nB00a4R0G7zMDyotzHpDnitPp76fF8zhT5TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olZ/syZBaojwoGc04MxP1zexiaB5y+grY7dnEIr59d4=;
 b=PBgxH0Sx3E2+AcTQ7CgwvUmpZc+z0XkI9pYhZxDjNDKn65vEVCanFJCIhsdbm2CWdy7gb9iHQ5yKr2+b7bourIDGVc5QQByZgNdAcw1CHTaPQFqpuaNTzXwZDBDu0jHZBWaTmEfsFyrGWAZyRi9qb9VT+erDkuTnKW4mQvrYsgVnS1iDYW8VZ4iiwgdjgjZkDzlrPGvcspvwsMHUCWUuxbFILezkxMjn2mEU0MSTWvTyCDlSIvdoWPTfysbwu2KCQMiEPvrQjY9d6JUo+Nh7WV8hUd8jEOj+IXEWMPpO+fkTx1fQ4D8vmQSxdFABGA4ucZ6aYUaTEfwY6oXarMyeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olZ/syZBaojwoGc04MxP1zexiaB5y+grY7dnEIr59d4=;
 b=115u0VkKytkPA8SFY1SJ++7o1/gmlRs+mtN9s+hOOgTyy0b3l0H1DOstvtt8SzJ+VqpztuWLXXrdbc05fIUHIT7PfE2NaQPIWiIz/PzuxVxr+q8dboWYlO531qFS1saS5jSK/f7jNbCsoCkJKoi6a+yOgMKYDNalJPf9q3mVPT8=
Received: from CYXPR02CA0030.namprd02.prod.outlook.com (2603:10b6:930:cc::19)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 07:03:38 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::5e) by CYXPR02CA0030.outlook.office365.com
 (2603:10b6:930:cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:34 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:03:25 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 04/20] drm/amd/display: Fix signed/unsigned comparison
 mismatches
Date: Wed, 6 May 2026 12:31:02 +0800
Message-ID: <20260506043342.2164710-5-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 488e5e48-0dda-47fc-0c19-08deab3d9905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003|20052099010;
X-Microsoft-Antispam-Message-Info: tzB5GBD8DggxWo5aBW6cznGCu1qPRiRhbJelg9YT/CZ0URhqMiIwOgPFhvZHrJpWNiOUfLLifqOkLobwBl6LYeSsGMUtnnqNkc9zTS5AF5yfEf7TVdHO/5R/Gy9ACxGdGGFFSEszmvwGmNbMQguyNh/4BUEum5kS+MmvH6oHHfKioYJhnv9PBNHntI6T0xMvn/WoBqPQYTyAUIWN0IUGffbTzx+FHbtes7DGS4TkkVz0C80Zr1qt6xiq+xz8DNAJQIFSBUV4jnespk9feWKqpE2bsCEAfbOd3ibHSqiKnDQqhv1AvsNm0P+/rkgdxttssnf0Fv5QDtdftyVlWjraidp+o03pGTZKsBxmscZ1FXjjWfzw01lb7tcCpeUTLlfhj51lqpsSvDofi89bfUxOTpKQDO9qhSUdcp0o/khYOBdr0gxQ/VObRFSK8lMgHR2x6BVeoHLV/dfKSPM1beMQgrFFZtNIqOdx1MCfmkvc5CT2Ph6X67mdqc0YcR9cvM69PT4kjSlPHZj8geptPgADjd3+Oxa9J8tg24/LWn0kLVxLLHfTwJ7z4nj2TLx/VT5y8MbGrgINQgnvhXO4sagod2qDJhwDdZtmFlvEIgk81YfbvzIfx8NVhWWHatKKTVxHwXJcZR7GgQNbiNpaE5sfufjRdfJzaG1YANYUj2mE+CXp9xm2dTAzp4yNav40D+BWq/xm4SSnDO6q3roKhwTiL5dEZWEoziieB3SySL55ob8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XkiJeOhyXsYgoLci6d/jRFsEpS3YaEX3exEiuwzj5Vsbzt6Wg9TzAjcCx65jgHuwYCN14coK6smn9Or2u/FUhDFC9Xz8DzYFnGZ+Bj1mG8c5SHFmeJTi9sCzTTaJ4Q+QkXoKR8gr5VW06m2Fj/sr1wYwdxb2WKX636/beTr62Bzxq6dh+xZ87TCT0QNVLSObKrDyoiUSYH3L8j9QY17tBCrMIn6UuZ9n+XqF4CLwxwYzOOk7X+fKjVeLy6z+EtgoOvXSKZMHF852FHolL/5/a6dZ8KwCnHkVKnTSA0ixZdAQg1j7sqG1AX81LgqPl1l9gu/cDH1NRRethlO5yzcWPkDqQ8ICaOLLzkXm6ieqbFQXBAof+AoE5/hqeNEenqmMU5eGF7ol7tT+nKIPzxqCM2biFIcGiwxBgFhrtaBni+2H0xFIHqBGvjt5L/Nq0+2o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:38.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488e5e48-0dda-47fc-0c19-08deab3d9905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Address signed/unsigned comparison warnings in DC paths
to keep builds warning-clean and improve type safety at comparison boundaries.
Most warnings came from signed loop/index temporaries compared against unsigned
counters (for example pipe_count, num_states, and resource-cap counters), plus a
small number of mixed signed/unsigned checks in writeback and clock-related assertions.

[How]
Aligned iterator and temporary variable types with the semantic type of the compared
bounds. Used unsigned indices for loops bounded by unsigned counters, and retained signed
types where values are semantically signed (for example arithmetic with sentinel or signed
intermediate values). Where mixed signed/unsigned comparisons are intentional, applied
explicit boundary casts or split assertions (for example non-negative signed-cap
checks before unsigned comparisons) instead of broad type changes.

No functional behavior changes are intended; this is a warning-resolution and
type-alignment cleanup.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  8 ++-
 .../dc/resource/dce100/dce100_resource.c      | 10 +--
 .../dc/resource/dce110/dce110_resource.c      |  8 +--
 .../dc/resource/dce112/dce112_resource.c      |  4 +-
 .../dc/resource/dce120/dce120_resource.c      |  6 +-
 .../dc/resource/dce80/dce80_resource.c        |  8 +--
 .../dc/resource/dcn10/dcn10_resource.c        | 15 ++---
 .../dc/resource/dcn20/dcn20_resource.c        | 60 +++++++++---------
 .../dc/resource/dcn21/dcn21_resource.c        | 26 ++++----
 .../dc/resource/dcn30/dcn30_resource.c        | 63 ++++++++++---------
 .../dc/resource/dcn301/dcn301_resource.c      | 31 ++++-----
 .../dc/resource/dcn302/dcn302_resource.c      | 22 +++----
 .../dc/resource/dcn303/dcn303_resource.c      | 22 +++----
 .../dc/resource/dcn31/dcn31_resource.c        | 30 ++++-----
 .../dc/resource/dcn314/dcn314_resource.c      | 26 ++++----
 .../dc/resource/dcn315/dcn315_resource.c      | 37 +++++------
 .../dc/resource/dcn316/dcn316_resource.c      | 29 ++++-----
 .../dc/resource/dcn32/dcn32_resource.c        | 25 ++++----
 .../resource/dcn32/dcn32_resource_helpers.c   |  6 +-
 .../dc/resource/dcn321/dcn321_resource.c      | 22 +++----
 .../dc/resource/dcn35/dcn35_resource.c        | 26 ++++----
 .../dc/resource/dcn351/dcn351_resource.c      | 26 ++++----
 .../dc/resource/dcn36/dcn36_resource.c        | 26 ++++----
 .../dc/resource/dcn401/dcn401_resource.c      | 32 +++++-----
 .../dc/resource/dcn42/dcn42_resource.c        | 40 ++++++------
 28 files changed, 317 insertions(+), 301 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 09868145d2de..1e178becf949 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3845,7 +3845,7 @@ static void program_cursor_attributes_sequence(
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
-	for (k = 0; k < dc->res_pool->pipe_count; k++) {
+	for (k = 0; k < (int)dc->res_pool->pipe_count; k++) {
 		struct pipe_ctx *tmp_pipe = &context->res_ctx.pipe_ctx[k];
 
 		if (tmp_pipe->stream != stream)
@@ -3893,7 +3893,7 @@ static void program_cursor_position_sequence(
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
-	for (k = 0; k < dc->res_pool->pipe_count; k++) {
+	for (k = 0; k < (int)dc->res_pool->pipe_count; k++) {
 		struct pipe_ctx *tmp_pipe = &context->res_ctx.pipe_ctx[k];
 
 		if (tmp_pipe->stream != stream ||
@@ -4083,7 +4083,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 	*num_steps = 0; // Initialize to 0
 
 	// Stream updates
-	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+	for (j = 0; j < (int)dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
 		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_ctx->stream == stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index fac5a50fefb2..71710d96ffe3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2217,7 +2217,7 @@ static void calculate_wm_set_for_vlevel(int vlevel,
 {
 	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
 
-	ASSERT(vlevel < dml->soc.num_states);
+	ASSERT(vlevel < (int)dml->soc.num_states);
 	/* only pipe 0 is read for voltage and dcf/soc clocks */
 	pipes[0].clks_cfg.voltage = vlevel;
 	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 81ef95f51d05..c4b73acd7140 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -298,7 +298,7 @@ static void calculate_wm_set_for_vlevel(int vlevel,
 {
 	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
 
-	ASSERT(vlevel < dml->soc.num_states);
+	ASSERT(vlevel < (int)dml->soc.num_states);
 	/* only pipe 0 is read for voltage and dcf/soc clocks */
 	pipes[0].clks_cfg.voltage = vlevel;
 	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index a2c8d4b21ac3..3c70d685ba65 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -262,7 +262,7 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool result = false;
-	int acquired_rmu = 0;
+	uint32_t acquired_rmu = 0;
 	int mpcc_id_projected = 0;
 
 	const struct pwl_params *shaper_lut = NULL;
@@ -439,7 +439,7 @@ static void dcn30_set_writeback(
 	ASSERT(wb_info->dwb_pipe_inst < MAX_DWB_PIPES);
 	ASSERT(wb_info->wb_enabled);
 	ASSERT(wb_info->mpcc_inst >= 0);
-	ASSERT(wb_info->mpcc_inst < dc->res_pool->mpcc_count);
+	ASSERT(wb_info->mpcc_inst < (int)dc->res_pool->mpcc_count);
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 	mcif_buf_params = &wb_info->mcif_buf_params;
 
@@ -593,7 +593,9 @@ void dcn30_program_all_writeback_pipes_in_tree(
 	}
 	ASSERT(stream_status);
 
-	ASSERT(stream->num_wb_info <= dc->res_pool->res_cap->num_dwb);
+	// Assert non-negative signed capacity first.
+	ASSERT(dc->res_pool->res_cap->num_dwb >= 0);
+	ASSERT(stream->num_wb_info <= (unsigned int)dc->res_pool->res_cap->num_dwb);
 	/* For each writeback pipe */
 	for (i_wb = 0; i_wb < stream->num_wb_info; i_wb++) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 48e48363eb89..28055e571445 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -805,7 +805,7 @@ static void dce100_resource_destruct(struct dce110_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -870,7 +870,7 @@ enum dc_status dce100_validate_bandwidth(
 	enum dc_validate_mode validate_mode)
 {
 	(void)validate_mode;
-	int i;
+	unsigned int i;
 	bool at_least_one_pipe = false;
 	struct dc_stream_state *stream = NULL;
 	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
@@ -979,7 +979,7 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
-	int i;
+	unsigned int i;
 	int j = -1;
 	struct dc_link *link = stream->link;
 	enum engine_id preferred_engine = link->link_enc->preferred_engine;
@@ -996,7 +996,7 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 			/* Store first available for MST second display
 			 * in daisy chain use case
 			 */
-			j = i;
+			j = (int)i;
 			if (pool->stream_enc[i]->id == preferred_engine)
 				return pool->stream_enc[i];
 		}
@@ -1176,7 +1176,7 @@ static bool dce100_resource_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce100_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 0138868e198b..060af765c7ed 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -840,7 +840,7 @@ static void dce110_resource_destruct(struct dce110_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1214,7 +1214,7 @@ struct stream_encoder *dce110_find_first_free_match_stream_enc_for_link(
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
-	int i;
+	unsigned int i;
 	int j = -1;
 	struct dc_link *link = stream->link;
 
@@ -1224,7 +1224,7 @@ struct stream_encoder *dce110_find_first_free_match_stream_enc_for_link(
 			/* Store first available for MST second display
 			 * in daisy chain use case
 			 */
-			j = i;
+			j = (int)i;
 			if (pool->stream_enc[i]->id ==
 					link->link_enc->preferred_engine)
 				return pool->stream_enc[i];
@@ -1497,7 +1497,7 @@ static bool dce110_resource_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce110_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 1dd5e44a0d6e..ad0214d99a45 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -805,7 +805,7 @@ static void dce112_resource_destruct(struct dce110_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1383,7 +1383,7 @@ static bool dce112_resource_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce112_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 06d4a6918bbb..5b0a8453b747 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -627,7 +627,7 @@ static void dce120_resource_destruct(struct dce110_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -929,7 +929,7 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	struct dm_pp_clock_levels_with_latency eng_clks = {0};
 	struct dm_pp_clock_levels_with_latency mem_clks = {0};
 	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {0};
-	int i;
+	unsigned int i;
 	unsigned int clk;
 	unsigned int latency;
 	/*original logic in dal3*/
@@ -1229,7 +1229,7 @@ static bool dce120_resource_construct(
 		j++;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce120_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 22d6ad298a3b..d8881c9cfc31 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -855,7 +855,7 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1059,7 +1059,7 @@ static bool dce80_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce80_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1259,7 +1259,7 @@ static bool dce81_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce80_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1457,7 +1457,7 @@ static bool dce83_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dce80_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index b7bd7344065b..214461f5d2f2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -978,7 +978,7 @@ static void dcn10_resource_destruct(struct dcn10_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		kfree(pool->base.hw_i2cs[i]);
@@ -1183,7 +1183,8 @@ static enum dc_status dcn10_validate_plane(const struct dc_plane_state *plane_st
 {
 	if (plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN
 			&& caps->max_video_width != 0
-			&& plane_state->src_rect.width > caps->max_video_width)
+			&& plane_state->src_rect.width > 0
+			&& (unsigned int)plane_state->src_rect.width > caps->max_video_width)
 		return DC_FAIL_SURFACE_VALIDATE;
 
 	return DC_OK;
@@ -1268,7 +1269,7 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
-	int i;
+	unsigned int i;
 	int j = -1;
 	struct dc_link *link = stream->link;
 
@@ -1280,7 +1281,7 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 			 */
 
 			if (pool->stream_enc[i]->id != ENGINE_ID_VIRTUAL)
-				j = i;
+				j = (int)i;
 
 			if (link->ep_type == DISPLAY_ENDPOINT_PHY && pool->stream_enc[i]->id ==
 					link->link_enc->preferred_engine)
@@ -1342,7 +1343,7 @@ static uint32_t read_pipe_fuses(struct dc_context *ctx)
 
 static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
 {
-	int i;
+	unsigned int i;
 
 	if (clks->num_levels == 0)
 		return false;
@@ -1360,7 +1361,7 @@ static bool dcn10_resource_construct(
 	struct dc *dc,
 	struct dcn10_resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	int j;
 	struct dc_context *ctx = dc->ctx;
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
@@ -1655,7 +1656,7 @@ static bool dcn10_resource_construct(
 		j++;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dcn10_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 038798808e52..2cfe69708bf6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1120,7 +1120,7 @@ static void dcn20_resource_destruct(struct dcn20_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1156,7 +1156,7 @@ static void dcn20_resource_destruct(struct dcn20_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1169,19 +1169,19 @@ static void dcn20_resource_destruct(struct dcn20_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN20_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1415,7 +1415,7 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc,
 		struct dc_stream_state *dc_stream)
 {
 	enum dc_status result = DC_OK;
-	int i;
+	unsigned int i;
 
 	/* Get a DSC if required and available */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1636,7 +1636,8 @@ void dcn20_set_mcif_arb_params(
 {
 	enum mmhubbub_wbif_mode wbif_mode;
 	struct mcif_arb_params *wb_arb_params;
-	int i, j, dwb_pipe;
+	int j, dwb_pipe;
+	unsigned int i;
 
 	/* Writeback MCIF_WB arbitration parameters */
 	dwb_pipe = 0;
@@ -1680,7 +1681,7 @@ void dcn20_set_mcif_arb_params(
 
 bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 {
-	int i;
+	unsigned int i;
 
 	/* Validate DSC config, dsc count validation is already done */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1797,7 +1798,7 @@ void dcn20_merge_pipes_for_validate(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	/* merge previously split odm pipes since mode support needs to make the decision */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1864,7 +1865,8 @@ int dcn20_validate_apply_pipe_split_flags(
 		int *split,
 		bool *merge)
 {
-	int i, pipe_idx, vlevel_split;
+	unsigned int i;
+	int pipe_idx, vlevel_split;
 	int plane_count = 0;
 	bool force_split = false;
 	bool avoid_split = dc->debug.pipe_split_policy == MPC_SPLIT_AVOID;
@@ -1897,7 +1899,7 @@ int dcn20_validate_apply_pipe_split_flags(
 				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
 			++plane_count;
 	}
-	if (plane_count > dc->res_pool->pipe_count / 2)
+	if ((unsigned int)plane_count > dc->res_pool->pipe_count / 2)
 		avoid_split = true;
 
 	/* W/A: Mode timing with borders may not work well with pipe split, avoid for this corner case */
@@ -1923,12 +1925,12 @@ int dcn20_validate_apply_pipe_split_flags(
 			if (!context->res_ctx.pipe_ctx[i].stream)
 				continue;
 
-			for (vlevel_split = vlevel; vlevel <= context->bw_ctx.dml.soc.num_states; vlevel++)
+			for (vlevel_split = vlevel; (unsigned int)vlevel <= context->bw_ctx.dml.soc.num_states; vlevel++)
 				if (v->NoOfDPP[vlevel][0][pipe_idx] == 1 &&
 						v->ModeSupport[vlevel][0])
 					break;
 			/* Impossible to not split this pipe */
-			if (vlevel > context->bw_ctx.dml.soc.num_states)
+			if ((unsigned int)vlevel > context->bw_ctx.dml.soc.num_states)
 				vlevel = vlevel_split;
 			else
 				max_mpc_comb = 0;
@@ -2064,7 +2066,8 @@ bool dcn20_fast_validate_bw(
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
 	bool merge[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel;
+	int pipe_cnt, pipe_idx, vlevel;
+	unsigned int i;
 
 	ASSERT(pipes);
 	if (!pipes)
@@ -2083,7 +2086,7 @@ bool dcn20_fast_validate_bw(
 
 	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (vlevel > context->bw_ctx.dml.soc.num_states)
+	if ((unsigned int)vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
 	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
@@ -2288,7 +2291,7 @@ static const struct resource_funcs dcn20_res_pool_funcs = {
 
 bool dcn20_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -2311,7 +2314,7 @@ bool dcn20_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 
 bool dcn20_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	ASSERT(pipe_count > 0);
@@ -2570,7 +2573,7 @@ static bool dcn20_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; (unsigned int)i < pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2618,12 +2621,12 @@ static bool dcn20_resource_construct(
 
 	if (!dc->debug.disable_pplib_wm_range) {
 		struct pp_smu_wm_range_sets ranges = {0};
-		int i = 0;
+		int j = 0;
 
 		ranges.num_reader_wm_sets = 0;
 
 		if (loaded_bb->num_states == 1) {
-			ranges.reader_wm_sets[0].wm_inst = (uint8_t)i;
+			ranges.reader_wm_sets[0].wm_inst = (uint8_t)j;
 			ranges.reader_wm_sets[0].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 			ranges.reader_wm_sets[0].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 			ranges.reader_wm_sets[0].min_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
@@ -2631,15 +2634,14 @@ static bool dcn20_resource_construct(
 
 			ranges.num_reader_wm_sets = 1;
 		} else if (loaded_bb->num_states > 1) {
-			for (i = 0; i < 4 && i < loaded_bb->num_states; i++) {
-				ranges.reader_wm_sets[i].wm_inst = (uint8_t)i;
-				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
-				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+			for (j = 0; j < 4 && (unsigned int)j < loaded_bb->num_states; j++) {
+				ranges.reader_wm_sets[j].wm_inst = (uint8_t)j;
+				ranges.reader_wm_sets[j].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
+				ranges.reader_wm_sets[j].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 				DC_FP_START();
-				dcn20_fpu_set_wm_ranges(i, &ranges, loaded_bb);
+				dcn20_fpu_set_wm_ranges(j, &ranges, loaded_bb);
 				DC_FP_END();
-
-				ranges.num_reader_wm_sets = i + 1;
+				ranges.num_reader_wm_sets = j + 1;
 			}
 
 			ranges.reader_wm_sets[0].min_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
@@ -2665,7 +2667,7 @@ static bool dcn20_resource_construct(
 		goto create_fail;
 
 	/* mem input -> ipp -> dpp -> opp -> TG */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; (unsigned int)i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn20_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2793,7 +2795,7 @@ static bool dcn20_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; (unsigned int)i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 775cfa901f08..0ee386c3bc23 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -684,7 +684,7 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -719,7 +719,7 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 			dal_irq_service_destroy(&pool->base.irqs);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -732,19 +732,19 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN20_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -804,7 +804,8 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
 	bool merge[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel;
+	int pipe_cnt, pipe_idx, vlevel;
+	unsigned int i;
 
 	ASSERT(pipes);
 	if (!pipes)
@@ -829,7 +830,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 				dm_allow_self_refresh_and_mclk_switch;
 	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (vlevel > context->bw_ctx.dml.soc.num_states) {
+	if ((unsigned int)vlevel > context->bw_ctx.dml.soc.num_states) {
 
 		if (allow_self_refresh_only) {
 			/*
@@ -842,7 +843,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
 						dm_allow_self_refresh;
 			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-			if (vlevel > context->bw_ctx.dml.soc.num_states)
+			if ((unsigned int)vlevel > context->bw_ctx.dml.soc.num_states)
 				goto validate_fail;
 		} else {
 			goto validate_fail;
@@ -1428,7 +1429,8 @@ static bool dcn21_resource_construct(
 	struct dc *dc,
 	struct dcn21_resource_pool *pool)
 {
-	int i, j;
+	unsigned int i;
+	int j;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
@@ -1660,7 +1662,7 @@ static bool dcn21_resource_construct(
 		j++;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dcn21_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1704,11 +1706,11 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn21_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
 			BREAK_TO_DEBUGGER();
-			dm_error("DC: failed to create display stream compressor %d!\n", i);
+			dm_error("DC: failed to create display stream compressor %u!\n", i);
 			goto create_fail;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index baefddd03438..e49728cb41d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1113,7 +1113,7 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1149,7 +1149,7 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1162,19 +1162,19 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1197,7 +1197,7 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1252,7 +1252,7 @@ static struct hubp *dcn30_hubp_create(
 
 static bool dcn30_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1277,7 +1277,7 @@ static bool dcn30_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn30_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1359,7 +1359,8 @@ int dcn30_populate_dml_pipes_from_context(
 	display_e2e_pipe_params_st *pipes,
 	enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	int pipe_cnt;
+	unsigned int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
 	DC_FP_START();
@@ -1417,7 +1418,8 @@ void dcn30_set_mcif_arb_params(
 	enum mmhubbub_wbif_mode wbif_mode;
 	struct display_mode_lib *dml = &context->bw_ctx.dml;
 	struct mcif_arb_params *wb_arb_params;
-	int i, j, dwb_pipe;
+	int j, dwb_pipe;
+	unsigned int i;
 
 	/* Writeback MCIF_WB arbitration parameters */
 	dwb_pipe = 0;
@@ -1673,7 +1675,8 @@ noinline bool dcn30_internal_validate_bw(
 	int split[MAX_PIPES] = { 0 };
 	bool merge[MAX_PIPES] = { false };
 	bool newly_split[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel = 0;
+	unsigned int i;
+	int pipe_cnt, pipe_idx, vlevel = 0;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	ASSERT(pipes);
@@ -1705,7 +1708,7 @@ noinline bool dcn30_internal_validate_bw(
 			dm_allow_self_refresh_and_mclk_switch;
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 		/* This may adjust vlevel and maxMpcComb */
-		if (vlevel < context->bw_ctx.dml.soc.num_states)
+		if ((unsigned int)vlevel < context->bw_ctx.dml.soc.num_states)
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 	}
 	if (allow_self_refresh_only &&
@@ -1723,7 +1726,7 @@ noinline bool dcn30_internal_validate_bw(
 			dm_allow_self_refresh;
 
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+		if ((unsigned int)vlevel < context->bw_ctx.dml.soc.num_states) {
 			memset(split, 0, sizeof(split));
 			memset(merge, 0, sizeof(merge));
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
@@ -2163,13 +2166,13 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	if (bw_params->clk_table.entries[0].memclk_mhz) {
 
 		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-			if (bw_params->clk_table.entries[i].dcfclk_mhz > dcn30_bb_max_clk.max_dcfclk_mhz)
+			if (bw_params->clk_table.entries[i].dcfclk_mhz > (unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz)
 				dcn30_bb_max_clk.max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-			if (bw_params->clk_table.entries[i].dispclk_mhz > dcn30_bb_max_clk.max_dispclk_mhz)
+			if (bw_params->clk_table.entries[i].dispclk_mhz > (unsigned int)dcn30_bb_max_clk.max_dispclk_mhz)
 				dcn30_bb_max_clk.max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-			if (bw_params->clk_table.entries[i].dppclk_mhz > dcn30_bb_max_clk.max_dppclk_mhz)
+			if (bw_params->clk_table.entries[i].dppclk_mhz > (unsigned int)dcn30_bb_max_clk.max_dppclk_mhz)
 				dcn30_bb_max_clk.max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-			if (bw_params->clk_table.entries[i].phyclk_mhz > dcn30_bb_max_clk.max_phyclk_mhz)
+			if (bw_params->clk_table.entries[i].phyclk_mhz > (unsigned int)dcn30_bb_max_clk.max_phyclk_mhz)
 				dcn30_bb_max_clk.max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
 		}
 
@@ -2177,14 +2180,14 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		dcn30_fpu_update_max_clk(&dcn30_bb_max_clk);
 		DC_FP_END();
 
-		if (dcn30_bb_max_clk.max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+		if ((unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
 			// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
 			dcfclk_sta_targets[num_dcfclk_sta_targets] = dcn30_bb_max_clk.max_dcfclk_mhz;
 			num_dcfclk_sta_targets++;
-		} else if (dcn30_bb_max_clk.max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+		} else if ((unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
 			// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
 			for (i = 0; i < num_dcfclk_sta_targets; i++) {
-				if (dcfclk_sta_targets[i] > dcn30_bb_max_clk.max_dcfclk_mhz) {
+				if (dcfclk_sta_targets[i] > (unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz) {
 					dcfclk_sta_targets[i] = dcn30_bb_max_clk.max_dcfclk_mhz;
 					break;
 				}
@@ -2236,7 +2239,7 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 			} else {
-				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= dcn30_bb_max_clk.max_dcfclk_mhz) {
+				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= (unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz) {
 					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
 					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 				} else {
@@ -2251,7 +2254,7 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		}
 
 		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
-				optimal_dcfclk_for_uclk[j] <= dcn30_bb_max_clk.max_dcfclk_mhz) {
+				optimal_dcfclk_for_uclk[j] <= (unsigned int)dcn30_bb_max_clk.max_dcfclk_mhz) {
 			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
 			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
 		}
@@ -2311,7 +2314,7 @@ static bool dcn30_resource_construct(
 	struct dc *dc,
 	struct dcn30_resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	struct ddc_service_init_data ddc_init_data = {0};
@@ -2533,7 +2536,7 @@ static bool dcn30_resource_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		pool->base.opps[i] = dcn30_opp_create(ctx, i);
 		if (pool->base.opps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2543,7 +2546,7 @@ static bool dcn30_resource_construct(
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.timing_generators[i] = dcn30_timing_generator_create(
 				ctx, i);
 		if (pool->base.timing_generators[i] == NULL) {
@@ -2563,13 +2566,13 @@ static bool dcn30_resource_construct(
 	}
 
 	/* ABM */
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
 				&abm_regs[i],
 				&abm_shift,
 				&abm_mask);
 		if (pool->base.multiple_abms[i] == NULL) {
-			dm_error("DC: failed to create abm for pipe %d!\n", i);
+			dm_error("DC: failed to create abm for pipe %u!\n", i);
 			BREAK_TO_DEBUGGER();
 			goto create_fail;
 		}
@@ -2582,11 +2585,11 @@ static bool dcn30_resource_construct(
 		goto create_fail;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn30_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
 			BREAK_TO_DEBUGGER();
-			dm_error("DC: failed to create display stream compressor %d!\n", i);
+			dm_error("DC: failed to create display stream compressor %u!\n", i);
 			goto create_fail;
 		}
 	}
@@ -2605,7 +2608,7 @@ static bool dcn30_resource_construct(
 	}
 
 	/* AUX and I2C */
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dcn30_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 625d9ec713a9..69890c26a8b1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1084,7 +1084,7 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1120,7 +1120,7 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1133,19 +1133,19 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1168,7 +1168,7 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1184,7 +1184,7 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1212,7 +1212,7 @@ static struct hubp *dcn301_hubp_create(struct dc_context *ctx, uint32_t inst)
 
 static bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1237,7 +1237,7 @@ static bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool *poo
 
 static bool dcn301_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1448,7 +1448,8 @@ static bool dcn301_resource_construct(
 	struct dc *dc,
 	struct dcn301_resource_pool *pool)
 {
-	int i, j;
+	int j;
+	unsigned int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
@@ -1680,13 +1681,13 @@ static bool dcn301_resource_construct(
 
 	/* ABM (or ABMs for NV2x) */
 	/* TODO: */
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
 				&abm_regs[i],
 				&abm_shift,
 				&abm_mask);
 		if (pool->base.multiple_abms[i] == NULL) {
-			dm_error("DC: failed to create abm for pipe %d!\n", i);
+			dm_error("DC: failed to create abm for pipe %u!\n", i);
 			BREAK_TO_DEBUGGER();
 			goto create_fail;
 		}
@@ -1700,11 +1701,11 @@ static bool dcn301_resource_construct(
 		goto create_fail;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn301_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
 			BREAK_TO_DEBUGGER();
-			dm_error("DC: failed to create display stream compressor %d!\n", i);
+			dm_error("DC: failed to create display stream compressor %u!\n", i);
 			goto create_fail;
 		}
 	}
@@ -1723,7 +1724,7 @@ static bool dcn301_resource_construct(
 	}
 
 	/* AUX and I2C */
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dcn301_aux_engine_create(ctx, i);
 		if (pool->base.engines[i] == NULL) {
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 6f380363033a..db7de6036408 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -738,7 +738,7 @@ static const struct dcn30_dwbc_mask dwbc30_mask = {
 
 static bool dcn302_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -773,7 +773,7 @@ static const struct dcn30_mmhubbub_mask mcif_wb30_mask = {
 
 static bool dcn302_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1036,7 +1036,7 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_dsc; i++) {
 		if (pool->dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->dscs[i]);
 	}
@@ -1071,7 +1071,7 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 			dal_irq_service_destroy(&pool->irqs);
 	}
 
-	for (i = 0; i < pool->res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_ddc; i++) {
 		if (pool->engines[i] != NULL)
 			dce110_engine_destroy(&pool->engines[i]);
 		if (pool->hw_i2cs[i] != NULL) {
@@ -1084,19 +1084,19 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_opp; i++) {
 		if (pool->opps[i] != NULL)
 			pool->opps[i]->funcs->opp_destroy(&pool->opps[i]);
 	}
 
-	for (i = 0; i < pool->res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_timing_generator; i++) {
 		if (pool->timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->timing_generators[i]));
 			pool->timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_dwb; i++) {
 		if (pool->dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->dwbc[i]));
 			pool->dwbc[i] = NULL;
@@ -1120,7 +1120,7 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 	if (pool->dp_clock_source != NULL)
 		dcn20_clock_source_destroy(&pool->dp_clock_source);
 
-	for (i = 0; i < pool->res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_mpc_3dlut; i++) {
 		if (pool->mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->mpc_lut[i]);
 			pool->mpc_lut[i] = NULL;
@@ -1371,7 +1371,7 @@ static bool dcn302_resource_construct(
 					CLOCK_SOURCE_ID_DP_DTO,
 					&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->clk_src_count; i++) {
+	for (i = 0; i < (int)pool->clk_src_count; i++) {
 		if (pool->clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -1416,7 +1416,7 @@ static bool dcn302_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < (int)pool->pipe_count; i++) {
 		pool->hubps[i] = dcn302_hubp_create(ctx, i);
 		if (pool->hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1526,7 +1526,7 @@ static bool dcn302_resource_construct(
 
 	dc->caps.max_planes =  pool->pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 8a7f62ab98b5..fc7353451e8f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -699,7 +699,7 @@ static const struct dcn30_dwbc_mask dwbc30_mask = {
 
 static bool dcn303_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -734,7 +734,7 @@ static const struct dcn30_mmhubbub_mask mcif_wb30_mask = {
 
 static bool dcn303_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -980,7 +980,7 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_dsc; i++) {
 		if (pool->dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->dscs[i]);
 	}
@@ -1015,7 +1015,7 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 			dal_irq_service_destroy(&pool->irqs);
 	}
 
-	for (i = 0; i < pool->res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_ddc; i++) {
 		if (pool->engines[i] != NULL)
 			dce110_engine_destroy(&pool->engines[i]);
 		if (pool->hw_i2cs[i] != NULL) {
@@ -1028,19 +1028,19 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_opp; i++) {
 		if (pool->opps[i] != NULL)
 			pool->opps[i]->funcs->opp_destroy(&pool->opps[i]);
 	}
 
-	for (i = 0; i < pool->res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_timing_generator; i++) {
 		if (pool->timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->timing_generators[i]));
 			pool->timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_dwb; i++) {
 		if (pool->dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->dwbc[i]));
 			pool->dwbc[i] = NULL;
@@ -1064,7 +1064,7 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 	if (pool->dp_clock_source != NULL)
 		dcn20_clock_source_destroy(&pool->dp_clock_source);
 
-	for (i = 0; i < pool->res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->res_cap->num_mpc_3dlut; i++) {
 		if (pool->mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->mpc_lut[i]);
 			pool->mpc_lut[i] = NULL;
@@ -1303,7 +1303,7 @@ static bool dcn303_resource_construct(
 					CLOCK_SOURCE_ID_DP_DTO,
 					&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->clk_src_count; i++) {
+	for (i = 0; i < (int)pool->clk_src_count; i++) {
 		if (pool->clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -1348,7 +1348,7 @@ static bool dcn303_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < (int)pool->pipe_count; i++) {
 		pool->hubps[i] = dcn303_hubp_create(ctx, i);
 		if (pool->hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1458,7 +1458,7 @@ static bool dcn303_resource_construct(
 
 	dc->caps.max_planes =  pool->pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 200be0f46ab0..5925c40da6ee 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1148,7 +1148,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1414,7 +1414,7 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1448,7 +1448,7 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1461,19 +1461,19 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1496,7 +1496,7 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1512,7 +1512,7 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1548,7 +1548,7 @@ static struct hubp *dcn31_hubp_create(
 
 static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1573,7 +1573,7 @@ static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn31_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1655,7 +1655,7 @@ int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
 					  enum dc_validate_mode validate_mode)
 {
 	uint32_t pipe_cnt;
-	int i;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -1679,7 +1679,7 @@ int dcn31_populate_dml_pipes_from_context(
 	display_e2e_pipe_params_st *pipes,
 	enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	unsigned int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
@@ -2080,7 +2080,7 @@ static bool dcn31_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2119,7 +2119,7 @@ static bool dcn31_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2256,7 +2256,7 @@ static bool dcn31_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 6a4094663050..16eee0c6f4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1206,7 +1206,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1473,7 +1473,7 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1506,7 +1506,7 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 			dal_irq_service_destroy(&pool->base.irqs);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1519,19 +1519,19 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1554,7 +1554,7 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1570,7 +1570,7 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1606,7 +1606,7 @@ static struct hubp *dcn31_hubp_create(
 
 static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1631,7 +1631,7 @@ static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn31_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -2000,7 +2000,7 @@ static bool dcn314_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2037,7 +2037,7 @@ static bool dcn314_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2167,7 +2167,7 @@ static bool dcn314_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 76b112426f33..37404aa0edd9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1147,7 +1147,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1415,7 +1415,7 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1449,7 +1449,7 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1462,19 +1462,19 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1497,7 +1497,7 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1513,7 +1513,7 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1549,7 +1549,7 @@ static struct hubp *dcn31_hubp_create(
 
 static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1574,7 +1574,7 @@ static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn31_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1670,7 +1670,7 @@ static int source_format_to_bpp (enum source_format_class SourcePixelFormat)
 
 static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
 	/* Only apply for dual stream scenarios with edp*/
@@ -1703,7 +1703,8 @@ static int dcn315_populate_dml_pipes_from_context(
 	display_e2e_pipe_params_st *pipes,
 	enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt, crb_idx, crb_pipes;
+	unsigned int i;
+	int pipe_cnt, crb_idx, crb_pipes;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = NULL;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
@@ -1743,7 +1744,7 @@ static int dcn315_populate_dml_pipes_from_context(
 
 			if (approx_det_segs_required_for_pstate <= 2 * DCN3_15_MAX_DET_SEGS) {
 				bool split_required = approx_det_segs_required_for_pstate > DCN3_15_MAX_DET_SEGS;
-				split_required = split_required || timing->pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
+				split_required = split_required || (unsigned int)timing->pix_clk_100hz >= (unsigned int)dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
 				split_required = split_required || (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
 				/* Minimum 2 segments to allow mpc/odm combine if its used later */
@@ -1792,7 +1793,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				continue;
 			}
 
-			bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+			bool split_required = (unsigned int)pipe->stream->timing.pix_clk_100hz >= (unsigned int)dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 					|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
 			if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
@@ -1829,7 +1830,7 @@ static int dcn315_populate_dml_pipes_from_context(
 					(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / 4) * DCN3_15_CRB_SEGMENT_SIZE_KB;
 		} else if (!is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 5120
-				&& pipe->stream->timing.pix_clk_100hz < dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)) {
+				&& (unsigned int)pipe->stream->timing.pix_clk_100hz < (unsigned int)dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)) {
 			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
@@ -2030,7 +2031,7 @@ static bool dcn315_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2069,7 +2070,7 @@ static bool dcn315_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2196,7 +2197,7 @@ static bool dcn315_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 2d34db42dd83..d946663f416a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1140,7 +1140,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1410,7 +1410,7 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1444,7 +1444,7 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1457,19 +1457,19 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1492,7 +1492,7 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1508,7 +1508,7 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1541,7 +1541,7 @@ static struct hubp *dcn31_hubp_create(
 
 static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1566,7 +1566,7 @@ static bool dcn31_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn31_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1648,7 +1648,8 @@ static int dcn316_populate_dml_pipes_from_context(
 	display_e2e_pipe_params_st *pipes,
 	enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	unsigned int i;
+	int pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_16_MIN_COMPBUF_SIZE_KB;
@@ -1904,7 +1905,7 @@ static bool dcn316_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -1943,7 +1944,7 @@ static bool dcn316_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2062,7 +2063,7 @@ static bool dcn316_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 6f0a3b0ff2d3..28d21dd30106 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1421,7 +1421,7 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1451,7 +1451,7 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1464,19 +1464,19 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1499,7 +1499,7 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1515,7 +1515,7 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1541,7 +1541,7 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 
 static bool dcn32_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1570,7 +1570,7 @@ static bool dcn32_dwbc_create(struct dc_context *ctx, struct resource_pool *pool
 
 static bool dcn32_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1906,7 +1906,8 @@ int dcn32_populate_dml_pipes_from_context(
 	display_e2e_pipe_params_st *pipes,
 	enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	unsigned int i;
+	int pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = NULL;
 	bool subvp_in_use = false;
@@ -2380,7 +2381,7 @@ static bool dcn32_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2550,7 +2551,7 @@ static bool dcn32_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index b2eac83ef02c..602a0e4e5dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -382,7 +382,8 @@ void dcn32_determine_det_override(struct dc *dc,
 void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes)
 {
-	int i, pipe_cnt;
+	unsigned int i;
+	int pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	bool disable_unbounded_requesting = dc->debug.disable_z9_mpc || dc->debug.disable_unbounded_requesting;
@@ -751,7 +752,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes)
 {
-	int i, pipe_cnt;
+	unsigned int i;
+	int pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 663e9335fdec..296558258672 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1402,7 +1402,7 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1431,7 +1431,7 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 			dal_irq_service_destroy(&pool->base.irqs);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1444,19 +1444,19 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1479,7 +1479,7 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1495,7 +1495,7 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1521,7 +1521,7 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 
 static bool dcn321_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1550,7 +1550,7 @@ static bool dcn321_dwbc_create(struct dc_context *ctx, struct resource_pool *poo
 
 static bool dcn321_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1879,7 +1879,7 @@ static bool dcn321_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2044,7 +2044,7 @@ static bool dcn321_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 27f8f13912b3..c7fba9f39e19 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1154,7 +1154,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1484,7 +1484,7 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1514,7 +1514,7 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1527,19 +1527,19 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1562,7 +1562,7 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1578,7 +1578,7 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1635,7 +1635,7 @@ static void dcn35_dwbc_init(struct dcn30_dwbc *dwbc30, struct dc_context *ctx)
 
 static bool dcn35_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1674,7 +1674,7 @@ static void dcn35_mmhubbub_init(struct dcn30_mmhubbub *mcif_wb30,
 
 static bool dcn35_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -2040,7 +2040,7 @@ static bool dcn35_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2092,7 +2092,7 @@ static bool dcn35_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2224,7 +2224,7 @@ static bool dcn35_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index d032db65108b..e9fc43abf342 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1134,7 +1134,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1464,7 +1464,7 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1494,7 +1494,7 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1507,19 +1507,19 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1542,7 +1542,7 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1558,7 +1558,7 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1615,7 +1615,7 @@ static void dcn35_dwbc_init(struct dcn30_dwbc *dwbc30, struct dc_context *ctx)
 
 static bool dcn35_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1654,7 +1654,7 @@ static void dcn35_mmhubbub_init(struct dcn30_mmhubbub *mcif_wb30,
 
 static bool dcn35_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -2012,7 +2012,7 @@ static bool dcn351_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2064,7 +2064,7 @@ static bool dcn351_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2196,7 +2196,7 @@ static bool dcn351_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 42fa8883d1b7..eb597be989a6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1141,7 +1141,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1471,7 +1471,7 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1501,7 +1501,7 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1514,19 +1514,19 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1549,7 +1549,7 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1565,7 +1565,7 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1622,7 +1622,7 @@ static void dcn35_dwbc_init(struct dcn30_dwbc *dwbc30, struct dc_context *ctx)
 
 static bool dcn35_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1661,7 +1661,7 @@ static void dcn35_mmhubbub_init(struct dcn30_mmhubbub *mcif_wb30,
 
 static bool dcn35_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -2010,7 +2010,7 @@ static bool dcn36_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2062,7 +2062,7 @@ static bool dcn36_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs and TGs */
-	for (i = 0; i < pool->base.pipe_count; i++) {
+	for (i = 0; i < (int)pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
 		if (pool->base.hubps[i] == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -2194,7 +2194,7 @@ static bool dcn36_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 6aa051154f5e..9498cbff2449 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1427,7 +1427,7 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn401_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1457,7 +1457,7 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1470,19 +1470,19 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL)	{
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1505,7 +1505,7 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1521,7 +1521,7 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1547,7 +1547,7 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 
 static bool dcn401_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1578,7 +1578,7 @@ static bool dcn401_dwbc_create(struct dc_context *ctx, struct resource_pool *poo
 
 static bool dcn401_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1796,11 +1796,11 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 		pixel_clk_params->dio_se_pix_per_cycle = 2;
 	} else if (dc_is_dp_signal(stream->signal)) {
 		/* round up to nearest power of 2, or max at 8 pixels per cycle */
-		if (pixel_clk_params->requested_pix_clk_100hz > 4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		if ((unsigned int)pixel_clk_params->requested_pix_clk_100hz > (unsigned int)(4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 8;
-		} else if (pixel_clk_params->requested_pix_clk_100hz > 2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		} else if ((unsigned int)pixel_clk_params->requested_pix_clk_100hz > (unsigned int)(2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 4;
-		} else if (pixel_clk_params->requested_pix_clk_100hz > stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		} else if ((unsigned int)pixel_clk_params->requested_pix_clk_100hz > (unsigned int)(stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 2;
 		} else {
 			pixel_clk_params->dio_se_pix_per_cycle = 1;
@@ -1810,10 +1810,10 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 
 int dcn401_get_power_profile(const struct dc_state *context)
 {
-	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
+	unsigned int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
 	int dpm_level = 0;
 
-	for (int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
+	for (unsigned int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
 		if (context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz == 0 ||
 			uclk_mhz < context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
 			break;
@@ -2100,7 +2100,7 @@ static bool dcn401_resource_construct(
 				CLOCK_SOURCE_ID_DP_DTO,
 				&clk_src_regs[0], true);
 
-	for (i = 0; i < pool->base.clk_src_count; i++) {
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
 		if (pool->base.clock_sources[i] == NULL) {
 			dm_error("DC: failed to create clock sources!\n");
 			BREAK_TO_DEBUGGER();
@@ -2262,7 +2262,7 @@ static bool dcn401_resource_construct(
 
 	dc->caps.max_planes =  pool->base.pipe_count;
 
-	for (i = 0; i < dc->caps.max_planes; ++i)
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
 	dc->caps.max_odm_combine_factor = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index c013a6483f5d..57c6e81280bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1416,7 +1416,7 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn42_dsc_destroy(&pool->base.dscs[i]);
 	}
@@ -1445,7 +1445,7 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 			dal_irq_service_destroy(&pool->base.irqs);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		if (pool->base.engines[i] != NULL)
 			dce110_engine_destroy(&pool->base.engines[i]);
 		if (pool->base.hw_i2cs[i] != NULL) {
@@ -1458,19 +1458,19 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.timing_generators[i] != NULL) {
 			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
 			pool->base.timing_generators[i] = NULL;
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_dwb; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
 		if (pool->base.dwbc[i] != NULL) {
 			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
 			pool->base.dwbc[i] = NULL;
@@ -1493,7 +1493,7 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
 		if (pool->base.mpc_lut[i] != NULL) {
 			dc_3dlut_func_release(pool->base.mpc_lut[i]);
 			pool->base.mpc_lut[i] = NULL;
@@ -1509,7 +1509,7 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		if (pool->base.multiple_abms[i] != NULL)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
@@ -1580,11 +1580,11 @@ static void dcn42_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 		pixel_clk_params->dio_se_pix_per_cycle = 2;
 	} else if (dc_is_dp_signal(stream->signal)) {
 		/* round up to nearest power of 2, or max at 8 pixels per cycle */
-		if (pixel_clk_params->requested_pix_clk_100hz > 4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 8;
-		} else if (pixel_clk_params->requested_pix_clk_100hz > 2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		} else if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 4;
-		} else if (pixel_clk_params->requested_pix_clk_100hz > stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+		} else if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
 			pixel_clk_params->dio_se_pix_per_cycle = 2;
 		} else {
 			pixel_clk_params->dio_se_pix_per_cycle = 1;
@@ -1594,7 +1594,7 @@ static void dcn42_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 
 static bool dcn42_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t dwb_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < dwb_count; i++) {
@@ -1631,7 +1631,7 @@ static void dcn42_mmhubbub_init(struct dcn30_mmhubbub *mcif_wb30,
 
 static bool dcn42_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
 
 	for (i = 0; i < pipe_count; i++) {
@@ -1753,7 +1753,7 @@ static struct link_encoder *dcn42_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1831,7 +1831,7 @@ static bool dcn42_resource_construct(
 	struct dc *dc,
 	struct dcn42_resource_pool *pool)
 {
-	int i, j;
+	unsigned int i, j;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	uint32_t pipe_fuses;
@@ -1867,7 +1867,7 @@ static bool dcn42_resource_construct(
 	num_pipes = pool->base.res_cap->num_dpp;
 	pipe_fuses = read_pipe_fuses(ctx);
 
-	for (i = 0; i < pool->base.res_cap->num_dpp; i++)
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dpp; i++)
 		if (pipe_fuses & 1 << i)
 			num_pipes--;
 
@@ -2121,7 +2121,7 @@ static bool dcn42_resource_construct(
 	}
 
 	/* HUBPs, DPPs, OPPs, TGs, ABMs */
-	for (i = 0, j = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+	for (i = 0, j = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
 		/* if pipe is disabled, skip instance of HW pipe,
 		 * i.e, skip ASIC register instance
 		 */
@@ -2165,7 +2165,7 @@ static bool dcn42_resource_construct(
 													  &abm_shift,
 													  &abm_mask);
 		if (pool->base.multiple_abms[j] == NULL) {
-			dm_error("DC: failed to create abm for pipe %d!\n", i);
+			dm_error("DC: failed to create abm for pipe %u!\n", i);
 			BREAK_TO_DEBUGGER();
 			goto create_fail;
 		}
@@ -2200,11 +2200,11 @@ static bool dcn42_resource_construct(
 	}
 
 	/* DSCs */
-	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn42_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
 			BREAK_TO_DEBUGGER();
-			dm_error("DC: failed to create display stream compressor %d!\n", i);
+			dm_error("DC: failed to create display stream compressor %u!\n", i);
 			goto create_fail;
 		}
 	}
@@ -2224,7 +2224,7 @@ static bool dcn42_resource_construct(
 	}
 
 	/* AUX and I2C */
-	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
 		pool->base.engines[i] = dcn42_aux_engine_create(ctx, i);
 
 		if (pool->base.engines[i] == NULL) {
-- 
2.43.0

