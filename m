Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA6BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD29010F392;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC7E10E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkVohsMWfBCPWhCRU+2jSZsyb7gcX/xcXma/GRA3CA2dKvoatlyjql29Pqtovx3DK03RgXwugQvuDoNpkCMKFEY9B8zDRegS09iXW5GgxJP66NOEv0QpSFYFFujDliv4K/kgUCpn8QnXyH7RYpl1AzAjQTjP1AeyaGhdWBmCgIROiNCi+iNh2O5lv/lrk40NS0xCFAPF1MCcz/TEzomCHlGfUMktJmho1aCFipKvjgGyoDr3ql0YVlZZ9ZtAS0MS9D/Ok6SuwRWoQUNapF/qau+5n4/r0DYO+dsWNRZXatKOAPhEdchWvBnqY7XWCTngqdl4rF4mbdT5i36DxbVsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc/sakVzoccVnuza8Bm0Y+a/ZHMIeayfYKOfy9ObxjA=;
 b=Y4n5Fi0Sakf/At3H68DXq8TaFP3XT8DfoKF55PW8VabIhhENPQtV2khaHtg+VdlGionIDi7Sa6rT5XmfVsYKMM15sZmvelIx6asFX8+gTTZg9WAj8e1fNGru/qaR8218VE4iEUKrnSu2/URO5HAIKTj92GeQYIYPqqH5DNGgkkhTlJukLP7HXlzJgfD/ctyYwZtqe5psBNNU8cQlulh2Z9cK1ySx6LcOJtk8jS2xT+1b+QMRmPY2PDCxjRrHs01hMR8iVfJzOGdc6/2cDRV+EIHn3OPP8yJk7VRIeoput337s9SNsfb7udf09RHTk7C+ljjANbiFnoz+Q9u2CEI+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc/sakVzoccVnuza8Bm0Y+a/ZHMIeayfYKOfy9ObxjA=;
 b=eSdpJBQu5u5yyzPQbQKhFdVjGijbWfF5mYjvqR+MRLUASVDc8jbxLxs7msQx4PKm/N9WkTHN/tY4DuA+ixCGXAXXiS+nRVeup0LdynAWJR9S9Gke7AYVkQnsciBpBXpqmExRWXQaKSihMsmFjsLFZyqUNTaaiY7/39wh56vd99M=
Received: from DM5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:3:d4::26) by
 CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 16:20:20 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::26) by DM5PR05CA0016.outlook.office365.com
 (2603:10b6:3:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/43] drm/amd/display: add new pixel rate programming
Date: Wed, 25 May 2022 12:19:31 -0400
Message-ID: <20220525161941.2544055-33-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e4f004f-044f-459b-2614-08da3e6a76c6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1765FFF4AF5416F1B8612C14F7D69@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsN3p3OgacKPmSkRVfGFklWG6lM1J+arlof3q8c4PvwAab18C1QfaJ8mUOAita+fmSX19/HriHFVUmcl0nFr89Zbrr+cWbTz01/iysNNjbsc80m2DR+HQawKyHkii05jxuEbPqXTBjuc+umQutBXrn/1ZG4lXODSUlqvs67x72TdUwVMt5wWTXcv9cDzQZZWK87e2sY1AsrwQu0kX2HdT9wtYCV2domVJnukqxBLsoo76W64K/TJBOLnCrXxEeEAWwV6Eojo3HhA84HL6fVp+9SCySbv5QIuzi/6xuZ6Nh9S0UUjcZ0fjz9JKF6DC1pTc81/H6Un80HRec/QVo3NizAuKopr/HttdmO5z5W4i9T1G55pRyUV3iWQWhtj02g2nxc4VvA/sn7WWR74lW7SILmQfquFYK3a0QIA7wVBv7rofSX6b8gmg6qbQwCjiFXJFPumCsh+nshlYkKqzTQn4WAKILeFsRlpd6Fa/zD7A0GTkd6M7Itbbvl6ARZuBiBZjIVOhwUCIBFH3WuMLv8u1b8KEtEMB5WFk21PE45S0cjtGX9UUn8WXgGUW7AluwYnrKCGb3NPI/oNCnNjI8fSZUg+mZZoeEctSvAMqQ8pPa0OQ3NkoBDwXNMrf/OFZXQo1WqjRk9n0qi2V0flsBsB4o3sknompX0T97kFpy+2RVMHjbyKPNAoAPIZN/ZAiOZF7a5kWix7K860LzhMpqZ29w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(26005)(508600001)(7696005)(70206006)(86362001)(316002)(4326008)(8676002)(70586007)(54906003)(36860700001)(6916009)(40460700003)(356005)(1076003)(83380400001)(426003)(336012)(2616005)(81166007)(186003)(47076005)(16526019)(36756003)(2906002)(5660300002)(82310400005)(8936002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:20.5405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4f004f-044f-459b-2614-08da3e6a76c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[why]
New dividers in DCCG need to be programmed depending
on encoder/stream type since pixels per clock in
OTG/DIO is different

DIO also needs additional programming depending on
pixels per clock

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 14 ++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  1 +
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  3 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 72 +++++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |  3 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  3 +
 10 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index f659aaab792e..034849e37860 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -571,6 +571,7 @@ struct dcn10_stream_enc_registers {
 	type DP_SEC_GSP11_LINE_NUM
 
 #define SE_REG_FIELD_LIST_DCN3_2(type) \
+	type DIG_FIFO_OUTPUT_PIXEL_MODE;\
 	type DIG_SYMCLK_FE_ON;\
 	type DIG_FIFO_READ_START_LEVEL;\
 	type DIG_FIFO_ENABLE;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d00a27893ab0..aed8ab06b41d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -661,7 +661,17 @@ enum dc_status dcn20_enable_stream_timing(
 	struct mpc_dwb_flow_control flow_control;
 	struct mpc *mpc = dc->res_pool->mpc;
 	bool rate_control_2x_pclk = (interlace || optc2_is_two_pixels_per_containter(&stream->timing));
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
 
+	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		dc->res_pool->dccg->funcs->set_pixel_rate_div(
+			dc->res_pool->dccg,
+			pipe_ctx->stream_res.tg->inst,
+			k1_div, k2_div);
+	}
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
 	 * with pipe 0. No program is needed.
@@ -2485,6 +2495,10 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	tg->funcs->set_early_control(tg, early_control);
 
+	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
+		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
+			timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ? 2 : 1);
+
 	/* enable audio only within mode set */
 	if (pipe_ctx->stream_res.audio != NULL) {
 		if (is_dp_128b_132b_signal(pipe_ctx))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index a3e0b95fdc84..c7d07203d21a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -274,6 +274,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
 	.otg_add_pixel = dccg32_otg_add_pixel,
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
+	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
 };
 
 struct dccg *dccg32_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 77da0a13525b..042bc9aca944 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -240,7 +240,8 @@
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET, mask_sh),\
-	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh)
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh)
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 #define SE_COMMON_MASK_SH_LIST_DCN32(mask_sh)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 8eed05aad54c..5994edc3dd0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -47,6 +47,7 @@
 #include "clk_mgr.h"
 #include "dsc.h"
 #include "dcn20/dcn20_optc.h"
