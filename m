Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB18C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B3010E629;
	Wed, 28 Feb 2024 18:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y7RPvOwA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2889110E629
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOL+rGMoKLWJG0UimsXBD9P6/3FBzrI7rFX3Jgv89ykmWhciMGQ3IYrO4JrW4a0GD3mmgZBxJGJnLq1nDIfXbysAoL4ajpZZtC2xaDaOwNnMDU51+y7g91LzBkQ/3aPmLlAxFYQY7IMPiRf29IckY1NNOo0yI5goiZ4Z2RyE0FGuCeTXJdXjKW0a03JmvhVBR3mWgjgF0yt/llEUVjuNhIt/PZo8XAYufKoMOvTO+ovX42hz7d2NLEuZjW+XGv3/eK8gLcmV0ZaFDls11RDms/60MS7zXdlM5CXDdjpCoV5BTSG0I4ZTIB+BhBeXk0AiDUKn3hToeV6ydgWtElcJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb5bO7xlhJixWfI793b/P+mNpUnrOvnWs06H7qpdUl0=;
 b=lonYbSZ1NluWWJ9oL1yRxwRsnpn0KFUgTx1Borv161Ua3OQAQZa5sb5kuPZaQMAYoWBbfBX6VH1vrzLMaf8wO79VWR6QePkOnih59fB7Frs+k/TMvxLDTK7FI2RqjFHmUlh6TprruDkBTlTE/dKtLid9WD+HwuYyTQ/loQspy1FghjJr05eIDHaxLj6yQJc8HQlOxXurZTr6G5OaMhm3GyPSbI6tWhneSGbV9U6DqP6w0544klNcjuDAep2gaC9Bn1yGOWhx/iDsu0va5Uisu2jsstD0Q9sYvyAfFoNbVAw6pct7zVg9MolMBoDjAnuym0mfK7joz+Y9dm1EgU0nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb5bO7xlhJixWfI793b/P+mNpUnrOvnWs06H7qpdUl0=;
 b=y7RPvOwAsYaM0aMqTZyhduBMTY/PJLYzaBdW85aPJH/gjaWKikf94vPG0XpgHKmiCoERVHC0rztyMQM47vh85yFp62HnWkYKRpT6FKXQkbLEUfUclrgIYnM84ouyYh1tysRX8BXs0af+DbGydMHcGUlV3jMmiyfEl0blcuaKgmY=
Received: from PH8PR21CA0014.namprd21.prod.outlook.com (2603:10b6:510:2ce::28)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:46:39 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d) by PH8PR21CA0014.outlook.office365.com
 (2603:10b6:510:2ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Wed, 28 Feb 2024 18:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:46:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:46:36 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 26/34] drm/amd/display: Implement update_planes_and_stream_v3
 sequence
