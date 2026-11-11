Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE1606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3dNuLnsm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B43F10F8F3;
	Wed, 11 Nov 2026 01:45:07 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C8110F8F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anFVZA3sX4SrNq5ECkgCwnVQQcBgCdo8OoHsd+ODZ5IebyA/Zj73s37hPD4gLpj1jgzajP9BPziiuvINCsZMnhLUgHCvBlSSKOpil7ZsId5rmADqrR2CFj/FvKnx171+H8aVjrmSNC9b3N/Q5yogyNnRiN1zcxxGLsW+67aQXmVOiqQYyq23KeDijIK9UKOXnqNyJtJC+iTq3TjrpLRw2d+HeqN8QszVeyRqohpK5w869/beq2CEOItn/afYu3Ju8/aHXjg8gY2djh3aIUc35kfQy7MiK9sN6QBt/ec7h6lpIOEhLyUQoHQRW9XHo/obZDgZj6ARdk+4T0bvJgcQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVarJIHxaW42Zb0nPsuHulVsNWeCUNxT/k6iIGKowQo=;
 b=a12RD/qv7X7YvnJit08EcuUk2lAk2UNdM/7rqhaWCASZOca2usvMkSoKYv4tHCPYOE+m+ClNhyuJbn20ua5g/E6w9/SO55Bjbouobgb3fS660SHgj1tefQ6JDbtqx8yLRyG75/ndVZEkpcgZwki22Zg05Qxm5gWqufld8OvT9dOSEwbkucxLtuV3Tsmzf6CtGgDbB2N4HPdcpPEktovpd3Lf9MJtdL1NJo2g8DF/DKWqO3qEaXxDNeUyoL3qYKm/7iA51IiOweuFiekfHqFiXtmmHxRP1pkjxQeAtOxHNnM02jU/8WZdk0Getvz1ZRHbT0uBf3j7wZXh2t0hCYmPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVarJIHxaW42Zb0nPsuHulVsNWeCUNxT/k6iIGKowQo=;
 b=3dNuLnsmUjJ1OvpRFHdCi0AnT88npMo1kFYiE6j7tpX6jJoNb2i9G3NQZkLqAUsnJsYDK2ro/0DZ8UaaOWpMyNpiFkfEyyxkYeNQmXbfzw2tHhX/uLTLc6ERHwxRSj/eSIzlB/830lRi8UfbGVkbjdG6gsvWkocKbqaSp7Wjcpc=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Wed, 11 Nov
 2026 01:43:47 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::2d) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:46 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:42 -0600
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
Subject: [PATCH 52/74] drm/amd/display: Add and remove two MPO planes in DC2
Date: Wed, 11 Nov 2026 09:28:58 +0800
Message-ID: <20261111014100.3596072-53-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 09db4788-e577-4c04-308c-08df3f953a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|261009221227099003|261021123027099003|261028144727099003|261009223327099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|261009223027099003|11063799006|261009220027099003|56012099006|5023799004|261009221727099003|10067099003|3023799007|6133799003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info: Dtmhszx2KWpP/XEWjPPS4qt3iU/6BOFY9LBdB2ZlkBzccJm85HiTBkecTfNUt4O16FyErHotgspDqx9NnUfQyoujwpWuoMwau0m3r+wsWpM6k1CF59WP57ilGhTHZGaHpLMFLALh7N1bQdOef6fNr6+XLywBvtpNw9Y/WGqCCj1E9luNhCq3eE8ED4Oz2pKXopFDgrq2VbOyw/paGwNUfLwzI0LTfFHcRvOUQSDVrq85SwmreStu47Fs/dr5wwjpthpRVvrjdKlCGo+x5vJp5ab5/O86kPqA5yFaGGVxfLCV1uLr3kvOc7XoimJF1YW82dv/d3F8x7BmlBUx8owxGs0xOL1lctgyCtSSbH3rMYojEOZqFEUx8Kp2Mb7W2dJCZBnSakdzgrhK69DU6QRyLkTk+6IOUxk0m/vF5dAxCFI0fZeM2MG+mMQ2E//juyg8vaMaoSKuql8hxDn+ekq394dvIUGXbiekivAWAMI5EArfpqrpaxsJUVvAGfOgJnK+4dmBwGbWcNyRJYszemPPRZZDzrIVJAUY2Y+8hAvproiMeszQo5vOCTHrlMV7NUjmgj2EmaCLsrCwite5zsijHJGNb+PF+ojXgtlqyIA8BDHG/6WDZtEoz1d9FDx1rV3Ci5aLkHNg/w0Xo77ZcfXvDeqceonQjkhF/5e5b+xmFDUy77FteT9sIMuIvN78VELM0zLufUMrqyfLht90ucNA9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(261009221227099003)(261021123027099003)(261028144727099003)(261009223327099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(11063799006)(261009220027099003)(56012099006)(5023799004)(261009221727099003)(10067099003)(3023799007)(6133799003)(18002099003)(261102123227099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zSrxh+Qnvn7IwRFSGz4SySSfuvrMfVWyXBsq6c1Wf4XxEbwVel4CNc7sigfNPCDLozGMZRCB2KGeTw8s+UB3EfCgSDWxMF1QrK6w2v893Y+Xoiwrn3JfOzPF7ySnP3eAn0/rp3TKtsJPT2/og+8cC7rwkQyVJwOkgDxsjOjhuPNzeFpFvC17D+AvY9sVshVEUdFE/LNPb7HA1KsmbW2u9eAJZgCukiRls5qwXsv4C8ol6U53uabHs9p26TNULK64zvWI7/3W266mKX2RnHVPDsBPXGA6tMWmVrmUHllqHX64ZQWqfs1o0/EdL5XVpdl/nf/UitRlM4JNla+pBOUD+Bq1MXDfBzYEQvv3wKFOI2kZVC0oOZ1J3hhRxS+3pcbWughtJpQoXqJnzcNzeXzurEho2oateC35Wx2C6lVcX93SNKyuzFlxyk+LoPacbJwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:46.9968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09db4788-e577-4c04-308c-08df3f953a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
The DC2 update on DCN4 supports only one plane. An update with two
MPO planes falls back to the old commit path.

