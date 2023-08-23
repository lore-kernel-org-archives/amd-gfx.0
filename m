Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B4EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FEE10E467;
	Wed, 23 Aug 2023 16:04:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E5B10E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grRCCvRLNpu7KYn+3FrS42gWuFo83H7cRRNfMy0gX0X7csNk7bsIP/vUHqehssWs7BAdDPXZqHME7EBDjgWSZAxBF7YsMxlDpcGl4nARUNcp4r7AULKDOA0wUvVLgAcdhyseUeudcb5AeY42D9LnUQ0M2fAUgWtMmadulZAWLrRNQtQx1zMiIIHixN2APM8yMSRGKN8uLdPns47z2OntJ3i5igi6KVVo8PiSUGs2Kb75hw6G8h4n2sEcpUv1dyxys9GKocImHEsJzaPJte8AIfXWMEKzIo5/oQNGJP5eYShL5MjwZ3ClDlLIhnOz5USwgkzS+/U0/q9KFf2j/rzwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PIZ2Aa4ntnxTxlYlZoYrTEbjXADIC0h8L4Vnilz+Jw=;
 b=A3e4vp/Pugl5Td7s0lsMJJBPRpQ/EWmdpKnprjyI2Jzns35Zra6RaPWfE6VqYWS8kDFSyz0UiTvqgB1SnNidmtFoSUcNLZX7ZwcJ1ekVXLpXtHb3LDWoIx0oem/v/V2nl+N709w8Oh3SLJiNOtJgdcqKQPsi1JzP2iElvwF4J9zva50L04BiOo8CFJT1KqKqaggdu4k6HSEF4DJqF84DQPwFjJapw/MtNzsQQhp5tuO+zaYeGZqMOgSf/ewRB+fiNLZk9iw/fntorDRyRdDxbejfCR1EegYlehgBjWyq34ToGn12mXZkTJCP3GIRxJOk4j85U6Yz3+j3/gzE6we0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PIZ2Aa4ntnxTxlYlZoYrTEbjXADIC0h8L4Vnilz+Jw=;
 b=GO6iCvVsn0dEhY8exFqO/wXMOGV0DmhLHJWYG35g7KlPX77VSoSNgSdUo7gt3gomtgTXCY80Gb/b1p1ZnO1v5/S5yLDYSCgCamq+YvYkVum60XGtBMsAvmCiKgUZa8dpSSEGqmZtLU9t6FsTbruEnRaneBeZn1U8g/yqbHjupug=
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Wed, 23 Aug
 2023 16:04:28 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::11) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 16:04:27 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:26 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: add new resource interface for
 acquiring sec opp heads and release pipe
Date: Wed, 23 Aug 2023 11:58:11 -0400
Message-ID: <20230823160347.176991-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c02bc1-fc06-4454-3282-08dba3f2a0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y1d/K3e9iVv4GSI7zWnc0ib5/aXNdvcNTkwSB5abU0vAnQFay4snNqTPNtOj2yIalDDjeKJKjbR65MluN0A/K/kx1KBHr6UglIb50NwSPCjHTKBeNAyVqCeYg0rE93r0faNGCoN/UI/pgMgKkxo3bDo9gqR/Jfpwb2nP6lPsVcldbHcgXuKZislrb/T+IWv6/72Qkf+dlRsrCuSvbgVtZDVl1f/qtKXIPnxqbqiV98EAOB1ih8aH7gb+rFUtXT98Xp3UZ39jS0FjyClK1+AZCYptyyhj4iCdVrQMd5QyBMWaO1h88t6acNCJCOhAEf7Rbu6LDtNy6PxIBKRaDhSnxj0YOo+mv5zSIjQ4gVixLz1OMIxTE/RZUGs7If7WaH4eoAOAkK8rx+FTTGu0Hm9ZWzwbYVMpnN8R5iTWtn86WB0ZOgfLrpFvX3EbAw2N6AqBzzUzXQ7qMiOhwWkpCeyqc08zpG1/BLQEDA5s1G2/UvrenUbVqdfs3ElqoEDq03xSrxIvZjOFaIFlTzdvFu4K3wY08NqIaC55vQi+DAPxU4u7ISCVpueOUDnP/X3p8K0elQuz22S9830ClwAOmUpLcU3UHPQFe036Nt4YWjGXM/yU9a3wD/Wr1krAnTA6x0DjEWNjaT2nGDdwqzwF6yI07yuquwFamX9v3L/9dGT4m6dKHnQrMkesqkY7IloWHx8ujZGwsNo7SbrUnT7aYJl9f5N9tXkp99M3jUzd9U6XO1Z/FaACpSCazBC9ct3MBSw79iSLbXZVcSr00Zady6QS43+6kHs8UGNuweeXHnt4G2M6ZbuTmfIG43VmrMVJ2ro
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(1076003)(40480700001)(40460700003)(83380400001)(5660300002)(6916009)(82740400003)(356005)(70206006)(70586007)(316002)(54906003)(2906002)(41300700001)(36860700001)(8936002)(47076005)(336012)(6666004)(426003)(2616005)(8676002)(4326008)(44832011)(26005)(16526019)(36756003)(86362001)(478600001)(81166007)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:27.9220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c02bc1-fc06-4454-3282-08dba3f2a0e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We need a new algorithm for acquiring secondary opp heads for ODM combine
in dcn32 and a release pipe interface to properly release pipe resources.

