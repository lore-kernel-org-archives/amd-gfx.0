Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17D606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sv5jrYg5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE3710F900;
	Wed, 11 Nov 2026 01:46:17 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EA110F900
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOaznbeK5fZnQv02HrqereUT9zps0iZf9YvlWT2R1b6AN1PtvmQks9zUUeB2rXvq2Ko8XiRkQz6W6Hanb/TiaLHA+/l5BcuKMwDRTxmHR8vHuYkAZlFHnq/1fCYyxyKxhKzmtZdgBBXsXZnq8RKgV1oHpTmHajvnFnE6VdTEzxkJLOcN8GpnC/Cf4w0fzLUIP5rGB/UbLWuu9tcMKmcCAJ8YuKmLWTkTQHhY2JIR5qDoFtg/B1dZRogb3/buNbCOrOlVEG4bgJ0P7s353WOtlHUsiMhBn+VV9ok9Pin+dYulmkH+OeA+xnQeijlWz8Cqsq++4hqdAlIl4TzmF5+ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOrLRFVGEQ4xm9bGFmXJjqCgrxIkRuIJXt00+jE++0s=;
 b=N6FO1Je7WmS8rUiHjk21PxZB+vrjH+AyTCpSk1IuWpR1FbskwFQ4ih8WctMHl9sEwXoQFY4e8MSRjVq3kq8snxJTxcDCQMY+kXYimPL9RqNLVJQYd2yQrdqUrcn89xNNcTYWvfAwWSxcRnhwAXI4i4g1cCTm1GBVucZDqWj7QV0dUrzDZndSxxl2CbsBq7R/VU4tiFPVEKG324agztH0FhSMRHZIPD6yuIgNfpVBZk/FECMTy/6kgDgpWnlDBmijUgJMLyzRLCGCfRR8hDByQ/3ylBTE2GFXJh0kgxc2I9Gl1ngXjs0N5WvdC4ghAvMkPGXgkMjK+Hc89Di2v4CiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOrLRFVGEQ4xm9bGFmXJjqCgrxIkRuIJXt00+jE++0s=;
 b=sv5jrYg59DJpl6ohQVWV/yxXXP9ON6yfqq3eXAtQVZhsYODugC2JKNWkdr0R/iIS0mvZKDo/WbUYua7vUY8RrMdI/mMrYjlOor043f6cstqEb2BAC9njDnq9yiWwz/CKsCA1WJBY393axdAYdTFUgvQhXR5ohRZbYTCceWYlgG8=
Received: from CY5P221CA0156.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::18)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:34 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::82) by CY5P221CA0156.outlook.office365.com
 (2603:10b6:930:6a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:33 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:29 -0600
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
Subject: [PATCH 71/74] drm/amd/display: Program ODM 2:1 and 3:1 on one stream
 in DC2
Date: Wed, 11 Nov 2026 09:29:17 +0800
Message-ID: <20261111014100.3596072-72-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 952b1820-7d15-4216-6bdf-08df3f957a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022115727099003|3023799007|261026140227099003|261026130827099003|261022075727099003|261026135527099003|261026121527099003|261021130227099003|261021135927099003|261028144727099003|261009223027099003|261009221227099003|261021123027099003|261021121427099003|261021133027099003|261022105027099003|10067099003|261022113327099003|261102123227099003|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W8+4+6FUptlzZSiHwtJS0Qf1B4hIMgl700vz5xs07RY62TIVbiEvanpqYAcTTtrHBx0L4mMwWF3a4iYXXlC6sxweVeGYXXzN8hNdcN+siFT7z6MLrm9HVQ+6QyDcu5XDHWc5vBG7fCt70+3JTJJVfV4a/D3LLkU5EEt7np64/QUUnUGwYfIDhJByderjJD4mFd0PYCNt9E4d7OylPqldsMlx2O32wL54i+CIlctWwz3VrJm7/IP1ZrX14ydTxFjPFLu8YYQn5FC5uuy9NrIY9hVo069rbxN97bEQA27e+qVStl1nw1QfOdQE7LfxL7yaPrxw7Iq3y8g8KlU2H5mOgR9yfQ9SwXYZjLGVJz6q/geVv2xx3ZO39wAy/q2gU2MH05AjaPryurKZ+Es+mo4mtzry+6+WXSpytI5wPiRCBG8nPaEmr2uqnx8zRva9Ela8u7yR53rCZyIPXfF6kh+ZPVaOG6x7av6IEw9H+QrVsUO5sL9+CtSuCpYOlAdMjvrk+0MbYIYus8FYig17yZlK34b0049pnCYcxfZaf24A17WLke2uOy5BhLhtVuIx54jFUzf1rv1nIUbfPSdUSMcXIWGvwpXph6Kn9s8HB0+vsiwP5QsUXTv5tjLNJhSErdZFjtZNpuAtNrIcwyLfHyVonzjK7K8OWuefcB/Jiq9LSHbH0aEMeRPQp7w5W2OL2DIw2TBJqj1cXnyOgQvmZQQAWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022115727099003)(3023799007)(261026140227099003)(261026130827099003)(261022075727099003)(261026135527099003)(261026121527099003)(261021130227099003)(261021135927099003)(261028144727099003)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261022105027099003)(10067099003)(261022113327099003)(261102123227099003)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 769RvpLdBfvW7dOI13mj09eEpH+iP35fKGDsKzHVIIxj8+9lLeS/m6RLwgPy52H8qF2GUj0+z3D9b/AL/hb9tlOr67YTjaInXuNz9Ak+aP5XLOaxAQqN2Z1QEc0Tv+W5yMWQhKFpAwuBoXDTpgKk9rtZe1Q/5Eu+ft5Uf1CvaDPOaRRapKXn2qFpjUaA1Q1F6bQKKxlzDC1kxmO4CsFg5iYyt6xfCj3H/Nmw6BMo+jzWckyqqhm5Ntn3Viy4ZD15yJYWkFh+VlHEK0pNfo8HVMvX6/Gvab7F9LvAn88pPcWyc3YAHg/XgnQ2e5zPbDleI0wm4XFHgc2cQ88l9HZSkaWS2y3hDPF0UAO+ZQFxmZulNGymX2bHoEx+MJ8bqiir1wo4iUKbY/Eh5kQCn7SQOS/fXCE78dPW6IyS3NHSd6iaMdNJVfXVM8LWaP8mM0Lx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:34.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b1820-7d15-4216-6bdf-08df3f957a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
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
The DC2 commit on DCN4 rejects all streams with ODM.