[How]
Let the seamless update add one plane or two blended planes to a kept
stream. Let the non-seamless commit remove a stream with one or two
planes. Program each DPP pipe from one step list, top pipe first.
Write the software state for each DPP pipe.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/bls_builder/dcn401_commit_builder.c    | 450 +++++++++++++-----
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  46 +-
 2 files changed, 350 insertions(+), 146 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index ab84e8fded1d..19765f7dcd11 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -25,16 +25,18 @@
 /*
  * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
  * The new state has no stream, or one stream with no plane; the current
- * state has no stream, or one stream with one plane. A plane is added
- * later by DCN_DECL_SEAMLESS_UPDATE, not by this commit.
+ * state has no stream, or one stream with one or two planes, one per DPP
+ * pipe. Planes are added later by DCN_DECL_SEAMLESS_UPDATE, not by this
+ * commit.
  *
  * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
  * calls in the same order, including the calls DC1 repeats. Everything is
  * in head_sequence: the ODM double-buffer and blank waits come before the
  * bandwidth lower, so no tail is needed.
  *
- * DCN_DECL_SEAMLESS_UPDATE either adds one plane to that stream, or keeps
- * one plane and programs its surface, address, scaler and viewport. The
+ * DCN_DECL_SEAMLESS_UPDATE either adds one plane, or two MPC-blended
+ * planes, to that stream, or keeps one plane and programs its surface,
+ * address, scaler and viewport. The
  * sequence follows the full update in commit_planes_for_stream on dcn401,
  * all in head_sequence: the outstanding updates, prepare_bandwidth and
  * the pending-update waits, then the locked front-end programming and
@@ -282,23 +284,11 @@ static bool check_abm(const struct dc *dc,
 			stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE;
 }
 
-static bool check_plane_count(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-	/*
-	 * The current state carries the removed plane. The new state has
-	 * none.
-	 */
-	bool has_plane = current_state != NULL;
-
-	(void)dc;
-	return state->stream_status[0].plane_count == (has_plane ? 1 : 0);
-}
-
-/* The pipe for this state's one stream, or NULL when it is not exactly one. */
+/*
+ * The OTG master for this state's one stream, or NULL when the stream has
+ * more than one. An MPC bottom pipe of the stream is not an OTG master;
+ * check_mpc_blend bounds it.
+ */
 static const struct pipe_ctx *dcn401_state_otg_master(
 		const struct dc_state *state, bool *not_one_pipe)
 {
@@ -311,6 +301,8 @@ static const struct pipe_ctx *dcn401_state_otg_master(
 
 		if (!pipe->stream)
 			continue;
+		if (pipe->stream == state->streams[0] && pipe->top_pipe)
+			continue;
 		if (pipe->stream != state->streams[0] || otg_master) {
 			*not_one_pipe = true;
 			return NULL;
@@ -340,6 +332,51 @@ static const struct pipe_ctx *dcn401_otg_of(const struct dc_state *state)
 	return dcn401_state_otg_master(state, &not_one_pipe);
 }
 
+/* The OTG master and its MPC bottom pipe, top to bottom. */
+static unsigned int dcn401_dpp_pipe_count(const struct pipe_ctx *otg_master)
+{
+	unsigned int count = 0;
+
+	for (; otg_master; otg_master = otg_master->bottom_pipe)
+		count++;
+	return count;
+}
+
+typedef bool (*dcn401_pipe_check)(const struct pipe_ctx *pipe);
+
+/* False when state has no OTG master, or check fails on one of its pipes. */
+static bool dcn401_each_dpp_pipe(const struct dc_state *state,
+		dcn401_pipe_check check)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(state);
+
+	if (!pipe)
+		return false;
+	for (; pipe; pipe = pipe->bottom_pipe) {
+		if (!check(pipe))
+			return false;
+	}
+	return true;
+}
+
+static bool check_plane_count(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+	unsigned int planes = state->stream_status[0].plane_count;
+
+	(void)dc;
+	/*
+	 * The current state carries the removed planes, one per DPP pipe.
+	 * The new state has none.
+	 */
+	if (!current_state)
+		return !planes;
+	return planes && planes == dcn401_dpp_pipe_count(dcn401_otg_of(state));
+}
+
 static bool check_one_otg_pipe(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -378,24 +415,45 @@ static bool check_mpc_blend(const struct dc *dc,
 	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
 			new_state);
 
+	const struct pipe_ctx *bottom;
+
 	(void)dc;
-	return pipe && !pipe->top_pipe && !pipe->bottom_pipe;
+	if (!pipe || pipe->top_pipe)
+		return false;
+	/* At most one bottom pipe, blended on the master's OTG and OPP. */
+	bottom = pipe->bottom_pipe;
+	if (!bottom)
+		return true;
+	return bottom->top_pipe == pipe && !bottom->bottom_pipe &&
+			!bottom->next_odm_pipe && !bottom->prev_odm_pipe &&
+			bottom->stream == pipe->stream &&
+			bottom->stream_res.tg == pipe->stream_res.tg &&
+			bottom->stream_res.opp == pipe->stream_res.opp;
+}
+
+static bool dcn401_pipe_has_plane(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state != NULL;
+}
+
+static bool dcn401_pipe_has_no_plane(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state == NULL;
 }
 
 static bool check_pipe_plane(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	(void)dc;
 	/*
-	 * The current state carries the removed plane. The new state has
+	 * The current state carries the removed planes. The new state has
 	 * none.
 	 */
-	bool has_plane = current_state != NULL;
-
-	(void)dc;
-	return pipe && !!pipe->plane_state == has_plane;
+	if (current_state)
+		return dcn401_each_dpp_pipe(current_state,
+				dcn401_pipe_has_plane);
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_has_no_plane);
 }
 
 static bool check_otg_master_blocks(const struct dc *dc,
@@ -410,21 +468,25 @@ static bool check_otg_master_blocks(const struct dc *dc,
 			pipe->stream_res.stream_enc && pipe->clock_source;
 }
 
+static bool dcn401_pipe_plane_blocks(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_res.hubp && pipe->plane_res.dpp &&
+			pipe->plane_res.mpcc_inst < MAX_MPCC;
+}
+
 static bool check_plane_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
-
 	(void)dc;
+	(void)new_state;
 	if (!current_state)
 		return true;
-	return pipe && pipe->plane_res.hubp && pipe->plane_res.dpp &&
-			pipe->plane_res.mpcc_inst < MAX_MPCC;
+	return dcn401_each_dpp_pipe(current_state, dcn401_pipe_plane_blocks);
 }
 
