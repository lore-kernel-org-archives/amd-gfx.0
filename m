Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCAAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A7310E625;
	Wed, 25 May 2022 16:20:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A2A10EE21
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH0Uh04maWF8HVS+SOC4alDimcsZPRi+o5W7FQTekWC6D/xvqaU8Rdw+3FA1uC13FOEGPShKk4dswFKUVhk6fuSXhEVN7NLuYqnRoDxblw1Ii+aubzO422h4gL0q5TXIOc90ICfFXHvCTDuFlzlgAvk2p5+P2wytk77KxBSf6Mj8rdudXP5DrG1NSt+y6R9yyjHItjqr2SWAOdsYzwZnF//xUMnJUeSWQCYH4gU08ku6ztxO6TzWrHk4PuUjbg6p1fKhxQVxdpgAW+onxXlNEbFLnLCOhyWv3SY9GaQ+sUCv03q5rTXqxBbjaTMbQnZT0mHU9s8zxPXcSF8oQ5W4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owljQXYRC8/EVG9dAmR0ytkfDC2rioq93bKoactffzg=;
 b=hKD40h2pldWXqf5Q8vaZp3JeisWMf0XyP9QA7/igLnxt0YnLM/P5n/Pm2DDbegyzNdzpdqstNgfFQZhN7EDu3DQwJ2hy3gi5RLPzwALgUgJAzXibYsi4uQW5BuIfAHU/ab7r4+60I9nJy5YWLbgkrYOhMQSMlCR4f6OWMxlr7AR+QvBpbRxyGuDJroWO8l5tPLU816uGyF3ydznuwwnEUjXTT/1D1/poZLmiMr4HMmYI9MdUjTrDfIxy2mFzHm97RZ9RQMk5hY3ZF3ea4baPabAi02raXY9KuhYN7Mw3OpqkZqOQDHUnjknF0VSH/8HEeSDD7FWw8IS8bWWpOC+ZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owljQXYRC8/EVG9dAmR0ytkfDC2rioq93bKoactffzg=;
 b=JQINyTEc71wTpynqpP+sGj/GMSTIhdP6w3h7V6DK0oi/IvfQiBm0SR967uVmH77UQ6UMopth20MlZwr82p5MPkI4D7IoWALx/3ai7DXkQfLIp9k10sX3jdvpiiS5JLIQb41BjYXzaTbG99hsSCRNjoLhJKlKsw5S0vjgI2IJngw=
Received: from DM5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:3:d4::26) by
 BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:15 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::c1) by DM5PR05CA0016.outlook.office365.com
 (2603:10b6:3:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/43] drm/amd/display: Various DML fixes to enable higher
 timings
Date: Wed, 25 May 2022 12:19:17 -0400
Message-ID: <20220525161941.2544055-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8157f9f-5696-4d93-f82b-08da3e6a737e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5382:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB538200644799417CFB814C89F7D69@BN9PR12MB5382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcsMSD25pX4rNDmD+gu5MKs9q5BVk7R7E48OJPUQBK7MZTNaRg9oAyqplPp7LaeEC+XlZcJfwgYHlYrNyM8mxROJXGha1MaShT71TPGg5TPj6bo1eo1bEyym+3QERHrKI3sF+nfjv6TyguYyDtP2xcaIJt6rwu68OfjEX4El5bUUfXiD6b/ebkNMfvYXfofqNG2LS0UHhbMJYXsJdsDkI7GDoZ1lQ9Vk7Rxb15W8dOglU39jwSFwoynoQqjsQJ3s6mBeztPXFETnEcpT3rMQJ/44ySuEwlO21Cbg6Uq/gDCmEp3m/Go8mtxblM53qDihXpBcLSDwba+hIJyXl8TrTvg4fVd3XmpuNU5D/zzT72d9NwMBhqHyz7mTCfHSJThZcedbvLyECZ7Hse26d2SbM7hkRi0yzeA2Rj5lXl/NWDfPjUU7ynmN1kZmjYil/JBzGOKgUC+QvkN7G9U32mbMRN8OuA6zTCaP+T79nKz3Qrm9qWkP4S1t1VOZuGHHq6Fkhc47kC1xTFB3mxH0Z5Nbb1wtiLSmVD+V2eg3rHhOHD6adVnGs6FjyolSuZ3loDLkk3JhRgiLK8U5YUXOkE4DLus03yZkJnCa6LBszk96hZXW+YyUgx2BV+IiidOFyQkrNT1WLbRZ2f0CV08QeGTDoIkfw8FjEP5kMWJVgjiO2vRylAbKWDMeqx/RLp3kyhjWHZ+EqQTBvCKYNx2Wk/0ekg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(16526019)(186003)(4326008)(26005)(81166007)(82310400005)(316002)(47076005)(426003)(336012)(2616005)(1076003)(36756003)(2906002)(83380400001)(6916009)(5660300002)(86362001)(36860700001)(54906003)(356005)(40460700003)(8936002)(508600001)(70586007)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:15.0409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8157f9f-5696-4d93-f82b-08da3e6a737e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Fixes to enable higher rate timings for DCN3.2.x.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  4 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 33 ++++++++++++-------
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 27 ++-------------
 3 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 27813374f2bb..99eb239bbc7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -65,7 +65,7 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_SET_2(COMPBUF_RESERVED_SPACE, 0,
 			COMPBUF_RESERVED_SPACE_64B, hubbub2->pixel_chunk_size / 32,
 			COMPBUF_RESERVED_SPACE_ZS, hubbub2->pixel_chunk_size / 128);
