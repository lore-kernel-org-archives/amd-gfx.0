Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB30606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ak8VNTt5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FFF10F841;
	Tue, 17 Nov 2026 17:17:14 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773CC10F841
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAiQlLh1/FOvexHkttYXd86rlYrR0xKIVZp6TzrrxwFN6Uf2c8P+jzGn19wQDp6pwK6qx1LHw++ous4DDXrW4rPJ0qnkaZXzpf6lb+8RwMj9t62uikc9w1mc06JAS3nnIjgwiI4pQYlFpzJvP3OC/B6GYkkQCLjtNGot8hCiDJLXYP3RWBPWiZqajn0fzEKtDZNDzGUlWN9tM15bhzJRrkNvP7rNJWnMD6WeDRgUO9sQbmg6TUMVBW4HzDfQItHbhG3O3CjCUU6jBMeKTQ1OHr9z5Xh85QkB3TRpRnd8BWF3kkr9MLATGh3zYbsn43K7yfCUnfWZyokCk55oYOWPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VixtjYkW4McpdTqxoCjpLPQnnT7FKSR60ozg6u7O7uE=;
 b=irAL8NmMf4MgiPKueW/oHNebzSFtqIEOmXqxXl/EAv5KMX06n+oI6bDwPoDbtgxXCR1BAbf5Rljo7+OGwJSb8ODmsqeEW5+/5a7vfUhXNmdBuxHe7CgbzyarRtfXa/TbZJ9ztxesm3VllMNad6k2XXciCVGxkZQ8O41QqifG4aklJYtEtlw1uzJb+IA9z3LeZlVhoaPeVaW+JoKsdH3Wmk05GO7/IYOpT3MLpdAOLl/1EIuPPUR0pGQtcV3yiuHqn0Ogbmnj0dcGJ13Ruy7y+WOPJjHYUAW2BoDbQvdtex9/DPTtDv1RPm89AH29J+X3yXPyf9d7EZ4dnPni/eFikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VixtjYkW4McpdTqxoCjpLPQnnT7FKSR60ozg6u7O7uE=;
 b=ak8VNTt5s/kPS0IGLavde2vzYTKjVHf43aQ/bbp+kFzeRln+A7+5dkZkZCqOd+y+6CM8CkLnnMgpmhaYPGbAqqfVl0I2nXg6RzozKoz2UUbJyFQhwvcVhkcWIofPzOOMKaBWcV8MpTjDCHY9zhSRojIbUTfgQVAlVx6ZqMnK95c=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:17:00 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::1c) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:17:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:56 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:47 -0600
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
Subject: [PATCH 28/33] drm/amd/display: Change the ODM and MPC layout in DC2
 update
Date: Tue, 17 Nov 2026 05:51:05 +0800
Message-ID: <20261116215641.2800595-29-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3e531e-32df-43c1-ab46-08df44ce96c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|6133799003|22082099003|261009220027099003|261009221727099003|261009221227099003|261009223327099003|261009223027099003|20052099010|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 7SIC9/H6I9WTyEaJQIpB5iD8/2Qi+8Xy9I0SQP+mevKYLgRnDBowemhutP7d0+PZP9jFQe36uh/0Nuc3DbiRTACYCTaXWhARcV/OCoKM7o1WCtfK9YsEiEz1Y+oxsowC65ulBGDGD+lwMJ5lWLpMtcJx1KdlTlJVIOIT7LfhONJK1D/87U/znL4zL8zLPvZToE+PwUZPPWxmTDWkgvbKVpiIUjYLvY0aKQL0JV7A4XZL6vWDy87JzJDCgRcMNp2DpPNgiuUt+W+dvHA9GSnmDOJ1FWiuCrW1ZqPvxY2BUdJvhhjD9JNXw2SedwHwQWC10UxAoB7DGMvyRr0jjY36EzKbGPb2Q31vcu8PWf1Yq9MPrfmRknSliVhehnycEEXovXRWXKkIiCbNljxHcvZ4MxEJqrnrVj761NDFgYW7pvc4ywV4UzHLlo2LO2KgGVHNJaMAHdE7EuoenD+UzS4gHYH5tXMVobb3rzIFm38HDEpc9N0kP9I4V3TNVDtaFi50vpnBm0uWoXzDCYlAsgukLzF+ebaCQmWnK+cgBZY652A4cK+oxkSM6gGI1rMGx1s5BYO0pi3ouUE4nA/+x5WSnUjh/QSfC3Yoir8zU83t3JcLUN+U4DaqW+zBPRXuzxgo7haqWreDoLUPTu7YvoPqYv++RCP7VK2GvVjmmu4r76Azm+xpW1GP7yKE2riq5WFGvpoJctn3xpOmnIrrFYKS8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(22082099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009223027099003)(20052099010)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OYAdfLRqP8uAH5pJ1qaURSjiaPovAwtpDgjOpiuXpF9PH7634V3fAJQg5V/L33Q8nKFpqwchDDodxrcLyi4y0si/eX4mPaheIQyKUaUGIjVxLlGhly0WjQCWA+XTTa8oKCVuZSDQjIG1iYbpZybbXccPPAAIPp+pWI+eQ75i5KMEXoEs4ZYUXNctOyaDc9b+ljIDCmkHEqYk5CtTQrciu7c988ha0I+8YUDMGTIzHXSx19N/O9DZNQarsO04U4mXqWXIXnoUmHhlvh02e+8PdzNVMbqOuTbgdGjnL1mSCAczdFDTpibxF2RDYH1kOrb4pqsOV/fkMyieaspy+/cektgkss/6jpgcfzn2uRraKOeGCkt6U2B8o0XMd+ZCnM8Ta0fIDz1OXaTup01a+zClR5sVXuBFfg67S32arFc2iz86kM2pA6ii+Y9sy/JuLZhq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:59.3029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3e531e-32df-43c1-ab46-08df44ce96c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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
The DC2 seamless update builder keeps the OPP of each ODM slice and
does not remove a pipe. An update between ODM 2:1 and ODM bypass with
two blended planes fails. The commit blanks a kept stream that
changes its layout.

