Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5239C47257
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762152072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VMMcLXU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762152072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3056E121;
	Sat,  2 May 2020 21:34:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E9B6E0F4
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HppamdnA/m9ISlsGsoUIMvVZ96T+Gu5oeM6YPiVGbH3bRpLjYNmclIz62tqfUPZ6e4m1HdE7zGcjpy5FODtMwxfmQdICMPIACLo/vuNh783jFLPz6d+YCaIOC4p6qm0bBF9/1YY2V/0W5ItF+kxxKlzqMVjvpagDKj/cVAAXtv9v0rDW//Kkqo9+H4ulHOy0AZoJHWFhaaaLzUQpL9c6CvDUfJeAwYcAJ/ttpgpkG7dqKZ/mDdRW8+YZii1SnFW7zNw4jWfUFSVQ/+cYdT15LdBs0RSNeOevPPVwFoDL2KgxIQZ6JBqHWEg+42tpYGnBLREmcXkUm6h27DfIhD8eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn0BuEH7/Go7ZtVRwgUngtfvMwbfPUud4FETlCpP18c=;
 b=JKqUxazJSN2S4XBVlULjKX9BJq6EtUGf7FhJ/QKb0ZNiTl3LqPm6PPgaW6SPyyRa2qxSyttzuaUFGvsUIrdIgemL0lPgs5NXH2cTE0ojpmgcJvdtDJpLY3nRi+gHrsh4ZPjCUUtAn6GOkNsURHsuA+SU/k8h3apt7FuU7t9gjsaeKKSIaM5591z/qYcPHOwVgiM20U85T4uFomMWDDzQ+K3U9npP1zwSh5CKqYl5kvTmNlYQzOvoU14mJd63r7s71zEUFzO/DDbo9WGhOte2t1tJDnNl4lb7DUoM1zWQx82BgRCXHUc20ovSsfvJFEj9El8f74V8pKdkRPzCcgaCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn0BuEH7/Go7ZtVRwgUngtfvMwbfPUud4FETlCpP18c=;
 b=VMMcLXU4tsBmGU6QlLqNi6I/Z0td0ZPYunVbHsVSs4JIhPsI+Xe2OK4KzUaf8apYcTB10jgCWjDvjD68kBsVgLyya2xW+HH+KE+DLfhfoPTWRlU00mD5CZlVanIeRDxzngkf4yVVIUAhZ9ln/fU2GSSVnFRfreIZJXB6WTrlNRw=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Sat, 2 May
 2020 21:34:47 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::f1) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 21:34:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:45 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:45 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:44 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Move panel_cntl specific register from
 abm to panel_cntl.
Date: Sat, 2 May 2020 17:34:27 -0400
Message-ID: <20200502213443.39232-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(82310400002)(44832011)(54906003)(7696005)(81166007)(82740400003)(47076004)(36756003)(316002)(478600001)(2906002)(86362001)(70586007)(70206006)(1076003)(30864003)(5660300002)(356005)(6916009)(4326008)(426003)(6666004)(336012)(8676002)(8936002)(2616005)(186003)(26005)(579004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2323e1-0e1f-4156-0f6f-08d7eee0a284
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364BA83DEDEEC97687D7DE28BA80@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXthAAla/NPWbXyMRx3GD8vp3W/faP5D3KWjxD7K3o/6sIu/5887FeYqRpTZJ9ILrllxF82uUSpDw/Xjndw8ikFJL0LgQv7Hp4w1VxN6RCK01bl8FoR85wILDOEjW1bYHLKIVLBHoKvCZQ8jRMKueRk88cgX5m+jVirlhvsIdDLr04BVMB8YRPGO2++6saHeu0VRa8ReSAetMeNRA9y4IoFsogVG3ONCz/1u/Eln0Z039KWNXisJh6DuPMd7i9FkRbHLGuO+qoYZZmIPWF08vcVuaFCW4+2fdxrzcnEgnK07YsWz9agDD+pMg/v4DJZ2PkAbFde8rRDcRoiam5Mv0WsgUjyNPM40F42l8CRwrWRX50b3VXADc08jMU1/pC3bytty/LGCsxtPhv4nJT8Ix5p9aleTriHJUdVkl9ubULir9ZXAIe2YDYnLDLoLObnYG+RJq862ejJQo35xXkjnroKvcTPILpqCitW6ok/dI9uzrC9vjwjuTSPoDVVOfbxMOAWX23x9YdT313Q7Ccjcig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:46.2423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2323e1-0e1f-4156-0f6f-08d7eee0a284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
Cc: Sunpeng.Li@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
panel_cntl specific register should be access in panel_cntl object.

[How]
Move these register access from abm to panel_cntl.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  59 +++--
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  | 215 +-----------------
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  30 +--
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 204 ++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_panel_cntl.h   |  48 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 127 +----------
 .../display/dc/dce110/dce110_hw_sequencer.c   |  49 ++--
 .../display/dc/dce110/dce110_hw_sequencer.h   |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  19 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   8 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  15 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 18 files changed, 339 insertions(+), 463 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad817bd74586..f47acf30acd2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2210,9 +2210,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 				if (should_program_abm) {
 					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
-						pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(
-								pipe_ctx->stream_res.abm,
-								pipe_ctx->stream->link->panel_cntl->inst);
+						dc->hwss.set_abm_immediate_disable(pipe_ctx);
 					} else {
 						pipe_ctx->stream_res.abm->funcs->set_abm_level(
 							pipe_ctx->stream_res.abm, stream->abm_level);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67c5342cf89a..f895412538c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2504,59 +2504,56 @@ int dc_link_get_target_backlight_pwm(const struct dc_link *link)
 	return (int) abm->funcs->get_target_backlight(abm);
 }
 
+static struct pipe_ctx *get_pipe_from_link(const struct dc_link *link)
+{
+	int i;
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream) {
+			if (dc->current_state->res_ctx.pipe_ctx[i].stream->link == link) {
+				pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+				break;
+			}
+		}
+	}
+
+	return pipe_ctx;
+}
+
 bool dc_link_set_backlight_level(const struct dc_link *link,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
 	struct dc  *dc = link->ctx->dc;
-	int i;
 
 	DC_LOGGER_INIT(link->ctx->logger);
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
 	if (dc_is_embedded_signal(link->connector_signal)) {
-		struct pipe_ctx *pipe_ctx = NULL;
-
-		for (i = 0; i < MAX_PIPES; i++) {
-			if (dc->current_state->res_ctx.pipe_ctx[i].stream) {
-				if (dc->current_state->res_ctx.
-						pipe_ctx[i].stream->link
-						== link) {
-					pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-
-					/* Disable brightness ramping when the display is blanked
-					 * as it can hang the DMCU
-					 */
-					if (dc->current_state->res_ctx.pipe_ctx[i].plane_state == NULL)
-						frame_ramp = 0;
-				}
-			}
-		}
+		struct pipe_ctx *pipe_ctx = get_pipe_from_link(link);
 
-		if (pipe_ctx == NULL)
+		if (pipe_ctx) {
+			/* Disable brightness ramping when the display is blanked
+			 * as it can hang the DMCU
+			 */
+			if (pipe_ctx->plane_state == NULL)
+				frame_ramp = 0;
+		} else {
 			ASSERT(false);
+			return false;
+		}
 
 		dc->hwss.set_backlight_level(
 				pipe_ctx,
 				backlight_pwm_u16_16,
 				frame_ramp);
 	}
-
 	return true;
 }
 