Date: Wed, 28 Feb 2024 11:39:32 -0700
Message-ID: <20240228183940.1883742-27-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bb9825-8c27-4613-46c4-08dc388d9926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYtKhS7KJc1/cYcQLetfahj1QIU7dE+Li+aqXM8HPCL8zcPqAYzdWhwTlvalu0nFarUezyl4WvSpbJQ5XeYXD0BU0urSrA1eL9NlMu1yCYQYJLT1PznOX09iX6EPrZE+1II9dYnBc9m0K6EAHb9V1LNuF6BfsmRzMQEkTUm7GzSO4puMVjxFQAPW/hL4geJ5rZS6B/AsIYdiCCsnEhPSmHd18LVKeCBzGBD0S258vAXwSFWxmHAbBycS+XaYlx65dtnkVVQEmPLQ0MSjxMMpsG6eH8lAbK5kPyfDqj9J7qKE1JT3b5U1jfenoQnjsWeXlEhORab0ARFoQ91Ku+2RBb0hBV0SjJbbwsJxHp0Bxg+++6/63EUc6qR5eRewPwUDlPg00lAr0soQVpZRc+pDdUJcJ0lhA4nct8eTeKGAfbDnfO/ljVWfSHbd7lXng52/lEKRrOjg4yUxcLlQbOnluI4ihh69FBtISR5sQ3Hk0/WYpDDnLvp1A06C5VUUBw4zKtqVTdRMos96cya+5b5u9sn4qVqDs2OV8gAKabSMZbhtIQgzXYaA1dIGPTJZNRn1ePp9Mz1iNGZY6jK/YL5H0PcW03BTVyhVP/4twtiVsjG+Z4575Enct9Q6hPRWbKcFSDCcGJjYaq0Nyu2X44LmBO7EeqAdnevkB90i3Oe+6voZNu3sbu5D+xJTVZ8AkBJu07NEXv9aOvbrUO3MHACfXkhOSFz9hozqCMyeMDI0XGD3XKtMHe305rHOejBWeZwG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:46:39.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb9825-8c27-4613-46c4-08dc388d9926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY & HOW]
Update planes and stream version 3 separates FULL and FAST updates
to their own sequences. It aims to clean up frequent checks for
update type resulting unnecessary branching in logic flow. It also
adds a new commit minimal transition sequence, which detects the need
for minimal transition based on the actual comparison of current and
new states instead of "predicting" it based on per feature software
policy, i.e. could_mpcc_tree_change_for_active_pipes.

The new commit minimal transition sequence is made universal to any
power saving features that would use extra free pipes such as Dynamic
ODM/MPC Combine, MPO or SubVp. Therefore there is no longer a need to
specially handle compatibility problems with transitions among those
features as they are now transparent to the new sequence.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 700 +++++++++++++++--------
 1 file changed, 469 insertions(+), 231 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ed6579633a58..e87aad983b40 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2065,7 +2065,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
-static bool commit_minimal_transition_state_legacy(struct dc *dc,
+static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context);
 
 /**
@@ -2131,7 +2131,7 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	}
 
 	if (handle_exit_odm2to1)
-		res = commit_minimal_transition_state_legacy(dc, dc->current_state);
+		res = commit_minimal_transition_state(dc, dc->current_state);
 
 	context = dc_state_create_current_copy(dc);
 	if (!context)
@@ -3029,6 +3029,63 @@ static void restore_planes_and_stream_state(
 	*stream->out_transfer_func = scratch->out_transfer_func;
 }
 
+/**
+ * update_seamless_boot_flags() - Helper function for updating seamless boot flags
+ *
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @surface_count: Number of surfaces that have an updated
+ * @stream: Corresponding stream to be updated in the current flip
+ *
+ * Updating seamless boot flags do not need to be part of the commit sequence. This
+ * helper function will update the seamless boot flags on each flip (if required)
+ * outside of the HW commit sequence (fast or slow).
+ *
+ * Return: void
+ */
+static void update_seamless_boot_flags(struct dc *dc,
+		struct dc_state *context,
+		int surface_count,
+		struct dc_stream_state *stream)
+{
+	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
+		/* Optimize seamless boot flag keeps clocks and watermarks high until
+		 * first flip. After first flip, optimization is required to lower
+		 * bandwidth. Important to note that it is expected UEFI will
+		 * only light up a single display on POST, therefore we only expect
+		 * one stream with seamless boot flag set.
+		 */
+		if (stream->apply_seamless_boot_optimization) {
+			stream->apply_seamless_boot_optimization = false;
+
+			if (get_seamless_boot_stream_count(context) == 0)
+				dc->optimized_required = true;
+		}
+	}
+}
+
+/**
+ * update_planes_and_stream_state() - The function takes planes and stream
+ * updates as inputs and determines the appropriate update type. If update type
+ * is FULL, the function allocates a new context, populates and validates it.
+ * Otherwise, it updates current dc context. The function will return both
+ * new_context and new_update_type back to the caller. The function also backs
+ * up both current and new contexts into corresponding dc state scratch memory.
+ * TODO: The function does too many things, and even conditionally allocates dc
+ * context memory implicitly. We should consider to break it down.
+ *
+ * @dc: Current DC state
+ * @srf_updates: an array of surface updates
+ * @surface_count: surface update count
+ * @stream: Corresponding stream to be updated
+ * @stream_update: stream update
+ * @new_update_type: [out] determined update type by the function
+ * @new_context: [out] new context allocated and validated if update type is
+ * FULL, reference to current context if update type is less than FULL.
+ *
+ * Return: true if a valid update is populated into new_context, false
+ * otherwise.
+ */
 static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -3153,6 +3210,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 				resource_build_subsampling_params(&context->res_ctx, otg_master);
 		}
 	}