[How]
Accept an update where each pipe keeps its plane and blocks, joins on
a free pipe, or leaves the stream on the same OTG. Under the lock,
disconnect the MPCC and DET of each removed pipe, and program the ODM
mode and each new OPP head. After the unlock, power down the removed
pipes and wait for the ODM double buffer. The commit keeps a stream
that keeps its OTG and programs its front end after the enable.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   8 +-
 .../bls_builder/bls_builder_private_types.h   |   9 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  36 +++
 .../bls_builder/dcn401_non_seamless_builder.c |  60 ++--
 .../dc/bls_builder/dcn401_seamless_builder.c  | 276 +++++++++++-------
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  79 +++--
 6 files changed, 305 insertions(+), 163 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index f899c27ea836..c9a4e59056ae 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -135,9 +135,11 @@ const struct bls_builder *bls_builder_create(struct dc *dc,
 		enum bls_builder_name name);
 
 /*
- * stream is in both states on the same pipes, each with the same plane
- * and blocks. DCN_DECL_NON_SEAMLESS_COMMIT leaves such a stream alone.
+ * stream is in both states and keeps its OTG, and the seamless update can
+ * program its front end. DCN_DECL_NON_SEAMLESS_COMMIT neither disables nor
+ * enables such a stream; it runs that front end when the stream changes.
  */
