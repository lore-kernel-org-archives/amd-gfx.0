Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DC5CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9D310E427;
	Wed, 20 Sep 2023 03:18:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8118910E428
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAWWjUj7olaJelZqLcE+LWPhLbok3WWMa+EBephbHjJLXMWqv2bGPQfBmf/sGvgNKE+LkLrGEG4y9hOEVRSoaBUPAmvg7XiavunsO9dw0LRnt0pC4IsRu13LYbyGTyudCuSyebaNsCjnegxyMobu/u8ZkpXpXjKHpVMVLcqOP1tm70y3bHUHCVylAuy4S13Pv+5jMYvubTvxrdWUZxdBUJqelHRjuNhKOxuwdAVLYfsXcvU1Xy1irLeQHBbfE9T5c2s8u27SPstMMoFzNtnCg+ZOaQ5ablzgwe0ob63xyoQud1d3KJkt6n2iXR9ZWctBm5s0r8RhdnW4LEmnyDOHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEShJATqFTLxs/vni8zsOiqB5XNeNdPAoBNRmWpwXgw=;
 b=NkyKuM+yuA3/twzUPxXHlp3Bq+FERRO+a1ZOLHcoBttFP1iixYE4pjb3Wc+XUwy7TR17v+NLzkH9bUx6gNKZ0RmYz3LjlwZUbHuJUe+hO11qQhcs3U0yFUDcSPFtB3L04PZCsf70R4k9mXYKZGC1qxIPGWQX0LZcKa7QE40pKrFuFlj6Z6Y/q0js/Ei5b4M/jHHcyksUYnRkVyy5mBiqeuqiwVhl/4K64fcqdRhshH8fJ78nFLLzsaJqByE23lv6C2hvu+aewXnqoIOIBZhF8Lq99ssCKe3e2vpj3G++0y8zGOm4Ulzk8WqhNW947Fh2iFtt34LlHgcDscMBdTX42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEShJATqFTLxs/vni8zsOiqB5XNeNdPAoBNRmWpwXgw=;
 b=GbKcgl1cKHJ10iXTAeqgVH6mitufGt81m5YWEALnXyqE9fZ1MlhcNPL9Dd/Me5/K8Ibk+fPLV4xaQsRyHffkwvhXpGXG7krpOi7UOl/KR4/ph75acLaqjAK6G3H31qbzK7upsuf9Uyi01oYoC4uyRrjCUu9IgFafBI2uRuVf9Us=
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Wed, 20 Sep 2023 03:18:34 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::50) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 03:18:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:18:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:18:12 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:18:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: add new windowed mpo odm minimal
 transition sequence
Date: Wed, 20 Sep 2023 11:16:09 +0800
Message-ID: <20230920031624.3129206-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f16fb-6977-4a1f-0ced-08dbb98845c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgNOIXiCbAXacBHZ9qdhYSADrJPd+jbQO4GTzRqiq2/wL+Vjwp+3FU90xxsABYHbXiCHt1DTiWdm0JG+Sn+9LRm56FLC3hFSP3bshgXrTf1ffehGRveqk1n6RlzwUEQoxwrVTpwV4kycvRm3zsYRiSVh2zj/OLDQjOgSpOM6jQ7CA0UVO5d2IZBLv+8CtEmtXAhe5JUu4+It9NygWnYVpS8eHxahxv9nQ/lpltVH/eiKuNIh4zvEnCvEPMWDA+z1Jw8rQa7jlqCGiXOlKQ5bL46tTdwgBlco8Pu1bc1BHJ4lxc630iLyiAftEoXhSFxyUog2ys++P7fCcFzWvSrUfBbJDzUpCPbXlCEXKf2OxLnr9qb+wnWToJ2bQMO3YerOncOfTi/kjlFKXmtqU3xXL83DzbEFHvjbToMbQmOVOmw5qrv3V2/+RHgMzycF3JhqODItUy2koAe5QoTdcNMmPxiOYL+lklr03hczlia6UGCrwXLtwPWDCc+Bp3giekzT+Yoa6WWFGuFfMyPw6vrggvo5VK0tDcPX2lrwqQR71fdQ+JvBXllRcdzV7DarYtmB+IEPgoKHiNSB/yo1ZQuYhfw7NTq5LH+jL/3AN1UWzu2aQu0GcOa7tQY2+ipmqn2lX0fs231rYGTBn/nGSZlH6e9iNlCmUYoRy5XrNKPji/AT3cR2kbw+kKxda1+LUn7j0fcWYRdnsOwfXcsy30fhkXoU6dgoI0h4kgPfN3mt55T7OlrpfDzJZ5V7COg50lsLBsl7/9RFd8TRnot2y7wJHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(26005)(1076003)(40480700001)(426003)(336012)(54906003)(41300700001)(316002)(6916009)(70206006)(70586007)(30864003)(478600001)(8936002)(8676002)(4326008)(7696005)(40460700003)(36756003)(2616005)(36860700001)(47076005)(356005)(81166007)(86362001)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:18:33.9377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f16fb-6977-4a1f-0ced-08dbb98845c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We do not have a programming sequence to support seamless transition
between MPC combine to ODM combine when plane count remains the same.
This can happen with windowed MPO ODM use cases when plane scaling
is changed over ODM Combine's capability.

