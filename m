Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0684EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4698810E46D;
	Wed, 23 Aug 2023 16:04:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF4A10E46B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaD9n8E0fuDgdrs4Wpp97/mjaEllYu6at6Gvraztr3P3/7SWKEcRytv4btWVdTE2qgRBf3vDoKGwUqz/RxedCPcwnrcwbMNuwud6pwkJ+/OXYkZi+0+GaAbDdKsb4+i3x/8vVBxB2vr984PUawn5758b2A0DGWvZZk1CrOwVxIjmqwkHiCEMEKYkTEJQ+2bK8iVGDcuBpVhCcTmv4cC4RxAZ3fnWoA5xkF1if2sA65vDNd3MwiWw7AkMlQkNx/NNVWDFA9ZqM3tKpCTA1hEyTyOZG32XrRAo9AOJItSKh6+JU7dTAje9yv0uYs4xaIfpMawtJlAUCPLns0QiMOpc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZHE0HXaFRdmgawXkKF9v65UvFdCGgVjrLVTUnG/1a4=;
 b=c14lvulDv4uSaWqUb6N2V50YLc3dRIaANZJvXbhkY4w3mLPvHL5sXxURjYqlh+grWemxd+1XgnzfcKfNluqB2bWKbGnIb94K8HVBXcqpzRj1MjBMKZr9Bety5xvsl9IBsrXAyu1JhTiVjLrQyXVDTwvxyWx9s+pZEuvX7+LZ9h7YIwY7HFPW06RbiTZ+4saxwRAk0Wjk0YgZiylbHiLTNHCW4fWv/XBBBz+M5C2L2GLgJGr5WiDMGdGJCiY4drdb0IMJmeCwcACVtCXv5xwf/+6xifCKUJHZCMNYRApBPPTpUMuc7Lnt0Gd56MrhicgFNkyDU9TAxhYCbtxz14H1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZHE0HXaFRdmgawXkKF9v65UvFdCGgVjrLVTUnG/1a4=;
 b=TrdvtV7sN8jFQUhniZv0x/d6bCY+rAh3vJA7UfuPjIT+/u06/jBZVRNEHqjEayMxgPOaXsVZOxL3jxE3LAtmdVGCqzFf8EJhYwkaGNOJvqKhD0VHdrUE13pbmmIuZ0haZ7XvamYYFJPZPY4ckxSBO22BEXDEEp37i7ZapvQXCgA=
