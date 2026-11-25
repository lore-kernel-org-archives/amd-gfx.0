Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275B606A327
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DmsJLC3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836BF10F614;
	Wed, 25 Nov 2026 06:57:03 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847AB10F610
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKn/m0k9W6P+PzNkumQX/CztLLIev+yWD02ZGA0UbB4EK3pDKzLmXE6lYQwaJfqxrCqMcWmv7BSfwvcfK2f+PkSpdsdW4KB+iuAPKj9GFYa1yQSZ2YRSa49kA26Cmp/Td1Tp0WT9F8fZVmgNXEgTdWIxer+AkNd+afVBX8Lopgl/8Q/g7zgdcuDChpEcejRmq7yzHXkHlRPXnpBx7goTLtd8Z/RjzNCdK2I/dnAJJDElQuB+80ycDSlurFMyM44BLI0cWSmjfpWLeVY2sXCNXjdia9OXdJ7sd1wEjAUZvm3Ol2LtHTdOVOr5TBU9AxwQ5mV3rYA/5Ojg7buSupVr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ7BVFhiF0ROJxF3SfCN0nvhC43E98SXclaGjU2orGo=;
 b=w80eZ4O1mYhCwoEtbwN0fNCJ2RecTGifzWs5GQluKigwtB0M3yL3CH19yQ80Pp4BzM56Q5v2m7GHiKvROkSwqacUui8evG4nZzwtCI7NfaAWwjmdq29fWQqqSZ/yg3IBCbyaM5I+g+7UGnSIe45Ll38FxkXxzG5fCuTltQzlneyAU8+azcVEbIHn7AzAJIcYoHvDq9MJ1c3nesdT8GuBHfkoaAwcN1ui8IMZX7B99SD1d7X3cGuQi9E4XoNR3wMLKlCd3l99+glD4M5ajRB8q5Pd2Hk//+jiuofeytUX5J3zT+THekoPtwODUGXNtmIvNS9fUgBSPYLbcQS9yKno1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ7BVFhiF0ROJxF3SfCN0nvhC43E98SXclaGjU2orGo=;
 b=DmsJLC3AiLbwh3gCzq7JNwxaERaLmPYPx2BHSwNWMZMNiZMmDhoiCEN06dvuixvxDNG7vUttORD4o+N6p90JKZG+tY3c6KSFNBdgtKejgU95NTsWt6v42rx6ygqVSV8ImlC2Qk9Txg9mBa10lqnWcRKm+1joAnPFHtwL9EC701I=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:56:51 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4e) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:56:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:50 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:41 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 11/27] drm/amd/display: Add the vsync flip to the DC2 seamless
 update
Date: Wed, 25 Nov 2026 14:55:00 +0800
Message-ID: <20261125065631.3889665-12-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca9acb4-75c1-43d2-8ea1-08df4ac14864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|261009221227099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: FT0jQkSX5FpATVbb89O9Px2dG8X0lrfHmdrb2mS6sRbAfe73Scx3fCErKTKXdRbSi+wvUI8auAv1B0XmNT3mvahIxeQ5bPmlOZdLkZkpRjhyyzDGamTwA4uItyKPj+LKN5jBss2LsXh/i+NQ+p4KdL7YIZwJB6zyZIyJXE8ZYc7g/tUvihhgt6gpUXz6rbKotJS3cbupypW5g+ABlykOK5OTr3d+BdIG5d3yQBxrTJv+uFt63wXo0mgqvjBqoUGDtGEt4mivS+nkkrTDJCgFyXevyrvqBwOzGbEr8JhKL0bdosUbZSJyYvOGv6qk3Af6Wu7s7wdO0qfaCoq3lDSiXJKhmm2igYnqxU8doKy2tCXGZf0hhSaY27fjdSlon4TGVDd/K3ycqNoyYumbw2a1t6O7nW3GuqOHKXAnEROCAQBLyhPQJr6U8AKms1/yNCViOKM6BxGKnmF/uEhmejC3+aLeT1ETrkdnNFdxGH4bNtVraUU1x0+ydtN/Z/lHWs/SMzvjxeN0629L12HwCI60SbPYg9PJSbWUBIw7udZkQ4KEqb5wX98VlYV0vrDkJDLLLlloTWP7UnXRacqQH+G4VDYW9LenUps2Rur47mNm0jBdV96+Ffgef202f8OLRt5ZOSR1OepDOj/YwxKE2jbhZ+dikHgUw2wuXZBX9v5+z0oBaYVQBsERgWTcu60liYuOtFdAMgkNg2QnJhmt5CS9Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261009221227099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G/uDPKLgjye73HfFyXjXywzzIC4ChBhdjlQfaV4wA4lVQyt6pmWjenVqtL6FGJ5FqABWeJQVwjYjN/H4WPXnRG7rixryI1aKZNjz3T+MwmHTlarllDCS4ht7bGk66Mw2L+MLp1pH+zH1q4xHbCW51tEw0CemDIwEVZqPh3pNN1LyXeXSlVytWAVwLDYDtpLQe0xO+5adpJmwgoUmgaNl78RowiBL5h/m5AKmtW+JZUoA6G2XI6zgOydZJE85E9OA/cJQLIkD8lIA6VTSE00/xNgF5cf+iyExZI6klnHxNlecvjuUVm5LW/wajV0szdSDHP+QbPP4cx4cpRzCbzp73PXZr0cvU34OsYiZP93v1XHeYmwELk0/vO+gTnwE1YzGfNzSVVTjQRmbDUGdksiQWjBNNTNkEyQpY/9dl553/aFS7HjKtaMWEH0ZASXXvURT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:51.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca9acb4-75c1-43d2-8ea1-08df4ac14864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
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
With DC2 selected, Core2 rejects every fast update. A flip on the one
virtual plane falls back to DC1.

