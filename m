Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30712C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854BB10F20A;
	Tue, 12 Mar 2024 09:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="202jtLzp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44F410F20A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKusDYBboOAOkPDWf4Qoi/P+vSxTy4WgM+Psl3tjWgbxmbizWzEIAVazryBjJNpwwt2g1izzTi3u5UwRhqPs13OXv9lAhg3rLmuhR1/xtFj74/mjasAxoYL8N+TM+DgyPIOE7fGXVSRJ5JcwHHJWz8a4Dq21jr0c3Uy62Bpzl+9Va70/JfWbtpcyOMJoMTJ7wgq84uOkQyuYFOuFCFpkhX9rlkPU586C2Vh+v8uu4T021W4rHl3Ij5ISijQcO8VTZTUd3esngQpU/9uMOQRtEfYlLBnIAjRNI1DHm2gcIhAFsmRSOgTVVnBjzZUc1kmTPK8Gt87Sw/3Br/EXhewkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlDTTubYr09i0Fa8KRML5WE9ylrkZS2JHzKqn6uFK4w=;
 b=dPqwibQVPOpGPeDT10GYmkXgDcaa14PhSVzpx9/zV/msxZNb1MntkoQsoDKpld7xFJSGDw24P2L7aV0iO3yqUeA0ewT3lmFzmsYksqB/qBLOus/ttLERTcjTw9ocX8Dh+wmsvROiO0v0IotpzjkkbCCSRpYcYdjgwSaO1QN5hhu+X1wmswJd96J1XHB29ANCFANnheWgEv53KfADDBvTImZUADar13+4c20hmrXAtpeDIuqeuEtPa7IHl7/Pzcf1nPTZIIH1jYceTIXeKTPVfcYoMLlb/FdjolfBONxm3pmxLEvCxQR9jfpeu/8JykaSFXE7Xz6jAoIQIIK8PyNDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlDTTubYr09i0Fa8KRML5WE9ylrkZS2JHzKqn6uFK4w=;
 b=202jtLzpw1OlBME0CQltRVOzlOHHUj+B215wxCouXZIvy2tC41YJocbVWX8WhtsVLzE3yV7sLxd3cs54ag8ujwpQibDr86UbK10H0uS17G5T131sFOFtBY9+9U3I0mAZaX5HGC5/1YvG9BHs5/EB9VaQ7he5Mri1es4B5ZXO2xs=
Received: from CH0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:b0::23)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 09:22:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::6e) by CH0PR03CA0018.outlook.office365.com
 (2603:10b6:610:b0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:23 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:18 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 14/43] drm/amd/display: skip forcing odm in minimal transition
Date: Tue, 12 Mar 2024 17:20:07 +0800
Message-ID: <20240312092036.3283319-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fd2930-54d1-4e29-a5f7-08dc4275ef46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYP1r3947ws/36yzY6JbAmrPNH7hV/n3AC72VMQuLhyppuR225hbxnJDAqIAyLVqkp6p8ssEO3/uW6t/xLGnb+5PdGsp3TDOholKxYrgUp2KpAB8mUSp0+1oZkRPDACC9AitSuPydHEyWeLvpbWrc7MPqPs++XXHjDRbGhJv0kIBQWd2CbKrIccqN1ydgw6krvGqpt/iiHs1vXie2zkdi7YYY12YxStLWsHYf0pwx+Guj4AkrukM2p1sODpjtev5S3/jhgeasBMUOCP2Fa1/RpQ9e8wMiBT6G8hGTFBTwM7IuWXkhS1mPrVvM74h9Q48CG4MZ/fZBpxfM67aV1yFtOHlZ2NjyRktr6kt0h2KrReQtrUgv4iSoKXHH8QJWLAxHuwy/eAoGb1gB8xiPGgyEXTdIUdye8nQA5ij8oe8M2ABlVeWzVfQGEGa3GdK7mxKLydUSEirli2mqGT+I4Ake3cyWK5yU17VD9HV2rlxqVxlJ9lGxTsE3VY+xJZ+0rENygrndS9sLu4VUXwnDbu16It0ETO8//MpVlxAPWtZIvwRKNcSecEKBDXxg6TRMBCLLz7ntgu0ctM1gf1xpO7xRme5ZOMrgh5dlLJlgILePxqCEPgL4v9qpLMqav8+6ygc8EDZRYDt9TEL0FFNLhegs8xqhCu/Es2Vfy2wM+3k2E/nma18nd8jKtRLablMZEMysQiFv8V0zlF3AAT/Co4/++/gsCfvnslewKaQHTeD24sxpYNCDAxlGXeIckl3XYcb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:27.1821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fd2930-54d1-4e29-a5f7-08dc4275ef46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In minial transitions state, ODM combine shouldn't be forced as it will
make transition non seamless. The force ODM debug option is to control
the end result not the intermediate transition. So we can temporarily
disable ODM forcing when committing minimal transition state.

[how]
Backup stream ODM forcing option and clear it in minimal transition
state. Once minimal transition state is released, we will restore the
original debug option back.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 97 ++++++++++++++++--------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2105e4ba3384..ad969e1dd427 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4162,55 +4162,88 @@ struct pipe_split_policy_backup {
 	bool dynamic_odm_policy;
 	bool subvp_policy;
 	enum pipe_split_policy mpc_policy;
+	char force_odm[MAX_PIPES];
 };
 
