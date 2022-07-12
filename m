Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D719C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8462E950B5;
	Tue, 12 Jul 2022 15:41:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59A2950CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7BDN23F/6WFTTwzIBSd1oCk+VAi3SmFCX/Yb5g0QTl11LDMmcr9AiRnWBNMvhWVorIkj1LMjzmhFxdU+mR6vX6K3F+fpSVxhUMWaotgy+XnO7siBteqQzUbfiPAZFzjJmPed0D7CKr96D/gYaz0GVpw6OSZGJtVVa4uDRFvpDnHYG456tADLkAhrqzbL5w9NavpT9ndT8vrmc/XPWDRwAtzMeh1FESXOxk8LktARIJGyDC/x2QYs4i0J28zGkpfQveItnYJYYrmFdTwhPeqRffmWHdcSnLvw9r6AQ2gd+0/1rYnaSaYssIJnPW9gIvnbQ+XlD7FDX1MwamoOsZwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EIpHH6SWFQKwuJFS297PtAnfw5Y6QJDCGJPLrU0i2U=;
 b=hHQ55XBb/5c8vSz4ig+y92+tP95ObcVd46WsCHc+4Vv3ap76/ZsNr6qZsqvqCDMkG/700joDc7ss8zR19nFVYHNNkdDqlZvGut3ZZdkF1fsm5zL9dtXTCDKK86Gb1cr4N7anufiebi5bZGjl5zVKdJUqgj6Xvh4HuWzNJMPv1DEeIqAMFERMwv2RASOoRMGsGNsD9ThUsO2AvLH8/qI5udC8oSc2ieqkNi3v/dB8k4SLMjR/mpB3el7NpGlrGgk1fYRcmI9ceBnn5OKBRRTjXsOJGp/SY0AapNnqobVuyqNjuQ2zBvyQuVkVPS8j6iDM3lR8mgt3qHjYRdk7iI3hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=bestguesspass action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EIpHH6SWFQKwuJFS297PtAnfw5Y6QJDCGJPLrU0i2U=;
 b=Vf7BNxuUWcpkFNwxNN3likN2qWvn/XNaRa/26+0Wl5iesj0/NaupXVDxeLaGT6Kaf0OR70zawaE6ZsHnoBsjjrKGGSj9mKhaGgkqzBYMO5Btvup+9v/2h9Vd6yPmUuei0FNSA66zk8wWMhrEHvbKj/3CPMUYt0/PecOnXWjb/0A=