+	update_seamless_boot_flags(dc, context, surface_count, stream);
 
 	*new_context = context;
 	*new_update_type = update_type;
@@ -4067,6 +4125,10 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 	struct dc_state *minimal_transition_context = NULL;
 	unsigned int i, j;
 
+	minimal_transition_context = dc_state_create_copy(base_context);
+	if (!minimal_transition_context)
+		return NULL;
+
 	if (!dc->config.is_vmin_only_asic) {
 		policy->mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
@@ -4076,10 +4138,6 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 	policy->subvp_policy = dc->debug.force_disable_subvp;
 	dc->debug.force_disable_subvp = true;
 
-	minimal_transition_context = dc_state_create_copy(base_context);
-	if (!minimal_transition_context)
-		return NULL;
-
 	/* commit minimal state */
 	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false)) {
 		for (i = 0; i < minimal_transition_context->stream_count; i++) {
@@ -4103,69 +4161,179 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 	return minimal_transition_context;
 }
 
+static bool is_pipe_topology_transition_seamless_with_intermediate_step(
+		struct dc *dc,
+		struct dc_state *initial_state,
+		struct dc_state *intermediate_state,
+		struct dc_state *final_state)
+{
+	return dc->hwss.is_pipe_topology_transition_seamless(dc, initial_state,
+			intermediate_state) &&
+			dc->hwss.is_pipe_topology_transition_seamless(dc,
+					intermediate_state, final_state);
+}
+
+static void swap_and_free_current_context(struct dc *dc,
+		struct dc_state *new_context, struct dc_stream_state *stream)
+{
+
+	int i;
+	struct dc_state *old = dc->current_state;
+	struct pipe_ctx *pipe_ctx;
+
+	/* Since memory free requires elevated IRQ, an interrupt
+	 * request is generated by mem free. If this happens
+	 * between freeing and reassigning the context, our vsync
+	 * interrupt will call into dc and cause a memory
+	 * corruption. Hence, we first reassign the context,
+	 * then free the old context.
+	 */
+	dc->current_state = new_context;
+	dc_state_release(old);
+
+	// clear any forced full updates
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx = &new_context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->plane_state && pipe_ctx->stream == stream)
+			pipe_ctx->plane_state->force_full_update = false;
+	}
+}
+
+static int initialize_empty_surface_updates(
+		struct dc_stream_state *stream,
+		struct dc_surface_update *srf_updates)
+{
+	struct dc_stream_status *status = dc_stream_get_status(stream);
+	int i;
+
+	for (i = 0; i < status->plane_count; i++) {
+		memset(&srf_updates[i], 0, sizeof(struct dc_surface_update));
+		srf_updates[i].surface = status->plane_states[i];
+	}
+	return status->plane_count;
+}
+
+static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
+		struct dc_state *new_context,
+		struct dc_stream_state *stream,
+		struct dc_surface_update *srf_updates,
+		int surface_count)
+{
+	bool success = false;
+	struct pipe_split_policy_backup policy;
+	struct dc_state *intermediate_context =
+			create_minimal_transition_state(dc, new_context,
+					&policy);
+
+	if (intermediate_context) {
+		if (is_pipe_topology_transition_seamless_with_intermediate_step(
+				dc,
+				dc->current_state,
+				intermediate_context,
+				new_context)) {
+			DC_LOG_DC("commit minimal transition state: base = new state\n");
+			commit_planes_for_stream(dc, srf_updates,
+					surface_count, stream, NULL,
+					UPDATE_TYPE_FULL, intermediate_context);
+			swap_and_free_current_context(
+					dc, intermediate_context, stream);
+			dc_state_retain(dc->current_state);
+			success = true;
+		}
+		release_minimal_transition_state(
+				dc, intermediate_context, &policy);
+	}
+	return success;
+}
+
+static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
+		struct dc_state *new_context, struct dc_stream_state *stream)
+{
+	bool success = false;
+	struct pipe_split_policy_backup policy;
+	struct dc_state *intermediate_context;
+	struct dc_surface_update srf_updates[MAX_SURFACE_NUM];
+	int surface_count;
+
+	/*
+	 * Both current and new contexts share the same stream and plane state
+	 * pointers. When new context is validated, stream and planes get
+	 * populated with new updates such as new plane addresses. This makes
+	 * the current context no longer valid because stream and planes are
+	 * modified from the original. We backup current stream and plane states
+	 * into scratch space whenever we are populating new context. So we can
+	 * restore the original values back by calling the restore function now.
+	 * This restores back the original stream and plane states associated
+	 * with the current state.
+	 */
+	restore_planes_and_stream_state(&dc->current_state->scratch, stream);
+	intermediate_context = create_minimal_transition_state(dc,
+			dc->current_state, &policy);
+	if (intermediate_context) {
+		if (is_pipe_topology_transition_seamless_with_intermediate_step(
+				dc,
+				dc->current_state,
+				intermediate_context,
+				new_context)) {
+			DC_LOG_DC("commit minimal transition state: base = current state\n");
+			surface_count = initialize_empty_surface_updates(
+					stream, srf_updates);
+			commit_planes_for_stream(dc, srf_updates,
+					surface_count, stream, NULL,
+					UPDATE_TYPE_FULL, intermediate_context);
+			swap_and_free_current_context(
+					dc, intermediate_context, stream);
+			dc_state_retain(dc->current_state);
+			success = true;
+		}
+		release_minimal_transition_state(dc, intermediate_context,
+				&policy);
+	}
+	/*
+	 * Restore stream and plane states back to the values associated with
+	 * new context.
+	 */
+	restore_planes_and_stream_state(&new_context->scratch, stream);
+	return success;
+}
 
 /**
- * commit_minimal_transition_state - Commit a minimal state based on current or new context
+ * commit_minimal_transition_state_in_dc_update - Commit a minimal state based
+ * on current or new context
  *
  * @dc: DC structure, used to get the current state
  * @context: New context
  * @stream: Stream getting the update for the flip
  *
- * The function takes in current state and new state and determine a minimal transition state
- * as the intermediate step which could make the transition between current and new states
- * seamless. If found, it will commit the minimal transition state and update current state to
- * this minimal transition state and return true, if not, it will return false.
+ * The function takes in current state and new state and determine a minimal
+ * transition state as the intermediate step which could make the transition
+ * between current and new states seamless. If found, it will commit the minimal
+ * transition state and update current state to this minimal transition state
+ * and return true, if not, it will return false.
  *
  * Return:
  * Return True if the minimal transition succeeded, false otherwise
  */
