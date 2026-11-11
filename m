Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037E606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h/yTU8d7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013BC10F8D1;
	Wed, 11 Nov 2026 01:42:44 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689C610F8D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpRnVQ5RLvmAXGPNKhLVn6391NzZle5q0vhRHd7e25EEhU7eEokC0u4KoIo1S6/x803sso4wbsf6p02RFK1CFyeo2Bb9lrxfbCEViGN7I8VK6S8I0vaz6dshbgmPFx+YDypwgPOjD4E10LZWBRN/MeoCGs9J7XiEWpcWjXbWAPQl2ih8wgODWkSxbdwIpGDId+9aPnA9QVabFw7odbD7rJPlYN9iySDW+3+PRiaKabPhS1HzY+dxmukgP1g3iQvY2B74kpCUd6NAIzSCECKrmLdVifwgzp6OsoFqAhX2nEazOvisjioLqK926NooZjwqVuQUgmgU3p5aXrRxApBk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/nBWa7JJQJC4zZiK9YOjYIZBT/YpVHS7niV7twn7ZQ=;
 b=YgvguFc6bAugl3n/EXW+ADvfh99oew90jTvI6e22IoIlfAjEdmKxwcvBNGrULT7HwO+n8dUWPgKX/oOzlG/m08E1VDRlPp0uAwxBiEeYIIFTzmDKeJT4QKyU9Nzryy5/vwLNExEljX/9XReLn16XTMjuQFzCLk9Kwz4dnKRTmd9HmTwfHcAFjgslaeh09q0zBeZoavtdZeA6MAMpnoUz6t3Yn+KSnq2ES5pN6AuzK5gwZzZDs094hDInP5GvvLiSS250ZRDWLZV1Cm0fTLgSFew8TwQaMuAcB7U6ghLGE8KXcGw8fh2aBFTAL1XArc7Lq8UlqWrVIbYX7rztnfSTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/nBWa7JJQJC4zZiK9YOjYIZBT/YpVHS7niV7twn7ZQ=;
 b=h/yTU8d7DNgbpNisE29s27sVqOGV6piR/PM+MJXkFJHjflB7XFVstuYoVrdDkT74YLDbbrmc/42px2G6+N/85QfPfPjI5TCYP7FM7REW9RVfye8U3HiP/VzQJtnZjSF+Fi2S/61lxsgqI6pdcRrBiHvlRLvfad9cnuQMzB5c2II=
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 01:42:32 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::42) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:28 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:25 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 33/74] drm/amd/display: Build the kept-plane surface update in
 DC2
