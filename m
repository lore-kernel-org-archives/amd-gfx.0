Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3F6C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3998110E5D1;
	Wed, 20 Dec 2023 16:36:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622AD10E5C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTC0YyUOcjs9EgMwHFikDqP6YgAY9cbnFy+hRQRu395JvDiVeky7Nae16jHb8i/QVEOoqJTvePjUcpavaaoqPTUQqOeFy5MUOoFgj3tGvGUk7YUgIMmiVH6w3R0zihUI2lLdrXXnIjhpMYux62ugZP2ByGIpg3B25l4V5QutiuGeFKIZBlUNlFuM2Xx0mzTLZoR28BEKOYfcRfZUFKMSx/QOOPK3Aa5fl1dzkr0My4cKDM4JGfk8edhh9lobsDlTssy6m1CHSaozM/kQ4B15YMH/xf2PLaK0KbEf73ktFHoWl9KMIRJZrMaYtIOrpBlHR9ShGM7tekG43epjDi56UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfK44kyyvHRXKxsRnbLc73tscnAHDTE1RkfKsLxrChc=;
 b=RKVSZtM4kQPUI01zPgsbyulEcCJYLwPHwg6Nj/GM2o1YUOF2YU8/l5muXJOTSlJN4AYVJD0rmK9RJvbPLatcB4kiX6EQ2mhkWGgvXZVci8jbSJCWF1iAC25wvxCUcH5HVkOoRJRWVfevOOBiLhVQ4eKUxy0aassiOzRJUezj6TS2+F0fPof92gaL+1LKNuFXfhQNQFJF0MClq8oyX+Bl0dl6r55Yu48fCjOVu5zAx7zyPV2+Oj9pZE1UAML8C3XE9xPKJGwG32uB3FdT2sDNzpg7p9QvGjDu0eBMcCQ8CDe+LJ3/zXfoE/sWKG3OkE+YCkOnAq7U8Q0FRoUArLJ1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfK44kyyvHRXKxsRnbLc73tscnAHDTE1RkfKsLxrChc=;
 b=OzeK7nEFhaLy4xGkY47lfWs05jaE6HmLTpI1fn9igTZcnVWy31PQZR3B0HsMWlLyXzC/LhSg2mfYkoDjqQR7jTTRDTYIPJu3RYfkY1Fs2JUyZouIL2ao1PEa+XdNwZWrUsL+EbdILqMAVwMVyDdBkL2U5Jy8spbIARb4c6aEubg=
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:47 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::c8) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 16:36:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:42 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/20] drm/amd/display: Don't allow FPO if no planes
Date: Wed, 20 Dec 2023 09:33:34 -0700
Message-ID: <20231220163538.1742834-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: c37af04e-a87a-4c5c-fdac-08dc0179db64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLnAaoBjLQLAv85ofRaUfsvP/klFfHYP392B4+hToqeF+l0sKKyWXAmQx3iFDgnzU+DFQV8yiSXlx2yplYzadGt0cfUKT8Foyb/mo6ssRbG6YQoxMcpUdpqYlB1tI9VUjVwGxBGOTfSv0/ML1c9AZij4h7O3AFTGekFKK8WfLNyhTJC93flkGyo6RDyCPcZJTBJF8w/PQ+/RRs2iNicEnvynpcsNRGnQtE/XXMIe+xm0xlDplLZKQ7K0TZ5/fYWOYpxst4fGqj5RfaK3jKkTtIrPHAZ23Cz+QayiP+VNY27tiBuTZI8fCCqtfWtQProdhs9Cpo5G7cGfUPL/DkPcaqmBdvsfbXyHGaAA/DBMgu7uOxFMPw511xduWGMuDJ6F+tALRvZO05x0ycXOTmGXX4FORvtT+80UkuDcVAIzWqZ3uUmJuLTI7nPIMQHY/9gWc8MwILVIYCe04JsVjH5vydQYgfHY0VX6rqj/t3/KhOXT3qBstVRKSoV+CoDReBiBZ5KE0QqpjFZ8AO56ucEMQhV/D+9M8gOkEpGu5SPK+HuxWEhxy2QKuJpSUl3ne7PipbwPqATwCG5R0SGDTPUhXd2+WfN32On0EzHwWLNJSpCPcuHudIKzbFLlHEJx8cv3v5bN/zCNxEgcW2JDEoYj+7ChSi6cgwIOh3iHfGRTdH0TjtNNMULvLXIh5MzqTimsymNk81/TLIOdiXignhGCbrmqapL5ycRUOYszRhwuQ07Y7gYqKJb7WzlRJwKEOn6Xr+Syhf65T+w6X6dHNaiulClr2wvBV+aLwzJt7y0SuCo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(16526019)(426003)(336012)(2616005)(478600001)(40480700001)(41300700001)(26005)(1076003)(36860700001)(81166007)(6916009)(54906003)(70586007)(70206006)(40460700003)(83380400001)(6666004)(316002)(86362001)(82740400003)(356005)(36756003)(8936002)(8676002)(47076005)(2906002)(5660300002)(4326008)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:46.2798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37af04e-a87a-4c5c-fdac-08dc0179db64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

