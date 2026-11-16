Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0A606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K4fdY6i0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD3610F845;
	Tue, 17 Nov 2026 17:17:33 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D25610F845
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSQmAft5pmX8lp6K7L6qEvq9WP7IhrS9dJi/477S8fGpMQ3dS4om/4w+4wx4dPdDFhjBYiXZX2JMWhcE8gV6aM9Kwh8+J7ZQKCPMbeUmZQA3lrHfisPNCjdd9X7uw3g+3KXM7meQOGcqaghKYGKN4Hbb7A3+15Ud12KQdZ47b2a+p+WZ4jyd5PyjYc5hz06TXJh6zr/nDNZV20/PzJrbDbqsiVTUd6k5izF9OvOxOgr9nxx6XoW7hymljnQh0YemO5qnxZbKNySgq7Wxs43vIguBO9gVkGkSC8ChgKKlTNiEVCslFutE1awFhJlicQvMvYTba9ruyy2n7X3/ukKYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkxU2NdT1SToGts8lDNhpY8JijkOOJMgetsMdf05RyY=;
 b=gJi1eRhhPtCCmw6t6JR8MyoalaOdFSLOfqPyUrnsHtYZGxnm2TywY4lmGoYDoVA4MVJIQqTZtUR7jCK/QQZm1euk7fphORyF9U6A2G3HfyQC85i6RmDuz2WG61h+D+P/x8rwgYTtW+ySvamZI9uz+NwhrUqj9z8DOx/A2ceoWWK1qGk9cmpEONkrWO+EHMiP2pVIdRxDK8KFr+/TFgPm+C8DgrSLjysgh7aS0eoRW9Fsrc5dkunTXViMqGly1ztuMb2y/o2zwW/p1bgvsQ9PkOgjxOxAT6E8/6KIPOsWuvOkm0PU5itXa4VEyswM9ij4JcQRT86843AEeX85jwRPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkxU2NdT1SToGts8lDNhpY8JijkOOJMgetsMdf05RyY=;
 b=K4fdY6i0gCkY9hDJgd5U/jGrBX5Kmyav/KAzDFiy/3UVLnhIZlX/F7bY6hIGC7oMi3hTSydU7a+FTHhUX7pGGjTFzA6ybnDzQ/FLIM0//YBAO2w0CTG5abVMJ/n8GH18ZahyGaQSirrpzqNJ4cg3WiyLnQjDnRSqHKdOEU3C/gk=
Received: from CH0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:610:e5::33)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8eb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Tue, 17 Nov
 2026 17:17:20 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::51) by CH0PR03CA0268.outlook.office365.com
 (2603:10b6:610:e5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:17:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:17:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:07 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:59 -0600
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
Subject: [PATCH 29/33] drm/amd/display: Give the DC2 builders State pipe facts
Date: Tue, 17 Nov 2026 05:51:06 +0800
Message-ID: <20261116215641.2800595-30-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a7c9b1-5b97-4f75-0a9e-08df44cea2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261009221227099003|261009223027099003|20052099010|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Btu0QemW6V4Vtumm6AsczDk1ggf1oBmsrrMBaII8jYljVWdNVF6vey1TXOVEacIjX1o6UbtWOt1d+Hi2sTgnLKChrFSCS/WFz0cuaqEMnCths7iAM2d9jU7ZzKYyFkhaArz2pj0HO6YDupXO8RNzqWjSzhYCGhVhDNzIxTiy7oWMMmlQeXXcf9ue4mrkLq555VEuKu07EiLILlWxBIKfj5ufgyLFVATIxmwuZuWo++smsGimKChWfN09mihNsKMi4YYenL2t+hKWD8UbFpizNmyahxWbijkx8+7wV/w+ylzsaHLjF6QZmd3UfoR6BJee9D6riS8ReTwtOWjglCgKJVrZgX0Cib77KYzTSW3qzERi51Vg80Prm1+4d8TegSW7Oyl05Zi0ENXP+0J9dZOAqJUem8Pa80Stn/OiQ4KBqFVateHK3Qu01g4epTinkgyaws3R7yUP5+P/i7TjddIhzKbySDj4+mLfg57HVqJnRmUJXgzTPz2F1Q0rp5+LQIbRmteTI2djLpUMwS9Uw6Suq4CuQmgGm4thoZ1IIHgJvCCPmCoGp3egdhvaW7nfWKWdzv2TOP8Ck1VKVo1tQp5kdSNfZVVOOzmwmdYw9PKZZyDxncyworn+OaLyJNbdNYRTGVCRReUA3h7IzVFN6rrexDoYS4NmTQ3IiWB35ohvRYGs4Y1T8cJF4hZfaw3Ugy4kRtFDnOHot2ojl9/8ddgLLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009221227099003)(261009223027099003)(20052099010)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pq/7pXAaJL1tjPa1x4Uh2kFGWgcShVPsmSR+riHIcfEea3iA2QM/MtPcZ5jvhOMPOGe8abNYjhyiyN/r3QGW6U6JzRI7UoSnlbKTqboM/XvJo2Tw2GAWvHcUVfQ8gVtpdwz5bwe6bV62Fxo1C8KGT7uaiGg5J7BfaKTo/3naeWcNlb4H2fGWwZ1TtOX2FlYKXXX1sl1MsMZL57WKrK4HEUlqqAuPafp8/8p2mJZu8FLihQYPkpAo7ihdvHUoycPtXK6FpOYsm/IgTmOf9FuluPvKVAISxuDxCOJddi6wgT35yB1OrqLdlaZWIj/NlCAwUQhnpqHKSvYxDz5g0xb9DHq4Qo1XJ1+419WpCS7qEdyn8K+j1sKJvgRTas5Q4Ji83yMepBHeNGUMP/E72TrMHHRcRYWyr9PjrBxqTK3OyRtwL0sZWDLqEQUkRo0kGQiK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:17:19.4302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a7c9b1-5b97-4f75-0a9e-08df44cea2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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
The dcn401 DC2 builders compare streams and pipe blocks by pointer,
which is not a reliable identity between two states.