-static bool commit_minimal_transition_state(struct dc *dc,
-		struct dc_state *context,
-		struct dc_stream_state *stream)
+static bool commit_minimal_transition_state_in_dc_update(struct dc *dc,
+		struct dc_state *new_context,
+		struct dc_stream_state *stream,
+		struct dc_surface_update *srf_updates,
+		int surface_count)
 {
-	bool success = false;
-	struct dc_state *minimal_transition_context;
-	struct pipe_split_policy_backup policy;
-
-	/* commit based on new context */
-	minimal_transition_context = create_minimal_transition_state(dc,
-			context, &policy);
-	if (minimal_transition_context) {
-		if (dc->hwss.is_pipe_topology_transition_seamless(
-					dc, dc->current_state, minimal_transition_context) &&
-			dc->hwss.is_pipe_topology_transition_seamless(
-					dc, minimal_transition_context, context)) {
-			DC_LOG_DC("%s base = new state\n", __func__);
-
-			success = dc_commit_state_no_check(dc, minimal_transition_context) == DC_OK;
-		}
-		release_minimal_transition_state(dc, minimal_transition_context, &policy);
-	}
-
-	if (!success) {
-		/* commit based on current context */
-		restore_planes_and_stream_state(&dc->current_state->scratch, stream);
-		minimal_transition_context = create_minimal_transition_state(dc,
-				dc->current_state, &policy);
-		if (minimal_transition_context) {
-			if (dc->hwss.is_pipe_topology_transition_seamless(
-					dc, dc->current_state, minimal_transition_context) &&
-				dc->hwss.is_pipe_topology_transition_seamless(
-						dc, minimal_transition_context, context)) {
-				DC_LOG_DC("%s base = current state\n", __func__);
-				success = dc_commit_state_no_check(dc, minimal_transition_context) == DC_OK;
-			}
-			release_minimal_transition_state(dc, minimal_transition_context, &policy);
-		}
-		restore_planes_and_stream_state(&context->scratch, stream);
-	}
-
-	ASSERT(success);
+	bool success = commit_minimal_transition_based_on_new_context(
+				dc, new_context, stream, srf_updates,
+				surface_count);
+	if (!success)
+		success = commit_minimal_transition_based_on_current_context(dc,
+				new_context, stream);
+	if (!success)
+		DC_LOG_ERROR("Fail to commit a seamless minimal transition state between current and new states.\nThis pipe topology update is non-seamless!\n");
 	return success;
 }
 
 /**
- * commit_minimal_transition_state_legacy - Create a transition pipe split state
+ * commit_minimal_transition_state - Create a transition pipe split state
  *
  * @dc: Used to get the current state status
  * @transition_base_context: New transition state
@@ -4182,7 +4350,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
  * Return:
  * Return false if something is wrong in the transition state.
  */
