Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC3C47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B49810FC6F;
	Wed, 31 Jan 2024 20:14:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46D110FC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh4EjpiPZzLHRU/PRZwkquxpK/pIcJCYGEec38O+YayOKDYNj2UTDigOfowqrToIFlYMpGGEnqFymLmlF7BTxUIp1LJ9tquymDjD9Arq0FB7guKT2Gj5y3c4L8RPApDhNhf+RDbVek30kpnxBSrpZvmKnQl8/mGe5eVXs++9eHDhzgTBLZQ/AD4XIdQSClFAQxF9XRmauUJ2MIcCdmhkUrMoSN9PeiJ49A1E+Tv4kd3NParnHH/nuJvPF3SFa14TvzQoZIOxYdpXCevKo4h7M3msGCRgWGF/8/ZlFA68SbGPBXo/iGqXQ5PgD+uMq9gMWAAsP+0EDlfs6gI27p99mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFhCJw/mcMsmZcRKYWkevuwYFUbyls3Ol54NHL5YlF4=;
 b=QZ2J8CNuS5pYsw2UN7eHbrpB+eCvqWqPJbWtNz9O9+cEr2219SHhSMXPRA4bc+jdaX1cnte+ajCv6m/KzS0IVjnM7U3bk198uT3JKRyMtIS7DgdlKtzeIkjEj1Z5M+MXiZj8AZe8DJPvI8lt8J/vxhesM+wHYzOSJniry7ujq7V5dJj2oY3Dt1RIBomoc0iavRmQ/MQU8mzT+XQDKj5IyJU1h5lf+lXHTUA32tbLXC4+aaxMKBLU80HRVmq2z8ZzDRbSk5coT3CWinhJvAs2pkEO7eHmgGh6NgpvoT+osxpFR+csPBSXC8ucRXhqubl/bD9r6T09rT4V5esTk6fpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFhCJw/mcMsmZcRKYWkevuwYFUbyls3Ol54NHL5YlF4=;
 b=3FYMpU4JHt+wGOxoRVBjjBOu0Ek18J1hN+8NeQeiOxyN4j0SrDHIrmvdCXx15meR6CZuP9FNO2yYW3qEx27a3zmWzM/YoIKLmNIv0zXyZV+dtMXsgvFHV/GC+7PlW5VzWsNRmRM7V68+QtVs/3JGPOAEutNI057yYpCeESJyjZk=