-static bool check_mpcc_alone(const struct dc *dc,
+/* The OPP's tree holds exactly the removed MPCCs, in pipe order. */
+static bool check_mpcc_tree(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
@@ -436,11 +498,15 @@ static bool check_mpcc_alone(const struct dc *dc,
 		return true;
 	if (!pipe || !dc->res_pool || !dc->res_pool->mpc)
 		return false;
-	mpcc = &dc->res_pool->mpc->mpcc_array[pipe->plane_res.mpcc_inst];
-	/* The removed MPCC must be the only one in the OPP's tree. */
-	return pipe->stream_res.opp->mpc_tree_params.opp_list == mpcc &&
-			!mpcc->mpcc_bot &&
-			mpcc->dpp_id == pipe->plane_res.dpp->inst;
+	mpcc = pipe->stream_res.opp->mpc_tree_params.opp_list;
+	for (; pipe; pipe = pipe->bottom_pipe) {
+		if (mpcc != &dc->res_pool->mpc->mpcc_array[
+				pipe->plane_res.mpcc_inst] ||
+				mpcc->dpp_id != pipe->plane_res.dpp->inst)
+			return false;
+		mpcc = mpcc->mpcc_bot;
+	}
+	return !mpcc;
 }
 
 static bool check_pipe_audio(const struct dc *dc,
@@ -516,7 +582,8 @@ static enum bls_builder_result dcn401_check_stream_support(
 	CHECK_CONDITION(one_otg_pipe, "stream is not on one pipe");
 	CHECK_RESOURCE(otg_master_present, "stream has no otg master");
 	CHECK_CONDITION(odm_combine, "odm is set");
-	CHECK_CONDITION(mpc_blend, "top or bottom pipe is set");
+	CHECK_CONDITION(mpc_blend,
+			"more than one bottom pipe, or it is off the otg or opp");
 	CHECK_RESOURCE(otg_master_blocks, "otg master is missing a block");
 	CHECK_CONDITION(pipe_audio, "audio is set");
 	CHECK_CONDITION(pipe_dsc, "dsc is set");
@@ -540,7 +607,7 @@ static enum bls_builder_result dcn401_check_commit_state_support(
 	CHECK_CONDITION(plane_count, "plane count does not match the state");
 	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
 	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
-	CHECK_CONDITION(mpcc_alone, "mpcc is not alone in the opp tree");
+	CHECK_CONDITION(mpcc_tree, "opp tree does not match the pipes");
 	return BLS_BUILD_SUCCESS;
 }
 
@@ -605,11 +672,14 @@ static bool check_stream_kept(const struct dc *dc,
 			current_state->streams[0] == new_state->streams[0];
 }
 
+/* Both planes of an MPO state are added together, by one update. */
 static bool dcn401_is_plane_add(const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
+	unsigned int planes = new_state->stream_status[0].plane_count;
+
 	return !current_state->stream_status[0].plane_count &&
-			new_state->stream_status[0].plane_count == 1;
+			(planes == 1 || planes == 2);
 }
 
 static bool dcn401_is_plane_kept(const struct dc_state *current_state,
@@ -620,16 +690,20 @@ static bool dcn401_is_plane_kept(const struct dc_state *current_state,
 }
 
 /*
- * The seamless update either adds the first plane, or keeps one plane and
- * programs its surface, address, scaler and viewport.
+ * The seamless update either adds the first one or two planes, or keeps
+ * one plane and programs its surface, address, scaler and viewport. Each
+ * plane has its own DPP pipe.
  */
 static bool check_plane_add_or_kept(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
-	return dcn401_is_plane_add(current_state, new_state) ||
-			dcn401_is_plane_kept(current_state, new_state);
+	if (!dcn401_is_plane_add(current_state, new_state) &&
+			!dcn401_is_plane_kept(current_state, new_state))
+		return false;
+	return dcn401_dpp_pipe_count(dcn401_otg_of(new_state)) ==
+			new_state->stream_status[0].plane_count;
 }
 
 static bool check_same_otg_master_blocks(const struct dc *dc,
@@ -646,16 +720,19 @@ static bool check_same_otg_master_blocks(const struct dc *dc,
 			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
 }
 
+static bool dcn401_pipe_new_plane_blocks(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state && pipe->plane_res.hubp &&
+			pipe->plane_res.dpp && pipe->plane_res.dpp->funcs;
+}
+
 static bool check_new_plane_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
 	(void)dc;
 	(void)current_state;
-	return pipe && pipe->plane_state && pipe->plane_res.hubp &&
-			pipe->plane_res.dpp && pipe->plane_res.dpp->funcs;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_new_plane_blocks);
 }
 
 static bool check_pool_funcs(const struct dc *dc,
@@ -667,23 +744,27 @@ static bool check_pool_funcs(const struct dc *dc,
 	return dc->res_pool->funcs && dc->res_pool->hubbub->funcs;
 }
 
-/* DC1 uses the HUBP instance as the MPCC and DPP instance. */
-static bool check_plane_instances(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+static bool dcn401_pipe_plane_instances(const struct pipe_ctx *pipe)
 {
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
 	int inst;
 
-	(void)dc;
-	(void)current_state;
-	if (!pipe || !pipe->plane_res.hubp || !pipe->plane_res.dpp)
+	if (!pipe->plane_res.hubp || !pipe->plane_res.dpp)
 		return false;
 	inst = pipe->plane_res.hubp->inst;
 	return inst < MAX_MPCC && pipe->plane_res.mpcc_inst == inst &&
 			pipe->plane_res.dpp->inst == inst;
 }
 
+/* DC1 uses the HUBP instance as the MPCC and DPP instance. */
+static bool check_plane_instances(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_plane_instances);
+}
+
 /* dcn401 programs DET by segments only. */
 static bool check_det_by_segments(const struct dc *dc,
 		const struct dc_state *current_state,
@@ -714,15 +795,18 @@ static bool check_no_sanity_checks(const struct dc *dc,
 	return !dc->debug.sanity_checks;
 }
 
+static bool dcn401_pipe_no_wait(const struct pipe_ctx *pipe)
+{
+	return !pipe->wait_is_required;
+}
+
 static bool check_no_pipe_wait(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
-	return pipe && !pipe->wait_is_required;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_wait);
 }
 
 /* dcn20_blank_pixel_data does nothing while a test pattern is on. */
@@ -750,15 +834,18 @@ static bool check_no_forced_dpg(const struct dc *dc,
 }
 
 /* dcn20_blank_pixel_data sets the ABM pipe on unblank when there is one. */
+static bool dcn401_pipe_no_abm(const struct pipe_ctx *pipe)
+{
+	return !pipe->stream_res.abm;
+}
+
 static bool check_no_abm_pipe(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
-	return pipe && !pipe->stream_res.abm;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_abm);
 }
 
 /* enable_plane programs the system aperture when VM is valid. */
@@ -772,30 +859,36 @@ static bool check_no_vm_aperture(const struct dc *dc,
 }
 
 /* enable_plane sets the flip interrupt when the plane asks for one. */
+static bool dcn401_pipe_no_flip_int(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state && !pipe->plane_state->flip_int_enabled;
+}
+
 static bool check_no_flip_int(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
-	return pipe && pipe->plane_state &&
-			!pipe->plane_state->flip_int_enabled;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_flip_int);
 }
 
 
+static bool dcn401_pipe_no_plane_gamut_remap(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state &&
+			!pipe->plane_state->gamut_remap_matrix.enable_remap;
+}
+
 /* The update bypasses the plane gamut remap. */
 static bool check_no_plane_gamut_remap(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
 	(void)dc;
 	(void)current_state;
-	return pipe && pipe->plane_state &&
-			!pipe->plane_state->gamut_remap_matrix.enable_remap;
+	return dcn401_each_dpp_pipe(new_state,
+			dcn401_pipe_no_plane_gamut_remap);
 }
 
 /* The update bypasses the stream gamut remap. */
@@ -819,15 +912,24 @@ static bool check_no_output_csc(const struct dc *dc,
 }
 
 /* The update programs the surface and its address without DCC. */
+static bool dcn401_pipe_no_dcc(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state && !pipe->plane_state->dcc.enable;
+}
+
 static bool check_no_dcc(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_dcc);
+}
 
-	return pipe && pipe->plane_state && !pipe->plane_state->dcc.enable;
+static bool dcn401_pipe_graphics_address(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state &&
+			pipe->plane_state->address.type == PLN_ADDR_TYPE_GRAPHICS;
 }
 
 /* The update programs a single graphics address, not stereo or video. */
@@ -837,10 +939,12 @@ static bool check_graphics_address(const struct dc *dc,
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_graphics_address);
+}
 
-	return pipe && pipe->plane_state &&
-			pipe->plane_state->address.type == PLN_ADDR_TYPE_GRAPHICS;
+static bool dcn401_pipe_no_immediate_flip(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state && !pipe->plane_state->flip_immediate;
 }
 
 /* DC1 programs triple buffering and the flip only for a queued flip. */
@@ -850,27 +954,33 @@ static bool check_no_immediate_flip(const struct dc *dc,
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-
-	return pipe && pipe->plane_state &&
-			!pipe->plane_state->flip_immediate;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_immediate_flip);
 }
 
 /*
  * DC1 translates a distributed-points curve into a LUT while it programs
  * the plane. The update programs only the predefined and bypass curves.
  */
