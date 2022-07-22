Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F15C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876A78B589;
	Fri, 22 Jul 2022 20:38:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6838B4E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rskne8N5eKDNb6mq8IXLrw/xWZNte+78ejkSDOLbChiHG0M0toax+9l0BmHC26WyHE9ratEQz5mOvoI+Oi7D2RaFEONl3rWAWyv23J6WW7/IcMwb1xbKw4VVsTxqY6s/2cy4Tftw6gvtUdS+Boqeo1v5XtOl+C8m35LfqvKWC4DkdZkp80WsE5HzJgr7M8UHdm1HTqUmH4opEA1ViL6mAv67BBmn4i/UX7R4Nq3K2lFnfGCg1RVnS8k/NKXuEhS9qthtLFgyqaTu3HcDb1/yJEH6Xm+mbQGgSlwkixf8GicC0csKp6wbFmSBxVfdLJcTWVaYXZ6UJAO7GYDscbrwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTvu+Tnd6dgxbtYUdyXxEmKUadWZv7gN1P4lduHitF4=;
 b=c1ENEHmFIqbg+YdRfhG36sIjUpkFAlfHDQLmp2W4JYeBegIGQPbWMlsFUR4aqNcoMr3tkhG4AWjye9xEpiQ3bbEW647if5mOCpY8t13mgriwFMDRdki6OqvFYhN790q8Jk/H5Piwu8tRXFJA7SlztVTTTXjcJHSe0/hreqESSUSl02fqG/QOAYoiSAlXE98olyCnxOYKQ6qAHvSA2KPFjB8R24kS0AH92eqBP/kRgjM0kk/KoPzJ5VNiOShx+/0YjxrxcoF0dwPp5dUvMr+2Ui283McADevtO/TtGxEGZ+zu+m7YzzyGe6UfDVB7Qsiv/Wdx0sRz9Mm6MBsSDtlmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTvu+Tnd6dgxbtYUdyXxEmKUadWZv7gN1P4lduHitF4=;
 b=q2E70JMKi+pNjtKyP2/HMH6jFUsMJGW5806UOvob9iIpAWMluQhrWa5gV6Dpt0ZRrT9rNQb/nF+xyawNODiHeeiAgvXTam/s/ukAlZV750wgn0vkbELfJwHsWIUAPZtJCUjuyTixqVzpgriitGfLk7P/o77yYWO0+/ZzIyW2s74=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:38:20 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b8) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Fri, 22 Jul 2022 20:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:38:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:38:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/31] drm/amd/display: Updates SubVP and SubVP DRR cases
Date: Fri, 22 Jul 2022 14:31:10 -0600
Message-ID: <20220722203137.4043516-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a3842a-bd3b-4b02-b1de-08da6c221d70
X-MS-TrafficTypeDiagnostic: MN2PR12MB2896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDrpHggBSgzvV4+2xqvt4mdx1bTYfYPCNaWVH3upKZJxDt8HYRnnDQT1ZipimQT+0DZizWwx874+q+D8a7OqRbAMjOZmQkoEGjLnLa8BrAoEdeTT1MaM0ith7YuG2z1ovlh1ZtlCQ/m+Kc2QPCpY8LzhqWc2FHg6S3ibN8a3Q+rCgv0SudEY4yL6/ba25EJBqlmCtP81kvX46Kyi9qCXoYItCrGPl+nB46znwMZUxVXQuUKx7WBuSD7oxgDljaIfv9JUA9hdXvQ4e8K5ld2sn7Ql2+c8USrc73UjSxJpaLtaq4WrFKbjT5/5CnkYR/pLgeG/lPlvxbrTAfwVgqtkuAR9p8ZH56pEkBGfPMSh0b2AkpZWMdltZF8Yg946Aly2fZgMntCqJ1oiPE3XYU8J6s6nwO7BV9RySS5IL4a+ug4Ot0rIYPYi4fhTREUJNmvYR+QXAsqsOdD/yJnbgwu5aTC2fB+J1a9cGsVL/0JpwqaWeTZFLZtSxbZDW/a6QfErepj6kR7WbX7VU8E0cBUtVwmxzn/bmqISRCbkTuL2T7UCXkFskUhMZQfU+5XKPc/oG2P9PVxk7h1/LJRwJGKaboQJ7oCpIeSbK92WH0JHy9Z/pPXeclErZHNk3FOWWXveoYgQLuXO/gRoqFLtBsHpGcSqULAMUtj+GvfaZFzScfOW6C++UaFvwWg8IJA4TLLgoBz9ZPFhQgyOayKW7nwPUaRiB7XvmW3g8xN2cG0QZFA9iHDdeCoiUfiaAJ/VLZOIscPaGqkErNVKe5v0x1XoYR6JXucwvbenJ9A/ysXiFNnyxVLwmuzU6lfopGPALwG+AHyv9HaJTxd2tpnLcuyFwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(70206006)(40460700003)(8676002)(15650500001)(86362001)(2906002)(70586007)(5660300002)(81166007)(82740400003)(4326008)(478600001)(44832011)(8936002)(356005)(186003)(36860700001)(26005)(82310400005)(16526019)(426003)(2616005)(47076005)(1076003)(336012)(41300700001)(6916009)(316002)(40480700001)(54906003)(36756003)(6666004)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:38:20.3084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a3842a-bd3b-4b02-b1de-08da6c221d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2896
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For any DRR cases in SubVP, don't lock for VSYNC flips
- For DCN32/321 use FW to do DRR manual trigger programming
- Add bit in SubVP cmd to indicate if the SubVP pipe is DRR

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 17 +++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  7 +--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 63 ++++++++++++++++++-
 4 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 39b426d04037..2d61c2a91cee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -270,6 +270,23 @@ void dc_dmub_srv_drr_update_cmd(struct dc *dc, uint32_t tg_inst, uint32_t vtotal
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 }
 