[How]
Add dc_state_compute_update_flags(). It records the facts of each pipe
in the current and the new state. The builder finds a kept stream by
stream_id and its pipe blocks by inst, and derives the deltas. The
stream update steps skip when the kept stream did not change. Name
the unfiltered trait match DC_TRAIT_MATCH_ANY.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   5 +
 .../bls_builder/bls_builder_private_types.h   |  40 +-
 .../dc/bls_builder/dcn401_builder_internal.h  |  14 +-
 .../bls_builder/dcn401_non_seamless_builder.c |  26 +-
 .../dc/bls_builder/dcn401_seamless_builder.c  | 497 ++++++++++++------
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  28 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  23 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |  23 +
 .../amd/display/dc/state_facts/state_facts.h  |   3 +
 9 files changed, 474 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index c9a4e59056ae..99d57e7c0789 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -6,6 +6,7 @@
 #pragma once
 
 #include "dc.h"
+#include "dc_state_priv.h"
 #include "dmub_cmd.h"
 #include "dmub/dmub_srv.h"
 #include "hwss/hw_sequencer.h"
@@ -99,6 +100,8 @@ struct bls_builder_check_capability_params {
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
 	const struct dc_stream_state *stream;
+	/* The current -> new delta from dc_state_compute_update_flags. */
+	const struct dc_state_update_flags *update_flags;
 };
 
 struct bls_builder_declarative_params {
@@ -106,6 +109,8 @@ struct bls_builder_declarative_params {
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
 	const struct dc_stream_state *stream;
+	/* Pipe facts of both states, from dc_state_compute_update_flags. */
+	const struct dc_state_update_flags *update_flags;
 	struct bls_builder_output_targets *out_targets;
 	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
 	unsigned int head_num_steps;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index de73efe274c1..11e452b36e05 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -7,12 +7,31 @@
 
 #include "hw_sequencer.h"
 #include "dccg.h"
+#include "dc_state_priv.h"
 
 /*
  * Step tables for the declarative builders. A change here changes what
  * a builder can express; a change to a builder's .c alone does not.
  */
 
+/*
+ * Conditions on pipe i that compare its facts in the current and the
+ * new state.
+ */
+struct dcn401_pipe_deltas {
+	/*
+	 * Both pipes are enabled and show a plane of the same stream on the
+	 * same HUBP, DPP and OPP.
+	 */
+	bool hubp_dpp_already_enabled;
+	/* The DET size is the same. */
+	bool det_unchanged;
+	/* The current pipe has no plane. */
+	bool current_has_no_plane;
+	/* The stream of the new pipe has the same OPP heads in both states. */
+	bool odm_kept;
+};
+
 /*
  * One dcn401 commit step is one BLS entry. The union holds the
  * arguments that differ between the times DC1 makes that call; the
@@ -109,29 +128,20 @@ struct dcn401_commit_step_meta {
 	struct {
 		/* The new state has a stream. */
 		bool new_state_has_stream;
+		/* The stream of the step is unchanged between the states. */
+		bool stream_unchanged;
 		/* dc->optimized_required is clear. */
 		bool optimized_not_required;
 		/* The plane has no address update, or skips the manual trigger. */
 		bool no_manual_trigger;
 		/* The OPP MPC tree has no plane yet. */
 		bool opp_tree_empty;
+		struct dcn401_pipe_deltas pipe_deltas;
 		/*
-		 * The pipe already showed the plane on this HUBP. The step is
-		 * part of enabling that block the first time, not of
-		 * reconfiguring it.
-		 */
-		bool hubp_dpp_already_enabled;
-		/* As hubp_dpp_already_enabled, and the DET size is the same. */
-		bool det_unchanged;
-		/*
-		 * The current pipe had no plane, or keeps its plane, HUBP, DPP
-		 * and OPP in the new state.
+		 * Skip only when each delta named in pipe_deltas is true. Clear,
+		 * skip when any of them is true.
 		 */
-		bool no_plane_removed;
-		/* As hubp_dpp_already_enabled, and each ODM slice keeps its OPP. */
-		bool odm_kept;
-		/* Each ODM slice of the stream keeps its OPP. */
-		bool same_opp_heads;
+		bool pipe_deltas_all;
 		/*
 		 * Neither the plane scaling, the plane position nor the
 		 * stream scaling changed. A full update sets every plane bit,
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index e9f190176485..4af30178b42b 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -44,6 +44,15 @@ void dcn401_commit_check_failed(const struct dc *dc, const char *msg);
 		} \
 	} while (0)
 
+/* As CHECK_UPDATE, for a helper that reads the update flags. */
+#define CHECK_UPDATE_FLAGS(name, msg) \
+	do { \
+		if (!check_##name(update_flags, current_state, new_state, i)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
+		} \
+	} while (0)
+
 /* Each check_<name> stream helper takes the state and a stream index. */
 #define CHECK_STREAM_CONDITION(name, msg) \
 	do { \
@@ -87,8 +96,6 @@ bool dcn401_stream_unchanged(const struct dc_state *current_state,
  * The pipe shows a plane on the same HUBP, DPP and OPP. The plane may be a
  * new dc_plane_state; the update reprograms its contents.
  */
-bool dcn401_pipe_kept(const struct pipe_ctx *current_pipe,
-		const struct pipe_ctx *new_pipe);
 /*
  * What the seamless update needs of stream i of new_state, apart from the
  * other streams.
@@ -115,6 +122,9 @@ struct dcn401_commit_step_args {
 	struct dc_state *new_state;
 	const struct dc_stream_state *stream;
 	struct pipe_ctx *pipe;
+	const struct dc_state_update_flags *update_flags;
+	/* stream is in both states on the same pipes, planes and blocks. */
+	bool stream_unchanged;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index f24480e949d6..2ce37c3aa982 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -45,7 +45,7 @@ static bool check_current_planes(const struct dc *dc,
 	return planes && planes ==
 			facts.global.blend_tree[i].dpp_pipe_count &&
 			dc_state_facts_all_pipe(&facts, (uint8_t)i,
-			DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
 }
 
@@ -57,7 +57,7 @@ static bool check_plane_blocks(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(state, &facts);
 	return dc_state_facts_all_pipe(&facts, (uint8_t)i,
-			DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
 
@@ -168,11 +168,12 @@ static bool check_link_not_active(const struct dc *dc,
 
 static enum bls_builder_result dcn401_check_non_seamless_commit_support(
 		const struct dc *dc, const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state,
+		const struct dc_state_update_flags *update_flags)
 {
 	enum bls_builder_result result;
 
-	if (!dc || !current_state || !new_state)
+	if (!dc || !current_state || !new_state || !update_flags)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
 	result = dcn401_check_dc_support(dc);
@@ -457,7 +458,8 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	result = dcn401_check_non_seamless_commit_support(params->dc,
-			params->current_state, params->new_state);
+			params->current_state, params->new_state,
+			params->update_flags);
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
@@ -465,13 +467,16 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_head);
 	for (i = 0; i < state_args.new_state->stream_count; i++) {
 		state_args.stream = state_args.new_state->streams[i];
-		if (dcn401_stream_kept(params->dc, params->current_state,
-				params->new_state, state_args.stream) &&
-				!dcn401_stream_unchanged(params->current_state,
+		if (!dcn401_stream_kept(params->dc, params->current_state,
 				params->new_state, state_args.stream))
-			dcn401_add_stream_update(&head, &state_args);
+			continue;
+		state_args.stream_unchanged = dcn401_stream_unchanged(
+				params->current_state, params->new_state,
+				state_args.stream);
+		dcn401_add_stream_update(&head, &state_args);
 	}
 	state_args.stream = NULL;
+	state_args.stream_unchanged = false;
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_postamble);
 
 	return BLS_BUILD_SUCCESS;
@@ -481,7 +486,8 @@ static bool dcn401_non_seamless_commit_check_capability(
 		const struct bls_builder_check_capability_params *params)
 {
 	return params && dcn401_check_non_seamless_commit_support(params->dc,
-			params->current_state, params->new_state) ==
+			params->current_state, params->new_state,
+			params->update_flags) ==
 			BLS_BUILD_SUCCESS;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 5218ecfbc385..a2c8d7964208 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -252,7 +252,8 @@ const struct pipe_ctx *dcn401_otg_master(const struct dc_state *state,
 	for (i = 0; i < MAX_PIPES; i++) {
 		const struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
 
-		if (!stream || pipe->stream != stream ||
+		if (!stream || !pipe->stream ||
+				pipe->stream->stream_id != stream->stream_id ||
 				pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (otg_master)
@@ -267,12 +268,38 @@ int dcn401_stream_index(const struct dc_state *state,
 {
 	int i;
 
+	if (!stream)
+		return -1;
 	for (i = 0; i < state->stream_count; i++)
-		if (state->streams[i] == stream)
+		if (state->streams[i]->stream_id == stream->stream_id)
 			return i;
 	return -1;
 }
 
+#define DCN401_SAME_INST(a, b) \
+	((!(a) && !(b)) || ((a) && (b) && (a)->inst == (b)->inst))
+
+static bool dcn401_pipe_on_stream(const struct pipe_ctx *pipe,
+		const struct dc_stream_state *stream)
+{
+	return pipe->stream && pipe->stream->stream_id == stream->stream_id;
+}
+
+/* The plane is compared as an object: planes have no DC-assigned id yet. */
+static bool dcn401_pipe_layout_unchanged(const struct pipe_ctx *cur,
+		const struct pipe_ctx *new)
+{
+	return cur->plane_state == new->plane_state &&
+			DCN401_SAME_INST(cur->plane_res.hubp, new->plane_res.hubp) &&
+			DCN401_SAME_INST(cur->plane_res.dpp, new->plane_res.dpp) &&
+			DCN401_SAME_INST(cur->stream_res.tg, new->stream_res.tg) &&
+			DCN401_SAME_INST(cur->stream_res.opp, new->stream_res.opp) &&
+			!cur->top_pipe == !new->top_pipe &&
+			!cur->bottom_pipe == !new->bottom_pipe &&
+			!cur->prev_odm_pipe == !new->prev_odm_pipe &&
+			!cur->next_odm_pipe == !new->next_odm_pipe;
+}
+
 bool dcn401_stream_unchanged(const struct dc_state *current_state,
 		const struct dc_state *new_state,
 		const struct dc_stream_state *stream)
@@ -286,19 +313,11 @@ bool dcn401_stream_unchanged(const struct dc_state *current_state,
 	for (i = 0; i < MAX_PIPES; i++) {
 		cur = &current_state->res_ctx.pipe_ctx[i];
 		new = &new_state->res_ctx.pipe_ctx[i];
-		if ((cur->stream == stream) != (new->stream == stream))
+		if (dcn401_pipe_on_stream(cur, stream) !=
+				dcn401_pipe_on_stream(new, stream))
 			return false;
-		if (new->stream != stream)
-			continue;
-		if (cur->plane_state != new->plane_state ||
-				cur->plane_res.hubp != new->plane_res.hubp ||
-				cur->plane_res.dpp != new->plane_res.dpp ||
-				cur->stream_res.tg != new->stream_res.tg ||
-				cur->stream_res.opp != new->stream_res.opp ||
-				!cur->top_pipe != !new->top_pipe ||
-				!cur->bottom_pipe != !new->bottom_pipe ||
-				!cur->prev_odm_pipe != !new->prev_odm_pipe ||
-				!cur->next_odm_pipe != !new->next_odm_pipe)
+		if (dcn401_pipe_on_stream(new, stream) &&
+				!dcn401_pipe_layout_unchanged(cur, new))
 			return false;
 	}
 	return true;
@@ -483,33 +502,51 @@ enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
  * The update keeps every stream. A stream other than the updated one keeps
  * its pipes, planes and blocks.
  */
-static bool check_streams_kept(const struct dc *dc,
+static bool check_streams_kept(
+		const struct dc_state_update_flags *update_flags,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state, unsigned int i)
 {
 	int j;
 
-	(void)dc;
+	(void)update_flags;
 	if (current_state->stream_count != new_state->stream_count)
 		return false;
 	for (j = 0; j < new_state->stream_count; j++)
 		if (dcn401_stream_index(current_state,
 				new_state->streams[j]) < 0 ||
-				(j != i && !dcn401_stream_unchanged(current_state,
+				(j != (int)i && !dcn401_stream_unchanged(current_state,
 				new_state, new_state->streams[j])))
 			return false;
 	return true;
 }
 
-bool dcn401_pipe_kept(const struct pipe_ctx *current_pipe,
-		const struct pipe_ctx *new_pipe)
+static bool pipe_has_plane(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state != NULL;
+}
+
+static bool pipe_assigned_to_stream(const struct pipe_ctx *pipe,
+		const struct dc_stream_state *stream)
+{
+	return pipe->stream && stream &&
+			pipe->stream->stream_id == stream->stream_id;
+}
+
+static bool pipe_plane_resources_identical(const struct pipe_ctx *cur,
+		const struct pipe_ctx *new)
+{
+	return cur->plane_res.hubp && new->plane_res.hubp &&
+			cur->plane_res.dpp && new->plane_res.dpp &&
+			cur->plane_res.hubp->inst == new->plane_res.hubp->inst &&
+			cur->plane_res.dpp->inst == new->plane_res.dpp->inst;
+}
+
+static bool pipe_opp_identical(const struct pipe_ctx *cur,
+		const struct pipe_ctx *new)
 {
-	return current_pipe->plane_state &&
-			current_pipe->stream == new_pipe->stream &&
-			new_pipe->plane_state &&
-			current_pipe->plane_res.hubp == new_pipe->plane_res.hubp &&
-			current_pipe->plane_res.dpp == new_pipe->plane_res.dpp &&
-			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
+	return cur->stream_res.opp && new->stream_res.opp &&
+			cur->stream_res.opp->inst == new->stream_res.opp->inst;
 }
 
 /*
@@ -534,9 +571,10 @@ static bool check_pipes_kept_or_free(const struct dc *dc,
 		new = &new_state->res_ctx.pipe_ctx[j];
 		if (new->stream != new_state->streams[i] || !cur->stream)
 			continue;
-		if (cur->stream != new->stream ||
-				cur->stream_res.opp != new->stream_res.opp ||
-				(cur->plane_state && !dcn401_pipe_kept(cur, new)))
+		if (!pipe_assigned_to_stream(new, cur->stream) ||
+				!pipe_opp_identical(cur, new) ||
+				(pipe_has_plane(cur) && (!pipe_has_plane(new) ||
+				!pipe_plane_resources_identical(cur, new))))
 			return false;
 	}
 	dc_state_facts_derive(new_state, &facts);
@@ -553,21 +591,8 @@ static bool check_same_otg(const struct dc *dc,
 			new_state->streams[i]);
 
 	(void)dc;
-	return cur && new && cur->stream_res.tg == new->stream_res.tg;
-}
-
-/* stream has the same OPP for each ODM slice in both states. */
-static bool dcn401_same_opp_heads(const struct dc_state *current_state,
-		const struct dc_state *new_state,
-		const struct dc_stream_state *stream)
-{
-	const struct pipe_ctx *cur = dcn401_otg_master(current_state, stream);
-	const struct pipe_ctx *new = dcn401_otg_master(new_state, stream);
-
-	for (; cur && new; cur = cur->next_odm_pipe, new = new->next_odm_pipe)
-		if (cur->stream_res.opp != new->stream_res.opp)
-			return false;
-	return !cur && !new;
+	return cur && new && cur->stream_res.tg && new->stream_res.tg &&
+			cur->stream_res.tg->inst == new->stream_res.tg->inst;
 }
 
 static bool check_new_plane_blocks(const struct dc *dc,
@@ -581,7 +606,7 @@ static bool check_new_plane_blocks(const struct dc *dc,
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
 			dc_state_facts_all_pipe(&facts, (uint8_t)i,
-			DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE |
 			DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
@@ -757,7 +782,7 @@ static bool check_no_dcc(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
 			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DCC, 0));
@@ -774,9 +799,9 @@ static bool check_graphics_address(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
-			dc_state_facts_all_plane(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_plane(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_GRAPHICS_ADDRESS, 0));
 }
 
@@ -791,7 +816,7 @@ static bool check_no_immediate_flip(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
 			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_FLIP_IMMEDIATE, 0));
@@ -811,7 +836,7 @@ static bool check_no_degamma_curve(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
 			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DEGAMMA_CURVE, 0));
@@ -829,7 +854,7 @@ static bool check_no_mcm_luts(const struct dc *dc,
 	(void)dc;
 	dc_state_facts_derive(new_state, &facts);
 	return facts.pipe.count &&
-			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH(0, 0),
+			dc_state_facts_all_pipe(&facts, (uint8_t)i, DC_TRAIT_MATCH_ANY,
 			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
 			!dc_state_facts_any_plane(&facts, (uint8_t)i,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_MCM_LUTS, 0));
@@ -918,12 +943,13 @@ static const struct dc_stream_state *dcn401_updated_stream(
 static enum bls_builder_result dcn401_check_seamless_update_support(
 		const struct dc *dc, const struct dc_state *current_state,
 		const struct dc_state *new_state,
+		const struct dc_state_update_flags *update_flags,
 		const struct dc_stream_state *stream)
 {
 	enum bls_builder_result result;
 	int i;
 
-	if (!dc || !current_state || !new_state)
+	if (!dc || !current_state || !new_state || !update_flags)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	i = dcn401_stream_index(new_state,
 			dcn401_updated_stream(new_state, stream));
@@ -941,7 +967,7 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	CHECK_UPDATE(streams_kept,
+	CHECK_UPDATE_FLAGS(streams_kept,
 			"a stream is not kept, or another stream changes");
 	return dcn401_check_stream_update(dc, current_state, new_state, i);
 }
@@ -1048,9 +1074,12 @@ static const struct dcn401_commit_step global_preamble[] = {
  * which a full update runs before it takes the pipe lock.
  */
 static const struct dcn401_commit_step pending[] = {
-	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES },
-	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
-	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE,
+	  .meta.skip_if.stream_unchanged = true },
 };
 
 /*
@@ -1063,18 +1092,23 @@ static const struct dcn401_commit_step pending[] = {
  * the first HUBP.
  */
 static const struct dcn401_commit_step lock[] = {
-	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = TG_LOCK,
+	  .meta.skip_if.stream_unchanged = true, .meta.tg_lock.lock = true },
 };
 
 static const struct dcn401_commit_step dpp_lock[] = {
-	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
-	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
+	{ .func = HUBP_PROGRAM_TRIPLEBUFFER,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = HUBP_PROGRAM_TRIPLEBUFFER,
+	  .meta.skip_if.stream_unchanged = true },
 };
 
 static const struct dcn401_commit_step first_hubp[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.hubbub_force_pstate_change_control.enable = true },
-	{ .func = DC_UDELAY },
+	{ .func = DC_UDELAY,
+	  .meta.skip_if.stream_unchanged = true },
 };
 
 /*
@@ -1083,28 +1117,42 @@ static const struct dcn401_commit_step first_hubp[] = {
  */
 static const struct dcn401_commit_step opp_unblank[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.opp_set_disp_pattern_generator.unblank = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 static const struct dcn401_commit_step global_sync[] = {
 	{ .func = TG_PROGRAM_GLOBAL_SYNC,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_WAIT_FOR_STATE,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_SET_VTG_PARAMS,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_SETUP_VERTICAL_INTERRUPT2,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPTC_SET_ODM_COMBINE,
-	  .meta.skip_if.odm_kept = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.pipe_deltas.odm_kept = true,
+	  .meta.skip_if.pipe_deltas_all = true },
 };
 
 static const struct dcn401_commit_step opp_odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
-	  .meta.skip_if.odm_kept = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.pipe_deltas.odm_kept = true,
+	  .meta.skip_if.pipe_deltas_all = true },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
-	  .meta.skip_if.odm_kept = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.pipe_deltas.odm_kept = true,
+	  .meta.skip_if.pipe_deltas_all = true },
 };
 
 /*
@@ -1112,130 +1160,204 @@ static const struct dcn401_commit_step opp_odm[] = {
  * MPCC and returns its DET segments, as DC1 disconnects a disabled pipe.
  */
 const struct dcn401_commit_step dcn401_disconnect[DCN401_DISCONNECT_STEPS] = {
-	{ .func = HUBP_PROGRAM_DET_SEGMENTS, .meta.skip_if.no_plane_removed = true },
-	{ .func = MPC_REMOVE_MPCC, .meta.skip_if.no_plane_removed = true },
+	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = MPC_REMOVE_MPCC,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 /* After the unlock, disable_plane on each removed pipe. */
 const struct dcn401_commit_step dcn401_power_down[DCN401_POWER_DOWN_STEPS] = {
-	{ .func = MPC_ASSERT_IDLE_MPCC, .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_SET_BLANK, .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_UPDATE_MALL_SEL, .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_SET_FLIP_CONTROL_GSL, .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_CLK_CNTL, .meta.skip_if.no_plane_removed = true },
-	{ .func = DPP_DPPCLK_CONTROL, .meta.skip_if.no_plane_removed = true },
-	{ .func = DC_IP_REQUEST_STATUS, .meta.skip_if.no_ip_request = true,
-	  .meta.skip_if.no_plane_removed = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
+	{ .func = MPC_ASSERT_IDLE_MPCC,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SET_BLANK,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_UPDATE_MALL_SEL,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SET_FLIP_CONTROL_GSL,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_CLK_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DPP_DPPCLK_CONTROL,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DC_IP_REQUEST_STATUS,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.no_ip_request = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DC_IP_REQUEST_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = true,
 	  .meta.skip_if.no_ip_request = true,
-	  .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_PG_CONTROL, .meta.skip_if.no_plane_removed = true },
-	{ .func = HUBP_RESET, .meta.skip_if.no_plane_removed = true },
-	{ .func = DPP_RESET, .meta.skip_if.no_plane_removed = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_PG_CONTROL,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_RESET,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DPP_RESET,
+	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DC_IP_REQUEST_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = false,
 	  .meta.skip_if.no_ip_request = true,
-	  .meta.skip_if.no_plane_removed = true },
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 /* enable_plane, then the watermark propagate and the DET segments. */
 static const struct dcn401_commit_step enable_plane[] = {
 	{ .func = DC_IP_REQUEST_STATUS,
-	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	{ .func = DC_IP_REQUEST_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
-	{ .func = HUBP_PG_CONTROL, .meta.hubp_pg_control.power_on = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
-	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	{ .func = HUBP_PG_CONTROL,
+	  .meta.skip_if.stream_unchanged = true, .meta.hubp_pg_control.power_on = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DC_IP_REQUEST_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
-	{ .func = HUBP_CLK_CNTL, .meta.hubp_clk_cntl.enable = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_CLK_CNTL,
+	  .meta.skip_if.stream_unchanged = true, .meta.hubp_clk_cntl.enable = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_INIT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.hubp_program_det_segments.allocate = true,
-	  .meta.skip_if.det_unchanged = true },
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.pipe_deltas.det_unchanged = true,
+	  .meta.skip_if.pipe_deltas_all = true },
 	/*
 	 * update_dchubp_dpp. First enable runs the whole table. A reconfigure
 	 * skips the steps that only bring the HUBP/DPP up, and programs the
 	 * scaler and viewport only when scaling or position changed. The MPCC is
 	 * removed when the OPP tree already holds one.
 	 */
-	{ .func = DPP_DPPCLK_CONTROL, .meta.dpp_dppclk_control.enable = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = DPP_DPPCLK_CONTROL,
+	  .meta.skip_if.stream_unchanged = true, .meta.dpp_dppclk_control.enable = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DCCG_UPDATE_DPP_DTO,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_VTG_SEL,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SETUP2,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_UNBOUNDED_REQUESTING,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SETUP_INTERDEPENDENT2,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
-	{ .func = DPP_SETUP_DPP },
-	{ .func = DPP_SET_CURSOR_MATRIX },
-	{ .func = DPP_PROGRAM_BIAS_AND_SCALE },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+	{ .func = DPP_SETUP_DPP,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = DPP_SET_CURSOR_MATRIX,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = DPP_PROGRAM_BIAS_AND_SCALE,
+	  .meta.skip_if.stream_unchanged = true },
 	{ .func = MPC_REMOVE_MPCC,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.skip_if.opp_tree_empty = true },
 	/* insert_plane programs the blending; no update_blending follows. */
-	{ .func = MPC_INSERT_PLANE },
-	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
+	{ .func = MPC_INSERT_PLANE,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = MPC_UPDATE_VISUAL_CONFIRM,
+	  .meta.skip_if.stream_unchanged = true },
 	{ .func = DPP_SET_SCALER,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.skip_if.scaling_unchanged = true },
 	{ .func = HUBP_MEM_PROGRAM_VIEWPORT,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.skip_if.scaling_unchanged = true },
-	{ .func = HUBP_PROGRAM_MCACHE_ID },
+	{ .func = HUBP_PROGRAM_MCACHE_ID,
+	  .meta.skip_if.stream_unchanged = true },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
 			MPCC_MCM_FIRST_GAMUT_REMAP },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
 			MPCC_MCM_SECOND_GAMUT_REMAP },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id = MPCC_OGAM_GAMUT_REMAP },
-	{ .func = MPC_POWER_ON_MPC_MEM_PWR },
-	{ .func = MPC_SET_OCSC_DEFAULT },
-	{ .func = HUBP_PROGRAM_SURFACE_CONFIG },
-	{ .func = HUBP_UPDATE_PLANE_ADDR },
-	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = MPC_POWER_ON_MPC_MEM_PWR,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = MPC_SET_OCSC_DEFAULT,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = HUBP_PROGRAM_SURFACE_CONFIG,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = HUBP_UPDATE_PLANE_ADDR,
+	  .meta.skip_if.stream_unchanged = true },
+	{ .func = HUBP_SET_BLANK,
+	  .meta.skip_if.stream_unchanged = true, .meta.hubp_set_blank.unblank = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	/* set_hdr_multiplier, the input and MCM transfer functions, the
 	 * output transfer function and the OPP format. First enable only.
 	 */
 	{ .func = DPP_SET_HDR_MULTIPLIER,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_SET_PRE_DEGAM,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_PROGRAM_GAMCOR_LUT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_SET_MOVABLE_CM_LOCATION,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_1DLUT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_SHAPER,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_3DLUT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_3DLUT_FL_CONFIG,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_3DLUT_FL,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_SET_OUTPUT_GAMMA,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_SET_DYN_EXPANSION,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_PROGRAM_FMT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 /*
@@ -1244,30 +1366,36 @@ static const struct dcn401_commit_step enable_plane[] = {
  * the manual trigger.
  */
 static const struct dcn401_commit_step unlock[] = {
-	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+	{ .func = TG_LOCK,
+	  .meta.skip_if.stream_unchanged = true, .meta.tg_lock.lock = false },
 };
 
 static const struct dcn401_commit_step dpp_flip[] = {
-	{ .func = HUBP_WAIT_FLIP_PENDING },
+	{ .func = HUBP_WAIT_FLIP_PENDING,
+	  .meta.skip_if.stream_unchanged = true },
 };
 
 static const struct dcn401_commit_step pstate[] = {
-	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	  .meta.skip_if.stream_unchanged = true },
 };
 
 static const struct dcn401_commit_step dpp_mall[] = {
 	{ .func = HUBP_UPDATE_MALL_SEL,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.hubp_update_mall_sel.from_new_state = true },
 };
 
 /* A changed ODM layout takes effect before the update returns. */
 static const struct dcn401_commit_step odm_wait[] = {
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
-	  .meta.skip_if.same_opp_heads = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.pipe_deltas.odm_kept = true },
 };
 
 static const struct dcn401_commit_step trigger[] = {
 	{ .func = OPTC_PROGRAM_MANUAL_TRIGGER,
+	  .meta.skip_if.stream_unchanged = true,
 	  .meta.skip_if.no_manual_trigger = true },
 };
 
@@ -2140,14 +2268,88 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	}
 }
 
+static bool dcn401_same_opp_heads(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
+{
+	const struct pipe_ctx *cur = dcn401_otg_master(current_state, stream);
+	const struct pipe_ctx *new = dcn401_otg_master(new_state, stream);
+	struct pipe_ctx *cur_heads[MAX_PIPES], *new_heads[MAX_PIPES];
+	int i, n;
+
+	if (!cur || !new)
+		return false;
+	n = resource_get_opp_heads_for_otg_master(cur,
+			(struct resource_context *)&current_state->res_ctx,
+			cur_heads);
+	if (n != resource_get_opp_heads_for_otg_master(new,
+			(struct resource_context *)&new_state->res_ctx,
+			new_heads))
+		return false;
+	for (i = 0; i < n; i++)
+		if (!cur_heads[i]->stream_res.opp ||
+				!new_heads[i]->stream_res.opp ||
+				cur_heads[i]->stream_res.opp->inst !=
+				new_heads[i]->stream_res.opp->inst)
+			return false;
+	return true;
+}
+
+static void dcn401_eval_pipe_deltas(const struct dcn401_commit_step_args *args,
+		unsigned int idx, struct dcn401_pipe_deltas *deltas)
+{
+	const struct dc_state_pipe_flags *cur_f =
+			&args->update_flags->cur_pipes[idx];
+	const struct dc_state_pipe_flags *new_f =
+			&args->update_flags->new_pipes[idx];
+	const struct pipe_ctx *cur = &args->current_state->res_ctx.pipe_ctx[idx];
+	const struct pipe_ctx *new = &args->new_state->res_ctx.pipe_ctx[idx];
+
+	deltas->hubp_dpp_already_enabled = cur_f->enabled && new_f->enabled &&
+			cur->stream->stream_id == new->stream->stream_id &&
+			cur->plane_res.hubp->inst == new->plane_res.hubp->inst &&
+			cur->plane_res.dpp->inst == new->plane_res.dpp->inst &&
+			cur->stream_res.opp->inst == new->stream_res.opp->inst;
+	deltas->det_unchanged = cur_f->det_size == new_f->det_size;
+	deltas->current_has_no_plane = !cur_f->has_plane;
+	deltas->odm_kept = new->stream && dcn401_same_opp_heads(
+			args->current_state, args->new_state, new->stream);
+}
+
+static bool dcn401_pipe_deltas_match(const struct dcn401_pipe_deltas *skip,
+		const struct dcn401_pipe_deltas *deltas, bool all)
+{
+	const bool named[] = { skip->hubp_dpp_already_enabled,
+			skip->det_unchanged, skip->current_has_no_plane,
+			skip->odm_kept };
+	const bool set[] = { deltas->hubp_dpp_already_enabled,
+			deltas->det_unchanged, deltas->current_has_no_plane,
+			deltas->odm_kept };
+	bool any = false;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(named); i++) {
+		if (!named[i])
+			continue;
+		if (all && !set[i])
+			return false;
+		any |= set[i];
+	}
+	return any;
+}
+
 static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *step)
 {
+	const struct dcn401_pipe_deltas *skip = &step->meta.skip_if.pipe_deltas;
+	struct dcn401_pipe_deltas deltas;
 	const struct pipe_ctx *cur, *new;
 
 	if (step->meta.skip_if.new_state_has_stream &&
 			args->new_state->stream_count)
 		return true;
+	if (step->meta.skip_if.stream_unchanged && args->stream_unchanged)
+		return true;
 	if (step->meta.skip_if.optimized_not_required &&
 			!args->dc->optimized_required)
 		return true;
@@ -2160,6 +2362,7 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 		return false;
 	cur = &args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
 	new = &args->new_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
+	dcn401_eval_pipe_deltas(args, args->pipe->pipe_idx, &deltas);
 	if (step->meta.skip_if.no_manual_trigger &&
 			(!args->pipe->plane_state->update_bits.addr_update ||
 			args->pipe->plane_state->skip_manual_trigger))
@@ -2168,28 +2371,14 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			(!args->pipe->stream_res.opp ||
 			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
 		return true;
-	if (step->meta.skip_if.hubp_dpp_already_enabled &&
-			dcn401_pipe_kept(cur, new))
-		return true;
-	if (step->meta.skip_if.no_plane_removed &&
-			(!cur->plane_state || dcn401_pipe_kept(cur, new)))
-		return true;
-	if (step->meta.skip_if.det_unchanged && dcn401_pipe_kept(cur, new) &&
-			cur->hubp_regs.det_size == new->hubp_regs.det_size)
-		return true;
-	if (step->meta.skip_if.odm_kept && dcn401_pipe_kept(cur, new) &&
-			dcn401_same_opp_heads(args->current_state,
-			args->new_state, args->pipe->stream))
-		return true;
-	if (step->meta.skip_if.same_opp_heads &&
-			dcn401_same_opp_heads(args->current_state,
-			args->new_state, args->pipe->stream))
+	if (dcn401_pipe_deltas_match(skip, &deltas,
+			step->meta.skip_if.pipe_deltas_all))
 		return true;
 	if (step->meta.skip_if.scaling_unchanged &&
 			!args->pipe->plane_state->update_bits.scaling_change &&
 			!args->pipe->plane_state->update_bits.position_change &&
 			!args->pipe->stream->update_flags.bits.scaling &&
-			(!dcn401_pipe_kept(cur, new) ||
+			(!deltas.hubp_dpp_already_enabled ||
 			!memcmp(&cur->plane_res.scl_data, &new->plane_res.scl_data,
 			sizeof(cur->plane_res.scl_data))))
 		return true;
@@ -2212,7 +2401,7 @@ static bool dcn401_walks_stream(const struct dcn401_commit_step_args *args,
 		const struct dc_stream_state *stream)
 {
 	if (args->stream)
-		return stream == args->stream;
+		return stream->stream_id == args->stream->stream_id;
 	return !dcn401_stream_kept(args->dc, args->current_state,
 			args->new_state, stream);
 }
@@ -2316,6 +2505,8 @@ void dcn401_init_and_unpack_params(
 	state_args->new_state = (struct dc_state *)params->new_state;
 	state_args->stream = NULL;
 	state_args->pipe = NULL;
+	state_args->update_flags = params->update_flags;
+	state_args->stream_unchanged = false;
 
 	params->head_num_steps = 0;
 	params->tail_num_steps = 0;
@@ -2409,7 +2600,8 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	result = dcn401_check_seamless_update_support(params->dc,
-			params->current_state, params->new_state, params->stream);
+			params->current_state, params->new_state,
+			params->update_flags, params->stream);
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
@@ -2426,7 +2618,8 @@ static bool dcn401_seamless_update_check_capability(
 		const struct bls_builder_check_capability_params *params)
 {
 	return params && dcn401_check_seamless_update_support(params->dc,
-			params->current_state, params->new_state, params->stream) ==
+			params->current_state, params->new_state,
+			params->update_flags, params->stream) ==
 			BLS_BUILD_SUCCESS;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index edb50c23ce24..961c3c1ea51f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -1165,3 +1165,31 @@ bool dc_state_is_alt_in_use(const struct dc *dc, const struct dc_state *state)
 	}
 	return false;
 }
+
+static void pipe_flags(const struct pipe_ctx *pipe,
+		struct dc_state_pipe_flags *flags)
+{
+	flags->has_plane = pipe->plane_state != NULL;
+	flags->enabled = flags->has_plane && pipe->stream &&
+			pipe->plane_res.hubp && pipe->plane_res.dpp &&
+			pipe->stream_res.opp;
+	flags->det_size = pipe->hubp_regs.det_size;
+}
+
+enum dc_status dc_state_compute_update_flags(const struct dc_state *cur_state,
+		const struct dc_state *target_state,
+		struct dc_state_update_flags *out_flags)
+{
+	unsigned int i;
+
+	if (!cur_state || !target_state || !out_flags)
+		return DC_ERROR_UNEXPECTED;
+	memset(out_flags, 0, sizeof(*out_flags));
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_flags(&cur_state->res_ctx.pipe_ctx[i],
+				&out_flags->cur_pipes[i]);
+		pipe_flags(&target_state->res_ctx.pipe_ctx[i],
+				&out_flags->new_pipes[i]);
+	}
+	return DC_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 22da4ebae256..c4e1fef8266e 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -169,6 +169,7 @@ static enum dc_status core2_build_and_run(struct dc *dc,
 	const struct workaround_manager *wam = dc2_workaround_manager_get();
 	struct bls_builder_declarative_params *params;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
+	struct dc_state_update_flags update_flags;
 
 	/* 256 block-sequence entries; keep them off the kernel stack. */
 	params = kvzalloc(sizeof(*params), GFP_KERNEL);
@@ -178,6 +179,10 @@ static enum dc_status core2_build_and_run(struct dc *dc,
 	params->current_state = dc->current_state;
 	params->new_state = new_state;
 	params->stream = stream;
+	if (dc_state_compute_update_flags(dc->current_state, new_state,
+			&update_flags) != DC_OK)
+		goto out;
+	params->update_flags = &update_flags;
 
 	/*
 	 * A tail runs on the vsync after the head, so Core would have to wait
@@ -203,14 +208,18 @@ static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
 		struct dc_state *new_state, const struct dc_stream_state *stream)
 {
 	const struct bls_builder *builder = TO_DC2(dc)->builders[name];
+	struct dc_state_update_flags update_flags;
 	struct bls_builder_check_capability_params check = {
 		.dc = dc,
 		.current_state = dc->current_state,
 		.new_state = new_state,
 		.stream = stream,
+		.update_flags = &update_flags,
 	};
 
-	return builder && builder->check_capability &&
+	return dc_state_compute_update_flags(dc->current_state, new_state,
+			&update_flags) == DC_OK &&
+			builder && builder->check_capability &&
 			builder->kind == BLS_BUILDER_DECLARATIVE &&
 			builder->build.declarative &&
 			dc2_workaround_manager_get() &&
@@ -282,14 +291,16 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 				context, current_state->streams[i]))
 			core2_commit_disable_done(dc, otg_master);
 	}
-	for (i = 0; i < context->stream_count; i++)
+	for (i = 0; i < context->stream_count; i++) {
+		struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+				&context->res_ctx, context->streams[i]);
+
 		if (dcn401_stream_kept(dc, current_state, context,
 				context->streams[i]))
 			core2_update_done(dc, context, context->streams[i]);
-		else
-			core2_commit_enable_done(
-					resource_get_otg_master_for_stream(
-					&context->res_ctx, context->streams[i]));
+		else if (otg_master)
+			core2_commit_enable_done(otg_master);
+	}
 	return DC_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
index 191bb431991f..0415e45d438e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
@@ -26,6 +26,7 @@
 #ifndef _DC_STATE_PRIV_H_
 #define _DC_STATE_PRIV_H_
 
+#include "dc.h"
 #include "dc_state.h"
 #include "dc_stream.h"
 
@@ -126,4 +127,26 @@ bool dc_state_can_clear_stream_cursor_subvp_limit(const struct dc_stream_state *
 bool dc_state_is_subvp_in_use(struct dc_state *state);
 
 bool dc_state_is_alt_in_use(const struct dc *dc, const struct dc_state *state);
+
+/* Facts about one pipe of one state. */
+struct dc_state_pipe_flags {
+	/* The pipe drives a stream through a HUBP, a DPP and an OPP. */
+	bool enabled;
+	/* The pipe shows a plane. */
+	bool has_plane;
+	/* The DET size from hubp_regs. */
+	uint32_t det_size;
+};
+
+/* The facts of pipe i in the current and in the target state. */
+struct dc_state_update_flags {
+	struct dc_state_pipe_flags cur_pipes[MAX_PIPES];
+	struct dc_state_pipe_flags new_pipes[MAX_PIPES];
+};
+
+/* Pure: reads both states and writes only out_flags. */
+enum dc_status dc_state_compute_update_flags(const struct dc_state *cur_state,
+		const struct dc_state *target_state,
+		struct dc_state_update_flags *out_flags);
+
 #endif /* _DC_STATE_PRIV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
index b8a8b8256262..c774ebdae968 100644
--- a/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
+++ b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
@@ -19,6 +19,9 @@ struct dc_trait_match {
 #define DC_TRAIT_MATCH(set, clear) \
 	((struct dc_trait_match){ .mask = (set) | (clear), .value = (set) })
 
+/* Every element matches: no trait constrains it. */
+#define DC_TRAIT_MATCH_ANY DC_TRAIT_MATCH(0, 0)
+
 /* Plane and pipe accessors: no stream filter. */
 #define DC_FACTS_ALL_STREAMS 0xFFu
 
-- 
2.43.0