-bool dc_link_set_abm_disable(const struct dc_link *link)
-{
-	struct abm *abm = get_abm_from_stream_res(link);
-	bool success = false;
-
-	if (abm)
-		success = abm->funcs->set_abm_immediate_disable(abm, link->panel_cntl->inst);
-
-	return success;
-}
-
 bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool wait)
 {
 	struct dc  *dc = link->ctx->dc;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 80fb4149f36a..eb5d910bffb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -220,8 +220,6 @@ int dc_link_get_backlight_level(const struct dc_link *dc_link);
 
 int dc_link_get_target_backlight_pwm(const struct dc_link *link);
 
-bool dc_link_set_abm_disable(const struct dc_link *dc_link);
-
 bool dc_link_set_psr_allow_active(struct dc_link *dc_link, bool enable, bool wait);
 
 bool dc_link_get_psr_state(const struct dc_link *dc_link, uint32_t *psr_state);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index c15e60fb5ebc..4e87e70237e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -83,120 +83,6 @@ static bool dce_abm_set_pipe(struct abm *abm, uint32_t controller_id, uint32_t p
 	return true;
 }
 
-static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_abm *abm_dce)
-{
-	uint64_t current_backlight;
-	uint32_t round_result;
-	uint32_t pwm_period_cntl, bl_period, bl_int_count;
-	uint32_t bl_pwm_cntl, bl_pwm, fractional_duty_cycle_en;
-	uint32_t bl_period_mask, bl_pwm_mask;
-
-	pwm_period_cntl = REG_READ(BL_PWM_PERIOD_CNTL);
-	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
-	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
-
-	bl_pwm_cntl = REG_READ(BL_PWM_CNTL);
-	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, (uint32_t *)(&bl_pwm));
-	REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle_en);
-
-	if (bl_int_count == 0)
-		bl_int_count = 16;
-
-	bl_period_mask = (1 << bl_int_count) - 1;
-	bl_period &= bl_period_mask;
-
-	bl_pwm_mask = bl_period_mask << (16 - bl_int_count);
-
-	if (fractional_duty_cycle_en == 0)
-		bl_pwm &= bl_pwm_mask;
-	else
-		bl_pwm &= 0xFFFF;
-
-	current_backlight = bl_pwm << (1 + bl_int_count);
-
-	if (bl_period == 0)
-		bl_period = 0xFFFF;
-
-	current_backlight = div_u64(current_backlight, bl_period);
-	current_backlight = (current_backlight + 1) >> 1;
-
-	current_backlight = (uint64_t)(current_backlight) * bl_period;
-
-	round_result = (uint32_t)(current_backlight & 0xFFFFFFFF);
-
-	round_result = (round_result >> (bl_int_count-1)) & 1;
-
-	current_backlight >>= bl_int_count;
-	current_backlight += round_result;
-
-	return (uint32_t)(current_backlight);
-}
-
-static void driver_set_backlight_level(struct dce_abm *abm_dce,
-		uint32_t backlight_pwm_u16_16)
-{
-	uint32_t backlight_16bit;
-	uint32_t masked_pwm_period;
-	uint8_t bit_count;
-	uint64_t active_duty_cycle;
-	uint32_t pwm_period_bitcnt;
-
-	/*
-	 * 1. Find  16 bit backlight active duty cycle, where 0 <= backlight
-	 * active duty cycle <= backlight period
-	 */
-
-	/* 1.1 Apply bitmask for backlight period value based on value of BITCNT
-	 */
-	REG_GET_2(BL_PWM_PERIOD_CNTL,
-			BL_PWM_PERIOD_BITCNT, &pwm_period_bitcnt,
-			BL_PWM_PERIOD, &masked_pwm_period);
-
-	if (pwm_period_bitcnt == 0)
-		bit_count = 16;
-	else
-		bit_count = pwm_period_bitcnt;
-
-	/* e.g. maskedPwmPeriod = 0x24 when bitCount is 6 */
-	masked_pwm_period = masked_pwm_period & ((1 << bit_count) - 1);
-
-	/* 1.2 Calculate integer active duty cycle required upper 16 bits
-	 * contain integer component, lower 16 bits contain fractional component
-	 * of active duty cycle e.g. 0x21BDC0 = 0xEFF0 * 0x24
-	 */
-	active_duty_cycle = backlight_pwm_u16_16 * masked_pwm_period;
-
-	/* 1.3 Calculate 16 bit active duty cycle from integer and fractional
-	 * components shift by bitCount then mask 16 bits and add rounding bit
-	 * from MSB of fraction e.g. 0x86F7 = ((0x21BDC0 >> 6) & 0xFFF) + 0
-	 */
-	backlight_16bit = active_duty_cycle >> bit_count;
-	backlight_16bit &= 0xFFFF;
-	backlight_16bit += (active_duty_cycle >> (bit_count - 1)) & 0x1;
-
-	/*
-	 * 2. Program register with updated value
-	 */
-
-	/* 2.1 Lock group 2 backlight registers */
-
-	REG_UPDATE_2(BL_PWM_GRP1_REG_LOCK,
-			BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, 1,
-			BL_PWM_GRP1_REG_LOCK, 1);
-
-	// 2.2 Write new active duty cycle
-	REG_UPDATE(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, backlight_16bit);
-
-	/* 2.3 Unlock group 2 backlight registers */
-	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
-			BL_PWM_GRP1_REG_LOCK, 0);
-
-	/* 3 Wait for pending bit to be cleared */
-	REG_WAIT(BL_PWM_GRP1_REG_LOCK,
-			BL_PWM_GRP1_REG_UPDATE_PENDING, 0,
-			1, 10000);
-}
-
 static void dmcu_set_backlight_level(
 	struct dce_abm *abm_dce,
 	uint32_t backlight_pwm_u16_16,
@@ -249,10 +135,9 @@ static void dmcu_set_backlight_level(
 			0, 1, 80000);
 }
 
