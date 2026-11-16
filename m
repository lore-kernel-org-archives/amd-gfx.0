Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B65606A897
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p4k8p+gJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E9A10F846;
	Tue, 17 Nov 2026 17:16:46 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2333B10F840
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKwo/Pat8aS6kTck70fTAQjGyz8nW+FX9nJjJdnSMDmp3OwdI7i3SzianGfbwvyXNG3YLEr6+2ZJU9DGoZykaYGj9Bs8pgdQgrL1eUSJC4cCkcXpJLaZ3fCydXnogt94XjOZ4Sq1FNCIa0hxeW3ZJBZa26BG97WNt4/1ipvInxXhIoJ+feEFNoltEEPtYUBVw5eXYdMZ7zhwxPi6MXaPPwh0zexjFlv1LpQwrHZWPDNIQNrCKCoL8IDg60IYsY2trkqgnE+r3dczSlZR+btoLNdFhDBPnx1n20G5YSbJ3zA/Nd4L0Ka8akjs9UH/PecfcIgnqV86EFK1qQNrNrL/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/vuRetlFNWdBoO6t6nZZ1al9j922n9/CrFJwASFx7w=;
 b=nxMZiZN8Q7kbCyE6MX8rnx6gVi2J8pU/9473UboYo0PGLe/ENmOeTo3TNPcffo5NYeMJvF5OYSJj6mK4ttCuCtrtsLhr2dvSTSEAfRIFwY9cNgMcqAyOmFb9dAyke0KkZmqhLhxwd/moWpFUHhNb7CR4miCrcq34R8RdneS/W3jftJBwm0FG1QGYASb8JcTKbjhvDr0zDJs982ty88y6fpqETT+NQV3ZvNSiBhk9gx+5PCoNimjh2QCb9AcIy1Xbq65fZ+Qm4fK3xQXLYzbxwfZMLZWn0jqbpxPPRH79iSr6A0DJpWSOpSCsOWsjg9dBOlUSGXG9VPy1ckbor3Erdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/vuRetlFNWdBoO6t6nZZ1al9j922n9/CrFJwASFx7w=;
 b=p4k8p+gJ7vFp9OpcCfiXF+NTHnriXE1RmG5IaYU3OqQD3YTQdcZPKLhSZsiUjGcyRVItK4OPcibEnKTzGCJaVza9ZPNNfVd4yC4JDrmOtnO6b1lqmMeqVHeBWdhe6SxpAKXYrwKjQFPZJnl8627Qx7a25CAeQxXAMLifISjhN3Q=
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:16:30 +0000
Received: from IA0PEPF00000042.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::25) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:16:29 +0000
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
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:24 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:16 -0600
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
Subject: [PATCH 25/33] drm/amd/display: Support two streams in the dcn401 DC2
 builders
Date: Tue, 17 Nov 2026 05:51:02 +0800
Message-ID: <20261116215641.2800595-26-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000042:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: b44a626b-4a8e-4295-9a44-08df44ce8506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|6133799003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003|20052099010|3023799007|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: lBt1g5XmspQ7ufyDwOsiYLB22nvoGyTW/cw69Ics88JXoFxGkSecXAoWHatG+734v08B8dAWCUHzWGvIzxaKa1FYwbkT/bptuKZu1nn/nYXEDe5GifvVs2R8AoOQFQ74Zch9Fkm5taEwd/CXyyCtXXCFMOdQei/PjsMQZwiBDkcmDSlEFnEIySeAJLfAfnAevtDv/tXic9jy4mcBX6fVwB0sqTf00Hl/0oy3OxTp2rvZD+L+Aq1upQjbliZ5tArdVZU17eQXoT2z8ZDoKmdikaUDPO09Sc1G4s+hWKrce5GtBT4oNKv+gVobVNJaxEESxuNgwY3uI23v/Fs34fIEqOPa5gk/uOYgy8pUSjRbHixfcTk0wJZoVzRaYMt1uUwSS0kUOaMoSBG2XWqY04pWypAJG2hNfNXQaxDkfYaTQo/X78aZ3a8LAbP6srNKR2lul5sxugckaTXPMxgiYOTOEZIWOqV6IuKpnsr/BOiasUO7mBoWY88CZX1FTQ81R5b/PqA4s6wfSHb2sDyRLd2xrvnMeo0xghrb0+5r93iv7nh1+8BnyecFJZ5JG0I0+l/WUtuUyKOscKFwbmOV5Zed+k56dehWkhVkFG8+gseUSxe8sSOMLgmafWfcdDw95/0sBB31V38wiyQ+Re/lTIaNMUhoS14LmnKIOWw4Wej3M0k+I/BKZpzdfsFTqGRkKCUIBPD6k4cxKscL4KJzkeqkjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003)(20052099010)(3023799007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8TqSw6EikLKRyLFbv3En8Q5XxsYoZzyK4y4KuejvqC4IgKLll6eyQpnlXt/qaPTaF1jsqmdRD+f5KWTlDgJXBcyk/no6BQ+d1rsaxGSDmzBhtEDrkRR+mLxYf3LhGQ6EzzLrxUG2GbRfJ5a6xywg5A9yGGhih1O0qJA5un+lmcjbwPeYDI4TxrTrA/Nxqq8e/3GCRSMHw8O/+FulwEcOC6JO9BkSnm8ZuM31sc5jgYskMbek//KNAbGoCWH1w3Bz6YMlQ9EYLdXCWpyG5lkQIAlzIdpMABnRRjGoPh2qZbwmc9hVfRnhoA+lDpBSkw/pdMnhUsPcybm0XCbXFygtOpyP9jMOmsXJwi0LrlpRlHaJnrb2o6g02Yp2IjX4Ank0hyNrYFivzIGpOEXJyiK5terYtazFuiGkkzi4DO4mZwKAny7gk4erh3szd18GGFlv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:29.5202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a626b-4a8e-4295-9a44-08df44ce8506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000042.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
The DC2 builders check only the first stream and reject a state with
two streams. Core2 cannot commit or update two streams.

[How]
Run the stream checks on each stream of a state. Find the OTG master
of each stream, and reject two streams on one link. The non-seamless
commit disables each current stream and enables each new stream. The
seamless update programs only the stream that the update names. Core2
builds the info frame and sets the software state for each stream.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   3 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  47 +-
 .../bls_builder/dcn401_non_seamless_builder.c | 158 ++---
 .../dc/bls_builder/dcn401_seamless_builder.c  | 601 ++++++++++--------
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  70 +-
 5 files changed, 496 insertions(+), 383 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 627c6186d135..879ff188264d 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -93,16 +93,19 @@ struct bls_builder_output_targets {
 	};
 };
 
+/* stream is the one stream an update changes, or NULL for a commit. */
 struct bls_builder_check_capability_params {
 	struct dc *dc;
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
+	const struct dc_stream_state *stream;
 };
 
 struct bls_builder_declarative_params {
 	struct dc *dc;
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
+	const struct dc_stream_state *stream;
 	struct bls_builder_output_targets *out_targets;
 	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
 	unsigned int head_num_steps;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index 41a31202162b..35ad8982db9a 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -44,6 +44,23 @@ void dcn401_commit_check_failed(const struct dc *dc, const char *msg);
 		} \
 	} while (0)
 
