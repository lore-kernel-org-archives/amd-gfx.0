Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B008CC001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382B610E4C2;
	Wed,  2 Aug 2023 06:53:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA0A10E4BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4wbhrls4UNnjpzwA/cgofO/QbmPhwwVOzFN7nUBC6hdzYOhz/+4ecB1Sxdp9odzsEem4h1g6mvx/AYRCNgM0Hxq3YZ4lSR8e/BcHGpFMsP6mbcq4VfZyKUSLboN7mef5xTpCPxfnJQAmaLStNIULcYpOascTxGFaPlQ0KVT078OTSbx80N2NW5kF3T5jtvdqy4cPX9LDvpkHX1LWM3nBXJ7SNzIl+xAgnPZIC2uWwJd3nLbExrtdI5WsXBAc7lmgEZAbKWcJzHHwt53SiE5e+ZzL89xXO8f8TOtWgR09RRXW9jUCSEnP28i8nH0PKUOaitQO81ldsd9DqRmgHOFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq13LBwkdpuv+JtLPP/WGD5gnMvofZHyx/hakb/9Xp0=;
 b=Q8WvbMU6BwC3bOs8CoVrdUetOrbTkbff+zdBT1rnc6A7azNBVCgiQ/OCorai3/80dlktPUIWqXf/ZNf/AaG9bQGRCczzitDEMctUQXEiV97dYUJET/KUoKZIkclT0+oVmf2QJKUq0owuMKe6nz5MXa9ov1qZGjMkeyHv/E4q64N2wbm4CyNVQAxJ9DBXdvOj0eY34joBy4qPZ16kneeIymM1vWiS53vKsmVvyzQoVa1XC6a9KpCz5P50D+Gu70KA9VJ158B3Uh9gHY4HtIyVb3Cat9+I1Htugj/5WlN2/tkN9zGOazneeTchRM9SFYp1/FCVvT8pzyKYEHVd/lh5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq13LBwkdpuv+JtLPP/WGD5gnMvofZHyx/hakb/9Xp0=;
 b=gHrGhdqA7psVtVbkqL7qrnCDjkUPASApvzuLn9g65HMT1OA/uiVpKH3ud5nykrVdNloRAXHdKnlsJGTOcPNOzgKsSHfym2ti6CoEmqTRcnMJ0CzJIBscHu3RBM12LgYgKWpmCxeiLqtDnkKBVQy4XW0it5dgoo1B9GqczKVNY1E=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:33 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::a9) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:31 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: rename acquire_idle_pipe_for_layer to
 acquire_free_pipe_as_sec_dpp_pipe