-static void dce_abm_init(struct abm *abm)
+static void dce_abm_init(struct abm *abm, uint32_t backlight)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
-	unsigned int backlight = calculate_16_bit_backlight_from_pwm(abm_dce);
 
 	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x103);
 	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x101);
@@ -334,85 +219,11 @@ static bool dce_abm_set_level(struct abm *abm, uint32_t level)
 
 static bool dce_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
 {
-	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
-
 	if (abm->dmcu_is_running == false)
 		return true;
 
 	dce_abm_set_pipe(abm, MCP_DISABLE_ABM_IMMEDIATELY, panel_inst);
 
-	abm->stored_backlight_registers.BL_PWM_CNTL =
-		REG_READ(BL_PWM_CNTL);
-	abm->stored_backlight_registers.BL_PWM_CNTL2 =
-		REG_READ(BL_PWM_CNTL2);
-	abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
-		REG_READ(BL_PWM_PERIOD_CNTL);
-
-	REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
-		&abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-	return true;
-}
-
-static bool dce_abm_init_backlight(struct abm *abm)
-{
-	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
-	uint32_t value;
-
-	/* It must not be 0, so we have to restore them
-	 * Bios bug w/a - period resets to zero,
-	 * restoring to cache values which is always correct
-	 */
-	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &value);
-	if (value == 0 || value == 1) {
-		if (abm->stored_backlight_registers.BL_PWM_CNTL != 0) {
-			REG_WRITE(BL_PWM_CNTL,
-				abm->stored_backlight_registers.BL_PWM_CNTL);
-			REG_WRITE(BL_PWM_CNTL2,
-				abm->stored_backlight_registers.BL_PWM_CNTL2);
-			REG_WRITE(BL_PWM_PERIOD_CNTL,
-				abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
-			REG_UPDATE(LVTMA_PWRSEQ_REF_DIV,
-				BL_PWM_REF_DIV,
-				abm->stored_backlight_registers.
-				LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-		} else {
-			/* TODO: Note: This should not really happen since VBIOS
-			 * should have initialized PWM registers on boot.
-			 */
-			REG_WRITE(BL_PWM_CNTL, 0xC000FA00);
-			REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
-		}
-	} else {
-		abm->stored_backlight_registers.BL_PWM_CNTL =
-				REG_READ(BL_PWM_CNTL);
-		abm->stored_backlight_registers.BL_PWM_CNTL2 =
-				REG_READ(BL_PWM_CNTL2);
-		abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
-				REG_READ(BL_PWM_PERIOD_CNTL);
-
-		REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
-				&abm->stored_backlight_registers.
-				LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-	}
-
-	/* Have driver take backlight control
-	 * TakeBacklightControl(true)
-	 */
-	value = REG_READ(BIOS_SCRATCH_2);
-	value |= ATOM_S2_VRI_BRIGHT_ENABLE;
-	REG_WRITE(BIOS_SCRATCH_2, value);
-
-	/* Enable the backlight output */
-	REG_UPDATE(BL_PWM_CNTL, BL_PWM_EN, 1);
-
-	/* Disable fractional pwm if configured */
-	REG_UPDATE(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN,
-		   abm->ctx->dc->config.disable_fractional_pwm ? 0 : 1);
-
-	/* Unlock group 2 backlight registers */
-	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
-			BL_PWM_GRP1_REG_LOCK, 0);
-
 	return true;
 }
 
@@ -421,23 +232,18 @@ static bool dce_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int controller_id,
-		unsigned int panel_inst,
-		bool fw_set_brightness)
+		unsigned int panel_inst)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
-	/* If DMCU is in reset state, DMCU is uninitialized */
-	if (fw_set_brightness)
-		dmcu_set_backlight_level(abm_dce,
-				backlight_pwm_u16_16,
-				frame_ramp,
-				controller_id,
-				panel_inst);
-	else
-		driver_set_backlight_level(abm_dce, backlight_pwm_u16_16);
+	dmcu_set_backlight_level(abm_dce,
+			backlight_pwm_u16_16,
+			frame_ramp,
+			controller_id,
+			panel_inst);
 
 	return true;
 }