-static bool commit_minimal_transition_state_legacy(struct dc *dc,
+static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
 	struct dc_state *transition_context;
@@ -4266,41 +4434,6 @@ static bool commit_minimal_transition_state_legacy(struct dc *dc,
 	return true;
 }
 
-/**
- * update_seamless_boot_flags() - Helper function for updating seamless boot flags
- *
- * @dc: Current DC state
- * @context: New DC state to be programmed
- * @surface_count: Number of surfaces that have an updated
- * @stream: Corresponding stream to be updated in the current flip
- *
- * Updating seamless boot flags do not need to be part of the commit sequence. This
- * helper function will update the seamless boot flags on each flip (if required)
- * outside of the HW commit sequence (fast or slow).
- *
- * Return: void
- */
-static void update_seamless_boot_flags(struct dc *dc,
-		struct dc_state *context,
-		int surface_count,
-		struct dc_stream_state *stream)
-{
-	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
-		/* Optimize seamless boot flag keeps clocks and watermarks high until
-		 * first flip. After first flip, optimization is required to lower
-		 * bandwidth. Important to note that it is expected UEFI will
-		 * only light up a single display on POST, therefore we only expect
-		 * one stream with seamless boot flag set.
-		 */
-		if (stream->apply_seamless_boot_optimization) {
-			stream->apply_seamless_boot_optimization = false;
-
-			if (get_seamless_boot_stream_count(context) == 0)
-				dc->optimized_required = true;
-		}
-	}
-}
-
 static void populate_fast_updates(struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -4420,123 +4553,9 @@ static bool fast_update_only(struct dc *dc,
 			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
 }
 
-bool dc_update_planes_and_stream(struct dc *dc,
+static bool update_planes_and_stream_v1(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update)
-{
-	struct dc_state *context;
-	enum surface_update_type update_type;
-	int i;
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
-
-	/* In cases where MPO and split or ODM are used transitions can
-	 * cause underflow. Apply stream configuration with minimal pipe
-	 * split first to avoid unsupported transitions for active pipes.
-	 */
-	bool force_minimal_pipe_splitting = 0;
-	bool is_plane_addition = 0;
-	bool is_fast_update_only;
-
-	dc_exit_ips_for_hw_access(dc);
-
-	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
-	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
-			surface_count, stream_update, stream);
-	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
-			dc,
-			stream,
-			srf_updates,
-			surface_count,
-			&is_plane_addition);
-
-	/* on plane addition, minimal state is the current one */
-	if (force_minimal_pipe_splitting && is_plane_addition &&
-		!commit_minimal_transition_state_legacy(dc, dc->current_state))
-				return false;
-
-	if (!update_planes_and_stream_state(
-			dc,
-			srf_updates,
-			surface_count,
-			stream,
-			stream_update,
-			&update_type,
-			&context))
-		return false;
-
-	/* on plane removal, minimal state is the new one */
-	if (force_minimal_pipe_splitting && !is_plane_addition) {
-		if (!commit_minimal_transition_state_legacy(dc, context)) {
-			dc_state_release(context);
-			return false;
-		}
-		update_type = UPDATE_TYPE_FULL;
-	}
-
-	if (dc->hwss.is_pipe_topology_transition_seamless &&
-			!dc->hwss.is_pipe_topology_transition_seamless(
-					dc, dc->current_state, context)) {
-		commit_minimal_transition_state(dc,
-				context, stream);
-	}
-	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
-		commit_planes_for_stream_fast(dc,
-				srf_updates,
-				surface_count,
-				stream,
-				stream_update,
-				update_type,
-				context);
-	} else {
-		if (!stream_update &&
-				dc->hwss.is_pipe_topology_transition_seamless &&
-				!dc->hwss.is_pipe_topology_transition_seamless(
-						dc, dc->current_state, context)) {
-			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
-			BREAK_TO_DEBUGGER();
-		}
-		commit_planes_for_stream(
-				dc,
-				srf_updates,
-				surface_count,
-				stream,
-				stream_update,
-				update_type,
-				context);
-	}
-
-	if (dc->current_state != context) {
-
-		/* Since memory free requires elevated IRQL, an interrupt
-		 * request is generated by mem free. If this happens
-		 * between freeing and reassigning the context, our vsync
-		 * interrupt will call into dc and cause a memory
-		 * corruption BSOD. Hence, we first reassign the context,
-		 * then free the old context.
-		 */
-
-		struct dc_state *old = dc->current_state;
-
-		dc->current_state = context;
-		dc_state_release(old);
-
-		// clear any forced full updates
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (pipe_ctx->plane_state && pipe_ctx->stream == stream)
-				pipe_ctx->plane_state->force_full_update = false;
-		}
-	}
-	return true;
-}
-
-void dc_commit_updates_for_stream(struct dc *dc,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
 		struct dc_state *state)
 {
@@ -4556,35 +4575,13 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	update_type = dc_check_update_surfaces_for_stream(
 				dc, srf_updates, surface_count, stream_update, stream_status);
 
-	/* TODO: Since change commit sequence can have a huge impact,
-	 * we decided to only enable it for DCN3x. However, as soon as
-	 * we get more confident about this change we'll need to enable
-	 * the new sequence for all ASICs.
-	 */
-	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		/*
-		 * Previous frame finished and HW is ready for optimization.
-		 */
-		if (update_type == UPDATE_TYPE_FAST)
-			dc_post_update_surfaces_to_stream(dc);
-
-		dc_update_planes_and_stream(dc, srf_updates,
-					    surface_count, stream,
-					    stream_update);
-		return;
-	}
-
-	if (update_type >= update_surface_trace_level)
-		update_surface_trace(dc, srf_updates, surface_count);
-
-
 	if (update_type >= UPDATE_TYPE_FULL) {
 
 		/* initialize scratch memory for building context */
 		context = dc_state_create_copy(state);
 		if (context == NULL) {
 			DC_ERROR("Failed to allocate new validate context!\n");
-			return;
+			return false;
 		}
 
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -4601,7 +4598,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		dc_post_update_surfaces_to_stream(dc);
 	}
 
