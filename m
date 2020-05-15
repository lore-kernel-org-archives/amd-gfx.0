Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE46C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C2520657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3AWyAsvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C2520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6806ED17;
	Fri, 15 May 2020 18:13:53 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045586ED19
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl7wgcanHp9COIcov2gORc3xf43HIOku0tYRIv11lvLhdEvdVWiuYcWzkplRL2rccE1YxA4L4h4myWuac7Xr73pAjS/O1nk+ty1MAqIKECn6iAPz8wCHeK+gK303rxFjvhc669XI2V/dNjebHoKHl2VgBSh4qIVcBpW8gZF73FispO91Zyqlgl78FtXMxLEjotPpwPezX5r4wVbqUdh1paxdIpq16AWai/MyOQwcsuLUH36euGrhSz5kynJ4UkY6RE49JnPcKDcfq1e4gwJAMYMpdNKSyZjaOM4RRCEeyC96GrO5ZgTAO4wi4g1rXV8EVKcOmeDKAHgF9uAmXiDJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMrNl6Rt0e7h8hhTPgn3nNBPUTHsT88O7SR6x9MkeU4=;
 b=IubRXNtu7P4xJwz0NF/Rwb2Y5AYvWMOFCa7eX7VLcvTIahIw47Jb8eh6vaf4c0svbhBntXFujVq8MZRTjXVmw3DZloIxY722nZtqHBf+k1GSR9VQOxUfXemrswlKhadtNCbLLxDu6sz6n40akGZI1T1NvM6misVZbSNwr8p14CwVBkX5aT4uQc1LTe8jZA7Yx1Shm1Nasvp3wvTsdiZqm5x+VtqSik5ERvPL5U1YxMPC587fU/mGl/x0fu5exUu4rOpEfoeXxR6aysbxe0/AGucrhwBASBKw8fc2z7LnEU+mXwQhE685YdVqOcZ5hvUsJTDLC3gXdIHfmzRsh7gGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMrNl6Rt0e7h8hhTPgn3nNBPUTHsT88O7SR6x9MkeU4=;
 b=3AWyAsvbgUbrlj21Vf3/4Hg18mi9Sub6arU9JZR2hynIniqnHXZyhZyY+RTxZY4svr2Xe5uyB1nP5ZyRwguaMoXZrxldGCDbKELXIp2Ae4gG6rgJUoDJscbqYgcggnRngq0WjDHy2gl5s6aG6+xxQJ4UpuA4X0nVh7jVhgBZA3Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:46 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/27] drm/amd/display: Implement some asic specific abm call
 backs.
