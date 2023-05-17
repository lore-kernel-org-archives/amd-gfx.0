Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9062FC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AC010E3FB;
	Wed, 17 May 2023 11:39:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393EB10E3F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkvy3RV77S7HC/2kGqcPBUD9Dm8TzrTBoewUr4mX2JS9YVoh1VI8c8EGOCIE67/Be1zvYJIlHV46f4LuBQT06lhWjPCQmgdx02522eLkp1koEJskZKwwd2/iMOSiueKaQQ5xgXJWOZlt39rXkbuHaIFvyuiFDZJooLkXPWYRsy5xe7Azstnem1cbapriHy71eoEv80Eq+Ksd6eoZUu1SgMHhJK5W+bC6jNPvFUgs6oTQcLq5j3TgzZPE0nGCl03LmgTHAZA3MbgXZ8+Gck1+MCVvzqx68agRU9htviDYfakjZi2Z9Lq2j+EHtK0+txmxH0rMyK59Yba5P4s1jowqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4DDbKkOe9YtcM7BfQtBBnDJgamCLQY1bP3wbZnRbx0=;
 b=FQ5SACjGsxtMfn+gH8J98Wb3lG0FaI6XHRbHhc1Ad9R20IgBdQ3DRwI7dsELVpXZErAmgvNIIrJ3YPFo14MfiKhroEIE+8ckzIqg0wNhdO1l7PKMwmOpvBBjhgnNRFL9bmMALDDeiuKTcEl+AVUW33VbPMYxv1977JTmAdXy5BXXNTi973uK7jFT+d8CWGvOQUj26JGXeDa12PCIgkU81seXlkfPcr9sjXOIsLQiEcjWDrO949JNzaVpDxygwym6zWV5/pza3Qvd25TVlnLiGf0BTMVMymZ0hVSuuquGrakJ9hnipM4Ybki/WejH611gyAZmCeCci19gKdgRim4WbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4DDbKkOe9YtcM7BfQtBBnDJgamCLQY1bP3wbZnRbx0=;
 b=gjdcGV+Y7WDvCUXu/+vL5+iGwHxwWKfDRgkT9Q0BbepSa5FbFj1qF0OGaCem4wZJ2zdJvO/HFy9plac9BckYWlOj+6VOyss4/YDF1ORrY4qZqJoZeyDE87V1gLTdvmpW/Iu03dFZ0moF9P1/fcfxxR5nSD3dEDad1HbrpaseK7o=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 11:39:35 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d0) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 11:39:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:33 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/18] drm/amd/display: Trigger DIO FIFO resync on commit
 streams
Date: Wed, 17 May 2023 19:37:14 +0800
Message-ID: <20230517113723.1757259-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: e542ee7a-c1bc-43e8-65de-08db56cb637b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7J6BW/Y/BgcfZs/5VKC6ZcHUmdFZJhVP08fpFrypBy07O6PRG4zI2efIA8sODCJnRTV8EA4sm4dqaWaGMwLyfOCviges+6bUlhzI0m/oQDD0yhy5p8y+beZuhfXPqdZFa0892olUP26LEjTUL28BIKVCsO3d7qIiiJGZ7GBO6CF8bHb2fUIJeRCoVcKIXtdRTcl4EXiRYKqslF2v9KhMBhIlLyzVo828Tfr0zpEkkx9cdoVB0jFE271IuEoByzAii5FkC+dN9ZvS7TqkjiBXprjzCUvyBNx0GHKbH+PmaTfmJxUkZsPrZr7EbpiZHOB0szD4AVxu4sq5vIskz0wIG7oPNDBMllz/c6cXbXBkIeTCScPatTTWaAx8YtckWg3mkeYuYOdW4kwwUyyoSP8lNGSZ1AizVPIF5tQuxU0DFEY5gtdhh5kXylVPDaIg0BOw0H6lqArM96/pL7GEMPbgTyC8IkuWFRaoER5BX1rNOpS/1Ike1Kxmho44rX+rZjcF30aUdOxyE4epV/atmcwwsZmPR+9aAo5Mg0jbc5azOR/pATDZuZwx4pmUzrfBEFI0eM03K4a0kRC7gHKr5mYPEYYa2Va1aVJJNyssrBZ+/C4PPvrqlBqwjNAtl0U5yMH+fYkjtmIF9RfgwgxcEIW3PVFQQFiLoSIxMqDI9ry/RZdb+FxWFfLQYrtKFucr9XPlP509xn5gS17dFPmLmRJYgL4sVdJF4Bdcs0jFcKfbMTuFfSkK7cYfqXH5K2o4yFggH5daio685PCognOpgBr9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(70586007)(4326008)(54906003)(316002)(7696005)(478600001)(6916009)(86362001)(70206006)(81166007)(82310400005)(40480700001)(2616005)(82740400003)(8676002)(8936002)(5660300002)(2906002)(6666004)(356005)(41300700001)(186003)(26005)(1076003)(336012)(36860700001)(426003)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:39:34.9032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e542ee7a-c1bc-43e8-65de-08db56cb637b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Saaem Rizvi <syedsaaem.rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <syedsaaem.rizvi@amd.com>