+static bool dcn401_pipe_no_degamma_curve(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_state &&
+			pipe->plane_state->in_transfer_func.type !=
+			TF_TYPE_DISTRIBUTED_POINTS;
+}
+
 static bool check_no_degamma_curve(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_degamma_curve);
+}
 
-	return pipe && pipe->plane_state &&
-			pipe->plane_state->in_transfer_func.type !=
-			TF_TYPE_DISTRIBUTED_POINTS;
+static bool dcn401_pipe_no_dpp_pregam(const struct pipe_ctx *pipe)
+{
+	return pipe->plane_res.dpp && pipe->plane_res.dpp->funcs &&
+			!pipe->plane_res.dpp->funcs->dpp_set_pregam_state;
 }
 
 /* dcn32_set_input_transfer_func calls dpp_set_pregam_state if present. */
@@ -880,10 +990,18 @@ static bool check_no_dpp_pregam(const struct dc *dc,
 {
 	(void)dc;
 	(void)current_state;
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_dpp_pregam);
+}
 
-	return pipe && pipe->plane_res.dpp && pipe->plane_res.dpp->funcs &&
-			!pipe->plane_res.dpp->funcs->dpp_set_pregam_state;
+static bool dcn401_pipe_no_mcm_luts(const struct pipe_ctx *pipe)
+{
+	const union dc_plane_cm_flags *flags;
+
+	if (!pipe->plane_state)
+		return false;
+	flags = &pipe->plane_state->cm.flags;
+	return !flags->bits.blend_enable && !flags->bits.shaper_enable &&
+			!flags->bits.lut3d_enable && !flags->bits.rmcm_enable;
 }
 
 /* dcn401_set_mcm_luts then programs every MCM LUT off. */
