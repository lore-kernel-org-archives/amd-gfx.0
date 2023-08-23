Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BADEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A241A10E461;
	Wed, 23 Aug 2023 16:04:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4376D10E461
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyHF1MF4D88O4lS5C+6CNyZQ7MaWRW+Is5c+QIDcCegSjCng90I6OiRO62JWN0jpQvWcMZidjMqhjATgSP6ufqTeaqMK/pOdihE6kmPOfGkJAGZyQFWw2aSkdWHUqMxHwSSbeDIiYcbPafyDrHcdP8vNakhsbMniiVENjIqyXJaq8t2V0u8k+bDmXLVbzr6pxNx+6CZwiNx1GZ1zWzsC4NZcQjflwfi1MGK17wJaPh7CTwrTBypZBAYV40/uYjhjaAbJ5CQyqStCn4Ie7CtG8SoouCu02g3vC9E2C8sNgy6MWEl9lVTQgEIMbk2LJigkZU3/ln7QQHW5NHqhuugaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSaSHe2H7TUWe6PhB/QIeVZ3tEEOuaBeKuwL4ZCRpD0=;
 b=hJqWaGffUQpDmOYIcxEAu1Of96w43Kf3YbpRT1/+9539ze4bzpvDHDV1PjOxtvvEHHw3IjRH4uLsFHBvwWewF1ax6vwclIrG5a4Q/1DhNSlDODZhJoyjtR1mIRgUoenNg6qDdQzJVs27g0xhCu5H2xIcA7lC7f7VfmFGGgbsORxzYVNqydzqlKZs9/Lkov/A5oFwxFIJFaV9r2vWrBNLv2eo5mZlGufMBVmfJQwXbBZw3MflwE1DsLjDGh+ul4lG0p5gMVy2JyDs3b6Fsa1/dQhezAn0qBUkdQdendwRIlss0FbfCsA0efDAWSgdKIboBFqGJpehZh5ZfCQ9lmb0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSaSHe2H7TUWe6PhB/QIeVZ3tEEOuaBeKuwL4ZCRpD0=;
 b=TP1BoeXh+Jwg1wkSyz3HSrocmMENM8WKtxcrg3eKg3yYDASAofH0gQ92KHIp8YkmeFCdqZ83weFLq+UJn5vmIWQiVy1mPAkYbw8BBrdgoblwuxwD0LaTbzKlTuj9bptXd6+Ji9otS6KRxEpe95fI2TTfeWEQbfw+MQL/jG2k2yw=
Received: from PR3P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::21)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 16:04:17 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10a6:102:52:cafe::d) by PR3P189CA0016.outlook.office365.com
 (2603:10a6:102:52::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:13 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:10 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] Partially revert "drm/amd/display: update add plane to
 context logic with a new algorithm"
Date: Wed, 23 Aug 2023 11:58:03 -0400
Message-ID: <20230823160347.176991-2-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: d3530af7-0100-45d7-5e2a-08dba3f29898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrrE9dnhyPVtIjGIyyBLgbPOucGVVeUpvNprJZ3/6+/bFMI7H35pGHWoybyvgcq0wfwHrncAvglUA8ZteOnrQ92klefj581MWqyfAc8jY0t3jTERzKSeLsmQi1/YAj3cVTLB09ucA0KXjrD5N8xpTWnLvh7MyuNENNA21hcWXjkB4uReGolwn2lxid7Ux/GK9UTwgQcfSdYoI/gQLq3uipkunNi2VnnOPNopomYeFT5RKIHGwKbm5nllb2VJRkHUWlJTGy+V4Cyjp6e3DbZxeOjAHp6j5RinQ/i185X+YB2UFyYWaA0Or7gVCoflUTazVMer7YilIiQ8/3HzSdyfANk/jgAviJIIwxC6Mkp3v1e6cnwrhq7JKr4991RRawLUtpaYzdPWyXnH4F8IGoCLoSpFxsPLNNraQFWaD7fMjEqju9vj4rbYfymfHS5FnzGh3+3yDgp7YHTuqCErx2/719CGCFekrQb8KMcm6Jz4+L1JsrkuEVzIM0sfkMAQGtuhiT0DEGUE6IlGwS2SsP+wDlKdAvkjbhhhLN7jGdw7EFKj64j5bKDcS0Q0eRcMG+dviNhXZFm6uL9HRzaS8AFXqCKHQskHlZrVqtwK9BemeNPW7lbTPD0tZiFG/eNxCuAqbx9lPWYPE0RxGqvcBkN9DPA7SZ1fOf3BBsGkyBNjhDJ6HcS5NX2jWaec/xJHC/3dytbBqIs7JACs3s/JdWpNf/PU4rSiAt7EdR0XoXE2nWlNW+ftgNHR4oqxThNwilwnq/IEGh0kfPrMGHeopX1TlN8425Lzd0tK1mncnb2j03pI7aveCJ3vGta31d5L0e/h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(15650500001)(40480700001)(83380400001)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(26005)(16526019)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:13.9967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3530af7-0100-45d7-5e2a-08dba3f29898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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
 qingqing.zhuo@amd.com, Martin Leung <martin.leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

