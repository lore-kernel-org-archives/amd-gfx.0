Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED58C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFB660724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBFB660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB406E1E9;
	Wed,  8 Sep 2021 14:55:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FC36E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j687rm3uucBr65m1uS13etLeOvUbeySmFOEXmoCHtUh+/r5kN3fHKUkgiSzACtEDn0Rq40ExvFLWInLb4QKNNqfKPfwM0FGzJJWStXgbmHGu7qGvy6CJvNrBuzXSJ04kRPb3Mv0+56slOJ4xYZj7uKyPtGRmqKKspHaMZbD3P9qgb4NLl4YM7tvcHnnCcOeE9akcyUJGJHJSwIjjAsNovCU8Rc9QR2XkphZyjcqxcDA3NX1r9fxA1jXURVUKKFGMs+9UnvT2R42uVr4rltB48YpsDOWnN+j1cCmELaImrUQwZwFDbxxzG5bPIowZHNEu0s8LvP4e+8dQ6v0UcWrfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/+MivK7RFtfDqumNe3xy8dkEuAZWuDJJorfGcGXZxaQ=;
 b=lc84xm5lXTf0OGr/tRi9hrBXHyBBZrI4Rki2puDTLJLfAnyHsegvcw6aFpaj4oUGUxaFofUFwd2Wjj/cD7Udo/I9K+AkZ9hnl+axW45PRyD5UkBs6tQsFDKZv5+BxN07h7HsgOwX5A3/15VXTvO/a7JoL8JmYsf1/RTN0Nehgd9mGU5YjJEH0aiQT44lWL/udoql7YPpPuHNqfwe76jz+XkUkwdwh053ItY7n/TN00oB49Sa2egPoXypEKWfRoXu7Y28TKy1C8ay9XCqBb+0wVi8RR2LgWNskAPUnjEDZyoURcKl7dfvHTkoZntmso4wy3l4gDF5SOhbqRs5EeYzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+MivK7RFtfDqumNe3xy8dkEuAZWuDJJorfGcGXZxaQ=;
 b=e5T1d32ua1+Gi5chI/lCb119nBouc7Xcq2flQgVi11uNmCoc1WjZg36QUiRO30fuzHi1OdIG0gSAaO5EaJABFvzmUwNCyXQIm7sDgtstxGj4buDmV+kCKsGBK/KRxsR7GSmd/89RxTUg8ytfd+OUoxWdKfAp1CzSzL88Zwe90eE=
Received: from DM5PR13CA0057.namprd13.prod.outlook.com (2603:10b6:3:117::19)
 by BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 14:55:03 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::1c) by DM5PR13CA0057.outlook.office365.com
 (2603:10b6:3:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:03 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:02 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Eric Yang
 <Eric.Yang2@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 23/33] drm/amd/display: Add periodic detection when zstate is
 enabled
Date: Wed, 8 Sep 2021 10:54:14 -0400
Message-ID: <20210908145424.3311-24-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5508729-ae91-4419-3500-08d972d8a3d4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3399:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3399AEEF81AA2B7CFB6EAE9BE4D49@BYAPR12MB3399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixOOGuzb2EtW3zuAQdQW33UM4LDZPy5/SmJKwPQiKaAuARFeZqudSp/3tgEhg1uArSuVC13+UH0lvYx3HNC4IBmuUo85BDW2pXiecH6LC7TdviVq6ZFlqeKWCo+CeJXPu/E4BGVjXb+8/BhuPUCGPwIkMM8AaHDsvXjDPRMiZ6M2Q2Hqu5YgUYKqMcv0k2o3MH8lv6EnoODPLnJboHIehQ9UDocUgoLBnV9eVVuLrRjgQC+ZMSEuYg6H9svCrrPtfNWGrDQejeo4umGQRe+FjFkjvJIXFwpyKthkB82bQ2onN316UB3xbbY60OmRbxtuyjOWtX310fqDnSYST82Johxv+5BliiLldBKAm4/RiQYc/WKwfQWCy8Y8p2s+C5vA732ibQQy2CtfBtDV3TMSTW1mxSJVwlsCev9Ngrv6BRAysOy8TPXhlQ5Vhc+CKxlHncI5XtLGv4OOYGDfyEnW83M0Cwdxt6399JpJUtiLToZ9gLJOzaTDUscn/RcYzYT+R8A10JYU9pmzige8hq1FxChPtRM27tMSdTYtld4p39UGcJepvPPn+YE7KhI/2BoxslaSlwpew9h5Evn7OlTWegkriuu7tFjovQhcjchHwkvM0GvifBr61ze41aPn8muiOcldYTwZsSJXloExC1zvm6Rh6SCY/32X/RiR5mXyVlktozVbkB9CBo7mwJhaxBw9KWOrv9OifqI5WmRmuxXHAmEsRUidpEtP5ZYS8/kYWnc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(70206006)(5660300002)(70586007)(478600001)(44832011)(2906002)(16526019)(6916009)(86362001)(4326008)(316002)(36756003)(81166007)(54906003)(26005)(6666004)(426003)(2616005)(186003)(82310400003)(336012)(36860700001)(356005)(82740400003)(83380400001)(8676002)(8936002)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:03.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5508729-ae91-4419-3500-08d972d8a3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3399
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
When system is in Z10 HPD interrupts cannot fire, we may miss display
configuration changes.

