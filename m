Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8483606A33B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hRb/SUgT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4600510F844;
	Tue, 17 Nov 2026 17:16:51 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D2010F841
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqDwfxbOzzZaXECe95P6nOx809IGB0ezz1OOh8kwF5yWQqHxIlDfscrY59EBCVnwWkwl0u7yJY2UV2nwoe2oke2p/evZpnFZIWve+VMnuPDc0tcDr8NXNseLHTEKWy6d4miA1fjB1cgy92Bd7zM0DwjIKsBA/kqTGTzJEtaxHMijjYmPTmq2sJ9EHRMwgbqDOSvx636zme/vVWPTb9KQXMuGNaSJzDTes51Bk3NMOBLw0SfIwV61aBkALFTcnyxSbtq4ztLJJ5PLhuotp40tUlqsUDdCAFydludWjkEW++D9MIXEPd5nvb5P7jTPirzbbMh04TYYJaT3jFos/cB8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWXkuPOnsxTS8AWmxd9wnGRiQoxM9qeDci53DB6jaik=;
 b=dp8lPf4vgrC5araMTc2Pg0yQrC/ggV1p48D3WN6ZTh4Y3mGi/KtDldPCh3vjrJsVblgBax6SWzUJPCflCRAxiUrcUe4uEZIzQhn4+MMXEJb8dRjIOswaLz7PJnRAp2Ibh91PxDUSyod7/Dn0Z96tjA4dW5waBMNuerQDhgfMqxTanEIHp9BoKjbujERzRkuPqyIK5DYvgK1BMEGdrY4mponZWxOcgxa+TypZoPEl6trzRPnUx65ixDyDE9SG1ygWYA+JuzL7TpkPPGtRPvmsG26XLKPRgYSJk7yaUXDvQxf8WfOGzRs3a60wQtnfC9ZLf+yV4iNA6zVRQxwcfP0reA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWXkuPOnsxTS8AWmxd9wnGRiQoxM9qeDci53DB6jaik=;
 b=hRb/SUgT51jfjarEeUjVhGS4pcvWOrzRWZmYu9UiVze/l5AS6hFlE1PDA6bBTWcIEpGkpkk5jiw17J7EdbY5C702kP45iSV/9d60XPk4+lyK0Nc/CPhfXizMql26MNFFlsl+zkXdJ+xA5yfAoevxH7evS7ADqqQS5FthPkHJpdE=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:16:38 +0000
Received: from IA0PEPF00000042.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a0) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:16:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000042.mail.protection.outlook.com (10.167.249.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:37 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:28 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 26/33] drm/amd/display: Add a plane beside a kept plane in DC2
 update
Date: Tue, 17 Nov 2026 05:51:03 +0800
Message-ID: <20261116215641.2800595-27-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000042:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 306276ea-7720-4e2f-0b0a-08df44ce8a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Lw6Lc97rJsZTjHfTmvvF/btAkoXLY8b9GDb/IpgGt1HjtaPnS9PnYn4g3QKGTKPxq0B/4CXnbPiTcGrcnpBaHPf1G2ZyKlYODBfG14RpDpqRLBWP1eK90NrRTcUuFDgYSpUKdE4uFprNvaQHTbvIHJIEUqwDjcbmV1BvqlM+FfXwIM8bGN+kxOPre4fE9PT/RUeT/SiUOAWo0+t8VdTyeEeh+W5QwUeWhtIxC3f6FuxTwU5t8jW9ajMPtAmebEJXYoqKHD00fNskCZwSDL2EKPQ19uFBb19OGQEQ8Bawb24ZAYcmRaVd2tjZq+7rcA5fUm8P62zcme/gLfex4LKfLWko2/CAP0bMmKjpJS6jLPGRE6GkY25uOeN4Br0ryzD64DCl826G9c2CUC9p/CWE6beuJprr1eHTsOOnplkagmGLBc4MHSpyoXiw1yKR0qhia86LjqkYIYHlMQA/LcIgGw5zwp6ipmPnONTazLC3vdzn4F5oXS3jSqPAte1iusgufHQC/W1kCWGgqfzB90nIVNUCI15Md+FBLaBpR/iP8UMYBIvoEwidtHUIUze0fGv1/YrIuVeMW1GNTiGUMW2alaH/Wjz4RZifJQpKqCqXu9j9WfNlw0e+N3TcT0rVhEU0hZd65qoFlOnjvzeuMbD0bqt6dYzTDT1YfsmXWuc1h8duHWItTczc6TmWI1UTHpSfFONmpQMJ5IsqT6GO1JsPKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e0npxp2LyLShCHOrJ9qbVkU2swkIThpkkNiW0oTy08xstKQtF63mO7JZ19Ue28uH3eqRSNY31BaWID0eJXycXNOeonfFp6lnrPwzM94AInQEcREFKcqKwqb+sKXTEPdeWbrTY2fCtFW/0HsPe22Cg1FElzT0unu/YgoKaJvANx34iWgTfiboF6Ve/prqP+NHl1TMzXspDw4nT/S98YqYoPXtvdRN7rBK/sUqEssMLoPVQXwOhBhmFkCrMwbJLQF0sd9lKLS0Y0biG1g4NelTeSufxp9y79HZ5lXKzYqKNuvWrf8Vpzt58x4eVG1UZJRrjFsF0Gzz2jVaTNqLLu1TFmI/94uDk+yA1S82zhhpR31nrkq16M2VAiuxilRafAY3VYMpXwDywn4dGBnSZW+smWacvfdk+Q0xGSYQd2iTwLt1bz0GBj80w8ioTO1UoQX9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:38.3530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306276ea-7720-4e2f-0b0a-08df44ce8a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000042.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The DC2 seamless update builder accepts a plane add only on a stream
with no plane. An update that adds a second plane to a stream fails.