[How]
Split enable_plane into named stages: ungate_hw, setup_pipe_1,
reconfigure_mpc, setup_pipe_2, program_flip and setup_pipe_3. A
per-DPP-pipe sub-sequence can hold stages, and each pipe runs every
stage before the next pipe, so the emitted order does not change.

program_flip holds the plane address and the GSL and triple buffer of
the fast flip. The update chooses its steps from the update flags only.
dcn401_is_hardware_remapped compares the enabled, plane and DET facts
of each pipe of the stream in both states.
dcn401_are_pipe_configs_changed reports a stream flag, or a plane bit
other than the address, on a pipe of the stream. A new only_if meta
holds the necessary conditions of a step, next to skip_if, which holds
the sufficient conditions for a skip. The GSL and triple buffer steps
are emitted only if the hardware is not remapped and no pipe config
changed, so a new or reconfigured plane programs only the address. A
new skip_if.only_addresses_changed skips each step that only a full
update needs, so a flip emits the lock, program_flip, the unlock and
the trigger.

The DCC meta wait and the cursor update are not emitted. The wait is 0
without an immediate flip, and the cursor update does nothing without
cursor offload, which the dc check rejects.

The flip check uses the shared dc and stream checks and reads only the
state, not the hwss. It rejects each state that makes DC1 send a DMUB
command, take a DMUB lock, or add a call: SubVP, PSR, Replay, an ABM
level, a stream update flag, ODM, more than one plane, an immediate
flip, triple-buffer flips, an MCM LUT and any plane update bit other
than the address. A kept state that does not flip is rejected.

Core2 takes the context-fast flow on the kept context in the same
support and execute path as the full update, when each surface is a
plane of the stream and there is no stream update. A fast update skips
the mcache programming and the bandwidth bookkeeping. After the
update, Core2 marks the VMID, records the requested address and clears
the stream update flags.

Before the build, core2_update_state_execute also calls
set_p_state_switch_method on every DPP pipe of the stream, for both
full and fast updates, unless dc->debug.using_dml2 is set.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |  12 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  14 +
 .../dc/bls_builder/dcn401_seamless_builder.c  | 462 +++++++++++++++---
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  71 ++-
 4 files changed, 487 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index 11e452b36e05..2fdac8415f31 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -150,7 +150,19 @@ struct dcn401_commit_step_meta {
 		bool scaling_unchanged;
 		/* funcs.pg_needs_ip_request() is false: no PG hook can gate. */
 		bool no_ip_request;
+		/* update_flags has no address update for the plane of the pipe. */
+		bool no_addr_update;
+		/*
+		 * update_flags change only plane addresses: the hardware is not
+		 * remapped and no pipe config changed.
+		 */
+		bool only_addresses_changed;
 	} skip_if;