-bool dcn401_stream_unchanged(const struct dc_state *current_state,
+bool dcn401_stream_kept(const struct dc *dc,
+		const struct dc_state *current_state,
 		const struct dc_state *new_state,
 		const struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index ed9d2f7fc0a2..de73efe274c1 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -123,6 +123,15 @@ struct dcn401_commit_step_meta {
 		bool hubp_dpp_already_enabled;
 		/* As hubp_dpp_already_enabled, and the DET size is the same. */
 		bool det_unchanged;
+		/*
+		 * The current pipe had no plane, or keeps its plane, HUBP, DPP
+		 * and OPP in the new state.
+		 */
+		bool no_plane_removed;
+		/* As hubp_dpp_already_enabled, and each ODM slice keeps its OPP. */
+		bool odm_kept;
+		/* Each ODM slice of the stream keeps its OPP. */
+		bool same_opp_heads;
 		/*
 		 * Neither the plane scaling, the plane position nor the
 		 * stream scaling changed. A full update sets every plane bit,
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index 2d832017f613..e9f190176485 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -76,6 +76,27 @@ int dcn401_stream_index(const struct dc_state *state,
 		const struct dc_stream_state *stream);
 
 
+/*
+ * stream is in both states on the same pipes, each with the same plane
+ * and blocks.
+ */
+bool dcn401_stream_unchanged(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream);
+/*
+ * The pipe shows a plane on the same HUBP, DPP and OPP. The plane may be a
+ * new dc_plane_state; the update reprograms its contents.
+ */
+bool dcn401_pipe_kept(const struct pipe_ctx *current_pipe,
+		const struct pipe_ctx *new_pipe);
+/*
+ * What the seamless update needs of stream i of new_state, apart from the
+ * other streams.
+ */
+enum bls_builder_result dcn401_check_stream_update(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i);
+
 /* What both builders need of the dc, before either state. */
 enum bls_builder_result dcn401_check_dc_support(const struct dc *dc);
 /* What both builders need of each stream of a state, apart from its planes. */
@@ -122,6 +143,21 @@ void dcn401_add_sub_sequences(struct block_sequence_state *sequence,
 #define DCN401_ADD_SUB_SEQUENCES(sequence, args, subs) \
 	dcn401_add_sub_sequences(sequence, args, subs, ARRAY_SIZE(subs))
 
+#define DCN401_DISCONNECT_STEPS 2
+#define DCN401_POWER_DOWN_STEPS 12
+/*
+ * Per current DPP pipe that leaves the stream: the MPCC and DET disconnect
+ * under the lock, and disable_plane after it.
+ */
+extern const struct dcn401_commit_step
+		dcn401_disconnect[DCN401_DISCONNECT_STEPS];
+extern const struct dcn401_commit_step
+		dcn401_power_down[DCN401_POWER_DOWN_STEPS];
+
+/* The seamless update's front end for args->stream, between the waits. */
+void dcn401_add_stream_update(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *args);
+
 /*
  * Points the step arguments at the states and the sequence at
  * head_sequence, both empty. The entries point into the states; the build
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index dcd1c8a50429..f24480e949d6 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -12,11 +12,11 @@
 /*
  * DCN_DECL_NON_SEAMLESS_COMMIT for virtual streams. It disables every
  * current stream, each with one or two planes, one per DPP pipe, then
- * enables every new stream, each with no plane. A stream that is
- * unchanged keeps its pipes and planes, and the commit programs none of
- * them. Planes are added later by DCN_DECL_SEAMLESS_UPDATE. Each
- * stream is in ODM bypass, 2:1 or 3:1, with one OPP head and at most one
- * DPP pipe per slice.
+ * enables every new stream, each with no plane. A kept stream keeps its
+ * OTG, and the commit runs the seamless update's front end for it when its
+ * pipes or planes change. Planes are added later by
+ * DCN_DECL_SEAMLESS_UPDATE. Each stream is in ODM bypass, 2:1 or 3:1, with
+ * one OPP head and at most one DPP pipe per slice.
  *
  * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
  * calls in the same order, including the calls DC1 repeats. Everything is
@@ -131,7 +131,7 @@ static enum bls_builder_result dcn401_check_commit_state_support(
 			is_current ? NULL : state);
 	for (i = 0; result == BLS_BUILD_SUCCESS && i < state->stream_count;
 			i++) {
-		if (dcn401_stream_unchanged(current_state, new_state,
+		if (dcn401_stream_kept(dc, current_state, new_state,
 				state->streams[i]))
 			continue;
 		result = is_current ?
@@ -229,32 +229,10 @@ static const struct dcn401_commit_step blank[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
 };
 
-static const struct dcn401_commit_step disconnect[] = {
-	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
-	{ .func = MPC_REMOVE_MPCC },
-};
-
 static const struct dcn401_commit_step unlock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
 };
 
-static const struct dcn401_commit_step power_down[] = {
-	{ .func = MPC_ASSERT_IDLE_MPCC },
-	{ .func = HUBP_SET_BLANK },
-	{ .func = HUBP_UPDATE_MALL_SEL },
-	{ .func = HUBP_SET_FLIP_CONTROL_GSL },
-	{ .func = HUBP_CLK_CNTL },
-	{ .func = DPP_DPPCLK_CONTROL },
-	{ .func = DC_IP_REQUEST_STATUS, .meta.skip_if.no_ip_request = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
-	  .meta.skip_if.no_ip_request = true },
-	{ .func = HUBP_PG_CONTROL },
-	{ .func = HUBP_RESET },
-	{ .func = DPP_RESET },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
-	  .meta.skip_if.no_ip_request = true },
-};
-
 static const struct dcn401_commit_step stream_off[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 
@@ -390,9 +368,9 @@ static const struct dcn401_commit_step postamble[] = {
 static_assert(ARRAY_SIZE(prepare_bandwidth) +
 		ARRAY_SIZE(lock) +
 		DCN401_MAX_OPP_HEADS * ARRAY_SIZE(blank) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(disconnect) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(dcn401_disconnect) +
 		ARRAY_SIZE(unlock) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(power_down) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(dcn401_power_down) +
 		ARRAY_SIZE(stream_off) +
 		ARRAY_SIZE(postamble) <=
 		DC2_BLS_MAX_STEPS,
@@ -422,14 +400,14 @@ static const struct dcn401_sub_sequence bls_head[] = {
 	  .steps = blank,
 	  .count = ARRAY_SIZE(blank) },
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
-	  .steps = disconnect,
-	  .count = ARRAY_SIZE(disconnect) },
+	  .steps = dcn401_disconnect,
+	  .count = ARRAY_SIZE(dcn401_disconnect) },
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = unlock,
 	  .count = ARRAY_SIZE(unlock) },
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
-	  .steps = power_down,
-	  .count = ARRAY_SIZE(power_down) },
+	  .steps = dcn401_power_down,
+	  .count = ARRAY_SIZE(dcn401_power_down) },
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = stream_off,
 	  .count = ARRAY_SIZE(stream_off) },
@@ -460,6 +438,9 @@ static const struct dcn401_sub_sequence bls_head[] = {
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = front_end,
 	  .count = ARRAY_SIZE(front_end) },
+};
+
+static const struct dcn401_sub_sequence bls_postamble[] = {
 	{ .flags = DCN401_NEW_STATE,
 	  .steps = postamble,
 	  .count = ARRAY_SIZE(postamble) },
@@ -471,6 +452,7 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 	struct dcn401_commit_step_args state_args;
 	struct block_sequence_state head;
 	enum bls_builder_result result;
+	unsigned int i;
 
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
@@ -481,6 +463,16 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 
 	dcn401_init_and_unpack_params(params, &state_args, &head);
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_head);
+	for (i = 0; i < state_args.new_state->stream_count; i++) {
+		state_args.stream = state_args.new_state->streams[i];
+		if (dcn401_stream_kept(params->dc, params->current_state,
+				params->new_state, state_args.stream) &&
+				!dcn401_stream_unchanged(params->current_state,
+				params->new_state, state_args.stream))
+			dcn401_add_stream_update(&head, &state_args);
+	}
+	state_args.stream = NULL;
+	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_postamble);
 
 	return BLS_BUILD_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 3f0285763d52..5218ecfbc385 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -29,16 +29,17 @@
  * DCN_DECL_SEAMLESS_UPDATE for one of the virtual streams that
  * DCN_DECL_NON_SEAMLESS_COMMIT (dcn401_non_seamless_builder.c) enabled.
  * The other streams keep their pipes and planes, and the update programs
- * none of them. The update either adds one plane, or two MPC-blended
- * planes, to the stream, or keeps its planes and programs their surface,
- * address, scaler and viewport, and may add a second plane below a kept
- * one. The sequence follows the full update in
+ * none of them. The stream ends with one or two planes. Each of its pipes
+ * keeps a plane on its HUBP, DPP and OPP, is added on a free pipe, or leaves
+ * the stream, so the update can add and remove planes and change the ODM
+ * and MPC layout on the same OTG. The sequence follows the full update in
  * commit_planes_for_stream on dcn401, all in head_sequence: the
  * outstanding updates, prepare_bandwidth and the pending-update waits,
  * then the locked front-end programming and
- * post_unlock_program_front_end. A kept plane skips the first-enable steps
- * of enable_plane, and a stream that had a plane skips the unblank. The
- * bandwidth lower stays with dc_post_update_surfaces_to_stream.
+ * post_unlock_program_front_end. Under the lock, a removed pipe leaves its
+ * MPCC; after it, the pipe powers down. A kept pipe skips the first-enable
+ * steps of enable_plane. The bandwidth lower stays with
+ * dc_post_update_surfaces_to_stream.
  *
  * This file also holds what both builders share: the dc and stream
  * support checks, and the step walkers that turn a table into BLS entries.
@@ -500,93 +501,73 @@ static bool check_streams_kept(const struct dc *dc,
 	return true;
 }
 
-static unsigned int dcn401_current_plane_count(
-		const struct dc_state *current_state,
-		const struct dc_state *new_state, unsigned int i)
+bool dcn401_pipe_kept(const struct pipe_ctx *current_pipe,
+		const struct pipe_ctx *new_pipe)
 {
-	return current_state->stream_status[dcn401_stream_index(current_state,
-			new_state->streams[i])].plane_count;
-}
-
-/* Both planes of an MPO state are added together, by one update. */
-static bool dcn401_is_plane_add(const struct dc_state *current_state,
-		const struct dc_state *new_state, unsigned int i)
-{
-	unsigned int planes = new_state->stream_status[i].plane_count;
-
-	return !dcn401_current_plane_count(current_state, new_state, i) &&
-			(planes == 1 || planes == 2);
+	return current_pipe->plane_state &&
+			current_pipe->stream == new_pipe->stream &&
+			new_pipe->plane_state &&
+			current_pipe->plane_res.hubp == new_pipe->plane_res.hubp &&
+			current_pipe->plane_res.dpp == new_pipe->plane_res.dpp &&
+			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
 }
 
 /*
- * Each current plane stays on its pipe, HUBP and DPP, and at most one
- * plane is added under them.
+ * The stream shows one or two planes. Each of its pipes was free, or kept
+ * its OPP and either had no plane or keeps a plane on its HUBP and DPP. A
+ * current pipe that does neither is removed.
  */
-static bool dcn401_is_plane_kept(const struct dc_state *current_state,
+static bool check_pipes_kept_or_free(const struct dc *dc,
+		const struct dc_state *current_state,
 		const struct dc_state *new_state, unsigned int i)
 {
-	unsigned int planes = dcn401_current_plane_count(current_state,
-			new_state, i);
+	unsigned int planes = new_state->stream_status[i].plane_count;
 	const struct pipe_ctx *cur, *new;
+	struct dc_state_facts facts;
 	unsigned int j;
 
-	if (!planes || new_state->stream_status[i].plane_count < planes ||
-			new_state->stream_status[i].plane_count > 2)
+	(void)dc;
+	if (planes < 1 || planes > 2)
 		return false;
 	for (j = 0; j < MAX_PIPES; j++) {
 		cur = &current_state->res_ctx.pipe_ctx[j];
 		new = &new_state->res_ctx.pipe_ctx[j];
-		if (cur->stream != new_state->streams[i] || !cur->plane_state)
+		if (new->stream != new_state->streams[i] || !cur->stream)
 			continue;
-		if (new->stream != cur->stream ||
-				new->plane_state != cur->plane_state ||
-				new->plane_res.hubp != cur->plane_res.hubp ||
-				new->plane_res.dpp != cur->plane_res.dpp ||
-				!new->top_pipe != !cur->top_pipe)
+		if (cur->stream != new->stream ||
+				cur->stream_res.opp != new->stream_res.opp ||
+				(cur->plane_state && !dcn401_pipe_kept(cur, new)))
 			return false;
 	}
-	return true;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.global.blend_tree[i].dpp_pipe_count == planes;
 }
 
-/*
- * The seamless update either adds the first one or two planes, or keeps
- * the planes and programs their surface, address, scaler and viewport,
- * and may add a second plane below one. Each plane has its own DPP pipe.
- */
-static bool check_plane_add_or_kept(const struct dc *dc,
+static bool check_same_otg(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state, unsigned int i)
 {
-	struct dc_state_facts facts;
+	const struct pipe_ctx *cur = dcn401_otg_master(current_state,
+			new_state->streams[i]);
+	const struct pipe_ctx *new = dcn401_otg_master(new_state,
+			new_state->streams[i]);
 
 	(void)dc;
-	if (!dcn401_is_plane_add(current_state, new_state, i) &&
-			!dcn401_is_plane_kept(current_state, new_state, i))
-		return false;
-	dc_state_facts_derive(new_state, &facts);
-	return facts.global.blend_tree[i].dpp_pipe_count ==
-			new_state->stream_status[i].plane_count;
+	return cur && new && cur->stream_res.tg == new->stream_res.tg;
 }
 
-static bool check_same_otg_master_blocks(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state, unsigned int i)
+/* stream has the same OPP for each ODM slice in both states. */
+static bool dcn401_same_opp_heads(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
 {
-	const struct pipe_ctx *current_pipe = dcn401_otg_master(current_state,
-			new_state->streams[i]);
-	const struct pipe_ctx *new_pipe = dcn401_otg_master(new_state,
-			new_state->streams[i]);
+	const struct pipe_ctx *cur = dcn401_otg_master(current_state, stream);
+	const struct pipe_ctx *new = dcn401_otg_master(new_state, stream);
 
-	(void)dc;
-	if (current_pipe->stream_res.tg != new_pipe->stream_res.tg)
-		return false;
-	/* The same OPP for each ODM slice. */
-	for (; current_pipe && new_pipe;
-			current_pipe = current_pipe->next_odm_pipe,
-			new_pipe = new_pipe->next_odm_pipe)
-		if (current_pipe->stream_res.opp != new_pipe->stream_res.opp)
+	for (; cur && new; cur = cur->next_odm_pipe, new = new->next_odm_pipe)
+		if (cur->stream_res.opp != new->stream_res.opp)
 			return false;
-	return !current_pipe && !new_pipe;
+	return !cur && !new;
 }
 
 static bool check_new_plane_blocks(const struct dc *dc,
@@ -960,12 +941,32 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	/* The transition: streams kept; add a plane or keep one plane. */
 	CHECK_UPDATE(streams_kept,
 			"a stream is not kept, or another stream changes");
-	CHECK_UPDATE(plane_add_or_kept,
-			"update is not a plane add, or keeps a plane off its pipe");
-	CHECK_UPDATE(same_otg_master_blocks, "otg, opp or odm changes");
+	return dcn401_check_stream_update(dc, current_state, new_state, i);
+}
+
+bool dcn401_stream_kept(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
+{
+	int i = dcn401_stream_index(new_state, stream);
+
+	if (i < 0 || dcn401_stream_index(current_state, stream) < 0)
+		return false;
+	return dcn401_stream_unchanged(current_state, new_state, stream) ||
+			dcn401_check_stream_update(dc, current_state, new_state,
+			(unsigned int)i) == BLS_BUILD_SUCCESS;
+}
+
+enum bls_builder_result dcn401_check_stream_update(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	CHECK_UPDATE(pipes_kept_or_free,
+			"a pipe moves, or the stream has no or too many planes");
+	CHECK_UPDATE(same_otg, "otg changes");
 	CHECK_UPDATE_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
@@ -1022,7 +1023,8 @@ prepare_bandwidth[] = {
 /*
  * Net effect: hwss_process_outstanding_hw_updates on the current state,
  * which commit_planes_for_stream runs while optimized_required is set.
- * The OTG master has no plane yet, so no MPCC disconnect is pending.
+ * The update disconnects its removed pipes itself, so no MPCC disconnect
+ * is pending.
  */
 static const struct dcn401_commit_step preamble[] = {
 	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
@@ -1095,14 +1097,44 @@ static const struct dcn401_commit_step global_sync[] = {
 	{ .func = TG_SETUP_VERTICAL_INTERRUPT2,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = OPTC_SET_ODM_COMBINE,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.odm_kept = true },
 };
 
 static const struct dcn401_commit_step opp_odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.odm_kept = true },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.odm_kept = true },
+};
+
+/*
+ * Under the lock, each current pipe that the update removes leaves its
+ * MPCC and returns its DET segments, as DC1 disconnects a disabled pipe.
+ */
+const struct dcn401_commit_step dcn401_disconnect[DCN401_DISCONNECT_STEPS] = {
+	{ .func = HUBP_PROGRAM_DET_SEGMENTS, .meta.skip_if.no_plane_removed = true },
+	{ .func = MPC_REMOVE_MPCC, .meta.skip_if.no_plane_removed = true },
+};
+
+/* After the unlock, disable_plane on each removed pipe. */
+const struct dcn401_commit_step dcn401_power_down[DCN401_POWER_DOWN_STEPS] = {
+	{ .func = MPC_ASSERT_IDLE_MPCC, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_SET_BLANK, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_UPDATE_MALL_SEL, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_SET_FLIP_CONTROL_GSL, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_CLK_CNTL, .meta.skip_if.no_plane_removed = true },
+	{ .func = DPP_DPPCLK_CONTROL, .meta.skip_if.no_plane_removed = true },
+	{ .func = DC_IP_REQUEST_STATUS, .meta.skip_if.no_ip_request = true,
+	  .meta.skip_if.no_plane_removed = true },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.no_ip_request = true,
+	  .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_PG_CONTROL, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_RESET, .meta.skip_if.no_plane_removed = true },
+	{ .func = DPP_RESET, .meta.skip_if.no_plane_removed = true },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.no_ip_request = true,
+	  .meta.skip_if.no_plane_removed = true },
 };
 
 /* enable_plane, then the watermark propagate and the DET segments. */
@@ -1228,12 +1260,26 @@ static const struct dcn401_commit_step dpp_mall[] = {
 	  .meta.hubp_update_mall_sel.from_new_state = true },
 };
 
+/* A changed ODM layout takes effect before the update returns. */
+static const struct dcn401_commit_step odm_wait[] = {
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
+	  .meta.skip_if.same_opp_heads = true },
+};
+
 static const struct dcn401_commit_step trigger[] = {
 	{ .func = OPTC_PROGRAM_MANUAL_TRIGGER,
 	  .meta.skip_if.no_manual_trigger = true },
 };
 
-/* The support check allows one stream, kept across the update. */
+/*
+ * The update programs one stream. A pipe that leaves the stream emits
+ * fewer steps than a pipe the update programs, so the bound counts every
+ * pipe as programmed. dcn401_add_step catches a longer sequence.
+ */
+static_assert(ARRAY_SIZE(dcn401_disconnect) + ARRAY_SIZE(dcn401_power_down) <=
+		ARRAY_SIZE(dpp_lock) + ARRAY_SIZE(enable_plane) +
+		ARRAY_SIZE(dpp_flip) + ARRAY_SIZE(dpp_mall),
+		"a removed pipe emits more than a programmed pipe");
 static_assert(
 		ARRAY_SIZE(preamble) +
 		ARRAY_SIZE(global_preamble) +
@@ -1247,6 +1293,7 @@ static_assert(
 		ARRAY_SIZE(opp_odm)) +
 		ARRAY_SIZE(unlock) +
 		ARRAY_SIZE(pstate) +
+		ARRAY_SIZE(odm_wait) +
 		ARRAY_SIZE(trigger) +
 		DCN401_MAX_DPP_PIPES * (
 		ARRAY_SIZE(dpp_lock) +
@@ -2093,25 +2140,26 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	}
 }
 
-static bool dcn401_pipe_already_enabled(
-		const struct dcn401_commit_step_args *args)
-{
-	const struct pipe_ctx *cur =
-			&args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
-
-	return cur->plane_state && cur->stream == args->pipe->stream &&
-			cur->plane_res.hubp == args->pipe->plane_res.hubp;
-}
-
 static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *step)
 {
+	const struct pipe_ctx *cur, *new;
+
 	if (step->meta.skip_if.new_state_has_stream &&
 			args->new_state->stream_count)
 		return true;
 	if (step->meta.skip_if.optimized_not_required &&
 			!args->dc->optimized_required)
 		return true;
+	if (step->meta.skip_if.no_ip_request &&
+			(!args->dc->hwseq->funcs.pg_needs_ip_request ||
+			!args->dc->hwseq->funcs.pg_needs_ip_request(args->dc)))
+		return true;
+	/* The remaining conditions are for per-pipe steps. */
+	if (!args->pipe)
+		return false;
+	cur = &args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
+	new = &args->new_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
 	if (step->meta.skip_if.no_manual_trigger &&
 			(!args->pipe->plane_state->update_bits.addr_update ||
 			args->pipe->plane_state->skip_manual_trigger))
@@ -2121,21 +2169,29 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
 		return true;
 	if (step->meta.skip_if.hubp_dpp_already_enabled &&
-			dcn401_pipe_already_enabled(args))
+			dcn401_pipe_kept(cur, new))
+		return true;
+	if (step->meta.skip_if.no_plane_removed &&
+			(!cur->plane_state || dcn401_pipe_kept(cur, new)))
+		return true;
+	if (step->meta.skip_if.det_unchanged && dcn401_pipe_kept(cur, new) &&
+			cur->hubp_regs.det_size == new->hubp_regs.det_size)
 		return true;
-	if (step->meta.skip_if.det_unchanged &&
-			dcn401_pipe_already_enabled(args) &&
-			args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx]
-			.hubp_regs.det_size == args->pipe->hubp_regs.det_size)
+	if (step->meta.skip_if.odm_kept && dcn401_pipe_kept(cur, new) &&
+			dcn401_same_opp_heads(args->current_state,
+			args->new_state, args->pipe->stream))
+		return true;
+	if (step->meta.skip_if.same_opp_heads &&
+			dcn401_same_opp_heads(args->current_state,
+			args->new_state, args->pipe->stream))
 		return true;
 	if (step->meta.skip_if.scaling_unchanged &&
 			!args->pipe->plane_state->update_bits.scaling_change &&
 			!args->pipe->plane_state->update_bits.position_change &&
-			!args->pipe->stream->update_flags.bits.scaling)
-		return true;
-	if (step->meta.skip_if.no_ip_request &&
-			(!args->dc->hwseq->funcs.pg_needs_ip_request ||
-			!args->dc->hwseq->funcs.pg_needs_ip_request(args->dc)))
+			!args->pipe->stream->update_flags.bits.scaling &&
+			(!dcn401_pipe_kept(cur, new) ||
+			!memcmp(&cur->plane_res.scl_data, &new->plane_res.scl_data,
+			sizeof(cur->plane_res.scl_data))))
 		return true;
 	return false;
 }
