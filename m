Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01646C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C642067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OcqK/hdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C642067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9226F4B6;
	Fri, 21 Feb 2020 16:04:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA57A6F4B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acPY1m7p7zUZpGUssyGk++SRjfx/4WOnt0BhH2faWDG7bJ9maEESvAI4av1a/wMlVJ8zqutYaBQ5qEmq/MVt64vn10bfAy53Ue8Krbs0RDYa4d+T44gL/Y7Z6gQPXbJAqAOBKoJr6HxMOYTjTprhA56Qd7nUXzKNa4oIL7i52UUT36GUyr5yyz3eY50HC0KYs934tm8LxS9WwG0RmoXr8Msr3IUpnC34tKbElv7Ay49iOPcxtrezIq2rm+Qc7zWhsKUHqwLB3XQA7RWUSPdnteppyjtDBhXRQWrm/sdvaEweoPfVwMd8jmzEdOEQL0/yOg8B6WXfSFDy6ABJYL15+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YUgJFNJzlaoAJPmVt3+FTV021keTGjtU2mVNcJKtlM=;
 b=Kv8HXj6BHLbN+ComwxlIlVAD35qHiMq/ICQZaQ/LrCw3b1RVxbINbkUdy+DWdwEyYm+JX3QHyH2Tu9Zc3t494BAq+Lc7turuUBzJH8lbj7f0oFV3Hu9Lsk5gaESaZ2chF8J1LKO2LVEXW1VNJaPttJtFjiy6Xk1Et3n5wEozzTZOU7IPkK1V+sSQaq7ASYFlv78BOals4I6h/O5agO6t98DdVhNuU4FC2D0t0VeiHweSPMtTmcpuRBo11Igb9POH45RZDKPWbsj/6QVSyh3NLCqWJrRt1H3Q4SY2wYzjBEVoO8iLVkrE61ljIPm3GNRqV+5z1g4rdV8IWJ0aHkqZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YUgJFNJzlaoAJPmVt3+FTV021keTGjtU2mVNcJKtlM=;
 b=OcqK/hdRdWNRoJVeuddwHaYIrLcwILPQ1fCpVcKEsIXAj8DU9p3Rn2bSgq/vMuMp4xmrfOV8cYbnw2cNabf0mDbJ9yNZ0VFEyezHEz9zHaU77/uRQNqzmBhtROkjJkCx9IlqGQIBY56/MvywRphe0a/1uf11m6J7kV2IVE5JsFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:08 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:08 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/35] drm/amd/display: update dml input population function
Date: Fri, 21 Feb 2020 11:03:13 -0500
Message-Id: <20200221160324.2969975-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:06 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d405c47-4f6d-41cb-ab0c-08d7b6e7ade4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24097E546B15F28EE305B20798120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(15650500001)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJnl7h1zy7X/66CTTx2gU6/GRWydIHQO9VrAqXIKf60XkSLolJBXvKH+C/owdYPgfFVDcOMNzgB2l7eBruV6h3878ZORxxjDYd1yd7c3lypVrAp8VZZUhXV9w4gfh3KA6xe0CDq2Xcut7FVJgdIOZz3EKJUJXhRPgODFVN+j0oKoTzLFYpqpHQElaKtAO5O5RNKXVWIfgk2g4g6EtLhKQ8tSU5jE1Bgpj1dnCSTWI1JYgwHgWhJIbzGOxfCZzRCbYLQJPXyFJtkuffIonJGvIF+qrkOfh8r8ybDjZ+TDscA18p988u6CQXawEDjkG04ixe7kIbZBgE0+RdeVWSdMZ9vNOey+4zTAcnzfukhx1XjwL7QBoc4S7jIqqQ5fDGryP7LTxLZ8NkRBTE1m/zLFWYwu6Zwfope/WL8OARCNIQ0SASZ0YhQTaSBUi77irqF3
X-MS-Exchange-AntiSpam-MessageData: w8KNZirNxAK/Qw64067uwMJHhjcJkAU/vuyOzOjXiF7Fh8ReY532pWkLk1o0O+xVK71hounmHWAlEQwkL3Vxf3iYjprhWLmSLkB46mf1qxHKURrxIRPH/1yZ++SJ1LBupB1ZlouH/CuwXbiZ7S1PsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d405c47-4f6d-41cb-ab0c-08d7b6e7ade4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:06.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs0DKoCytasGpdwKbfk8t4i6zxeJi6FKqT+edic5I2FlmmffpkQdCF2prBKyEG9RAdxa6lcxpVsQKMNmoRh7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Update dcn20_populate_dml_pipes_from_context to correctly handle odm
when no surface is provided.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 26 ++++++++++++-------
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 --
 .../drm/amd/display/dc/dml/display_mode_vba.h |  3 ---
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 080d4581a93d..883ecd2ed4c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1949,9 +1949,14 @@ int dcn20_populate_dml_pipes_from_context(
 		}
 		pipes[pipe_cnt].pipe.src.hsplit_grp = res_ctx->pipe_ctx[i].pipe_idx;
 		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state
