Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE015C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294C510E815;
	Wed,  7 Sep 2022 18:12:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A0710E80B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dizclophAj/nBHQtCIGUmTKpoNXhoEcc8kF4gKzuoZYI2nTZuyMDyyFT2wC4dxO5HaWF9qfrXXqS9jaIdmWdNKu36GCPD9e6ihu6WcMPtyg/ogqfcKEJJXh8oRVPMkN3hIHFoQfXQoNAzujHze4QTwPwV0iqeK4LE45y5/PcMb1U7pyr4vsQLBaUM5G3t1akavCBgTolEM2/VgSNIlNVJ/hinNuJT09GZePeIq0ebMkBj1KxfT4yzn0rPuTmVHSCtlfO9KjLsBxcPye8wGR1KCU94N0haPy0f94T1Y/3nDbaipHfXBGhvovRssSWHBd3tBIcz63mQAeLRnKKNbPdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsFyWlzPX8o+aLRuXjLUoD7LCCJqbdZb6vj3QqlTHAQ=;
 b=Jqc2pmdGaZvmBcLHFr4M7HTp+Zr7fYdHGpvKVbXdQBCJABeNA9q3Q+btHSkZmeVAbZn9mx/aWomivb+eqLcXh62FG6ly7enba5QiWTCWhtGMGjsQlHeyxh3QkbSSFa6wnohoiX6dkYrVbMmMLi+TfKO24I2Bly/PhW7tbm2T5hdwM0EMRprmInjy4jW8t4Wt1e1ZRnD8OOiZWrvp2su/HxpDPf8ITMI8Uynn8a7eK4rLI5PjgesfVW0dXilo/jOxjEtItk2aooXY3Nyuz0laOv6IVfacamZ9zJZPMswQOyTRZ/Uh4sXWrgCJRRxa8jB6BUMFMjoLHmohvuhqN02mtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsFyWlzPX8o+aLRuXjLUoD7LCCJqbdZb6vj3QqlTHAQ=;
 b=a2ncsoBgvFvOX3UV0RCEp7On9Naum4geotUyUTleQNFJqwZM7ATPnlS3Y9612/xky1QhWUsWseORUtFup3xEO58kI/AQ55If2o5A9Yo2QJucK2D7avF5tmDOrE4hr7H/ZLUWGelKzsQm2nqxydXKAwuzHx70us39iffx7lN2HRc=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:12:37 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::1a) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:36 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:35 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: Refactor SubVP calculation to remove
 FPU
Date: Wed, 7 Sep 2022 14:11:58 -0400
Message-ID: <20220907181200.54726-19-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 807cd46d-e234-4d50-6af3-08da90fc8b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyBxbfst4BuUSN2cjNX0juEtHBHj1a2Y0o1z6yvg+pHuMUWWC3gpzBrHFrNSM64uqH+25ow3sq3ct0LODvYLlUOUSaLJWCPlkRbnxNH5sbCi4ONoxem/u6YGEMwadsBTDRY3TthmMdpzVZkDQC6W77KtwK4vzwstc1ZRacpR5tBUeKbvdAi+joe7NFcPUXdyn2AfQ2dQO51Q6CvoO7Dah6CfCNz0duuLc35EetrBf/hFHOncLihKjpde2Ej+Azs2BQmPyajpkm2aP5Xa986ZW03osZehD2Ovwv/bSUi4bMDYXykBBgCbU75+DrpM0oqjKZtlS22JkceV6bw2Ka7buRTBcLVoZTg1zllR3Z3SPZ+Jf+srVwdLAP5BhNZYt5eezT0EisPD6l76V16+ogjG1M2yNoW5y0352UjuSBygRgTHNInQrUeJNp3MzbJEbytcgNX3/0QMZIKo/+Os1dnbHS/Li0Y8gP8LoZPdNqjf9V4h4ubRGxJjlRDXFlFYmQuglukUHOG2M+1vYD9qWwTJw9mPDTObr1wQ/g7yT+P6XfwUmw3WR18QVTIJsi10mGrPWN4MRDzrO5FUis8fBoslWW6ondHfVsMBve08X6gWNyychkDiNz7bvI7F3wAlzgL0QrvkmFQu4m2DBF/G0isSBAoBJZqtSeh4k852hjUpU3U2YeIjcuvKEgY4XsGTv2iWQaQMqJsah41duY2UtDHK8Y93yp2R/+Uu8o3z0PmxpAHKdvfKeEJ1r9+RndZteiTBCdD9e2ECD6OLAhFYvyFEELRQkHMGfVVPH1JSe//gJYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(81166007)(478600001)(356005)(40460700003)(41300700001)(70206006)(8676002)(4326008)(70586007)(6916009)(54906003)(86362001)(316002)(82310400005)(26005)(36756003)(83380400001)(47076005)(426003)(8936002)(1076003)(66574015)(336012)(44832011)(186003)(16526019)(36860700001)(2616005)(7696005)(82740400003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:36.8583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807cd46d-e234-4d50-6af3-08da90fc8b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Magali Lemes <magalilemes00@gmail.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Refactor calculation to remove floating point operations from dmub_srv.
To ensure that 32-bit compilation works well, we use the div64 family of
macros to do integer division for SubVP-related timing parameters.