Date: Wed, 11 Nov 2026 09:28:39 +0800
Message-ID: <20261111014100.3596072-34-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 264d5cba-6d29-4d8f-966d-08df3f950c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|3023799007|22082099003|6133799003|10067099003|56012099006|261022105027099003|11063799006|261026140227099003|261102123227099003|261009223027099003|261021123027099003|261026121527099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: IKkhbZBd7923njl5qGXsnsntySSqnNZXYGTeCQrCyNqFYoCNmCgJKbMESHZmikIUVElV1Aj9Oiisv0Y5v8fdCuT2Og6jVUUhSO9DWmiXj+MZQT8IXzF0BbROZhp/JcI2Thlm64XslLCcnJW+A1dChvh4Uo4vxAfJtAuuDCN18UUeiLoZasD1Lr4qovJoU+BttQAJo5tbicS7GEHAGqDUFnuhjEH2IgiNWpEGBJTn51Q3Ax5zqGTYBh7i0yJFuS/qUt/ae5M0pe9M8iRlVEmZEDP/m5fDqqu4vd0Myxl/S4Dw422vIDRpydtzwPLgLoE+9wCd48egq/TPl7t2ME0Bh+7sr2Ysd1c6wJJhP6YpmKyZEyuXEFE+kppfJYiu4GM3S5VkdrXspP47wY/qEIBjOpAzxURhJTXaG1Cii1WDzg7KLQ81BFhzH61eHpi5Kw6kts4nWj4OgClS1pBW9Qe0qDt7luQD8DMN2B+zsRlTtGFKZftGoJLUZsvc7udlDGd0nxhx9Y9gcjFeUzMMll/RcFvi/oVIW6rD1YjaGqsTao6YjNiReW9FAeT8XBuK5EF5o1sCfZOlSqx3srUMMMumGrogj9ShHZ4/MeDknG4q9RM1hjD7cCJXuFoy1qyUik4LGQ4ulqWs0okqe2wU0K7arhh9GZQ8rZz+639Y+/XVMw7+uLKiclWq5rnFUoMWEH5V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(3023799007)(22082099003)(6133799003)(10067099003)(56012099006)(261022105027099003)(11063799006)(261026140227099003)(261102123227099003)(261009223027099003)(261021123027099003)(261026121527099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3HOXEPbgrxm8jV3jIJ+jAmTRXLr8HrlBU/Rm0vcjvSqEd5pORjoLT8uM0Xop/GBNBdNFlmT6YNKiwfWHeEyCl0wkUK0X0K/WFQtnkZw6HFuH+ZQhftdiWUDvvWBb/DP0VBs1uJHp/ncM+4eYpwJBtoZ/ltr+efij4kEjU6FSCnt1DEa+OrgsL3Jdi7EMOHtmLeGXpoOsK4cV44FbRK05im7S4UTFLKqUrzuaPH/5z18VlHSCr4i3r9NW8NVL2loXi2Ry/+903/JjAvhnE+hDe2FGnyzT0obhtQL0M0qmmkmjNXKeM4lcIPTjsuHWGThstXEtpx6Pg8H1p50QzwIIM9PCWkZx6fTQU16fR2Z7bnqj9Lo42DoErcu+gA3J5eA/AamyKPOVQNEDonrjMDpG/z/veEuYIz4Ojnhji2DYrvCoKT3/BLVYmy08z2VN6ma
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:29.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d5cba-6d29-4d8f-966d-08df3f950c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

From: Tony Cheng <tony.cheng@amd.com>

[Why]
With DC2 selected, a full update that keeps one plane and changes its
surface or address has no builder.

[How]
Accept a kept plane on the virtual stream. Emit the surface and address
steps without enable_plane. Reject a scaling or viewport change.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |   2 +
 .../dc/bls_builder/dcn401_commit_builder.c    | 165 +++++++++++++++---
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |   2 +-
 3 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index 2f3cb1457ebe..a3b27a179f20 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -115,6 +115,8 @@ struct dcn401_commit_step_meta {
 		bool optimized_not_required;
 		/* The plane has no address update, or skips the manual trigger. */
 		bool no_manual_trigger;
+		/* The OPP MPC tree has no plane yet. */
+		bool opp_tree_empty;
 	} skip_if;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index b6208a0ad164..a636e2bfe042 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -33,11 +33,13 @@
  * in head_sequence: the ODM double-buffer and blank waits come before the
  * bandwidth lower, so no tail is needed.
  *
- * DCN_DECL_SEAMLESS_UPDATE adds one plane to that stream. The sequence
- * follows the full update in commit_planes_for_stream on dcn401, all in
+ * DCN_DECL_SEAMLESS_UPDATE either adds one plane to that stream, or keeps
+ * one plane and programs its surface and address. The sequence follows
+ * the full update in commit_planes_for_stream on dcn401, all in
  * head_sequence: the outstanding updates, prepare_bandwidth and the
  * pending-update waits, then the locked front-end programming and
- * post_unlock_program_front_end. The bandwidth lower stays with
+ * post_unlock_program_front_end. A kept-plane update skips enable_plane
+ * and the stream unblank. The bandwidth lower stays with
  * dc_post_update_surfaces_to_stream.
  *
  * Neither builder emits a tail_sequence. A tail runs only after a vsync,
@@ -592,7 +594,7 @@ static enum bls_builder_result dcn401_check_non_seamless_commit_support(
 	return BLS_BUILD_SUCCESS;
 }
 
-/* The seamless update keeps the one stream and only adds its plane. */
+/* The seamless update keeps the one stream across the update. */
 static bool check_stream_kept(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -603,15 +605,33 @@ static bool check_stream_kept(const struct dc *dc,
 			current_state->streams[0] == new_state->streams[0];
 }
 
-static bool check_plane_added(const struct dc *dc,
-		const struct dc_state *current_state,
+static bool dcn401_is_plane_add(const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
 	return !current_state->stream_status[0].plane_count &&
 			new_state->stream_status[0].plane_count == 1;
 }
 
+static bool dcn401_is_plane_kept(const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	return current_state->stream_status[0].plane_count == 1 &&
+			new_state->stream_status[0].plane_count == 1;
+}
+
+/*
+ * The seamless update either adds the first plane, or keeps one plane and
+ * programs its surface and address. Scaling and viewport stay rejected.
+ */
+static bool check_plane_add_or_kept(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	return dcn401_is_plane_add(current_state, new_state) ||
+			dcn401_is_plane_kept(current_state, new_state);
+}
+
 static bool check_same_otg_master_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -765,7 +785,11 @@ static bool check_no_flip_int(const struct dc *dc,
 }
 
 /* With an empty tree, DC1 removes no MPCC before the insert. */
-static bool check_opp_tree_empty(const struct dc *dc,
+/*
+ * Plane add needs an empty OPP tree. A kept-plane update removes the MPCC
+ * that is already there, so a non-empty tree is fine.
+ */
+static bool check_opp_tree_for_update(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
@@ -774,17 +798,47 @@ static bool check_opp_tree_empty(const struct dc *dc,
 	unsigned int i;
 
 	(void)dc;
-	(void)current_state;
 	if (!pipe)
 		return false;
 	opp = pipe->stream_res.opp;
-	if (!opp || opp->mpc_tree_params.opp_list)
+	if (!opp)
 		return false;
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (opp->mpcc_disconnect_pending[i])
 			return false;
 	}
-	return true;
+	if (dcn401_is_plane_kept(current_state, new_state))
+		return true;
+	return !opp->mpc_tree_params.opp_list;
+}
+
+/*
+ * A kept-plane update does not yet emit scaler or viewport steps. Plane
+ * add has no current plane, so those rects are not compared.
+ */
+static bool check_no_scale_or_viewport(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *current_pipe = dcn401_otg_of(current_state);
+	const struct pipe_ctx *new_pipe = dcn401_otg_of(new_state);
+	const struct dc_plane_state *current_plane;
+	const struct dc_plane_state *new_plane;
+
+	(void)dc;
+	if (dcn401_is_plane_add(current_state, new_state))
+		return true;
+	if (!current_pipe || !new_pipe || !current_pipe->plane_state ||
+			!new_pipe->plane_state)
+		return false;
+	current_plane = current_pipe->plane_state;
+	new_plane = new_pipe->plane_state;
+	return !memcmp(&current_plane->src_rect, &new_plane->src_rect,
+			sizeof(current_plane->src_rect)) &&
+			!memcmp(&current_plane->dst_rect, &new_plane->dst_rect,
+					sizeof(current_plane->dst_rect)) &&
+			!memcmp(&current_plane->clip_rect, &new_plane->clip_rect,
+					sizeof(current_plane->clip_rect));
 }
 
 /* The update bypasses the plane gamut remap. */
@@ -982,31 +1036,33 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	/* The transition: one stream, kept, gains one plane on its OTG. */
+	/* The transition: one stream, kept; add a plane or keep one plane. */
 	CHECK_CONDITION(stream_kept, "stream is not kept across the update");
-	CHECK_CONDITION(plane_added, "update does not add exactly one plane");
+	CHECK_CONDITION(plane_add_or_kept,
+			"update is not a plane add or a kept-plane surface update");
 	CHECK_CONDITION(same_otg_master_blocks, "otg or opp changes");
 	CHECK_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
 	CHECK_CONDITION(plane_instances, "mpcc or dpp is not the hubp instance");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
+	CHECK_CONDITION(no_scale_or_viewport,
+			"scaling or viewport changes");
 
 	/* Under the lock, before the pipe is programmed. */
 	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
 	CHECK_CONDITION(no_sanity_checks, "sanity checks are enabled");
 	CHECK_CONDITION(no_pipe_wait, "pipe wait is required");
 
-	/* Unblank. */
+	/* Unblank / enable_plane: only the plane-add path emits these. */
 	CHECK_CONDITION(no_test_pattern, "test pattern is set");
 	CHECK_CONDITION(no_forced_dpg, "dpg is forced");
 	CHECK_CONDITION(no_abm_pipe, "abm is set");
-
-	/* enable_plane. */
 	CHECK_CONDITION(no_vm_aperture, "vm system aperture is valid");
 	CHECK_CONDITION(no_flip_int, "flip interrupt is enabled");
 
 	/* update_dchubp_dpp. */
-	CHECK_CONDITION(opp_tree_empty, "opp tree is not empty");
+	CHECK_CONDITION(opp_tree_for_update,
+			"opp tree is not ready for the update");
 	CHECK_CONDITION(no_plane_gamut_remap, "plane gamut remap is set");
 	CHECK_CONDITION(no_stream_gamut_remap, "stream gamut remap is set");
 	CHECK_CONDITION(no_output_csc, "output csc is set");
@@ -1333,6 +1389,35 @@ static const struct dcn401_commit_step
 	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true },
 };
 
+/*
+ * update_dchubp_dpp for a kept plane: surface and address only. No
+ * enable_plane, no scaler, no viewport. DC1 remove+insert when the OPP
+ * tree already holds the MPCC.
+ */
+static const struct dcn401_commit_step
+		bls_update_head_kept_update_dchubp_dpp[] = {
+	{ .func = DPP_SETUP_DPP },
+	{ .func = DPP_SET_CURSOR_MATRIX },
+	{ .func = DPP_PROGRAM_BIAS_AND_SCALE },
+	{ .func = MPC_REMOVE_MPCC,
+	  .meta.skip_if.opp_tree_empty = true },
+	{ .func = MPC_INSERT_PLANE },
+	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
+	{ .func = HUBP_PROGRAM_MCACHE_ID },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id =
+			MPCC_MCM_FIRST_GAMUT_REMAP },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id =
+			MPCC_MCM_SECOND_GAMUT_REMAP },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id = MPCC_OGAM_GAMUT_REMAP },
+	{ .func = MPC_POWER_ON_MPC_MEM_PWR },
+	{ .func = MPC_SET_OCSC_DEFAULT },
+	{ .func = HUBP_PROGRAM_SURFACE_CONFIG },
+	{ .func = HUBP_UPDATE_PLANE_ADDR },
+};
+
 /*
  * set_hdr_multiplier, the input and MCM transfer functions, the output
  * transfer function and the OPP format.
@@ -1385,7 +1470,18 @@ static_assert(
 		ARRAY_SIZE(bls_update_head_new_update_dchubp_dpp) +
 		ARRAY_SIZE(bls_update_head_new_transfer_funcs) +
 		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
-		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
+		"dcn401 seamless plane-add head exceeds DC2_BLS_MAX_STEPS");
+static_assert(
+		ARRAY_SIZE(
+		bls_update_head_per_stream_per_otg_master_pipe_preamble) +
+		ARRAY_SIZE(bls_update_head_global_preamble) +
+		ARRAY_SIZE(bls_head_per_state_new) +
+		ARRAY_SIZE(
+		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
+		ARRAY_SIZE(bls_update_head_new_lock) +
+		ARRAY_SIZE(bls_update_head_kept_update_dchubp_dpp) +
+		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
+		"dcn401 seamless kept-plane head exceeds DC2_BLS_MAX_STEPS");
 
 /* pipe is NULL only for the bandwidth and p-state steps. */
 struct dcn401_commit_step_args {
@@ -2209,6 +2305,10 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			(!args->pipe->plane_state->update_bits.addr_update ||
 			args->pipe->plane_state->skip_manual_trigger))
 		return true;