@@ -2157,8 +2213,8 @@ static bool dcn401_walks_stream(const struct dcn401_commit_step_args *args,
 {
 	if (args->stream)
 		return stream == args->stream;
-	return !dcn401_stream_unchanged(args->current_state, args->new_state,
-			stream);
+	return !dcn401_stream_kept(args->dc, args->current_state,
+			args->new_state, stream);
 }
 
 static void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
@@ -2268,10 +2324,10 @@ void dcn401_init_and_unpack_params(
 }
 
 /*
- * The updated stream only. skip_if drops first-enable steps on a pipe
- * that already showed its plane, so a kept-plane surface update is the
- * same table. The enable_plane list runs per DPP pipe, top pipe first, so the
- * top MPCC is inserted before the bottom one.
+ * The waits and the bandwidth raise, then the updated stream only.
+ * skip_if drops the steps a kept pipe or ODM layout does not need, so
+ * every transition is the same table. The enable_plane list runs per DPP
+ * pipe, top pipe first, so the top MPCC is inserted before the bottom one.
  */
 static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
@@ -2283,6 +2339,10 @@ static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_NEW_STATE,
 	  .steps = prepare_bandwidth,
 	  .count = ARRAY_SIZE(prepare_bandwidth) },
+};
+
+/* The front end of one stream, which a commit also runs for a kept stream. */
+static const struct dcn401_sub_sequence bls_stream_update[] = {
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = pending,
 	  .count = ARRAY_SIZE(pending) },