This partially reverts commit e170066a4719 ("drm/amd/display: update add
plane to context logic with a new algorithm").

The new secondary pipe allocation logic triggers an issue with a
specific hardware state transition and causes a frame of corruption when
toggling between windowed MPO and ODM desktop only mode. Ideally hwss is
supposed to handle this scenario. We are temporarily reverting the logic
and investigate the root cause why this transition would cause
corruptions.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 118 +++++++++++++++++-
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 935cd23e6a01..f9d601c8c721 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2564,18 +2564,128 @@ static int find_optimal_free_pipe_as_secondary_dpp_pipe(
 	return free_pipe_idx;
 }
 
+static struct pipe_ctx *find_idle_secondary_pipe_check_mpo(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *primary_pipe)
+{
+	int i;
+	struct pipe_ctx *secondary_pipe = NULL;
+	struct pipe_ctx *next_odm_mpo_pipe = NULL;
+	int primary_index, preferred_pipe_idx;
+	struct pipe_ctx *old_primary_pipe = NULL;
+
+	/*
+	 * Modified from find_idle_secondary_pipe
+	 * With windowed MPO and ODM, we want to avoid the case where we want a
+	 *  free pipe for the left side but the free pipe is being used on the
+	 *  right side.
+	 * Add check on current_state if the primary_pipe is the left side,
+	 *  to check the right side ( primary_pipe->next_odm_pipe ) to see if
+	 *  it is using a pipe for MPO ( primary_pipe->next_odm_pipe->bottom_pipe )
+	 * - If so, then don't use this pipe
+	 * EXCEPTION - 3 plane ( 2 MPO plane ) case
+	 * - in this case, the primary pipe has already gotten a free pipe for the
+	 *  MPO window in the left
+	 * - when it tries to get a free pipe for the MPO window on the right,
+	 *  it will see that it is already assigned to the right side
+	 *  ( primary_pipe->next_odm_pipe ).  But in this case, we want this
+	 *  free pipe, since it will be for the right side.  So add an
+	 *  additional condition, that skipping the free pipe on the right only
+	 *  applies if the primary pipe has no bottom pipe currently assigned
+	 */
+	if (primary_pipe) {
+		primary_index = primary_pipe->pipe_idx;
+		old_primary_pipe = &primary_pipe->stream->ctx->dc->current_state->res_ctx.pipe_ctx[primary_index];
+		if ((old_primary_pipe->next_odm_pipe) && (old_primary_pipe->next_odm_pipe->bottom_pipe)
+			&& (!primary_pipe->bottom_pipe))
+			next_odm_mpo_pipe = old_primary_pipe->next_odm_pipe->bottom_pipe;
+
+		preferred_pipe_idx = (pool->pipe_count - 1) - primary_pipe->pipe_idx;
+		if ((res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) &&
+			!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == preferred_pipe_idx)) {
+			secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
+			secondary_pipe->pipe_idx = preferred_pipe_idx;
+		}
+	}
+
+	/*
+	 * search backwards for the second pipe to keep pipe
+	 * assignment more consistent
+	 */
+	if (!secondary_pipe)
+		for (i = pool->pipe_count - 1; i >= 0; i--) {
+			if ((res_ctx->pipe_ctx[i].stream == NULL) &&
+				!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == i)) {
+				secondary_pipe = &res_ctx->pipe_ctx[i];
+				secondary_pipe->pipe_idx = i;
+				break;
+			}
+		}
+
+	return secondary_pipe;
+}
+
+static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
+		struct dc_state *state,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream,
+		const struct pipe_ctx *head_pipe)
+{
+	struct resource_context *res_ctx = &state->res_ctx;
+	struct pipe_ctx *idle_pipe, *pipe;
+	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
+	int head_index;
+
+	if (!head_pipe)
+		ASSERT(0);
+
+	/*
+	 * Modified from dcn20_acquire_idle_pipe_for_layer
+	 * Check if head_pipe in old_context already has bottom_pipe allocated.
+	 * - If so, check if that pipe is available in the current context.
+	 * --  If so, reuse pipe from old_context
+	 */
+	head_index = head_pipe->pipe_idx;
+	pipe = &old_ctx->pipe_ctx[head_index];
+	if (pipe->bottom_pipe && res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx].stream == NULL) {
+		idle_pipe = &res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx];
+		idle_pipe->pipe_idx = pipe->bottom_pipe->pipe_idx;
+	} else {
+		idle_pipe = find_idle_secondary_pipe_check_mpo(res_ctx, pool, head_pipe);
+		if (!idle_pipe)
+			return NULL;
+	}
+
+	idle_pipe->stream = head_pipe->stream;
+	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
+	idle_pipe->stream_res.opp = head_pipe->stream_res.opp;
+
+	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
+
+	return idle_pipe;
+}
+
 struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe)
 {
-	int free_pipe_idx =
-			find_optimal_free_pipe_as_secondary_dpp_pipe(
-					&cur_ctx->res_ctx, &new_ctx->res_ctx,
-					pool, opp_head_pipe);
+
+	int free_pipe_idx;
 	struct pipe_ctx *free_pipe;
 
+	if (!opp_head_pipe->stream->ctx->dc->config.enable_windowed_mpo_odm)
+		return dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
+				new_ctx, pool, opp_head_pipe->stream, opp_head_pipe);
+
+	free_pipe_idx = find_optimal_free_pipe_as_secondary_dpp_pipe(
+					&cur_ctx->res_ctx, &new_ctx->res_ctx,
+					pool, opp_head_pipe);
 	if (free_pipe_idx >= 0) {
 		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
 		free_pipe->pipe_idx = free_pipe_idx;
-- 
2.41.0