+/* Each check_<name> stream helper takes the state and a stream index. */
+#define CHECK_STREAM_CONDITION(name, msg) \
+	do { \
+		if (!check_##name(dc, state, i)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
+		} \
+	} while (0)
+
+#define CHECK_STREAM_RESOURCE(name, msg) \
+	do { \
+		if (!check_##name(dc, state, i)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING; \
+		} \
+	} while (0)
+
 static inline const struct dc_state *dcn401_checked_state(
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -51,26 +68,37 @@ static inline const struct dc_state *dcn401_checked_state(
 	return current_state ? current_state : new_state;
 }
 
-/* The OTG master of state's one stream, or NULL when it is not one pipe. */
-const struct pipe_ctx *dcn401_otg_of(const struct dc *dc,
-		const struct dc_state *state);
-const struct pipe_ctx *dcn401_checked_otg_master(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state);
+/* The one OTG master of stream in state, or NULL when it has none or more. */
+const struct pipe_ctx *dcn401_otg_master(const struct dc_state *state,
+		const struct dc_stream_state *stream);
+/* The index of stream in state, or -1. */
+int dcn401_stream_index(const struct dc_state *state,
+		const struct dc_stream_state *stream);
+/*
+ * stream is in both states on the same pipes, each with the same plane
+ * and blocks.
+ */
+bool dcn401_stream_unchanged(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream);
 
 
 /* What both builders need of the dc, before either state. */
 enum bls_builder_result dcn401_check_dc_support(const struct dc *dc);
-/* What both builders need of a state's stream, apart from its planes. */
+/* What both builders need of each stream of a state, apart from its planes. */
 enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state);
 
-/* pipe is NULL only for the bandwidth and p-state steps. */
+/*
+ * pipe is NULL only for the bandwidth and p-state steps. The walkers
+ * expand only stream when it is set.
+ */
 struct dcn401_commit_step_args {
 	struct dc *dc;
 	struct dc_state *current_state;
 	struct dc_state *new_state;
+	const struct dc_stream_state *stream;
 	struct pipe_ctx *pipe;
 };
 