@@ -445,13 +251,12 @@ static bool dce_abm_set_backlight_level_pwm(
 static const struct abm_funcs dce_funcs = {
 	.abm_init = dce_abm_init,
 	.set_abm_level = dce_abm_set_level,
-	.init_backlight = dce_abm_init_backlight,
 	.set_pipe = dce_abm_set_pipe,
 	.set_backlight_level_pwm = dce_abm_set_backlight_level_pwm,
 	.get_current_backlight = dce_abm_get_current_backlight,
 	.get_target_backlight = dce_abm_get_target_backlight,
 	.init_abm_config = NULL,
-	.set_abm_immediate_disable = dce_abm_immediate_disable
+	.set_abm_immediate_disable = dce_abm_immediate_disable,
 };
 
 static void dce_abm_construct(
@@ -465,10 +270,6 @@ static void dce_abm_construct(
 
 	base->ctx = ctx;
 	base->funcs = &dce_funcs;
-	base->stored_backlight_registers.BL_PWM_CNTL = 0;
-	base->stored_backlight_registers.BL_PWM_CNTL2 = 0;
-	base->stored_backlight_registers.BL_PWM_PERIOD_CNTL = 0;
-	base->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV = 0;
 	base->dmcu_is_running = false;
 
 	abm_dce->regs = regs;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index ba0caaffa24b..9718a4823372 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -30,11 +30,6 @@
 #include "abm.h"
 
 #define ABM_COMMON_REG_LIST_DCE_BASE() \
-	SR(BL_PWM_PERIOD_CNTL), \
-	SR(BL_PWM_CNTL), \
-	SR(BL_PWM_CNTL2), \
-	SR(BL_PWM_GRP1_REG_LOCK), \
-	SR(LVTMA_PWRSEQ_REF_DIV), \
 	SR(MASTER_COMM_CNTL_REG), \
 	SR(MASTER_COMM_CMD_REG), \
 	SR(MASTER_COMM_DATA_REG1)
@@ -85,15 +80,6 @@
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
 #define ABM_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh) \
-	ABM_SF(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
-	ABM_SF(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, mask_sh), \
-	ABM_SF(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, mask_sh), \
-	ABM_SF(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, mask_sh), \
-	ABM_SF(BL_PWM_CNTL, BL_PWM_EN, mask_sh), \
-	ABM_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, mask_sh), \
-	ABM_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_LOCK, mask_sh), \
-	ABM_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_UPDATE_PENDING, mask_sh), \
-	ABM_SF(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV, mask_sh), \
 	ABM_SF(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, mask_sh), \
 	ABM_SF(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE0, mask_sh), \
 	ABM_SF(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE1, mask_sh), \
@@ -178,19 +164,10 @@
 	type ABM1_HG_REG_READ_MISSED_FRAME_CLEAR; \
 	type ABM1_LS_REG_READ_MISSED_FRAME_CLEAR; \
 	type ABM1_BL_REG_READ_MISSED_FRAME_CLEAR; \
-	type BL_PWM_PERIOD; \
-	type BL_PWM_PERIOD_BITCNT; \
-	type BL_ACTIVE_INT_FRAC_CNT; \
-	type BL_PWM_FRACTIONAL_EN; \
 	type MASTER_COMM_INTERRUPT; \
 	type MASTER_COMM_CMD_REG_BYTE0; \
 	type MASTER_COMM_CMD_REG_BYTE1; \
-	type MASTER_COMM_CMD_REG_BYTE2; \
-	type BL_PWM_REF_DIV; \
-	type BL_PWM_EN; \
-	type BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN; \
-	type BL_PWM_GRP1_REG_LOCK; \
-	type BL_PWM_GRP1_REG_UPDATE_PENDING
+	type MASTER_COMM_CMD_REG_BYTE2
 
 struct dce_abm_shift {
 	ABM_REG_FIELD_LIST(uint8_t);
@@ -201,10 +178,6 @@ struct dce_abm_mask {
 };
 
 struct dce_abm_registers {
-	uint32_t BL_PWM_PERIOD_CNTL;
-	uint32_t BL_PWM_CNTL;
-	uint32_t BL_PWM_CNTL2;
-	uint32_t LVTMA_PWRSEQ_REF_DIV;
 	uint32_t DC_ABM1_HG_SAMPLE_RATE;
 	uint32_t DC_ABM1_LS_SAMPLE_RATE;
 	uint32_t BL1_PWM_BL_UPDATE_SAMPLE_RATE;
@@ -219,7 +192,6 @@ struct dce_abm_registers {
 	uint32_t MASTER_COMM_CMD_REG;
 	uint32_t MASTER_COMM_DATA_REG1;
 	uint32_t BIOS_SCRATCH_2;
-	uint32_t BL_PWM_GRP1_REG_LOCK;
 };
 
 struct dce_abm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index d9b0ff7eb2a4..ebff9b1e312e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -28,6 +28,7 @@
 #include "dc_dmub_srv.h"
 #include "panel_cntl.h"
 #include "dce_panel_cntl.h"
+#include "atom.h"
 
 #define TO_DCE_PANEL_CNTL(panel_cntl)\
 	container_of(panel_cntl, struct dce_panel_cntl, base)
@@ -45,9 +46,113 @@
 #define FN(reg_name, field_name) \
 	dce_panel_cntl->shift->field_name, dce_panel_cntl->mask->field_name
 
-void dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_panel_cntl *dce_panel_cntl)
 {
+	uint64_t current_backlight;
+	uint32_t round_result;
+	uint32_t pwm_period_cntl, bl_period, bl_int_count;
+	uint32_t bl_pwm_cntl, bl_pwm, fractional_duty_cycle_en;
+	uint32_t bl_period_mask, bl_pwm_mask;
 
+	pwm_period_cntl = REG_READ(BL_PWM_PERIOD_CNTL);
+	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
+	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
+
+	bl_pwm_cntl = REG_READ(BL_PWM_CNTL);
+	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, (uint32_t *)(&bl_pwm));
+	REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle_en);
+
+	if (bl_int_count == 0)
+		bl_int_count = 16;
+
+	bl_period_mask = (1 << bl_int_count) - 1;
+	bl_period &= bl_period_mask;
+
+	bl_pwm_mask = bl_period_mask << (16 - bl_int_count);
+
+	if (fractional_duty_cycle_en == 0)
+		bl_pwm &= bl_pwm_mask;
+	else
+		bl_pwm &= 0xFFFF;
+
+	current_backlight = bl_pwm << (1 + bl_int_count);
+
+	if (bl_period == 0)
+		bl_period = 0xFFFF;
+
+	current_backlight = div_u64(current_backlight, bl_period);
+	current_backlight = (current_backlight + 1) >> 1;
+
+	current_backlight = (uint64_t)(current_backlight) * bl_period;
+
+	round_result = (uint32_t)(current_backlight & 0xFFFFFFFF);
+
+	round_result = (round_result >> (bl_int_count-1)) & 1;
+
+	current_backlight >>= bl_int_count;
+	current_backlight += round_result;
+
+	return (uint32_t)(current_backlight);
+}
+
+uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+{
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
+	uint32_t value;
+	uint32_t current_backlight;
+
+	/* It must not be 0, so we have to restore them
+	 * Bios bug w/a - period resets to zero,
+	 * restoring to cache values which is always correct
+	 */
+	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &value);
+
+	if (value == 0 || value == 1) {
+		if (panel_cntl->stored_backlight_registers.BL_PWM_CNTL != 0) {
+			REG_WRITE(BL_PWM_CNTL,
+					panel_cntl->stored_backlight_registers.BL_PWM_CNTL);
+			REG_WRITE(BL_PWM_CNTL2,
+					panel_cntl->stored_backlight_registers.BL_PWM_CNTL2);
+			REG_WRITE(BL_PWM_PERIOD_CNTL,
+					panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
+			REG_UPDATE(PWRSEQ_REF_DIV,
+				BL_PWM_REF_DIV,
+				panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+		} else {
+			/* TODO: Note: This should not really happen since VBIOS
+			 * should have initialized PWM registers on boot.
+			 */
+			REG_WRITE(BL_PWM_CNTL, 0xC000FA00);
+			REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
+		}
+	} else {
+		panel_cntl->stored_backlight_registers.BL_PWM_CNTL =
+				REG_READ(BL_PWM_CNTL);
+		panel_cntl->stored_backlight_registers.BL_PWM_CNTL2 =
+				REG_READ(BL_PWM_CNTL2);
+		panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
+				REG_READ(BL_PWM_PERIOD_CNTL);
+
+		REG_GET(PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
+				&panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+	}
+
+	// Have driver take backlight control
+	// TakeBacklightControl(true)
+	value = REG_READ(BIOS_SCRATCH_2);
+	value |= ATOM_S2_VRI_BRIGHT_ENABLE;
+	REG_WRITE(BIOS_SCRATCH_2, value);
+
+	// Enable the backlight output
+	REG_UPDATE(BL_PWM_CNTL, BL_PWM_EN, 1);
+
+	// Unlock group 2 backlight registers
+	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
+			BL_PWM_GRP1_REG_LOCK, 0);
+
+	current_backlight = calculate_16_bit_backlight_from_pwm(dce_panel_cntl);
+
+	return current_backlight;
 }
 
 bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
@@ -55,7 +160,7 @@ bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t value;
 
-	REG_GET(PWRSEQ_CNTL, BLON, &value);
+	REG_GET(PWRSEQ_CNTL, LVTMA_BLON, &value);
 
 	return value;
 }
