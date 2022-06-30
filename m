Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE3EC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8B912A6A2;
	Thu, 30 Jun 2022 19:14:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D1812A6C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFRwyCsHqW4S8JB6zLFQoP16IKIJ36w1TFnyojCD+cfEblMZopqK9Y5eV0V6sBBFUaFCoOUPGS3xmfnyPPFex3Q3vHjtTx+gtxXe/rauoKVJMs6/rmuF+YcmaqBPuSbGWT4oJrRrzQAmcaA1LB8Lejlw19x7w3G6g6nqY8h5glvquiFmuhnCGYeARGR63z8vZPMFLJTgtCOP5Mlbbk24p1fjpwgThd/LSzQwU0wlU545UVM68EEMTt7Kn5Oz7DcGshqdMRfmhSIbgnOUJV3y+VxTpsbaLUVBc170IYM+cU4ER9N2VdnXhWGO0gB2VVgX6a3dbJr9udRuEMIYSVVDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnP/cqu3F3dfJuh2teaGv1GM+gyfjAP5XGC+uIDsJfY=;
 b=by2mypPEzhk2zVLBJo4AU/o++Tb+isiL5gETvVFUAhNwN1wjqIJgLTd6vANSQkp8+YEkcQdYwzqlf9/WtY47TB1cKb1sNzYmCnQHyrLgdq4Ow43a6DoXQANibJbLdk5tcjYugLbzyBEUF/ARK9Ow/rjq+8fyLd53M8RhzUAj2vZtI/siCwtzcn1EJrDEXVMvDyZPsxpwo3aVjuE+eVj51vJQyz/pzOi4yZ9iJIb7bC+T6vM6jTTRYlfrPscV5o+UhSlva/GsHFFd0MLchWEpMXqeMhrzlkvWEgGpPc1lBzmlf2ofjULm9gL9n4N+OT923R59J2QQs5SoDY0bujXeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnP/cqu3F3dfJuh2teaGv1GM+gyfjAP5XGC+uIDsJfY=;
 b=a9pxQ3n/MQHsaldsnaLaFXURJr49bBpbVemR0AaHCs5WSy6OgZoJY215KGlI+ilCtZzmRa6wfystouee43kSmltHYzwvH8KD/1qc66ikMvP30C+VEPfXTJcGQhajwkd95wI7MQHzZ+SMJGmWF5TCKYEHWtaH66EzWfY40feR4PE=
Received: from BN9PR03CA0770.namprd03.prod.outlook.com (2603:10b6:408:13a::25)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:03 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::b4) by BN9PR03CA0770.outlook.office365.com
 (2603:10b6:408:13a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:03 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/40] drm/amd/display: Add minimal pipe split transition state
Date: Thu, 30 Jun 2022 15:12:56 -0400
Message-ID: <20220630191322.909650-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 252ac52a-b9f0-4f5b-c2a6-08da5accb224
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCHd6wHcITj0+IXXQTLxiJWgfbAD5uuVUovpKuo5PbY3mOyjtchHf+sGCybTHV7Tb4gAKhJPfqZJcgLH1IDizz7/Gyb4pQsj73WgR8pW45Q7CtcLmhDw5duyyuE6dsDd81yfxfjGD5wlny/S1RaRiz7hogJYPpbRe6wY3FEqCxcI26OBJLvFpQuf9GdqNcEBF2zVX5QG3xYGQAFrJdAllU3mh1b4PmcyxZsXXOuwMbOly7VlNISIN8V5g3Z824igrLwafTDJqyzyZrJl87cU1EoLYhDVWcn+CClVbkF4OYYhIO1ncB5lzlWf+Boi8WgNfP4XqWflXVngAr3o74U6W5tw7d67SIQ0yqhoP1s8jIJBz4k9IOtp3RPRKCPaDLU0mbWh3diclPZrAtJqhkknzZoTDN5fP1g+cIzL5VldNoEKQ7jeML8GGtuHD/QwUSuNYyebp44t4Uux9A4eIqSs8e5jsq96F1KaL2tYYUuVC9aexpcNOTs+UgnPBOWxLN2WNpvwbNxaWqhEx84QKefaTxmw1KPEzH2HlZXYXBb8A6vwYemkM4Jrexzv66USrrA2ACRssWbeUmhTG07dAIhe5Hpc1Q8nbibI1jBh4gF/7Sw2jRgvF3OsoeGlJH3u6FOe93Q7jhohvycQx5fiC9/r6fI72ECXwab5nXnQxVO7CaIqN7WM5I5VCowzbXYTICBMDrpxAH1VDXMivLxuWmIIj2EmdSB3XIP/2wRqHmPCLvAhAXptSIDMGjcdXBDfFnabuZKwrX1yC7H7EuyDkNChrtMIzn0lx2yyZ/K7/qigxr2Y7k4J5X8ngzXyPWSeGVgCFg0HAvrc+FJ0OPdizUlc8pw8UY2EOoIce6bXzZYz7gk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(4326008)(8676002)(83380400001)(70206006)(70586007)(5660300002)(8936002)(54906003)(36756003)(6916009)(478600001)(30864003)(82310400005)(316002)(40480700001)(16526019)(2906002)(82740400003)(7696005)(41300700001)(86362001)(6666004)(26005)(2616005)(186003)(40460700003)(1076003)(81166007)(336012)(356005)(47076005)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:03.4303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ac52a-b9f0-4f5b-c2a6-08da5accb224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY?]
When adding/removing a plane to some configurations, unsupported pipe
programming can occur when moving to a new plane.  Such cases include pipe
split on multi-display, with MPO, and/or ODM.