Received: from SN7PR18CA0001.namprd18.prod.outlook.com (2603:10b6:806:f3::15)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:49 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::2) by SN7PR18CA0001.outlook.office365.com
 (2603:10b6:806:f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:49 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:46 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: Add left edge pixel for YCbCr422/420 +
 ODM pipe split
Date: Wed, 31 Jan 2024 15:11:16 -0500
Message-ID: <20240131201220.19106-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7723ce0f-4453-4a99-756c-08dc229946dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHt9LaDguhVmtpUF0Si5z6bTnGv7R6Xvzf/1lZsCXzXoa3EAn4O2lnVaVa3jJRskaclucPo0AGAymSwK04lpxU/h5Mdk8w9zsG0F8zU/5AIG7cWP2lMa5GR/ruvceXsznRw7Qdx7EK2LmwPYIrheVOaNiYHhxhXtbTfnsRDjW+5ct7YBbG1Y9DbEsbPbuPzwHrJWoouyhJAThxSLbkXshNVyEJdxBH34/MgP644wco4V1s7d0QyPUhhvRDZl8fs68Y/TocMaJkWBxAP5wVCIL3AOxhYzMe7E0gaPunEXYh+oeUyqZg1LT2zAU4/1hUovN2NDBvVNm/0mJypN+Xui9MZw2Gd10EuMcji9rqJjWUPnrxFkQs2lYuUfcQ2AM535SYrwkwTZPJzQ5O9WCkARn6HyWOrO99W5ogcmuzrXya2ZTQ8EYV29gBAze1vRXG7CPy72uvwPU3wRANceACH0DpNsn+xiIClwy5PRIoo0rvtKt+FMzMnIypk8Q16HQ0yxzkJ9wm+6K8viIktP6512nqTK4Rg9RNZVTESBZvIYszfxU24CbpWsp3U2zGGcJtj5JDiLfdVFsuZB8qq6r2T46d9bsXmQ/FCw4mDEuay5Z6tUseakNkaNRBXQfmANBD5jOWpTVbq1I2FISbUNWdhXsWqwHqlV5a2/QSAQHd9Esis/7iEybwQdX3y8sbOYLGIc1ulPbuRaOWPuB3y1QS5KJUb6TJ/EzyvUYwoA4S5MlyxOf8KDnvUR+i3sFFv60r2e3oD8wwmlbIi9QtgmLHqhw9RMp6XqL05jWItcNLmD//8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(6029001)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(41300700001)(81166007)(36860700001)(47076005)(36756003)(86362001)(82740400003)(356005)(8936002)(6666004)(4326008)(54906003)(8676002)(6916009)(316002)(70206006)(70586007)(478600001)(336012)(26005)(2906002)(83380400001)(2616005)(1076003)(44832011)(5660300002)(426003)(40460700003)(40480700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:49.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7723ce0f-4453-4a99-756c-08dc229946dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Currently 3-tap chroma subsampling is used for YCbCr422/420. When ODM
pipesplit is used, pixels on the left edge of ODM slices need one extra
pixel from the right edge of the previous slice to calculate the correct
chroma value.

Without this change, the chroma value is slightly different than
expected. This is usually imperceptible visually, but it impacts test
pattern CRCs for compliance test automation.

[How]
Update logic to use the register for adding extra left edge pixel for
YCbCr422/420 ODM cases.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  7 +++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  4 ++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eb803d4d3478..e58bd0861dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3090,6 +3090,10 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
+
+			if (otg_master && (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+					otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420))
+				resource_build_subsampling_params(&context->res_ctx, otg_master);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 259ccbe858b4..528d3eb245ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -822,6 +822,16 @@ static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ct
 			stream->timing.v_border_bottom +
 			stream->timing.v_border_top;
 
+	/* Recout for ODM slices after the first slice need one extra left edge pixel
+	 * for 3-tap chroma subsampling.
+	 */
+	if (odm_slice_idx > 0 &&
+			(pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+				pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
+		odm_rec.x -= 1;
+		odm_rec.width += 1;
+	}
+
 	return odm_rec;
 }
 
@@ -1438,6 +1448,7 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum controller_dp_color_space controller_color_space;
 	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
+	enum dc_pixel_encoding pixel_encoding = otg_master->stream->timing.pixel_encoding;
 	int h_active = otg_master->stream->timing.h_addressable +
 		otg_master->stream->timing.h_border_left +
 		otg_master->stream->timing.h_border_right;
@@ -1469,10 +1480,36 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 		else
 			params->width = last_odm_slice_width;
 
+		/* Extra left edge pixel is required for 3-tap chroma subsampling. */
+		if (i != 0 && (pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+				pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
+			params->offset -= 1;
+			params->width += 1;
+		}
+
 		offset += odm_slice_width;
 	}
 }
 
+void resource_build_subsampling_params(struct resource_context *res_ctx,
+	struct pipe_ctx *otg_master)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int odm_cnt = 1;
+	int i;
+
+	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
+
+	/* For ODM slices after the first slice, extra left edge pixel is required
+	 * for 3-tap chroma subsampling.
+	 */
+	if (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+			otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		for (i = 0; i < odm_cnt; i++)
+			opp_heads[i]->stream_res.left_edge_extra_pixel = (i == 0) ? false : true;
+	}
+}
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index d26353dafc1c..68268803e754 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1573,7 +1573,8 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 	 * makes this assumption at the moment with how hubp reset is matched to
 	 * same index mpcc reset.
 	 */
-	if (old_pipe->stream_res.opp != new_pipe->stream_res.opp)
+	if (old_pipe->stream_res.opp != new_pipe->stream_res.opp ||
+			old_pipe->stream_res.left_edge_extra_pixel != new_pipe->stream_res.left_edge_extra_pixel)
 		new_pipe->update_flags.bits.opp_changed = 1;
 	if (old_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		new_pipe->update_flags.bits.tg_changed = 1;
@@ -1959,6 +1960,10 @@ static void dcn20_program_pipe(
 			pipe_ctx->stream_res.opp,
 			&pipe_ctx->stream->bit_depth_params,
 			&pipe_ctx->stream->clamping);
+
+		pipe_ctx->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+			pipe_ctx->stream_res.opp,
+			pipe_ctx->stream_res.left_edge_extra_pixel);
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3a6bf77a6873..ebb659c327e0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -333,6 +333,8 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
+
+	bool left_edge_extra_pixel;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 2eae2f3e846d..77e87c8de777 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -107,6 +107,10 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
+void resource_build_subsampling_params(
+		struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx);
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
 enum dc_status resource_build_scaling_params_for_context(
-- 
2.43.0