[How]
When Zstate is enabled, if DMUB indicate DCN has lost power, do a
complete detection periodically.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 ++++++
 .../drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c               |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c          |  4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h                    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c     |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h     |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h            |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h      |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h            |  4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c      |  8 ++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h      |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c        | 10 +++++++++-
 13 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 8c1792637836..1aa69dd8e02f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -793,4 +793,10 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
        // FPGA programming for this clock in diags framework that
        // needs to go through dm layer, therefore leave dummy interace here
 }
+
+
+void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
+{
+	/* TODO: add peridic detection implementation */
+}
 #endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 1414da4b95d7..d7bf9283dc90 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -142,6 +142,7 @@ static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_ALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn31_smu_set_Z9_support(clk_mgr, true);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
@@ -166,6 +167,7 @@ static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn31_smu_set_Z9_support(clk_mgr, false);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 822239b59a78..7a1f910d711e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1562,7 +1562,7 @@ static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-void dc_z10_restore(struct dc *dc)
+void dc_z10_restore(const struct dc *dc)
 {
 	if (dc->hwss.z10_restore)
 		dc->hwss.z10_restore(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 61e49671fed5..46933a43ef2e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1250,6 +1250,10 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 		}
 	}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	dc_z10_restore(dc);
+#endif
+
 	/* get out of low power state */
 	if (!can_apply_seamless_boot && reason != DETECT_REASON_BOOT)
 		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ece44796a74f..134faa7a1937 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1363,7 +1363,7 @@ void dc_hardware_release(struct dc *dc);
 
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-void dc_z10_restore(struct dc *dc);
+void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 83f223d745fa..d3598ce1f5de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -425,7 +425,7 @@ void dcn31_z10_save_init(struct dc *dc)
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 }
 
-void dcn31_z10_restore(struct dc *dc)
+void dcn31_z10_restore(const struct dc *dc)
 {
 	union dmub_rb_cmd cmd;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
index 140435e4f7ff..7ae45dd202d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
@@ -43,7 +43,7 @@ void dcn31_enable_power_gating_plane(
 
 void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx);
 
-void dcn31_z10_restore(struct dc *dc);
+void dcn31_z10_restore(const struct dc *dc);
 void dcn31_z10_save_init(struct dc *dc);
 
 void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 8de554fb98b9..3a905fb667bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -160,6 +160,10 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable);
+#endif
+
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
 
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index ad5f2adcc40d..d50f4bd06b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -236,7 +236,7 @@ struct hw_sequencer_funcs {
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
 
-	void (*z10_restore)(struct dc *dc);
+	void (*z10_restore)(const struct dc *dc);
 	void (*z10_save_init)(struct dc *dc);
 
 	void (*update_visual_confirm_color)(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index caf961bb633f..ef324fc39315 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -358,6 +358,8 @@ struct dmub_srv_hw_funcs {
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
 	void (*get_diagnostic_data)(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
+
+	bool (*should_detect)(struct dmub_srv *dmub);
 };
 
 /**
@@ -724,6 +726,8 @@ bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entr
 
 bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
 
+bool dmub_srv_should_detect(struct dmub_srv *dmub);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index fc667cb17eb0..6ac370c15dea 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -432,3 +432,11 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
 }
+
+bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
+{
+	uint32_t fw_boot_status = REG_READ(DMCUB_SCRATCH0);
+	bool should_detect = fw_boot_status & DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED;
+	return should_detect;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index bb62605d2ac8..59ddc81b5a0e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -245,4 +245,6 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
 
 void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
 
+bool dmub_dcn31_should_detect(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN31_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 75a91cfaf036..a6188d067d65 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -234,7 +234,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_outbox0_rptr = dmub_dcn31_set_outbox0_rptr;
 
 		funcs->get_diagnostic_data = dmub_dcn31_get_diagnostic_data;
-
+		funcs->should_detect = dmub_dcn31_should_detect;
 		funcs->get_current_time = dmub_dcn31_get_current_time;
 
 		break;
@@ -816,3 +816,11 @@ bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_
 	dmub->hw_funcs.get_diagnostic_data(dmub, diag_data);
 	return true;
 }
+
+bool dmub_srv_should_detect(struct dmub_srv *dmub)
+{
+	if (!dmub->hw_init || !dmub->hw_funcs.should_detect)
+		return false;
+
+	return dmub->hw_funcs.should_detect(dmub);
+}
-- 
2.25.1