+void dc_dmub_srv_set_drr_manual_trigger_cmd(struct dc *dc, uint32_t tg_inst)
+{
+	union dmub_rb_cmd cmd = { 0 };
+
+	cmd.drr_update.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
+	// TODO: Uncomment once FW headers are promoted
+	//cmd.drr_update.header.sub_type = DMUB_CMD__FAMS_SET_MANUAL_TRIGGER;
+	cmd.drr_update.dmub_optc_state_req.tg_inst = tg_inst;
+
+	cmd.drr_update.header.payload_bytes = sizeof(cmd.drr_update) - sizeof(cmd.drr_update.header);
+
+	// Send the command to the DMCUB.
+	dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
+}
+
 static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
 {
 	uint8_t pipes = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 1d124a2695d5..159782cd6659 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -74,6 +74,7 @@ void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
 void dc_dmub_srv_drr_update_cmd(struct dc *dc, uint32_t tg_inst, uint32_t vtotal_min, uint32_t vtotal_max);
 
+void dc_dmub_srv_set_drr_manual_trigger_cmd(struct dc *dc, uint32_t tg_inst);
 bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool enable_pstate, struct dc_state *context);
 
 void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b6bada383958..bf9ac9dfc7dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -424,7 +424,6 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 	unsigned int i = 0;
 	bool subvp_immediate_flip = false;
 	bool subvp_in_use = false;
-	bool drr_pipe = false;
 	struct pipe_ctx *pipe;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -440,12 +439,10 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		if (top_pipe_to_program->stream->mall_stream_config.type == SUBVP_MAIN &&
 				top_pipe_to_program->plane_state->flip_immediate)
 			subvp_immediate_flip = true;
-		else if (top_pipe_to_program->stream->mall_stream_config.type == SUBVP_NONE &&
-				top_pipe_to_program->stream->ignore_msa_timing_param)
-			drr_pipe = true;
 	}
 
-	if ((subvp_in_use && (should_lock_all_pipes || subvp_immediate_flip || drr_pipe)) || (!subvp_in_use && subvp_prev_use)) {
+	// Don't need to lock for DRR VSYNC flips -- FW will wait for DRR pending update cleared.
+	if ((subvp_in_use && (should_lock_all_pipes || subvp_immediate_flip)) || (!subvp_in_use && subvp_prev_use)) {
 		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
 		if (!lock) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 00ff21458a53..992e56c6907e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -26,9 +26,11 @@
 #include "dcn32_optc.h"
 
 #include "dcn30/dcn30_optc.h"
+#include "dcn31/dcn31_optc.h"
 #include "reg_helper.h"
 #include "dc.h"
 #include "dcn_calc_math.h"
+#include "dc_dmub_srv.h"
 
 #define REG(reg)\
 	optc1->tg_regs->reg
@@ -188,6 +190,65 @@ static void optc32_set_odm_bypass(struct timing_generator *optc,
 	optc1->opp_count = 1;
 }
 
+void optc32_setup_manual_trigger(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_set_drr_manual_trigger_cmd(dc, optc->inst);
+	else {
+		/*
+		 * MIN_MASK_EN is gone and MASK is now always enabled.
+		 *
+		 * To get it to it work with manual trigger we need to make sure
+		 * we program the correct bit.
+		 */
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_V_TOTAL_MIN_SEL, 1,
+				OTG_V_TOTAL_MAX_SEL, 1,
+				OTG_FORCE_LOCK_ON_EVENT, 0,
+				OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
+		// Setup manual flow control for EOF via TRIG_A
+		optc->funcs->setup_manual_trigger(optc);
+	}
+}
+
+void optc32_set_drr(
+	struct timing_generator *optc,
+	const struct drr_params *params)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	if (params != NULL &&
+		params->vertical_total_max > 0 &&
+		params->vertical_total_min > 0) {
+
+		if (params->vertical_total_mid != 0) {
+
+			REG_SET(OTG_V_TOTAL_MID, 0,
+				OTG_V_TOTAL_MID, params->vertical_total_mid - 1);
+
+			REG_UPDATE_2(OTG_V_TOTAL_CONTROL,
+					OTG_VTOTAL_MID_REPLACING_MAX_EN, 1,
+					OTG_VTOTAL_MID_FRAME_NUM,
+					(uint8_t)params->vertical_total_mid_frame_num);
+
+		}
+
+		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
+		optc32_setup_manual_trigger(optc);
+	} else {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
+
+		optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	}
+}
 
 static struct timing_generator_funcs dcn32_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
@@ -221,7 +282,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_vrr_m_const = optc3_set_vrr_m_const,
-		.set_drr = optc1_set_drr,
+		.set_drr = optc31_set_drr, // TODO: Update to optc32_set_drr once FW headers are promoted
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc3_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
-- 
2.37.1