[HOW?]
Add a safe transistion state that minimizes pipe usage before programming
new configuration. When adding a plane, the current state has the least
pipes required so it is applied without splitting.  This must be applied
prior to updating the plane_state for seamless transition.  When removing a
plane, the new state has the least pieps required so it is applied without
splitting.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 277 +++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  18 ++
 2 files changed, 295 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 05c2e178ca99..40848eda44d9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2717,6 +2717,137 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 }
 
+void dc_reset_state(struct dc *dc, struct dc_state *context)
+{
+	dc_resource_state_destruct(context);
+
+	/* clear the structure, but don't reset the reference count */
+	memset(context, 0, offsetof(struct dc_state, refcount));
+
+	init_state(dc, context);
+}
+
+static bool update_planes_and_stream_state(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type *new_update_type,
+		struct dc_state **new_context)
+{
+	struct dc_state *context;
+	int i, j;
+	enum surface_update_type update_type;
+	const struct dc_stream_status *stream_status;
+	struct dc_context *dc_ctx = dc->ctx;
+
+	stream_status = dc_stream_get_status(stream);
+
+	if (!stream_status) {
+		if (surface_count) /* Only an error condition if surf_count non-zero*/
+			ASSERT(false);
+
+		return false; /* Cannot commit surface to stream that is not committed */
+	}
+
+	context = dc->current_state;
+
+	update_type = dc_check_update_surfaces_for_stream(
+			dc, srf_updates, surface_count, stream_update, stream_status);
+
+	/* update current stream with the new updates */
+	copy_stream_update_to_stream(dc, context, stream, stream_update);
+
+	/* do not perform surface update if surface has invalid dimensions
+	 * (all zero) and no scaling_info is provided
+	 */
+	if (surface_count > 0) {
+		for (i = 0; i < surface_count; i++) {
+			if ((srf_updates[i].surface->src_rect.width == 0 ||
+				 srf_updates[i].surface->src_rect.height == 0 ||
+				 srf_updates[i].surface->dst_rect.width == 0 ||
+				 srf_updates[i].surface->dst_rect.height == 0) &&
+				(!srf_updates[i].scaling_info ||
+				  srf_updates[i].scaling_info->src_rect.width == 0 ||
+				  srf_updates[i].scaling_info->src_rect.height == 0 ||
+				  srf_updates[i].scaling_info->dst_rect.width == 0 ||
+				  srf_updates[i].scaling_info->dst_rect.height == 0)) {
+				DC_ERROR("Invalid src/dst rects in surface update!\n");
+				return false;
+			}
+		}
+	}
+
+	if (update_type >= update_surface_trace_level)
+		update_surface_trace(dc, srf_updates, surface_count);
+
+	if (update_type >= UPDATE_TYPE_FULL) {
+		struct dc_plane_state *new_planes[MAX_SURFACES] = {0};
+
+		for (i = 0; i < surface_count; i++)
+			new_planes[i] = srf_updates[i].surface;
+
+		/* initialize scratch memory for building context */
+		context = dc_create_state(dc);
+		if (context == NULL) {
+			DC_ERROR("Failed to allocate new validate context!\n");
+			return false;
+		}
+
+		dc_resource_state_copy_construct(
+				dc->current_state, context);
+
+		/*remove old surfaces from context */
+		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
+
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+
+		/* add surface to context */
+		if (!dc_add_all_planes_for_stream(dc, stream, new_planes, surface_count, context)) {
+
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+	}
+
+	/* save update parameters into surface */
+	for (i = 0; i < surface_count; i++) {
+		struct dc_plane_state *surface = srf_updates[i].surface;
+
+		copy_surface_update_to_plane(surface, &srf_updates[i]);
+
+		if (update_type >= UPDATE_TYPE_MED) {
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+				if (pipe_ctx->plane_state != surface)
+					continue;
+
+				resource_build_scaling_params(pipe_ctx);
+			}
+		}
+	}
+
+	if (update_type == UPDATE_TYPE_FULL) {
+		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+	}
+
+	*new_context = context;
+	*new_update_type = update_type;
+
+	return true;
+
+fail:
+	dc_release_state(context);
+
+	return false;
+
+}
+
 static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
