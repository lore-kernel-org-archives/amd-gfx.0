Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82EC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75CE10E5CE;
	Wed, 14 Feb 2024 18:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+sbac/b";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3A910E5CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jidqNXm8mflQO+9NYDL6LEmmCUcF6v3n9oBCdaCL0UxmuSK29ErSmIxDu/5cgvRJs3Fd2JfriVfY9f89jv8C3MwRnCT9LqVeCNmeWcYGS4+vEZIlkSU4eijfsWH1adA5ES//hqWbK6eINwzeaQEA/49tEXOjYUPGIkkev7gFgeIyCwS4ztii5GQWH6qOtNQnqDmelLBoHDh/7/N5WXk+pWxhv0R4SaQsmTtgRq3OmQtdVnKjbz84jo69bx/nmm1ZMHaVILPIZMGIQW/9FzQNORVm68pLLKDT67WxLwp1/IykZ+lcf6xUXCuGMgpuc49Vg0IE9DSd2K6sRKrsYVcr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtOCb7YueJyRfsjHhAM2b5UucrEfhjVANd/Hu5fgqj0=;
 b=cKx9DEt4a+Qfw0CKWlQS0EBhXKgBC0Kb8E9AFouOoE/n646fMQGf9MNabD7phU00T5jIMthLCxqlvlO1j/4ar8y9vDHkiEAU4QpTHMwAubZ1jgHEOZhf9LoeYwzTFicls8SQ1wYgEkO5rcRB8X991LnwJ/O8qKwd49p4y3NTsC3alnv+BO8zK7yggNePEzxbuH8iksE+qySGKDqXVDi6k0Oc0LhhUHvMcZbF+YmvpUyEYgdANTJkPTwbO3kpCadbcdgXx+Y7FnKQRcfnnP7Z3i1ajDMK146X0T5AAQDLnxhPOGzTat6Ybfuy+mHj7c6XOYi5kWj327lJSM+TYVzVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtOCb7YueJyRfsjHhAM2b5UucrEfhjVANd/Hu5fgqj0=;
 b=u+sbac/bJXJWChnWLFEzNwtcYA5hXTwA+EPHXCCXO6Q4Yg1vfWaR4f0kBnNz+GMzpj5t++uPqj8Cs86prChpReP5k++XNgEKb0pp4UYgeRySRu5iZR9SlZLliTsHtvITJ0RzgcsuAVVj9txJQAh4CrVDS7pMJjDTFE1uZOUAODQ=
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 18:40:45 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::13) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:45 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:43 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/17] drm/amd/display: Generalize new minimal transition path
Date: Wed, 14 Feb 2024 11:38:41 -0700
Message-ID: <20240214184006.1356137-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 289ec069-0101-4c39-6852-08dc2d8c74ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJdFfFQvWrL7C3hSC8vNYI/V34U99Cys+c6md2ZMmy9iBCWkU2k70+oX9jX2+fHSdJKYYmioT1hLaijsaJ7XMDYbDnpWp87nB4dlLXcumvHb2V8NjDNVuCnt1UQ6HudBO1ndcARiR2p2WjXvGy3nev6/pxCLnYw7qlwWaYM1A6VHp5mxQQAK7gTcI9RuAtaauO6a7m2nANriutB69u0D2FA7oAeYx4G66/vnSqRsbLIZzWtt2f527KKV1Gmk2FKTN+ySJcNFNxB+m1G54psGGCoI9uCdYwnm370ABInVZsBwbFC0a/d+d/wcELlMr88bnMXcafHC0yiWMIgf3dGHba4zfY91zZhGiXB3jB3p+g2wpKy1TSnpbXP2rmBm4BmIRZoPIaEpMw9xtKSbZcmlPdT/QPwx2f8iFPaJUzxThONb2SO+wTc06fG+o/vdmE/rY7kv3ywE2I2VApxKA/QyCWV+T1D8R+bN0h3uY7BwqUmSJpI0Ue9GDuUnvE5Ia4w1wWAQLIIIJrN+JLgzraHSjUoGHVxz6LIoLhMruWYYwHdqsl412O/k9X+tfD1yC7L1aGBZBnE51L0v/6xcTC0FkkB78Gj97LKOUjvA8p02oAE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(4326008)(8936002)(8676002)(30864003)(5660300002)(6916009)(70586007)(82740400003)(426003)(336012)(83380400001)(2616005)(1076003)(16526019)(26005)(36756003)(356005)(86362001)(81166007)(70206006)(54906003)(316002)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:45.7079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289ec069-0101-4c39-6852-08dc2d8c74ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

