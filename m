Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59100C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DDB10E625;
	Tue, 10 Jan 2023 16:57:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B9610E613
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjfsxHOQRs4oe7jrpExq7l0wHtrtVLk2Dkgi0WBERgJtmWmPiOXE3n/yIS/+DIa7laKoN22BkdG5CxS+H9ODzZ1PSSDyOqSQUEHQ1amF99FhyBISJxTKehIv84J1jTZbRPiBu2ueUMahNseUqOQOpOFc3BUIOBk4VFAiSSf5yijEqfOdh3vAkT4dmzVUYoi7vb1ZfcL1vxN4KEBCK010/2R9bbVdqxBsW08gFhFHEIQhSf38Gfru1J6aUZGsp+IbfpyziZnkLnPypVzMfCo7QOynixKcFvbyaDoM93YnsnrkKT883otTZJVnLpYUA43kHM18Q/6OKFnX4Gl044vK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0f8Fqmn5hP9In2x26ZsJQr2EQPTTztDtHmgA3SKpKY=;
 b=k7Dl6ITOLnhNoz68hLs+atBL+cXy+8NkQEMTLmP0BhxUWVsoO2jMqguKhuhWunliePa9S6Yc6KBhDtXbJLFIN5i6F0UnDE1903cdJXHe4MsNA7tFhlO7/0StSOqJEV1hQCZfyHssKaHN4AekQAakAhVOf3ODGecbr6a3AVuRvTrZrwL9ARg6vo3Y+auERztGZ1Upj10vmexcgxsuPFdCE5RK1pv6yn4yP0wmoERGh31M6V39f93yr65nX7ITB5XQftg8H9TTBvjaVX/SBNZGL1774aQrLaPGPHCc7n23h0lHl+SU8ts4JR08Jpgx+gQS1iGIcFyYIY06RDS1xEUeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0f8Fqmn5hP9In2x26ZsJQr2EQPTTztDtHmgA3SKpKY=;
 b=JEsRXAKlfSMByvBtDXQPEYNHlv8GNrh+r9gqH8QH0eN8C0mWE9zU+hKsws0KvTdzGXs1KRAsP1kHYhQcpoS2dOgL32Aj2Jo6OgfwqfQNSQ23Am0AvCi7R0hz9hk610fBroUWfC1G3EvAPiGh8vLCk2BQ2oNsUbcSOogzq8lAqhY=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:16 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e3) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:15 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/37] drm/amd/display: Optimize subvp and drr validation
Date: Tue, 10 Jan 2023 11:55:10 -0500
Message-ID: <20230110165535.3358492-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8d290e-c958-4e46-552a-08daf32bba26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rC6+wqErNun/xIvwpRWte/RMKAz89mD4ZDw7qUrzKuFuOzFqzM1aZYNg4VUXsIzNlvNCblws76eUMymU9c/NAo1ngviJCKdNrvXysuwoguNUgux5RxO4J+31ihmFc72fjDfie0krJXuXCTkpvJtAiryh2CA+fkGjijcvO8ihv5dfd0bNbasf1AWJjExvyIQ2+i8nexzlg1ekGyYl2umXbDmTV9T7gtAng4ljQEegZfsEaiiXzry1Jq6A2K23EMkWd7mt1xeHRziAIiNqvG5HDOaWQUIgHJ0MDQTOFdbTW2w1tPcIZHvVrd9Cl38sFrkkQLmp2dFprWd/msD07bwswKklbF1si4JVWy+cLANreViP1GY22bpgmgZNyLysFuRPz5oX8eoQPLLSAuoNQzj7xx9JHdJejMeR86CT7+WTsSKr5IGNFghIODsI1+v8LHfmcPjXVvhhJ8egLi3d5wiKVq1xNDXApzylaRFVdC27nMH9Y9So7104nTJnelX0ZbK4OzfrfMwIUX46Gwr3G1mj9HaaczU5aFl2leSpz1t0QNGwGkmc458drHTsPg9jRUqhIx5rZT8xsUPr5HIV5FtzGA9ifmxgSom2gptNG73IjMYTR6SJ+RV4NifIzLrroeowzQbbdMLN4S3QVLF+CTiQI6SDGlnmoINy+1EErrbcEo2qcaWMHbqua1d3mbCmdnTnlPsP7bJF/EdvDS+0CkFGs8Qq8HesXnoxA5LHMvcz2Sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(54906003)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:15.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8d290e-c958-4e46-552a-08daf32bba26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