+	if (step->meta.skip_if.opp_tree_empty &&
+			(!args->pipe->stream_res.opp ||
+			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
+		return true;
 	return false;
 }
 
@@ -2302,6 +2402,7 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	struct dcn401_commit_step_args state_args;
 	struct block_sequence_state head;
 	enum bls_builder_result result;
+	bool plane_add;
 
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
@@ -2310,6 +2411,8 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
+	plane_add = dcn401_is_plane_add(params->current_state,
+			params->new_state);
 	dcn401_init_and_unpack_params(params, &state_args, &head);
 	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
 			state_args.current_state,
@@ -2324,14 +2427,24 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	/* One stream, so adding each table per stream keeps the DC1 order. */
 	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
 			bls_update_head_new_lock);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
-			bls_update_head_new_stream);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
-			bls_update_head_new_enable_plane);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
-			bls_update_head_new_update_dchubp_dpp);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
-			bls_update_head_new_transfer_funcs);
+	if (plane_add) {
+		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+				state_args.new_state,
+				bls_update_head_new_stream);
+		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+				state_args.new_state,
+				bls_update_head_new_enable_plane);
+		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+				state_args.new_state,
+				bls_update_head_new_update_dchubp_dpp);
+		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+				state_args.new_state,
+				bls_update_head_new_transfer_funcs);
+	} else {
+		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+				state_args.new_state,
+				bls_update_head_kept_update_dchubp_dpp);
+	}
 	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
 			bls_update_head_new_unlock);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 295d2d8b277e..85d9aa1614f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -295,7 +295,7 @@ static bool core2_update_state_supported(
 	if (scratch->update_type != UPDATE_TYPE_FULL ||
 			scratch->flow != UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS)
 		return false;
-	/* The full-update builder adds one plane. */
+	/* The full-update builder adds or keeps one plane. */
 	if (scratch->surface_count != 1)
 		return false;
 	if (!core2_stream_update_supported(scratch->stream_update))
-- 
2.43.0

