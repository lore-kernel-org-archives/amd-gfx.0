Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226B606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FgGJlJ2o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F7C10F840;
	Tue, 17 Nov 2026 17:16:58 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B110210F847
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS70MFmSaJhMnfwzVpMSspufPBvPllnqkJiU3z3fVgDbA5qcpaPHrEbIjxveFIBr0c2vhtNd9kagfOyB5MC4c+YgyqXXVvHptym5jID3u3G7QYiAhoBynd2I7BZgmB6xXoDgWRYQX3OP/kQLSQ33c9Jrohpx8+i8ZPkzLy1GQHXq573xAs6RgvCDszRslH3O3DuR/5EVnaerUbAZzgp2pBxJQt26wStsPcBW3DGEOYKKQB3EUdJS1iTXvsKevQBqqpFUlaxYhornTNx34v3CFGAJRUTFTr4WxgsPR3rURI7h0qoTzEZyHotFWRUhmoZh3zIPDmI63oHHmrDgmm3n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHyU84wua8ocFQvj0UJusMF/KovYVVQehb+jtUtZBns=;
 b=IkTjQrqn5qQ2QNNmh+gV4gEw5rFVPoc4b3gAXXcibD/naJgpA0/8dMLnhEcE04Fn3tYmsGtbwaSNkN4pM5L2irIYcwreL7uzDfdY+IxCgsUX9p32fGlD2chcGIJaaPvTdbxqN7fulSmeBeW23ulzHKH6qyIGVkkOgp3kkFMeS05qq67311gkaqev2tzdk9VnS6IFamV+vY9jVj/4TzVnH/JAWPfYv8QXsg9J10ZyEJa9ZyKm8G43YCDfps7EMBjGm5J8NxzKVpAS8FYInDhitVve9KS6oCs2cFa7np+Aw+5h9Us50UxFcAQCzYLMMpHegr6g826Us/ePbnH3Ss+Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHyU84wua8ocFQvj0UJusMF/KovYVVQehb+jtUtZBns=;
 b=FgGJlJ2oPbT87p5ZPy354ESorqnbUkya8pM+ZKs5qluWfi0gXVR87MQrlRAzIBzE2zlOfS539hc5G4mQeZTABU8ucI3EJG+hB79Lmr64R68suAGEV/CszBEGxp/ULVMboZjlglDMUmvqnQqRKB+cw+8Ik8wLSZorxeYpxlSlKcw=