@@ -65,13 +170,94 @@ bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t pwr_seq_state, dig_on, dig_on_ovrd;
 
-	REG_GET(PWRSEQ_STATE, PWRSEQ_TARGET_STATE_R, &pwr_seq_state);
+	REG_GET(PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, &pwr_seq_state);
 
-	REG_GET_2(PWRSEQ_CNTL, DIGON, &dig_on, DIGON_OVRD, &dig_on_ovrd);
+	REG_GET_2(PWRSEQ_CNTL, LVTMA_DIGON, &dig_on, LVTMA_DIGON_OVRD, &dig_on_ovrd);
 
 	return (pwr_seq_state == 1) || (dig_on == 1 && dig_on_ovrd == 1);
 }
 
+void dce_store_backlight_level(struct panel_cntl *panel_cntl)
+{
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
+
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL =
+		REG_READ(BL_PWM_CNTL);
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL2 =
+		REG_READ(BL_PWM_CNTL2);
+	panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
+		REG_READ(BL_PWM_PERIOD_CNTL);
+
+	REG_GET(PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
+		&panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+}
+
+void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
+		uint32_t backlight_pwm_u16_16)
+{
+	uint32_t backlight_16bit;
+	uint32_t masked_pwm_period;
+	uint8_t bit_count;
+	uint64_t active_duty_cycle;
+	uint32_t pwm_period_bitcnt;
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
+
+	/*
+	 * 1. Find  16 bit backlight active duty cycle, where 0 <= backlight
+	 * active duty cycle <= backlight period
+	 */
+
+	/* 1.1 Apply bitmask for backlight period value based on value of BITCNT
+	 */
+	REG_GET_2(BL_PWM_PERIOD_CNTL,
+			BL_PWM_PERIOD_BITCNT, &pwm_period_bitcnt,
+			BL_PWM_PERIOD, &masked_pwm_period);
+
+	if (pwm_period_bitcnt == 0)
+		bit_count = 16;
+	else
+		bit_count = pwm_period_bitcnt;
+
+	/* e.g. maskedPwmPeriod = 0x24 when bitCount is 6 */
+	masked_pwm_period = masked_pwm_period & ((1 << bit_count) - 1);
+
+	/* 1.2 Calculate integer active duty cycle required upper 16 bits
+	 * contain integer component, lower 16 bits contain fractional component
+	 * of active duty cycle e.g. 0x21BDC0 = 0xEFF0 * 0x24
+	 */
+	active_duty_cycle = backlight_pwm_u16_16 * masked_pwm_period;
+
+	/* 1.3 Calculate 16 bit active duty cycle from integer and fractional
+	 * components shift by bitCount then mask 16 bits and add rounding bit
+	 * from MSB of fraction e.g. 0x86F7 = ((0x21BDC0 >> 6) & 0xFFF) + 0
+	 */
+	backlight_16bit = active_duty_cycle >> bit_count;
+	backlight_16bit &= 0xFFFF;
+	backlight_16bit += (active_duty_cycle >> (bit_count - 1)) & 0x1;
+
+	/*
+	 * 2. Program register with updated value
+	 */
+
+	/* 2.1 Lock group 2 backlight registers */
+
+	REG_UPDATE_2(BL_PWM_GRP1_REG_LOCK,
+			BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, 1,
+			BL_PWM_GRP1_REG_LOCK, 1);
+
+	// 2.2 Write new active duty cycle
+	REG_UPDATE(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, backlight_16bit);
+
+	/* 2.3 Unlock group 2 backlight registers */
+	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
+			BL_PWM_GRP1_REG_LOCK, 0);
+
+	/* 3 Wait for pending bit to be cleared */
+	REG_WAIT(BL_PWM_GRP1_REG_LOCK,
+			BL_PWM_GRP1_REG_UPDATE_PENDING, 0,
+			1, 10000);
+}
+
 static void dce_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(*panel_cntl);