In DCN32/321 FPO uses per-pipe P-State force. If there is no plane, then
then HUBP is power gated, in which case any programming in HUBP has no
effect and the pipe is always asserting P-State allow. This is contrary
to what we want to happen for FPO (FW should moderate the P-State
assertion), so block FPO if there's no plane for the FPO pipe.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c  | 18 +++++++++++++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 10 +++++++++-
 .../display/dc/resource/dcn32/dcn32_resource.h |  2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 1743ebcd6b2e..cca6436ecdf5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -524,13 +524,14 @@ static int get_refresh_rate(struct dc_stream_state *fpo_candidate_stream)
  *
  * Return: Pointer to FPO stream candidate if config can support FPO, otherwise NULL
  */
-struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, const struct dc_state *context)
+struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context)
 {
 	int refresh_rate = 0;
 	const int minimum_refreshrate_supported = 120;
 	struct dc_stream_state *fpo_candidate_stream = NULL;
 	bool is_fpo_vactive = false;
 	uint32_t fpo_vactive_margin_us = 0;
+	struct dc_stream_status *fpo_stream_status = NULL;
 
 	if (context == NULL)
 		return NULL;
@@ -559,10 +560,21 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 		DC_FP_END();
 		if (!is_fpo_vactive || dc->debug.disable_fpo_vactive)
 			return NULL;
-	} else
+	} else {
 		fpo_candidate_stream = context->streams[0];
+		if (fpo_candidate_stream)
+			fpo_stream_status = dc_state_get_stream_status(context, fpo_candidate_stream);
+	}
 
-	if (!fpo_candidate_stream)
+	/* In DCN32/321, FPO uses per-pipe P-State force.
+	 * If there's no planes, HUBP is power gated and
+	 * therefore programming UCLK_PSTATE_FORCE does
+	 * nothing (P-State will always be asserted naturally
+	 * on a pipe that has HUBP power gated. Therefore we
+	 * only want to enable FPO if the FPO pipe has both
+	 * a stream and a plane.
+	 */
+	if (!fpo_candidate_stream || !fpo_stream_status || fpo_stream_status->plane_count == 0)
 		return NULL;
 
 	if (fpo_candidate_stream->sink->edid_caps.panel_patch.disable_fams)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index cc759b34268b..9f37f717a1f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -3465,7 +3465,15 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
+		/* In DCN32/321, FPO uses per-pipe P-State force.
+		 * If there's no planes, HUBP is power gated and
+		 * therefore programming UCLK_PSTATE_FORCE does
+		 * nothing (P-State will always be asserted naturally
+		 * on a pipe that has HUBP power gated. Therefore we
+		 * only want to enable FPO if the FPO pipe has both
+		 * a stream and a plane.
+		 */
+		if (!pipe->stream || !pipe->plane_state)
 			continue;
 
 		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index b27fadd452bb..0c87b0fabba7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -163,7 +163,7 @@ void dcn32_determine_det_override(struct dc *dc,
 void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes);
 
-struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, const struct dc_state *context);
+struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
 
 bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe);
 
-- 
2.42.0