Date: Wed, 2 Aug 2023 14:51:29 +0800
Message-ID: <20230802065132.3129932-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e6bd09-04db-4b10-da4b-08db93253032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzNle3cnWgYajh3dqgI4RUr2DAkyoWj40NGShEVtOCG0NIPx1m7poYwW6JLMDGWYbrc0T2cW+hCV9QoR3UGByi92t+r6Tom2ZIaSXXxlYrATYmrhQdysDlq6SPHxmFijqk+zREMF8tkVh+LLtMqG8ARl4odgyGIgnM2i6s7bIQKymErypIJPqhiNypijfeGpuzOSm3tyU8dqHHbjcp07WxrgfcUQis4VRgy6gF53Hu2/wYM5Y7mZzd8ZB8mR1Oz3JCRbrJz3qkBm1b0i0y2YCBZEd8DpMsnPW3mSOrT+IfTsKRqYjYogHkQuRMVbs4+1S4Wba6SDlcQTT9WfseLlTeuM9JK09SwyrBZx3U+0VkTbhX9TtwsqJJ13uWxW/XPwqXolMt+SxsAeBobi3Bs0kr4du6NYMXJ0sKX9jHVmaKnGm2s16gtlfaebe4vmTq4ZcjsymMHjT1NUwJ3Tdq5UDKc9D0lzLV0ZVVtAe5cX1zGLcOj4eR+oAWd6QNgBNkD50FAo/PBPrSRhDV3JEfHN+aXKi3caMnrkNTvU1oLKWB8O9g3qg/3TNk2Vt239ZbeXynd3kRfeh4x6bq1PZNh0G9JlJbqN0cS5E8gmUj735stxyyyrQ5bSYUqPjeI4iIG7tfcfd5tQars+6JcOIyRHLtxzd3wnIk/DaeojSSR6PXiH9pexkbx2shctSwI4qhDFbNRSpRyg4Hn8mqH7cYMxyWIuyCXysTj5stFsSAG3ABxASiAZc/NFaxeZDtqVZko66vwjSfqOGX4QW5eCbcEeFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(86362001)(47076005)(70586007)(70206006)(2616005)(426003)(40460700003)(7696005)(54906003)(81166007)(356005)(36756003)(186003)(26005)(1076003)(336012)(478600001)(82740400003)(36860700001)(41300700001)(2906002)(30864003)(8676002)(8936002)(5660300002)(83380400001)(316002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:33.3050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e6bd09-04db-4b10-da4b-08db93253032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Secondary DPP pipes are used for rendering secondary layers of planes.
The name "for layer" doesn't make it obvious. The function is acquiring
a free pipe as secondary dpp pipe only. We rename it so it is more obvious.
In a future follow up change, we want to add functions to acquire free pipe as
opp head pipe or otg master pipe as well. They will have their separate
allocation priority.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 40 +++++------
 .../amd/display/dc/dce110/dce110_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  2 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |  2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |  2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 70 +++++++++----------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 12 +---
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 12 ++--
 21 files changed, 85 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 103dfe82dc28..7561fe748c72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1563,7 +1563,7 @@ enum dc_status resource_build_scaling_params_for_context(
 	return DC_OK;
 }
 
-struct pipe_ctx *find_idle_secondary_pipe_legacy(
+struct pipe_ctx *find_free_secondary_pipe_legacy(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe)
@@ -1623,38 +1623,38 @@ struct pipe_ctx *find_idle_secondary_pipe_legacy(
 	return secondary_pipe;
 }
 
-int resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
+int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct pipe_ctx *cur_opp_head)
 {
 	const struct pipe_ctx *cur_sec_dpp = cur_opp_head->bottom_pipe;
 	struct pipe_ctx *new_sec_dpp;
-	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 
 	while (cur_sec_dpp) {
-		/* find an idle pipe used in current opp blend tree,
+		/* find a free pipe used in current opp blend tree,
 		 * this is to avoid MPO pipe switching to different opp blending
 		 * tree
 		 */
 		new_sec_dpp = &new_res_ctx->pipe_ctx[cur_sec_dpp->pipe_idx];
 		if (new_sec_dpp->plane_state == NULL &&
 				new_sec_dpp->stream == NULL) {
-			idle_pipe_idx = cur_sec_dpp->pipe_idx;
+			free_pipe_idx = cur_sec_dpp->pipe_idx;
 			break;
 		}
 		cur_sec_dpp = cur_sec_dpp->bottom_pipe;
 	}
 
-	return idle_pipe_idx;
+	return free_pipe_idx;
 }
 
-int recource_find_idle_pipe_not_used_in_cur_res_ctx(
+int recource_find_free_pipe_not_used_in_cur_res_ctx(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool)
 {
-	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
 	int i;
 
@@ -1666,20 +1666,20 @@ int recource_find_idle_pipe_not_used_in_cur_res_ctx(
 				cur_sec_dpp->stream == NULL &&
 				new_sec_dpp->plane_state == NULL &&
 				new_sec_dpp->stream == NULL) {
-			idle_pipe_idx = i;
+			free_pipe_idx = i;
 			break;
 		}
 	}
 
-	return idle_pipe_idx;
+	return free_pipe_idx;
 }
 
-int resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool)
 {
-	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
 	int i;
 
@@ -1692,18 +1692,18 @@ int resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 				cur_sec_dpp->top_pipe->plane_state == cur_sec_dpp->plane_state &&
 				new_sec_dpp->plane_state == NULL &&
 				new_sec_dpp->stream == NULL) {
-			idle_pipe_idx = i;
+			free_pipe_idx = i;
 			break;
 		}
 	}
 
-	return idle_pipe_idx;
+	return free_pipe_idx;
 }
 