Date: Fri, 15 May 2020 14:12:56 -0400
Message-Id: <20200515181315.1237251-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:45 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e479159a-cd6d-4b7b-c373-08d7f8fbb581
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974B7E7BC00F47940E80C5F98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBx0hsokgyP7TBkaJMdVSwb63Nj/2TLdqkGqaJLnhycJchuzUFK+ns0CKwkItF+Ambyy6ZaXZXtq/Hqe8pgMAnzlBfUKPOuFDfymSJkKCJgqwQSVtdSl6rUTgZf3SedAfeTMbnxMDovw813N1utOW4mTNMUGbVv2s61aIwZ3j9vyXsY9yD5XPYNyrDJD9Gyr5qgMNN4F9jXixZJtNKuk5oOkEZGTOm4yYU2Z26/DkZOitrfNzQY0fPb/E7wO0Dz6bZ+E2cBoOI78UH0141xU9ui9PW4+m2gPi2QfPtQdykDCZx7grsNpIgWkQWZmXzkJy/y6KvWiPKEOk9LliZ0tLINiiK+AoiWoJjK+dFdh/F9TcJFlQaxHX+yfiXizp4q1qQqT2vKSgz4q6e2ZsNeR8Z/1l0PhjXCnLuSKpngS0sTcw8CY/7ehBcQjD4lHGPya
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(30864003)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CKpUWzfzqjgnId0IfxT+qdLdiR2aL23dEYClp6u8P+d/oraOxbMzoFRs4rWbXgdMBY5xNmmPKTuMSyVuG3ZIh+L0DRjDngOyv81P4EwJOW0EcWBkLThBNPuPxwAeTbzLXGDXqYtcsArlTtCy3kiHgbL2VBwWnYJ83KYljhfV7iN2GbYTcO79ZCJ/ZGuxRlRyfvznOUi/r4uMwnC1Ur9krD8sMzexu0XcQ7ZuJoO0KH1DCYuMs46A3bCcsO1eLURqrvRKAiyAXikXJdvqYGRp29hDWr8zGJ2rKMeuBshVx91pPAM2aAn2RMkxeaqav7mUI9HQxPkKz7oLx+8QutkOmTh3pjzlbRzTMxMceRw7k8Y/JXtg7KS+1E9EtQ2b/tlYYhHG/PqX1LeryOTF2/jZeCrWFtmAFig4QknfXER3RFqF0z6sq28uLM2PYGW+hIy3fQ7tfq3q5khNrEXlg3tbHDtkAU+s5xv9gwGOpN56vBDmMHo22darHw3tgEzib60qFrZRvt6RvNcopBffBkTO6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e479159a-cd6d-4b7b-c373-08d7f8fbb581
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:46.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD0KFdeJPbrouerEXKVk4VM7cwkZdNZQF3Xd85JCBKxo1wKjpKl7n/WV5QTexVQjhMx6oCDC+s4nYa1G3oeDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Implement abm set_pipe call stacks
Have some asics speicifc call stacks for abm.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 92 -------------------
 .../display/dc/dce110/dce110_hw_sequencer.c   | 11 +++
 .../display/dc/dce110/dce110_hw_sequencer.h   |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 89 ++++++++++++++++++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.h    |  6 ++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  5 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +
 12 files changed, 120 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index da0b29abfbda..0cf130dc4e52 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -50,71 +50,7 @@
 
 #define DISABLE_ABM_IMMEDIATELY 255
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t panel_inst)
-{
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
-
-	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
-	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
-	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
-
-	return true;
-}
-
-static void dmcub_set_backlight_level(
-	struct dce_abm *dce_abm,
-	uint32_t backlight_pwm_u16_16,
-	uint32_t frame_ramp,
-	uint32_t otg_inst,
-	uint32_t panel_inst)
-{
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = dce_abm->base.ctx;
-	unsigned int backlight_8_bit = 0;
-	uint32_t s2;
-
-	if (backlight_pwm_u16_16 & 0x10000)
-		// Check for max backlight condition
-		backlight_8_bit = 0xFF;
-	else
-		// Take MSB of fractional part since backlight is not max
-		backlight_8_bit = (backlight_pwm_u16_16 >> 8) & 0xFF;
-
-	dmub_abm_set_pipe(&dce_abm->base, otg_inst, panel_inst);
-
-	REG_UPDATE(BL1_PWM_USER_LEVEL, BL1_PWM_USER_LEVEL, backlight_pwm_u16_16);
-
-	if (otg_inst == 0)
-		frame_ramp = 0;
-
-	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
-	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
-	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
 
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
-
-	// Update requested backlight level
-	s2 = REG_READ(BIOS_SCRATCH_2);
-
-	s2 &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
-	backlight_8_bit &= (ATOM_S2_CURRENT_BL_LEVEL_MASK >>
-				ATOM_S2_CURRENT_BL_LEVEL_SHIFT);
-	s2 |= (backlight_8_bit << ATOM_S2_CURRENT_BL_LEVEL_SHIFT);
-
-	REG_WRITE(BIOS_SCRATCH_2, s2);
-}
 
 static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 {
@@ -211,31 +147,6 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 	return true;
 }
 
-static bool dmub_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
-{
-	dmub_abm_set_pipe(abm, DISABLE_ABM_IMMEDIATELY, panel_inst);
-
-	return true;
-}
-
-static bool dmub_abm_set_backlight_level_pwm(
-		struct abm *abm,
-		unsigned int backlight_pwm_u16_16,
-		unsigned int frame_ramp,
-		unsigned int otg_inst,
-		uint32_t panel_inst)
-{
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-
-	dmcub_set_backlight_level(dce_abm,
-			backlight_pwm_u16_16,
-			frame_ramp,
-			otg_inst,
-			panel_inst);
-
-	return true;
-}
-
 static bool dmub_abm_init_config(struct abm *abm,
 	const char *src,
 	unsigned int bytes)
@@ -266,11 +177,8 @@ static bool dmub_abm_init_config(struct abm *abm,
 static const struct abm_funcs abm_funcs = {
 	.abm_init = dmub_abm_init,
 	.set_abm_level = dmub_abm_set_level,
-	.set_pipe = dmub_abm_set_pipe,
-	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm,
 	.get_current_backlight = dmub_abm_get_current_backlight,
 	.get_target_backlight = dmub_abm_get_target_backlight,
-	.set_abm_immediate_disable = dmub_abm_immediate_disable,
 	.init_abm_config = dmub_abm_init_config,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index b77e9dc16086..a475e529ae1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2767,6 +2767,16 @@ void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 }
 
+void dce110_set_pipe(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst + 1;
+
+	if (abm && panel_cntl)
+		abm->funcs->set_pipe(abm, otg_inst, panel_cntl->inst);
+}
+
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -2804,6 +2814,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.set_cursor_attribute = dce110_set_cursor_attribute,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+	.set_pipe = dce110_set_pipe,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index fe5326df00f7..b6f3843d3d05 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -89,6 +89,7 @@ bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp);
 void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
