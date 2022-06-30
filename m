Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071F8C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6D11124F9;
	Thu, 30 Jun 2022 19:14:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407911120DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM2sRydLC5AcZwFzFvM62800sF2779pY50IHJdcrpPBJJNwn9TG2M5S3yWWag/SYLjajPCgPqpu7ur2zJq7QXIRq5tVczwVU3X7SpprBclBl+6HO08qw3q5rc+JFxBtx873N6DUdwssUgE7ihs+9iSXUMxLZGDTPFi5oHa26vYuRe5ZuweTBfrK8/CiT9zg4/nimzWLw5M7XKggbzGk6UPlkSKAfa4IxalnpcidwD57aZr9kWj3eFYniGmJWpyJOJrcyL4FmzYEFqsaIp65BPU6sid9yLg6BlDdhiqRnx0nJg94CdGdg6SQk69hah69Nahfu0/HqeFx5a6mUsMTokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBA9HPl/nU8jH1lGTC5T8n9TKB5DIQrPKQ9oYfXra+o=;
 b=B4/X6RF/HFK7Mo2TpiTeAcLSqyGG1QMKJOJ06GLpCdWGNMKln1nFfFp8TL6AGfL9++ZkKhWF43Gz9O4hlHfyTwL9a3FjxW3CIYIZuJt+CGXBDkqOe5C7ObhULZVV+kuVsRhxy2/gHf6e4dCOU99BnfTwo/V3aaMKiWTMwmzExIaplCPR1dFk4l8GueE8anlZmnqtzPqk4cyys9dOQIar+yaXOItTOiv175i2q4pWpuiNff5U9eeWm4pXxYL1KE7ClYetV+saWMzq19YEPIvK3efGhTMi/nqH9BQfTwL+m5h69ed2Zd43yDAjarIFMPipCk1kQmeFwPKosl81L/04gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBA9HPl/nU8jH1lGTC5T8n9TKB5DIQrPKQ9oYfXra+o=;
 b=ch1y/xiFU2p92Ff9y/mCL4GNaAknlOtmtrlgcu02VwxzQNAcLXCmqc1hL31pjZ6y2XBj20uy3J5NSB+k5uPWZll3K92490LOv9uGKHMhvaXbm5Cpoa38ATodXRKb1PrVHH30R3AX4g7oY8RuzlezjVvSBq5W7eCTAI4kTamNX2U=
Received: from BN6PR17CA0037.namprd17.prod.outlook.com (2603:10b6:405:75::26)
 by DM5PR12MB1772.namprd12.prod.outlook.com (2603:10b6:3:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:13:54 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::5c) by BN6PR17CA0037.outlook.office365.com
 (2603:10b6:405:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:54 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/40] drm/amd/display: Add function to set pixels per cycle