@@ -85,7 +271,8 @@ static const struct panel_cntl_funcs dce_link_panel_cntl_funcs = {
 	.hw_init = dce_panel_cntl_hw_init,
 	.is_panel_backlight_on = dce_is_panel_backlight_on,
 	.is_panel_powered_on = dce_is_panel_powered_on,
-
+	.store_backlight_level = dce_store_backlight_level,
+	.driver_set_backlight = dce_driver_set_backlight,
 };
 
 void dce_panel_cntl_construct(
@@ -95,6 +282,13 @@ void dce_panel_cntl_construct(
 	const struct dce_panel_cntl_shift *shift,
 	const struct dce_panel_cntl_mask *mask)
 {
+	struct panel_cntl *base = &dce_panel_cntl->base;
+
+	base->stored_backlight_registers.BL_PWM_CNTL = 0;
+	base->stored_backlight_registers.BL_PWM_CNTL2 = 0;
+	base->stored_backlight_registers.BL_PWM_PERIOD_CNTL = 0;
+	base->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV = 0;
+
 	dce_panel_cntl->regs = regs;
 	dce_panel_cntl->shift = shift;
 	dce_panel_cntl->mask = mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
index 6dc6984f9248..70ec691e14d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
@@ -35,10 +35,12 @@
 #define DCE_PANEL_CNTL_REG_LIST()\
 	DCE_PANEL_CNTL_SR(PWRSEQ_CNTL, LVTMA), \
 	DCE_PANEL_CNTL_SR(PWRSEQ_STATE, LVTMA), \
+	DCE_PANEL_CNTL_SR(PWRSEQ_REF_DIV, LVTMA), \
 	SR(BL_PWM_CNTL), \
 	SR(BL_PWM_CNTL2), \
 	SR(BL_PWM_PERIOD_CNTL), \
-	SR(BL_PWM_GRP1_REG_LOCK)
+	SR(BL_PWM_GRP1_REG_LOCK), \
+	SR(BIOS_SCRATCH_2)
 
 #define DCN_PANEL_CNTL_SR(reg_name, block)\
 	.reg_name = BASE(mm ## block ## _ ## reg_name ## _BASE_IDX) + \
@@ -47,33 +49,37 @@
 #define DCN_PANEL_CNTL_REG_LIST()\
 	DCN_PANEL_CNTL_SR(PWRSEQ_CNTL, LVTMA), \
 	DCN_PANEL_CNTL_SR(PWRSEQ_STATE, LVTMA), \
+	DCE_PANEL_CNTL_SR(PWRSEQ_REF_DIV, LVTMA), \
 	SR(BL_PWM_CNTL), \
 	SR(BL_PWM_CNTL2), \
 	SR(BL_PWM_PERIOD_CNTL), \
-	SR(BL_PWM_GRP1_REG_LOCK)
+	SR(BL_PWM_GRP1_REG_LOCK), \
+	SR(BIOS_SCRATCH_2)
 
-#define DCE_PANEL_CNTL_SF(block, reg_name, field_name, post_fix)\
-	.field_name = block ## reg_name ## __ ## block ## field_name ## post_fix
+#define DCE_PANEL_CNTL_SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
 
 #define DCE_PANEL_CNTL_MASK_SH_LIST(mask_sh) \
-	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, BLON, mask_sh),\
-	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, DIGON, mask_sh),\
-	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, DIGON_OVRD, mask_sh),\
-	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_STATE, PWRSEQ_TARGET_STATE_R, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_PWM_EN, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_LOCK, mask_sh), \
-	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_UPDATE_PENDING, mask_sh)
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_DIGON, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_DIGON_OVRD, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, mask_sh), \
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_CNTL, BL_PWM_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_LOCK, mask_sh), \
+	DCE_PANEL_CNTL_SF(BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_UPDATE_PENDING, mask_sh)
 
 #define DCE_PANEL_CNTL_REG_FIELD_LIST(type) \
-	type BLON;\
-	type DIGON;\
-	type DIGON_OVRD;\
-	type PWRSEQ_TARGET_STATE_R; \
+	type LVTMA_BLON;\
+	type LVTMA_DIGON;\
+	type LVTMA_DIGON_OVRD;\
+	type LVTMA_PWRSEQ_TARGET_STATE_R; \
+	type BL_PWM_REF_DIV; \
 	type BL_PWM_EN; \
 	type BL_ACTIVE_INT_FRAC_CNT; \
 	type BL_PWM_FRACTIONAL_EN; \
@@ -98,6 +104,8 @@ struct dce_panel_cntl_registers {
 	uint32_t BL_PWM_CNTL2;
 	uint32_t BL_PWM_PERIOD_CNTL;
 	uint32_t BL_PWM_GRP1_REG_LOCK;
+	uint32_t PWRSEQ_REF_DIV;
+	uint32_t BIOS_SCRATCH_2;
 };
 
 struct dce_panel_cntl {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 06d39d529c09..c15a4f5b4c62 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -70,53 +70,6 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t panel
 	return true;
 }
 
-static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_abm *dce_abm)
-{
-	uint64_t current_backlight;
-	uint32_t round_result;
-	uint32_t bl_period, bl_int_count;
-	uint32_t bl_pwm, fractional_duty_cycle_en;
-	uint32_t bl_period_mask, bl_pwm_mask;
-
-	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
-	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
-
-	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &bl_pwm);
-	REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle_en);
-
-	if (bl_int_count == 0)
-		bl_int_count = 16;
-
-	bl_period_mask = (1 << bl_int_count) - 1;
-	bl_period &= bl_period_mask;
-
-	bl_pwm_mask = bl_period_mask << (16 - bl_int_count);
-
-	if (fractional_duty_cycle_en == 0)
-		bl_pwm &= bl_pwm_mask;
-	else
-		bl_pwm &= 0xFFFF;
-
-	current_backlight = (uint64_t)bl_pwm << (1 + bl_int_count);
-
-	if (bl_period == 0)
-		bl_period = 0xFFFF;
-
-	current_backlight = div_u64(current_backlight, bl_period);
-	current_backlight = (current_backlight + 1) >> 1;
-
-	current_backlight = (uint64_t)(current_backlight) * bl_period;
-
-	round_result = (uint32_t)(current_backlight & 0xFFFFFFFF);
-
-	round_result = (round_result >> (bl_int_count-1)) & 1;
-
-	current_backlight >>= bl_int_count;
-	current_backlight += round_result;
-
-	return (uint32_t)(current_backlight);
-}
-
 static void dmcub_set_backlight_level(
 	struct dce_abm *dce_abm,
 	uint32_t backlight_pwm_u16_16,
@@ -178,10 +131,9 @@ static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-static void dmub_abm_init(struct abm *abm)
+static void dmub_abm_init(struct abm *abm, uint32_t backlight)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-	unsigned int backlight = calculate_16_bit_backlight_from_pwm(dce_abm);
 
 	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x103);
 	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x101);