@@ -2292,6 +2352,9 @@ static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
 	  .steps = dpp_lock,
 	  .count = ARRAY_SIZE(dpp_lock) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = dcn401_disconnect,
+	  .count = ARRAY_SIZE(dcn401_disconnect) },
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = first_hubp,
 	  .count = ARRAY_SIZE(first_hubp) },
@@ -2310,6 +2373,9 @@ static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = unlock,
 	  .count = ARRAY_SIZE(unlock) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = dcn401_power_down,
+	  .count = ARRAY_SIZE(dcn401_power_down) },
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
 	  .steps = dpp_flip,
 	  .count = ARRAY_SIZE(dpp_flip) },
@@ -2319,11 +2385,20 @@ static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
 	  .steps = dpp_mall,
 	  .count = ARRAY_SIZE(dpp_mall) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = odm_wait,
+	  .count = ARRAY_SIZE(odm_wait) },
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = trigger,
 	  .count = ARRAY_SIZE(trigger) },
 };
 
+void dcn401_add_stream_update(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *args)
+{
+	DCN401_ADD_SUB_SEQUENCES(sequence, args, bls_stream_update);
+}
+
 static enum bls_builder_result dcn401_build_seamless_update(
 		struct bls_builder_declarative_params *params)
 {
@@ -2342,6 +2417,7 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	state_args.stream = dcn401_updated_stream(params->new_state,
 			params->stream);
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_update_head);
+	dcn401_add_stream_update(&head, &state_args);
 
 	return BLS_BUILD_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index ce2b14bb7a5a..22da4ebae256 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -218,6 +218,28 @@ static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
 			core2_query_accelerated_mode(dc);
 }
 
