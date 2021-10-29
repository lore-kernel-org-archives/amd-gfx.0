Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB6C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E17C61165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E17C61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A706E14D;
	Fri, 29 Oct 2021 15:15:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA73B6E14D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRAYeGgaA8BYvEFw3nl7VYd4qrM/M17BcTFkc9DB7UUXJz8ycu30LylhQUJ8p3jOW0LBMwF/82MnD4jQjyY70NvsqnDeQcOn5ooGH1F+Ke/OqRaUA96z0UIPeq2b9gbUQmw+YEGZVv9k/rysS2cpgzoj8ofYHPvZuLmMS4dI/M7jM8rJkLE6R5x3L5x/QCo01RjjZ1KfroGhRjq622ZJR0F5bcAIfBSNZvnJXhACPjAM5WWqGy6drQ00ET6coVpOB3WS998Kk3nFkWPaspLXl/j+878jTbMv5uOkyVc/ngoa6ngcOB/++EFY0RAMDaCPxamDcEucl6e3LW6m0de3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9TxKFFIgrZjtX4p2EEgteFhtTyxd37eA2uqY4AV36c=;
 b=IxFyEsmr1dabHd2vLyD1GbGGj7VXaBJi6jUTuCNn429d/PLUI8Po1eP5ZKxFIsK0aa/NALe7xWMZAmPc6anQ5z+3kfOVHk2M+W+P7GYUbf+PIbTIsrUg4XmAlfVbtoWrNWYT0Zx8tGn3SbrUP1YyUVIMb2/1rWBbuoPHa7/gq+Bqowv2WkIu0kF1raHHDExY9pCD/sFu/i+Dzgisu2PY27DIruads003ufdE8XQvAK1/1Jwbfuw+5NGiSBw/VruSsckyjzIu0bnaN1EhqzsktIgOVIBCDITeub6MdfcHnj9nGU7twv4TIKFGQFNyUjDjz/3msh5xYPEOcaOMdNV6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9TxKFFIgrZjtX4p2EEgteFhtTyxd37eA2uqY4AV36c=;
 b=IsTo24Q4D1rNgEwg3QJ6WScjGPeUibphWaa+Nj4OZbVq4n1rUX7wz99Dm9/1EI+At7WtB2107SH3x/3W73RtN9qtuOkZMJIj7Ff+xDogU9v41k13d9E7eAFbg0SpUkzAC/skhHVLHAlTmxW7hnlBAlPEGjVA4fuPSIuZBAI+GNw=
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:15:20 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::c5) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:18 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, "Nicholas
 Kazlauskas" <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Added HPO HW control shutdown support
