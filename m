Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7BC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6622076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lnJSxWzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6622076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019A76E12C;
	Wed, 22 Apr 2020 22:08:30 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C0489FCA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKCAuRU31Q44Fr2xidM9G0hBGZJHOyZTZvsOAu2642if5QGTOxsLvp/xIJkZLJzo2XhvTCaAKPX1KajBetDBS/aYUkT7lQ8LZEdThcV8nDW2ZjxkKDdSK8brHifGwBfWPOXnWQyL/rZTOAzEw+bAioOaNE5K8w5DH8zyUg2XI6sMnh7nCvGBREPzl41WL90lqaagiOp1/3yE6jBHWoOT5p8MlO4zrlEzBKDxAIyp+W3rqVOpLZmPm8tLdXUAC3r+hTl2/zfOokMFYlkchnwfQ1r1tdN2XSlVYZN8cHeQjTKOqsNPwwitIhI1U9HcACRw7rsAr7Qgt06xZFQ8HsSKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPn9kQ5WDFRJ+xGnawX4HQj1rskdPbTSXuXKj0SVusg=;
 b=IwNpueFWGga+SHnkfwa4oITL5wsP75ubLhk3e5Qx27esHFlAEF1LJKr1YfElIgWcJPBBACOar8CGOlkk5CNA6fR1ERRhF4RC5gUdt08+FLdKva280f3JhdKRTNpfvJCmJqh645izFhKxwA75cFBHto8Ud//OTfQl84A2pnRXgWQAEEgllrzRHOIm+sNQbwxh2p1y0/dYtGjqnfN0r73wjf0aTEUQumUGuTdUz7RMZnbvzKr5jx7K/VNffJwrxHeW7SPa6NeNkams9W6AjrewEXaEBNatNvJJINtcT/j11WG2/aEMIGV8gkD/aIzOiiYEJxichFq/kA+Qxj2Bhes9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPn9kQ5WDFRJ+xGnawX4HQj1rskdPbTSXuXKj0SVusg=;
 b=lnJSxWzLO0NceIX1aFmrC9DvnK9nEH06axdUp7dm0WZxTIbohikFD23O6cwesa8pEjL13T3gP6c404jD4wmDWihUm+Inn7K7FB+XUK0AnxZdyMETQxkDT/tAd9suduujj53w5f0N1Tu9PbdhxCzIrzCutLaf5FFEHs83YIA0R1U=
Received: from MWHPR22CA0056.namprd22.prod.outlook.com (2603:10b6:300:12a::18)
 by BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:27 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::65) by MWHPR22CA0056.outlook.office365.com
 (2603:10b6:300:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:25 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:24 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: Add panel cntl id for set backlight
 level.
Date: Wed, 22 Apr 2020 18:07:59 -0400
Message-ID: <20200422220805.15759-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(428003)(46966005)(82740400003)(2906002)(356005)(47076004)(81156014)(8676002)(8936002)(70586007)(316002)(6916009)(70206006)(81166007)(7696005)(478600001)(4326008)(54906003)(5660300002)(30864003)(86362001)(1076003)(82310400002)(26005)(44832011)(336012)(36756003)(6666004)(426003)(186003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2faa9e-d48d-4f48-b19f-08d7e709ae7f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3361:
X-Microsoft-Antispam-PRVS: <BN8PR12MB336146C7F7C28158E24EF8668BD20@BN8PR12MB3361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1egBfr7nZHJCkYQHXDuJFbFruZwZ4qGUWim5O3EkEFWBEP/CM5EJ5VsabH0Onj7/y9TtS83dG8YvlLiFbKfc/447exrq19xsj/zswPZIDBBQIw8swssfAhfI+jJckRaMETwH5V4O985kJf5PTlmKh6KfRUQn6Y4lBtd8XF0nrRJ7TaABKUMtpRTgbmzN39rpaRsQjjqfnPFGR8SPZ3Gm2UaibRcxzn2GVWj3uORPLcOOSSLzK3l2KQ2ylhZACBk0YhzQH1pb5AhFqBhoErD0WvPPGrhmJadFxur3n9bGg0w47zioq3JwWGjzy8H6PvN/HUBwEG5SlPr8isa3a8VNUM+jwBVuNYkUvitOeamrd5I/C4h+ekTcQEs2by9xDeQkdHDfyRf4V+vYbWFdXFCzBKkht9seex/bCmK/KvxByjVqLwxnjRrbqsP+RgukwvK+JsEX4b1xDoI25+j4Fh5osC3c2xpQ3VSpHdO8BT1jsRUNQ/woZC8xDHQnU6woOhTe8vfaVPnecTVIciY4+fZtCA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:26.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2faa9e-d48d-4f48-b19f-08d7e709ae7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3361
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
Add panel cntl instance when calling set backlight.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c         |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c     | 15 +++++++++------
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c    | 16 ++++++++++------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c    |  9 ++++++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c   |  9 ++++++---
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h      |  5 +++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h  |  1 +
 8 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0f7810571be3..ad817bd74586 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2210,7 +2210,9 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 				if (should_program_abm) {
 					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
-						pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm);
+						pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(
+								pipe_ctx->stream_res.abm,
+								pipe_ctx->stream->link->panel_cntl->inst);
 					} else {
 						pipe_ctx->stream_res.abm->funcs->set_abm_level(
 							pipe_ctx->stream_res.abm, stream->abm_level);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9c4686edcf3e..a54b3e05f66b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2552,6 +2552,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 				backlight_pwm_u16_16,
 				frame_ramp,
 				controller_id,
+				link->panel_cntl->inst,
 				fw_set_brightness);
 	}
 