-
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *surface = srf_updates[i].surface;
 
@@ -4626,13 +4622,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
 			DC_ERROR("Mode validation failed for stream update!\n");
 			dc_state_release(context);
-			return;
+			return false;
 		}
 	}
 
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
-	update_seamless_boot_flags(dc, context, surface_count, stream);
 	if (fast_update_only(dc, fast_update, srf_updates, surface_count, stream_update, stream) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
@@ -4673,9 +4668,252 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		dc_post_update_surfaces_to_stream(dc);
 		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
 	}
+	return true;
+}
+
+static bool update_planes_and_stream_v2(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update)
+{
+	struct dc_state *context;
+	enum surface_update_type update_type;
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
+
+	/* In cases where MPO and split or ODM are used transitions can
+	 * cause underflow. Apply stream configuration with minimal pipe
+	 * split first to avoid unsupported transitions for active pipes.
+	 */
+	bool force_minimal_pipe_splitting = 0;
+	bool is_plane_addition = 0;
+	bool is_fast_update_only;
+
+	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
+	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
+			surface_count, stream_update, stream);
+	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
+			dc,
+			stream,
+			srf_updates,
+			surface_count,
+			&is_plane_addition);
+
+	/* on plane addition, minimal state is the current one */
+	if (force_minimal_pipe_splitting && is_plane_addition &&
+		!commit_minimal_transition_state(dc, dc->current_state))
+		return false;
+
+	if (!update_planes_and_stream_state(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update,
+			&update_type,
+			&context))
+		return false;
+
+	/* on plane removal, minimal state is the new one */
+	if (force_minimal_pipe_splitting && !is_plane_addition) {
+		if (!commit_minimal_transition_state(dc, context)) {
+			dc_state_release(context);
+			return false;
+		}
+		update_type = UPDATE_TYPE_FULL;
+	}
+
+	if (dc->hwss.is_pipe_topology_transition_seamless &&
+			!dc->hwss.is_pipe_topology_transition_seamless(
+					dc, dc->current_state, context))
+		commit_minimal_transition_state_in_dc_update(dc, context, stream,
+				srf_updates, surface_count);
+
+	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
+		commit_planes_for_stream_fast(dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				context);
+	} else {
+		if (!stream_update &&
+				dc->hwss.is_pipe_topology_transition_seamless &&
+				!dc->hwss.is_pipe_topology_transition_seamless(
+						dc, dc->current_state, context)) {
+			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
+			BREAK_TO_DEBUGGER();
+		}
+		commit_planes_for_stream(
+				dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				context);
+	}
+	if (dc->current_state != context)
+		swap_and_free_current_context(dc, context, stream);
+	return true;
+}
 