@@ -78,7 +106,8 @@ struct dcn401_commit_step_args {
  * A sub-sequence names the state its steps read and how they expand: once,
  * or once per OTG master, OPP head (ODM slice) or DPP pipe of each stream
  * of that state, the OTG master first. A builder lists its sub-sequences
- * in emission order.
+ * in emission order. A sequence longer than DC2_BLS_MAX_STEPS keeps its
+ * count and only the first entries; Core rejects it.
  */
 #define DCN401_CURRENT_STATE			(1u << 0)
 #define DCN401_NEW_STATE			(1u << 1)
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index d5adbef8a6f1..bfbe2e0e7eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -10,12 +10,12 @@
 #include "state_facts/state_facts.h"
 
 /*
- * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
- * The new state has no stream, or one stream with no plane; the current
- * state has no stream, or one stream with one or two planes, one per DPP
- * pipe. Planes are added later by DCN_DECL_SEAMLESS_UPDATE, not by this
- * commit. The stream is in ODM bypass, 2:1 or 3:1, with one OPP head
- * and at most one DPP pipe per slice.
+ * DCN_DECL_NON_SEAMLESS_COMMIT for virtual streams without planes. It
+ * disables every current stream, each with one or two planes, one per DPP
+ * pipe, then enables every new stream, each with no plane. Planes are
+ * added later by DCN_DECL_SEAMLESS_UPDATE, not by this commit. Each
+ * stream is in ODM bypass, 2:1 or 3:1, with one OPP head and at most one
+ * DPP pipe per slice.
  *
  * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
  * calls in the same order, including the calls DC1 repeats. Everything is
@@ -32,78 +32,44 @@ static bool check_stream_config_update(const struct dc *dc,
 	return !dc->ctx->cp_psp.funcs.update_stream_config;
 }
 
-static bool check_plane_count(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+/* A current stream has its planes, one per DPP pipe. */
+static bool check_current_planes(const struct dc *dc,
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-	unsigned int planes = state->stream_status[0].plane_count;
+	unsigned int planes = state->stream_status[i].plane_count;
 	struct dc_state_facts facts;
 
-	/*
-	 * The current state carries the removed planes, one per DPP pipe.
-	 * The new state has none.
-	 */
 	(void)dc;
-	if (!current_state)
-		return !planes;
 	dc_state_facts_derive(state, &facts);
 	return planes && planes ==
-			facts.global.blend_tree[0].dpp_pipe_count;
-}
-
-static bool check_pipe_plane(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	/*
-	 * The current state carries the removed planes. The new state has
-	 * none.
-	 */
-	struct dc_state_facts facts;
-	const struct dc_state *state = current_state ? current_state : new_state;
-
-	(void)dc;
-	dc_state_facts_derive(state, &facts);
-	if (!facts.pipe.count)
-		return false;
-	if (current_state)
-		return dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
-				DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
-	return !dc_state_facts_any_pipe(&facts, 0,
+			facts.global.blend_tree[i].dpp_pipe_count &&
+			dc_state_facts_all_pipe(&facts, (uint8_t)i,
+			DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
 }
 
 static bool check_plane_blocks(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
-	(void)new_state;
 	(void)dc;
-	if (!current_state)
-		return true;
-	dc_state_facts_derive(current_state, &facts);
-	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+	dc_state_facts_derive(state, &facts);
+	return dc_state_facts_all_pipe(&facts, (uint8_t)i,
+			DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
 
 /* Each OPP's tree holds exactly the removed MPCCs of its slice, in order. */
 static bool check_mpcc_tree(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *opp_head = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *opp_head = dcn401_otg_master(state,
+			state->streams[i]);
 	const struct pipe_ctx *pipe;
 	const struct mpcc *mpcc;
 
-	if (!current_state)
-		return true;
-	if (!opp_head || !dc->res_pool || !dc->res_pool->mpc)
+	if (!dc->res_pool || !dc->res_pool->mpc)
 		return false;
 	for (; opp_head; opp_head = opp_head->next_odm_pipe) {
 		mpcc = opp_head->stream_res.opp->mpc_tree_params.opp_list;
@@ -120,42 +86,79 @@ static bool check_mpcc_tree(const struct dc *dc,
 	return true;
 }
 
+/* A new stream has no plane. */
+static bool check_new_no_planes(const struct dc *dc,
+		const struct dc_state *state, unsigned int i)
+{
+	struct dc_state_facts facts;
+
+	(void)dc;
+	dc_state_facts_derive(state, &facts);
+	return !state->stream_status[i].plane_count &&
+			!dc_state_facts_any_pipe(&facts, (uint8_t)i,
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
+}
+
+static enum bls_builder_result dcn401_check_current_stream(
+		const struct dc *dc, const struct dc_state *state,
+		unsigned int i)
+{
+	CHECK_STREAM_CONDITION(current_planes,
+			"plane count does not match the pipes");
+	CHECK_STREAM_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
+	CHECK_STREAM_CONDITION(mpcc_tree, "opp tree does not match the pipes");
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_check_new_stream(
+		const struct dc *dc, const struct dc_state *state,
+		unsigned int i)
+{
+	CHECK_STREAM_CONDITION(new_no_planes, "new stream has a plane");
+	return BLS_BUILD_SUCCESS;
+}
+
 static enum bls_builder_result dcn401_check_commit_state_support(
 		const struct dc *dc, const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
 	enum bls_builder_result result;
+	unsigned int i;
 
 	result = dcn401_check_stream_support(dc, current_state, new_state);
-	if (result != BLS_BUILD_SUCCESS ||
-			!dcn401_checked_state(current_state,
-			new_state)->stream_count)
-		return result;
-
-	CHECK_CONDITION(plane_count, "plane count does not match the state");
-	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
-	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
-	CHECK_CONDITION(mpcc_tree, "opp tree does not match the pipes");
-	return BLS_BUILD_SUCCESS;
+	for (i = 0; result == BLS_BUILD_SUCCESS && i < state->stream_count;
+			i++)
+		result = current_state ?
+				dcn401_check_current_stream(dc, state, i) :
+				dcn401_check_new_stream(dc, state, i);
+	return result;
 }
 
 /*
- * The current stream is disabled before the new one is enabled, so the
- * link may be active when it carries the current stream.
+ * The current streams are disabled before the new ones are enabled, so a
+ * new stream's link may be active when it carries a current stream.
  */
 static bool check_link_not_active(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	const struct dc_link *link;
+	int i, j;
 
 	(void)dc;
-	if (!new_state->stream_count)
-		return true;
-	link = new_state->streams[0]->link;
-	return !link->link_status.link_active ||
-			(current_state->stream_count &&
-			current_state->streams[0]->link == link);
+	for (i = 0; i < new_state->stream_count; i++) {
+		link = new_state->streams[i]->link;
+		if (!link->link_status.link_active)
+			continue;
+		for (j = 0; j < current_state->stream_count; j++)
+			if (current_state->streams[j]->link == link)
+				break;
+		if (j == current_state->stream_count)
+			return false;
+	}
+	return true;
 }
 
 static enum bls_builder_result dcn401_check_non_seamless_commit_support(
@@ -200,7 +203,7 @@ prepare_bandwidth[] = {
 };
 
 /*
- * Net effect: disable the stream of the current state.
+ * Net effect: disable each stream of the current state.
  * - disable_dangling_plane: disconnect the MPCC under the OTG lock, then
  *   dcn20_disable_plane.
  * - link_set_dpms_off for the virtual signal: dcn401_disable_stream, then
@@ -265,7 +268,7 @@ static const struct dcn401_commit_step stream_off[] = {
 };
 
 /*
- * Net effect: enable the stream of the new state. Between the BIOS
+ * Net effect: enable each stream of the new state. Between the BIOS
  * critical-state calls:
  * - dcn401_enable_stream_timing plus the dce110_apply_single_controller
  *   calls around it, up to the DIG connect.
@@ -376,10 +379,7 @@ static const struct dcn401_commit_step postamble[] = {
 	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = true },
 };
 
-/*
- * Bounds on what build adds. The support check allows one stream per
- * state, and never one in both.
- */
+/* Bounds on what build adds for one stream in either state. */
 static_assert(ARRAY_SIZE(prepare_bandwidth) +
 		ARRAY_SIZE(lock) +
 		DCN401_MAX_OPP_HEADS * ARRAY_SIZE(blank) +
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index a9884eefdd9f..09ea7ba26452 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -26,11 +26,12 @@
 	dc->ctx->logger
 
 /*
- * DCN_DECL_SEAMLESS_UPDATE for the one virtual stream that
+ * DCN_DECL_SEAMLESS_UPDATE for one of the virtual streams that
  * DCN_DECL_NON_SEAMLESS_COMMIT (dcn401_non_seamless_builder.c) enabled.
- * The update either adds one plane, or two MPC-blended planes, to that
- * stream, or keeps one plane and programs its surface, address, scaler
- * and viewport. The sequence follows the full update in
+ * The other streams keep their pipes and planes, and the update programs
+ * none of them. The update either adds one plane, or two MPC-blended
+ * planes, to the stream, or keeps one plane and programs its surface,
+ * address, scaler and viewport. The sequence follows the full update in
  * commit_planes_for_stream on dcn401, all in head_sequence: the
  * outstanding updates, prepare_bandwidth and the pending-update waits,
  * then the locked front-end programming and
@@ -138,15 +139,13 @@ enum bls_builder_result dcn401_check_dc_support(const struct dc *dc)
 	return BLS_BUILD_SUCCESS;
 }
 
-static bool check_one_stream(const struct dc *dc,
+static bool check_no_phantom(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-
 	(void)dc;
-	return state->stream_count <= 1 && !state->phantom_stream_count;
+	return !dcn401_checked_state(current_state,
+			new_state)->phantom_stream_count;
 }
 
 static bool check_fams2_state(const struct dc *dc,
@@ -161,47 +160,35 @@ static bool check_fams2_state(const struct dc *dc,
 }
 
 static bool check_stream_link(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-	const struct dc_stream_state *stream = state->streams[0];
-
 	(void)dc;
-	return stream && stream->link;
+	return state->streams[i] && state->streams[i]->link;
 }
 
 /* link_set_dpms_on and _off program nothing for a virtual signal. */
 static bool check_virtual_signal(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-
 	(void)dc;
 	(void)state;
+	(void)i;
 	return false;
 }
 
 static bool check_link_encoder(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_link *link = dcn401_checked_state(current_state,
-			new_state)->streams[0]->link;
+	const struct dc_link *link = state->streams[i]->link;
 
 	(void)dc;
 	return link->ep_type == DISPLAY_ENDPOINT_PHY && link->link_enc;
 }
 
 static bool check_timing_flags(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_crtc_timing *timing = &dcn401_checked_state(
-			current_state, new_state)->streams[0]->timing;
+	const struct dc_crtc_timing *timing = &state->streams[i]->timing;
 
 	(void)dc;
 	return !timing->flags.DSC && !timing->flags.INTERLACE &&
@@ -210,11 +197,9 @@ static bool check_timing_flags(const struct dc *dc,
 
 /* The DPG black and the pixel rate divider are fixed for RGB. */
 static bool check_rgb_srgb(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_stream_state *stream = dcn401_checked_state(
-			current_state, new_state)->streams[0];
+	const struct dc_stream_state *stream = state->streams[i];
 
 	(void)dc;
 	return stream->timing.pixel_encoding == PIXEL_ENCODING_RGB &&
@@ -222,11 +207,9 @@ static bool check_rgb_srgb(const struct dc *dc,
 }
 
 static bool check_no_drr(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_stream_state *stream = dcn401_checked_state(
-			current_state, new_state)->streams[0];
+	const struct dc_stream_state *stream = state->streams[i];
 
 	(void)dc;
 	return !stream->ignore_msa_timing_param &&
@@ -235,11 +218,9 @@ static bool check_no_drr(const struct dc *dc,
 }
 
 static bool check_no_boot_dpms_writeback(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_stream_state *stream = dcn401_checked_state(
-			current_state, new_state)->streams[0];
+	const struct dc_stream_state *stream = state->streams[i];
 
 	(void)dc;
 	return !stream->apply_seamless_boot_optimization && !stream->dpms_off &&
@@ -247,11 +228,9 @@ static bool check_no_boot_dpms_writeback(const struct dc *dc,
 }
 
 static bool check_abm(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct dc_stream_state *stream = dcn401_checked_state(
-			current_state, new_state)->streams[0];
+	const struct dc_stream_state *stream = state->streams[i];
 
 	(void)dc;
 	return !stream->abm_level ||
@@ -259,82 +238,86 @@ static bool check_abm(const struct dc *dc,
 }
 
 /*
- * The OTG master for this state's one stream, or NULL when the stream has
- * more than one. An MPC bottom pipe or an ODM slice of the stream is not
- * an OTG master; check_mpc_blend and check_odm_combine bound them.
+ * An MPC bottom pipe or an ODM slice of the stream is not an OTG master;
+ * check_mpc_blend and check_odm_combine bound them.
  */
-static const struct pipe_ctx *dcn401_state_otg_master(const struct dc *dc,
-		const struct dc_state *state, bool *not_one_pipe)
+const struct pipe_ctx *dcn401_otg_master(const struct dc_state *state,
+		const struct dc_stream_state *stream)
 {
 	const struct pipe_ctx *otg_master = NULL;
 	unsigned int i;
 
-	(void)dc;
-	*not_one_pipe = false;
 	for (i = 0; i < MAX_PIPES; i++) {
 		const struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
-			continue;
-		if (pipe->stream == state->streams[0] &&
-				(pipe->top_pipe || pipe->prev_odm_pipe))
+		if (!stream || pipe->stream != stream ||
+				pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream != state->streams[0] || otg_master) {
-			*not_one_pipe = true;
+		if (otg_master)
 			return NULL;
-		}
 		otg_master = pipe;
 	}
 	return otg_master;
 }
 
-const struct pipe_ctx *dcn401_checked_otg_master(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+int dcn401_stream_index(const struct dc_state *state,
+		const struct dc_stream_state *stream)
 {
-	bool not_one_pipe = false;
+	int i;
 
-	return dcn401_state_otg_master(dc, dcn401_checked_state(current_state,
-			new_state), &not_one_pipe);
+	for (i = 0; i < state->stream_count; i++)
+		if (state->streams[i] == stream)
+			return i;
+	return -1;
 }
 
-const struct pipe_ctx *dcn401_otg_of(const struct dc *dc,
-		const struct dc_state *state)
+bool dcn401_stream_unchanged(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
 {
-	bool not_one_pipe = false;
-
-	if (!state)
-		return NULL;
-	return dcn401_state_otg_master(dc, state, &not_one_pipe);
-}
-
-static bool check_one_otg_pipe(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	bool not_one_pipe = false;
+	const struct pipe_ctx *cur, *new;
+	unsigned int i;
 
-	dcn401_state_otg_master(dc, dcn401_checked_state(current_state,
-			new_state), &not_one_pipe);
-	return !not_one_pipe;
+	if (dcn401_stream_index(current_state, stream) < 0 ||
+			dcn401_stream_index(new_state, stream) < 0)
+		return false;
+	for (i = 0; i < MAX_PIPES; i++) {
+		cur = &current_state->res_ctx.pipe_ctx[i];
+		new = &new_state->res_ctx.pipe_ctx[i];
+		if ((cur->stream == stream) != (new->stream == stream))
+			return false;
+		if (new->stream != stream)
+			continue;
+		if (cur->plane_state != new->plane_state ||
+				cur->plane_res.hubp != new->plane_res.hubp ||
+				cur->plane_res.dpp != new->plane_res.dpp ||
+				cur->stream_res.tg != new->stream_res.tg ||
+				cur->stream_res.opp != new->stream_res.opp ||
+				!cur->top_pipe != !new->top_pipe ||
+				!cur->bottom_pipe != !new->bottom_pipe ||
+				!cur->prev_odm_pipe != !new->prev_odm_pipe ||
+				!cur->next_odm_pipe != !new->next_odm_pipe)
+			return false;
+	}
+	return true;
 }
 
 static bool check_otg_master_present(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	return dcn401_checked_otg_master(dc, current_state, new_state) != NULL;
+	(void)dc;
+	return dcn401_otg_master(state, state->streams[i]) != NULL;
 }
 
 /* At most DCN401_MAX_OPP_HEADS ODM slices, each with an OPP. */
 static bool check_odm_combine(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *odm = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *odm = dcn401_otg_master(state,
+			state->streams[i]);
 	unsigned int count = 0;
 
+	(void)dc;
 	for (; odm; odm = odm->next_odm_pipe)
 		if (!odm->stream_res.opp || ++count > DCN401_MAX_OPP_HEADS)
 			return false;
@@ -342,76 +325,69 @@ static bool check_odm_combine(const struct dc *dc,
 }
 
 static bool check_mpc_blend(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
-
 	struct dc_state_facts facts;
 
-	if (!pipe || pipe->top_pipe)
-		return false;
-	dc_state_facts_derive(dcn401_checked_state(current_state, new_state),
-			&facts);
+	(void)dc;
+	dc_state_facts_derive(state, &facts);
 	/*
 	 * At most one bottom pipe, on the master's OTG and OPP. A bottom pipe
 	 * and ODM do not go together.
 	 */
-	return facts.global.blend_tree[0].dpp_pipe_count <= 2 &&
-			facts.global.blend_tree[0].on_otg_master_blocks &&
-			(facts.global.blend_tree[0].dpp_pipe_count == 1 ||
-			!dc_state_facts_any_pipe(&facts, 0,
+	return facts.global.blend_tree[i].dpp_pipe_count <= 2 &&
+			facts.global.blend_tree[i].on_otg_master_blocks &&
+			(facts.global.blend_tree[i].dpp_pipe_count == 1 ||
+			!dc_state_facts_any_pipe(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ODM, 0)));
 }
 
 static bool check_otg_master_blocks(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *pipe = dcn401_otg_master(state,
+			state->streams[i]);
 
+	(void)dc;
 	return pipe && pipe->stream_res.tg && pipe->stream_res.opp &&
 			pipe->stream_res.stream_enc && pipe->clock_source;
 }
 
 static bool check_pipe_audio(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *pipe = dcn401_otg_master(state,
+			state->streams[i]);
 
+	(void)dc;
 	return pipe && !pipe->stream_res.audio;
 }
 
 static bool check_pipe_dsc(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *pipe = dcn401_otg_master(state,
+			state->streams[i]);
 
+	(void)dc;
 	return pipe && !pipe->stream_res.dsc;
 }
 
 static bool check_pipe_gsl(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *pipe = dcn401_otg_master(state,
+			state->streams[i]);
 
+	(void)dc;
 	return pipe && !pipe->stream_res.gsl_group;
 }
 
 static bool check_link_enc_assignment(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *state, unsigned int i)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
-			current_state, new_state);
+	const struct pipe_ctx *pipe = dcn401_otg_master(state,
+			state->streams[i]);
 
 	if (!dc->config.unify_link_enc_assignment)
 		return true;
@@ -419,69 +395,133 @@ static bool check_link_enc_assignment(const struct dc *dc,
 			pipe->stream->link->link_enc;
 }
 
+/* Each stream on its own link. */
+static bool check_own_link(const struct dc *dc,
+		const struct dc_state *state, unsigned int i)
+{
+	unsigned int j;
+
+	(void)dc;
+	for (j = 0; j < i; j++)
+		if (state->streams[j]->link == state->streams[i]->link)
+			return false;
+	return true;
+}
+
+static enum bls_builder_result dcn401_check_one_stream(const struct dc *dc,
+		const struct dc_state *state, unsigned int i)
+{
+	CHECK_STREAM_RESOURCE(stream_link, "stream has no link");
+	CHECK_STREAM_CONDITION(own_link, "streams share a link");
+	CHECK_STREAM_CONDITION(virtual_signal, "signal is not virtual");
+	CHECK_STREAM_RESOURCE(link_encoder, "link encoder is not DIO");
+	CHECK_STREAM_CONDITION(timing_flags,
+			"timing is DSC, interlace, or stereo");
+	CHECK_STREAM_CONDITION(rgb_srgb, "stream is not RGB sRGB");
+	CHECK_STREAM_CONDITION(no_drr, "DRR is set");
+	CHECK_STREAM_CONDITION(no_boot_dpms_writeback,
+			"seamless boot, dpms, or writeback is set");
+	CHECK_STREAM_CONDITION(abm, "ABM level is set");
+	CHECK_STREAM_RESOURCE(otg_master_present,
+			"stream has no otg master, or more than one");
+	CHECK_STREAM_CONDITION(odm_combine, "odm is not bypass, 2:1 or 3:1");
+	CHECK_STREAM_CONDITION(mpc_blend,
+			"more than one bottom pipe, off the otg or opp, or with odm");
+	CHECK_STREAM_RESOURCE(otg_master_blocks,
+			"otg master is missing a stream resource or pixel clock");
+	CHECK_STREAM_CONDITION(pipe_audio, "audio is set");
+	CHECK_STREAM_CONDITION(pipe_dsc, "dsc is set");
+	CHECK_STREAM_CONDITION(pipe_gsl, "gsl is set");
+	CHECK_STREAM_CONDITION(link_enc_assignment,
+			"link encoder assignment differs");
+	return BLS_BUILD_SUCCESS;
+}
+
+/* Every pipe with a stream belongs to a stream of the state. */
+static bool check_pipe_streams(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+	unsigned int i;
+
+	(void)dc;
+	for (i = 0; i < MAX_PIPES; i++)
+		if (state->res_ctx.pipe_ctx[i].stream &&
+				dcn401_stream_index(state,
+				state->res_ctx.pipe_ctx[i].stream) < 0)
+			return false;
+	return true;
+}
+
 enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	const struct dc_state *state = dcn401_checked_state(current_state,
 			new_state);
+	enum bls_builder_result result;
+	unsigned int i;
 
 	if (!state)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-	CHECK_CONDITION(one_stream, "more than one stream");
+	CHECK_CONDITION(no_phantom, "a phantom stream is set");
 	CHECK_CONDITION(fams2_state, "fams2 is enabled");
-	if (!state->stream_count)
-		return BLS_BUILD_SUCCESS;
-
-	CHECK_RESOURCE(stream_link, "stream has no link");
-	CHECK_CONDITION(virtual_signal, "signal is not virtual");
-	CHECK_RESOURCE(link_encoder, "link encoder is not DIO");
-	CHECK_CONDITION(timing_flags, "timing is DSC, interlace, or stereo");
-	CHECK_CONDITION(rgb_srgb, "stream is not RGB sRGB");
-	CHECK_CONDITION(no_drr, "DRR is set");
-	CHECK_CONDITION(no_boot_dpms_writeback,
-			"seamless boot, dpms, or writeback is set");
-	CHECK_CONDITION(abm, "ABM level is set");
-	CHECK_CONDITION(one_otg_pipe, "stream is not on one pipe");
-	CHECK_RESOURCE(otg_master_present, "stream has no otg master");
-	CHECK_CONDITION(odm_combine, "odm is not bypass, 2:1 or 3:1");
-	CHECK_CONDITION(mpc_blend,
-			"more than one bottom pipe, off the otg or opp, or with odm");
-	CHECK_RESOURCE(otg_master_blocks,
-			"otg master is missing a stream resource or pixel clock");
-	CHECK_CONDITION(pipe_audio, "audio is set");
-	CHECK_CONDITION(pipe_dsc, "dsc is set");
-	CHECK_CONDITION(pipe_gsl, "gsl is set");
-	CHECK_CONDITION(link_enc_assignment, "link encoder assignment differs");
+	CHECK_CONDITION(pipe_streams, "a pipe has a stream the state lacks");
+	for (i = 0; i < state->stream_count; i++) {
+		result = dcn401_check_one_stream(dc, state, i);
+		if (result != BLS_BUILD_SUCCESS)
+			return result;
+	}
 	return BLS_BUILD_SUCCESS;
 }
 
-/* The seamless update keeps the one stream across the update. */
-static bool check_stream_kept(const struct dc *dc,
+/*
+ * The update keeps every stream. A stream other than the updated one keeps
+ * its pipes, planes and blocks.
+ */
+static bool check_streams_kept(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
+	int j;
+
 	(void)dc;
-	return current_state->stream_count == 1 &&
-			new_state->stream_count == 1 &&
-			current_state->streams[0] == new_state->streams[0];
+	if (current_state->stream_count != new_state->stream_count)
+		return false;
+	for (j = 0; j < new_state->stream_count; j++)
+		if (dcn401_stream_index(current_state,
+				new_state->streams[j]) < 0 ||
+				(j != i && !dcn401_stream_unchanged(current_state,
+				new_state, new_state->streams[j])))
+			return false;
+	return true;
+}
+
+static unsigned int dcn401_current_plane_count(
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	return current_state->stream_status[dcn401_stream_index(current_state,
+			new_state->streams[i])].plane_count;
 }
 
 /* Both planes of an MPO state are added together, by one update. */
 static bool dcn401_is_plane_add(const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	unsigned int planes = new_state->stream_status[0].plane_count;
+	unsigned int planes = new_state->stream_status[i].plane_count;
 
-	return !current_state->stream_status[0].plane_count &&
+	return !dcn401_current_plane_count(current_state, new_state, i) &&
 			(planes == 1 || planes == 2);
 }
 
 static bool dcn401_is_plane_kept(const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	return current_state->stream_status[0].plane_count == 1 &&
-			new_state->stream_status[0].plane_count == 1;
+	return dcn401_current_plane_count(current_state, new_state, i) == 1 &&
+			new_state->stream_status[i].plane_count == 1;
 }
 
 /*
@@ -491,28 +531,30 @@ static bool dcn401_is_plane_kept(const struct dc_state *current_state,
  */
 static bool check_plane_add_or_kept(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)dc;
-	if (!dcn401_is_plane_add(current_state, new_state) &&
-			!dcn401_is_plane_kept(current_state, new_state))
+	if (!dcn401_is_plane_add(current_state, new_state, i) &&
+			!dcn401_is_plane_kept(current_state, new_state, i))
 		return false;
 	dc_state_facts_derive(new_state, &facts);
-	return facts.global.blend_tree[0].dpp_pipe_count ==
-			new_state->stream_status[0].plane_count;
+	return facts.global.blend_tree[i].dpp_pipe_count ==
+			new_state->stream_status[i].plane_count;
 }
 
 static bool check_same_otg_master_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	const struct pipe_ctx *current_pipe = dcn401_otg_of(dc, current_state);
-	const struct pipe_ctx *new_pipe = dcn401_otg_of(dc, new_state);
+	const struct pipe_ctx *current_pipe = dcn401_otg_master(current_state,
+			new_state->streams[i]);
+	const struct pipe_ctx *new_pipe = dcn401_otg_master(new_state,
+			new_state->streams[i]);
 
-	if (!current_pipe || !new_pipe ||
-			current_pipe->stream_res.tg != new_pipe->stream_res.tg)
+	(void)dc;
+	if (current_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		return false;
 	/* The same OPP for each ODM slice. */
 	for (; current_pipe && new_pipe;
@@ -525,16 +567,16 @@ static bool check_same_otg_master_blocks(const struct dc *dc,
 
 static bool check_new_plane_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)current_state;
-	if (!dcn401_otg_of(dc, new_state))
-		return false;
+	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i,
+			DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE |
 			DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
@@ -580,23 +622,23 @@ static bool check_no_sanity_checks(const struct dc *dc,
 
 static bool check_no_pipe_wait(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)current_state;
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
-	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, 0,
+	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_WAIT, 0));
 }
 
 /* dcn20_blank_pixel_data does nothing while a test pattern is on. */
 static bool check_no_test_pattern(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	const struct dc_stream_state *stream = new_state->streams[0];
+	const struct dc_stream_state *stream = new_state->streams[i];
 
 	(void)dc;
 	(void)current_state;
@@ -618,14 +660,14 @@ static bool check_no_forced_dpg(const struct dc *dc,
 /* dcn20_blank_pixel_data sets the ABM pipe on unblank when there is one. */
 static bool check_no_abm_pipe(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)current_state;
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
-	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, 0,
+	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ABM, 0));
 }
 
@@ -642,20 +684,19 @@ static bool check_no_vm_aperture(const struct dc *dc,
 /* enable_plane sets the flip interrupt when the plane asks for one. */
 static bool check_no_flip_int(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
-	int i, n = new_state && new_state->stream_count ?
-			resource_get_dpp_pipes_for_stream(new_state->streams[0],
+	int j, n = resource_get_dpp_pipes_for_stream(new_state->streams[i],
 			(struct resource_context *)&new_state->res_ctx,
-			dpp_pipes) : 0;
+			dpp_pipes);
 
 	(void)dc;
 	(void)current_state;
 	if (!n)
 		return false;
-	for (i = 0; i < n; i++)
-		if (dpp_pipes[i]->plane_state->flip_int_enabled)
+	for (j = 0; j < n; j++)
+		if (dpp_pipes[j]->plane_state->flip_int_enabled)
 			return false;
 	return true;
 }
@@ -663,20 +704,19 @@ static bool check_no_flip_int(const struct dc *dc,
 /* The update bypasses the plane gamut remap. */
 static bool check_no_plane_gamut_remap(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
-	int i, n = new_state && new_state->stream_count ?
-			resource_get_dpp_pipes_for_stream(new_state->streams[0],
+	int j, n = resource_get_dpp_pipes_for_stream(new_state->streams[i],
 			(struct resource_context *)&new_state->res_ctx,
-			dpp_pipes) : 0;
+			dpp_pipes);
 
 	(void)dc;
 	(void)current_state;
 	if (!n)
 		return false;
-	for (i = 0; i < n; i++)
-		if (dpp_pipes[i]->plane_state->gamut_remap_matrix.enable_remap)
+	for (j = 0; j < n; j++)
+		if (dpp_pipes[j]->plane_state->gamut_remap_matrix.enable_remap)
 			return false;
 	return true;
 }
@@ -684,45 +724,44 @@ static bool check_no_plane_gamut_remap(const struct dc *dc,
 /* The update bypasses the stream gamut remap. */
 static bool check_no_stream_gamut_remap(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	(void)dc;
 	(void)current_state;
-	return !new_state->streams[0]->gamut_remap_matrix.enable_remap;
+	return !new_state->streams[i]->gamut_remap_matrix.enable_remap;
 }
 
 /* The update sets the default output CSC. */
 static bool check_no_output_csc(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	(void)dc;
 	(void)current_state;
-	return !new_state->streams[0]->csc_color_matrix.enable_adjustment;
+	return !new_state->streams[i]->csc_color_matrix.enable_adjustment;
 }
 
 /* The update programs the surface and its address without DCC. */
 static bool check_no_dcc(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)current_state;
-	if (!dcn401_otg_of(dc, new_state))
-		return false;
+	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			!dc_state_facts_any_plane(&facts, 0,
+			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DCC, 0));
 }
 
 /* The update programs a single graphics address, not stereo or video. */
 static bool check_graphics_address(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
@@ -730,27 +769,26 @@ static bool check_graphics_address(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			dc_state_facts_all_plane(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_plane(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_GRAPHICS_ADDRESS, 0));
 }
 
 /* DC1 programs triple buffering and the flip only for a queued flip. */
 static bool check_no_immediate_flip(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
 	(void)current_state;
-	if (!dcn401_otg_of(dc, new_state))
-		return false;
+	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			!dc_state_facts_any_plane(&facts, 0,
+			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_FLIP_IMMEDIATE, 0));
 }
 
@@ -760,7 +798,7 @@ static bool check_no_immediate_flip(const struct dc *dc,
  */
 static bool check_no_degamma_curve(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
@@ -768,16 +806,16 @@ static bool check_no_degamma_curve(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			!dc_state_facts_any_plane(&facts, 0,
+			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DEGAMMA_CURVE, 0));
 }
 
 /* dcn401_set_mcm_luts then programs every MCM LUT off. */
 static bool check_no_mcm_luts(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	struct dc_state_facts facts;
 
@@ -786,17 +824,17 @@ static bool check_no_mcm_luts(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			!dc_state_facts_any_plane(&facts, 0,
+			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_MCM_LUTS, 0));
 }
 
 static bool check_no_shaper_curve(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	const struct dc_transfer_func *shaper = new_state->streams[0]->func_shaper;
+	const struct dc_transfer_func *shaper = new_state->streams[i]->func_shaper;
 
 	(void)dc;
 	(void)current_state;
@@ -805,9 +843,9 @@ static bool check_no_shaper_curve(const struct dc *dc,
 
 static bool check_no_stream_3dlut(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
-	const struct dc_3dlut *lut3d = new_state->streams[0]->lut3d_func;
+	const struct dc_3dlut *lut3d = new_state->streams[i]->lut3d_func;
 
 	(void)dc;
 	(void)current_state;
@@ -816,44 +854,76 @@ static bool check_no_stream_3dlut(const struct dc *dc,
 
 static bool check_no_regamma_curve(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	(void)dc;
 	(void)current_state;
-	return new_state->streams[0]->out_transfer_func.type !=
+	return new_state->streams[i]->out_transfer_func.type !=
 			TF_TYPE_DISTRIBUTED_POINTS;
 }
 
 static bool check_no_cursor(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	(void)dc;
 	(void)current_state;
-	return !new_state->streams[0]->cursor_attributes.address.quad_part;
+	return !new_state->streams[i]->cursor_attributes.address.quad_part;
 }
 
 static bool check_no_dsc_change(const struct dc *dc,
 		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, unsigned int i)
 {
 	(void)dc;
 	(void)current_state;
-	return !new_state->streams[0]->update_flags.bits.dsc_changed;
+	return !new_state->streams[i]->update_flags.bits.dsc_changed;
 }
 
 /*
  * The checks follow the update in the order it programs the pipe. Each one
  * rejects a state for which DC1 would make a call the update does not emit.
  */
+#define CHECK_UPDATE(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state, i)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
+		} \
+	} while (0)
+
+#define CHECK_UPDATE_RESOURCE(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state, i)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING; \
+		} \
+	} while (0)
+
+/* The updated stream: the one named, else the state's only stream. */
+static const struct dc_stream_state *dcn401_updated_stream(
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
+{
+	if (!stream && new_state->stream_count == 1)
+		return new_state->streams[0];
+	return stream;
+}
+
 static enum bls_builder_result dcn401_check_seamless_update_support(
 		const struct dc *dc, const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
 {
 	enum bls_builder_result result;
+	int i;
 
 	if (!dc || !current_state || !new_state)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	i = dcn401_stream_index(new_state,
+			dcn401_updated_stream(new_state, stream));
+	if (i < 0)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
 	result = dcn401_check_dc_support(dc);
 	if (result != BLS_BUILD_SUCCESS)
@@ -866,45 +936,46 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	/* The transition: one stream, kept; add a plane or keep one plane. */
-	CHECK_CONDITION(stream_kept, "stream is not kept across the update");
-	CHECK_CONDITION(plane_add_or_kept,
+	/* The transition: streams kept; add a plane or keep one plane. */
+	CHECK_UPDATE(streams_kept,
+			"a stream is not kept, or another stream changes");
+	CHECK_UPDATE(plane_add_or_kept,
 			"update is not a plane add or a kept-plane surface update");
-	CHECK_CONDITION(same_otg_master_blocks, "otg, opp or odm changes");
-	CHECK_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
+	CHECK_UPDATE(same_otg_master_blocks, "otg, opp or odm changes");
+	CHECK_UPDATE_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
 
 	/* Under the lock, before the pipe is programmed. */
 	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
 	CHECK_CONDITION(no_sanity_checks, "sanity checks are enabled");
-	CHECK_CONDITION(no_pipe_wait, "pipe wait is required");
+	CHECK_UPDATE(no_pipe_wait, "pipe wait is required");
 
 	/* Unblank / enable_plane: only the plane-add path emits these. */
-	CHECK_CONDITION(no_test_pattern, "test pattern is set");
+	CHECK_UPDATE(no_test_pattern, "test pattern is set");
 	CHECK_CONDITION(no_forced_dpg, "dpg is forced");
-	CHECK_CONDITION(no_abm_pipe, "abm is set");
+	CHECK_UPDATE(no_abm_pipe, "abm is set");
 	CHECK_CONDITION(no_vm_aperture, "vm system aperture is valid");
-	CHECK_CONDITION(no_flip_int, "flip interrupt is enabled");
+	CHECK_UPDATE(no_flip_int, "flip interrupt is enabled");
 
 	/* update_dchubp_dpp. */
-	CHECK_CONDITION(no_plane_gamut_remap, "plane gamut remap is set");
-	CHECK_CONDITION(no_stream_gamut_remap, "stream gamut remap is set");
-	CHECK_CONDITION(no_output_csc, "output csc is set");
-	CHECK_CONDITION(no_dcc, "dcc is enabled");
-	CHECK_CONDITION(graphics_address, "address is not graphics");
-	CHECK_CONDITION(no_immediate_flip, "flip is immediate");
+	CHECK_UPDATE(no_plane_gamut_remap, "plane gamut remap is set");
+	CHECK_UPDATE(no_stream_gamut_remap, "stream gamut remap is set");
+	CHECK_UPDATE(no_output_csc, "output csc is set");
+	CHECK_UPDATE(no_dcc, "dcc is enabled");
+	CHECK_UPDATE(graphics_address, "address is not graphics");
+	CHECK_UPDATE(no_immediate_flip, "flip is immediate");
 
 	/* Input, MCM and output transfer functions. */
-	CHECK_CONDITION(no_degamma_curve, "plane degamma is distributed points");
-	CHECK_CONDITION(no_mcm_luts, "an mcm lut is enabled");
-	CHECK_CONDITION(no_shaper_curve, "shaper is distributed points");
-	CHECK_CONDITION(no_stream_3dlut, "stream 3dlut is set");
-	CHECK_CONDITION(no_regamma_curve, "regamma is distributed points");
+	CHECK_UPDATE(no_degamma_curve, "plane degamma is distributed points");
+	CHECK_UPDATE(no_mcm_luts, "an mcm lut is enabled");
+	CHECK_UPDATE(no_shaper_curve, "shaper is distributed points");
+	CHECK_UPDATE(no_stream_3dlut, "stream 3dlut is set");
+	CHECK_UPDATE(no_regamma_curve, "regamma is distributed points");
 
 	/* Not programmed by this update. */
-	CHECK_CONDITION(no_cursor, "cursor is set");
-	CHECK_CONDITION(no_dsc_change, "dsc changes");
+	CHECK_UPDATE(no_cursor, "cursor is set");
+	CHECK_UPDATE(no_dsc_change, "dsc changes");
 	return BLS_BUILD_SUCCESS;
 }
 
@@ -1394,9 +1465,8 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *step)
 {
-	struct block_sequence *entry =
-			&sequence->steps[(*sequence->num_steps)++];
-	union block_sequence_params *p = &entry->params;
+	struct block_sequence *entry;
+	union block_sequence_params *p;
 	struct dc *dc = args->dc;
 	struct dcn_bw_output *bw = &args->new_state->bw_ctx.bw.dcn;
 	struct pipe_ctx *pipe;
@@ -1404,6 +1474,12 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	struct dc_plane_state *plane;
 	const struct dcn401_commit_step_meta *m = &step->meta;
 
+	if (*sequence->num_steps >= DC2_BLS_MAX_STEPS) {
+		(*sequence->num_steps)++;
+		return;
+	}
+	entry = &sequence->steps[(*sequence->num_steps)++];
+	p = &entry->params;
 	memset(entry, 0, sizeof(*entry));
 	entry->func = step->func;
 	/*
@@ -2011,8 +2087,10 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
 		return true;
 	if (step->meta.skip_if.hubp_dpp_already_enabled &&
-			args->current_state->stream_count &&
-			args->current_state->stream_status[0].plane_count)
+			dcn401_stream_index(args->current_state,
+			args->pipe->stream) >= 0 &&
+			args->current_state->stream_status[dcn401_stream_index(
+			args->current_state, args->pipe->stream)].plane_count)
 		return true;
 	if (step->meta.skip_if.scaling_unchanged &&
 			!args->pipe->plane_state->update_bits.scaling_change &&
@@ -2047,6 +2125,8 @@ static void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 	unsigned int i;
 
 	for (i = 0; i < state->stream_count; i++) {
+		if (args.stream && state->streams[i] != args.stream)
+			continue;
 		args.pipe = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[i]);
 		dcn401_add_steps(sequence, &args, steps, count);
@@ -2064,6 +2144,8 @@ static void dcn401_add_per_opp_head(struct block_sequence_state *sequence,
 	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
+		if (args.stream && state->streams[i] != args.stream)
+			continue;
 		n = resource_get_opp_heads_for_stream(state->streams[i],
 				&state->res_ctx, opp_heads);
 		for (j = 0; j < n; j++) {
@@ -2084,6 +2166,8 @@ static void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
 	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
+		if (args.stream && state->streams[i] != args.stream)
+			continue;
 		n = resource_get_dpp_pipes_for_stream(state->streams[i],
 				&state->res_ctx, dpp_pipes);
 		for (j = 0; j < n; j++) {
@@ -2129,6 +2213,7 @@ void dcn401_init_and_unpack_params(
 	state_args->dc = params->dc;
 	state_args->current_state = (struct dc_state *)params->current_state;
 	state_args->new_state = (struct dc_state *)params->new_state;
+	state_args->stream = NULL;
 	state_args->pipe = NULL;
 
 	params->head_num_steps = 0;
@@ -2138,10 +2223,10 @@ void dcn401_init_and_unpack_params(
 }
 
 /*
- * One stream. skip_if drops first-enable steps when the HUBP/DPP is
- * already on, so a kept-plane surface update is the same table. The
- * enable_plane list runs per DPP pipe, top pipe first, so the top MPCC is
- * inserted before the bottom one.
+ * The updated stream only. skip_if drops first-enable steps when the
+ * HUBP/DPP is already on, so a kept-plane surface update is the same
+ * table. The enable_plane list runs per DPP pipe, top pipe first, so the
+ * top MPCC is inserted before the bottom one.
  */
 static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
@@ -2204,11 +2289,13 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	result = dcn401_check_seamless_update_support(params->dc,
-			params->current_state, params->new_state);
+			params->current_state, params->new_state, params->stream);
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
 	dcn401_init_and_unpack_params(params, &state_args, &head);
+	state_args.stream = dcn401_updated_stream(params->new_state,
+			params->stream);
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_update_head);
 
 	return BLS_BUILD_SUCCESS;
@@ -2218,7 +2305,7 @@ static bool dcn401_seamless_update_check_capability(
 		const struct bls_builder_check_capability_params *params)
 {
 	return params && dcn401_check_seamless_update_support(params->dc,
-			params->current_state, params->new_state) ==
+			params->current_state, params->new_state, params->stream) ==
 			BLS_BUILD_SUCCESS;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index d05d74595829..90bcf02ded00 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -55,21 +55,6 @@ void core2_destruct(struct dc *dc)
 	(void)dc;
 }
 
-static struct pipe_ctx *core2_otg_master(struct dc_state *state)
-{
-	unsigned int i;
-
-	if (!state->stream_count)
-		return NULL;
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (state->res_ctx.pipe_ctx[i].stream == state->streams[0] &&
-				!state->res_ctx.pipe_ctx[i].top_pipe &&
-				!state->res_ctx.pipe_ctx[i].prev_odm_pipe)
-			return &state->res_ctx.pipe_ctx[i];
-	}
-	return NULL;
-}
-
 static bool core2_run_commit_sequence(struct dc *dc,
 		const struct bls_builder *builder,
 		const struct workaround_manager *wam,
@@ -177,7 +162,8 @@ static void core2_commit_disable_done(struct dc *dc, struct pipe_ctx *pipe)
 
 /* Builds and runs one declarative builder from dc->current_state to new_state. */
 static enum dc_status core2_build_and_run(struct dc *dc,
-		enum bls_builder_name name, struct dc_state *new_state)
+		enum bls_builder_name name, struct dc_state *new_state,
+		const struct dc_stream_state *stream)
 {
 	const struct bls_builder *builder = TO_DC2(dc)->builders[name];
 	const struct workaround_manager *wam = dc2_workaround_manager_get();
@@ -191,6 +177,7 @@ static enum dc_status core2_build_and_run(struct dc *dc,
 	params->dc = dc;
 	params->current_state = dc->current_state;
 	params->new_state = new_state;
+	params->stream = stream;
 
 	/*
 	 * A tail runs on the vsync after the head, so Core would have to wait
@@ -213,13 +200,14 @@ static enum dc_status core2_build_and_run(struct dc *dc,
 }
 
 static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
-		struct dc_state *new_state)
+		struct dc_state *new_state, const struct dc_stream_state *stream)
 {
 	const struct bls_builder *builder = TO_DC2(dc)->builders[name];
 	struct bls_builder_check_capability_params check = {
 		.dc = dc,
 		.current_state = dc->current_state,
 		.new_state = new_state,
+		.stream = stream,
 	};
 
 	return builder && builder->check_capability &&
@@ -233,33 +221,36 @@ static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
 /* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
 enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 {
-	struct pipe_ctx *old_pipe;
-	struct pipe_ctx *new_pipe;
+	struct dc_state *current_state = dc->current_state;
 	enum dc_status status;
+	int i;
 
-	if (!core2_builder_supports(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context))
+	if (!core2_builder_supports(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context,
+			NULL))
 		return DC_NOT_SUPPORTED;
 
-	old_pipe = core2_otg_master(dc->current_state);
-	new_pipe = core2_otg_master(context);
-
 	/*
 	 * link_set_dpms_on builds the info frame into the
 	 * pipe before it programs the packets. Remove when the builder
 	 * computes it.
 	 */
-	if (new_pipe)
-		resource_build_info_frame(new_pipe);
+	for (i = 0; i < context->stream_count; i++)
+		resource_build_info_frame(resource_get_otg_master_for_stream(
+				&context->res_ctx, context->streams[i]));
 
-	status = core2_build_and_run(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context);
+	status = core2_build_and_run(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context,
+			NULL);
 	if (status != DC_OK)
 		return status;
 
 	core2_commit_prepare_done(dc, context);
-	if (old_pipe)
-		core2_commit_disable_done(dc, old_pipe);
-	if (new_pipe)
-		core2_commit_enable_done(new_pipe);
+	for (i = 0; i < current_state->stream_count; i++)
+		core2_commit_disable_done(dc, resource_get_otg_master_for_stream(
+				&current_state->res_ctx,
+				current_state->streams[i]));
+	for (i = 0; i < context->stream_count; i++)
+		core2_commit_enable_done(resource_get_otg_master_for_stream(
+				&context->res_ctx, context->streams[i]));
 	return DC_OK;
 }
 
@@ -309,7 +300,7 @@ static bool core2_update_state_supported(
 	if (!core2_stream_update_supported(scratch->stream_update))
 		return false;
 	return core2_builder_supports(scratch->dc, DCN_DECL_SEAMLESS_UPDATE,
-			scratch->new_context);
+			scratch->new_context, scratch->stream);
 }
 
 /*
@@ -317,14 +308,15 @@ static bool core2_update_state_supported(
  * the plane. The swap to the new context stays in
  * dc_update_state_cleanup.
  */
-static void core2_update_done(struct dc *dc, struct dc_state *context)
+static void core2_update_done(struct dc *dc, struct dc_state *context,
+		struct dc_stream_state *stream)
 {
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 	struct pipe_ctx *pipe;
 	struct dc_plane_state *plane;
 	struct hubp *hubp;
-	int i, n = context->stream_count ? resource_get_dpp_pipes_for_stream(
-			context->streams[0], &context->res_ctx, dpp_pipes) : 0;
+	int i, n = resource_get_dpp_pipes_for_stream(stream, &context->res_ctx,
+			dpp_pipes);
 
 	for (i = 0; i < n; i++) {
 		pipe = dpp_pipes[i];
@@ -349,7 +341,8 @@ static void core2_update_state_execute(
 {
 	struct dc *dc = scratch->dc;
 	struct dc_state *context = scratch->new_context;
-	struct pipe_ctx *pipe = core2_otg_master(context);
+	struct pipe_ctx *pipe = resource_get_otg_master_for_stream(
+			&context->res_ctx, scratch->stream);
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 	int i, n;
 
@@ -361,15 +354,16 @@ static void core2_update_state_execute(
 		return;
 	if (dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
-	n = resource_get_dpp_pipes_for_stream(pipe->stream, &context->res_ctx,
+	n = resource_get_dpp_pipes_for_stream(scratch->stream, &context->res_ctx,
 			dpp_pipes);
 	for (i = 0; i < n; i++)
 		dpp_pipes[i]->plane_res.scl_data.lb_params.alpha_en =
 				dpp_pipes[i]->plane_state->per_pixel_alpha;
 
-	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context) != DC_OK) {
+	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context,
+			scratch->stream) != DC_OK) {
 		ASSERT(false);
 		return;
 	}
-	core2_update_done(dc, context);
+	core2_update_done(dc, context, scratch->stream);
 }
-- 
2.43.0