@@ -2564,7 +2565,7 @@ bool dc_link_set_abm_disable(const struct dc_link *link)
 	bool success = false;
 
 	if (abm)
-		success = abm->funcs->set_abm_immediate_disable(abm);
+		success = abm->funcs->set_abm_immediate_disable(abm, link->panel_cntl->inst);
 
 	return success;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 4dae9efebb6f..c15e60fb5ebc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -55,7 +55,7 @@
 
 #define MCP_DISABLE_ABM_IMMEDIATELY 255
 
-static bool dce_abm_set_pipe(struct abm *abm, uint32_t controller_id)
+static bool dce_abm_set_pipe(struct abm *abm, uint32_t controller_id, uint32_t panel_inst)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 	uint32_t rampingBoundary = 0xFFFF;
@@ -201,7 +201,8 @@ static void dmcu_set_backlight_level(
 	struct dce_abm *abm_dce,
 	uint32_t backlight_pwm_u16_16,
 	uint32_t frame_ramp,
-	uint32_t controller_id)
+	uint32_t controller_id,
+	uint32_t panel_id)
 {
 	unsigned int backlight_8_bit = 0;
 	uint32_t s2;
@@ -213,7 +214,7 @@ static void dmcu_set_backlight_level(
 		// Take MSB of fractional part since backlight is not max
 		backlight_8_bit = (backlight_pwm_u16_16 >> 8) & 0xFF;
 
-	dce_abm_set_pipe(&abm_dce->base, controller_id);
+	dce_abm_set_pipe(&abm_dce->base, controller_id, panel_id);
 
 	/* waitDMCUReadyForCmd */
 	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT,
@@ -331,14 +332,14 @@ static bool dce_abm_set_level(struct abm *abm, uint32_t level)
 	return true;
 }
 
-static bool dce_abm_immediate_disable(struct abm *abm)
+static bool dce_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 
 	if (abm->dmcu_is_running == false)
 		return true;
 
-	dce_abm_set_pipe(abm, MCP_DISABLE_ABM_IMMEDIATELY);
+	dce_abm_set_pipe(abm, MCP_DISABLE_ABM_IMMEDIATELY, panel_inst);
 
 	abm->stored_backlight_registers.BL_PWM_CNTL =
 		REG_READ(BL_PWM_CNTL);
@@ -420,6 +421,7 @@ static bool dce_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int controller_id,
+		unsigned int panel_inst,
 		bool fw_set_brightness)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
@@ -432,7 +434,8 @@ static bool dce_abm_set_backlight_level_pwm(
 		dmcu_set_backlight_level(abm_dce,
 				backlight_pwm_u16_16,
 				frame_ramp,
-				controller_id);
+				controller_id,
+				panel_inst);
 	else
 		driver_set_backlight_level(abm_dce, backlight_pwm_u16_16);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 09e19e3332e2..06d39d529c09 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -50,7 +50,7 @@
 
 #define DISABLE_ABM_IMMEDIATELY 255
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst)
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -59,6 +59,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst)
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
 	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
 
@@ -120,7 +121,8 @@ static void dmcub_set_backlight_level(
 	struct dce_abm *dce_abm,
 	uint32_t backlight_pwm_u16_16,
 	uint32_t frame_ramp,
-	uint32_t otg_inst)
+	uint32_t otg_inst,
+	uint32_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dce_abm->base.ctx;
@@ -134,7 +136,7 @@ static void dmcub_set_backlight_level(
 		// Take MSB of fractional part since backlight is not max
 		backlight_8_bit = (backlight_pwm_u16_16 >> 8) & 0xFF;
 
-	dmub_abm_set_pipe(&dce_abm->base, otg_inst);
+	dmub_abm_set_pipe(&dce_abm->base, otg_inst, panel_inst);
 
 	REG_UPDATE(BL1_PWM_USER_LEVEL, BL1_PWM_USER_LEVEL, backlight_pwm_u16_16);
 
@@ -257,11 +259,11 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 	return true;
 }
 
