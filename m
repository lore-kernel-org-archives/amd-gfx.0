Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01905C47257
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C876F2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OOkHmTZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C876F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874DA6E1D2;
	Sat,  2 May 2020 21:35:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3616E1D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I31YE611LWk9Zdlt3cY8rUob279U0pgWzUcdJnIR4/EPogE+xs+sqSlxalPiiY4wB9M0wAeczCbow2IEj7/zvzpSqnGssf6MJ9h7C8RXPK9Gdlw9lZrR6SpwZ5Yul6vMCkyV7SMWY6PPJfk8PM2KydyLBd3wsmW89ZCQd+VmySDdWcigV1pJZDOxFvk/QcokvHb5M6lDeqGflPJht0auCiwAsJuM9pY4g6xdxL3+8mrVKsa9FTsMe3uclAHy/kHZgMiuZUsPRY34dBSDNPkMGs3Ikvn76L45v4t8hl3XBGuRE0YKNdo2OD8xat0hovd/3kVG2Npm7Qcep5fjFHY+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JP3pA+NmwBayhYGNQszbd6ccwvwG3YX8rUWErxzzOc=;
 b=NfqH0VmRcWwl2SpkhHG/eQA87VUlZBTu4PMJmo9ofxfLTqp59pC+X7/RU+L51O+yy0V1c4N3EVnhrHYZCSOxOQS19ajAxS7MkUNdQzPBKKMYMsAeQZIeaHmVFKrsbqRQ9aF6cLJ9hYxn2H6EBO7rdAWmuWeoxVXgz23zzxzXrzja7cGPwcmr2RGPXmoiLS77kI30EGG/CNbqs2dyed07LYSd3dYwySiPWgj4WnvlJuUMBmxUnN24LoOxf0Oegakg2IDR99sl9Q+3XAIO+MM3T5FDkhp7ra3k6tXF1Ta0I8q6Ddgt+EZKOKQ6WKR43pwsjLAGZ7eqVG/Q52OA9ZpBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JP3pA+NmwBayhYGNQszbd6ccwvwG3YX8rUWErxzzOc=;
 b=OOkHmTZgj2pm1gNj1a5nc7+XIUOXfGlKlLbVZNBMs+7nOZmIQz/AILjplxSAzEeNIt0A0RFqPxQKYfV+wWsFviRI9W1KR+onGcuaCo7r5tCNWMc69U8wgzAYHJXbgUW5y8m4A8y3bkPO4LX98AEt3vtUBMnxPfYynvfVF5EBMMI=