@@ -891,16 +1009,9 @@ static bool check_no_mcm_luts(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-	const union dc_plane_cm_flags *flags;
-
 	(void)dc;
 	(void)current_state;
-	if (!pipe || !pipe->plane_state)
-		return false;
-	flags = &pipe->plane_state->cm.flags;
-	return !flags->bits.blend_enable && !flags->bits.shaper_enable &&
-			!flags->bits.lut3d_enable && !flags->bits.rmcm_enable;
+	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_mcm_luts);
 }
 
 static bool check_no_shaper_curve(const struct dc *dc,
@@ -1030,7 +1141,8 @@ static struct pipe_ctx *get_otg_master_from_state_by_stream(
 	unsigned int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (state->res_ctx.pipe_ctx[i].stream == stream)
+		if (state->res_ctx.pipe_ctx[i].stream == stream &&
+				!state->res_ctx.pipe_ctx[i].top_pipe)
 			return &state->res_ctx.pipe_ctx[i];
 	}
 	return NULL;
@@ -1059,14 +1171,28 @@ static const struct dcn401_commit_step bls_head_per_state_new[] = {
  *   disable_link, which disables the output as DisplayPort.
  * - dcn401_reset_back_end_for_pipe after link_set_dpms_off, then the
  *   clock source power-down from dcn401_reset_hw_ctx_wrap.
+ * The front end disconnects every MPCC under the lock, then powers down
+ * each DPP pipe after the unlock; the _dpp tables run once per DPP pipe.
  */
 static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current[] = {
+		bls_head_per_stream_per_otg_master_pipe_current_lock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_dpp_pipe_current_disconnect[] = {
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
 	{ .func = MPC_REMOVE_MPCC },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current_unlock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_dpp_pipe_current_power_down[] = {
 	{ .func = MPC_ASSERT_IDLE_MPCC },
 	{ .func = HUBP_SET_BLANK },
 	{ .func = HUBP_UPDATE_MALL_SEL },
@@ -1082,6 +1208,10 @@ static const struct dcn401_commit_step
 	{ .func = HUBP_RESET },
 	{ .func = DPP_RESET },
 	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current_stream_off[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
 
 	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
@@ -1201,12 +1331,23 @@ static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {
 	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = true },
 };
 
+/* The support check allows the OTG master and one MPC bottom pipe. */
+#define DCN401_MAX_DPP_PIPES 2
+
 /*
  * Bounds on what build adds. The support check allows one stream per
  * state, and never one in both.
  */
 static_assert(ARRAY_SIZE(bls_head_per_state_new) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current) +
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current_lock) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
+		bls_head_per_stream_per_dpp_pipe_current_disconnect) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_current_unlock) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
+		bls_head_per_stream_per_dpp_pipe_current_power_down) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_current_stream_off) +
 		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
 		DC2_BLS_MAX_STEPS,
 		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