[How]
Accept one stream with two or three ODM slices. Declare each builder's
steps as a table of sub-sequences that names the state each reads and
how it expands. Always program ODM: combine for more than one slice,
else bypass. Program the OPP steps on each slice, and the plane on each
slice with its own viewport. Make the step list large enough for ODM
3:1. Keep ODM 4:1, ODM with MPO and ODM changes on a kept stream
rejected.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   2 +-
 .../dc/bls_builder/dcn401_builder_internal.h  |  55 +--
 .../bls_builder/dcn401_non_seamless_builder.c | 198 ++++++----
 .../dc/bls_builder/dcn401_seamless_builder.c  | 373 ++++++++++++------
 .../display/dc/bls_executor/bls_executor.c    |  15 +
 5 files changed, 415 insertions(+), 228 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 9a3907bf950a..ad0348b3cae5 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -12,7 +12,7 @@
 #include "bls_builder/dmub_abi.h"
 #include "bls_builder/bls_builder_legacy_init.h"
 
-#define DC2_BLS_MAX_STEPS 128
+#define DC2_BLS_MAX_STEPS 192
 
 enum bls_builder_result {
 	BLS_BUILD_SUCCESS,
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index cc531a7eadf7..41a31202162b 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -14,8 +14,12 @@
  * table into BLS entries.
  */
 
-/* The support check allows the OTG master and one MPC bottom pipe. */
-#define DCN401_MAX_DPP_PIPES 2
+/*
+ * The support check allows the OTG master and one MPC bottom pipe, or up to
+ * three ODM slices with one DPP pipe each.
+ */
+#define DCN401_MAX_OPP_HEADS 3
+#define DCN401_MAX_DPP_PIPES DCN401_MAX_OPP_HEADS
 
 void dcn401_commit_check_failed(const struct dc *dc, const char *msg);
 
@@ -54,10 +58,6 @@ const struct pipe_ctx *dcn401_checked_otg_master(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state);
 
-/* Each DPP pipe under the OTG master of state, top pipe first. */
-#define DCN401_FOR_EACH_DPP_PIPE(dc, state, pipe) \
-	for ((pipe) = dcn401_otg_of(dc, state); (pipe); \
-			(pipe) = (pipe)->bottom_pipe)
 
 /* What both builders need of the dc, before either state. */
 enum bls_builder_result dcn401_check_dc_support(const struct dc *dc);
@@ -74,27 +74,30 @@ struct dcn401_commit_step_args {
 	struct pipe_ctx *pipe;
 };
 
-void dcn401_add_steps(struct block_sequence_state *sequence,
-		const struct dcn401_commit_step_args *args,
-		const struct dcn401_commit_step *steps, unsigned int count);
-/* The support check found an OTG master for each stream of state. */
-void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
-		const struct dcn401_commit_step_args *state_args,
-		struct dc_state *state,
-		const struct dcn401_commit_step *steps, unsigned int count);
-/* Each DPP pipe of each stream, the OTG master first. */
-void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
+/*
+ * A sub-sequence names the state its steps read and how they expand: once,
+ * or once per OTG master, OPP head (ODM slice) or DPP pipe of each stream
+ * of that state, the OTG master first. A builder lists its sub-sequences
+ * in emission order.
+ */
+#define DCN401_CURRENT_STATE			(1u << 0)
+#define DCN401_NEW_STATE			(1u << 1)
+#define DCN401_PER_STREAM_PER_OTG_MASTER	(1u << 2)
+#define DCN401_PER_STREAM_PER_OPP_HEAD		(1u << 3)
+#define DCN401_PER_STREAM_PER_DPP_PIPE		(1u << 4)
+
+struct dcn401_sub_sequence {
+	uint32_t flags;
+	const struct dcn401_commit_step *steps;
+	unsigned int count;
+};
+
+/* The support check found an OTG master for each stream it expands. */
+void dcn401_add_sub_sequences(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
-		struct dc_state *state,
-		const struct dcn401_commit_step *steps, unsigned int count);
-#define DCN401_ADD_STEPS(sequence, args, steps) \
-	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
-#define DCN401_ADD_PER_OTG_MASTER(sequence, args, state, steps) \
-	dcn401_add_per_otg_master(sequence, args, state, steps, \
-			ARRAY_SIZE(steps))
-#define DCN401_ADD_PER_DPP_PIPE(sequence, args, state, steps) \
-	dcn401_add_per_dpp_pipe(sequence, args, state, steps, \
-			ARRAY_SIZE(steps))
+		const struct dcn401_sub_sequence *subs, unsigned int count);
+#define DCN401_ADD_SUB_SEQUENCES(sequence, args, subs) \
+	dcn401_add_sub_sequences(sequence, args, subs, ARRAY_SIZE(subs))
 
 /*
  * Points the step arguments at the states and the sequence at
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index 965004f6e49b..f9aa8f0b9b1e 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -14,7 +14,8 @@
  * The new state has no stream, or one stream with no plane; the current
  * state has no stream, or one stream with one or two planes, one per DPP
  * pipe. Planes are added later by DCN_DECL_SEAMLESS_UPDATE, not by this
- * commit.
+ * commit. The stream is in ODM bypass, 2:1 or 3:1, with one OPP head
+ * and at most one DPP pipe per slice.
  *
  * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
  * calls in the same order, including the calls DC1 repeats. Everything is
@@ -90,28 +91,33 @@ static bool check_plane_blocks(const struct dc *dc,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
 
-/* The OPP's tree holds exactly the removed MPCCs, in pipe order. */
+/* Each OPP's tree holds exactly the removed MPCCs of its slice, in order. */
 static bool check_mpcc_tree(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+	const struct pipe_ctx *opp_head = dcn401_checked_otg_master(dc,
 			current_state, new_state);
+	const struct pipe_ctx *pipe;
 	const struct mpcc *mpcc;
 
 	if (!current_state)
 		return true;
-	if (!pipe || !dc->res_pool || !dc->res_pool->mpc)
+	if (!opp_head || !dc->res_pool || !dc->res_pool->mpc)
 		return false;
-	mpcc = pipe->stream_res.opp->mpc_tree_params.opp_list;
-	for (; pipe; pipe = pipe->bottom_pipe) {
-		if (mpcc != &dc->res_pool->mpc->mpcc_array[
-				pipe->plane_res.mpcc_inst] ||
-				mpcc->dpp_id != pipe->plane_res.dpp->inst)
+	for (; opp_head; opp_head = opp_head->next_odm_pipe) {
+		mpcc = opp_head->stream_res.opp->mpc_tree_params.opp_list;
+		for (pipe = opp_head; pipe; pipe = pipe->bottom_pipe) {
+			if (mpcc != &dc->res_pool->mpc->mpcc_array[
+					pipe->plane_res.mpcc_inst] ||
+					mpcc->dpp_id != pipe->plane_res.dpp->inst)
+				return false;
+			mpcc = mpcc->mpcc_bot;
+		}
+		if (mpcc)
 			return false;
-		mpcc = mpcc->mpcc_bot;
 	}
-	return !mpcc;
+	return true;
 }
 
 static enum bls_builder_result dcn401_check_commit_state_support(
@@ -184,7 +190,7 @@ static enum bls_builder_result dcn401_check_non_seamless_commit_support(
  * softmax.
  */
 static const struct dcn401_commit_step
-bls_head_per_state_new_prepare_bandwidth[] = {
+prepare_bandwidth[] = {
 	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
 	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
@@ -203,28 +209,28 @@ bls_head_per_state_new_prepare_bandwidth[] = {
  *   disable_link, which disables the output as DisplayPort.
  * - dcn401_reset_back_end_for_pipe after link_set_dpms_off, then the
  *   clock source power-down from dcn401_reset_hw_ctx_wrap.
- * The front end disconnects every MPCC under the lock, then powers down
- * each DPP pipe after the unlock; the _dpp tables run once per DPP pipe.
+ * The front end blanks each ODM slice and disconnects every MPCC under
+ * the lock, then powers down each DPP pipe after the unlock; the _dpp
+ * tables run once per DPP pipe and the _opp tables once per OPP head.
  */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_lock[] = {
+static const struct dcn401_commit_step lock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+};
+
+static const struct dcn401_commit_step blank[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
 };
 
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_dpp_pipe_current_disconnect[] = {
+static const struct dcn401_commit_step disconnect[] = {
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
 	{ .func = MPC_REMOVE_MPCC },
 };
 
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_unlock[] = {
+static const struct dcn401_commit_step unlock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
 };
 
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_dpp_pipe_current_power_down[] = {
+static const struct dcn401_commit_step power_down[] = {
 	{ .func = MPC_ASSERT_IDLE_MPCC },
 	{ .func = HUBP_SET_BLANK },
 	{ .func = HUBP_UPDATE_MALL_SEL },
@@ -241,8 +247,7 @@ static const struct dcn401_commit_step
 	  .meta.skip_if.no_ip_request = true },
 };
 
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_stream_off[] = {
+static const struct dcn401_commit_step stream_off[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 
 	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
@@ -270,9 +275,9 @@ static const struct dcn401_commit_step
  *   dcn401_enable_stream. The virtual stream encoder has no enable, map,
  *   input-mode or FIFO funcs, and update_info_frame programs nothing.
  *   DC1 skips dig_connect_to_otg for the virtual signal.
+ * The OPP clock, left edge pixel and blank run on each ODM slice.
  */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_new[] = {
+static const struct dcn401_commit_step stream_timing[] = {
 	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
 	  .meta.bios_set_scratch_critical_state.state = true },
 
@@ -280,6 +285,7 @@ static const struct dcn401_commit_step
 	{ .func = OPP_SET_DYN_EXPANSION },
 	{ .func = DCCG_SET_PIXEL_RATE_DIV,
 	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_4 },
+	{ .func = OPTC_SET_ODM_COMBINE },
 	{ .func = DCCG_SET_DTBCLK_P_SRC,
 	  .meta.dccg_set_dtbclk_p_src.src = DPREFCLK },
 	{ .func = TG_ENABLE_OPTC_CLOCK,
@@ -287,10 +293,18 @@ static const struct dcn401_commit_step
 	{ .func = CLK_SRC_PROGRAM_PIX_CLK },
 	{ .func = TG_PROGRAM_TIMING },
 	{ .func = TG_SET_H_TIMING_DIV_MANUAL_MODE },
+};
+
+static const struct dcn401_commit_step odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+};
+
+static const struct dcn401_commit_step opp_clock[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+};
+
+static const struct dcn401_commit_step crtc[] = {
 	{ .func = TG_ENABLE_CRTC },
 	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
 	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true,
@@ -316,22 +330,27 @@ static const struct dcn401_commit_step
 
 /*
  * Net effect: finish the head for the new OTG master. program_front_end
- * for a master with no plane, then stereo, then the waits that complete
- * the head's double buffering. DC1 sets up stereo twice for a
+ * for a master with no plane: update_odm, which programs each plane-less
+ * OPP head and blanks each ODM slice. Then stereo, then the waits that
+ * complete the head's double buffering. DC1 sets up stereo twice for a
  * mode-changed stream, in legacy_commit_state_hw and dc_enable_stereo,
  * with the same result; one dcn10_setup_stereo with no 3D format, the two
  * STEREO calls, matches it.
  * The bandwidth lower starts only after these waits.
  */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_new_front_end[] = {
+static const struct dcn401_commit_step front_end_lock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
-	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = OPTC_SET_ODM_COMBINE },
+};
+
+static const struct dcn401_commit_step front_end_odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
 	{ .func = OPP_SET_DYN_EXPANSION },
 	{ .func = OPP_PROGRAM_FMT },
-	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+};
+
+static const struct dcn401_commit_step front_end[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 
@@ -346,7 +365,8 @@ static const struct dcn401_commit_step
  * Net effect: release the forced p-state when no OTG master did, then
  * dcn401_optimize_bandwidth without FAMS2, SubVP or DC-mode softmax.
  */
-static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+static const struct dcn401_commit_step postamble[] = {
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
 	  .meta.skip_if.new_state_has_stream = true },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
 	  .meta.hubbub_program_watermarks.safe_to_lower = true },
@@ -362,27 +382,84 @@ static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {	{
  * Bounds on what build adds. The support check allows one stream per
  * state, and never one in both.
  */
-static_assert(ARRAY_SIZE(bls_head_per_state_new_prepare_bandwidth) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current_lock) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
-		bls_head_per_stream_per_dpp_pipe_current_disconnect) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_current_unlock) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
-		bls_head_per_stream_per_dpp_pipe_current_power_down) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_current_stream_off) +
-		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
+static_assert(ARRAY_SIZE(prepare_bandwidth) +
+		ARRAY_SIZE(lock) +
+		DCN401_MAX_OPP_HEADS * ARRAY_SIZE(blank) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(disconnect) +
+		ARRAY_SIZE(unlock) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(power_down) +
+		ARRAY_SIZE(stream_off) +
+		ARRAY_SIZE(postamble) <=
 		DC2_BLS_MAX_STEPS,
 		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
-static_assert(ARRAY_SIZE(bls_head_per_state_new_prepare_bandwidth) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_new) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_new_front_end) +
-		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
+static_assert(ARRAY_SIZE(prepare_bandwidth) +
+		ARRAY_SIZE(stream_timing) +
+		ARRAY_SIZE(opp_clock) +
+		ARRAY_SIZE(crtc) +
+		ARRAY_SIZE(front_end_lock) +
+		ARRAY_SIZE(front_end) +
+		DCN401_MAX_OPP_HEADS * (
+		ARRAY_SIZE(odm) +
+		2 * ARRAY_SIZE(blank) +
+		ARRAY_SIZE(front_end_odm)) +
+		ARRAY_SIZE(postamble) <=
 		DC2_BLS_MAX_STEPS,
 		"dcn401 commit enable head exceeds DC2_BLS_MAX_STEPS");
 
+static const struct dcn401_sub_sequence bls_head[] = {
+	{ .flags = DCN401_NEW_STATE,
+	  .steps = prepare_bandwidth,
+	  .count = ARRAY_SIZE(prepare_bandwidth) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = lock,
+	  .count = ARRAY_SIZE(lock) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = blank,
+	  .count = ARRAY_SIZE(blank) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = disconnect,
+	  .count = ARRAY_SIZE(disconnect) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = unlock,
+	  .count = ARRAY_SIZE(unlock) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = power_down,
+	  .count = ARRAY_SIZE(power_down) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = stream_off,
+	  .count = ARRAY_SIZE(stream_off) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = stream_timing,
+	  .count = ARRAY_SIZE(stream_timing) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = odm,
+	  .count = ARRAY_SIZE(odm) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = opp_clock,
+	  .count = ARRAY_SIZE(opp_clock) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = blank,
+	  .count = ARRAY_SIZE(blank) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = crtc,
+	  .count = ARRAY_SIZE(crtc) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = front_end_lock,
+	  .count = ARRAY_SIZE(front_end_lock) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = front_end_odm,
+	  .count = ARRAY_SIZE(front_end_odm) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = blank,
+	  .count = ARRAY_SIZE(blank) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = front_end,
+	  .count = ARRAY_SIZE(front_end) },
+	{ .flags = DCN401_NEW_STATE,
+	  .steps = postamble,
+	  .count = ARRAY_SIZE(postamble) },
+};
+
 static enum bls_builder_result dcn401_build_non_seamless_commit(
 		struct bls_builder_declarative_params *params)
 {
@@ -398,26 +475,7 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 		return result;
 
 	dcn401_init_and_unpack_params(params, &state_args, &head);
-	DCN401_ADD_STEPS(&head, &state_args,
-			bls_head_per_state_new_prepare_bandwidth);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_lock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
-			bls_head_per_stream_per_dpp_pipe_current_disconnect);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_unlock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
-			bls_head_per_stream_per_dpp_pipe_current_power_down);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_stream_off);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_head_per_stream_per_otg_master_pipe_new);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_head_per_stream_per_otg_master_pipe_new_front_end);
-	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new_postamble);
+	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_head);
 
 	return BLS_BUILD_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 863919e0967e..a9884eefdd9f 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -260,8 +260,8 @@ static bool check_abm(const struct dc *dc,
 
 /*
  * The OTG master for this state's one stream, or NULL when the stream has
- * more than one. An MPC bottom pipe of the stream is not an OTG master;
- * check_mpc_blend bounds it.
+ * more than one. An MPC bottom pipe or an ODM slice of the stream is not
+ * an OTG master; check_mpc_blend and check_odm_combine bound them.
  */
 static const struct pipe_ctx *dcn401_state_otg_master(const struct dc *dc,
 		const struct dc_state *state, bool *not_one_pipe)
@@ -276,7 +276,8 @@ static const struct pipe_ctx *dcn401_state_otg_master(const struct dc *dc,
 
 		if (!pipe->stream)
 			continue;
-		if (pipe->stream == state->streams[0] && pipe->top_pipe)
+		if (pipe->stream == state->streams[0] &&
+				(pipe->top_pipe || pipe->prev_odm_pipe))
 			continue;
 		if (pipe->stream != state->streams[0] || otg_master) {
 			*not_one_pipe = true;
@@ -325,14 +326,19 @@ static bool check_otg_master_present(const struct dc *dc,
 	return dcn401_checked_otg_master(dc, current_state, new_state) != NULL;
 }
 
+/* At most DCN401_MAX_OPP_HEADS ODM slices, each with an OPP. */
 static bool check_odm_combine(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+	const struct pipe_ctx *odm = dcn401_checked_otg_master(dc,
 			current_state, new_state);
+	unsigned int count = 0;
 
-	return pipe && !pipe->next_odm_pipe && !pipe->prev_odm_pipe;
+	for (; odm; odm = odm->next_odm_pipe)
+		if (!odm->stream_res.opp || ++count > DCN401_MAX_OPP_HEADS)
+			return false;
+	return count;
 }
 
 static bool check_mpc_blend(const struct dc *dc,
@@ -348,11 +354,15 @@ static bool check_mpc_blend(const struct dc *dc,
 		return false;
 	dc_state_facts_derive(dcn401_checked_state(current_state, new_state),
 			&facts);
-	/* At most one bottom pipe, on the master's OTG and OPP, and no ODM. */
+	/*
+	 * At most one bottom pipe, on the master's OTG and OPP. A bottom pipe
+	 * and ODM do not go together.
+	 */
 	return facts.global.blend_tree[0].dpp_pipe_count <= 2 &&
 			facts.global.blend_tree[0].on_otg_master_blocks &&
+			(facts.global.blend_tree[0].dpp_pipe_count == 1 ||
 			!dc_state_facts_any_pipe(&facts, 0,
-			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ODM, 0));
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ODM, 0)));
 }
 
 static bool check_otg_master_blocks(const struct dc *dc,
@@ -434,9 +444,9 @@ enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
 	CHECK_CONDITION(abm, "ABM level is set");
 	CHECK_CONDITION(one_otg_pipe, "stream is not on one pipe");
 	CHECK_RESOURCE(otg_master_present, "stream has no otg master");
-	CHECK_CONDITION(odm_combine, "odm is set");
+	CHECK_CONDITION(odm_combine, "odm is not bypass, 2:1 or 3:1");
 	CHECK_CONDITION(mpc_blend,
-			"more than one bottom pipe, or it is off the otg or opp");
+			"more than one bottom pipe, off the otg or opp, or with odm");
 	CHECK_RESOURCE(otg_master_blocks,
 			"otg master is missing a stream resource or pixel clock");
 	CHECK_CONDITION(pipe_audio, "audio is set");
@@ -501,10 +511,16 @@ static bool check_same_otg_master_blocks(const struct dc *dc,
 	const struct pipe_ctx *current_pipe = dcn401_otg_of(dc, current_state);
 	const struct pipe_ctx *new_pipe = dcn401_otg_of(dc, new_state);
 
-	if (!current_pipe || !new_pipe)
+	if (!current_pipe || !new_pipe ||
+			current_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		return false;
-	return current_pipe->stream_res.tg == new_pipe->stream_res.tg &&
-			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
+	/* The same OPP for each ODM slice. */
+	for (; current_pipe && new_pipe;
+			current_pipe = current_pipe->next_odm_pipe,
+			new_pipe = new_pipe->next_odm_pipe)
+		if (current_pipe->stream_res.opp != new_pipe->stream_res.opp)
+			return false;
+	return !current_pipe && !new_pipe;
 }
 
 static bool check_new_plane_blocks(const struct dc *dc,
@@ -628,15 +644,19 @@ static bool check_no_flip_int(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n = new_state && new_state->stream_count ?
+			resource_get_dpp_pipes_for_stream(new_state->streams[0],
+			(struct resource_context *)&new_state->res_ctx,
+			dpp_pipes) : 0;
 
+	(void)dc;
 	(void)current_state;
-	if (!dcn401_otg_of(dc, new_state))
+	if (!n)
 		return false;
-	DCN401_FOR_EACH_DPP_PIPE(dc, new_state, pipe) {
-		if (!pipe->plane_state || pipe->plane_state->flip_int_enabled)
+	for (i = 0; i < n; i++)
+		if (dpp_pipes[i]->plane_state->flip_int_enabled)
 			return false;
-	}
 	return true;
 }
 
@@ -645,16 +665,19 @@ static bool check_no_plane_gamut_remap(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n = new_state && new_state->stream_count ?
+			resource_get_dpp_pipes_for_stream(new_state->streams[0],
+			(struct resource_context *)&new_state->res_ctx,
+			dpp_pipes) : 0;
 
+	(void)dc;
 	(void)current_state;
-	if (!dcn401_otg_of(dc, new_state))
+	if (!n)
 		return false;
-	DCN401_FOR_EACH_DPP_PIPE(dc, new_state, pipe) {
-		if (!pipe->plane_state ||
-				pipe->plane_state->gamut_remap_matrix.enable_remap)
+	for (i = 0; i < n; i++)
+		if (dpp_pipes[i]->plane_state->gamut_remap_matrix.enable_remap)
 			return false;
-	}
 	return true;
 }
 
@@ -847,7 +870,7 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	CHECK_CONDITION(stream_kept, "stream is not kept across the update");
 	CHECK_CONDITION(plane_add_or_kept,
 			"update is not a plane add or a kept-plane surface update");
-	CHECK_CONDITION(same_otg_master_blocks, "otg or opp changes");
+	CHECK_CONDITION(same_otg_master_blocks, "otg, opp or odm changes");
 	CHECK_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
@@ -885,29 +908,12 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	return BLS_BUILD_SUCCESS;
 }
 
-static struct pipe_ctx *get_otg_master_from_state_by_stream(
-		const struct dc *dc, struct dc_state *state,
-		const struct dc_stream_state *stream)
-{
-	unsigned int i;
-
-	(void)dc;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
-
-		if (pipe->stream == stream && !pipe->top_pipe)
-			return pipe;
-	}
-	return NULL;
-}
-
 /*
  * Net effect: dcn401_prepare_bandwidth without FAMS2, SubVP or DC-mode
  * softmax.
  */
 static const struct dcn401_commit_step
-bls_update_head_per_state_new_prepare_bandwidth[] = {
+prepare_bandwidth[] = {
 	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
 	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
@@ -923,8 +929,7 @@ bls_update_head_per_state_new_prepare_bandwidth[] = {
  * which commit_planes_for_stream runs while optimized_required is set.
  * The OTG master has no plane yet, so no MPCC disconnect is pending.
  */
-static const struct dcn401_commit_step
-		bls_update_head_per_stream_per_otg_master_pipe_preamble[] = {
+static const struct dcn401_commit_step preamble[] = {
 	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
 	  .meta.skip_if.optimized_not_required = true },
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
@@ -934,7 +939,7 @@ static const struct dcn401_commit_step
 };
 
 /* Net effect: dcn401_program_outstanding_updates on the current state. */
-static const struct dcn401_commit_step bls_update_head_global_preamble[] = {
+static const struct dcn401_commit_step global_preamble[] = {
 	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
 	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true,
 	  .meta.hubbub_program_compbuf_segments.use_current_state_size = true,
@@ -945,8 +950,7 @@ static const struct dcn401_commit_step bls_update_head_global_preamble[] = {
  * Net effect: hwss_wait_for_outstanding_hw_updates on the current state,
  * which a full update runs before it takes the pipe lock.
  */
-static const struct dcn401_commit_step
-		bls_update_head_per_stream_per_otg_master_pipe_current_pending[] = {
+static const struct dcn401_commit_step pending[] = {
 	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES },
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
 	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
@@ -961,29 +965,32 @@ static const struct dcn401_commit_step
  * dcn401_program_front_end_for_ctx, then the forced p-state and delay for
  * the first HUBP.
  */
-static const struct dcn401_commit_step bls_update_head_new_lock[] = {
+static const struct dcn401_commit_step lock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_dpp_lock[] = {
+static const struct dcn401_commit_step dpp_lock[] = {
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_first_hubp[] = {
+static const struct dcn401_commit_step first_hubp[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
 	  .meta.hubbub_force_pstate_change_control.enable = true },
 	{ .func = DC_UDELAY },
 };
 
 /*
- * blank_pixel_data (unblank), dcn401_program_tg and update_odm.
- * First enable of the HUBP/DPP only.
+ * blank_pixel_data (unblank) on each ODM slice, dcn401_program_tg and
+ * update_odm. First enable of the HUBP/DPP only.
  */
-static const struct dcn401_commit_step bls_update_head_new_stream[] = {
+static const struct dcn401_commit_step opp_unblank[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR,
 	  .meta.opp_set_disp_pattern_generator.unblank = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
+};
+
+static const struct dcn401_commit_step global_sync[] = {
 	{ .func = TG_PROGRAM_GLOBAL_SYNC,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = TG_WAIT_FOR_STATE,
@@ -992,8 +999,11 @@ static const struct dcn401_commit_step bls_update_head_new_stream[] = {
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = TG_SETUP_VERTICAL_INTERRUPT2,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
-	{ .func = OPTC_SET_ODM_BYPASS,
+	{ .func = OPTC_SET_ODM_COMBINE,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
+};
+
+static const struct dcn401_commit_step opp_odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
@@ -1001,7 +1011,7 @@ static const struct dcn401_commit_step bls_update_head_new_stream[] = {
 };
 
 /* enable_plane, then the watermark propagate and the DET segments. */
-static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
+static const struct dcn401_commit_step enable_plane[] = {
 	{ .func = DC_IP_REQUEST_STATUS,
 	  .meta.skip_if.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
@@ -1106,47 +1116,48 @@ static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
  * flip-pending wait, the p-state release and the MALL selection. Last,
  * the manual trigger.
  */
-static const struct dcn401_commit_step bls_update_head_new_unlock[] = {
+static const struct dcn401_commit_step unlock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_dpp_flip[] = {
+static const struct dcn401_commit_step dpp_flip[] = {
 	{ .func = HUBP_WAIT_FLIP_PENDING },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_pstate[] = {
+static const struct dcn401_commit_step pstate[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_dpp_mall[] = {
+static const struct dcn401_commit_step dpp_mall[] = {
 	{ .func = HUBP_UPDATE_MALL_SEL,
 	  .meta.hubp_update_mall_sel.from_new_state = true },
 };
 
-static const struct dcn401_commit_step bls_update_head_new_trigger[] = {
+static const struct dcn401_commit_step trigger[] = {
 	{ .func = OPTC_PROGRAM_MANUAL_TRIGGER,
 	  .meta.skip_if.no_manual_trigger = true },
 };
 
 /* The support check allows one stream, kept across the update. */
 static_assert(
-		ARRAY_SIZE(
-		bls_update_head_per_stream_per_otg_master_pipe_preamble) +
-		ARRAY_SIZE(bls_update_head_global_preamble) +
-		ARRAY_SIZE(bls_update_head_per_state_new_prepare_bandwidth) +
-		ARRAY_SIZE(
-		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
-		ARRAY_SIZE(bls_update_head_new_lock) +
-		ARRAY_SIZE(bls_update_head_new_first_hubp) +
-		ARRAY_SIZE(bls_update_head_new_stream) +
-		ARRAY_SIZE(bls_update_head_new_unlock) +
-		ARRAY_SIZE(bls_update_head_new_pstate) +
-		ARRAY_SIZE(bls_update_head_new_trigger) +
+		ARRAY_SIZE(preamble) +
+		ARRAY_SIZE(global_preamble) +
+		ARRAY_SIZE(prepare_bandwidth) +
+		ARRAY_SIZE(pending) +
+		ARRAY_SIZE(lock) +
+		ARRAY_SIZE(first_hubp) +
+		ARRAY_SIZE(global_sync) +
+		DCN401_MAX_OPP_HEADS * (
+		ARRAY_SIZE(opp_unblank) +
+		ARRAY_SIZE(opp_odm)) +
+		ARRAY_SIZE(unlock) +
+		ARRAY_SIZE(pstate) +
+		ARRAY_SIZE(trigger) +
 		DCN401_MAX_DPP_PIPES * (
-		ARRAY_SIZE(bls_update_head_new_dpp_lock) +
-		ARRAY_SIZE(bls_update_head_new_enable_plane) +
-		ARRAY_SIZE(bls_update_head_new_dpp_flip) +
-		ARRAY_SIZE(bls_update_head_new_dpp_mall)) <= DC2_BLS_MAX_STEPS,
+		ARRAY_SIZE(dpp_lock) +
+		ARRAY_SIZE(enable_plane) +
+		ARRAY_SIZE(dpp_flip) +
+		ARRAY_SIZE(dpp_mall)) <= DC2_BLS_MAX_STEPS,
 		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
 
 /* enable_stream_timing_calc: manual mode unless every span is even. */
@@ -1190,14 +1201,15 @@ static uint32_t dcn401_early_cntl(const struct pipe_ctx *pipe)
 }
 
 /*
- * dcn20_blank_pixel_data: sRGB black over the whole OTG, or the video
- * on unblank.
+ * dcn20_blank_pixel_data: sRGB black over the ODM slice of this OPP head,
+ * or the video on unblank.
  */
 static void dcn401_opp_blank_params(const struct dc *dc,
-		const struct pipe_ctx *pipe, bool unblank,
+		struct pipe_ctx *pipe, bool unblank,
 		struct opp_set_disp_pattern_generator_params *p)
 {
 	const struct dc_crtc_timing *timing = &pipe->stream->timing;
+	struct rect slice = resource_get_odm_slice_src_rect(pipe);
 
 	p->opp = pipe->stream_res.opp;
 	p->test_pattern = unblank ? CONTROLLER_DP_TEST_PATTERN_VIDEOMODE :
@@ -1205,14 +1217,32 @@ static void dcn401_opp_blank_params(const struct dc *dc,
 	p->color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
 	p->color_depth = timing->display_color_depth;
 	p->use_solid_color = true;
-	p->width = timing->h_addressable + timing->h_border_left +
-			timing->h_border_right;
-	p->height = timing->v_addressable + timing->v_border_top +
-			timing->v_border_bottom;
+	p->width = slice.width;
+	p->height = slice.height;
+	p->offset = slice.x;
 	p->disable_dyn_exp_for_test_pattern =
 			dc->debug.disable_dynamic_expansion_for_test_pattern;
 }
 
+/*
+ * dcn401_update_odm: one OPP per ODM slice, in slice order. A table's
+ * OPTC_SET_ODM_COMBINE programs the ODM unconditionally: N:1 combine for
+ * N > 1 slices, else bypass.
+ */
+static void dcn401_odm_combine_params(struct pipe_ctx *otg_master,
+		struct set_odm_combine_params *p)
+{
+	struct pipe_ctx *odm;
+
+	p->tg = otg_master->stream_res.tg;
+	for (odm = otg_master; odm; odm = odm->next_odm_pipe)
+		p->opp_inst[p->opp_head_count++] = odm->stream_res.opp->inst;
+	p->odm_slice_width = resource_get_odm_slice_dst_width(otg_master,
+			false);
+	p->last_odm_slice_width = resource_get_odm_slice_dst_width(otg_master,
+			true);
+}
+
 static void dcn401_program_timing_params(const struct pipe_ctx *pipe,
 		struct tg_program_timing_params *p)
 {
@@ -1534,6 +1564,16 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->tg_program_stereo_params.tg = pipe->stream_res.tg;
 		p->tg_program_stereo_params.timing = &pipe->stream->timing;
 		break;
+	case OPTC_SET_ODM_COMBINE:
+		if (pipe->next_odm_pipe) {
+			dcn401_odm_combine_params(pipe,
+					&p->set_odm_combine_params);
+			break;
+		}
+		entry->func = OPTC_SET_ODM_BYPASS;
+		p->set_odm_bypass_params.tg = pipe->stream_res.tg;
+		p->set_odm_bypass_params.timing = &pipe->stream->timing;
+		break;
 	case OPTC_SET_ODM_BYPASS:
 		p->set_odm_bypass_params.tg = pipe->stream_res.tg;
 		p->set_odm_bypass_params.timing = &pipe->stream->timing;
@@ -1548,7 +1588,7 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->opp_program_left_edge_extra_pixel_params.pixel_encoding =
 				pipe->stream->timing.pixel_encoding;
 		p->opp_program_left_edge_extra_pixel_params.is_otg_master =
-				true;
+				!pipe->prev_odm_pipe;
 		break;
 	case OPP_PROGRAM_FMT:
 		p->opp_program_fmt_params.opp = pipe->stream_res.opp;
@@ -1986,7 +2026,7 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 	return false;
 }
 
-void dcn401_add_steps(struct block_sequence_state *sequence,
+static void dcn401_add_steps(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *steps, unsigned int count)
 {
@@ -1998,7 +2038,7 @@ void dcn401_add_steps(struct block_sequence_state *sequence,
 	}
 }
 
-void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
+static void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
 		const struct dcn401_commit_step *steps, unsigned int count)
@@ -2007,25 +2047,77 @@ void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 	unsigned int i;
 
 	for (i = 0; i < state->stream_count; i++) {
-		args.pipe = get_otg_master_from_state_by_stream(args.dc,
-				state, state->streams[i]);
+		args.pipe = resource_get_otg_master_for_stream(
+				&state->res_ctx, state->streams[i]);
 		dcn401_add_steps(sequence, &args, steps, count);
 	}
 }
 
-void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
+static void dcn401_add_per_opp_head(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
 		const struct dcn401_commit_step *steps, unsigned int count)
 {
 	struct dcn401_commit_step_args args = *state_args;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
 	unsigned int i;
+	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
-		for (args.pipe = get_otg_master_from_state_by_stream(args.dc,
-				state, state->streams[i]); args.pipe;
-				args.pipe = args.pipe->bottom_pipe)
+		n = resource_get_opp_heads_for_stream(state->streams[i],
+				&state->res_ctx, opp_heads);
+		for (j = 0; j < n; j++) {
+			args.pipe = opp_heads[j];
 			dcn401_add_steps(sequence, &args, steps, count);
+		}
+	}
+}
+
+static void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		struct dc_state *state,
+		const struct dcn401_commit_step *steps, unsigned int count)
+{
+	struct dcn401_commit_step_args args = *state_args;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	unsigned int i;
+	int j, n;
+
+	for (i = 0; i < state->stream_count; i++) {
+		n = resource_get_dpp_pipes_for_stream(state->streams[i],
+				&state->res_ctx, dpp_pipes);
+		for (j = 0; j < n; j++) {
+			args.pipe = dpp_pipes[j];
+			dcn401_add_steps(sequence, &args, steps, count);
+		}
+	}
+}
+
+void dcn401_add_sub_sequences(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		const struct dcn401_sub_sequence *subs, unsigned int count)
+{
+	const struct dcn401_sub_sequence *sub;
+	struct dc_state *state;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		sub = &subs[i];
+		state = sub->flags & DCN401_CURRENT_STATE ?
+				state_args->current_state :
+				state_args->new_state;
+		if (sub->flags & DCN401_PER_STREAM_PER_OTG_MASTER)
+			dcn401_add_per_otg_master(sequence, state_args, state,
+					sub->steps, sub->count);
+		else if (sub->flags & DCN401_PER_STREAM_PER_OPP_HEAD)
+			dcn401_add_per_opp_head(sequence, state_args, state,
+					sub->steps, sub->count);
+		else if (sub->flags & DCN401_PER_STREAM_PER_DPP_PIPE)
+			dcn401_add_per_dpp_pipe(sequence, state_args, state,
+					sub->steps, sub->count);
+		else
+			dcn401_add_steps(sequence, state_args, sub->steps,
+					sub->count);
 	}
 }
 
@@ -2045,6 +2137,63 @@ void dcn401_init_and_unpack_params(
 	head->num_steps = &params->head_num_steps;
 }
 
+/*
+ * One stream. skip_if drops first-enable steps when the HUBP/DPP is
+ * already on, so a kept-plane surface update is the same table. The
+ * enable_plane list runs per DPP pipe, top pipe first, so the top MPCC is
+ * inserted before the bottom one.
+ */
+static const struct dcn401_sub_sequence bls_update_head[] = {
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = preamble,
+	  .count = ARRAY_SIZE(preamble) },
+	{ .flags = DCN401_NEW_STATE,
+	  .steps = global_preamble,
+	  .count = ARRAY_SIZE(global_preamble) },
+	{ .flags = DCN401_NEW_STATE,
+	  .steps = prepare_bandwidth,
+	  .count = ARRAY_SIZE(prepare_bandwidth) },
+	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = pending,
+	  .count = ARRAY_SIZE(pending) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = lock,
+	  .count = ARRAY_SIZE(lock) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = dpp_lock,
+	  .count = ARRAY_SIZE(dpp_lock) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = first_hubp,
+	  .count = ARRAY_SIZE(first_hubp) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = opp_unblank,
+	  .count = ARRAY_SIZE(opp_unblank) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = global_sync,
+	  .count = ARRAY_SIZE(global_sync) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OPP_HEAD,
+	  .steps = opp_odm,
+	  .count = ARRAY_SIZE(opp_odm) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = enable_plane,
+	  .count = ARRAY_SIZE(enable_plane) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = unlock,
+	  .count = ARRAY_SIZE(unlock) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = dpp_flip,
+	  .count = ARRAY_SIZE(dpp_flip) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = pstate,
+	  .count = ARRAY_SIZE(pstate) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
+	  .steps = dpp_mall,
+	  .count = ARRAY_SIZE(dpp_mall) },
+	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
+	  .steps = trigger,
+	  .count = ARRAY_SIZE(trigger) },
+};
+
 static enum bls_builder_result dcn401_build_seamless_update(
 		struct bls_builder_declarative_params *params)
 {
@@ -2060,45 +2209,7 @@ static enum bls_builder_result dcn401_build_seamless_update(
 		return result;
 
 	dcn401_init_and_unpack_params(params, &state_args, &head);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_update_head_per_stream_per_otg_master_pipe_preamble);
-	DCN401_ADD_STEPS(&head, &state_args,
-			bls_update_head_global_preamble);
-	DCN401_ADD_STEPS(&head, &state_args,
-			bls_update_head_per_state_new_prepare_bandwidth);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_update_head_per_stream_per_otg_master_pipe_current_pending);
-
-	/*
-	 * One stream. skip_if drops first-enable steps when the HUBP/DPP
-	 * is already on, so a kept-plane surface update is the same table.
-	 */
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_lock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
-			bls_update_head_new_dpp_lock);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_first_hubp);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_stream);
-	/*
-	 * One step list per DPP pipe, top pipe first, so the top MPCC is
-	 * inserted before the bottom one.
-	 */
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
-			bls_update_head_new_enable_plane);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_unlock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
-			bls_update_head_new_dpp_flip);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_pstate);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
-			bls_update_head_new_dpp_mall);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_trigger);
+	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_update_head);
 
 	return BLS_BUILD_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 47c7137eeeaf..297ddbed2eac 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -353,6 +353,10 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 	case TG_SETUP_VERTICAL_INTERRUPT2:
 		tg = step->params.tg_setup_vertical_interrupt2_params.tg;
 		return tg && tg->funcs && tg->funcs->setup_vertical_interrupt2;
+	case OPTC_SET_ODM_COMBINE:
+		tg = step->params.set_odm_combine_params.tg;
+		return tg && tg->funcs && tg->funcs->set_odm_combine &&
+				step->params.set_odm_combine_params.opp_head_count > 1;
 	case OPTC_SET_ODM_BYPASS:
 		tg = step->params.set_odm_bypass_params.tg;
 		return tg && tg->funcs && tg->funcs->set_odm_bypass &&
@@ -1230,6 +1234,17 @@ enum dc2_bls_exec_result dc2_bls_execute(
 			tg->funcs->setup_vertical_interrupt2(tg, entry->params
 					.tg_setup_vertical_interrupt2_params.start_line);
 			break;
+		case OPTC_SET_ODM_COMBINE: {
+			const struct set_odm_combine_params *p =
+					&entry->params.set_odm_combine_params;
+			int opp_inst[MAX_PIPES];
+
+			memcpy(opp_inst, p->opp_inst, sizeof(opp_inst));
+			p->tg->funcs->set_odm_combine(p->tg, opp_inst,
+					p->opp_head_count, p->odm_slice_width,
+					p->last_odm_slice_width);
+			break;
+		}
 		case OPTC_SET_ODM_BYPASS:
 			tg = entry->params.set_odm_bypass_params.tg;
 			tg->funcs->set_odm_bypass(tg,
-- 
2.43.0

