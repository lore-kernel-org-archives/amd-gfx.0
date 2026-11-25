Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732E606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=B4PWl7Io
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0020F10F785;
	Wed, 25 Nov 2026 06:59:03 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AD610F787
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltboy2mYm9WvNT1Xw3OfUp0c+YriCSvExZeD+2u6Qxo6xxp/sinztKB+IN9h5K0hxD1+kvM1pm1LqkU/LstIoGhqzPXZJM8S3p3XRr+Xuj57AW74K/WHDUkSzouOOnErn9+Ri4iJQCGq8cgG8XQam6lTtK/tUZQDTcFGmVJFQsJDS/lhKQwIO3uITSvTqQmJ82RfkvjR698pBXkTXlvU7mhZccS/XHwrz6UF1DUWo6GSMjAuLnF1Ks6mxWnCiyynVVTPVc2dLRwEBS+ZZHUBhvNLtjd4hmlZwmKnlasvrPdbq7Z7zHnxP+GMz0ehJP7LF5AbNSOp1JdRyyZpLG83IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPIV2kXLlcbGm1a0njci6P8w0ZzIBqpWzPbiXisXaLo=;
 b=U7Uvt/li9OAEDoEyiQ/bzYzKQMdCASM9noW7tY+88RE6ML69+NY6oZcuQm8Hnudf7R+0wdokFP9kPMMA78DL1JPHtBk92E+iU0TUpEq38dj1RCeyTtCvt2GZB4ZPQllQZH+dXB6M0Nb/wkOP71OwRtj0CzLC8VCbZAf/fkQoAiEFpp4KmwvSVpvehaBp6WxqPO4waNGDPZ1qnzNV/ul7d+gtM8hsrf3rd3X2qoYfVPAv+JiujTaDC4iocQTAanHsmgjqoZOZHdzuQbTsCCn9Z7/vi+/hpg5YuJhKQH0VDE0FlebLNWnTREN/YBRnoSfRWgKj/5+Un9VcRk5gxFTuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPIV2kXLlcbGm1a0njci6P8w0ZzIBqpWzPbiXisXaLo=;
 b=B4PWl7IoPzjqwFpZF1dvGIttwTM8761RctmPoI+gDZmLYYIuU84ml3sXzG93uf1FlCdthDO36BBIeaEo8rhyeTulauPy2d54UcH7KxdlWSR6XfJNWwFgKkmBc0Qpm+tCytaXGysQK6NjVMJZMyh/SYEYSC8h3VsSj+1l2Szlcg8=
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:58:53 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::85) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Wed,
 25 Nov 2026 06:58:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:52 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:44 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 24/27] drm/amd/display: Fix two streams sharing one OTG
Date: Wed, 25 Nov 2026 14:55:13 +0800
Message-ID: <20261125065631.3889665-25-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c72f97-07cc-490d-a9c9-08df4ac19121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|261022105027099003|261009223027099003|261028144727099003|261026140227099003|261021121427099003|261102123227099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: zHbwyv9BA4kuLTvCrkKi0EhvZQa5ww2I9kepv3661zbvNGwW3a2bt+OaEtlxAPbq+iLlZCEtVEC0Zq3I69fxYt08avmWZVGNNO0ITwmCojzNshzUkhvmCWQPndODSYMIodHfkWof91S7+EIzItU3mS8WZm8TjBlboWths4jSb8rxAdvs0/NOvP9FldcoZ12kfHwulFxQirsfih/PSMYZMzeyjS/uOoFjgq+p+LIh59C6gbPhjvZOD30lGohTbV9/5HIJbviazhHYJ1/5vguQpez6oMiIQegijO76a/KXle5hWYCXEVxAHEBLCZyjH9850EH7K/jKFsxUm2Yu7BVtzRjvMA4/Q55RaK064cWauhDzeUehtaeEnF9bIVTfFs6OZDhdwkhrKd6eCa7vgbpL3W8oMmjSRSk/80flLz+TpWtPTTcczF12m5JLzZEbLpG1IZ13cD/CfQadND1OOI/zbitmg3PP2uDV0TzJTf/5VcM8LN2IfeCPiIqsUh+Z38ub3Tn6AWGoLZBY4ZXIIHzxuaPdUjYCoZMrGfwmuzU5UBFPwsoxJjvtgbaj413yBTVvUqJcMRZzPF02IJAgoeJTlfFBDLPauBupjG668LBHpdzQd8qc4djXyjgZRVqbuCEkOkuIAhITgAE57m0Z/ymrbFaH4cgbbZwiW8bYZAqg40aQNtYbnNNqbasXvbYbt16qqaF0G2PmEg+Lda8JENIgMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBc40SiF4o1lOsAobP04koY37FZlq20Xy5sp7Pq29k89vQrw4UCqecNreKNd9FRTuKxxqpInNQY4jv9bQHNNo7+/XMqzI+himnBDwi3mZpGUfSAr9muF3EsqEMx02UTr/FQJNOn+kY4/qHy6HWpPecqwYjbnO7Xz4g4eRkPAwNMO5TBP0Vt2yVGCtDXAD3/DOT+4ANXt6WFeeb1eSF4qjDKFfWIFsyG7i/Eshu7KeKtcfgY/9G6qvORreroT34uiQBLE4/bXRhN/lTcmT2hdxSsFaqTDb5s43ZWaplqhC5O6hUstjVf3F90Va7zM+8N/r2BdbuGsFvoU4uU2E2vWhuY6bbr3Lc6CiLPqp7r5pUCovEuGmLUPAiy2sCl+YSC5FKLpoQAVfVWnN9HwbmkJYjgWRkHSY6ZMcAEdd8MKq8+KFBeuhJ/TXscYpOZ7FEey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:53.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c72f97-07cc-490d-a9c9-08df4ac19121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Some ASICs have more pipes than OTGs and OPPs. A stream could be
given a pipe without its own OTG and was then aliased to the last
OTG and OPP, which another stream already used. Both streams then
shared one OTG, so one of them stopped getting vblank interrupts.