Cc: Maíra Canal <mairacanal@riseup.net>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Isabella Basso <isabbasso@riseup.net>
Cc: Magali Lemes <magalilemes00@gmail.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Co-developed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 89 ++++++++++----------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 7b765efe0825..080704d4e540 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -450,44 +450,42 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
 	struct dc_crtc_timing *phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
 	struct dc_crtc_timing *drr_timing = &vblank_pipe->stream->timing;
-	int16_t drr_frame_us = 0;
-	int16_t min_drr_supported_us = 0;
-	int16_t max_drr_supported_us = 0;
-	int16_t max_drr_vblank_us = 0;
-	int16_t max_drr_mallregion_us = 0;
-	int16_t mall_region_us = 0;
-	int16_t prefetch_us = 0;
-	int16_t subvp_active_us = 0;
-	int16_t drr_active_us = 0;
-	int16_t min_vtotal_supported = 0;
-	int16_t max_vtotal_supported = 0;
+	uint16_t drr_frame_us = 0;
+	uint16_t min_drr_supported_us = 0;
+	uint16_t max_drr_supported_us = 0;
+	uint16_t max_drr_vblank_us = 0;
+	uint16_t max_drr_mallregion_us = 0;
+	uint16_t mall_region_us = 0;
+	uint16_t prefetch_us = 0;
+	uint16_t subvp_active_us = 0;
+	uint16_t drr_active_us = 0;
+	uint16_t min_vtotal_supported = 0;
+	uint16_t max_vtotal_supported = 0;
 
 	pipe_data->pipe_config.vblank_data.drr_info.drr_in_use = true;
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
 
-	drr_frame_us = div64_s64(drr_timing->v_total * drr_timing->h_total,
-				 (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
+	drr_frame_us = div64_u64(((uint64_t)drr_timing->v_total * drr_timing->h_total * 1000000),
+			(((uint64_t)drr_timing->pix_clk_100hz * 100)));
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = div64_s64(phantom_timing->v_addressable * phantom_timing->h_total,
-				   (int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000);
+	mall_region_us = div64_u64(((uint64_t)phantom_timing->v_addressable * phantom_timing->h_total * 1000000),
+			(((uint64_t)phantom_timing->pix_clk_100hz * 100)));
 	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	min_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 *
-					 (div64_s64((int64_t)min_drr_supported_us, 1000000)),
-					 (int64_t)drr_timing->h_total);
-
-	prefetch_us = div64_s64((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total,
-				(int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-				dc->caps.subvp_prefetch_end_to_mall_start_us);
-	subvp_active_us = div64_s64(main_timing->v_addressable * main_timing->h_total,
-				    (int64_t)(main_timing->pix_clk_100hz * 100) * 1000000);
-	drr_active_us = div64_s64(drr_timing->v_addressable * drr_timing->h_total,
-				  (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
-	max_drr_vblank_us = div64_s64((int64_t)(subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
+	min_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * min_drr_supported_us),
+			(((uint64_t)drr_timing->h_total * 1000000)));
+
+	prefetch_us = ((uint64_t)(phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total * 1000000)
+			/ (((uint64_t)phantom_timing->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp_active_us = div64_u64(((uint64_t)main_timing->v_addressable * main_timing->h_total * 1000000),
+			(((uint64_t)main_timing->pix_clk_100hz * 100)));
+	drr_active_us = div64_u64(((uint64_t)drr_timing->v_addressable * drr_timing->h_total * 1000000),
+			(((uint64_t)drr_timing->pix_clk_100hz * 100)));
+	max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
-	max_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 * (div64_s64((int64_t)max_drr_supported_us, 1000000)),
-					 (int64_t)drr_timing->h_total);
+	max_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us),
+			(((uint64_t)drr_timing->h_total * 1000000)));
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
@@ -581,10 +579,12 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
-	subvp0_prefetch_us = div64_s64((phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total,
-				       (int64_t)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
-	subvp1_prefetch_us = div64_s64((phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total,
-				       (int64_t)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp0_prefetch_us = div64_u64(((uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) *
+			(uint64_t)phantom_timing0->h_total * 1000000),
+			(((uint64_t)phantom_timing0->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us));
+	subvp1_prefetch_us = div64_u64(((uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) *
+			(uint64_t)phantom_timing1->h_total * 1000000),
+			(((uint64_t)phantom_timing1->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us));
 
 	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
 	// should increase it's prefetch time to match the other
@@ -592,16 +592,17 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
-				   (phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1),
-				  (int64_t)phantom_timing1->h_total);
+				div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+					((uint64_t)phantom_timing1->pix_clk_100hz * 100) + ((uint64_t)phantom_timing1->h_total * 1000000 - 1)),
+					((uint64_t)phantom_timing1->h_total * 1000000));
+
 	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
-				   (phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1),
-				  (int64_t)phantom_timing0->h_total);
+				div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+					((uint64_t)phantom_timing0->pix_clk_100hz * 100) + ((uint64_t)phantom_timing0->h_total * 1000000 - 1)),
+					((uint64_t)phantom_timing0->h_total * 1000000));
 	}
 }
 
@@ -668,13 +669,11 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-		div64_s64(((div64_s64((int64_t)dc->caps.subvp_prefetch_end_to_mall_start_us, 1000000)) *
-			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
-			  (int64_t)phantom_timing->h_total);
+			div64_u64(((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
+					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-		div64_s64(((div64_s64((int64_t)dc->caps.subvp_fw_processing_delay_us, 1000000)) *
-			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
-			  (int64_t)phantom_timing->h_total);
+			div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
+					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
-- 
2.34.1