@@ -261,77 +213,8 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 
 static bool dmub_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
 {
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-
 	dmub_abm_set_pipe(abm, DISABLE_ABM_IMMEDIATELY, panel_inst);
 
-	abm->stored_backlight_registers.BL_PWM_CNTL =
-		REG_READ(BL_PWM_CNTL);
-	abm->stored_backlight_registers.BL_PWM_CNTL2 =
-		REG_READ(BL_PWM_CNTL2);
-	abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
-		REG_READ(BL_PWM_PERIOD_CNTL);
-
-	REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
-		&abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-
-	return true;
-}
-
-static bool dmub_abm_init_backlight(struct abm *abm)
-{
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-	uint32_t value;
-
-	/* It must not be 0, so we have to restore them
-	 * Bios bug w/a - period resets to zero,
-	 * restoring to cache values which is always correct
-	 */
-	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &value);
-
-	if (value == 0 || value == 1) {
-		if (abm->stored_backlight_registers.BL_PWM_CNTL != 0) {
-			REG_WRITE(BL_PWM_CNTL,
-				abm->stored_backlight_registers.BL_PWM_CNTL);
-			REG_WRITE(BL_PWM_CNTL2,
-				abm->stored_backlight_registers.BL_PWM_CNTL2);
-			REG_WRITE(BL_PWM_PERIOD_CNTL,
-				abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
-			REG_UPDATE(LVTMA_PWRSEQ_REF_DIV,
-				BL_PWM_REF_DIV,
-				abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-		} else {
-			/* TODO: Note: This should not really happen since VBIOS
-			 * should have initialized PWM registers on boot.
-			 */
-			REG_WRITE(BL_PWM_CNTL, 0xC000FA00);
-			REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
-		}
-	} else {
-		abm->stored_backlight_registers.BL_PWM_CNTL =
-				REG_READ(BL_PWM_CNTL);
-		abm->stored_backlight_registers.BL_PWM_CNTL2 =
-				REG_READ(BL_PWM_CNTL2);
-		abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
-				REG_READ(BL_PWM_PERIOD_CNTL);
-
-		REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
-				&abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-	}
-
-	// Have driver take backlight control
-	// TakeBacklightControl(true)
-	value = REG_READ(BIOS_SCRATCH_2);
-	value |= ATOM_S2_VRI_BRIGHT_ENABLE;
-	REG_WRITE(BIOS_SCRATCH_2, value);
-
-	// Enable the backlight output
-	REG_UPDATE(BL_PWM_CNTL, BL_PWM_EN, 1);
-
-	// Unlock group 2 backlight registers
-	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
-			BL_PWM_GRP1_REG_LOCK, 0);
-
 	return true;
 }
 
@@ -340,8 +223,7 @@ static bool dmub_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int otg_inst,
-		uint32_t panel_inst,
-		bool fw_set_brightness)
+		uint32_t panel_inst)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 
@@ -384,7 +266,6 @@ static bool dmub_abm_init_config(struct abm *abm,
 static const struct abm_funcs abm_funcs = {
 	.abm_init = dmub_abm_init,
 	.set_abm_level = dmub_abm_set_level,
-	.init_backlight = dmub_abm_init_backlight,
 	.set_pipe = dmub_abm_set_pipe,
 	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm,
 	.get_current_backlight = dmub_abm_get_current_backlight,
@@ -404,10 +285,6 @@ static void dmub_abm_construct(
 
 	base->ctx = ctx;
 	base->funcs = &abm_funcs;
-	base->stored_backlight_registers.BL_PWM_CNTL = 0;
-	base->stored_backlight_registers.BL_PWM_CNTL2 = 0;
-	base->stored_backlight_registers.BL_PWM_PERIOD_CNTL = 0;
-	base->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV = 0;
 	base->dmcu_is_running = false;
 
 	abm_dce->regs = regs;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 6bd8d4e1c294..b77e9dc16086 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1066,7 +1066,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 		hws->funcs.edp_backlight_control(link, false);
-		dc_link_set_abm_disable(link);
+		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
@@ -2355,6 +2355,7 @@ static void init_hw(struct dc *dc)
 	struct abm *abm;
 	struct dmcu *dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
 	bp = dc->ctx->dc_bios;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -2401,12 +2402,17 @@ static void init_hw(struct dc *dc)
 		audio->funcs->hw_init(audio);
 	}
 
-	abm = dc->res_pool->abm;
-	if (abm != NULL) {
-		abm->funcs->init_backlight(abm);
-		abm->funcs->abm_init(abm);
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link->panel_cntl)
+			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
 	}
 
+	abm = dc->res_pool->abm;
+	if (abm != NULL)
+		abm->funcs->abm_init(abm, backlight);
+
 	dmcu = dc->res_pool->dmcu;
 	if (dmcu != NULL && abm != NULL)
 		abm->dmcu_is_running = dmcu->funcs->is_dmcu_initialized(dmcu);
@@ -2721,6 +2727,7 @@ bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct dc_link *link = pipe_ctx->stream->link;
 	struct dc  *dc = link->ctx->dc;
 	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = link->panel_cntl;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	bool fw_set_brightness = true;
 	/* DMCU -1 for all controller id values,
@@ -2728,23 +2735,38 @@ bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	 */
 	uint32_t controller_id = pipe_ctx->stream_res.tg->inst + 1;
 
-	if (abm == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
+	if (abm == NULL || panel_cntl == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
 		return false;
 
 	if (dmcu)
 		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
 
-	abm->funcs->set_backlight_level_pwm(
-			abm,
-			backlight_pwm_u16_16,
-			frame_ramp,
-			controller_id,
-			link->panel_cntl->inst,
-			fw_set_brightness);
+	if (!fw_set_brightness && panel_cntl->funcs->driver_set_backlight)
+		panel_cntl->funcs->driver_set_backlight(panel_cntl, backlight_pwm_u16_16);
+	else
+		abm->funcs->set_backlight_level_pwm(
+				abm,
+				backlight_pwm_u16_16,
+				frame_ramp,
+				controller_id,
+				link->panel_cntl->inst);
 
 	return true;
 }
 
+void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	if (abm)
+		abm->funcs->set_abm_immediate_disable(abm,
+				pipe_ctx->stream->link->panel_cntl->inst);
+
+	if (panel_cntl)
+		panel_cntl->funcs->store_backlight_level(panel_cntl);
+}
+
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -2781,6 +2803,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.set_cursor_position = dce110_set_cursor_position,
 	.set_cursor_attribute = dce110_set_cursor_attribute,
 	.set_backlight_level = dce110_set_backlight_level,
+	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index e609a72b4634..fe5326df00f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -88,6 +88,7 @@ void dce110_edp_wait_for_hpd_ready(
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp);
+void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 2eb5d0e3e425..b33eafe45f76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -903,8 +903,7 @@ static void dcn10_reset_back_end_for_pipe(
 	if (pipe_ctx->top_pipe == NULL) {
 
 		if (pipe_ctx->stream_res.abm)
-			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm,
-					pipe_ctx->stream->link->panel_cntl->inst);
+			dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
@@ -1245,6 +1244,7 @@ void dcn10_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
+	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -1411,11 +1411,16 @@ void dcn10_init_hw(struct dc *dc)
 		audio->funcs->hw_init(audio);
 	}
 
-	if (abm != NULL) {
-		abm->funcs->init_backlight(abm);
-		abm->funcs->abm_init(abm);
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link->panel_cntl)
+			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
 	}
 