[How]
Only pick a pipe as OTG master if it has its own OTG. If none is
free, drop another stream's ODM slices and let DML validation add
them back if needed. Remove the aliasing fallback. Skip pipes
without an OPP when acquiring an ODM slice.

Cc: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 64 ++++++++++++---
 .../dc/resource/dcn42b/dcn42b_resource.c      | 82 ++++++++++++++++++-
 .../dc/resource/dcn42b/dcn42b_resource.h      |  6 ++
 3 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ec11a79811e7..cb537aa90ad5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4295,6 +4295,48 @@ static void mark_seamless_boot_stream(const struct dc  *dc,
 	}
 }
 
+/*
+ * Some ASICs (e.g. DCN 2.0.1 and DCN 4.2B) have more pipes than OTGs. A pipe
+ * without its own OTG can only be a secondary DPP pipe. As an OTG master it
+ * would share the OTG and OPP of another stream.
+ */
+static bool can_pipe_be_otg_master(const struct resource_pool *pool,
+		int pipe_idx)
+{
+	return pipe_idx >= 0 &&
+			(unsigned int)pipe_idx < pool->timing_generator_count;
+}
+
+/*
+ * Remove the ODM slices of the first stream that has more than one and return
+ * the first free pipe. DML re-evaluates the ODM slice count of that stream
+ * during validation. It adds the slices back if the timing needs them and
+ * enough OPPs are left, and fails validation otherwise.
+ */
+static int release_odm_slices_of_a_stream(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool)
+{
+	unsigned int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		struct pipe_ctx *otg_master = &new_ctx->res_ctx.pipe_ctx[i];
+
+		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
+				resource_get_odm_slice_count(otg_master) == 1)
+			continue;
+
+		if (!resource_update_pipes_for_stream_with_slice_count(new_ctx,
+				cur_ctx, pool, otg_master->stream, 1))
+			return FREE_PIPE_INDEX_NOT_FOUND;
+
+		return resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
+	}
+
+	return FREE_PIPE_INDEX_NOT_FOUND;
+}
+
 /*
  * Acquire a pipe as OTG master and assign to the stream in new dc context.
  * return - true if OTG master pipe is acquired and new dc context is updated.
@@ -4349,7 +4391,7 @@ static bool acquire_otg_master_pipe_for_stream(
 	 * Try to acquire a pipe not used in current resource context to avoid
 	 * pipe swapping.
 	 */
-	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+	if (!can_pipe_be_otg_master(pool, pipe_idx))
 		pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
 				&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
 	/*
@@ -4357,12 +4399,19 @@ static bool acquire_otg_master_pipe_for_stream(
 	 * secondary DPP pipe in current state as we prioritize to support more
 	 * streams over supporting MPO planes.
 	 */
