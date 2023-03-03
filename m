Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7272BC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179E910E6E4;
	Fri,  3 Mar 2023 15:51:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FF110E6E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQyMuqulnyNTArLDzza38SmQwbs4s2rq6mQleAsIMNxg0PvBF+SqpqIgzhYtvvpVomBefgfs3yzBRLkCNR0yz1m3KVCDxLM/8F3AOlLeQQPlhd4DnXcprxTyZ2rA6L9lBHNE0+qqYOYtPKg3vA62cjxSl9Fwpm8XQAcDsHJ50C1yeVxzR0EtJ84IdNkY5l+JdjIVWdzfbQOIwpIJOu8b1AJdY2Wu5nPBpGebOlhOJJGRLay7hvEcNhngGjtzKOcNf0Qi9aK90JKsh3LCwDEVWnCas70npiIzxpcWh4bd4u+b1kOS2xXtjuwwHyOHLNUBGMr26Ydu42bt1jTJNHLTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI6TvfeiE42iEBtEtEftMJLLp2mTnE28KlvoQSMk2nU=;
 b=g/gQ84fCv05UR1xbYSlOAaL57LButkUhwv7WfV+qtj8nwksRyP8TEzDMCnGy3QGkv6f+Y7SI+Zmg61pHFOJQ1hhiVgscHb+LUdpMDjAiH2U9N6vzaVWLyn0C7EPqxTZmE8dfQ7YpP+BrAo/QHa2I/bq79gD54JIWPngmZh7ut0BmQXz1rs1RYlDv+ymtqKSlbl3AoFyhzW5z5sSEtCYQIEqyYmLez9fbDW9HlUrGo8Rh9I3xy260vP+EC9WP1PTgRVgLZfbB7P0PXX9RT3gIhMYkihr/sdphydNdMl/wpCbvmejyPY+4OR7lbtKyOvh6GvTbk4F6cHgZO1SfYhYupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI6TvfeiE42iEBtEtEftMJLLp2mTnE28KlvoQSMk2nU=;
 b=4vRqOiu8QXpGqpI4jMZc8cz+pK0kgg3yQSaqPwkj88+vyGMtQdEx9UN/lQx+CUbsC2MFsJ/KtBofxBdILp97kzYQcIa5p65AFFJGDLvsat07EhIUBhf5jko0BYwTWd41RauzXqfheQwvSfGFrnkO6R+56sAnsuUTLB9okDwE0p0=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 15:51:30 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::38) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:19 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/33] drm/amd/display: Pass tg and hubp inst instead of pipe
 index for SubVP
Date: Fri, 3 Mar 2023 10:40:15 -0500
Message-ID: <20230303154022.2667-27-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b737133-0536-4101-151e-08db1bff27fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzAcPoF+kfToMOVfqp1DguP4Z3xadPDM8wUjqK+S4jQqY3niJtigOJsvfBiUuWD9DfcHZrgMUZHBudAQHuyNboc7ysrrGSX+ZscSj4LnQoq96QzZIompIV6H2cgV0OKRnlTOzEZEuVYRRqJH4YkfjOlWIqTC/M7Gkg3K1BukBtyAlyN25pFO6CrDVl3j7Gd00qxV591boq1roBO2uiNmxFPUbzgfPSE7TP1OYPvsaq6E2wSOaKwRcRso2vkulMVWdRt0Cr91v68UiwgeyRarvTJ+f/Pu0xqqhQCm8Cqq99Ypl1DVR2PPiQyw8qzOMHyba4a+NSwTDTc3GqrgdBno0ndmFK6OxBk2Uwr3yG8x9qQO/ISHrE8SGGcE1uh4OcFaZQVw/eS3yYHMTD8rCFuOtYVhsID3+9I40IVe2xBG4/8GuCwBmEM2abyMGKzYORu5qX1Qs6EEySllrEEml/UqVs2zCWJNFU+7/Zw5EIcdCApD710dUCrIkDHvZblxCQ9WxaDjsFjh2XNveHBXxb9zvTg+ibKVe0C8GjeJGkaE+YsPCtTs1SnNQSyuXfMcSM0Ip4uFaFxl+/VPOPdoN5qkIQUCR1zWR+As867XTTCU2AUTqOS3pQUWSTHBEVzDoqQDZxt7vQ9PmsxKdHh7U+PVSeWN/mKvyqpkw2Oqh+FkpBRuzHgv5mLt4BgN6Sz5GSkbx6mhVEFaw/nnwFzTTsr1UlQ+DAp7h9aNMKaJU9qJvAo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(478600001)(36860700001)(40460700003)(36756003)(426003)(1076003)(26005)(16526019)(186003)(47076005)(40480700001)(336012)(83380400001)(2616005)(82740400003)(6666004)(82310400005)(81166007)(8936002)(41300700001)(70586007)(70206006)(4326008)(8676002)(5660300002)(86362001)(6916009)(44832011)(316002)(356005)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:30.3783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b737133-0536-4101-151e-08db1bff27fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For pipe harvesting cases, the pipe index does not necessarily
  match up with the OTG instance, so pass index by OTG Instance instead
- For pipe split cases pass HUBP instance, since the split index is
  only used for HUBP programming
- Also check for OPP ID when accessing opp for pipe harvesting cases

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     | 30 +++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c |  8 +++---
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f9f051f1537d..7bbbe64185aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1079,6 +1079,7 @@ static void phantom_pipe_blank(
 	struct output_pixel_processor *opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
 	uint32_t otg_active_width, otg_active_height;
+	uint32_t i;
 
 	/* program opp dpg blank color */
 	color_space = COLOR_SPACE_SRGB;
@@ -1090,17 +1091,24 @@ static void phantom_pipe_blank(
 	/* get the OPTC source */
 	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
 	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
-	opp = dc->res_pool->opps[opp_id_src0];
-
-	opp->funcs->opp_set_disp_pattern_generator(
-			opp,
-			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
-			CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-			COLOR_DEPTH_UNDEFINED,
-			&black_color,
-			otg_active_width,
-			otg_active_height,
-			0);
+
+	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
+			opp = dc->res_pool->opps[i];
+			break;
+		}
+	}
+
+	if (opp && opp->funcs->opp_set_disp_pattern_generator)
+		opp->funcs->opp_set_disp_pattern_generator(
+				opp,
+				CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+				COLOR_DEPTH_UNDEFINED,
+				&black_color,
+				otg_active_width,
+				otg_active_height,
+				0);
 
 	if (tg->funcs->is_tg_enabled(tg))
 		hws->funcs.wait_for_blank_complete(opp);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 027f6ebe0496..b5c6501c28fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -637,7 +637,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.subvp_data.main_vblank_end =
 			main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
-	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->pipe_idx;
+	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->stream_res.tg->inst;
 	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param;
 
 	/* Calculate the scaling factor from the src and dst height.
@@ -679,11 +679,11 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
 
 		if (phantom_pipe->stream == subvp_pipe->stream->mall_stream_config.paired_stream) {
-			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->pipe_idx;
+			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->stream_res.tg->inst;
 			if (phantom_pipe->bottom_pipe) {
-				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->pipe_idx;
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->plane_res.hubp->inst;
 			} else if (phantom_pipe->next_odm_pipe) {
-				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->next_odm_pipe->pipe_idx;
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->next_odm_pipe->plane_res.hubp->inst;
 			} else {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0;
 			}
-- 
2.34.1