Received: from BN7PR06CA0060.namprd06.prod.outlook.com (2603:10b6:408:34::37)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 12 Jul
 2022 15:41:31 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::2e) by BN7PR06CA0060.outlook.office365.com
 (2603:10b6:408:34::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:29 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:24 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: Fix lag when moving windowed MPO
 across display using ODM 2:1 combine
Date: Tue, 12 Jul 2022 23:41:11 +0800
Message-ID: <20220712154111.501566-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6661f85-1e5d-4ce6-ecc7-08da641cfd4a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60TZS8fQGnvArfVzd2JQWpBiBl3CdqQhma/jqsMpK06HAqtB+E0QAKQI8SVWiLsWjoUOtx3df56PEdHfIicvs5NNNi8r5a4cqclFmLRYEH9EjiMWvb1Qtt4evtISUIkRkJ4wrH9zaM5WspHfcAINgROx1zyJphETpMDnHy+VL93Q9IC2ssZfE2Q9uF419I5nW2+oxK4UHnD/C7F58mj19G9+aKAfjjb5ddqPPAP2V4BIIx/hCVUW2YABdw2/TJ48bY0QVQvcteewj0tvWrS7d0Qsn52/QtVMNR7y008l+SFj7YgrxGW8IYuok3q5BqPaHSSN4gifNIGr9+406QCbJH6bev5ETcq5d/OLNykbIwvAsrT2XsqxLJJNHzAhNYVkULPd9Q8jnMNc2+t+EpV4rVcejjr7RWRxoXtbM9WZcv4VPXMcqnZTbl7AAbhLFQVFIE3z+8u5Ov8Z85PNd/LExzhKmc5YqhKS4xXno+X5JtxHXPfBqHeLtiDN9ow+m6Pq2E6F2rH67gTJIp1wTvwlI0nbIZrWvhBdpJ4PM3CsC+npYnh3KvgTOaB/trp00mMRKoDtqqi/cC6sL8sA2XEiIo4tB4/O5bFIWVqBhuQtxskF+xiq/dZMG3htNBpWO985mT5E43AvPaT6albwxgL5him6zFA4u9GBeeiCDI7hcp54EkkqAKqcZKb/O2l/dd47UkdbfzPmWm2/S+9xlVdDX1IVRtUaWkTZng2TlJBMsgLggKttwhtar7qCWOnOnrhKfkrDaaQbqazYqBk+GyWC4Mu7T6aivrFciC9hcjU8vnsWVVw6+qK/cV5mkCcEvjeeBb2cjbndEOttHql0izyz20w3dL3pw1paJ6DGSDHs99g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(8676002)(47076005)(356005)(5660300002)(4326008)(16526019)(2906002)(70586007)(41300700001)(7696005)(26005)(82740400003)(70206006)(36860700001)(81166007)(6666004)(86362001)(186003)(83380400001)(8936002)(336012)(40460700003)(426003)(40480700001)(316002)(82310400005)(2616005)(478600001)(54906003)(36756003)(1076003)(44832011)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:29.6973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6661f85-1e5d-4ce6-ecc7-08da641cfd4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Ariel
 Bernstein <Eric.Bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
With single display odm 2:1 policy, when moving windowed MPO across
 the display, we experience a momentary lag when we move between the
 centre of the display and the right half of the display.  This is
 caused by the MPO pipe being reallocated when it crosses this
 boundary

[How]
Handle two cases:
1. if the head pipe has a MPO pipe already allocated in the old
 context, then use that pipe if it is available in the current
 context
2. if the head pipe is on the left side, check the right side to
 see if it has a MPO pipe already allocated.  If so, don't use
 that pipe if it is selected as the idle pipe in the current
 context
Add new function pointer called .acquire_idle_pipe_for_head_pipe
 that will pass in the head pipe and handle case 1
Add find_idle_secondary_pipe_check_mpo() to handle case 2
 if we don't hit case 1.

In dc_add_plane_to_context(), start with head pipe and check
 case 1 and 2 in call acquire_free_pipe_for_head().
If we are on the right side of the display, check case 1
 again by passing in right side pipe as the new head in
 call acquire_free_pipe_for_head().

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 32 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 27 ++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9db50ed5460b..2a701c583332 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1397,8 +1397,12 @@ static struct pipe_ctx *acquire_free_pipe_for_head(
 	 * to acquire an idle one to satisfy the request
 	 */
 
-	if (!pool->funcs->acquire_idle_pipe_for_layer)
-		return NULL;
+	if (!pool->funcs->acquire_idle_pipe_for_layer) {
+		if (!pool->funcs->acquire_idle_pipe_for_head_pipe_in_layer)
+			return NULL;
+		else
+			return pool->funcs->acquire_idle_pipe_for_head_pipe_in_layer(context, pool, head_pipe->stream, head_pipe);
+	}
 
 	return pool->funcs->acquire_idle_pipe_for_layer(context, pool, head_pipe->stream);
 }
@@ -1448,6 +1452,8 @@ bool dc_add_plane_to_context(
 	struct resource_pool *pool = dc->res_pool;
 	struct pipe_ctx *head_pipe, *tail_pipe, *free_pipe;
 	struct dc_stream_status *stream_status = NULL;
+	struct pipe_ctx *prev_right_head = NULL;
+	struct pipe_ctx *free_right_pipe = NULL;
 
 	DC_LOGGER_INIT(stream->ctx->logger);
 	for (i = 0; i < context->stream_count; i++)
@@ -1507,6 +1513,28 @@ bool dc_add_plane_to_context(
 						free_pipe->pipe_idx,
 						tail_pipe->next_odm_pipe ? tail_pipe->next_odm_pipe->pipe_idx : -1);
 
+				/*
+				 * We want to avoid the case where the right side already has a pipe assigned to
+				 *  it and is different from free_pipe ( which would cause trigger a pipe
+				 *  reallocation ).
+				 * Check the old context to see if the right side already has a pipe allocated
+				 * - If not, continue to use free_pipe
+				 * - If the right side already has a pipe, use that pipe instead if its available
+				 */
+				prev_right_head = &dc->current_state->res_ctx.pipe_ctx[tail_pipe->next_odm_pipe->pipe_idx];
+				if ((prev_right_head->bottom_pipe) && (free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
+					free_right_pipe = acquire_free_pipe_for_head(context, pool, tail_pipe->next_odm_pipe);
+					if (free_right_pipe) {
+						free_pipe->stream = NULL;
+						memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
+						memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
+						free_pipe->plane_state = NULL;
+						free_pipe->pipe_idx = 0;
+						free_right_pipe->plane_state = plane_state;
+						free_pipe = free_right_pipe;
+					}
+				}
+
 				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
 				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
 				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 2e158b1f5980..e4b4102b1538 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -143,11 +143,38 @@ struct resource_funcs {
 		struct dc *dc,
 		struct dc_state *context);
 
+	/*
+	 * Acquires a free pipe for the head pipe.
+	 * The head pipe is first pipe in the current context that matches the stream
+	 *  and does not have a top pipe or prev_odm_pipe.
+	 */
 	struct pipe_ctx *(*acquire_idle_pipe_for_layer)(
 			struct dc_state *context,
 			const struct resource_pool *pool,
 			struct dc_stream_state *stream);
 
+	/*
+	 * Acquires a free pipe for the head pipe with some additional checks for odm.
+	 * The head pipe is passed in as an argument unlike acquire_idle_pipe_for_layer
+	 *  where it is read from the context.  So this allows us look for different
+	 *  idle_pipe if the head_pipes are different ( ex. in odm 2:1 when we have
+	 *  a left and right pipe ).
+	 *
+	 * It also checks the old context to see if:
+	 *
+	 * 1. a pipe has already been allocated for the head pipe.  If so, it will
+	 *  try to select that pipe as the idle pipe if it is available in the current
+	 *  context.
+	 * 2. if the head_pipe is on the left, it will check if the right pipe has
+	 *  a pipe already allocated.  If so, it will not use that pipe if it is
+	 *  selected as the idle pipe.
+	 */
+	struct pipe_ctx *(*acquire_idle_pipe_for_head_pipe_in_layer)(
+			struct dc_state *context,
+			const struct resource_pool *pool,
+			struct dc_stream_state *stream,
+			struct pipe_ctx *head_pipe);
+
 	enum dc_status (*validate_plane)(const struct dc_plane_state *plane_state, struct dc_caps *caps);
 
 	enum dc_status (*add_stream_to_ctx)(
-- 
2.25.1

