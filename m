Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A2CC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5E910ED52;
	Thu, 20 Apr 2023 23:50:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357F210ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kosyMQPwgkfszC1U3Tp4PcoypRyw69lGWz/bF9l7jxxlfOQxJWuVdqSzD0bwnOkLO6FKllxx0YYDIS4iyE4BaadV+vYTCkgczoAKfB/6oDsY9lJVWhdhbgk4VFypMRjxecKYutV6q4oACSaWRmkEOAEvGBdWVyWynid5Y6NbD3wQXkXa5oyCywwbxz1FuX5zWkdWjBB17GyvXHTT0L5q4CDWgRKOuVeVRxEdlw/7C+18MMCdHukt01BxN1M8Z3nli7Lo7SRAGlrNQWdszSc7Y+9q1gGrpOhm1OOHkJWF3gkuRlch8Ej8nVhdzHyGgxi35jJBxE4+TkZoiW4sXLkHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFjsAOxiB3d3UlKOPbbk02rDL0jQZy0r+LUmIalOj/w=;
 b=k1XS5/QkqIRQoRCcSOQg/V2YzPUv35TJPvsJenUVGBGxGVD2y6OhbflbAkE8UCUkvLUS0bwHf8Ew0Y+rH9PJUVg9r+5fYiXdYdNztwx5CB4/IjXzg1ZDfpIaJ4SRSVeINfehvB8bO/pKs0Y5E+13mDVZxNWlm8zV3Ci3g/ni+InoylcXA2vCIQS5SXltDSLxecx8cxdqyGCaexCbV7oUNkp4/TMVhLy9Gb4wve4JhUkjAeHCg6mfF/W/ncYlkzObHfdOiwqidxnFcy0EuThuJzzBWvnSKlkyvR0BPmNyJmHmnoK+X7ofGubN53y7xn80G4Qn1856PB6PIcGuKyonnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFjsAOxiB3d3UlKOPbbk02rDL0jQZy0r+LUmIalOj/w=;
 b=SLCQk1WxCKUiezwteAuHHbwx8WDB2FzLiVXQZ1bclm9JzNOWAKBVYLEOFs9Negnrs9/v1J3+aT4uNbSV5MvVfWhwCgevw+M5mi5eSnCUFTz4hw/q1T9uUt7TbF4V9oljVmurJanyDmd1Coo1FSRYOpRXHDBLSoHm+H/hzBoO+Ao=