-	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+	if (!can_pipe_be_otg_master(pool, pipe_idx))
 		pipe_idx = resource_find_free_pipe_used_as_cur_sec_dpp(
 				&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
-	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+	if (!can_pipe_be_otg_master(pool, pipe_idx))
 		pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
-	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
+	/*
+	 * If the only free pipes have no OTG (e.g. pipe 3 on DCN 4.2B), free a
+	 * pipe that has one by removing the ODM slices of another stream.
+	 */
+	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND &&
+			!can_pipe_be_otg_master(pool, pipe_idx))
+		pipe_idx = release_odm_slices_of_a_stream(cur_ctx, new_ctx, pool);
+	if (can_pipe_be_otg_master(pool, pipe_idx)) {
 		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
 		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
 		pipe_ctx->pipe_idx = (uint8_t)pipe_idx;
@@ -4376,13 +4425,6 @@ static bool acquire_otg_master_pipe_for_stream(
 		if (pool->dpps[pipe_idx])
 			pipe_ctx->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 
-		if ((unsigned int)pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
-			int tg_inst = pool->timing_generator_count - 1;
-
-			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-			pipe_ctx->stream_res.opp = pool->opps[tg_inst];
-		}
-
 		pipe_ctx->stream = stream;
 	} else {
 		pipe_idx = acquire_first_split_pipe(&new_ctx->res_ctx, pool, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 338c506588d9..aeecdd2daae2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1950,6 +1950,86 @@ static unsigned int dcn42b_get_max_hw_cursor_size(const struct dc *dc,
 	return dc->caps.max_cursor_size;
 }
 
+/*
+ * DCN 4.2B has 4 pipes but only 3 OPPs. An OPP head needs its own OPP, so the
+ * pipe without one can only be a secondary DPP pipe.
+ */
+static bool dcn42b_can_pipe_be_opp_head(const struct resource_pool *pool,
+		int pipe_idx)
+{
+	return pipe_idx >= 0 && pool->opps[pipe_idx];
+}
+
+static int dcn42b_find_optimal_free_pipe_as_secondary_opp_head(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_otg_master)
+{
+	const struct pipe_ctx *cur_otg_master;
+	int free_pipe_idx;
+
+	cur_otg_master = &cur_res_ctx->pipe_ctx[new_otg_master->pipe_idx];
+	free_pipe_idx = resource_find_free_pipe_used_as_sec_opp_head_by_cur_otg_master(
+			cur_res_ctx, new_res_ctx, cur_otg_master);
+
+	if (!dcn42b_can_pipe_be_opp_head(pool, free_pipe_idx))
+		free_pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
+				cur_res_ctx, new_res_ctx, pool);
+
+	if (!dcn42b_can_pipe_be_opp_head(pool, free_pipe_idx))
+		free_pipe_idx = resource_find_any_free_pipe(new_res_ctx, pool);
+
+	if (!dcn42b_can_pipe_be_opp_head(pool, free_pipe_idx))
+		return FREE_PIPE_INDEX_NOT_FOUND;
+
+	return free_pipe_idx;
+}
+
+struct pipe_ctx *dcn42b_acquire_free_pipe_as_secondary_opp_head(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *otg_master)
+{
+	int free_pipe_idx = dcn42b_find_optimal_free_pipe_as_secondary_opp_head(
+			&cur_ctx->res_ctx, &new_ctx->res_ctx,
+			pool, otg_master);
+	struct pipe_ctx *free_pipe;
+
+	if (free_pipe_idx >= 0) {
+		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
+		free_pipe->pipe_idx = (uint8_t)free_pipe_idx;
+		free_pipe->stream = otg_master->stream;
+		free_pipe->stream_res.tg = otg_master->stream_res.tg;
+		free_pipe->stream_res.dsc = NULL;
+		free_pipe->stream_res.opp = pool->opps[free_pipe_idx];
+		free_pipe->plane_res.mi = pool->mis[free_pipe_idx];
+		free_pipe->plane_res.hubp = pool->hubps[free_pipe_idx];
+		free_pipe->plane_res.ipp = pool->ipps[free_pipe_idx];
+		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
+		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
+		free_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[free_pipe_idx]->inst;
+		free_pipe->dsc_padding_params = otg_master->dsc_padding_params;
+		if (free_pipe->stream->timing.flags.DSC == 1) {
+			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
+					&new_ctx->res_ctx,
+					&free_pipe->stream_res.dsc,
+					free_pipe_idx);
+			ASSERT(free_pipe->stream_res.dsc);
+			if (free_pipe->stream_res.dsc == NULL) {
+				memset(free_pipe, 0, sizeof(*free_pipe));
+				free_pipe = NULL;
+			}
+		}
+	} else {
+		ASSERT(otg_master);
+		free_pipe = NULL;
+	}
+
+	return free_pipe;
+}
+
 static struct resource_funcs dcn42b_res_pool_funcs = {
 	.destroy = dcn42b_destroy_resource_pool,
 	.link_enc_create = dcn42b_link_encoder_create,
@@ -1961,7 +2041,7 @@ static struct resource_funcs dcn42b_res_pool_funcs = {
 	.calculate_wm_and_dlg = NULL,
 	.populate_dml_pipes = NULL,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
-	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
+	.acquire_free_pipe_as_secondary_opp_head = dcn42b_acquire_free_pipe_as_secondary_opp_head,
 	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
index 484ba1455468..8b9e3e9723ed 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
@@ -516,4 +516,10 @@ enum dc_status dcn42b_validate_bandwidth(struct dc *dc,
 
 void dcn42b_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 
+struct pipe_ctx *dcn42b_acquire_free_pipe_as_secondary_opp_head(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *otg_master);
+
 #endif /* _DCN42B_RESOURCE_H_ */
-- 
2.43.0