-	return;
+static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type update_type)
+{
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
+	ASSERT(update_type < UPDATE_TYPE_FULL);
+	populate_fast_updates(fast_update, srf_updates, surface_count,
+			stream_update);
+	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
+			stream_update, stream) &&
+			!dc->debug.enable_legacy_fast_update)
+		commit_planes_for_stream_fast(dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				dc->current_state);
+	else
+		commit_planes_for_stream(
+				dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				dc->current_state);
+}
+
+static void commit_planes_and_stream_update_with_new_context(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type update_type,
+		struct dc_state *new_context)
+{
+	ASSERT(update_type >= UPDATE_TYPE_FULL);
+	if (!dc->hwss.is_pipe_topology_transition_seamless(dc,
+			dc->current_state, new_context))
+		/*
+		 * It is required by the feature design that all pipe topologies
+		 * using extra free pipes for power saving purposes such as
+		 * dynamic ODM or SubVp shall only be enabled when it can be
+		 * transitioned seamlessly to AND from its minimal transition
+		 * state. A minimal transition state is defined as the same dc
+		 * state but with all power saving features disabled. So it uses
+		 * the minimum pipe topology. When we can't seamlessly
+		 * transition from state A to state B, we will insert the
+		 * minimal transition state A' or B' in between so seamless
+		 * transition between A and B can be made possible.
+		 */
+		commit_minimal_transition_state_in_dc_update(dc, new_context,
+				stream, srf_updates, surface_count);
+
+	commit_planes_for_stream(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update,
+			update_type,
+			new_context);
+}
+
+static bool update_planes_and_stream_v3(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update)
+{
+	struct dc_state *new_context;
+	enum surface_update_type update_type;
+
+	/*
+	 * When this function returns true and new_context is not equal to
+	 * current state, the function allocates and validates a new dc state
+	 * and assigns it to new_context. The function expects that the caller
+	 * is responsible to free this memory when new_context is no longer
+	 * used. We swap current with new context and free current instead. So
+	 * new_context's memory will live until the next full update after it is
+	 * replaced by a newer context. Refer to the use of
+	 * swap_and_free_current_context below.
+	 */
+	if (!update_planes_and_stream_state(dc, srf_updates, surface_count,
+				stream, stream_update, &update_type,
+				&new_context))
+		return false;
+
+	if (new_context == dc->current_state) {
+		commit_planes_and_stream_update_on_current_context(dc,
+				srf_updates, surface_count, stream,
+				stream_update, update_type);
+	} else {
+		commit_planes_and_stream_update_with_new_context(dc,
+				srf_updates, surface_count, stream,
+				stream_update, update_type, new_context);
+		swap_and_free_current_context(dc, new_context, stream);
+	}
+
+	return true;
+}
+
+bool dc_update_planes_and_stream(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update)
+{
+	dc_exit_ips_for_hw_access(dc);
+	/*
+	 * update planes and stream version 3 separates FULL and FAST updates
+	 * to their own sequences. It aims to clean up frequent checks for
+	 * update type resulting unnecessary branching in logic flow. It also
+	 * adds a new commit minimal transition sequence, which detects the need
+	 * for minimal transition based on the actual comparison of current and
+	 * new states instead of "predicting" it based on per feature software
+	 * policy.i.e could_mpcc_tree_change_for_active_pipes. The new commit
+	 * minimal transition sequence is made universal to any power saving
+	 * features that would use extra free pipes such as Dynamic ODM/MPC
+	 * Combine, MPO or SubVp. Therefore there is no longer a need to
+	 * specially handle compatibility problems with transitions among those
+	 * features as they are now transparent to the new sequence.
+	 */
+	if (dc->ctx->dce_version > DCN_VERSION_3_51)
+		return update_planes_and_stream_v3(dc, srf_updates,
+				surface_count, stream, stream_update);
+	return update_planes_and_stream_v2(dc, srf_updates,
+			surface_count, stream, stream_update);
+}
+
+void dc_commit_updates_for_stream(struct dc *dc,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		struct dc_state *state)
+{
+	dc_exit_ips_for_hw_access(dc);
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs.
+	 */
+	if (dc->ctx->dce_version > DCN_VERSION_3_51) {
+		update_planes_and_stream_v3(dc, srf_updates, surface_count,
+				stream, stream_update);
+		return;
+	}
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		update_planes_and_stream_v2(dc, srf_updates, surface_count,
+				stream, stream_update);
+		return;
+	}
+	update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
+			stream_update, state);
 }
 
 uint8_t dc_get_current_stream_count(struct dc *dc)
-- 
2.34.1