Received: from DM6PR06CA0026.namprd06.prod.outlook.com (2603:10b6:5:120::39)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 23:50:24 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::cb) by DM6PR06CA0026.outlook.office365.com
 (2603:10b6:5:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: add pixel rate based CRB allocation
 support
Date: Thu, 20 Apr 2023 17:49:39 -0600
Message-ID: <20230420234951.1772270-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 875e9a40-0d8b-4923-a983-08db41fa0257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7fFadTjnLb6kMwWebv2MQQQbM2fNT2GAhRlzZycfewG4JMPS8EKnSUsUAcvPOsT8ZsXCk5+xgGwDa3UZ36yR+fl9G0dJXHPTcYk+iYN8eDjQL8D+aCV8zV+OGK++YPXYWXeEYUQSkBWV9rnJbal1C1ZocfhkQqocFbNmR4LJnc7jZksymBtOa/NdHmKvaSuniF+3H9DhFL/c51qiYnPI5dPtStccLptTlNbFhh0Ud1n7ob0gq4RBfjTuZYECU4md8yjmaqJLVjck9IdReGdbiKQROCg/1oIGs4/vzyRyC4OfkN6gzvcFIf29F7OnuKhlmXbT2RYMHU14Wc993bpuy8S9l3rSjQUn/vvb3C/g/91Rc1ud8FLsUG/vXz/FS8xrL+xbgVgTFnIG0+POKgNjSGQuAPISHAHuHyO50X2gTgcQnyzqF98+/Cbd5YAMKN1RfLdzhrSi5HlSiAxTjvLMzWK6peFIjfxd+SWO4N8eIKjFoyMW0g3p9FlY99UE84R2kgqFSpXSXsJFk3lji2gRHqDhLXI7uQBARxzjqP5mAZo3MW3mU3qt9ayCafvGdYqiUK7gHDXOU00jugxu6nxX24X1l5Pn4gvGcfUW8Fl2dzk/ZBgXfFKak6YhvBO0+PvG5aiPYyNPl7Y77QdUnQzIuNUvuvkTJ6U29B8mxOgM7sgdkTTkn9YGhfrKFo2VBGXPWvlnswEz4pbg/trK1hzpP120Eyobf7aQMAbUxjoy21Ps3y9OTfHTXVdBMHQYsmp/laROWaOmHnAk+cb4TUW9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(426003)(6666004)(86362001)(478600001)(336012)(2616005)(36756003)(36860700001)(40480700001)(83380400001)(26005)(186003)(40460700003)(82740400003)(16526019)(1076003)(70586007)(356005)(316002)(4326008)(70206006)(30864003)(2906002)(81166007)(5660300002)(6916009)(47076005)(8936002)(8676002)(41300700001)(82310400005)(54906003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:23.9204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875e9a40-0d8b-4923-a983-08db41fa0257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This feature is meant to unblock PSTATE for certain high end display
configs on dcn315. This is achieved by allocating CRB to detile buffer
based on display requirements to meet pstate latency hiding needs.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  1 +
 .../amd/display/dc/dcn315/dcn315_resource.c   | 97 ++++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 25 ++++-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  3 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 39 +++++---
 .../drm/amd/display/dc/dml/display_mode_vba.c |  6 ++
 6 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 7e7cd5b64e6a..7445ed27852a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -103,6 +103,7 @@ static void dcn31_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigne
 	default:
 		break;
 	}
+	DC_LOG_DEBUG("Set DET%d to %d segments\n", hubp_inst, det_size_segments);
 	/* Should never be hit, if it is we have an erroneous hw config*/
 	ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
 			+ hubbub2->det3_size + hubbub2->compbuf_size_segments <= hubbub2->crb_size_segs);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 41c972c8eb19..42a0157fd813 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -136,6 +136,9 @@
 
 #define DCN3_15_MAX_DET_SIZE 384
 #define DCN3_15_CRB_SEGMENT_SIZE_KB 64
+#define DCN3_15_MAX_DET_SEGS (DCN3_15_MAX_DET_SIZE / DCN3_15_CRB_SEGMENT_SIZE_KB)
+/* Minimum 2 extra segments need to be in compbuf and claimable to guarantee seamless mpo transitions */
+#define MIN_RESERVED_DET_SEGS 2
 
 enum dcn31_clk_src_array_id {
 	DCN31_CLK_SRC_PLL0,
@@ -1636,21 +1639,57 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+static int source_format_to_bpp (enum source_format_class SourcePixelFormat)
+{
+	if (SourcePixelFormat == dm_444_64)
+		return 8;
+	else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16)
+		return 2;
+	else if (SourcePixelFormat == dm_444_8)
+		return 1;
+	else if (SourcePixelFormat == dm_rgbe_alpha)
+		return 5;
+	else if (SourcePixelFormat == dm_420_8)
+		return 3;
+	else if (SourcePixelFormat == dm_420_12)
+		return 6;
+	else
+		return 4;
+}
+
+static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct resource_context *res_ctx = &context->res_ctx;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+
+		/*Don't apply if MPO to avoid transition issues*/
+		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state != res_ctx->pipe_ctx[i].plane_state)
+			return false;
+	}
+	return true;
+}
+
 static int dcn315_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate)
 {
-	int i, pipe_cnt;
+	int i, pipe_cnt, crb_idx, crb_pipes;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
+	int remaining_det_segs = max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB;
+	bool pixel_rate_crb = allow_pixel_rate_crb(dc, context);
 
 	DC_FP_START();
 	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0, pipe_cnt = 0, crb_pipes = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1671,6 +1710,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
+			/* Ceil to crb segment size */
+			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
+					&context->bw_ctx.dml.soc, timing->pix_clk_100hz, bpp, DCN3_15_CRB_SEGMENT_SIZE_KB);
+			if (approx_det_segs_required_for_pstate <= 2 * DCN3_15_MAX_DET_SEGS) {
+				bool split_required = approx_det_segs_required_for_pstate > DCN3_15_MAX_DET_SEGS;
+				split_required = split_required || timing->pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
+				split_required = split_required || (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+				if (split_required)
+					approx_det_segs_required_for_pstate += approx_det_segs_required_for_pstate % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override = approx_det_segs_required_for_pstate;
+				remaining_det_segs -= approx_det_segs_required_for_pstate;
+			} else
+				remaining_det_segs = -1;
+			crb_pipes++;
+		}
 		DC_FP_END();
 
 		if (pipes[pipe_cnt].dout.dsc_enable) {
@@ -1689,16 +1745,49 @@ static int dcn315_populate_dml_pipes_from_context(
 				break;
 			}
 		}