@@ -1263,8 +1404,14 @@ static const struct dcn401_commit_step
  */
 static const struct dcn401_commit_step bls_update_head_new_lock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_dpp_lock[] = {
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_first_hubp[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
 	  .meta.hubbub_force_pstate_change_control.enable = true },
 	{ .func = DC_UDELAY },
@@ -1313,16 +1460,12 @@ static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
 	  .meta.hubp_program_det_segments.allocate = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
-};
-
-/*
- * update_dchubp_dpp. First enable runs the whole table. A reconfigure
- * skips the steps that only bring the HUBP/DPP up, and programs the
- * scaler and viewport only when scaling or position changed. The MPCC is
- * removed when the OPP tree already holds one.
- */
-static const struct dcn401_commit_step
-		bls_update_head_new_update_dchubp_dpp[] = {
+	/*
+	 * update_dchubp_dpp. First enable runs the whole table. A reconfigure
+	 * skips the steps that only bring the HUBP/DPP up, and programs the
+	 * scaler and viewport only when scaling or position changed. The MPCC is
+	 * removed when the OPP tree already holds one.
+	 */
 	{ .func = DPP_DPPCLK_CONTROL, .meta.dpp_dppclk_control.enable = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = DCCG_UPDATE_DPP_DTO,
@@ -1362,14 +1505,9 @@ static const struct dcn401_commit_step
 	{ .func = HUBP_UPDATE_PLANE_ADDR },
 	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
-};
-
-/*
- * set_hdr_multiplier, the input and MCM transfer functions, the output
- * transfer function and the OPP format. First enable only.
- */
-static const struct dcn401_commit_step
-		bls_update_head_new_transfer_funcs[] = {
+	/* set_hdr_multiplier, the input and MCM transfer functions, the
+	 * output transfer function and the OPP format. First enable only.
+	 */
 	{ .func = DPP_SET_HDR_MULTIPLIER,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = DPP_SET_PRE_DEGAM,
@@ -1406,10 +1544,22 @@ static const struct dcn401_commit_step
  */
 static const struct dcn401_commit_step bls_update_head_new_unlock[] = {
 	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_dpp_flip[] = {
 	{ .func = HUBP_WAIT_FLIP_PENDING },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_pstate[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_dpp_mall[] = {
 	{ .func = HUBP_UPDATE_MALL_SEL,
 	  .meta.hubp_update_mall_sel.from_new_state = true },
+};
+
+static const struct dcn401_commit_step bls_update_head_new_trigger[] = {
 	{ .func = OPTC_PROGRAM_MANUAL_TRIGGER,
 	  .meta.skip_if.no_manual_trigger = true },
 };
@@ -1423,11 +1573,16 @@ static_assert(
 		ARRAY_SIZE(
 		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
 		ARRAY_SIZE(bls_update_head_new_lock) +
+		ARRAY_SIZE(bls_update_head_new_first_hubp) +
 		ARRAY_SIZE(bls_update_head_new_stream) +
+		ARRAY_SIZE(bls_update_head_new_unlock) +
+		ARRAY_SIZE(bls_update_head_new_pstate) +
+		ARRAY_SIZE(bls_update_head_new_trigger) +
+		DCN401_MAX_DPP_PIPES * (
+		ARRAY_SIZE(bls_update_head_new_dpp_lock) +
 		ARRAY_SIZE(bls_update_head_new_enable_plane) +
-		ARRAY_SIZE(bls_update_head_new_update_dchubp_dpp) +
-		ARRAY_SIZE(bls_update_head_new_transfer_funcs) +
-		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
+		ARRAY_SIZE(bls_update_head_new_dpp_flip) +
+		ARRAY_SIZE(bls_update_head_new_dpp_mall)) <= DC2_BLS_MAX_STEPS,
 		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
 
 /* pipe is NULL only for the bandwidth and p-state steps. */
@@ -2297,11 +2452,32 @@ static void dcn401_add_per_otg_master(
 	}
 }
 
+/* Each DPP pipe of each stream, the OTG master first. */
+static void dcn401_add_per_dpp_pipe(
+		struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		struct dc_state *state,
+		const struct dcn401_commit_step *steps, unsigned int count)
+{
+	struct dcn401_commit_step_args args = *state_args;
+	unsigned int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		for (args.pipe = get_otg_master_from_state_by_stream(state,
+				state->streams[i]); args.pipe;
+				args.pipe = args.pipe->bottom_pipe)
+			dcn401_add_steps(sequence, &args, steps, count);
+	}
+}
+
 #define DCN401_ADD_STEPS(sequence, args, steps) \
 	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
 #define DCN401_ADD_PER_OTG_MASTER(sequence, args, state, steps) \
 	dcn401_add_per_otg_master(sequence, args, state, steps, \
 			ARRAY_SIZE(steps))
+#define DCN401_ADD_PER_DPP_PIPE(sequence, args, state, steps) \
+	dcn401_add_per_dpp_pipe(sequence, args, state, steps, \
+			ARRAY_SIZE(steps))
 
 /*
  * Points the step arguments at the states and the sequence at
@@ -2342,7 +2518,17 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
 			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current);
+			bls_head_per_stream_per_otg_master_pipe_current_lock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
+			bls_head_per_stream_per_dpp_pipe_current_disconnect);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
+			state_args.current_state,
+			bls_head_per_stream_per_otg_master_pipe_current_unlock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
+			bls_head_per_stream_per_dpp_pipe_current_power_down);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
+			state_args.current_state,
+			bls_head_per_stream_per_otg_master_pipe_current_stream_off);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_head_per_stream_per_otg_master_pipe_new);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
@@ -2383,16 +2569,28 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	 */
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_update_head_new_lock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
+			bls_update_head_new_dpp_lock);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_stream);
+			bls_update_head_new_first_hubp);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_update_head_new_stream);
+	/*
+	 * One step list per DPP pipe, top pipe first, so the top MPCC is
+	 * inserted before the bottom one.
+	 */
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
 			bls_update_head_new_enable_plane);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_update_dchubp_dpp);