+void dce110_set_pipe(struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f36d1f57b846..27cae98936ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2506,8 +2506,7 @@ void dcn10_blank_pixel_data(
 		if (stream_res->tg->funcs->set_blank)
 			stream_res->tg->funcs->set_blank(stream_res->tg, blank);
 		if (stream_res->abm) {
-			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1,
-					stream->link->panel_cntl->inst);
+			dc->hwss.set_pipe(pipe_ctx);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
 	} else if (blank) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 897a3d25685a..9f8c89b6a763 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -74,6 +74,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+	.set_pipe = dce110_set_pipe,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index da5333d165ac..258dcd33787e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -996,8 +996,7 @@ void dcn20_blank_pixel_data(
 
 	if (!blank)
 		if (stream_res->abm) {
-			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1,
-					stream->link->panel_cntl->inst);
+			dc->hwss.set_pipe(pipe_ctx);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index a8bcd747d7ba..e20760fa11ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -85,6 +85,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+	.set_pipe = dce110_set_pipe,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index ada65b1a7eb1..01f1d3d9a639 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -28,10 +28,13 @@
 #include "core_types.h"
 #include "resource.h"
 #include "dce/dce_hwseq.h"
+#include "dce110/dce110_hw_sequencer.h"
 #include "dcn21_hwseq.h"
 #include "vmid.h"
 #include "reg_helper.h"
 #include "hw/clk_mgr.h"
+#include "dc_dmub_srv.h"
+#include "abm.h"
 
 
 #define DC_LOGGER_INIT(logger)
@@ -134,3 +137,89 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint32_t ramping_boundary = 0xFFFF;
+
+	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
+	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+
+	if (dmcu) {
+		dce110_set_abm_immediate_disable(pipe_ctx);
+		return;
+	}
+
+	if (abm && panel_cntl)
+		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+				panel_cntl->inst);
+}
+
+void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+
+	if (dmcu) {
+		dce110_set_pipe(pipe_ctx);
+		return;
+	}
+
+	if (abm && panel_cntl)
+		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+}
+
+bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = pipe_ctx->stream->ctx;
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	if (dc->dc->res_pool->dmcu) {
+		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
+		return true;
+	}
+
+	if (abm && panel_cntl)
+		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+
+	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
+	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
+	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
index 26bf24d3b59f..9e97747e57cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
@@ -47,4 +47,10 @@ void dcn21_optimize_pwr_state(
 void dcn21_PLAT_58856_wa(struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);
 
+void dcn21_set_pipe(struct pipe_ctx *pipe_ctx);
+void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
+bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp);
+
 #endif /* __DC_HWSS_DCN21_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index e97dfaa656e9..9a2d1f755839 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -87,8 +87,9 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.power_down = dce110_power_down,
-	.set_backlight_level = dce110_set_backlight_level,
-	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+	.set_backlight_level = dcn21_set_backlight_level,
+	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
+	.set_pipe = dcn21_set_pipe,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 3b2ea9bdb62c..2e8f3fecc6a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -198,6 +198,8 @@ struct hw_sequencer_funcs {
 
 	void (*set_abm_immediate_disable)(struct pipe_ctx *pipe_ctx);
 
+	void (*set_pipe)(struct pipe_ctx *pipe_ctx);
+
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 599bf2055bcb..cbfde2706c18 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,6 +36,9 @@
 #define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
 #define REG_SET_MASK 0xFFFF
 
+#define SET_ABM_PIPE_GRADUALLY_DISABLE           0
+#define SET_ABM_PIPE_IMMEDIATELY_DISABLE         255
+#define SET_ABM_PIPE_NORMAL                      1
 
 /*
  * Command IDs should be treated as stable ABI.
@@ -272,6 +275,7 @@ struct dmub_rb_cmd_abm_set_pipe {
 
 struct dmub_cmd_abm_set_backlight_data {
 	uint32_t frame_ramp;
+	uint32_t backlight_user_level;
 };
 
 struct dmub_rb_cmd_abm_set_backlight {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