-
 		pipe_cnt++;
 	}
 
+	/* Spread remaining unreserved crb evenly among all pipes, use default policy if not enough det or single pipe */
+	if (pixel_rate_crb) {
+		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &res_ctx->pipe_ctx[i];
+			if (!pipe->stream)
+				continue;
+
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
+				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+				if (remaining_det_segs < 0 || crb_pipes == 1)
+					pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
+					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+					/* Clamp to 2 pipe split max det segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+				}
+				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+					/* If we are splitting we must have an even number of segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				}
+				/* Convert segments into size for DML use */
+				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+				crb_idx++;
+			}
+			pipe_cnt++;
+		}
+	}
+
 	if (pipe_cnt)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 				(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / pipe_cnt) * DCN3_15_CRB_SEGMENT_SIZE_KB;
 	if (context->bw_ctx.dml.ip.det_buffer_size_kbytes > DCN3_15_MAX_DET_SIZE)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_15_MAX_DET_SIZE;
-	ASSERT(context->bw_ctx.dml.ip.det_buffer_size_kbytes >= DCN3_15_DEFAULT_DET_SIZE);
+
 	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 59836570603a..19d034341e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, active_hubp_count = 0;
+	int i, pipe_idx, total_det = 0, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -563,6 +563,18 @@ void dcn31_calculate_wm_and_dlg_fp(
 			if (context->res_ctx.pipe_ctx[i].stream)
 				context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 	}
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		context->res_ctx.pipe_ctx[i].det_buffer_size_kb =
+				get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		if (context->res_ctx.pipe_ctx[i].det_buffer_size_kb > 384)
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb /= 2;
+		total_det += context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
+		pipe_idx++;
+	}
+	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
@@ -815,3 +827,14 @@ int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc)
 {
 	return soc->clock_limits[0].dispclk_mhz * 10000.0 / (1.0 + soc->dcn_downspread_percent / 100.0);
 }
+
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb)
+{
+	/* Roughly calculate required crb to hide latency. In practice there is slightly
+	 * more buffer available for latency hiding
+	 */
+	return (int)(soc->dram_clock_change_latency_us * pix_clk_100hz * bpp
+					/ 10240000 + seg_size_kb - 1) /	seg_size_kb;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index 687d3522cc33..8f9c8faed260 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -47,6 +47,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc);
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb);
 
 int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
 					  struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 330b089d6a86..01603abd75bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -532,7 +532,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByte[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -3118,7 +3119,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->SurfaceWidthC[k],
 				v->SurfaceHeightY[k],
 				v->SurfaceHeightC[k],
-				v->DETBufferSizeInKByte[0] * 1024,
+				v->DETBufferSizeInKByte[k] * 1024,
 				v->BlockHeight256BytesY[k],
 				v->BlockHeight256BytesC[k],
 				v->SurfaceTiling[k],
@@ -3313,7 +3314,8 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	CalculateSwathAndDETConfiguration(
 			false,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			dummy1,
 			dummy2,
 			v->SourceScan,
@@ -3779,14 +3781,16 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 		&v->VReadyOffsetPix[k]);
 }
 