-int resource_find_any_idle_pipe(struct resource_context *new_res_ctx,
+int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 		const struct resource_pool *pool)
 {
-	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_sec_dpp;
 	int i;
 
@@ -1712,12 +1712,12 @@ int resource_find_any_idle_pipe(struct resource_context *new_res_ctx,
 
 		if (new_sec_dpp->plane_state == NULL &&
 				new_sec_dpp->stream == NULL) {
-			idle_pipe_idx = i;
+			free_pipe_idx = i;
 			break;
 		}
 	}
 
-	return idle_pipe_idx;
+	return free_pipe_idx;
 }
 
 /* TODO: Unify the pipe naming convention:
@@ -1855,12 +1855,12 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 {
 	struct pipe_ctx *opp_head_pipe, *sec_pipe;
 
-	if (!pool->funcs->acquire_idle_pipe_for_layer)
+	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe)
 		return false;
 
 	opp_head_pipe = otg_master_pipe;
 	while (opp_head_pipe) {
-		sec_pipe = pool->funcs->acquire_idle_pipe_for_layer(
+		sec_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
 				cur_ctx,
 				new_ctx,
 				pool,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index b17134504944..c0214da714d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1235,7 +1235,7 @@ static const struct resource_funcs dce110_res_pool_funcs = {
 	.panel_cntl_create = dce110_panel_cntl_create,
 	.validate_bandwidth = dce110_validate_bandwidth,
 	.validate_plane = dce110_validate_plane,
-	.acquire_idle_pipe_for_layer = dce110_acquire_underlay,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dce110_acquire_underlay,
 	.add_stream_to_ctx = dce110_add_stream_to_ctx,
 	.validate_global = dce110_validate_global,
 	.find_first_free_match_stream_enc_for_link = dce110_find_first_free_match_stream_enc_for_link
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 292e71b99808..82e5af4d5d15 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1083,7 +1083,7 @@ static enum dc_status dcn10_add_stream_to_ctx(
 	return result;
 }
 
-static struct pipe_ctx *dcn10_acquire_idle_pipe_for_layer(
+static struct pipe_ctx *dcn10_acquire_free_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
@@ -1091,7 +1091,7 @@ static struct pipe_ctx *dcn10_acquire_idle_pipe_for_layer(
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe) {
 		ASSERT(0);
@@ -1272,7 +1272,7 @@ static const struct resource_funcs dcn10_res_pool_funcs = {
 	.link_enc_create = dcn10_link_encoder_create,
 	.panel_cntl_create = dcn10_panel_cntl_create,
 	.validate_bandwidth = dcn10_validate_bandwidth,
-	.acquire_idle_pipe_for_layer = dcn10_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn10_acquire_free_pipe_for_layer,
 	.validate_plane = dcn10_validate_plane,
 	.validate_global = dcn10_validate_global,
 	.add_stream_to_ctx = dcn10_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d526f06e8f1a..dfecb9602f49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2147,7 +2147,7 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	return voltage_supported;
 }
 
-struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
+struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
@@ -2155,7 +2155,7 @@ struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe)
 		ASSERT(0);
@@ -2217,7 +2217,7 @@ static const struct resource_funcs dcn20_res_pool_funcs = {
 	.link_enc_create = dcn20_link_encoder_create,
 	.panel_cntl_create = dcn20_panel_cntl_create,
 	.validate_bandwidth = dcn20_validate_bandwidth,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 67a78ea2c0e4..6d1a8924e57b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -58,7 +58,7 @@ unsigned int dcn20_calc_max_scaled_time(
 		enum mmhubbub_wbif_mode mode,
 		unsigned int urgent_watermark);
 
-struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
+struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 1a8927e9b64b..4fce3485d0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -992,7 +992,7 @@ static struct hubp *dcn201_hubp_create(
 	return NULL;
 }
 
-static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
+static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
@@ -1000,7 +1000,7 @@ static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe)
 		ASSERT(0);
@@ -1068,7 +1068,7 @@ static struct resource_funcs dcn201_res_pool_funcs = {
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = NULL,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.acquire_idle_pipe_for_layer = dcn201_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn201_acquire_free_pipe_for_layer,
 	.populate_dml_writeback_from_context = dcn201_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 82dfcf773b1a..0b00cb9db2d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1387,7 +1387,7 @@ static const struct resource_funcs dcn21_res_pool_funcs = {
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn21_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f5bfcd2a0dbc..13fc1118a001 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2214,7 +2214,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index f856a4773c27..79d6697d13b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1379,7 +1379,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn301_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 5ad6a22ee47d..8ce2b2c24e76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1135,7 +1135,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
-		.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+		.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 131b8b82afc0..953661bebca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1061,7 +1061,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
-		.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+		.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fc33b5fcabe1..33842e3eaa2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1818,7 +1818,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn31_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 9b8e0f6f32b4..2416175a0f34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1765,7 +1765,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn314_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 2e3fa0fb8bd4..f0a81bcea273 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1817,7 +1817,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn315_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn315_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 707cf28bbceb..4f3cd7b17457 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1704,7 +1704,7 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn316_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2615a89d580b..cadbe1dcfbfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2038,7 +2038,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn32_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
@@ -2486,10 +2486,10 @@ struct resource_pool *dcn32_create_resource_pool(
 }
 
 /*
- * Find the most optimal idle pipe from res_ctx, which could be used as a
+ * Find the most optimal free pipe from res_ctx, which could be used as a
  * secondary dpp pipe for input opp head pipe.
  *
- * an idle pipe - a pipe in input res_ctx not yet used for any streams or
+ * a free pipe - a pipe in input res_ctx not yet used for any streams or
  * planes.
  * secondary dpp pipe - a pipe gets inserted to a head OPP pipe's MPC blending
  * tree. This is typical used for rendering MPO planes or additional offset
@@ -2522,78 +2522,78 @@ struct resource_pool *dcn32_create_resource_pool(
  *
  * 2. We want to in general minimize the unnecessary changes in pipe topology.
  * If a pipe is already added in current blending tree and there are no changes
- * to plane topology, we don't want to swap it with another idle pipe
+ * to plane topology, we don't want to swap it with another free pipe
  * unnecessarily in every update. Powering up and down a pipe would require a
  * full update which delays the flip for 1 frame. If we use the original pipe
  * we don't have to toggle its power. So we can flip faster.
  */