Received: from MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::26)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:16:48 +0000
Received: from IA0PEPF00000042.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::5) by MN0P220CA0016.outlook.office365.com
 (2603:10b6:208:52e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:16:47 +0000
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
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:46 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:16:38 -0600
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
Subject: [PATCH 27/33] drm/amd/display: Keep an unchanged stream in the DC2
 commit
Date: Tue, 17 Nov 2026 05:51:04 +0800
Message-ID: <20261116215641.2800595-28-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000042:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7b3584-5f84-4418-eddf-08df44ce8ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|20052099010|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: db6Qdv4u8v6EtfNx2Ac8CgYN1MPt4bNNy8bl1oo2qhA4sdlcZSe46x0y2W904azQq/JglkvdtvC+quc265MqwJxpo2vsofpArMaBV+jBjOdv3GL7jpnsmVprMVp3pB6pshJ4CoAsaopWE6mubyZ79nB6Z3PM2i3yokhMO0CkTlLG8g2s4807parpPF1Ev0ND5IJjZSNztYk9v+DzDe7dcokfZtaR1MWd8eWzE7tCQhNqlYsEop+HCSC3mKKAGMpd35EG85djy/Hz7HWrqz+EvUvleAs8beyzRYcfqFhHvTu7L1jDmS4nHr263baJOhomx69YyxQx64tTUkNPhmtJIGu/vPCd/R7DOtyMvUcjGxB+4BfifdTL/4zKpFaXTShhJOoONoSLU5w/nOXf0U6PTt7iAQy4E/FDb0vFLFdiaTeU4TY7yU0634pginv3vnR9zD7KEwxW0NO7AaqzRrFc8UkZFbUZDoHmntK5npgWiEDRvnWOcIV9hrjJSL0DgeP5IGeOYCPI1sM6FXhrxBeXAHJ8LWV5aue+qyn88E8LD31gwrL1GrgaUh8ZGWbWXDWJg2KCixAs/Tbedi9WEpYdy9VLOgX7Z5ez5JckNEd4T3DtoFz8P7+Cjoa0KqMIkDKaYIReYDQ6oxfuWgbo/vUraj6APt1cPby9l5MfehKU+lAHXPrqWtB9updMrWB9xAbUeuTy4mEY2c65QFQR4KyKWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(20052099010)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RaG5hgrJLlpntpAUzHozlr3RaUewY/wsJkq6vsdf5MBVDYvvV1RVZDwy3J26s6nG54iAIux5QUKvwGnO81M9pVKVCZ8THoLOKQmDHKJEokfn2+hoTuEatUlg7psoP6RgyYFMCRiUj6xrGVWpUozCRYGagRnbmuSWPeQ9iuLAS+qwhpaBY/UyCbOxtiAyiiDlUfLxqaLOyXlmBMQ/jIz1jr6K08g7BiGhkp2cAVwUBrzVYqBIlrzor1qLiCy/77azxT4u4DHc10A0oc6VyGrFtCDiY6lWWjr6mxFVksUtdO1/kj1kaX9YP3tLObIHZTbxD+Kv9OsVirYUT23OApb+H9rSxiLKbD2tm8NDjfV+uOfp2B9wfflgCw0eggppnqlCd5QTzGIOqurjDZ6UcKHbdSXtdN0sPGo6ckTbxXYXIdj5AVsUEWFQS693zJmEXKHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:47.8870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b3584-5f84-4418-eddf-08df44ce8ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000042.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The DC2 non-seamless commit builder disables every current stream and
enables every new stream. A commit that removes one of two streams
blanks the other stream, or fails when that stream shows a plane.

[How]
Do not program a stream that is in both states on the same pipes with
the same planes and blocks. The checks, the step walkers and the Core2
software state skip that stream.

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |  8 +++++
 .../dc/bls_builder/dcn401_builder_internal.h  | 10 ++----
 .../bls_builder/dcn401_non_seamless_builder.c | 31 ++++++++++++-------
 .../dc/bls_builder/dcn401_seamless_builder.c  | 15 +++++++--
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 16 +++++++---
 5 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 879ff188264d..f899c27ea836 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -133,3 +133,11 @@ struct bls_builder {
 
 const struct bls_builder *bls_builder_create(struct dc *dc,
 		enum bls_builder_name name);
+
+/*
+ * stream is in both states on the same pipes, each with the same plane
+ * and blocks. DCN_DECL_NON_SEAMLESS_COMMIT leaves such a stream alone.
+ */
+bool dcn401_stream_unchanged(const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index 35ad8982db9a..2d832017f613 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -74,13 +74,6 @@ const struct pipe_ctx *dcn401_otg_master(const struct dc_state *state,
 /* The index of stream in state, or -1. */
 int dcn401_stream_index(const struct dc_state *state,
 		const struct dc_stream_state *stream);
-/*
- * stream is in both states on the same pipes, each with the same plane
- * and blocks.
- */
-bool dcn401_stream_unchanged(const struct dc_state *current_state,
-		const struct dc_state *new_state,
-		const struct dc_stream_state *stream);
 
 
 /* What both builders need of the dc, before either state. */
@@ -92,7 +85,8 @@ enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
 
 /*
  * pipe is NULL only for the bandwidth and p-state steps. The walkers
- * expand only stream when it is set.
+ * expand only stream when it is set, else each stream that is not
+ * unchanged.
  */
 struct dcn401_commit_step_args {
 	struct dc *dc;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index bfbe2e0e7eb2..dcd1c8a50429 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -10,10 +10,11 @@
 #include "state_facts/state_facts.h"
 
 /*
- * DCN_DECL_NON_SEAMLESS_COMMIT for virtual streams without planes. It
- * disables every current stream, each with one or two planes, one per DPP
- * pipe, then enables every new stream, each with no plane. Planes are
- * added later by DCN_DECL_SEAMLESS_UPDATE, not by this commit. Each
+ * DCN_DECL_NON_SEAMLESS_COMMIT for virtual streams. It disables every
+ * current stream, each with one or two planes, one per DPP pipe, then
+ * enables every new stream, each with no plane. A stream that is
+ * unchanged keeps its pipes and planes, and the commit programs none of
+ * them. Planes are added later by DCN_DECL_SEAMLESS_UPDATE. Each
  * stream is in ODM bypass, 2:1 or 3:1, with one OPP head and at most one
  * DPP pipe per slice.
  *
@@ -120,19 +121,23 @@ static enum bls_builder_result dcn401_check_new_stream(
 
 static enum bls_builder_result dcn401_check_commit_state_support(
 		const struct dc *dc, const struct dc_state *current_state,
-		const struct dc_state *new_state)
+		const struct dc_state *new_state, bool is_current)
 {
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
+	const struct dc_state *state = is_current ? current_state : new_state;
 	enum bls_builder_result result;
 	unsigned int i;
 
-	result = dcn401_check_stream_support(dc, current_state, new_state);
+	result = dcn401_check_stream_support(dc, is_current ? state : NULL,
+			is_current ? NULL : state);
 	for (i = 0; result == BLS_BUILD_SUCCESS && i < state->stream_count;
-			i++)
-		result = current_state ?
+			i++) {
+		if (dcn401_stream_unchanged(current_state, new_state,
+				state->streams[i]))
+			continue;
+		result = is_current ?
 				dcn401_check_current_stream(dc, state, i) :
 				dcn401_check_new_stream(dc, state, i);
+	}
 	return result;
 }
 
@@ -175,10 +180,12 @@ static enum bls_builder_result dcn401_check_non_seamless_commit_support(
 		return result;
 	CHECK_CONDITION(stream_config_update, "stream config update is set");
 
-	result = dcn401_check_commit_state_support(dc, current_state, NULL);
+	result = dcn401_check_commit_state_support(dc, current_state,
+			new_state, true);
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
-	result = dcn401_check_commit_state_support(dc, NULL, new_state);
+	result = dcn401_check_commit_state_support(dc, current_state,
+			new_state, false);
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 178598f18517..3f0285763d52 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -2152,6 +2152,15 @@ static void dcn401_add_steps(struct block_sequence_state *sequence,
 	}
 }
 
+static bool dcn401_walks_stream(const struct dcn401_commit_step_args *args,
+		const struct dc_stream_state *stream)
+{
+	if (args->stream)
+		return stream == args->stream;
+	return !dcn401_stream_unchanged(args->current_state, args->new_state,
+			stream);
+}
+
 static void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
@@ -2161,7 +2170,7 @@ static void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 	unsigned int i;
 
 	for (i = 0; i < state->stream_count; i++) {
-		if (args.stream && state->streams[i] != args.stream)
+		if (!dcn401_walks_stream(&args, state->streams[i]))
 			continue;
 		args.pipe = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[i]);
@@ -2180,7 +2189,7 @@ static void dcn401_add_per_opp_head(struct block_sequence_state *sequence,
 	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
-		if (args.stream && state->streams[i] != args.stream)
+		if (!dcn401_walks_stream(&args, state->streams[i]))
 			continue;
 		n = resource_get_opp_heads_for_stream(state->streams[i],
 				&state->res_ctx, opp_heads);
@@ -2202,7 +2211,7 @@ static void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
 	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
-		if (args.stream && state->streams[i] != args.stream)
+		if (!dcn401_walks_stream(&args, state->streams[i]))
 			continue;
 		n = resource_get_dpp_pipes_for_stream(state->streams[i],
 				&state->res_ctx, dpp_pipes);
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 90bcf02ded00..ce2b14bb7a5a 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -245,12 +245,18 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 
 	core2_commit_prepare_done(dc, context);
 	for (i = 0; i < current_state->stream_count; i++)
-		core2_commit_disable_done(dc, resource_get_otg_master_for_stream(
-				&current_state->res_ctx,
-				current_state->streams[i]));
+		if (!dcn401_stream_unchanged(current_state, context,
+				current_state->streams[i]))
+			core2_commit_disable_done(dc,
+					resource_get_otg_master_for_stream(
+					&current_state->res_ctx,
+					current_state->streams[i]));
 	for (i = 0; i < context->stream_count; i++)
-		core2_commit_enable_done(resource_get_otg_master_for_stream(
-				&context->res_ctx, context->streams[i]));
+		if (!dcn401_stream_unchanged(current_state, context,
+				context->streams[i]))
+			core2_commit_enable_done(
+					resource_get_otg_master_for_stream(
+					&context->res_ctx, context->streams[i]));
 	return DC_OK;
 }
 
-- 
2.43.0