Date: Thu, 30 Jun 2022 15:12:46 -0400
Message-ID: <20220630191322.909650-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6648ac1d-5784-48b9-54b9-08da5accac95
X-MS-TrafficTypeDiagnostic: DM5PR12MB1772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZINlZRrINq0cAFoTHc7fuDZ+hoJszQ4JvManw3sl4cMmUXvI7Fu5+oZgyCcT35hF1bnCEMehQPw6ZatdHU9KfFxj0MMwywNL8V2qoprP8iKebEsfPVVtmyyDKj+oG+GjxfHnm5Bz2H66F6/Tw4eYUoGD9eMsKmLwg1OoyUCO5dDkPRMSBF7EUq1KW0pKIXL4gQPwYkjj5A3dyBA9RgYkMv3jkY5Czg8BvgoPHwjkT9T0tkGQXUZDFt3nwI/LFKPg10qYl5yvJ3RnIfXjXGTqJDHqQ6MWiF8SqZY/STaKEzLPUe6Xt+tKKfC0iwDNcsvcCPEyAAC9JETNuNPIE5LqTTmrOu9Up1T7jT6qiTmTkmvfUnuCKR0b7VpgcrEwC9Ai7Fain8tJ+2vU2fBet+3vdB5E4wOkpDKmxq7yUybZhq9TEqtmIqUfOw5Zxs5pBtam4oSqrm4UIASbxVRoAa4MO6LMhqaVv7DBeHqiXyRSokIaqK2CBv/I2iHh/MZ6sTSz63YKpxBuM4qAekkdlQeVRgu5HjNpaHoPEsFgWLO7xH+f0JnR4ynxJJCVzKNx0DUvgcCfSGqmVLZPQMGSqC33kAEpUZNB1lXvvW2s8V9AAg5k6SDiQ2uyFeq4kPwuoqqBo96WkjT2JN6WIzm9mGt6mg8FK0D2ceZALhNxO6gf9LpCwRK8YqsHT3fMdIX6+F0siSrwQQSkpfKsykFvu4JT5Ctx+MKI8sAj2r5rcNWZDg12jiZ5gU8fNCPbas5Rg8tWQP8In279HFdR2HW55ppwjFdV6Tg/GATDfPaZBVHj0srLIXIBVwNZsw1A2DVXeOJEIYlcOfgyhL5vO5PuyYfnG3PoEjkwCROcCKrWnon5Lwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(4326008)(8676002)(70206006)(36756003)(70586007)(36860700001)(40480700001)(8936002)(478600001)(82310400005)(6916009)(54906003)(316002)(5660300002)(83380400001)(81166007)(6666004)(2906002)(26005)(2616005)(1076003)(336012)(426003)(47076005)(16526019)(186003)(7696005)(356005)(40460700003)(41300700001)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:54.1017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6648ac1d-5784-48b9-54b9-08da5accac95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1772
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Add function to set pixels per cycle in DIG stream encoder

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  |  5 ++---
 .../display/dc/dcn32/dcn32_dio_stream_encoder.c |  4 ++--
 .../display/dc/dcn32/dcn32_dio_stream_encoder.h |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c  | 17 +++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c   |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h   |  1 +
 8 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index f8d22ba6a6e4..aa4f41745be4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -577,6 +577,7 @@ struct dcn10_stream_enc_registers {
 
 #define SE_REG_FIELD_LIST_DCN3_2(type) \
 	type DIG_FIFO_OUTPUT_PIXEL_MODE;\
+	type DP_PIXEL_PER_CYCLE_PROCESSING_MODE;\
 	type DIG_SYMCLK_FE_ON;\
 	type DIG_FIFO_READ_START_LEVEL;\
 	type DIG_FIFO_ENABLE;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 9f07c1b170c9..2286cc34e9cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2535,9 +2535,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	tg->funcs->set_early_control(tg, early_control);
 
-	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
-		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
-			timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ? 2 : 1);
+	if (dc->hwseq->funcs.set_pixels_per_cycle)
+		dc->hwseq->funcs.set_pixels_per_cycle(pipe_ctx);
 
 	/* enable audio only within mode set */
 	if (pipe_ctx->stream_res.audio != NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 4d7588f2ee79..f16c4fcdf9e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -54,9 +54,9 @@ static void enc32_dp_set_odm_combine(
 	struct stream_encoder *enc,
 	bool odm_combine)
 {
-	//struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	//TODO: REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_COMBINE, odm_combine);
+	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, odm_combine ? 1 : 0);
 }
 
 /* setup stream encoder in dvi mode */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 042bc9aca944..250d9a341cf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -96,6 +96,7 @@
 #define SE_COMMON_MASK_SH_LIST_DCN32_BASE(mask_sh)\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_ENCODING, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_COMPONENT_DEPTH, mask_sh),\
+	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, mask_sh),\
 	SE_SF(DIG0_HDMI_CONTROL, HDMI_PACKET_GEN_VERSION, mask_sh),\
 	SE_SF(DIG0_HDMI_CONTROL, HDMI_KEEPOUT_MODE, mask_sh),\
 	SE_SF(DIG0_HDMI_CONTROL, HDMI_DEEP_COLOR_ENABLE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 49dd9e0edcb1..01a95de80138 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1112,3 +1112,20 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 
 	return odm_combine_factor;
 }
+
+void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
+{
+	uint32_t pix_per_cycle = 1;
+	uint32_t odm_combine_factor = 1;
+
+	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
+		return;
+
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
+		pix_per_cycle = 2;
+
+	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
+		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
+				pix_per_cycle);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 494cb3a47435..18227d58c51d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -70,6 +70,8 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
+void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
+
 void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index fb965d31e8dd..19d8a30b3358 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -142,6 +142,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.subvp_update_force_pstate = dcn32_subvp_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
+	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index ded45f8f4b82..2b2e5b808962 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -153,6 +153,7 @@ struct hwseq_private_funcs {
 	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
 			unsigned int *k1_div,
 			unsigned int *k2_div);
+	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
 #endif
 };
 
-- 
2.25.1