-static bool dmub_abm_immediate_disable(struct abm *abm)
+static bool dmub_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 
-	dmub_abm_set_pipe(abm, DISABLE_ABM_IMMEDIATELY);
+	dmub_abm_set_pipe(abm, DISABLE_ABM_IMMEDIATELY, panel_inst);
 
 	abm->stored_backlight_registers.BL_PWM_CNTL =
 		REG_READ(BL_PWM_CNTL);
@@ -338,6 +340,7 @@ static bool dmub_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int otg_inst,
+		uint32_t panel_inst,
 		bool fw_set_brightness)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
@@ -345,7 +348,8 @@ static bool dmub_abm_set_backlight_level_pwm(
 	dmcub_set_backlight_level(dce_abm,
 			backlight_pwm_u16_16,
 			frame_ramp,
-			otg_inst);
+			otg_inst,
+			panel_inst);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0d53e1d6d6b7..bfc8578eda15 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -903,7 +903,8 @@ static void dcn10_reset_back_end_for_pipe(
 	if (pipe_ctx->top_pipe == NULL) {
 
 		if (pipe_ctx->stream_res.abm)
-			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm);
+			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm,
+					pipe_ctx->stream->link->panel_cntl->inst);
 
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
@@ -2474,12 +2475,14 @@ void dcn10_blank_pixel_data(
 		if (stream_res->tg->funcs->set_blank)
 			stream_res->tg->funcs->set_blank(stream_res->tg, blank);
 		if (stream_res->abm) {
-			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1);
+			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1,
+					stream->link->panel_cntl->inst);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
 	} else if (blank) {
 		if (stream_res->abm)
-			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm);
+			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm,
+					stream->link->panel_cntl->inst);
 		if (stream_res->tg->funcs->set_blank)
 			stream_res->tg->funcs->set_blank(stream_res->tg, blank);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index bd2ccf8eb9cf..3a290ccaeb82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -962,7 +962,8 @@ void dcn20_blank_pixel_data(
 
 	if (blank) {
 		if (stream_res->abm)
-			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm);
+			stream_res->abm->funcs->set_abm_immediate_disable(stream_res->abm,
+					stream->link->panel_cntl->inst);
 
 		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
 			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
@@ -997,7 +998,8 @@ void dcn20_blank_pixel_data(
 
 	if (!blank)
 		if (stream_res->abm) {
-			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1);
+			stream_res->abm->funcs->set_pipe(stream_res->abm, stream_res->tg->inst + 1,
+					stream->link->panel_cntl->inst);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
 }
@@ -2041,7 +2043,8 @@ static void dcn20_reset_back_end_for_pipe(
 	if (pipe_ctx->top_pipe == NULL) {
 
 		if (pipe_ctx->stream_res.abm)
-			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm);
+			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm,
+					pipe_ctx->stream->link->panel_cntl->inst);
 
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 0dd12c4fc23c..91a42f0f1fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -45,8 +45,8 @@ struct abm {
 struct abm_funcs {
 	void (*abm_init)(struct abm *abm);
 	bool (*set_abm_level)(struct abm *abm, unsigned int abm_level);
-	bool (*set_abm_immediate_disable)(struct abm *abm);
-	bool (*set_pipe)(struct abm *abm, unsigned int controller_id);
+	bool (*set_abm_immediate_disable)(struct abm *abm, unsigned int panel_inst);
+	bool (*set_pipe)(struct abm *abm, unsigned int controller_id, unsigned int panel_inst);
 	bool (*init_backlight)(struct abm *abm);
 
 	/* backlight_pwm_u16_16 is unsigned 32 bit,
@@ -56,6 +56,7 @@ struct abm_funcs {
 			unsigned int backlight_pwm_u16_16,
 			unsigned int frame_ramp,
 			unsigned int controller_id,
+			unsigned int panel_inst,
 			bool fw_set_brightness);
 
 	unsigned int (*get_current_backlight)(struct abm *abm);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6b48285446c3..eb10518dc058 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -261,6 +261,7 @@ struct dmub_rb_cmd_psr_set_version {
 struct dmub_cmd_abm_set_pipe_data {
 	uint32_t ramping_boundary;
 	uint32_t otg_inst;
+	uint32_t panel_inst;
 };
 
 struct dmub_rb_cmd_abm_set_pipe {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