Date: Fri, 29 Oct 2021 11:14:51 -0400
Message-ID: <20211029151456.955294-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f43990-b29e-44d1-eea1-08d99aeeebc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:
X-Microsoft-Antispam-PRVS: <DM6PR12MB446661E95995E746C0D4FF6C8B879@DM6PR12MB4466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9ZgaE89W3OnbqBpOcSX2al3Xw+OTUK/eIxD5Kt0cg3ZMq+swmVIKDuXkavvH3HYlH8Dq1/E0RTN3wIlf7UtdAHQ/ySb/R4I6W2+zQez9+i08dYN8rOKndJjWT0LsN6lrVRlijuMfbVlCW6J1oHstHIcBx+nD9q3Yq4JRESfJll5lA0UnjTQ+X7GWPglRF5a7lddVJFGOSC3b4Ss3sXvje9W6IVUUqU1vkR1eOBO8jg2x+Fh9znzJFDjTPDKMAUQSkdD2AHAmsRGV+3QLDtpa4ECZav57RMSAYF+krYLoU3D7Ey6e7djgR46jA7CwLY2Q9WTOK86wQXahLNLJ5oEezlTbgvgL0VrzOYC3oFRAU5W/JpASfiqYoWbia/dQqKW31dUSivfMpxJMOdP8Rt9Gr17fvuOXP0m4Uj6lA7Ca0Qe5vGD52xH8qQZNS+jAwkbXL7GdtC/wwTi8AYmcvGusfo0HkLhXDIknEOSuY/VaJYblqQ6wMz9dJluIYQcXAqDEl0OYxmbWuSEoZ3YySWEm69YNG7BVE5orxa8/4EdiHeHVSzgoRLPOHaN6zCouxPVpPSyMSEHar4P6ssVw7yUQx6R9DTtCRXz8BdlyIjw8ETBo62RqT9oAteMnnDUnm/wlpghCpXBJweVpsPGOGevPvR/k1IjoYEsMPTXy2au1izfSO6WIZdGRHyd3ZL2+X77oXsKdBKEuGtyoS4if1ZnsBANNsI1S1nOspAJBSSam/htbYvH/B6vF+uCaeJ0BDtVCdMmz8BNb8uWfd6WUynmIwrUhhnmGXITPNbVrNMZWU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(36756003)(86362001)(508600001)(6666004)(336012)(82310400003)(83380400001)(356005)(81166007)(44832011)(4326008)(6916009)(36860700001)(54906003)(70206006)(70586007)(426003)(2616005)(47076005)(1076003)(8676002)(26005)(5660300002)(186003)(2906002)(8936002)(117716001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:19.7838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f43990-b29e-44d1-eea1-08d99aeeebc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

From: Jake Wang <haonan.wang2@amd.com>

[Why]
HPO is only used for DP2.0. HPO HW control should be
disable when not being used to save power.

[How]
Shutdown HPO HW control during init hw.
Shutdown HPO HW control during stream disable.
Enable HPO HW control during stream enable if DP2.0.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                      | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h           | 4 +++-
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c       | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h       | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c        | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c    | 6 ++++--
 .../gpu/drm/amd/display/dc/inc/hw_sequencer_private.h    | 1 +
 9 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a5339796902a..e9bac161fd25 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -675,6 +675,7 @@ struct dc_debug_options {
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
+	bool hpo_optimization;
 	bool force_vblank_alignment;
 
 	/* Enable dmub aux for legacy ddc */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index 989f5b6907e2..a3fee929cd12 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -671,6 +671,7 @@ struct dce_hwseq_registers {
 	uint32_t MC_VM_FB_LOCATION_BASE;
 	uint32_t MC_VM_FB_LOCATION_TOP;
 	uint32_t MC_VM_FB_OFFSET;
+	uint32_t HPO_TOP_HW_CONTROL;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -1152,7 +1153,8 @@ struct dce_hwseq_registers {
 	type DOMAIN_PGFSM_PWR_STATUS;\
 	type HPO_HDMISTREAMCLK_G_GATE_DIS;\
 	type DISABLE_HOSTVM_FORCE_ALLOW_PSTATE;\
-	type I2C_LIGHT_SLEEP_FORCE;
+	type I2C_LIGHT_SLEEP_FORCE;\
+	type HPO_IO_EN;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index af3e68d3e747..24e47df526f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1244,6 +1244,12 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 #endif
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE);
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (dc->hwseq->funcs.setup_hpo_hw_control && is_dp_128b_132b_signal(pipe_ctx))
+		dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, false);
+#endif
+
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cfee456c6c9a..4f88376a118f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2397,6 +2397,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	 * BY this, it is logic clean to separate stream and link
 	 */
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		if (pipe_ctx->stream->ctx->dc->hwseq->funcs.setup_hpo_hw_control)
+			pipe_ctx->stream->ctx->dc->hwseq->funcs.setup_hpo_hw_control(
+				pipe_ctx->stream->ctx->dc->hwseq, true);
 		setup_dp_hpo_stream(pipe_ctx, true);
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->enable_stream(
 				pipe_ctx->stream_res.hpo_dp_stream_enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index d24ad7754d71..1b089893460a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -264,6 +264,9 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->debug.enable_mem_low_power.bits.i2c)
 		REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 1);
 
+	if (hws->funcs.setup_hpo_hw_control)
+		hws->funcs.setup_hpo_hw_control(hws, false);
+
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
 		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
@@ -597,3 +600,9 @@ void dcn31_reset_hw_ctx_wrap(
 	/* New dc_state in the process of being applied to hardware. */
 	dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_TRANSIENT;
 }
+
+void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
+{
+	if (hws->ctx->dc->debug.hpo_optimization)
+		REG_UPDATE(HPO_TOP_HW_CONTROL, HPO_IO_EN, !!enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
index 7ae45dd202d9..edfc01d6ad73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
@@ -54,5 +54,6 @@ void dcn31_reset_hw_ctx_wrap(
 bool dcn31_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream);
 void dcn31_init_pipes(struct dc *dc, struct dc_state *context);
+void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
 
 #endif /* __DC_HWSS_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index c6a737781ad1..05335a8c3c2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -137,6 +137,7 @@ static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 };
 
 void dcn31_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6d8a5ffce1d3..a7aeb236a884 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -860,7 +860,8 @@ static const struct dccg_mask dccg_mask = {
 	SR(D6VGA_CONTROL), \
 	SR(DC_IP_REQUEST_CNTL), \
 	SR(AZALIA_AUDIO_DTO), \
-	SR(AZALIA_CONTROLLER_CLOCK_GATING)
+	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
+	SR(HPO_TOP_HW_CONTROL)
 
 static const struct dce_hwseq_registers hwseq_reg = {
 		HWSEQ_DCN31_REG_LIST()
@@ -898,7 +899,8 @@ static const struct dce_hwseq_registers hwseq_reg = {
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
 	HWS_SF(, MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, mask_sh), \
-	HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+	HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh), \
+	HWS_SF(, HPO_TOP_HW_CONTROL, HPO_IO_EN, mask_sh)
 
 static const struct dce_hwseq_shift hwseq_shift = {
 		HWSEQ_DCN31_MASK_SH_LIST(__SHIFT)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index f324285394be..c2008258c50a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -143,6 +143,7 @@ struct hwseq_private_funcs {
 			const struct dc_plane_state *plane_state);
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
+	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
 };
 
 struct dce_hwseq {
-- 
2.30.2