From: Alvin Lee <alvin.lee2@amd.com>

Previously the new minimal transition path was only used for windowed
MPO + ODM for plane scaling updates. However, we want to generalize the
transition for all cases whenever a non-seamless transition is detected
(such as for MPO -> SubVP + MPC).

To make this change we add pointers in the plane state, stream, and
pointers in the stream state to the dc_scratch state and backup and
restore these so the minimal transition can take place successfully.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 146 +++++++-----------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  31 ++--
 2 files changed, 77 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4d5194293dbd..5211c1c0f3c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2032,7 +2032,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
-static bool commit_minimal_transition_state(struct dc *dc,
+static bool commit_minimal_transition_state_legacy(struct dc *dc,
 		struct dc_state *transition_base_context);
 
 /**
@@ -2098,7 +2098,7 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	}
 
 	if (handle_exit_odm2to1)
-		res = commit_minimal_transition_state(dc, dc->current_state);
+		res = commit_minimal_transition_state_legacy(dc, dc->current_state);
 
 	context = dc_state_create_current_copy(dc);
 	if (!context)
@@ -2952,8 +2952,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 }
 
-static void backup_plane_states_for_stream(
-		struct dc_plane_state plane_states[MAX_SURFACE_NUM],
+static void backup_planes_and_stream_state(
+		struct dc_scratch_space *scratch,
 		struct dc_stream_state *stream)
 {
 	int i;
@@ -2962,12 +2962,20 @@ static void backup_plane_states_for_stream(
 	if (!status)
 		return;
 
-	for (i = 0; i < status->plane_count; i++)
-		plane_states[i] = *status->plane_states[i];
+	for (i = 0; i < status->plane_count; i++) {
+		scratch->plane_states[i] = *status->plane_states[i];
+		scratch->gamma_correction[i] = *status->plane_states[i]->gamma_correction;
+		scratch->in_transfer_func[i] = *status->plane_states[i]->in_transfer_func;
+		scratch->lut3d_func[i] = *status->plane_states[i]->lut3d_func;
+		scratch->in_shaper_func[i] = *status->plane_states[i]->in_shaper_func;
+		scratch->blend_tf[i] = *status->plane_states[i]->blend_tf;
+	}
+	scratch->stream_state = *stream;
+	scratch->out_transfer_func = *stream->out_transfer_func;
 }
 
-static void restore_plane_states_for_stream(
-		struct dc_plane_state plane_states[MAX_SURFACE_NUM],
+static void restore_planes_and_stream_state(
+		struct dc_scratch_space *scratch,
 		struct dc_stream_state *stream)
 {
 	int i;
@@ -2976,8 +2984,16 @@ static void restore_plane_states_for_stream(
 	if (!status)
 		return;
 
-	for (i = 0; i < status->plane_count; i++)
-		*status->plane_states[i] = plane_states[i];
+	for (i = 0; i < status->plane_count; i++) {
+		*status->plane_states[i] = scratch->plane_states[i];
+		*status->plane_states[i]->gamma_correction = scratch->gamma_correction[i];
+		*status->plane_states[i]->in_transfer_func = scratch->in_transfer_func[i];
+		*status->plane_states[i]->lut3d_func = scratch->lut3d_func[i];
+		*status->plane_states[i]->in_shaper_func = scratch->in_shaper_func[i];
+		*status->plane_states[i]->blend_tf = scratch->blend_tf[i];
+	}
+	*stream = scratch->stream_state;
+	*stream->out_transfer_func = scratch->out_transfer_func;
 }
 
 static bool update_planes_and_stream_state(struct dc *dc,
@@ -3003,7 +3019,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	context = dc->current_state;
-	backup_plane_states_for_stream(dc->current_state->scratch.plane_states, stream);
+	backup_planes_and_stream_state(&dc->current_state->scratch, stream);
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
 
@@ -3103,7 +3119,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	*new_context = context;
 	*new_update_type = update_type;
-	backup_plane_states_for_stream(context->scratch.plane_states, stream);
+	backup_planes_and_stream_state(&context->scratch, stream);
 
 	return true;
 
@@ -4047,7 +4063,23 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 	return minimal_transition_context;
 }
 
-static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
+
+/**
+ * commit_minimal_transition_state - Commit a minimal state based on current or new context
+ *
+ * @dc: DC structure, used to get the current state
+ * @context: New context
+ * @stream: Stream getting the update for the flip
+ *
+ * The function takes in current state and new state and determine a minimal transition state
+ * as the intermediate step which could make the transition between current and new states
+ * seamless. If found, it will commit the minimal transition state and update current state to
+ * this minimal transition state and return true, if not, it will return false.
+ *
+ * Return:
+ * Return True if the minimal transition succeeded, false otherwise
+ */
+static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
@@ -4056,12 +4088,6 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 	struct pipe_split_policy_backup policy;
 
 	/* commit based on new context */
-	/* Since all phantom pipes are removed in full validation,
-	 * we have to save and restore the subvp/mall config when
-	 * we do a minimal transition since the flags marking the
-	 * pipe as subvp/phantom will be cleared (dc copy constructor
-	 * creates a shallow copy).
-	 */
 	minimal_transition_context = create_minimal_transition_state(dc,
 			context, &policy);
 	if (minimal_transition_context) {
@@ -4078,7 +4104,7 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 
 	if (!success) {
 		/* commit based on current context */
-		restore_plane_states_for_stream(dc->current_state->scratch.plane_states, stream);
+		restore_planes_and_stream_state(&dc->current_state->scratch, stream);
 		minimal_transition_context = create_minimal_transition_state(dc,
 				dc->current_state, &policy);
 		if (minimal_transition_context) {
@@ -4091,7 +4117,7 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 			}
 			release_minimal_transition_state(dc, minimal_transition_context, &policy);
 		}
-		restore_plane_states_for_stream(context->scratch.plane_states, stream);
+		restore_planes_and_stream_state(&context->scratch, stream);
 	}
 
 	ASSERT(success);
@@ -4099,7 +4125,7 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 }
 
 /**
- * commit_minimal_transition_state - Create a transition pipe split state
+ * commit_minimal_transition_state_legacy - Create a transition pipe split state
  *
  * @dc: Used to get the current state status
  * @transition_base_context: New transition state
@@ -4116,7 +4142,7 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
  * Return:
  * Return false if something is wrong in the transition state.
  */