[WHY]
Currently, there is an intermittent issue where a screen can either go
blank or be corrupted.

[HOW]
To resolve the issue we trigger the ramping logic for DIO FIFO so that
it goes back up to the correct speed.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  3 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  4 ++-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 11 ++++++++
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  5 +++-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 27 +++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 ++
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  3 +++
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 ++
 9 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 8d2460d06bce..1a0be40d125c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2291,6 +2291,9 @@ enum dc_status dce110_apply_ctx_to_hw(
 
 		if (DC_OK != status)
 			return status;
+
+		if (hws->funcs.resync_fifo_dccg_dio)
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
 	}
 
 	if (dc->fbc_compressor)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 7bdc146f7cb5..c8602bcfa393 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -208,7 +208,9 @@
 #define DCCG314_REG_FIELD_LIST(type) \
 	type DSCCLK3_DTO_PHASE;\
 	type DSCCLK3_DTO_MODULO;\
-	type DSCCLK3_DTO_ENABLE;
+	type DSCCLK3_DTO_ENABLE;\
+	type DENTIST_DISPCLK_RDIVIDER;\
+	type DENTIST_DISPCLK_WDIVIDER;
 
 #define DCCG32_REG_FIELD_LIST(type) \
 	type DPSTREAMCLK0_EN;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index de7bfba2c179..e0e7d32bb1a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -45,6 +45,16 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg314_trigger_dio_fifo_resync(
+	struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t dispclk_rdivider_value = 0;
+
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
+	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
+}
+
 static void dccg314_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -357,6 +367,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
 	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
+	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index 90687a9e8fdd..8e07d3151f91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -192,7 +192,10 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_GATE_DISABLE, mask_sh)
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh)
 
 struct dccg *dccg314_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index f7a3e0d71d01..70fac2ebb757 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -390,6 +390,33 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 				pix_per_cycle);
 }
 
+void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
+{
+	uint8_t i;
+	struct pipe_ctx *pipe = NULL;
+	bool otg_disabled[MAX_PIPES] = {false};
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->top_pipe || pipe->prev_odm_pipe)
+			continue;
+
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
+			reset_sync_context_for_pipe(dc, context, i);
+			otg_disabled[i] = true;
+		}
+	}
+
+	hws->ctx->dc->res_pool->dccg->funcs->trigger_dio_fifo_resync(hws->ctx->dc->res_pool->dccg);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (otg_disabled[i])
+			pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+	}
+}
+
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
 {
 	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 6d0b62503caa..559d71002e8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -41,6 +41,8 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
+void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
+
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 7a28c7bb25d2..90be62c05822 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -152,6 +152,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
+	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 };
 
 void dcn314_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ad6acd1b34e1..0b700b3d7d97 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -159,6 +159,9 @@ struct dccg_funcs {
 			int otg_inst,
 			int pixclk_khz);
 
+	void (*trigger_dio_fifo_resync)(
+			struct dccg *dccg);
+
 	void (*dpp_root_clock_control)(
 			struct dccg *dccg,
 			unsigned int dpp_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 4513544559be..4ca4192c1e12 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -160,6 +160,8 @@ struct hwseq_private_funcs {
 			unsigned int *k1_div,
 			unsigned int *k2_div);
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
+	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
+			struct dc_state *context);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
 #endif
 };
-- 
2.25.1