-static int find_optimal_idle_pipe_as_secondary_dpp_pipe(
+static int find_optimal_free_pipe_as_secondary_dpp_pipe(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *new_opp_head)
 {
 	const struct pipe_ctx *cur_opp_head;
-	int idle_pipe_idx;
+	int free_pipe_idx;
 
 	cur_opp_head = &cur_res_ctx->pipe_ctx[new_opp_head->pipe_idx];
-	idle_pipe_idx = resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
+	free_pipe_idx = resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 			cur_res_ctx, new_res_ctx, cur_opp_head);
 
-	/* Up until here if we have not found an idle secondary pipe, we will
+	/* Up until here if we have not found a free secondary pipe, we will
 	 * need to wait for at least one frame to complete the transition
 	 * sequence.
 	 */
-	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
-		idle_pipe_idx = recource_find_idle_pipe_not_used_in_cur_res_ctx(
+	if (free_pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		free_pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
 				cur_res_ctx, new_res_ctx, pool);
 
-	/* Up until here if we have not found an idle secondary pipe, we will
+	/* Up until here if we have not found a free secondary pipe, we will
 	 * need to wait for at least two frames to complete the transition
 	 * sequence. It really doesn't matter which pipe we decide take from
 	 * current enabled pipes. It won't save our frame time when we swap only
 	 * one pipe or more pipes.
 	 */
-	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
-		idle_pipe_idx = resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+	if (free_pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		free_pipe_idx = resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 				cur_res_ctx, new_res_ctx, pool);
 
-	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
-		idle_pipe_idx = resource_find_any_idle_pipe(new_res_ctx, pool);
+	if (free_pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		free_pipe_idx = resource_find_any_free_pipe(new_res_ctx, pool);
 
-	return idle_pipe_idx;
+	return free_pipe_idx;
 }
 
-struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
+struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe)
 {
-	int idle_pipe_idx =
-			find_optimal_idle_pipe_as_secondary_dpp_pipe(
+	int free_pipe_idx =
+			find_optimal_free_pipe_as_secondary_dpp_pipe(
 					&cur_ctx->res_ctx, &new_ctx->res_ctx,
 					pool, opp_head_pipe);
-	struct pipe_ctx *idle_pipe;
-
-	if (idle_pipe_idx >= 0) {
-		idle_pipe = &new_ctx->res_ctx.pipe_ctx[idle_pipe_idx];
-		idle_pipe->pipe_idx = idle_pipe_idx;
-		idle_pipe->stream = opp_head_pipe->stream;
-		idle_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
-		idle_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
-
-		idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
-		idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
-		idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
-		idle_pipe->plane_res.mpcc_inst =
-				pool->dpps[idle_pipe->pipe_idx]->inst;
+	struct pipe_ctx *free_pipe;
+
+	if (free_pipe_idx >= 0) {
+		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
+		free_pipe->pipe_idx = free_pipe_idx;
+		free_pipe->stream = opp_head_pipe->stream;
+		free_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
+		free_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
+
+		free_pipe->plane_res.hubp = pool->hubps[free_pipe->pipe_idx];
+		free_pipe->plane_res.ipp = pool->ipps[free_pipe->pipe_idx];
+		free_pipe->plane_res.dpp = pool->dpps[free_pipe->pipe_idx];
+		free_pipe->plane_res.mpcc_inst =
+				pool->dpps[free_pipe->pipe_idx]->inst;
 	} else {
 		ASSERT(opp_head_pipe);
-		idle_pipe = NULL;
+		free_pipe = NULL;
 	}
 
-	return idle_pipe;
+	return free_pipe;
 }
 
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 165754ed5f49..103a2b54d025 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -136,7 +136,7 @@ bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
 bool dcn32_is_center_timing(struct pipe_ctx *pipe);
 bool dcn32_is_psr_capable(struct pipe_ctx *pipe);
 
-struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
+struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index c2fd841d4c0b..8d73cceb485b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1588,7 +1588,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn32_acquire_idle_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 8377a0b58ec3..794d6517e511 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1258,7 +1258,7 @@ bool dcn_validate_bandwidth(
 						hsplit_pipe->pipe_dlg_param.vblank_end = pipe->pipe_dlg_param.vblank_end;
 					} else {
 						/* pipe not split previously needs split */
-						hsplit_pipe = find_idle_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
+						hsplit_pipe = find_free_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
 						ASSERT(hsplit_pipe);
 						split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pipe);
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b821e27867b7..b161beab7678 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -125,17 +125,7 @@ struct resource_funcs {
 		struct dc *dc,
 		struct dc_state *context);
 
-	/*
-	 * Acquire an idle pipe from context, which could be used as a secondary
-	 * pipe for the otg master pipe associated with the input stream.
-	 *
-	 * an idle pipe - a pipe not yet used for any streams or
-	 * planes.
-	 * secondary pipe - a pipe gets inserted to a head OPP pipe's blending
-	 * tree. This is typical used for rendering MPO planes or additional
-	 * offset areas in MPCC combine.
-	 */
-	struct pipe_ctx *(*acquire_idle_pipe_for_layer)(
+	struct pipe_ctx *(*acquire_free_pipe_as_secondary_dpp_pipe)(
 			const struct dc_state *cur_ctx,
 			struct dc_state *new_ctx,
 			const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c518ee8b1a03..8dabbbc2a7b9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -37,7 +37,7 @@
 #define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
 #define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
 #define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
-#define IDLE_PIPE_INDEX_NOT_FOUND -1
+#define FREE_PIPE_INDEX_NOT_FOUND -1
 
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
@@ -154,27 +154,27 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
-struct pipe_ctx *find_idle_secondary_pipe_legacy(
+struct pipe_ctx *find_free_secondary_pipe_legacy(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe);
 
-int resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
+int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct pipe_ctx *cur_opp_head);
 
-int recource_find_idle_pipe_not_used_in_cur_res_ctx(
+int recource_find_free_pipe_not_used_in_cur_res_ctx(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
-int resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
-int resource_find_any_idle_pipe(struct resource_context *new_res_ctx,
+int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
 bool resource_validate_attach_surfaces(
-- 
2.25.1