+/*
+ * The values DC1 computes into the context before it programs the planes.
+ * The builder reads them from the context.
+ */
+static void core2_update_prepare(struct dc *dc, struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n;
+
+	if (dc->res_pool->funcs->prepare_mcache_programming)
+		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
+	n = resource_get_dpp_pipes_for_stream(stream, &context->res_ctx,
+			dpp_pipes);
+	for (i = 0; i < n; i++)
+		dpp_pipes[i]->plane_res.scl_data.lb_params.alpha_en =
+				dpp_pipes[i]->plane_state->per_pixel_alpha;
+}
+
+static void core2_update_done(struct dc *dc, struct dc_state *context,
+		struct dc_stream_state *stream);
+
 /* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
 enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 {
@@ -234,9 +256,16 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 	 * pipe before it programs the packets. Remove when the builder
 	 * computes it.
 	 */
-	for (i = 0; i < context->stream_count; i++)
-		resource_build_info_frame(resource_get_otg_master_for_stream(
-				&context->res_ctx, context->streams[i]));
+	for (i = 0; i < context->stream_count; i++) {
+		struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+				&context->res_ctx, context->streams[i]);
+
+		if (otg_master)
+			resource_build_info_frame(otg_master);
+		if (dcn401_stream_kept(dc, current_state, context,
+				context->streams[i]))
+			core2_update_prepare(dc, context, context->streams[i]);
+	}
 
 	status = core2_build_and_run(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context,
 			NULL);
