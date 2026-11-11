Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD11606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OKv5Zu8f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D9910F8E8;
	Wed, 11 Nov 2026 01:43:59 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360F710F8E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2Dmi14Ql8Om1VpVuY+2mwnySbyO0aAx4JepSQxCN0pX+mS1bbxwLUdCsnWbIArLIzkpjiYzvNx4OkpYwpkeXfH4xZ81TYruuirRkMM3sP5Elg4VKo6PZm8YcKDuVTpz7vfEmwVzQW/1GmGzNqUqXUZzsRGzMZOKGqLrjzCCuToEvap+TWxpom2WptFW8ZipsG3sNPdXhxkLDWwYiifD7VfTYs6JHXAaE7J8+UduzU5BLa9szQ9Apax6bdDcOSLiY11oCpMUjf+LonL0iskx8KpKLJKN+8nqrCESZpf3ujQgbLc01tHNcHhaBA3MhZWsyOXK2xHhrJDGZM2vG78xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h76LWT+TcGTc8a/5TAPwOWTReb1/nGT0b7uhZ+8dfSQ=;
 b=xXEs/gNOditE8Wh8cm0O4VurZeNBRU8QYXeoWiOlAz/qItZ1C1Kpdt5UUElqXCjh8RUy9EMSVDBIdbZLjbe6eMTKutTV8UozyeeN108WfY4c9ytguZQiEeYKbQrdIEnqIAIN7iyONsRWw1+KV+vLtUy2KXDgnsvujsJsHPzJq0H2Cc+PTKu4kQH9394/Fdi0v9OB8Tfq5jCaujegdcAULlTRa0CfVfycOmqsftJ/D2umSDnQG2Asu8AqXjIXRyaqeQAKs+lVLjyftEcXtD4ZH5D/Ww6G+TsPZny+QEAprTnFxBve1S/2aQNbjv4oaw6UT/xJyqZ5tFHl0kJZWL/ojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h76LWT+TcGTc8a/5TAPwOWTReb1/nGT0b7uhZ+8dfSQ=;
 b=OKv5Zu8fKwaE11BTQXwsMMsxSiOXWFfGCBCQKiJxYDK/NMUC9iivQ2LwUQ3+lLnrAuwMpGaO67URJhR3dR6QchQbvmLDS5kEOt/8b0rjaVNZJ3NAZr9MUy2cSeff4gRMf+AbuUnoAVexc2HLlyb7MMKcZ/S8i+eW5pQVUF0C7jw=