-	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x17F);
+	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
 static void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
@@ -119,8 +119,8 @@ static void dcn32_program_compbuf_size(struct hubbub *hubbub, unsigned int compb
 		ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
 				+ hubbub2->det3_size + compbuf_size_segments <= hubbub2->crb_size_segs);
 		REG_UPDATE(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, compbuf_size_segments);
-		REG_WAIT(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, compbuf_size_segments, 1, 100);
 		hubbub2->compbuf_size_segments = compbuf_size_segments;
+		ASSERT(REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &compbuf_size_segments) && !compbuf_size_segments);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ca9da3d4b1b5..8a10a7a4c3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3015,13 +3015,30 @@ int dcn32_populate_dml_pipes_from_context(
 		}
 		pipe_cnt++;
 	}
-	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE;
 
-	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
-		if (!is_dual_plane(pipe->plane_state->format)) {
-			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
-			pipes[0].pipe.src.unbounded_req_mode = true;
+	switch (pipe_cnt) {
+	case 1:
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE;
+		if (pipe->plane_state && !dc->debug.disable_z9_mpc) {
+			if (!is_dual_plane(pipe->plane_state->format)) {
+				context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE;
+				pipes[0].pipe.src.unbounded_req_mode = true;
+				if (pipe->plane_state->src_rect.width >= 5120 &&
+					pipe->plane_state->src_rect.height >= 2880)
+					context->bw_ctx.dml.ip.det_buffer_size_kbytes = 320; // 5K or higher
+			}
 		}
+		break;
+	case 2:
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE / 2; // 576 KB (9 segments)
+		break;
+	case 3:
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE / 3; // 384 KB (6 segments)
+		break;
+	case 4:
+	default:
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE; // 256 KB (4 segments)
+		break;
 	}
 
 	return pipe_cnt;
@@ -3283,7 +3300,6 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 	 * possible with firmware driven vertical blank stretching.
 	 */
 	// context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
-
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
 	if (context->bw_ctx.dml.vba.FCLKChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_fclock_change_unsupported)
@@ -3339,11 +3355,6 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
-		/* cstate disabled on 201 */
-//		if (dc->ctx->dce_version == DCN_VERSION_2_01)
-//			cstate_en = false;
-
-
 		context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg_v2(&context->bw_ctx.dml,
 				&context->res_ctx.pipe_ctx[i].dlg_regs, &context->res_ctx.pipe_ctx[i].ttu_regs, pipes,
 				pipe_cnt, pipe_idx);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 8d4c74b0fc90..eeec40f6fd0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1018,31 +1018,8 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.dest.pixel_rate_mhz *= 2;
 		pipes[pipe_cnt].pipe.dest.otg_inst = res_ctx->pipe_ctx[i].stream_res.tg->inst;
 		pipes[pipe_cnt].dout.dp_lanes = 4;
-		if (res_ctx->pipe_ctx[i].stream->link) {
-			switch (res_ctx->pipe_ctx[i].stream->link->cur_link_settings.link_rate) {
-			case LINK_RATE_HIGH:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_hbr;
-				break;
-			case LINK_RATE_HIGH2:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_hbr2;
-				break;
-			case LINK_RATE_HIGH3:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_hbr3;
-				break;
-			case LINK_RATE_UHBR10:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_uhbr10;
-				break;
-			case LINK_RATE_UHBR13_5:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_uhbr13p5;
-				break;
-			case LINK_RATE_UHBR20:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_uhbr20;
-				break;
-			default:
-				pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_na;
-				break;
-			}
-		}
+		if (res_ctx->pipe_ctx[i].stream->link)
+			pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_na;
 		pipes[pipe_cnt].dout.is_virtual = 0;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
-- 
2.35.3

