Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C01C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D222071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0SQV6tEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D222071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6293A89FCA;
	Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35ECB6E12A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntqsMKO/O+/yR8YvCT4NsxGgnwZnUuG6ddMZLROLNBstwL/eLBYaLJj3hIHmFU9jg4ZVzTkX/IiYGTke1Y7zXD89ogcXJHA7oPqdug5Por95uSqQ9oGntsNo45uWSOMZckjwmKXBky1lptDhbqRf3ZK8pfTF3jnbdAWqiSpmY5o4Mj2WUWYZnprWfy8ZvF1Ifv6xGFdPkgUTmS+6s8JUWVorP3AhQzaSCtHQpazp81j+mKMI6KcuQpo19m0VthAYZb451F7Fn3S7gav2Y+TIBHevoBjcWBCPrp8GMTqEKOH7VGBoF5YLpm11nsC8jeKlz43zPJwQyh4l2FgiWZRCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUnZXmITy+Oi8AQTlTS4pxADenp8O6AjgvhlBhuUQ+c=;
 b=QqCLINoQca1jXtdKo4sNHew3KGhd3YZyQkuLbz6Mk7CQkJUPttMhBpfSaBfGC9/b7aR5z5ZlA+TSn1nFx7E8Njn8WttXT9pZwW+ILaDlHJp7lRYy2d3cNrFwYm7KsS2mUsI0Utz/sSe5k9KMME1UB4YwxcaLz0hJhVOI95QGbJf5QUztMaHUf1SpAkAHMb/yqFzuYwFl8rGfQlGX7l5qVoUSwt468FPnz+6yF1cc53zvzkgm+9VgoSX75SDY2OVJAaha80+NC8ZZG9Mr9wbTkjoZgWNtksl9pLgV9wyexZHsbTlIxlHFrXEgcGf3LIRomjB9SSBw7Ci0LsPcpQwkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUnZXmITy+Oi8AQTlTS4pxADenp8O6AjgvhlBhuUQ+c=;
 b=0SQV6tEHPZb79V+9paLInXA/+bIkIPaK+1YwTW1EgefRef3gMRw3I/FthSnEu48nTssuzXUxO6aL+rdLkHYL5Sf/3syic5eI+mLhBkoFk1VKMo4DXDvJYbj292OFgpvCb05jM4/BFxkCCJCYIC6UM7NPkBW73Roc7ve7kcxn5rI=