[How]
We are adding a programming sequence specifically to handle the transition
between MPC combine and ODM combine during plane scaling change.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 252 ++++++++++++++----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 2 files changed, 207 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 195ea6286c33..e2dcb836a0f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2965,6 +2965,34 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 }
 
+static void backup_plane_states_for_stream(
+		struct dc_plane_state plane_states[MAX_SURFACE_NUM],
+		struct dc_stream_state *stream)
+{
+	int i;
+	struct dc_stream_status *status = dc_stream_get_status(stream);
+
+	if (!status)
+		return;
+
+	for (i = 0; i < status->plane_count; i++)
+		plane_states[i] = *status->plane_states[i];
+}
+
+static void restore_plane_states_for_stream(
+		struct dc_plane_state plane_states[MAX_SURFACE_NUM],
+		struct dc_stream_state *stream)
+{
+	int i;
+	struct dc_stream_status *status = dc_stream_get_status(stream);
+
+	if (!status)
+		return;
+
+	for (i = 0; i < status->plane_count; i++)
+		*status->plane_states[i] = plane_states[i];
+}
+
 static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -2988,7 +3016,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	context = dc->current_state;
-
+	backup_plane_states_for_stream(dc->current_state->scratch.plane_states, stream);
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
 
@@ -3095,6 +3123,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	*new_context = context;
 	*new_update_type = update_type;
+	backup_plane_states_for_stream(context->scratch.plane_states, stream);
 
 	return true;
 
@@ -3986,6 +4015,107 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 	return force_minimal_pipe_splitting;
 }
 