@@ -244,16 +273,20 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 		return status;
 
 	core2_commit_prepare_done(dc, context);
-	for (i = 0; i < current_state->stream_count; i++)
-		if (!dcn401_stream_unchanged(current_state, context,
-				current_state->streams[i]))
-			core2_commit_disable_done(dc,
-					resource_get_otg_master_for_stream(
-					&current_state->res_ctx,
-					current_state->streams[i]));
+	for (i = 0; i < current_state->stream_count; i++) {
+		struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+				&current_state->res_ctx,
+				current_state->streams[i]);
+
+		if (otg_master && !dcn401_stream_kept(dc, current_state,
+				context, current_state->streams[i]))
+			core2_commit_disable_done(dc, otg_master);
+	}
 	for (i = 0; i < context->stream_count; i++)
-		if (!dcn401_stream_unchanged(current_state, context,
+		if (dcn401_stream_kept(dc, current_state, context,
 				context->streams[i]))
+			core2_update_done(dc, context, context->streams[i]);
+		else
 			core2_commit_enable_done(
 					resource_get_otg_master_for_stream(
 					&context->res_ctx, context->streams[i]));
@@ -321,9 +354,15 @@ static void core2_update_done(struct dc *dc, struct dc_state *context,
 	struct pipe_ctx *pipe;
 	struct dc_plane_state *plane;
 	struct hubp *hubp;
-	int i, n = resource_get_dpp_pipes_for_stream(stream, &context->res_ctx,
-			dpp_pipes);
+	int i, n = resource_get_dpp_pipes_for_stream(stream,
+			&dc->current_state->res_ctx, dpp_pipes);
 
+	/* The update powers down the pipes that leave the stream. */
+	for (i = 0; i < n; i++)
+		if (dpp_pipes[i]->plane_res.hubp)
+			dpp_pipes[i]->plane_res.hubp->power_gated = true;
+	n = resource_get_dpp_pipes_for_stream(stream, &context->res_ctx,
+			dpp_pipes);
 	for (i = 0; i < n; i++) {
 		pipe = dpp_pipes[i];
 		if (!pipe->plane_state || !pipe->plane_res.hubp ||
@@ -349,22 +388,10 @@ static void core2_update_state_execute(
 	struct dc_state *context = scratch->new_context;
 	struct pipe_ctx *pipe = resource_get_otg_master_for_stream(
 			&context->res_ctx, scratch->stream);
-	struct pipe_ctx *dpp_pipes[MAX_PIPES];
-	int i, n;
 
-	/*
-	 * The values DC1 computes into the context before it programs the
-	 * planes. The builder reads them from the context.
-	 */
 	if (!pipe || !pipe->plane_state)
 		return;
-	if (dc->res_pool->funcs->prepare_mcache_programming)
-		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
-	n = resource_get_dpp_pipes_for_stream(scratch->stream, &context->res_ctx,
-			dpp_pipes);
-	for (i = 0; i < n; i++)
-		dpp_pipes[i]->plane_res.scl_data.lb_params.alpha_en =
-				dpp_pipes[i]->plane_state->per_pixel_alpha;
+	core2_update_prepare(dc, context, scratch->stream);
 
 	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context,
 			scratch->stream) != DC_OK) {
-- 
2.43.0