Received: from MWHPR20CA0017.namprd20.prod.outlook.com (2603:10b6:300:13d::27)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 22:08:30 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::f0) by MWHPR20CA0017.outlook.office365.com
 (2603:10b6:300:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:28 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: Add set backlight to hw sequencer.
Date: Wed, 22 Apr 2020 18:08:01 -0400
Message-ID: <20200422220805.15759-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(428003)(46966005)(8936002)(81166007)(6916009)(336012)(186003)(316002)(44832011)(54906003)(70586007)(70206006)(2616005)(47076004)(6666004)(82310400002)(8676002)(478600001)(426003)(26005)(7696005)(1076003)(36756003)(4326008)(5660300002)(81156014)(82740400003)(86362001)(2906002)(356005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95d587e-e3d4-48ef-07de-08d7e709b04b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2623855A7578ED7F624536438BD20@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpGCRveoA7KxIGDB4PZO9qg/UcaDfRem7Wlk+cTP50aLe4rOfs6LmHQRZS558wWqenAT2522f3JdkgE7Zu4fJBKMpLAov6AQEa3ksmUFEdNXGckBMbkldViR1j91eSmKaz07tf5VbwdHDE1CF5dRBLWQCM7xCiQWowftewYkSzQPKkmlx/YdCeuLIyP8kmp0dWBk3hD2uquIb9wWRUCu9ZzhgFmoHU/hvkGttJBKIXNZtbK26YLVZH5BJZkM+NdFqugXNXO+BdQFwwiXCPxJhMDcPVIDvSKLZaRubFyUaX6yEJMOIYr2ZoFMxzTmOnaNzQHmLY+NdSIev3szwMiucqCwLuFBcWZ2EGvilzskr3YEu7jmoY37t6lJ/dVzJ7+7Eq42QHr2UiNHW87akswtSeOE+RuhQ6K+DOrWNkwlgOJbKLFLGRZxiWfXAkN/nhMCXUK/nXk29Gu2l9ryOmLDsbfpAlEAfadka4UmkeIar1ZGDhC+NC4kyO8mJp85K3+d8VgbahFaw8Pj9iP3Mxn7Fg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:29.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d587e-e3d4-48ef-07de-08d7e709b04b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Add set backlight to hw sequencer, dmu communication will
be handled in hw sequencer for new asics.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 35 ++++++-------------
 .../display/dc/dce110/dce110_hw_sequencer.c   | 34 +++++++++++++++++-
 .../display/dc/dce110/dce110_hw_sequencer.h   |  4 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +++
 7 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a54b3e05f66b..67c5342cf89a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2509,35 +2509,21 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 		uint32_t frame_ramp)
 {
 	struct dc  *dc = link->ctx->dc;
-	struct abm *abm = get_abm_from_stream_res(link);
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	unsigned int controller_id = 0;
-	bool fw_set_brightness = true;
 	int i;
-	DC_LOGGER_INIT(link->ctx->logger);
-
-	if (abm == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
-		return false;
-
-	if (dmcu)
-		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
 
+	DC_LOGGER_INIT(link->ctx->logger);
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
 	if (dc_is_embedded_signal(link->connector_signal)) {
+		struct pipe_ctx *pipe_ctx = NULL;
+
 		for (i = 0; i < MAX_PIPES; i++) {
 			if (dc->current_state->res_ctx.pipe_ctx[i].stream) {
 				if (dc->current_state->res_ctx.
 						pipe_ctx[i].stream->link
 						== link) {
-					/* DMCU -1 for all controller id values,
-					 * therefore +1 here
-					 */
-					controller_id =
-						dc->current_state->
-						res_ctx.pipe_ctx[i].stream_res.tg->inst +
-						1;
+					pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
 					/* Disable brightness ramping when the display is blanked
 					 * as it can hang the DMCU
@@ -2547,13 +2533,14 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 				}
 			}
 		}
-		abm->funcs->set_backlight_level_pwm(
-				abm,
+
+		if (pipe_ctx == NULL)
+			ASSERT(false);
+
+		dc->hwss.set_backlight_level(
+				pipe_ctx,
 				backlight_pwm_u16_16,
-				frame_ramp,
-				controller_id,
-				link->panel_cntl->inst,
-				fw_set_brightness);
+				frame_ramp);
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9cd130c8894a..30469026c642 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2714,6 +2714,37 @@ void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->plane_res.xfm, attributes);
 }
 
+bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc  *dc = link->ctx->dc;
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	bool fw_set_brightness = true;
+	/* DMCU -1 for all controller id values,
+	 * therefore +1 here
+	 */
+	uint32_t controller_id = pipe_ctx->stream_res.tg->inst + 1;
+
+	if (abm == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
+		return false;
+
+	if (dmcu)
+		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
+
+	abm->funcs->set_backlight_level_pwm(
+			abm,
+			backlight_pwm_u16_16,
+			frame_ramp,
+			controller_id,
+			link->panel_cntl->inst,
+			fw_set_brightness);
+
+	return true;
+}
+
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -2747,7 +2778,8 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dce110_set_cursor_position,
-	.set_cursor_attribute = dce110_set_cursor_attribute
+	.set_cursor_attribute = dce110_set_cursor_attribute,
+	.set_backlight_level = dce110_set_backlight_level,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index 26a9c14a58b1..e609a72b4634 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -85,5 +85,9 @@ void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
 
+bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		uint32_t backlight_pwm_u16_16,
+		uint32_t frame_ramp);
+
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index b88ef9703b2b..6f3dbcdb06f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -71,6 +71,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.set_backlight_level = dce110_set_backlight_level,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 1642bf546ceb..1e33e29b37f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -82,6 +82,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.init_vm_ctx = dcn20_init_vm_ctx,
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.set_backlight_level = dce110_set_backlight_level,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 8410a6305a9a..128d5e3729c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -91,6 +91,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.power_down = dce110_power_down,
+	.set_backlight_level = dce110_set_backlight_level,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 9380721f28b8..ed3505cbba6e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -191,6 +191,10 @@ struct hw_sequencer_funcs {
 			unsigned int bufSize, unsigned int mask);
 	void (*clear_status_bits)(struct dc *dc, unsigned int mask);
 
+	bool (*set_backlight_level)(struct pipe_ctx *pipe_ctx,
+			uint32_t backlight_pwm_u16_16,
+			uint32_t frame_ramp);
+
 
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