+#include "dc_link_dp.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -836,20 +837,44 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	}
 }
 
+/*
+* Given any pipe_ctx, return the total ODM combine factor, and optionally return
+* the OPPids which are used
+* */
+static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_instances)
+{
+	unsigned int opp_count = 1;
+	struct pipe_ctx *odm_pipe;
+
+	/* First get to the top pipe */
+	for (odm_pipe = pipe_ctx; odm_pipe->prev_odm_pipe; odm_pipe = odm_pipe->prev_odm_pipe)
+		;
+
+	/* First pipe is always used */
+	if (opp_instances)
+		opp_instances[0] = odm_pipe->stream_res.opp->inst;
+
+	/* Find and count odm pipes, if any */
+	for (odm_pipe = odm_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		if (opp_instances)
+			opp_instances[opp_count] = odm_pipe->stream_res.opp->inst;
+		opp_count++;
+	}
+
+	return opp_count;
+}
+
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *odm_pipe;
-	int opp_cnt = 1;
-	int opp_inst[MAX_PIPES] = { pipe_ctx->stream_res.opp->inst };
+	int opp_cnt = 0;
+	int opp_inst[MAX_PIPES] = {0};
 	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
 	struct mpc_dwb_flow_control flow_control;
 	struct mpc *mpc = dc->res_pool->mpc;
 	int i;
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
-		opp_cnt++;
-	}
+	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
 	if (opp_cnt > 1)
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
@@ -892,3 +917,38 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
 }
 
+unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	unsigned int odm_combine_factor = 0;
+
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
+
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		*k2_div = PIXEL_RATE_DIV_BY_1;
+	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
+		*k1_div = PIXEL_RATE_DIV_BY_1;
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		else
+			*k2_div = PIXEL_RATE_DIV_BY_4;
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			*k1_div = PIXEL_RATE_DIV_BY_1;
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		} else if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			*k1_div = PIXEL_RATE_DIV_BY_2;
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		} else {
+			if (odm_combine_factor == 1)
+				*k2_div = PIXEL_RATE_DIV_BY_4;
+			else if (odm_combine_factor == 2)
+				*k2_div = PIXEL_RATE_DIV_BY_2;
+		}
+	}
+
+	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
+		ASSERT(false);
+
+	return odm_combine_factor;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 737a7fac5cf9..2a5bdcf58bc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -61,4 +61,6 @@ void dcn32_subvp_update_force_pstate(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
 
+unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index d1e3db1bc488..7f492734f881 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -141,6 +141,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.subvp_update_force_pstate = dcn32_subvp_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
+	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 2fbd65d88b61..a06c8daed5ed 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -59,7 +59,8 @@ enum dentist_dispclk_change_mode {
 enum pixel_rate_div {
    PIXEL_RATE_DIV_BY_1 = 0,
    PIXEL_RATE_DIV_BY_2 = 1,
-   PIXEL_RATE_DIV_BY_4 = 3
+   PIXEL_RATE_DIV_BY_4 = 3,
+   PIXEL_RATE_DIV_NA = 0xF
 };
 
 struct dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 36ec56524afd..e5fe0f6adc86 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -247,6 +247,9 @@ struct stream_encoder_funcs {
 
 	uint32_t (*get_fifo_cal_average_level)(
 		struct stream_encoder *enc);
+
+	void (*set_input_mode)(
+		struct stream_encoder *enc, unsigned int pix_per_container);
 };
 
 struct hpo_dp_stream_encoder_state {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 5a0648784872..60d89e863d1e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -147,6 +147,9 @@ struct hwseq_private_funcs {
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*subvp_update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
+	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
+			unsigned int *k1_div,
+			unsigned int *k2_div);
 #endif
 };
 
-- 
2.35.3