Received: from MWHPR1601CA0006.namprd16.prod.outlook.com
 (2603:10b6:300:da::16) by BN7PR12MB2753.namprd12.prod.outlook.com
 (2603:10b6:408:31::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 21:34:58 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::61) by MWHPR1601CA0006.outlook.office365.com
 (2603:10b6:300:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:55 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Add 4 to 1 MPC split support
Date: Sat, 2 May 2020 17:34:37 -0400
Message-ID: <20200502213443.39232-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(6916009)(81166007)(356005)(82310400002)(7696005)(5660300002)(82740400003)(2906002)(1076003)(478600001)(47076004)(86362001)(6666004)(70206006)(36756003)(4326008)(8676002)(44832011)(8936002)(186003)(26005)(2616005)(54906003)(70586007)(336012)(316002)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37cc9c2-2824-448c-5c2c-08d7eee0a9aa
X-MS-TrafficTypeDiagnostic: BN7PR12MB2753:
X-Microsoft-Antispam-PRVS: <BN7PR12MB275313ADCC3DD8DDE394B3FA8BA80@BN7PR12MB2753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Z8kul5x9PWiIIcW4uivjnKuuMCs+mI67TTUStk+iPdwzZEt6uO49kaW2KI1QRo1EOU89z3KyjziLKje/Lgl6HNvyf8dh538C0fK9DhaAUc7Kdr4+Qke6oQRg4m+5OcR+2Bhxtx9gUzIVnpMPzpC4gFg866BNlQTUtnw6i4Xu07q+nkw97ao1YdVA3vMFSeFAj6syjyDbHZw/zugWO2o6Rw/IFhLOdJ/JnSCo1KITSFqOHMe7NH5EzKo05Hxe7lZ2/YASdLgftOzZj4lzLtWi+Z4KGv3lMLICOgT9ih6IiGuFJmCeG4s2b/Xxnx1RCjS4s8n7yFqeTZvlipZdkzqmMpb0iEHGiHRzHPEcjZRGQHzS45X4MRAo1qtrCUPjqViNb9I4TEWYb3avrR+jhmg4iqURzSriXv9qN+q4ajZWimzHcSyJlHnhv18zevi7SLhqy0cvP5Y/xQzYbGVS3S9rrFiFWgv4Df8ggWpKVgEUOmxnk2xWvrO3XeO8hwGcQM6YNB2gfH8MkSWhxMXBluZxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:58.1114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37cc9c2-2824-448c-5c2c-08d7eee0a9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2753
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Want to make use of detile buffer of all 4 pipes to maximize amount of
data stored to hide certain memory latency cases.

[How]
In case of 1 plane and 1 stream, program 4 pipes to each retrieve 1/4 of
plane later mixed together by the MPCs. Added support for transition
from 4 to 1 MPC to 2 to 1 MPC or no pipe split case and vice versa.
Currently, only enabled if debug flag is set.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 107 ++++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   5 +-
 3 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 636cf5c3a709..d2f796bff522 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -277,6 +277,7 @@ struct dc_config {
 	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
+	bool enable_4to1MPC;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 96b5a451cf26..e20fe292ccf5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1922,7 +1922,7 @@ bool dcn20_split_stream_for_odm(
 	return true;
 }
 
-bool dcn20_split_stream_for_mpc(
+void dcn20_split_stream_for_mpc(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		struct pipe_ctx *primary_pipe,
@@ -1951,11 +1951,6 @@ bool dcn20_split_stream_for_mpc(
 	secondary_pipe->top_pipe = primary_pipe;
 
 	ASSERT(primary_pipe->plane_state);
-	if (!resource_build_scaling_params(primary_pipe) ||
-			!resource_build_scaling_params(secondary_pipe))
-		return false;
-
-	return true;
 }
 
 void dcn20_populate_dml_writeback_from_context(
@@ -2581,11 +2576,32 @@ static void dcn20_merge_pipes_for_validate(
 	}
 }
 
+int dcn20_find_previous_split_count(struct pipe_ctx *pipe)
+{
+	int previous_split = 1;
+	struct pipe_ctx *current_pipe = pipe;
+
+	while (current_pipe->bottom_pipe) {
+		if (current_pipe->plane_state != current_pipe->bottom_pipe->plane_state)
+			break;
+		previous_split++;
+		current_pipe = current_pipe->bottom_pipe;
+	}
+	current_pipe = pipe;
+	while (current_pipe->top_pipe) {
+		if (current_pipe->plane_state != current_pipe->top_pipe->plane_state)
+			break;
+		previous_split++;
+		current_pipe = current_pipe->top_pipe;
+	}
+	return previous_split;
+}
+
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
 		int vlevel,
-		bool *split,
+		int *split,
 		bool *merge)
 {
 	int i, pipe_idx, vlevel_split;
@@ -2640,8 +2656,14 @@ int dcn20_validate_apply_pipe_split_flags(
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
-		if (force_split || context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_plane] > 1)
-			split[i] = true;
+		if (force_split
+				|| context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_plane] > 1) {
+			if (context->stream_count == 1 && plane_count == 1
+					&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4)
+				split[i] = 4;
+			else
+				split[i] = 2;
+		}
 		if ((pipe->stream->view_format ==
 				VIEW_3D_FORMAT_SIDE_BY_SIDE ||
 				pipe->stream->view_format ==
@@ -2650,9 +2672,9 @@ int dcn20_validate_apply_pipe_split_flags(
 				TIMING_3D_FORMAT_TOP_AND_BOTTOM ||
 				 pipe->stream->timing.timing_3d_format ==
 				TIMING_3D_FORMAT_SIDE_BY_SIDE))
-			split[i] = true;
+			split[i] = 2;
 		if (dc->debug.force_odm_combine & (1 << pipe->stream_res.tg->inst)) {
-			split[i] = true;
+			split[i] = 2;
 			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_plane] = dm_odm_combine_mode_2to1;
 		}
 		context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] =
@@ -2660,39 +2682,58 @@ int dcn20_validate_apply_pipe_split_flags(
 
 		if (pipe->prev_odm_pipe && context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] != dm_odm_combine_mode_disabled) {
 			/*Already split odm pipe tree, don't try to split again*/
-			split[i] = false;
-			split[pipe->prev_odm_pipe->pipe_idx] = false;
+			split[i] = 0;
+			split[pipe->prev_odm_pipe->pipe_idx] = 0;
 		} else if (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state
 				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
-			/*Already split mpc tree, don't try to split again, assumes only 2x mpc combine*/
-			split[i] = false;
-			split[pipe->top_pipe->pipe_idx] = false;
-		} else if (pipe->prev_odm_pipe || (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state)) {
-			if (split[i] == false) {
+			/*If 2 way split but can support 4 way split, then split each pipe again*/
+			if (context->stream_count == 1 && plane_count == 1
+					&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4) {
+				split[i] = 2;
+			} else {
+				split[i] = 0;
+				split[pipe->top_pipe->pipe_idx] = 0;
+			}
+		} else if (pipe->prev_odm_pipe || (dcn20_find_previous_split_count(pipe) == 2 && pipe->top_pipe)) {
+			if (split[i] == 0) {
 				/*Exiting mpc/odm combine*/
 				merge[i] = true;
-				if (pipe->prev_odm_pipe) {
-					ASSERT(0); /*should not actually happen yet*/
-					merge[pipe->prev_odm_pipe->pipe_idx] = true;
-				} else
-					merge[pipe->top_pipe->pipe_idx] = true;
 			} else {
 				/*Transition from mpc combine to odm combine or vice versa*/
 				ASSERT(0); /*should not actually happen yet*/
-				split[i] = true;
+				split[i] = 2;
 				merge[i] = true;
 				if (pipe->prev_odm_pipe) {
-					split[pipe->prev_odm_pipe->pipe_idx] = true;
+					split[pipe->prev_odm_pipe->pipe_idx] = 2;
 					merge[pipe->prev_odm_pipe->pipe_idx] = true;
 				} else {
-					split[pipe->top_pipe->pipe_idx] = true;
+					split[pipe->top_pipe->pipe_idx] = 2;
 					merge[pipe->top_pipe->pipe_idx] = true;
 				}
 			}
+		} else if (dcn20_find_previous_split_count(pipe) == 3) {
+			if (split[i] == 0 && !pipe->top_pipe) {
+				merge[pipe->bottom_pipe->pipe_idx] = true;
+				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+			} else if (split[i] == 2 && !pipe->top_pipe) {
+				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+				split[i] = 0;
+			}
+		} else if (dcn20_find_previous_split_count(pipe) == 4) {
+			if (split[i] == 0 && !pipe->top_pipe) {
+				merge[pipe->bottom_pipe->pipe_idx] = true;
+				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+				merge[pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+			} else if (split[i] == 2 && !pipe->top_pipe) {
+				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+				merge[pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+				split[i] = 0;
+			}
 		}
 
 		/* Adjust dppclk when split is forced, do not bother with dispclk */
-		if (split[i] && context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] == 1)
+		if (split[i] != 0
+				&& context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] == 1)
 			context->bw_ctx.dml.vba.RequiredDPPCLK[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] /= 2;
 		pipe_idx++;
 	}
@@ -2709,7 +2750,7 @@ bool dcn20_fast_validate_bw(
 		int *vlevel_out)
 {
 	bool out = false;
-	bool split[MAX_PIPES] = { false };
+	int split[MAX_PIPES] = { 0 };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2769,7 +2810,7 @@ bool dcn20_fast_validate_bw(
 				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx])
 			goto validate_fail;
 
-		if (split[i]) {
+		if (split[i] == 2) {
 			if (!hsplit_pipe || hsplit_pipe->plane_state != pipe->plane_state) {
 				/* pipe not split previously needs split */
 				hsplit_pipe = dcn20_find_secondary_pipe(dc, &context->res_ctx, dc->res_pool, pipe);
@@ -2784,11 +2825,13 @@ bool dcn20_fast_validate_bw(
 							pipe, hsplit_pipe))
 						goto validate_fail;
 					dcn20_build_mapped_resource(dc, context, pipe->stream);
-				} else
-					if (!dcn20_split_stream_for_mpc(
+				} else {
+					dcn20_split_stream_for_mpc(
 							&context->res_ctx, dc->res_pool,
-							pipe, hsplit_pipe))
+							pipe, hsplit_pipe);
+					if (!resource_build_scaling_params(pipe) || !resource_build_scaling_params(hsplit_pipe))
 						goto validate_fail;
+				}
 				pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
 			}
 		} else if (hsplit_pipe && hsplit_pipe->plane_state == pipe->plane_state) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 578265ccbf5b..d5448c9b0e15 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -119,17 +119,18 @@ void dcn20_set_mcif_arb_params(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt);
 bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
+int dcn20_find_previous_split_count(struct pipe_ctx *pipe);
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
 		int vlevel,
-		bool *split,
+		int *split,
 		bool *merge);
 void dcn20_release_dsc(struct resource_context *res_ctx,
 			const struct resource_pool *pool,
 			struct display_stream_compressor **dsc);
 bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx);
-bool dcn20_split_stream_for_mpc(
+void dcn20_split_stream_for_mpc(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		struct pipe_ctx *primary_pipe,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