-static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int *DETBufferSizeInKByte)
+static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
 {
 	int i, total_pipes = 0;
 	for (i = 0; i < NumberOfActivePlanes; i++)
 		total_pipes += NoOfDPPThisState[i];
-	*DETBufferSizeInKByte = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
-	if (*DETBufferSizeInKByte > DCN3_15_MAX_DET_SIZE)
-		*DETBufferSizeInKByte = DCN3_15_MAX_DET_SIZE;
+	DETBufferSizeInKByte[0] = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
+	if (DETBufferSizeInKByte[0] > DCN3_15_MAX_DET_SIZE)
+		DETBufferSizeInKByte[0] = DCN3_15_MAX_DET_SIZE;
+	for (i = 1; i < NumberOfActivePlanes; i++)
+		DETBufferSizeInKByte[i] = DETBufferSizeInKByte[0];
 }
 
 
@@ -4026,7 +4030,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	CalculateSwathAndDETConfiguration(
 			true,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			v->MaximumSwathWidthLuma,
 			v->MaximumSwathWidthChroma,
 			v->SourceScan,
@@ -4166,6 +4171,10 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
 					v->DISPCLK_DPPCLK_Support[i][j] = false;
 				}
+				if (mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[k] > DCN3_15_MAX_DET_SIZE && v->NoOfDPP[i][j][k] < 2) {
+					v->MPCCombine[i][j][k] = true;
+					v->NoOfDPP[i][j][k] = 2;
+				}
 			}
 			v->TotalNumberOfActiveDPP[i][j] = 0;
 			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
@@ -4642,12 +4651,13 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
 			}
 
-			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315)
-				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, &v->DETBufferSizeInKByte[0]);
+			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315 && !v->DETSizeOverride[0])
+				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, v->DETBufferSizeInKByte);
 			CalculateSwathAndDETConfiguration(
 					false,
 					v->NumberOfActivePlanes,
-					v->DETBufferSizeInKByte[0],
+					mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+					v->DETBufferSizeInKByte,
 					v->MaximumSwathWidthLuma,
 					v->MaximumSwathWidthChroma,
 					v->SourceScan,
@@ -6611,7 +6621,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByteA[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -6695,6 +6706,10 @@ static void CalculateSwathAndDETConfiguration(
 
 	*ViewportSizeSupport = true;
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
+		unsigned int DETBufferSizeInKByte = DETBufferSizeInKByteA[k];
+
+		if (DETSharedByAllDPP && DPPPerPlane[k])
+			DETBufferSizeInKByte /= DPPPerPlane[k];
 		if ((SourcePixelFormat[k] == dm_444_64 || SourcePixelFormat[k] == dm_444_32 || SourcePixelFormat[k] == dm_444_16 || SourcePixelFormat[k] == dm_mono_16
 				|| SourcePixelFormat[k] == dm_mono_8 || SourcePixelFormat[k] == dm_rgbe)) {
 			if (SurfaceTiling[k] == dm_sw_linear
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index f9653f511baa..2f63ae954826 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -571,6 +571,10 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
 		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
 		mode_lib->vba.DETSizeOverride[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		if (src->det_size_override)
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		else
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = ip->det_buffer_size_kbytes;
 		//TODO: Need to assign correct values to dp_multistream vars
 		mode_lib->vba.OutputMultistreamEn[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_en;
 		mode_lib->vba.OutputMultistreamId[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_id;
@@ -785,6 +789,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 					mode_lib->vba.pipe_plane[k] =
 							mode_lib->vba.NumberOfActivePlanes;
 					mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes]++;
+					if (src_k->det_size_override)
+						mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src_k->det_size_override;
 					if (mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes]
 							== dm_horz) {
 						mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] +=
-- 
2.39.2