+	/* Necessary conditions: the step is emitted only if each holds. */
+	struct {
+		bool hardware_not_remapped;
+		bool pipe_configs_not_changed;
+	} only_if;
 };
 
 struct dcn401_commit_step {
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
index 4af30178b42b..ee829acb3c78 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -125,6 +125,10 @@ struct dcn401_commit_step_args {
 	const struct dc_state_update_flags *update_flags;
 	/* stream is in both states on the same pipes, planes and blocks. */
 	bool stream_unchanged;
+	/* update_flags: a pipe of stream changes its blocks, plane or DET. */
+	bool hardware_remapped;
+	/* update_flags: a stream change or a non-address plane change. */
+	bool pipe_configs_changed;
 };
 
 /*
@@ -133,6 +137,9 @@ struct dcn401_commit_step_args {
  * of that state, the OTG master first. A builder lists its sub-sequences
  * in emission order. A sequence longer than DC2_BLS_MAX_STEPS keeps its
  * count and only the first entries; Core rejects it.
+ *
+ * A per-DPP-pipe sub-sequence can hold a group of named stages instead of
+ * steps. Each pipe then emits every stage before the next pipe starts.
  */
 #define DCN401_CURRENT_STATE			(1u << 0)
 #define DCN401_NEW_STATE			(1u << 1)
@@ -140,10 +147,17 @@ struct dcn401_commit_step_args {
 #define DCN401_PER_STREAM_PER_OPP_HEAD		(1u << 3)
 #define DCN401_PER_STREAM_PER_DPP_PIPE		(1u << 4)
 
+struct dcn401_stage {
+	const struct dcn401_commit_step *steps;
+	unsigned int count;
+};
+
 struct dcn401_sub_sequence {
 	uint32_t flags;
 	const struct dcn401_commit_step *steps;
 	unsigned int count;
+	const struct dcn401_stage *stages;
+	unsigned int stage_count;
 };
 
 /* The support check found an OTG master for each stream it expands. */
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index a2c8d7964208..850b5d8c96d4 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -39,7 +39,9 @@
  * post_unlock_program_front_end. Under the lock, a removed pipe leaves its
  * MPCC; after it, the pipe powers down. A kept pipe skips the first-enable
  * steps of enable_plane. The bandwidth lower stays with
- * dc_post_update_surfaces_to_stream.
+ * dc_post_update_surfaces_to_stream. When only the plane address of the
+ * stream changes, the update is a flip: it locks the pipe, programs the
+ * address and unlocks, with no DMUB command and no DMUB lock.
  *
  * This file also holds what both builders share: the dc and stream
  * support checks, and the step walkers that turn a table into BLS entries.
@@ -931,6 +933,159 @@ static bool check_no_dsc_change(const struct dc *dc,
 	} while (0)
 
 /* The updated stream: the one named, else the state's only stream. */
+
+static bool check_no_subvp(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	(void)dc;
+	(void)current_state;
+	return new_state->stream_status[i].mall_stream_config.type ==
+			SUBVP_NONE;
+}
+
+/*
+ * DC1 sends dirty rects to DMUB with PSR, Replay or an ABM level, and
+ * takes the DMUB HW lock around the flip with Replay or HWFQ.
+ */
+static bool check_no_dmub_work(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	const struct dc_stream_state *stream = new_state->streams[i];
+	const struct dc_link *link = stream->link;
+
+	(void)current_state;
+	(void)dc;
+	return link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
+			!link->replay_settings.config.replay_supported &&
+			!link->replay_settings.replay_feature_enabled &&
+			!stream->abm_level;
+}
+
+/*
+ * Each stream update flag adds a step: cursor, info frame, dither,
+ * gamut remap, output CSC, output transfer function and others.
+ */
+static bool check_no_stream_update_flags(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	(void)dc;
+	(void)current_state;
+	return !new_state->streams[i]->update_flags.raw;
+}
+
+/*
+ * Any other plane update bit adds a step to the flip. DC1 hands an
+ * offloaded flip to HWFQ. With triple-buffer flips, the pipe lock is not
+ * a TG_LOCK leaf.
+ */
+static bool check_one_address_only_plane(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	const struct dc_plane_state *plane;
+
+	(void)dc;
+	(void)current_state;
+	if (new_state->stream_status[i].plane_count != 1 ||
+			resource_get_opp_heads_for_stream(new_state->streams[i],
+			(struct resource_context *)&new_state->res_ctx,
+			dpp_pipes) != 1 ||
+			resource_get_dpp_pipes_for_stream(new_state->streams[i],
+			(struct resource_context *)&new_state->res_ctx,
+			dpp_pipes) != 1 ||
+			!dpp_pipes[0]->plane_state ||
+			!dpp_pipes[0]->plane_res.hubp)
+		return false;
+	plane = dpp_pipes[0]->plane_state;
+	return dc_check_address_only_update(plane->update_bits) &&
+			!plane->triplebuffer_flips;
+}
+
+static bool dcn401_pipe_on_either(const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int j,
+		const struct dc_stream_state *stream)
+{
+	return dcn401_pipe_on_stream(&current_state->res_ctx.pipe_ctx[j],
+			stream) ||
+			dcn401_pipe_on_stream(&new_state->res_ctx.pipe_ctx[j],
+			stream);
+}
+
+/* A pipe of the stream changes its blocks, its plane or its DET. */
+static bool dcn401_is_hardware_remapped(
+		const struct dc_state_update_flags *flags,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
+{
+	const struct dc_state_pipe_flags *cur, *new;
+	unsigned int j;
+
+	if (!flags || !stream)
+		return true;
+	for (j = 0; j < MAX_PIPES; j++) {
+		if (!dcn401_pipe_on_either(current_state, new_state, j, stream))
+			continue;
+		cur = &flags->cur_pipes[j];
+		new = &flags->new_pipes[j];
+		if (cur->enabled != new->enabled ||
+				cur->has_plane != new->has_plane ||
+				cur->det_size != new->det_size)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * dc_core flags a stream change, or a plane change other than its
+ * address, on a pipe of the stream.
+ */
+static bool dcn401_are_pipe_configs_changed(
+		const struct dc_state_update_flags *flags,
+		const struct dc_state *new_state,
+		const struct dc_stream_state *stream)
+{
+	struct pipe_update_bits bits;
+	int i = dcn401_stream_index(new_state, stream);
+	unsigned int j;
+
+	if (!flags || i < 0 || i >= MAX_STREAMS || flags->streams[i].raw)
+		return true;
+	for (j = 0; j < MAX_PIPES; j++) {
+		if (!dcn401_pipe_on_stream(&new_state->res_ctx.pipe_ctx[j],
+				stream))
+			continue;
+		bits = flags->new_pipes[j].plane;
+		bits.addr_update = 0;
+		if (dc_pipe_update_bits_is_any_set(&bits))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Each check rejects a state for which DC1 would make a call the flip
+ * does not emit.
+ */
+static enum bls_builder_result dcn401_check_flip(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	CHECK_UPDATE(no_subvp, "subvp is set");
+	CHECK_UPDATE(no_dmub_work, "psr, replay, abm or hwfq needs dmub");
+	CHECK_UPDATE(no_stream_update_flags, "stream update flags are set");
+	CHECK_UPDATE(one_address_only_plane,
+			"stream has odm, or not one plane with an address-only update");
+	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
+	CHECK_UPDATE(no_immediate_flip, "flip is immediate");
+	CHECK_UPDATE(no_mcm_luts, "an mcm lut is enabled");
+	return BLS_BUILD_SUCCESS;
+}
+
 static const struct dc_stream_state *dcn401_updated_stream(
 		const struct dc_state *new_state,
 		const struct dc_stream_state *stream)
@@ -969,6 +1124,18 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 
 	CHECK_UPDATE_FLAGS(streams_kept,
 			"a stream is not kept, or another stream changes");
+	if (!dcn401_is_hardware_remapped(update_flags, current_state,
+			new_state, new_state->streams[i]) &&
+			!dcn401_are_pipe_configs_changed(update_flags, new_state,
+			new_state->streams[i]))
+		return dcn401_check_flip(dc, current_state, new_state,
+				(unsigned int)i);
+	/* Without a new state, the update can only flip. */
+	if (current_state == new_state) {
+		dcn401_commit_check_failed(dc,
+				"state is kept and the update is not a flip");
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	}
 	return dcn401_check_stream_update(dc, current_state, new_state, i);
 }
 
@@ -1037,13 +1204,17 @@ enum bls_builder_result dcn401_check_stream_update(const struct dc *dc,
 static const struct dcn401_commit_step
 prepare_bandwidth[] = {
 	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
-	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
+	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
-	  .meta.hubbub_program_watermarks.safe_to_lower = false },
+	  .meta.hubbub_program_watermarks.safe_to_lower = false,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = HUBBUB_PROGRAM_ARBITER,
-	  .meta.hubbub_program_arbiter.safe_to_lower = false },
+	  .meta.hubbub_program_arbiter.safe_to_lower = false,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
-	  .meta.hubbub_program_compbuf_segments.safe_to_lower = false },
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = false,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 /*
@@ -1054,11 +1225,14 @@ prepare_bandwidth[] = {
  */
 static const struct dcn401_commit_step preamble[] = {
 	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
-	  .meta.skip_if.optimized_not_required = true },
+	  .meta.skip_if.optimized_not_required = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
-	  .meta.skip_if.optimized_not_required = true },
+	  .meta.skip_if.optimized_not_required = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE,
-	  .meta.skip_if.optimized_not_required = true },
+	  .meta.skip_if.optimized_not_required = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 /* Net effect: dcn401_program_outstanding_updates on the current state. */
@@ -1066,7 +1240,8 @@ static const struct dcn401_commit_step global_preamble[] = {
 	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
 	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true,
 	  .meta.hubbub_program_compbuf_segments.use_current_state_size = true,
-	  .meta.skip_if.optimized_not_required = true },
+	  .meta.skip_if.optimized_not_required = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 /*
@@ -1075,11 +1250,14 @@ static const struct dcn401_commit_step global_preamble[] = {
  */
 static const struct dcn401_commit_step pending[] = {
 	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 /*
@@ -1098,17 +1276,21 @@ static const struct dcn401_commit_step lock[] = {
 
 static const struct dcn401_commit_step dpp_lock[] = {
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = HUBP_PROGRAM_TRIPLEBUFFER,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 static const struct dcn401_commit_step first_hubp[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.hubbub_force_pstate_change_control.enable = true },
 	{ .func = DC_UDELAY,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 /*
@@ -1118,6 +1300,7 @@ static const struct dcn401_commit_step first_hubp[] = {
 static const struct dcn401_commit_step opp_unblank[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.opp_set_disp_pattern_generator.unblank = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
@@ -1125,18 +1308,23 @@ static const struct dcn401_commit_step opp_unblank[] = {
 static const struct dcn401_commit_step global_sync[] = {
 	{ .func = TG_PROGRAM_GLOBAL_SYNC,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_WAIT_FOR_STATE,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_SET_VTG_PARAMS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = TG_SETUP_VERTICAL_INTERRUPT2,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPTC_SET_ODM_COMBINE,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.pipe_deltas.odm_kept = true,
 	  .meta.skip_if.pipe_deltas_all = true },
@@ -1145,11 +1333,13 @@ static const struct dcn401_commit_step global_sync[] = {
 static const struct dcn401_commit_step opp_odm[] = {
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.pipe_deltas.odm_kept = true,
 	  .meta.skip_if.pipe_deltas_all = true },
 	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.pipe_deltas.odm_kept = true,
 	  .meta.skip_if.pipe_deltas_all = true },
@@ -1161,89 +1351,135 @@ static const struct dcn401_commit_step opp_odm[] = {
  */
 const struct dcn401_commit_step dcn401_disconnect[DCN401_DISCONNECT_STEPS] = {
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_REMOVE_MPCC,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 /* After the unlock, disable_plane on each removed pipe. */
 const struct dcn401_commit_step dcn401_power_down[DCN401_POWER_DOWN_STEPS] = {
 	{ .func = MPC_ASSERT_IDLE_MPCC,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_BLANK,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_UPDATE_MALL_SEL,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_FLIP_CONTROL_GSL,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_CLK_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_DPPCLK_CONTROL,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DC_IP_REQUEST_STATUS,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.no_ip_request = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.no_ip_request = true,
 	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DC_IP_REQUEST_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.dc_ip_request_cntl.enable = true,
 	  .meta.skip_if.no_ip_request = true,
 	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PG_CONTROL,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_RESET,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_RESET,
-	  .meta.skip_if.stream_unchanged = true, .meta.skip_if.pipe_deltas.current_has_no_plane = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DC_IP_REQUEST_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.dc_ip_request_cntl.enable = false,
 	  .meta.skip_if.no_ip_request = true,
 	  .meta.skip_if.pipe_deltas.current_has_no_plane = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
 /* enable_plane, then the watermark propagate and the DET segments. */
-static const struct dcn401_commit_step enable_plane[] = {
+/* Ungate and clock the HUBP and DPP of a pipe brought up. */
+static const struct dcn401_commit_step ungate_hw[] = {
 	{ .func = DC_IP_REQUEST_STATUS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
 	{ .func = DC_IP_REQUEST_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.dc_ip_request_cntl.enable = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
 	{ .func = HUBP_PG_CONTROL,
-	  .meta.skip_if.stream_unchanged = true, .meta.hubp_pg_control.power_on = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.hubp_pg_control.power_on = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DC_IP_REQUEST_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.dc_ip_request_cntl.enable = false,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.no_ip_request = true },
 	{ .func = HUBP_CLK_CNTL,
-	  .meta.skip_if.stream_unchanged = true, .meta.hubp_clk_cntl.enable = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.hubp_clk_cntl.enable = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_INIT,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_PIPE_CLOCK_CONTROL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
+};
+
+/* The DET, then update_dchubp_dpp up to the DPP bias and scale. */
+static const struct dcn401_commit_step setup_pipe_1[] = {
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.hubp_program_det_segments.allocate = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true,
 	  .meta.skip_if.pipe_deltas.det_unchanged = true,
@@ -1255,111 +1491,188 @@ static const struct dcn401_commit_step enable_plane[] = {
 	 * removed when the OPP tree already holds one.
 	 */
 	{ .func = DPP_DPPCLK_CONTROL,
-	  .meta.skip_if.stream_unchanged = true, .meta.dpp_dppclk_control.enable = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.dpp_dppclk_control.enable = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DCCG_UPDATE_DPP_DTO,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_VTG_SEL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SETUP2,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_UNBOUNDED_REQUESTING,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SETUP_INTERDEPENDENT2,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_SETUP_DPP,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = DPP_SET_CURSOR_MATRIX,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = DPP_PROGRAM_BIAS_AND_SCALE,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
+};
+
+/* Remove and insert the MPCC of the plane. */
+static const struct dcn401_commit_step reconfigure_mpc[] = {
 	{ .func = MPC_REMOVE_MPCC,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.opp_tree_empty = true },
 	/* insert_plane programs the blending; no update_blending follows. */
 	{ .func = MPC_INSERT_PLANE,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = MPC_UPDATE_VISUAL_CONFIRM,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
+};
+
+/* The scaler, viewport, MCACHE, gamut remap and surface config. */
+static const struct dcn401_commit_step setup_pipe_2[] = {
 	{ .func = DPP_SET_SCALER,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.scaling_unchanged = true },
 	{ .func = HUBP_MEM_PROGRAM_VIEWPORT,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.scaling_unchanged = true },
 	{ .func = HUBP_PROGRAM_MCACHE_ID,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
 			MPCC_MCM_FIRST_GAMUT_REMAP },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
 			MPCC_MCM_SECOND_GAMUT_REMAP },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_set_gamut_remap_bypass.block_id = MPCC_OGAM_GAMUT_REMAP },
 	{ .func = MPC_POWER_ON_MPC_MEM_PWR,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = MPC_SET_OCSC_DEFAULT,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 	{ .func = HUBP_PROGRAM_SURFACE_CONFIG,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
+};
+
+/*
+ * The plane address. On a flip, also the GSL and triple buffer of
+ * commit_planes_for_stream_fast; a new or reconfigured plane skips them.
+ */
+static const struct dcn401_commit_step program_flip[] = {
+	{ .func = HUBP_SET_FLIP_CONTROL_GSL,
+	  .meta.only_if.hardware_not_remapped = true,
+	  .meta.only_if.pipe_configs_not_changed = true,
+	  .meta.skip_if.no_addr_update = true },
+	{ .func = HUBP_PROGRAM_TRIPLEBUFFER,
+	  .meta.only_if.hardware_not_remapped = true,
+	  .meta.only_if.pipe_configs_not_changed = true,
+	  .meta.skip_if.no_addr_update = true },
 	{ .func = HUBP_UPDATE_PLANE_ADDR,
 	  .meta.skip_if.stream_unchanged = true },
+};
+
+/* Unblank, then the transfer functions and the OPP format. */
+static const struct dcn401_commit_step setup_pipe_3[] = {
 	{ .func = HUBP_SET_BLANK,
-	  .meta.skip_if.stream_unchanged = true, .meta.hubp_set_blank.unblank = true,
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
+	  .meta.hubp_set_blank.unblank = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	/* set_hdr_multiplier, the input and MCM transfer functions, the
 	 * output transfer function and the OPP format. First enable only.
 	 */
 	{ .func = DPP_SET_HDR_MULTIPLIER,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_SET_PRE_DEGAM,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = DPP_PROGRAM_GAMCOR_LUT,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_SET_MOVABLE_CM_LOCATION,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_1DLUT,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_SHAPER,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.mpc_program_lut_mode.id = MCM_LUT_3DLUT,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_3DLUT_FL_CONFIG,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_SET_3DLUT_FL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = MPC_SET_OUTPUT_GAMMA,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_SET_DYN_EXPANSION,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 	{ .func = OPP_PROGRAM_FMT,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.hubp_dpp_already_enabled = true },
 };
 
+static const struct dcn401_stage enable_plane[] = {
+	{ ungate_hw, ARRAY_SIZE(ungate_hw) },
+	{ setup_pipe_1, ARRAY_SIZE(setup_pipe_1) },
+	{ reconfigure_mpc, ARRAY_SIZE(reconfigure_mpc) },
+	{ setup_pipe_2, ARRAY_SIZE(setup_pipe_2) },
+	{ program_flip, ARRAY_SIZE(program_flip) },
+	{ setup_pipe_3, ARRAY_SIZE(setup_pipe_3) },
+};
+
+#define DCN401_ENABLE_PLANE_STEPS (ARRAY_SIZE(ungate_hw) + \
+		ARRAY_SIZE(setup_pipe_1) + ARRAY_SIZE(reconfigure_mpc) + \
+		ARRAY_SIZE(setup_pipe_2) + ARRAY_SIZE(program_flip) + \
+		ARRAY_SIZE(setup_pipe_3))
+
 /*
  * The pipe unlock, then dcn401_post_unlock_program_front_end: the
  * flip-pending wait, the p-state release and the MALL selection. Last,
@@ -1372,17 +1685,20 @@ static const struct dcn401_commit_step unlock[] = {
 
 static const struct dcn401_commit_step dpp_flip[] = {
 	{ .func = HUBP_WAIT_FLIP_PENDING,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 static const struct dcn401_commit_step pstate[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
-	  .meta.skip_if.stream_unchanged = true },
+	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true },
 };
 
 static const struct dcn401_commit_step dpp_mall[] = {
 	{ .func = HUBP_UPDATE_MALL_SEL,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.hubp_update_mall_sel.from_new_state = true },
 };
 
@@ -1390,6 +1706,7 @@ static const struct dcn401_commit_step dpp_mall[] = {
 static const struct dcn401_commit_step odm_wait[] = {
 	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
 	  .meta.skip_if.stream_unchanged = true,
+	  .meta.skip_if.only_addresses_changed = true,
 	  .meta.skip_if.pipe_deltas.odm_kept = true },
 };
 
@@ -1405,7 +1722,7 @@ static const struct dcn401_commit_step trigger[] = {
  * pipe as programmed. dcn401_add_step catches a longer sequence.
  */
 static_assert(ARRAY_SIZE(dcn401_disconnect) + ARRAY_SIZE(dcn401_power_down) <=
-		ARRAY_SIZE(dpp_lock) + ARRAY_SIZE(enable_plane) +
+		ARRAY_SIZE(dpp_lock) + DCN401_ENABLE_PLANE_STEPS +
 		ARRAY_SIZE(dpp_flip) + ARRAY_SIZE(dpp_mall),
 		"a removed pipe emits more than a programmed pipe");
 static_assert(
@@ -1425,7 +1742,7 @@ static_assert(
 		ARRAY_SIZE(trigger) +
 		DCN401_MAX_DPP_PIPES * (
 		ARRAY_SIZE(dpp_lock) +
-		ARRAY_SIZE(enable_plane) +
+		DCN401_ENABLE_PLANE_STEPS +
 		ARRAY_SIZE(dpp_flip) +
 		ARRAY_SIZE(dpp_mall)) <= DC2_BLS_MAX_STEPS,
 		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
@@ -2345,6 +2662,14 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 	struct dcn401_pipe_deltas deltas;
 	const struct pipe_ctx *cur, *new;
 
+	if (step->meta.skip_if.only_addresses_changed &&
+			!args->hardware_remapped && !args->pipe_configs_changed)
+		return true;
+	if (step->meta.only_if.hardware_not_remapped && args->hardware_remapped)
+		return true;
+	if (step->meta.only_if.pipe_configs_not_changed &&
+			args->pipe_configs_changed)
+		return true;
 	if (step->meta.skip_if.new_state_has_stream &&
 			args->new_state->stream_count)
 		return true;
@@ -2363,6 +2688,10 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 	cur = &args->current_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
 	new = &args->new_state->res_ctx.pipe_ctx[args->pipe->pipe_idx];
 	dcn401_eval_pipe_deltas(args, args->pipe->pipe_idx, &deltas);
+	if (step->meta.skip_if.no_addr_update &&
+			!args->update_flags->new_pipes[args->pipe->pipe_idx]
+			.plane.addr_update)
+		return true;
 	if (step->meta.skip_if.no_manual_trigger &&
 			(!args->pipe->plane_state->update_bits.addr_update ||
 			args->pipe->plane_state->skip_manual_trigger))
@@ -2447,12 +2776,11 @@ static void dcn401_add_per_opp_head(struct block_sequence_state *sequence,
 
 static void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
-		struct dc_state *state,
-		const struct dcn401_commit_step *steps, unsigned int count)
+		struct dc_state *state, const struct dcn401_sub_sequence *sub)
 {
 	struct dcn401_commit_step_args args = *state_args;
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
-	unsigned int i;
+	unsigned int i, k;
 	int j, n;
 
 	for (i = 0; i < state->stream_count; i++) {
@@ -2462,7 +2790,15 @@ static void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
 				&state->res_ctx, dpp_pipes);
 		for (j = 0; j < n; j++) {
 			args.pipe = dpp_pipes[j];
-			dcn401_add_steps(sequence, &args, steps, count);
+			if (!sub->stages) {
+				dcn401_add_steps(sequence, &args, sub->steps,
+						sub->count);
+				continue;
+			}
+			for (k = 0; k < sub->stage_count; k++)
+				dcn401_add_steps(sequence, &args,
+						sub->stages[k].steps,
+						sub->stages[k].count);
 		}
 	}
 }
@@ -2487,8 +2823,7 @@ void dcn401_add_sub_sequences(struct block_sequence_state *sequence,
 			dcn401_add_per_opp_head(sequence, state_args, state,
 					sub->steps, sub->count);
 		else if (sub->flags & DCN401_PER_STREAM_PER_DPP_PIPE)
-			dcn401_add_per_dpp_pipe(sequence, state_args, state,
-					sub->steps, sub->count);
+			dcn401_add_per_dpp_pipe(sequence, state_args, state, sub);
 		else
 			dcn401_add_steps(sequence, state_args, sub->steps,
 					sub->count);
@@ -2507,6 +2842,8 @@ void dcn401_init_and_unpack_params(
 	state_args->pipe = NULL;
 	state_args->update_flags = params->update_flags;
 	state_args->stream_unchanged = false;
+	state_args->hardware_remapped = true;
+	state_args->pipe_configs_changed = true;
 
 	params->head_num_steps = 0;
 	params->tail_num_steps = 0;
@@ -2517,8 +2854,10 @@ void dcn401_init_and_unpack_params(
 /*
  * The waits and the bandwidth raise, then the updated stream only.
  * skip_if drops the steps a kept pipe or ODM layout does not need, so
- * every transition is the same table. The enable_plane list runs per DPP
- * pipe, top pipe first, so the top MPCC is inserted before the bottom one.
+ * every transition is the same table. Each DPP pipe runs every
+ * enable_plane stage before the next pipe, top pipe first, so the top
+ * MPCC is inserted before the bottom one. A flip runs only the lock,
+ * program_flip, the unlock and the trigger.
  */
 static const struct dcn401_sub_sequence bls_update_head[] = {
 	{ .flags = DCN401_CURRENT_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
@@ -2559,8 +2898,8 @@ static const struct dcn401_sub_sequence bls_stream_update[] = {
 	  .steps = opp_odm,
 	  .count = ARRAY_SIZE(opp_odm) },
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_DPP_PIPE,
-	  .steps = enable_plane,
-	  .count = ARRAY_SIZE(enable_plane) },
+	  .stages = enable_plane,
+	  .stage_count = ARRAY_SIZE(enable_plane) },
 	{ .flags = DCN401_NEW_STATE | DCN401_PER_STREAM_PER_OTG_MASTER,
 	  .steps = unlock,
 	  .count = ARRAY_SIZE(unlock) },
@@ -2608,6 +2947,11 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	dcn401_init_and_unpack_params(params, &state_args, &head);
 	state_args.stream = dcn401_updated_stream(params->new_state,
 			params->stream);
+	state_args.hardware_remapped = dcn401_is_hardware_remapped(
+			params->update_flags, params->current_state,
+			params->new_state, state_args.stream);
+	state_args.pipe_configs_changed = dcn401_are_pipe_configs_changed(
+			params->update_flags, params->new_state, state_args.stream);
 	DCN401_ADD_SUB_SEQUENCES(&head, &state_args, bls_update_head);
 	dcn401_add_stream_update(&head, &state_args);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index c4e1fef8266e..245ebd8e01d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -247,7 +247,7 @@ static void core2_update_prepare(struct dc *dc, struct dc_state *context,
 }
 
 static void core2_update_done(struct dc *dc, struct dc_state *context,
-		struct dc_stream_state *stream);
+		struct dc_stream_state *stream, enum dc_update_type update_type);
 
 /* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
 enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
@@ -297,7 +297,8 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 
 		if (dcn401_stream_kept(dc, current_state, context,
 				context->streams[i]))
-			core2_update_done(dc, context, context->streams[i]);
+			core2_update_done(dc, context, context->streams[i],
+					UPDATE_TYPE_FULL);
 		else if (otg_master)
 			core2_commit_enable_done(otg_master);
 	}
@@ -331,6 +332,30 @@ static bool core2_stream_update_supported(
 			!(update->wb_update && update->wb_update->num_wb_info);
 }
 
+/* Each surface of the update is a plane of the stream in the new context. */
+static bool core2_surfaces_supported(
+		const struct dc_update_scratch_space *scratch)
+{
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, j, n;
+
+	if (!scratch->surface_updates)
+		return false;
+	n = resource_get_dpp_pipes_for_stream(scratch->stream,
+			&scratch->new_context->res_ctx, dpp_pipes);
+	if (n != scratch->surface_count)
+		return false;
+	for (i = 0; i < scratch->surface_count; i++) {
+		for (j = 0; j < n; j++)
+			if (dpp_pipes[j]->plane_state ==
+					scratch->surface_updates[i].surface)
+				break;
+		if (j == n)
+			return false;
+	}
+	return true;
+}
+
 static bool core2_update_state_supported(
 		const struct dc_update_scratch_space *scratch)
 {
@@ -338,15 +363,22 @@ static bool core2_update_state_supported(
 	if (!scratch->stream || !scratch->update_v3 || scratch->probe_updates)
 		return false;
 	/*
-	 * Only a full update on a new context has a builder. A context-full
-	 * flow keeps dc->current_state, so its update type is below FULL.
+	 * The builder takes both states: a full update on a new context, or
+	 * a fast update on the kept one. A context-full flow keeps
+	 * dc->current_state with an update type below FULL, and has no
+	 * builder.
 	 */
-	if (scratch->update_type != UPDATE_TYPE_FULL ||
-			scratch->flow != UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS)
+	if (!(scratch->update_type == UPDATE_TYPE_FULL &&
+			scratch->flow == UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS) &&
+			!(scratch->update_type == UPDATE_TYPE_FAST &&
+			scratch->flow == UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST &&
+			scratch->new_context == scratch->dc->current_state))
 		return false;
-	/* The full-update builder adds one or two planes, or keeps one. */
+	/* The builder adds one or two planes, keeps them, or flips one. */
 	if (scratch->surface_count != 1 && scratch->surface_count != 2)
 		return false;
+	if (!core2_surfaces_supported(scratch))
+		return false;
 	if (!core2_stream_update_supported(scratch->stream_update))
 		return false;
 	return core2_builder_supports(scratch->dc, DCN_DECL_SEAMLESS_UPDATE,
@@ -355,11 +387,11 @@ static bool core2_update_state_supported(
 
 /*
  * The software state commit_planes_for_stream writes while it programs
- * the plane. The swap to the new context stays in
- * dc_update_state_cleanup.
+ * the plane, and that the HUBP_UPDATE_PLANE_ADDR entry does not write.
+ * The swap to the new context stays in dc_update_state_cleanup.
  */
 static void core2_update_done(struct dc *dc, struct dc_state *context,
-		struct dc_stream_state *stream)
+		struct dc_stream_state *stream, enum dc_update_type update_type)
 {
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 	struct pipe_ctx *pipe;
@@ -389,7 +421,9 @@ static void core2_update_done(struct dc *dc, struct dc_state *context,
 		hubp->mpcc_id = hubp->inst;
 		hubp->power_gated = false;
 	}
-	core2_commit_prepare_done(dc, context);
+	/* DC1 prepares bandwidth only on a full update. */
+	if (update_type == UPDATE_TYPE_FULL)
+		core2_commit_prepare_done(dc, context);
 }
 
 static void core2_update_state_execute(
@@ -400,14 +434,25 @@ static void core2_update_state_execute(
 	struct pipe_ctx *pipe = resource_get_otg_master_for_stream(
 			&context->res_ctx, scratch->stream);
 
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n;
+
 	if (!pipe || !pipe->plane_state)
 		return;
-	core2_update_prepare(dc, context, scratch->stream);
+	if (scratch->update_type != UPDATE_TYPE_FAST)
+		core2_update_prepare(dc, context, scratch->stream);
+	if (!dc->debug.using_dml2) {
+		n = resource_get_dpp_pipes_for_stream(scratch->stream,
+				&context->res_ctx, dpp_pipes);
+		for (i = 0; i < n; i++)
+			set_p_state_switch_method(dc, context, dpp_pipes[i]);
+	}
 
 	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context,
 			scratch->stream) != DC_OK) {
 		ASSERT(false);
 		return;
 	}
-	core2_update_done(dc, context, scratch->stream);
+	stream_update_flags_clear(&scratch->stream->update_flags);
+	core2_update_done(dc, context, scratch->stream, scratch->update_type);
 }
-- 
2.43.0

