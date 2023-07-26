Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0AC001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AD010E4AB;
	Wed, 26 Jul 2023 19:32:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273E310E4A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWtezihjgzWseqwE4SiDoJwkDe0EFRYw22NLUWmRSGyunCUGCbg9zY5ayRVEcdgX3QVozoa8zSEDnBr1kygEhqz8Wq4Y9CSoG77YxN23haKtRGUZlazmTdnXXRCXPi3V70AumWKDQPK7V94v3+JGsXPFB78mncLEuUuVVxXKv1gsXqwQf4NJ9lQt5vD6VkcwgpftaAgYSnb/EbCKEjOsOVDpb8SA8+iecSAG/7OApdubueJwGD7qumjXlZlIYLXBFYczCh5NCaXFBzWieichiylbLLUA4/7ToY2gnP2sbKXZMfJIgggBEqFd/RVidmYXKXtTK8gB6MFy1W66LUE47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsLQ9QyjZqfiwj093Z5ViWSS676GQkX+UTP9pRN3jNw=;
 b=Rv+iil3XU9ixhifZnVcsTAgCEEBvfFMKcVD9w32pleShU27/kCq2u9Klwm/T3G4sgsbSP4pWWxUlB0Mcp85YyAK0JP2OBc15YYjzXc/A2hJ8AO3UBPK6X3aRzywwDu9Z8J3xUyYeUYwb3bMi1trejOrtwL3l3EzfKli0flveCm2WL/UEUVYjNOX4NBHSsSpmv/wQbkbEqFbr9RK/ImLXdX8qx8P/46UWYARW9u8SnpU/NY1g6toGwpZSBNIcnWd8UYd8oDVlUYkr4+3eRgcvOGlTXM7DmWQxxIPzHCgzD85UsMD1vnFsUAazjT7b0MuYV2zoAHP3L/4cR3Dc3IfH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsLQ9QyjZqfiwj093Z5ViWSS676GQkX+UTP9pRN3jNw=;
 b=1fWhYnfSJJHLmglGnd21kf89TU7MwNc4XjRXlpiqn125UJ153OXj1MQ62p0QHIj29G5INzQgmN2fZFpqArQ3tt8CCaO3MSpwxtDbrMcKf8r5DsNjIfcqVLSVoeIbxA4hi90FdVhWCGc37DPninGd5Jb3n0HXOB2m0HrL96jsUqM=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 19:31:58 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::4d) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:31:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:57 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:31:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/display: Add symclk enable/disable during stream
 enable/disable
Date: Wed, 26 Jul 2023 15:27:40 -0400
Message-ID: <20230726193155.2525270-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c670e8-5c51-42ab-3348-08db8e0efa2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MvApPMgkd2En5T5/aRxvCG3Ek99nq6dSmaGgqhbSb5DSCV5W6+7CglBiUjzMf70sMc28u8e3+AFpVi1eOM/y2TzhmuXO8AgI4UHWZyvtvQv9rVhHZ/rKH8gTsb3ybJRov0f6kfZlq9rTZzpMDnDmzib+7mhJR7finRu9Welqim72rYVl7Jdf9QyZycpYUcmEhxUiKORpcoWeVfu0a3jzWu9DqHWBP6Kl6FTIrYhNcSOjfF5tkkjhfVhpnIRBU7xbAx+IfHfiUrLDATZt6R8UGvi0eb+yiIJwjO677N+TqQliEFrhYu21xvkjLnHO0JZyb7GLqMnB0pJFAR8SxrLRm76PPkufqhvRNGdoEIrmlsaIUlNBXMWk4CN4igt7UTNR3NVMrigTkm3tJWwSWLhKpTKrWV7AcWt+RmMf44NYdoggvRXqIcbB8Iyywr+M9mwNdT/A64fTGpdvhTT2G5OmUD9VgWEubs3ID5CO512ZONjx1XUHvrlieE+3hUFU7AT6fpt7ZD5kvo6fpwx+rcuG8LZOch4TyDtlGwzkt7VVnpKuXV5HoB2e+cd8h1tR/dY5i4UQaHiRyV7czu+iJ0Z4d73Gaf4bnTG0FRc1g6CvrrbHw6e6VZ0yT4DBq3v+iVz4TTlGk5RqIc5EOvlsvcKEza0GZ08Gv9P3kORwqQv8pBXZ/oONiiyzM47tAtvrF6bCLddbJ+ALloF9XghGZku6Mv8vnHyxqDrkWLWeXmpsEh1XdJbr1i32kJ8tqBNREy0gIpjImIOtEBwwgUNOTmHnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(41300700001)(82740400003)(81166007)(356005)(478600001)(6666004)(7696005)(54906003)(5660300002)(2616005)(70586007)(6916009)(4326008)(8936002)(8676002)(70206006)(316002)(36860700001)(336012)(426003)(186003)(83380400001)(47076005)(26005)(1076003)(86362001)(2906002)(44832011)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:31:58.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c670e8-5c51-42ab-3348-08db8e0efa2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
Using dig_stream_mapper, program symclk_en and symclk_fe_src_sel when
enabling or disabling the corresponding stream.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c       | 6 +++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h             | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h   | 1 +
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c | 3 +++
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 20d4d08a6a2f..1eb4f884e5bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1150,6 +1150,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->stop_hdmi_info_packets(
@@ -1176,7 +1177,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-	}
+	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->disable_symclk_se)
+		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst);
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		/* TODO: This looks like a bug to me as we are disabling HPO IO when
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e32d3246e82a..e0a73d99b784 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2719,6 +2719,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = dc->hwseq;
 	unsigned int k1_div = PIXEL_RATE_DIV_NA;
 	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		if (dc->hwseq->funcs.setup_hpo_hw_control)
@@ -2738,7 +2740,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-	}
+	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->enable_symclk_se)
+		dccg->funcs->enable_symclk_se(dccg,
+			stream_enc->stream_enc_inst, link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 93592281de32..c378cb287a3a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -172,6 +172,15 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			unsigned int dpp_inst,
 			bool clock_on);
+
+	void (*enable_symclk_se)(
+			struct dccg *dccg,
+			uint32_t stream_enc_inst,
+			uint32_t link_enc_inst);
+
+	void (*disable_symclk_se)(
+			struct dccg *dccg,
+			uint32_t stream_enc_inst);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index c4fbbf08ef86..a6dedf3c7d74 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -269,6 +269,7 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc, unsigned int pix_per_container);
 	void (*enable_fifo)(struct stream_encoder *enc);
 	void (*disable_fifo)(struct stream_encoder *enc);
+	void (*map_stream_to_link)(struct stream_encoder *enc, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 };
 
 struct hpo_dp_stream_encoder_state {
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index bebf9c4c8702..d19a0a958fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -46,6 +46,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(pipe_ctx->stream->link,
 				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+	if (stream_enc->funcs->map_stream_to_link)
+		stream_enc->funcs->map_stream_to_link(stream_enc,
+				stream_enc->stream_enc_inst, link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	if (stream_enc->funcs->enable_fifo)
 		stream_enc->funcs->enable_fifo(stream_enc);
 }
-- 
2.41.0