+	if (abm != NULL)
+		abm->funcs->abm_init(abm, backlight);
+
 	if (dmcu != NULL && !dmcu->auto_load_dmcu)
 		dmcu->funcs->dmcu_init(dmcu);
 
@@ -2490,9 +2495,7 @@ void dcn10_blank_pixel_data(
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
 	} else if (blank) {
-		if (stream_res->abm)
-			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm,
-					stream->link->panel_cntl->inst);
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 		if (stream_res->tg->funcs->set_blank)
 			stream_res->tg->funcs->set_blank(stream_res->tg, blank);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 6ff7e2bd1d4a..897a3d25685a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -73,6 +73,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.set_backlight_level = dce110_set_backlight_level,
+	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3a290ccaeb82..da5333d165ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -961,9 +961,7 @@ void dcn20_blank_pixel_data(
 	width = width / odm_cnt;
 
 	if (blank) {
-		if (stream_res->abm)
-			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm,
-					stream->link->panel_cntl->inst);
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
 		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
 			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
@@ -2042,9 +2040,7 @@ static void dcn20_reset_back_end_for_pipe(
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
 
-		if (pipe_ctx->stream_res.abm)
-			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm,
-					pipe_ctx->stream->link->panel_cntl->inst);
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index c83d98e0d211..a8bcd747d7ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -84,6 +84,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.set_backlight_level = dce110_set_backlight_level,
+	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 2c87e571579a..e97dfaa656e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -88,6 +88,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.power_down = dce110_power_down,
 	.set_backlight_level = dce110_set_backlight_level,
+	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 91a42f0f1fc4..e8ce8c85adf1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -27,27 +27,17 @@
 
 #include "dm_services_types.h"
 
-struct abm_backlight_registers {
-	unsigned int BL_PWM_CNTL;
-	unsigned int BL_PWM_CNTL2;
-	unsigned int BL_PWM_PERIOD_CNTL;
-	unsigned int LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
-};
-
 struct abm {
 	struct dc_context *ctx;
 	const struct abm_funcs *funcs;
 	bool dmcu_is_running;
-	/* registers setting needs to be saved and restored at InitBacklight */
-	struct abm_backlight_registers stored_backlight_registers;
 };
 
 struct abm_funcs {
-	void (*abm_init)(struct abm *abm);
+	void (*abm_init)(struct abm *abm, uint32_t back_light);
 	bool (*set_abm_level)(struct abm *abm, unsigned int abm_level);
 	bool (*set_abm_immediate_disable)(struct abm *abm, unsigned int panel_inst);
 	bool (*set_pipe)(struct abm *abm, unsigned int controller_id, unsigned int panel_inst);
-	bool (*init_backlight)(struct abm *abm);
 
 	/* backlight_pwm_u16_16 is unsigned 32 bit,
 	 * 16 bit integer + 16 fractional, where 1.0 is max backlight value.
@@ -56,8 +46,7 @@ struct abm_funcs {
 			unsigned int backlight_pwm_u16_16,
 			unsigned int frame_ramp,
 			unsigned int controller_id,
-			unsigned int panel_inst,
-			bool fw_set_brightness);
+			unsigned int panel_inst);
 
 	unsigned int (*get_current_backlight)(struct abm *abm);
 	unsigned int (*get_target_backlight)(struct abm *abm);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 5a75d035f1fa..f9ab5abb6462 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -32,11 +32,23 @@
 
 #include "dc_types.h"
 
+#define MAX_BACKLIGHT_LEVEL 0xFFFF
+
+struct panel_cntl_backlight_registers {
+	unsigned int BL_PWM_CNTL;
+	unsigned int BL_PWM_CNTL2;
+	unsigned int BL_PWM_PERIOD_CNTL;
+	unsigned int LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
+};
+
 struct panel_cntl_funcs {
 	void (*destroy)(struct panel_cntl **panel_cntl);
-	void (*hw_init)(struct panel_cntl *panel_cntl);
+	uint32_t (*hw_init)(struct panel_cntl *panel_cntl);
 	bool (*is_panel_backlight_on)(struct panel_cntl *panel_cntl);
 	bool (*is_panel_powered_on)(struct panel_cntl *panel_cntl);
+	void (*store_backlight_level)(struct panel_cntl *panel_cntl);
+	void (*driver_set_backlight)(struct panel_cntl *panel_cntl,
+			uint32_t backlight_pwm_u16_16);
 };
 
 struct panel_cntl_init_data {
@@ -48,6 +60,8 @@ struct panel_cntl {
 	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
+	/* registers setting needs to be saved and restored at InitBacklight */
+	struct panel_cntl_backlight_registers stored_backlight_registers;
 };
 
 #endif /* DC_PANEL_CNTL_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 1570fed20de0..3b2ea9bdb62c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -196,6 +196,8 @@ struct hw_sequencer_funcs {
 			uint32_t backlight_pwm_u16_16,
 			uint32_t frame_ramp);
 
+	void (*set_abm_immediate_disable)(struct pipe_ctx *pipe_ctx);
+
 
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