Two issues existed:
1) Configs that support DRR, but have it disabled will fail subvp+vblank
validation incorrectly. Use subvp+vblank path for this case.
2) Configs that support DRR and have it enabled can use higher voltage level
than required if they also support subvp+vblank. Use lowest supported voltage
level for this case.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 42 ++++++++++++-------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 025139a22e84..0c7ddd6f05b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -977,13 +977,12 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe->stream->mall_stream_config.type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	// Use ignore_msa_timing_param flag to identify as DRR
-	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
-		// SUBVP + DRR case -- don't enable SubVP + DRR for HDMI VRR cases
-		if (context->res_ctx.pipe_ctx[vblank_index].stream->allow_freesync)
-			schedulable = subvp_drr_schedulable(dc, context, &context->res_ctx.pipe_ctx[vblank_index]);
-		else
-			schedulable = false;
+	// Use ignore_msa_timing_param and VRR active, or Freesync flag to identify as DRR On
+	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param &&
+			(context->res_ctx.pipe_ctx[vblank_index].stream->allow_freesync ||
+			context->res_ctx.pipe_ctx[vblank_index].stream->vrr_active_variable)) {
+		// SUBVP + DRR case -- only allowed if run through DRR validation path
+		schedulable = false;
 	} else if (found) {
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
@@ -1087,12 +1086,12 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 {
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	unsigned int dc_pipe_idx = 0;
+	int i = 0;
 	bool found_supported_config = false;
 	struct pipe_ctx *pipe = NULL;
 	uint32_t non_subvp_pipes = 0;
 	bool drr_pipe_found = false;
 	uint32_t drr_pipe_index = 0;
-	uint32_t i = 0;
 
 	dc_assert_fp_enabled();
 
@@ -1186,11 +1185,11 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported
 			    && subvp_validate_static_schedulability(dc, context, *vlevel)) {
 				found_supported_config = true;
-			} else if (*vlevel < context->bw_ctx.dml.soc.num_states &&
-					vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
-				/* Case where 1 SubVP is added, and DML reports MCLK unsupported. This handles
-				 * the case for SubVP + DRR, where the DRR display does not support MCLK switch
-				 * at it's native refresh rate / timing.
+			} else if (*vlevel < context->bw_ctx.dml.soc.num_states) {
+				/* Case where 1 SubVP is added, and DML reports MCLK unsupported or DRR is allowed.
+				 * This handles the case for SubVP + DRR, where the DRR display does not support MCLK
+				 * switch at it's native refresh rate / timing, or DRR is allowed for the non-subvp
+				 * display.
 				 */
 				for (i = 0; i < dc->res_pool->pipe_count; i++) {
 					pipe = &context->res_ctx.pipe_ctx[i];
@@ -1207,6 +1206,15 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 				// If there is only 1 remaining non SubVP pipe that is DRR, check static
 				// schedulability for SubVP + DRR.
 				if (non_subvp_pipes == 1 && drr_pipe_found) {
+					/* find lowest vlevel that supports the config */
+					for (i = *vlevel; i >= 0; i--) {
+						if (vba->ModeSupport[i][vba->maxMpcComb]) {
+							*vlevel = i;
+						} else {
+							break;
+						}
+					}
+
 					found_supported_config = subvp_drr_schedulable(dc, context,
 										       &context->res_ctx.pipe_ctx[drr_pipe_index]);
 				}
@@ -1849,7 +1857,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
-	bool is_subvp_p_drr = true;
+	bool is_subvp_p_drr = false;
 
 	dc_assert_fp_enabled();
 
@@ -1857,7 +1865,8 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	if (subvp_in_use) {
 		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
 		if (!pstate_en) {
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+			context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final = dm_prefetch_support_fclk_and_stutter;
 			pstate_en = true;
 			is_subvp_p_drr = true;
 		}
@@ -1875,8 +1884,9 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 							dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+		maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 		if (is_subvp_p_drr) {
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
 		}
 	}
 
-- 
2.39.0