@@ -3264,6 +3395,152 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context)
+{
+	struct dc_state *transition_context = dc_create_state(dc);
+	enum pipe_split_policy tmp_policy;
+	enum dc_status ret = DC_ERROR_UNEXPECTED;
+	unsigned int i, j;
+
+	if (!transition_context)
+		return false;
+
+	tmp_policy = dc->debug.pipe_split_policy;
+	dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+
+	dc_resource_state_copy_construct(transition_base_context, transition_context);
+
+	//commit minimal state
+	if (dc->res_pool->funcs->validate_bandwidth(dc, transition_context, false)) {
+		for (i = 0; i < transition_context->stream_count; i++) {
+			struct dc_stream_status *stream_status = &transition_context->stream_status[i];
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
+
+		ret = dc_commit_state_no_check(dc, transition_context);
+	}
+
+	//always release as dc_commit_state_no_check retains in good case
+	dc_release_state(transition_context);
+
+	//restore previous pipe split policy
+	dc->debug.pipe_split_policy = tmp_policy;
+
+	if (ret != DC_OK) {
+		//this should never happen
+		BREAK_TO_DEBUGGER();
+		return false;
+	}
+
+	//force full surface update
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
+			dc->current_state->stream_status[i].plane_states[j]->update_flags.raw = 0xFFFFFFFF;
+		}
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
+	struct dc_state *context;
+	enum surface_update_type update_type;
+	int i;
+
+	/* In cases where MPO and split or ODM are used transitions can
+	 * cause underflow. Apply stream configuration with minimal pipe
+	 * split first to avoid unsupported transitions for active pipes.
+	 */
+	bool force_minimal_pipe_splitting = false;
+	bool is_plane_addition = false;
+
+	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
+
+	if (cur_stream_status &&
+			dc->current_state->stream_count > 0 &&
+			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID) {
+		/* determine if minimal transition is required */
+		if (cur_stream_status->plane_count > surface_count) {
+			force_minimal_pipe_splitting = true;
+		} else if (cur_stream_status->plane_count < surface_count) {
+			force_minimal_pipe_splitting = true;
+			is_plane_addition = true;
+		}
+	}
+
+	/* on plane addition, minimal state is the current one */
+	if (force_minimal_pipe_splitting && is_plane_addition &&
+		!commit_minimal_transition_state(dc, dc->current_state))
+				return false;
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
+	/* on plane addition, minimal state is the new one */
+	if (force_minimal_pipe_splitting && !is_plane_addition) {
+		if (!commit_minimal_transition_state(dc, context)) {
+			dc_release_state(context);
+			return false;
+		}
+
+		update_type = UPDATE_TYPE_FULL;
+	}
+
+	commit_planes_for_stream(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update,
+			update_type,
+			context);
+
+	if (dc->current_state != context) {
+
+		/* Since memory free requires elevated IRQL, an interrupt
+		 * request is generated by mem free. If this happens
+		 * between freeing and reassigning the context, our vsync
+		 * interrupt will call into dc and cause a memory
+		 * corruption BSOD. Hence, we first reassign the context,
+		 * then free the old context.
+		 */
+
+		struct dc_state *old = dc->current_state;
+
+		dc->current_state = context;
+		dc_release_state(old);
+
+		// clear any forced full updates
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->plane_state && pipe_ctx->stream == stream)
+				pipe_ctx->plane_state->force_full_update = false;
+		}
+	}
+	return true;
+}
+
 void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 1820c19d14d8..2a2f719587ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -324,6 +324,9 @@ bool dc_is_stream_scaling_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream);
 
 /*
+ * Setup stream attributes if no stream updates are provided
+ * there will be no impact on the stream parameters
+ *
  * Set up surface attributes and associate to a stream
  * The surfaces parameter is an absolute set of all surface active for the stream.
  * If no surfaces are provided, the stream will be blanked; no memory read.
@@ -332,8 +335,23 @@ bool dc_is_stream_scaling_unchanged(
  * After this call:
  *   Surfaces attributes are programmed and configured to be composed into stream.
  *   This does not trigger a flip.  No surface address is programmed.
+ *
  */
+bool dc_update_planes_and_stream(struct dc *dc,
+		struct dc_surface_update *surface_updates, int surface_count,
+		struct dc_stream_state *dc_stream,
+		struct dc_stream_update *stream_update);
 
+/*
+ * Set up surface attributes and associate to a stream
+ * The surfaces parameter is an absolute set of all surface active for the stream.
+ * If no surfaces are provided, the stream will be blanked; no memory read.
+ * Any flip related attribute changes must be done through this interface.
+ *
+ * After this call:
+ *   Surfaces attributes are programmed and configured to be composed into stream.
+ *   This does not trigger a flip.  No surface address is programmed.
+ */
 void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
-- 
2.25.1