-static void release_minimal_transition_state(struct dc *dc,
-		struct dc_state *context, struct pipe_split_policy_backup *policy)
+static void backup_and_set_minimal_pipe_split_policy(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_split_policy_backup *policy)
 {
-	dc_state_release(context);
-	/* restore previous pipe split and odm policy */
+	int i;
+
+	if (!dc->config.is_vmin_only_asic) {
+		policy->mpc_policy = dc->debug.pipe_split_policy;
+		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	}
+	policy->dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
+	dc->debug.enable_single_display_2to1_odm_policy = false;
+	policy->subvp_policy = dc->debug.force_disable_subvp;
+	dc->debug.force_disable_subvp = true;
+	for (i = 0; i < context->stream_count; i++) {
+		policy->force_odm[i] = context->streams[i]->debug.force_odm_combine_segments;
+		context->streams[i]->debug.force_odm_combine_segments = 0;
+	}
+}
+
+static void restore_minimal_pipe_split_policy(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_split_policy_backup *policy)
+{
+	uint8_t i;
+
 	if (!dc->config.is_vmin_only_asic)
 		dc->debug.pipe_split_policy = policy->mpc_policy;
-	dc->debug.enable_single_display_2to1_odm_policy = policy->dynamic_odm_policy;
+	dc->debug.enable_single_display_2to1_odm_policy =
+			policy->dynamic_odm_policy;
 	dc->debug.force_disable_subvp = policy->subvp_policy;
+	for (i = 0; i < context->stream_count; i++)
+		context->streams[i]->debug.force_odm_combine_segments = policy->force_odm[i];
+}
+
+static void release_minimal_transition_state(struct dc *dc,
+		struct dc_state *minimal_transition_context,
+		struct dc_state *base_context,
+		struct pipe_split_policy_backup *policy)
+{
+	restore_minimal_pipe_split_policy(dc, base_context, policy);
+	dc_state_release(minimal_transition_context);
+	/* restore previous pipe split and odm policy */
+}
+
+static void force_vsync_flip_in_minimal_transition_context(struct dc_state *context)
+{
+	uint8_t i;
+	int j;
+	struct dc_stream_status *stream_status;
+
+	for (i = 0; i < context->stream_count; i++) {
+		stream_status = &context->stream_status[i];
+
+		for (j = 0; j < stream_status->plane_count; j++)
+			stream_status->plane_states[j]->flip_immediate = false;
+	}
 }
 
 static struct dc_state *create_minimal_transition_state(struct dc *dc,
 		struct dc_state *base_context, struct pipe_split_policy_backup *policy)
 {
 	struct dc_state *minimal_transition_context = NULL;
-	unsigned int i, j;
 
 	minimal_transition_context = dc_state_create_copy(base_context);
 	if (!minimal_transition_context)
 		return NULL;
 
-	if (!dc->config.is_vmin_only_asic) {
-		policy->mpc_policy = dc->debug.pipe_split_policy;
-		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-	}
-	policy->dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
-	dc->debug.enable_single_display_2to1_odm_policy = false;
-	policy->subvp_policy = dc->debug.force_disable_subvp;
-	dc->debug.force_disable_subvp = true;
-
+	backup_and_set_minimal_pipe_split_policy(dc, base_context, policy);
 	/* commit minimal state */
 	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false)) {
-		for (i = 0; i < minimal_transition_context->stream_count; i++) {
-			struct dc_stream_status *stream_status = &minimal_transition_context->stream_status[i];
-
-			for (j = 0; j < stream_status->plane_count; j++) {
-				struct dc_plane_state *plane_state = stream_status->plane_states[j];
-
-				/* force vsync flip when reconfiguring pipes to prevent underflow
-				 * and corruption
-				 */
-				plane_state->flip_immediate = false;
-			}
-		}
+		/* prevent underflow and corruption when reconfiguring pipes */
+		force_vsync_flip_in_minimal_transition_context(minimal_transition_context);
 	} else {
-		/* this should never happen */
-		release_minimal_transition_state(dc, minimal_transition_context, policy);
+		/*
+		 * This should never happen, minimal transition state should
+		 * always be validated first before adding pipe split features.
+		 */
+		release_minimal_transition_state(dc, minimal_transition_context, base_context, policy);
 		BREAK_TO_DEBUGGER();
 		minimal_transition_context = NULL;
 	}
@@ -4298,7 +4331,7 @@ static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
 			success = true;
 		}
 		release_minimal_transition_state(
-				dc, intermediate_context, &policy);
+				dc, intermediate_context, new_context, &policy);
 	}
 	return success;
 }
@@ -4344,7 +4377,7 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 			success = true;
 		}
 		release_minimal_transition_state(dc, intermediate_context,
-				&policy);
+				dc->current_state, &policy);
 	}
 	/*
 	 * Restore stream and plane states back to the values associated with
@@ -4471,7 +4504,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			transition_base_context, &policy);
 	if (transition_context) {
 		ret = dc_commit_state_no_check(dc, transition_context);
-		release_minimal_transition_state(dc, transition_context, &policy);
+		release_minimal_transition_state(dc, transition_context, transition_base_context, &policy);
 	}
 
 	if (ret != DC_OK) {
-- 
2.37.3