Received: from PA7P264CA0119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::12)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:43 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::e5) by PA7P264CA0119.outlook.office365.com
 (2603:10a6:102:34c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:42 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:33 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: switch to new ODM policy for windowed
 MPO ODM support
Date: Wed, 23 Aug 2023 11:58:15 -0400
Message-ID: <20230823160347.176991-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e16604-14ed-4cd8-cf82-08dba3f2a985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQvb4v9G09HO0pU77HSsKeiymPIRQnybN7MNGBmti7x2ArCQ5Ua4MvZOSV+4jqWt8tkFvM4n5CVm6jJdouTzv446QVuiYn7aAyfeADEPZYcorEP5EKtkJVsqRwk3hTAnQQ4rPfkAi8u7sblqpK7MLQBUvdoNbhIODtG71E1jXHjjZDNLqBl4ZJu+DYBK5RGIEaJmIu5ignjU45tzqLyHCP9oW2qwX96zS3D8DMHqrojK1DSJgYMP6m4vGkO53SEEebMTNT4qX1k4MnNrwlDRNU+8Z8xT3IwP9RdvIZ8+EMArepD+XnKTdXjLjjfgrCnkPkU5ACYe22TCGcd++vYm1iTcIDD4sLjjf4L35LWaUCwFDN4iCt6SOov3xrrfdK6nEoCm+rxa/0+MyAn1b852jbFi1TyUV5vAOgzwIhzkJD2W5qHoAz+twM7TRMomaO0Iul8LuIC9Uij0WHXIK276x1m5pVVoI/oqnLBZYsSxxdQBCy5JEy2DLu7ghvRkgkxdffLCjD5AncjC8xvmJxyFhpcN3Hj6IUgXF9jvXOZ9ga8QjvgRAe18u7uYBiYgEXd/pQiscjtYplGekBQq5LyuI28+c/trm+4WQiot1yHrjWwXlu5PWX0hjpkzu22DcbOg/Peer9YxHM/p3trWb25+xtgJqzer3bHPSgRARkSJ4EnadFoLCXmftRZU4RDlwlK5LYao6lnpSf+JocpTntZ1tb/VbTyUnFCrlqR7yhsiGY7cCqoTKue/vfiXx+EoI1sPMmX99Ei1Kp45E3EOtvFgsHmO/Cc5/Ktuiryg7RIryoiwhSQ5uQq8987fHbGtsW+8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(44832011)(426003)(5660300002)(336012)(16526019)(86362001)(36860700001)(26005)(47076005)(2616005)(8936002)(4326008)(70586007)(316002)(54906003)(6916009)(70206006)(82740400003)(478600001)(8676002)(356005)(81166007)(40460700003)(41300700001)(36756003)(6666004)(1076003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:42.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e16604-14ed-4cd8-cf82-08dba3f2a985
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

We need to align windowed MPO ODM support on DCN3x with new ODM policy.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 84 ++++++++++++++-----
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 88c9dbbacbd3..fd12791995a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1885,6 +1885,67 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
+static bool should_allow_odm_power_optimization(struct dc *dc,
+		struct dc_state *context)
+{
+	struct dc_stream_state *stream = context->streams[0];
+
+	/*
+	 * this debug flag allows us to disable ODM power optimization feature
+	 * unconditionally. we force the feature off if this is set to false.
+	 */
+	if (!dc->debug.enable_single_display_2to1_odm_policy)
+		return false;
+
+	/* current design and test coverage is only limited to allow ODM power
+	 * optimization for single stream. Supporting it for multiple streams
+	 * use case would require additional algorithm to decide how to
+	 * optimize power consumption when there are not enough free pipes to
+	 * allocate for all the streams. This level of optimization would
+	 * require multiple attempts of revalidation to make an optimized
+	 * decision. Unfortunately We do not support revalidation flow in
+	 * current version of DML.
+	 */
+	if (context->stream_count != 1)
+		return false;
+
+	/*
+	 * Our hardware doesn't support ODM for HDMI TMDS
+	 */
+	if (dc_is_hdmi_signal(stream->signal))
+		return false;
+
+	/*
+	 * ODM Combine 2:1 requires horizontal timing divisible by 2 so each
+	 * ODM segment has the same size.
+	 */
+	if (!is_h_timing_divisible_by_2(stream))
+		return false;
+
+	/*
+	 * No power benefits if the timing's pixel clock is not high enough to
+	 * raise display clock from minimum power state.
+	 */
+	if (stream->timing.pix_clk_100hz * 100 <= DCN3_2_VMIN_DISPCLK_HZ)
+		return false;
+
+	/* the new ODM power optimization feature reduces software design
+	 * limitation and allows ODM power optimization to be supported even
+	 * with presence of overlay planes. The new feature is enabled based on
+	 * enable_windowed_mpo_odm flag. If the flag is not set, we limit our
+	 * feature scope due to previous software design limitation */
+	if (!dc->config.enable_windowed_mpo_odm) {
+		if (context->stream_status[0].plane_count != 1)
+			return false;
+
+		if (stream->src.width >= 5120 &&
+				stream->src.width > stream->dst.width)
+			return false;
+	}
+
+	return true;
+}
+
 int dcn32_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
@@ -1895,35 +1956,20 @@ int dcn32_populate_dml_pipes_from_context(
 	struct pipe_ctx *pipe = NULL;
 	bool subvp_in_use = false;
 	struct dc_crtc_timing *timing;
-	bool vsr_odm_support = false;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
-	/* Determine whether we will apply ODM 2to1 policy:
-	 * Applies to single display and where the number of planes is less than 3.
-	 * For 3 plane case ( 2 MPO planes ), we will not set the policy for the MPO pipes.
-	 *
+	/*
 	 * Apply pipe split policy first so we can predict the pipe split correctly
 	 * (dcn32_predict_pipe_split).
 	 */
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
-		pipe = &res_ctx->pipe_ctx[i];
-		timing = &pipe->stream->timing;
-
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		vsr_odm_support = (res_ctx->pipe_ctx[i].stream->src.width >= 5120 &&
-				res_ctx->pipe_ctx[i].stream->src.width > res_ctx->pipe_ctx[i].stream->dst.width);
-		if (context->stream_count == 1 &&
-				context->stream_status[0].plane_count == 1 &&
-				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
-				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
-				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
-				dc->debug.enable_single_display_2to1_odm_policy &&
-				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
+		if (should_allow_odm_power_optimization(dc, context))
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-		}
+		else
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
 		pipe_cnt++;
 	}
 
-- 
2.41.0