-static bool commit_minimal_transition_state(struct dc *dc,
+static bool commit_minimal_transition_state_legacy(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
 	struct dc_state *transition_context;
@@ -4354,53 +4380,6 @@ static bool fast_update_only(struct dc *dc,
 			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
 }
 
-static bool should_commit_minimal_transition_for_windowed_mpo_odm(struct dc *dc,
-		struct dc_stream_state *stream,
-		struct dc_state *context)
-{
-	struct pipe_ctx *cur_pipe, *new_pipe;
-	bool cur_is_odm_in_use, new_is_odm_in_use;
-	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
-	struct dc_stream_status *new_stream_status = stream_get_status(context, stream);
-
-	if (!dc->debug.enable_single_display_2to1_odm_policy ||
-			!dc->config.enable_windowed_mpo_odm)
-		/* skip the check if windowed MPO ODM or dynamic ODM is turned
-		 * off.
-		 */
-		return false;
-
-	if (context == dc->current_state)
-		/* skip the check for fast update */
-		return false;
-
-	if (new_stream_status->plane_count != cur_stream_status->plane_count)
-		/* plane count changed, not a plane scaling update so not the
-		 * case we are looking for
-		 */
-		return false;
-
-	cur_pipe = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, stream);
-	new_pipe = resource_get_otg_master_for_stream(&context->res_ctx, stream);
-	if (!cur_pipe || !new_pipe)
-		return false;
-	cur_is_odm_in_use = resource_get_odm_slice_count(cur_pipe) > 1;
-	new_is_odm_in_use = resource_get_odm_slice_count(new_pipe) > 1;
-	if (cur_is_odm_in_use == new_is_odm_in_use)
-		/* ODM state isn't changed, not the case we are looking for */
-		return false;
-
-	if (dc->hwss.is_pipe_topology_transition_seamless &&
-			dc->hwss.is_pipe_topology_transition_seamless(
-					dc, dc->current_state, context))
-		/* transition can be achieved without the need for committing
-		 * minimal transition state first
-		 */
-		return false;
-
-	return true;
-}
-
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -4433,7 +4412,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 
 	/* on plane addition, minimal state is the current one */
 	if (force_minimal_pipe_splitting && is_plane_addition &&
-		!commit_minimal_transition_state(dc, dc->current_state))
+		!commit_minimal_transition_state_legacy(dc, dc->current_state))
 				return false;
 
 	if (!update_planes_and_stream_state(
@@ -4448,32 +4427,19 @@ bool dc_update_planes_and_stream(struct dc *dc,
 
 	/* on plane removal, minimal state is the new one */
 	if (force_minimal_pipe_splitting && !is_plane_addition) {
-		/* Since all phantom pipes are removed in full validation,
-		 * we have to save and restore the subvp/mall config when
-		 * we do a minimal transition since the flags marking the
-		 * pipe as subvp/phantom will be cleared (dc copy constructor
-		 * creates a shallow copy).
-		 */
-		if (!commit_minimal_transition_state(dc, context)) {
+		if (!commit_minimal_transition_state_legacy(dc, context)) {
 			dc_state_release(context);
 			return false;
 		}
 		update_type = UPDATE_TYPE_FULL;
 	}
 
-	/* when windowed MPO ODM is supported, we need to handle a special case
-	 * where we can transition between ODM combine and MPC combine due to
-	 * plane scaling update. This transition will require us to commit
-	 * minimal transition state. The condition to trigger this update can't
-	 * be predicted by could_mpcc_tree_change_for_active_pipes because we
-	 * can only determine it after DML validation. Therefore we can't rely
-	 * on the existing commit minimal transition state sequence. Instead
-	 * we have to add additional handling here to handle this transition
-	 * with its own special sequence.
-	 */
-	if (should_commit_minimal_transition_for_windowed_mpo_odm(dc, stream, context))
-		commit_minimal_transition_state_for_windowed_mpo_odm(dc,
+	if (dc->hwss.is_pipe_topology_transition_seamless &&
+			!dc->hwss.is_pipe_topology_transition_seamless(
+					dc, dc->current_state, context)) {
+		commit_minimal_transition_state(dc,
 				context, stream);
+	}
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3a6bf77a6873..b1b72e688f74 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -522,6 +522,25 @@ struct dc_dmub_cmd {
 	enum dm_dmub_wait_type wait_type;
 };
 
+struct dc_scratch_space {
+	/* used to temporarily backup plane states of a stream during
+	 * dc update. The reason is that plane states are overwritten
+	 * with surface updates in dc update. Once they are overwritten
+	 * current state is no longer valid. We want to temporarily
+	 * store current value in plane states so we can still recover
+	 * a valid current state during dc update.
+	 */
+	struct dc_plane_state plane_states[MAX_SURFACE_NUM];
+	struct dc_gamma gamma_correction[MAX_SURFACE_NUM];
+	struct dc_transfer_func in_transfer_func[MAX_SURFACE_NUM];
+	struct dc_3dlut lut3d_func[MAX_SURFACE_NUM];
+	struct dc_transfer_func in_shaper_func[MAX_SURFACE_NUM];
+	struct dc_transfer_func blend_tf[MAX_SURFACE_NUM];
+
+	struct dc_stream_state stream_state;
+	struct dc_transfer_func out_transfer_func;
+};
+
 /**
  * struct dc_state - The full description of a state requested by users
  */
@@ -604,16 +623,8 @@ struct dc_state {
 		unsigned int stutter_period_us;
 	} perf_params;
 
-	struct {
-		/* used to temporarily backup plane states of a stream during
-		 * dc update. The reason is that plane states are overwritten
-		 * with surface updates in dc update. Once they are overwritten
-		 * current state is no longer valid. We want to temporarily
-		 * store current value in plane states so we can still recover
-		 * a valid current state during dc update.
-		 */
-		struct dc_plane_state plane_states[MAX_SURFACE_NUM];
-	} scratch;
+
+	struct dc_scratch_space scratch;
 };
 
 struct replay_context {
-- 
2.43.0