+			bls_update_head_new_unlock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
+			bls_update_head_new_dpp_flip);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_transfer_funcs);
+			bls_update_head_new_pstate);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.new_state,
+			bls_update_head_new_dpp_mall);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_update_head_new_unlock);
+			bls_update_head_new_trigger);
 
 	return BLS_BUILD_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 85d9aa1614f6..33c52ef9b728 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -60,7 +60,8 @@ static struct pipe_ctx *core2_otg_master(struct dc_state *state)
 	if (!state->stream_count)
 		return NULL;
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (state->res_ctx.pipe_ctx[i].stream == state->streams[0])
+		if (state->res_ctx.pipe_ctx[i].stream == state->streams[0] &&
+				!state->res_ctx.pipe_ctx[i].top_pipe)
 			return &state->res_ctx.pipe_ctx[i];
 	}
 	return NULL;
@@ -159,8 +160,10 @@ static void core2_commit_enable_done(struct pipe_ctx *pipe)
 static void core2_commit_disable_done(struct dc *dc, struct pipe_ctx *pipe)
 {
 	struct dc_link *link = pipe->stream->link;
+	struct pipe_ctx *dpp_pipe;
 
-	pipe->plane_res.hubp->power_gated = true;
+	for (dpp_pipe = pipe; dpp_pipe; dpp_pipe = dpp_pipe->bottom_pipe)
+		dpp_pipe->plane_res.hubp->power_gated = true;
 	link->link_status.link_active = false;
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	pipe->stream->timing_adjust_pending = true;
@@ -295,8 +298,8 @@ static bool core2_update_state_supported(
 	if (scratch->update_type != UPDATE_TYPE_FULL ||
 			scratch->flow != UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS)
 		return false;
-	/* The full-update builder adds or keeps one plane. */
-	if (scratch->surface_count != 1)
+	/* The full-update builder adds one or two planes, or keeps one. */
+	if (scratch->surface_count != 1 && scratch->surface_count != 2)
 		return false;
 	if (!core2_stream_update_supported(scratch->stream_update))
 		return false;
@@ -311,22 +314,24 @@ static bool core2_update_state_supported(
  */
 static void core2_update_done(struct dc *dc, struct dc_state *context)
 {
-	struct pipe_ctx *pipe = core2_otg_master(context);
+	struct pipe_ctx *pipe;
 	struct dc_plane_state *plane;
 	struct hubp *hubp;
 
-	if (!pipe || !pipe->plane_state || !pipe->plane_res.hubp ||
-			!pipe->stream_res.opp)
-		return;
-	plane = pipe->plane_state;
-	hubp = pipe->plane_res.hubp;
-
-	vm_helper_mark_vmid_used(dc->vm_helper, plane->address.vmid,
-			(uint8_t)hubp->inst);
-	plane->status.requested_address = plane->address;
-	hubp->opp_id = pipe->stream_res.opp->inst;
-	hubp->mpcc_id = hubp->inst;
-	hubp->power_gated = false;
+	for (pipe = core2_otg_master(context); pipe; pipe = pipe->bottom_pipe) {
+		if (!pipe->plane_state || !pipe->plane_res.hubp ||
+				!pipe->stream_res.opp)
+			return;
+		plane = pipe->plane_state;
+		hubp = pipe->plane_res.hubp;
+
+		vm_helper_mark_vmid_used(dc->vm_helper, plane->address.vmid,
+				(uint8_t)hubp->inst);
+		plane->status.requested_address = plane->address;
+		hubp->opp_id = pipe->stream_res.opp->inst;
+		hubp->mpcc_id = hubp->inst;
+		hubp->power_gated = false;
+	}
 	core2_commit_prepare_done(dc, context);
 }
 
@@ -339,14 +344,15 @@ static void core2_update_state_execute(
 
 	/*
 	 * The values DC1 computes into the context before it programs the
-	 * plane. The builder reads them from the context.
+	 * planes. The builder reads them from the context.
 	 */
 	if (!pipe || !pipe->plane_state)
 		return;
 	if (dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
-	pipe->plane_res.scl_data.lb_params.alpha_en =
-			pipe->plane_state->per_pixel_alpha;
+	for (; pipe; pipe = pipe->bottom_pipe)
+		pipe->plane_res.scl_data.lb_params.alpha_en =
+				pipe->plane_state->per_pixel_alpha;
 
 	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context) != DC_OK) {
 		ASSERT(false);
-- 
2.43.0