[How]
Accept one or two kept planes and at most one added plane. Each kept
plane stays on its pipe, HUBP and DPP. Skip the first-enable steps of a
kept pipe, and program the DET segments when its DET size changes.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |  7 +-
 .../dc/bls_builder/dcn401_seamless_builder.c  | 72 ++++++++++++++-----
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index cc301a02c494..ed9d2f7fc0a2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -116,10 +116,13 @@ struct dcn401_commit_step_meta {
 		/* The OPP MPC tree has no plane yet. */
 		bool opp_tree_empty;
 		/*
-		 * The HUBP/DPP block is already on. The step is part of
-		 * enabling that block the first time, not of reconfiguring it.
+		 * The pipe already showed the plane on this HUBP. The step is
+		 * part of enabling that block the first time, not of
+		 * reconfiguring it.
 		 */
 		bool hubp_dpp_already_enabled;
+		/* As hubp_dpp_already_enabled, and the DET size is the same. */
+		bool det_unchanged;
 		/*
 		 * Neither the plane scaling, the plane position nor the
 		 * stream scaling changed. A full update sets every plane bit,
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 09ea7ba26452..178598f18517 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -30,14 +30,15 @@
  * DCN_DECL_NON_SEAMLESS_COMMIT (dcn401_non_seamless_builder.c) enabled.
  * The other streams keep their pipes and planes, and the update programs
  * none of them. The update either adds one plane, or two MPC-blended
- * planes, to the stream, or keeps one plane and programs its surface,
- * address, scaler and viewport. The sequence follows the full update in
+ * planes, to the stream, or keeps its planes and programs their surface,
+ * address, scaler and viewport, and may add a second plane below a kept
+ * one. The sequence follows the full update in
  * commit_planes_for_stream on dcn401, all in head_sequence: the
  * outstanding updates, prepare_bandwidth and the pending-update waits,
  * then the locked front-end programming and
- * post_unlock_program_front_end. A kept-plane update skips enable_plane
- * and the stream unblank. The bandwidth lower stays with
- * dc_post_update_surfaces_to_stream.
+ * post_unlock_program_front_end. A kept plane skips the first-enable steps
+ * of enable_plane, and a stream that had a plane skips the unblank. The
+ * bandwidth lower stays with dc_post_update_surfaces_to_stream.
  *
  * This file also holds what both builders share: the dc and stream
  * support checks, and the step walkers that turn a table into BLS entries.
@@ -517,17 +518,40 @@ static bool dcn401_is_plane_add(const struct dc_state *current_state,
 			(planes == 1 || planes == 2);
 }
 
+/*
+ * Each current plane stays on its pipe, HUBP and DPP, and at most one
+ * plane is added under them.
+ */
 static bool dcn401_is_plane_kept(const struct dc_state *current_state,
 		const struct dc_state *new_state, unsigned int i)
 {
-	return dcn401_current_plane_count(current_state, new_state, i) == 1 &&
-			new_state->stream_status[i].plane_count == 1;
+	unsigned int planes = dcn401_current_plane_count(current_state,
+			new_state, i);
+	const struct pipe_ctx *cur, *new;
+	unsigned int j;
+
+	if (!planes || new_state->stream_status[i].plane_count < planes ||
+			new_state->stream_status[i].plane_count > 2)
+		return false;
+	for (j = 0; j < MAX_PIPES; j++) {
+		cur = &current_state->res_ctx.pipe_ctx[j];
+		new = &new_state->res_ctx.pipe_ctx[j];
+		if (cur->stream != new_state->streams[i] || !cur->plane_state)
+			continue;
+		if (new->stream != cur->stream ||
+				new->plane_state != cur->plane_state ||
+				new->plane_res.hubp != cur->plane_res.hubp ||
+				new->plane_res.dpp != cur->plane_res.dpp ||
+				!new->top_pipe != !cur->top_pipe)
+			return false;
+	}
+	return true;
 }
 
 /*
  * The seamless update either adds the first one or two planes, or keeps
- * one plane and programs its surface, address, scaler and viewport. Each
- * plane has its own DPP pipe.
+ * the planes and programs their surface, address, scaler and viewport,
+ * and may add a second plane below one. Each plane has its own DPP pipe.
  */
 static bool check_plane_add_or_kept(const struct dc *dc,
 		const struct dc_state *current_state,
@@ -940,7 +964,7 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	CHECK_UPDATE(streams_kept,
 			"a stream is not kept, or another stream changes");
 	CHECK_UPDATE(plane_add_or_kept,
-			"update is not a plane add or a kept-plane surface update");
+			"update is not a plane add, or keeps a plane off its pipe");
 	CHECK_UPDATE(same_otg_master_blocks, "otg, opp or odm changes");
 	CHECK_UPDATE_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
@@ -1104,7 +1128,7 @@ static const struct dcn401_commit_step enable_plane[] = {
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
 	  .meta.hubp_program_det_segments.allocate = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.det_unchanged = true },
 	/*
 	 * update_dchubp_dpp. First enable runs the whole table. A reconfigure
 	 * skips the steps that only bring the HUBP/DPP up, and programs the
@@ -2069,6 +2093,16 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	}
 }
 
+static bool dcn401_pipe_already_enabled(
+		const struct dcn401_commit_step_args *args)
+{
+	const struct pipe_ctx *cur =
+			&args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
+
+	return cur->plane_state && cur->stream == args->pipe->stream &&
+			cur->plane_res.hubp == args->pipe->plane_res.hubp;
+}
+
 static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *step)
 {
@@ -2087,10 +2121,12 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
 		return true;
 	if (step->meta.skip_if.hubp_dpp_already_enabled &&
-			dcn401_stream_index(args->current_state,
-			args->pipe->stream) >= 0 &&
-			args->current_state->stream_status[dcn401_stream_index(
-			args->current_state, args->pipe->stream)].plane_count)
+			dcn401_pipe_already_enabled(args))
+		return true;
+	if (step->meta.skip_if.det_unchanged &&
+			dcn401_pipe_already_enabled(args) &&
+			args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx]
+			.hubp_regs.det_size == args->pipe->hubp_regs.det_size)
 		return true;
 	if (step->meta.skip_if.scaling_unchanged &&
 			!args->pipe->plane_state->update_bits.scaling_change &&
@@ -2223,9 +2259,9 @@ void dcn401_init_and_unpack_params(
 }
 
 /*
- * The updated stream only. skip_if drops first-enable steps when the
- * HUBP/DPP is already on, so a kept-plane surface update is the same
- * table. The enable_plane list runs per DPP pipe, top pipe first, so the
+ * The updated stream only. skip_if drops first-enable steps on a pipe
+ * that already showed its plane, so a kept-plane surface update is the
+ * same table. The enable_plane list runs per DPP pipe, top pipe first, so the
  * top MPCC is inserted before the bottom one.
  */
 static const struct dcn401_sub_sequence bls_update_head[] = {
-- 
2.43.0