[how]
add two new interfaces in DCN specific resource file.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 21 +++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 81 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 10 +++
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 10 +++
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 12 +++
 5 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a2705771d790..20f9da625267 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1615,6 +1615,27 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 	return secondary_pipe;
 }
 
+int resource_find_free_pipe_used_as_sec_opp_head_by_cur_otg_master(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct pipe_ctx *cur_otg_master)
+{
+	const struct pipe_ctx *cur_sec_opp_head = cur_otg_master->next_odm_pipe;
+	struct pipe_ctx *new_pipe;
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
+
+	while (cur_sec_opp_head) {
+		new_pipe = &new_res_ctx->pipe_ctx[cur_sec_opp_head->pipe_idx];
+		if (resource_is_pipe_type(new_pipe, FREE_PIPE)) {
+			free_pipe_idx = cur_sec_opp_head->pipe_idx;
+			break;
+		}
+		cur_sec_opp_head = cur_sec_opp_head->next_odm_pipe;
+	}
+
+	return free_pipe_idx;
+}
+
 int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f9d601c8c721..072c5ba4c99c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2039,6 +2039,8 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
+	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
+	.release_pipe = dcn32_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
@@ -2669,6 +2671,33 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	return idle_pipe;
 }
 
+static int find_optimal_free_pipe_as_secondary_opp_head(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_otg_master)
+{
+	const struct pipe_ctx *cur_otg_master;
+	int free_pipe_idx;
+
+	cur_otg_master =  &cur_res_ctx->pipe_ctx[new_otg_master->pipe_idx];
+	free_pipe_idx = resource_find_free_pipe_used_as_sec_opp_head_by_cur_otg_master(
+			cur_res_ctx, new_res_ctx, cur_otg_master);
+
+	/* Up until here if we have not found a free secondary pipe, we will
+	 * need to wait for at least one frame to complete the transition
+	 * sequence.
+	 */
+	if (free_pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		free_pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
+				cur_res_ctx, new_res_ctx, pool);
+
+	if (free_pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		free_pipe_idx = resource_find_any_free_pipe(new_res_ctx, pool);
+
+	return free_pipe_idx;
+}
+
 struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
@@ -2706,6 +2735,58 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 	return free_pipe;
 }
 
+struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *otg_master)
+{
+	int free_pipe_idx = find_optimal_free_pipe_as_secondary_opp_head(
+			&cur_ctx->res_ctx, &new_ctx->res_ctx,
+			pool, otg_master);
+	struct pipe_ctx *free_pipe;
+
+	if (free_pipe_idx >= 0) {
+		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
+		free_pipe->pipe_idx = free_pipe_idx;
+		free_pipe->stream = otg_master->stream;
+		free_pipe->stream_res.tg = otg_master->stream_res.tg;
+		free_pipe->stream_res.dsc = NULL;
+		free_pipe->stream_res.opp = pool->opps[free_pipe_idx];
+		free_pipe->plane_res.mi = pool->mis[free_pipe_idx];
+		free_pipe->plane_res.hubp = pool->hubps[free_pipe_idx];
+		free_pipe->plane_res.ipp = pool->ipps[free_pipe_idx];
+		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
+		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
+		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
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
+void dcn32_release_pipe(struct dc_state *context,
+			struct pipe_ctx *pipe,
+			const struct resource_pool *pool)
+{
+	if (resource_is_pipe_type(pipe, OPP_HEAD) && pipe->stream_res.dsc)
+		dcn20_release_dsc(&context->res_ctx, pool, &pipe->stream_res.dsc);
+	memset(pipe, 0, sizeof(*pipe));
+}
+
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans)
 {
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 0c6ca3da66d9..4caebcaca031 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -142,6 +142,16 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe);
 
+struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *otg_master);
+
+void dcn32_release_pipe(struct dc_state *context,
+			struct pipe_ctx *pipe,
+			const struct resource_pool *pool);
+
 void dcn32_determine_det_override(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b55848480485..77457c9c46f3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -132,6 +132,16 @@ struct resource_funcs {
 			const struct resource_pool *pool,
 			const struct pipe_ctx *opp_head_pipe);
 
+	struct pipe_ctx *(*acquire_free_pipe_as_secondary_opp_head)(
+			const struct dc_state *cur_ctx,
+			struct dc_state *new_ctx,
+			const struct resource_pool *pool,
+			const struct pipe_ctx *otg_master);
+
+	void (*release_pipe)(struct dc_state *context,
+			struct pipe_ctx *pipe,
+			const struct resource_pool *pool);
+
 	enum dc_status (*validate_plane)(
 			const struct dc_plane_state *plane_state,
 			struct dc_caps *caps);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index e546b9c506c1..7a503d87fe9f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -280,6 +280,18 @@ bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
  */
 bool resource_is_for_mpcc_combine(const struct pipe_ctx *pipe_ctx);
 
+/*
+ * Look for a free pipe in new resource context that is used as a secondary OPP
+ * head by cur_otg_master.
+ *
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
+int resource_find_free_pipe_used_as_sec_opp_head_by_cur_otg_master(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct pipe_ctx *cur_otg_master);
+
 /*
  * Look for a free pipe in new resource context that is used as a secondary DPP
  * pipe in MPC blending tree associated with input OPP head pipe.
-- 
2.41.0