+struct pipe_split_policy_backup {
+	bool dynamic_odm_policy;
+	bool subvp_policy;
+	enum pipe_split_policy mpc_policy;
+};
+
+static void release_minimal_transition_state(struct dc *dc,
+		struct dc_state *context, struct pipe_split_policy_backup *policy)
+{
+	dc_release_state(context);
+	/* restore previous pipe split and odm policy */
+	if (!dc->config.is_vmin_only_asic)
+		dc->debug.pipe_split_policy = policy->mpc_policy;
+	dc->debug.enable_single_display_2to1_odm_policy = policy->dynamic_odm_policy;
+	dc->debug.force_disable_subvp = policy->subvp_policy;
+}
+
+static struct dc_state *create_minimal_transition_state(struct dc *dc,
+		struct dc_state *base_context, struct pipe_split_policy_backup *policy)
+{
+	struct dc_state *minimal_transition_context = dc_create_state(dc);
+	unsigned int i, j;
+
+	if (!dc->config.is_vmin_only_asic) {
+		policy->mpc_policy = dc->debug.pipe_split_policy;
+		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	}
+	policy->dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
+	dc->debug.enable_single_display_2to1_odm_policy = false;
+	policy->subvp_policy = dc->debug.force_disable_subvp;
+	dc->debug.force_disable_subvp = true;
+
+	dc_resource_state_copy_construct(base_context, minimal_transition_context);
+
+	/* commit minimal state */
+	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false)) {
+		for (i = 0; i < minimal_transition_context->stream_count; i++) {
+			struct dc_stream_status *stream_status = &minimal_transition_context->stream_status[i];
+
+			for (j = 0; j < stream_status->plane_count; j++) {
+				struct dc_plane_state *plane_state = stream_status->plane_states[j];
+
+				/* force vsync flip when reconfiguring pipes to prevent underflow
+				 * and corruption
+				 */
+				plane_state->flip_immediate = false;
+			}
+		}
+	} else {
+		/* this should never happen */
+		release_minimal_transition_state(dc, minimal_transition_context, policy);
+		BREAK_TO_DEBUGGER();
+		minimal_transition_context = NULL;
+	}
+	return minimal_transition_context;
+}
+
+static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
+		struct dc_state *context,
+		struct dc_stream_state *stream)
+{
+	bool success = false;
+	struct dc_state *minimal_transition_context;
+	struct pipe_split_policy_backup policy;
+
+	/* commit based on new context */
+	minimal_transition_context = create_minimal_transition_state(dc,
+			context, &policy);
+	if (minimal_transition_context) {
+		if (dc->hwss.is_pipe_topology_transition_seamless(
+					dc, dc->current_state, minimal_transition_context) &&
+			dc->hwss.is_pipe_topology_transition_seamless(
+					dc, minimal_transition_context, context)) {
+			DC_LOG_DC("%s base = new state\n", __func__);
+			success = dc_commit_state_no_check(dc, minimal_transition_context) == DC_OK;
+		}
+		release_minimal_transition_state(dc, minimal_transition_context, &policy);
+	}
+
+	if (!success) {
+		/* commit based on current context */
+		restore_plane_states_for_stream(dc->current_state->scratch.plane_states, stream);
+		minimal_transition_context = create_minimal_transition_state(dc,
+				dc->current_state, &policy);
+		if (minimal_transition_context) {
+			if (dc->hwss.is_pipe_topology_transition_seamless(
+					dc, dc->current_state, minimal_transition_context) &&
+				dc->hwss.is_pipe_topology_transition_seamless(
+						dc, minimal_transition_context, context)) {
+				DC_LOG_DC("%s base = current state\n", __func__);
+				success = dc_commit_state_no_check(dc, minimal_transition_context) == DC_OK;
+			}
+			release_minimal_transition_state(dc, minimal_transition_context, &policy);
+		}
+		restore_plane_states_for_stream(context->scratch.plane_states, stream);
+	}
+
+	ASSERT(success);
+	return success;
+}
+
 /**
  * commit_minimal_transition_state - Create a transition pipe split state
  *
@@ -4007,23 +4137,14 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
-	struct dc_state *transition_context = dc_create_state(dc);
-	enum pipe_split_policy tmp_mpc_policy = 0;
-	bool temp_dynamic_odm_policy = 0;
-	bool temp_subvp_policy = 0;
+	struct dc_state *transition_context;
+	struct pipe_split_policy_backup policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
 	bool subvp_in_use = false;
 	bool odm_in_use = false;
 
-	if (!transition_context)
-		return false;
-	/* Setup:
-	 * Store the current ODM and MPC config in some temp variables to be
-	 * restored after we commit the transition state.
-	 */
-
 	/* check current pipes in use*/
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &transition_base_context->res_ctx.pipe_ctx[i];
@@ -4064,10 +4185,8 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use) {
-		dc_release_state(transition_context);
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use)
 		return true;
-	}
 
 	DC_LOG_DC("%s base = %s state, reason = %s\n", __func__,
 			dc->current_state == transition_base_context ? "current" : "new",
@@ -4076,49 +4195,13 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID ? "MPC in Use" :
 			"Unknown");
 