-				== res_ctx->pipe_ctx[i].plane_state)
-			pipes[pipe_cnt].pipe.src.hsplit_grp = res_ctx->pipe_ctx[i].top_pipe->pipe_idx;
-		else if (res_ctx->pipe_ctx[i].prev_odm_pipe) {
+				== res_ctx->pipe_ctx[i].plane_state) {
+			struct pipe_ctx *first_pipe = res_ctx->pipe_ctx[i].top_pipe;
+
+			while (first_pipe->top_pipe && first_pipe->top_pipe->plane_state
+					== res_ctx->pipe_ctx[i].plane_state)
+				first_pipe = first_pipe->top_pipe;
+			pipes[pipe_cnt].pipe.src.hsplit_grp = first_pipe->pipe_idx;
+		} else if (res_ctx->pipe_ctx[i].prev_odm_pipe) {
 			struct pipe_ctx *first_pipe = res_ctx->pipe_ctx[i].prev_odm_pipe;
 
 			while (first_pipe->prev_odm_pipe)
@@ -2046,6 +2051,7 @@ int dcn20_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.cur1_bpp = dm_cur_32bit;
 
 		if (!res_ctx->pipe_ctx[i].plane_state) {
+			pipes[pipe_cnt].pipe.src.is_hsplit = pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
 			pipes[pipe_cnt].pipe.src.source_scan = dm_horz;
 			pipes[pipe_cnt].pipe.src.sw_mode = dm_sw_linear;
 			pipes[pipe_cnt].pipe.src.macro_tile_size = dm_64k_tile;
@@ -2071,19 +2077,21 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.scale_ratio_depth.scl_enable = 0; /*Lb only or Full scl*/
 			pipes[pipe_cnt].pipe.scale_taps.htaps = 1;
 			pipes[pipe_cnt].pipe.scale_taps.vtaps = 1;
-			pipes[pipe_cnt].pipe.src.is_hsplit = 0;
-			pipes[pipe_cnt].pipe.dest.odm_combine = 0;
 			pipes[pipe_cnt].pipe.dest.vtotal_min = v_total;
 			pipes[pipe_cnt].pipe.dest.vtotal_max = v_total;
+
+			if (pipes[pipe_cnt].pipe.dest.odm_combine == dm_odm_combine_mode_2to1) {
+				pipes[pipe_cnt].pipe.src.viewport_width /= 2;
+				pipes[pipe_cnt].pipe.dest.recout_width /= 2;
+			}
 		} else {
 			struct dc_plane_state *pln = res_ctx->pipe_ctx[i].plane_state;
 			struct scaler_data *scl = &res_ctx->pipe_ctx[i].plane_res.scl_data;
 
 			pipes[pipe_cnt].pipe.src.immediate_flip = pln->flip_immediate;
-			pipes[pipe_cnt].pipe.src.is_hsplit = (res_ctx->pipe_ctx[i].bottom_pipe
-					&& res_ctx->pipe_ctx[i].bottom_pipe->plane_state == pln)
-					|| (res_ctx->pipe_ctx[i].top_pipe
-					&& res_ctx->pipe_ctx[i].top_pipe->plane_state == pln);
+			pipes[pipe_cnt].pipe.src.is_hsplit = (res_ctx->pipe_ctx[i].bottom_pipe && res_ctx->pipe_ctx[i].bottom_pipe->plane_state == pln)
+					|| (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state == pln)
+					|| pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
 			pipes[pipe_cnt].pipe.src.source_scan = pln->rotation == ROTATION_ANGLE_90
 					|| pln->rotation == ROTATION_ANGLE_270 ? dm_vert : dm_horz;
 			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport.y;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 9bb8bff4cdd9..35fe3c640330 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -112,6 +112,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	int use_urgent_burst_bw;
 	unsigned int num_states;
 	struct _vcs_dpi_voltage_scaling_st clock_limits[MAX_CLOCK_LIMIT_STATES];
+	double min_dcfclk;
 	bool do_urgent_latency_adjustment;
 	double urgent_latency_adjustment_fabric_clock_component_us;
 	double urgent_latency_adjustment_fabric_clock_reference_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index b3c96d9b472f..e23fa0f05f06 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -266,8 +266,6 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.MaxDispclk[i] = soc->clock_limits[i].dispclk_mhz;
 		mode_lib->vba.DTBCLKPerState[i] = soc->clock_limits[i].dtbclk_mhz;
 	}
-	mode_lib->vba.MinVoltageLevel = 0;
-	mode_lib->vba.MaxVoltageLevel = mode_lib->vba.soc.num_states;
 
 	mode_lib->vba.DoUrgentLatencyAdjustment =
 		soc->do_urgent_latency_adjustment;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 2875efd85467..cb563a429590 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -842,8 +842,6 @@ struct vba_vars_st {
 	double DCCRateChroma[DC__NUM_DPP__MAX];
 
 	double PHYCLKD18PerState[DC__VOLTAGE_STATES + 1];
-	int MinVoltageLevel;
-	int MaxVoltageLevel;
 
 	bool WritebackSupportInterleaveAndUsingWholeBufferForASingleStream;
 	bool NumberOfHDMIFRLSupport;
@@ -880,7 +878,6 @@ struct vba_vars_st {
 	double TotalMetaRowBandwidth[DC__VOLTAGE_STATES + 1][2];
 	double TotalVActiveCursorBandwidth[DC__VOLTAGE_STATES + 1][2];
 	double TotalVActivePixelBandwidth[DC__VOLTAGE_STATES + 1][2];
-	bool UseMinimumRequiredDCFCLK;
 	double WritebackDelayTime[DC__NUM_DPP__MAX];
 	unsigned int DCCYIndependentBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCCIndependentBlock[DC__NUM_DPP__MAX];
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