Received: from CY5P221CA0161.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::15)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 01:43:43 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::30) by CY5P221CA0161.outlook.office365.com
 (2603:10b6:930:6a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 01:43:43 +0000
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
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:42 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:38 -0600
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
Subject: [PATCH 51/74] drm/amd/display: Program the kept-plane scaler in DC2
Date: Wed, 11 Nov 2026 09:28:57 +0800
Message-ID: <20261111014100.3596072-52-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b8d637-ea03-4c47-6851-08df3f9537f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: iPKlak/IcE8hZpS9NoZyJkVVmaCC1VZB6pz3BdcAfPwj2c6pmH2uEENB2ynnECoRLZ0eiR2Bj9nQe1d/zu0rOGD9BwJLkyGKR6HPTNVKPmqTPt/X8K9BJH8krr/50uFtVg4UyTMFLbYjMlFfmNGjl920MkPF/IxZCkbIQjO0M2wzAEnYLS35i5fK34opfWBCZhAkxvBExLjgOjxuUvOHxj/0avcA2lg1l9hpG6OTyrHFU12EyuSqll0CcWWI+oSUlb+3oEOPxFqFkNYGXKxSvfRtdWAQyjUEmvJQakdn/e8lhS9WwSS+V3czrbSpK46hSS4oN2LlceZZe2ZMrw4niM5gmGTUufQ69PbrNjlLQIigAQC2y5Jm6ctSbiTFgp2dFoo/i9pPgZSC1hbhr105oeI76lI8yAiWJVsaM641LIOyubScVN+wkxpoF4Pku7hiSL153sZc/HDZPSl31xTnsUWiyn2/9zQlnJf0mQrPd9WItcabsGXtCc7euvDf4Lb7f/31wYh785ze+BajCr6a0sDVxDgNWcqNT3Lqimw/XHIpEQ5nFy2uoPP1K1Levnp8XEG8k9bUTUf+7Cjgw6jGxCqKTLiiX/PCiiuWgXcfY/3v4xTqtnkFltpMblc9YT3MzS6w/IZJcpLXI6CSiHD3heYLHKIJlfCypj2LRDzG7CyLbtZzEFGwrOojG0aWfwW9MLqYvj3sBbKcwq/RvIB+VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TtJMlaEQMpLqd8OiRZIB7TUQGfdBxuubBvLooudjJXvDLBaI1pphxp1vR2lDBECvTAnkT9aV6GmIjewR0ALW/7efG8KvG5ZjE/2wHrH26YXLARP5ms4G6s+VDaNmuUZSZerYnanMRWCaDGn1+GwvsWNGnaK6H1k3n/baIERLjFrUapnUmCALLqr7XY3tmm2zy7R1G9iIg5SXCOwPg1aMVKVUBHmYRBJahud7ypyuAcXhYjcOi3XhnjtpAAihCEYSSjBM5xRYDBcwMMgFvVV4Gn0upskoHvwArkVS+Splh3FYPlfy4A0pRVhHDrT+aii+SiXHrDGz5Zt0IP1sTwEEQoNjQpurrHVfMgdaJil+dxkknlcDaH7wa8rhwxayP0SdOXUzMhLPm6j8wB1PESWlyLgrDsamjDf5yuWXYlpqGibVSGLucn+znzHO5McC4WD6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:42.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b8d637-ea03-4c47-6851-08df3f9537f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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
A full update that keeps one plane and changes its scaling or its
viewport is rejected on DCN4. The builder rejects every rect change.

[How]
Remove the rect change check. Program the DPP scaler and the HUBP
viewport when the plane scaling, the plane position or the stream
scaling changes. A full update sets every plane update bit, so a new
plane also programs both.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |  6 +++
 .../dc/bls_builder/dcn401_commit_builder.c    | 54 ++++++-------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index df86ff7d4867..0e6733eba83d 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -122,6 +122,12 @@ struct dcn401_commit_step_meta {
 		 * enabling that block the first time, not of reconfiguring it.
 		 */
 		bool hubp_dpp_already_enabled;
+		/*
+		 * Neither the plane scaling, the plane position nor the
+		 * stream scaling changed. A full update sets every plane bit,
+		 * so a plane add always programs the scaler and viewport.
+		 */
+		bool scaling_unchanged;
 	} skip_if;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index d071768bda03..ab84e8fded1d 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -34,10 +34,10 @@
  * bandwidth lower, so no tail is needed.
  *
  * DCN_DECL_SEAMLESS_UPDATE either adds one plane to that stream, or keeps
- * one plane and programs its surface and address. The sequence follows
- * the full update in commit_planes_for_stream on dcn401, all in
- * head_sequence: the outstanding updates, prepare_bandwidth and the
- * pending-update waits, then the locked front-end programming and
+ * one plane and programs its surface, address, scaler and viewport. The
+ * sequence follows the full update in commit_planes_for_stream on dcn401,
+ * all in head_sequence: the outstanding updates, prepare_bandwidth and
+ * the pending-update waits, then the locked front-end programming and
  * post_unlock_program_front_end. A kept-plane update skips enable_plane
  * and the stream unblank. The bandwidth lower stays with
  * dc_post_update_surfaces_to_stream.
@@ -621,7 +621,7 @@ static bool dcn401_is_plane_kept(const struct dc_state *current_state,
 
 /*
  * The seamless update either adds the first plane, or keeps one plane and
- * programs its surface and address. Scaling and viewport stay rejected.
+ * programs its surface, address, scaler and viewport.
  */
 static bool check_plane_add_or_kept(const struct dc *dc,
 		const struct dc_state *current_state,
@@ -784,34 +784,6 @@ static bool check_no_flip_int(const struct dc *dc,
 			!pipe->plane_state->flip_int_enabled;
 }
 
-/*
- * A kept-plane update does not yet emit scaler or viewport steps. Plane
- * add has no current plane, so those rects are not compared.
- */
-static bool check_no_scale_or_viewport(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	const struct pipe_ctx *current_pipe = dcn401_otg_of(current_state);
-	const struct pipe_ctx *new_pipe = dcn401_otg_of(new_state);
-	const struct dc_plane_state *current_plane;
-	const struct dc_plane_state *new_plane;
-
-	(void)dc;
-	if (dcn401_is_plane_add(current_state, new_state))
-		return true;
-	if (!current_pipe || !new_pipe || !current_pipe->plane_state ||
-			!new_pipe->plane_state)
-		return false;
-	current_plane = current_pipe->plane_state;
-	new_plane = new_pipe->plane_state;
-	return !memcmp(&current_plane->src_rect, &new_plane->src_rect,
-			sizeof(current_plane->src_rect)) &&
-			!memcmp(&current_plane->dst_rect, &new_plane->dst_rect,
-					sizeof(current_plane->dst_rect)) &&
-			!memcmp(&current_plane->clip_rect, &new_plane->clip_rect,
-					sizeof(current_plane->clip_rect));
-}
 
 /* The update bypasses the plane gamut remap. */
 static bool check_no_plane_gamut_remap(const struct dc *dc,
@@ -1017,8 +989,6 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
 	CHECK_CONDITION(plane_instances, "mpcc or dpp is not the hubp instance");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
-	CHECK_CONDITION(no_scale_or_viewport,
-			"scaling or viewport changes");
 
 	/* Under the lock, before the pipe is programmed. */
 	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
@@ -1347,8 +1317,9 @@ static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
 
 /*
  * update_dchubp_dpp. First enable runs the whole table. A reconfigure
- * skips the steps that only bring the HUBP/DPP up, and removes the MPCC
- * when the OPP tree already holds one.
+ * skips the steps that only bring the HUBP/DPP up, and programs the
+ * scaler and viewport only when scaling or position changed. The MPCC is
+ * removed when the OPP tree already holds one.
  */
 static const struct dcn401_commit_step
 		bls_update_head_new_update_dchubp_dpp[] = {
@@ -1373,9 +1344,9 @@ static const struct dcn401_commit_step
 	{ .func = MPC_INSERT_PLANE },
 	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
 	{ .func = DPP_SET_SCALER,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.scaling_unchanged = true },
 	{ .func = HUBP_MEM_PROGRAM_VIEWPORT,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.scaling_unchanged = true },
 	{ .func = HUBP_PROGRAM_MCACHE_ID },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
@@ -2289,6 +2260,11 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			args->current_state->stream_count &&
 			args->current_state->stream_status[0].plane_count)
 		return true;
+	if (step->meta.skip_if.scaling_unchanged &&
+			!args->pipe->plane_state->update_bits.scaling_change &&
+			!args->pipe->plane_state->update_bits.position_change &&
+			!args->pipe->stream->update_flags.bits.scaling)
+		return true;
 	return false;
 }
 
-- 
2.43.0