-	if (!dc->config.is_vmin_only_asic) {
-		tmp_mpc_policy = dc->debug.pipe_split_policy;
-		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-	}
-
-	temp_dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
-	dc->debug.enable_single_display_2to1_odm_policy = false;
-
-	temp_subvp_policy = dc->debug.force_disable_subvp;
-	dc->debug.force_disable_subvp = true;
-
-	dc_resource_state_copy_construct(transition_base_context, transition_context);
-
-	/* commit minimal state */
-	if (dc->res_pool->funcs->validate_bandwidth(dc, transition_context, false)) {
-		for (i = 0; i < transition_context->stream_count; i++) {
-			struct dc_stream_status *stream_status = &transition_context->stream_status[i];
-
-			for (j = 0; j < stream_status->plane_count; j++) {
-				struct dc_plane_state *plane_state = stream_status->plane_states[j];
-
-				/* force vsync flip when reconfiguring pipes to prevent underflow
-				 * and corruption
-				 */
-				plane_state->flip_immediate = false;
-			}
-		}
-
+	transition_context = create_minimal_transition_state(dc,
+			transition_base_context, &policy);
+	if (transition_context) {
 		ret = dc_commit_state_no_check(dc, transition_context);
+		release_minimal_transition_state(dc, transition_context, &policy);
 	}
 
-	/* always release as dc_commit_state_no_check retains in good case */
-	dc_release_state(transition_context);
-
-	/* TearDown:
-	 * Restore original configuration for ODM and MPO.
-	 */
-	if (!dc->config.is_vmin_only_asic)
-		dc->debug.pipe_split_policy = tmp_mpc_policy;
-
-	dc->debug.enable_single_display_2to1_odm_policy = temp_dynamic_odm_policy;
-	dc->debug.force_disable_subvp = temp_subvp_policy;
-
 	if (ret != DC_OK) {
 		/* this should never happen */
 		BREAK_TO_DEBUGGER();
@@ -4290,6 +4373,51 @@ static bool fast_update_only(struct dc *dc,
 			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
 }
 
+static bool should_commit_minimal_transition_for_windowed_mpo_odm(struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_state *context)
+{
+	struct pipe_ctx *cur_pipe, *new_pipe;
+	bool cur_is_odm_in_use, new_is_odm_in_use;
+	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
+	struct dc_stream_status *new_stream_status = stream_get_status(context, stream);
+
+	if (!dc->debug.enable_single_display_2to1_odm_policy ||
+			!dc->config.enable_windowed_mpo_odm)
+		/* skip the check if windowed MPO ODM or dynamic ODM is turned
+		 * off.
+		 */
+		return false;
+
+	if (context == dc->current_state)
+		/* skip the check for fast update */
+		return false;
+
+	if (new_stream_status->plane_count != cur_stream_status->plane_count)
+		/* plane count changed, not a plane scaling update so not the
+		 * case we are looking for
+		 */
+		return false;
+
+	cur_pipe = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, stream);
+	new_pipe = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+	cur_is_odm_in_use = resource_get_odm_slice_count(cur_pipe) > 1;
+	new_is_odm_in_use = resource_get_odm_slice_count(new_pipe) > 1;
+	if (cur_is_odm_in_use == new_is_odm_in_use)
+		/* ODM state isn't changed, not the case we are looking for */
+		return false;
+
+	if (dc->hwss.is_pipe_topology_transition_seamless &&
+			dc->hwss.is_pipe_topology_transition_seamless(
+					dc, dc->current_state, context))
+		/* transition can be achieved without the need for committing
+		 * minimal transition state first
+		 */
+		return false;
+
+	return true;
+}
+
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -4362,6 +4490,19 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		update_type = UPDATE_TYPE_FULL;
 	}
 
+	/* when windowed MPO ODM is supported, we need to handle a special case
+	 * where we can transition between ODM combine and MPC combine due to
+	 * plane scaling update. This transition will require us to commit
+	 * minimal transition state. The condition to trigger this update can't
+	 * be predicted by could_mpcc_tree_change_for_active_pipes because we
+	 * can only determine it after DML validation. Therefore we can't rely
+	 * on the existing commit minimal transition state sequence. Instead
+	 * we have to add additional handling here to handle this transition
+	 * with its own special sequence.
+	 */
+	if (should_commit_minimal_transition_for_windowed_mpo_odm(dc, stream, context))
+		commit_minimal_transition_state_for_windowed_mpo_odm(dc,
+				context, stream);
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
@@ -4376,7 +4517,6 @@ bool dc_update_planes_and_stream(struct dc *dc,
 				dc->hwss.is_pipe_topology_transition_seamless &&
 				!dc->hwss.is_pipe_topology_transition_seamless(
 						dc, dc->current_state, context)) {
-
 			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
 			BREAK_TO_DEBUGGER();
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9f41e8d15065..c095ccbb80c4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -563,6 +563,17 @@ struct dc_state {
 	struct {
 		unsigned int stutter_period_us;
 	} perf_params;
+
+	struct {
+		/* used to temporarily backup plane states of a stream during
+		 * dc update. The reason is that plane states are overwritten
+		 * with surface updates in dc update. Once they are overwritten
+		 * current state is no longer valid. We want to temporarily
+		 * store current value in plane states so we can still recover
+		 * a valid current state during dc update.
+		 */
+		struct dc_plane_state plane_states[MAX_SURFACE_NUM];
+	} scratch;
 };
 
 struct replay_context {
-- 
2.37.3

