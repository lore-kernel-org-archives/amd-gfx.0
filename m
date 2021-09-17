Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD9C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B478360F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B478360F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DC16EE84;
	Fri, 17 Sep 2021 19:26:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072A36EE83
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvvwQsatXsE1hu01FFhOcbmhumJafsQ01WPDSq4qLvUoH11iyUS1mG8uHCEYelUzNFDotC5x0ixJxk62tWq75J6D5MrrEVuT1byuVy1Q6awwostJp+m0dAf0/WqrPsDXOuTc2YodiwF4ISWw2cUxpSkJWittcbUL1PKvyIul4Xu4DeUU7O3lnnOxqFgoS5bjqZGN1AU4foRQwhGl2L1wrYfynpn0LPNiEBCQMHhGIZxvCG1VcPsroxF7Ncyy68dRdu5wbb6RAuPLZhGvCQpjSm/QMKNf1w9x5Bv+GGC5lzsjD2S2tqNTcs4WYVebu0qQGeEJMRVo3somtEqXPT5IQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2/RUaFK5Dd+WTZPe9G5badjJXVDEjLHKS/Feoz6Z7Oo=;
 b=AGk2E4bLFGBvnFc4+cDTzHz6/FyUPKgElKXSRBIkZ6rqIqlWBIpT21LKlDVtldiOX79fhDcvFZwRehnIUg8WO/bNYiqydH/+Op3JRTzRv3W62wzBzsU4QLcN79M+RXuYDQxJbHhGk91HHwxUd80ukVo4txOyR4k9fUNsEKplPj0a+HNa4ZEx2K7Mg6dJ2OclMHGnORnZEgx6pHfzH6+hM/s+53zWmmLbIIT5ZuWSVKARk3SfA8SCq89aHzX61kDyR8qY35VfE5Pp4BA4CXBrz+l15O5J/9lB6WByvDIb/Jh5fA1cmdNiOklfEov1UKRPeUK5xiq6IINkS2rmAbrObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/RUaFK5Dd+WTZPe9G5badjJXVDEjLHKS/Feoz6Z7Oo=;
 b=3VzNw1OVClkP6i2YCweANsqnq56i6HNAOC3ERrLxoLImKnntOomZ/a+ROaPiDVOmyI/KCWxFFs+tdo1ZWAtYiBX7SVHV+HD3fdF1p2rBuQuydS1Jl6vrj8SWw/M3y6k4ipLIHvQHnsjIPfXixZetEVI7IjXeTeJq42milNTId3A=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:56 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::3b) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:56 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Guo, Bing"
 <Bing.Guo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 10/18] drm/amd/display: Fix issue with dynamic bpp change for
 DCN3x
Date: Fri, 17 Sep 2021 15:25:16 -0400
Message-ID: <20210917192524.3020276-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c280ebd-ae7b-48b3-60c3-08d97a10f902
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-Microsoft-Antispam-PRVS: <BL1PR12MB520732BACEEB9CFE85451BF798DD9@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6lABtzMnJpDNBclEouOdtWGlXqG7bkNxbk2V+HU+hXkGVg1hkKVQIq4TvqfnlMhGZDvsaMcNeXLTI3EtivYi7fVpaeOOKcN5JaE9g80uidnwy6jmaDhcyAPG8GwAMu7SdQJ/QUdiW/Hk5Z0vslfvR5YqQ7zYog/5UzfzMV3UIKVDO4QT/JHD8K1nybTKR8gCtMx2PnRKW/MgPkRfXqdivLh+IJfirZXS/6cVqEuHLu8JWKbHv7irtwth8BZCzjxDJF+YOtjPlwiBNWrpAQT4RfVKi6NL7zcvNcqFgAbxuzsqEEVM30V88/q8q82ZTkOO8UN1wXVw5g0wBt2F2b1LIruTfH9cIKMg2e8IXlPf0Xj0iiXse1WR6wNG8TbKt+KUcatGk/xtmYyMxoD7zDsZjWfCprVX4iV/dNMUgJIuj23RwrvMSajZh9c7vRJD+eVUt/pHfqhIG2Qp8PYNlJyqNnCSerkM8rsmi+PCH3AgVzlCnVR8chKYZQn0HL5JsIAA4VGwCO8kMko1IMiJfSeCWVVnXGls+q/PHn4KfpGqRwI3VjPDNyuFDmpw9ufjv5/5KXhigHHSmDrIeyzdtKR9lHSZcCvINU7mLoP7A/QVD6ciex9D1arj3bknOvFHzI07oLTk3eBEcmmxxe/QCP9Z4Eu6JXFSzF0FhY4NDF2BZb4a5rlsdVVmipotVHPY49OsWJaCCVJhZqVF9zJW+SSPINxsuhW1k6xS9IuSHc4zv0bGZJI7iJIjtfh4QG0Xi1Pd/i8QswyYRPiXAkdg9OWNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(6666004)(316002)(54906003)(36756003)(70206006)(47076005)(26005)(478600001)(36860700001)(4326008)(82740400003)(6916009)(5660300002)(8936002)(356005)(2616005)(81166007)(86362001)(30864003)(8676002)(16526019)(1076003)(83380400001)(82310400003)(2906002)(186003)(70586007)(336012)(426003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:56.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c280ebd-ae7b-48b3-60c3-08d97a10f902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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

From: "Guo, Bing" <Bing.Guo@amd.com>

Why:
Screen sometimes would have artifacts or blink once at the time when bpp
is dynamically changed.

How:
1. Changed to update PPS infopacket in frame mode instead of immediate mode
   since other updates for bpp change are double-buffered.
2. Changed double-buffering enablement programming for DCN30 as advised by
ASIC team

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   4 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  29 ++-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   3 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  18 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  17 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  | 198 ++++++++++++------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |   6 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  15 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   6 +-
 .../dc/virtual/virtual_stream_encoder.c       |   3 +-
 11 files changed, 204 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4ec3de34bd67..2bd38d19a447 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3554,7 +3554,7 @@ static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pi
 
 	/* Set DPS PPS SDP (AKA "info frames") */
 	if (pipe_ctx->stream->timing.flags.DSC) {
-		dp_set_dsc_pps_sdp(pipe_ctx, true);
+		dp_set_dsc_pps_sdp(pipe_ctx, true, true);
 	}
 
 	/* Allocate Payload */
@@ -3803,7 +3803,7 @@ void core_link_enable_stream(
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
 					dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 				dp_set_dsc_on_rx(pipe_ctx, true);
-				dp_set_dsc_pps_sdp(pipe_ctx, true);
+				dp_set_dsc_pps_sdp(pipe_ctx, true, true);
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 64f76f57c85d..cc4b28e94727 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -607,7 +607,8 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
 										pipe_ctx->stream_res.hpo_dp_stream_enc,
 										false,
-										NULL);
+										NULL,
+										true);
 			else
 #endif
 				if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
@@ -615,7 +616,7 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 							pipe_ctx->stream_res.stream_enc,
 							OPTC_DSC_DISABLED, 0, 0);
 					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-								pipe_ctx->stream_res.stream_enc, false, NULL);
+								pipe_ctx->stream_res.stream_enc, false, NULL, true);
 				}
 		}
 
@@ -650,7 +651,16 @@ bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
 	return result;
 }
 
-bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
+/*
+ * For dynamic bpp change case, dsc is programmed with MASTER_UPDATE_LOCK enabled;
+ * hence PPS info packet update need to use frame update instead of immediate update.
+ * Added parameter immediate_update for this purpose.
+ * The decision to use frame update is hard-coded in function dp_update_dsc_config(),
+ * which is the only place where a "false" would be passed in for param immediate_update.
+ *
+ * immediate_update is only applicable when DSC is enabled.
+ */
+bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -682,13 +692,15 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
 										pipe_ctx->stream_res.hpo_dp_stream_enc,
 										true,
-										&dsc_packed_pps[0]);
+										&dsc_packed_pps[0],
+										immediate_update);
 			else
 #endif
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 										pipe_ctx->stream_res.stream_enc,
 										true,
-										&dsc_packed_pps[0]);
+										&dsc_packed_pps[0],
+										immediate_update);
 		}
 	} else {
 		/* disable DSC PPS in stream encoder */
@@ -698,11 +710,12 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
 										pipe_ctx->stream_res.hpo_dp_stream_enc,
 										false,
-										NULL);
+										NULL,
+										true);
 			else
 #endif
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-							pipe_ctx->stream_res.stream_enc, false, NULL);
+							pipe_ctx->stream_res.stream_enc, false, NULL, true);
 		}
 	}
 
@@ -720,7 +733,7 @@ bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx)
 		return false;
 
 	dp_set_dsc_on_stream(pipe_ctx, true);
-	dp_set_dsc_pps_sdp(pipe_ctx, true);
+	dp_set_dsc_pps_sdp(pipe_ctx, true, false);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 44f31b7b9ac9..11c50b508754 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -292,7 +292,8 @@ static void enc2_dp_set_dsc_config(struct stream_encoder *enc,
 
 static void enc2_dp_set_dsc_pps_info_packet(struct stream_encoder *enc,
 					bool enable,
-					uint8_t *dsc_packed_pps)
+					uint8_t *dsc_packed_pps,
+					bool immediate_update)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index b73dfd2661b9..3ea6dacec80c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -77,7 +77,8 @@ static void enc3_update_hdmi_info_packet(
 		enc1->base.vpg->funcs->update_generic_info_packet(
 				enc1->base.vpg,
 				packet_index,
-				info_packet);
+				info_packet,
+				true);
 
 		/* enable transmission of packet(s) -
 		 * packet transmission begins on the next frame */
@@ -335,7 +336,8 @@ static void enc3_dp_set_dsc_config(struct stream_encoder *enc,
 
 static void enc3_dp_set_dsc_pps_info_packet(struct stream_encoder *enc,
 					bool enable,
-					uint8_t *dsc_packed_pps)
+					uint8_t *dsc_packed_pps,
+					bool immediate_update)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -365,7 +367,8 @@ static void enc3_dp_set_dsc_pps_info_packet(struct stream_encoder *enc,
 			enc1->base.vpg->funcs->update_generic_info_packet(
 							enc1->base.vpg,
 							11 + i,
-							&pps_sdp);
+							&pps_sdp,
+							immediate_update);
 		}
 
 		/* SW should make sure VBID[6] update line number is bigger
@@ -429,19 +432,22 @@ static void enc3_stream_encoder_update_dp_info_packets(
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				0,  /* packetIndex */
-				&info_frame->vsc);
+				&info_frame->vsc,
+				true);
 	}
 	if (info_frame->spd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				2,  /* packetIndex */
-				&info_frame->spd);
+				&info_frame->spd,
+				true);
 	}
 	if (info_frame->hdrsmd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
-				&info_frame->hdrsmd);
+				&info_frame->hdrsmd,
+				true);
 	}
 	/* packetIndex 4 is used for send immediate sdp message, and please
 	 * use other packetIndex (such as 5,6) for other info packet
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 089be7347591..5d9e6413d67a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -73,16 +73,23 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc)
 		OTG_H_BLANK_END, &h_blank_end);
 
 	REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
-		MASTER_UPDATE_LOCK_DB_START_Y, v_blank_start,
-		MASTER_UPDATE_LOCK_DB_END_Y, v_blank_end);
+		MASTER_UPDATE_LOCK_DB_START_Y, v_blank_start - 1,
+		MASTER_UPDATE_LOCK_DB_END_Y, v_blank_start);
 	REG_UPDATE_2(OTG_GLOBAL_CONTROL4,
-		DIG_UPDATE_POSITION_X, 20,
-		DIG_UPDATE_POSITION_Y, v_blank_start);
+		DIG_UPDATE_POSITION_X, h_blank_start - 180 - 1,
+		DIG_UPDATE_POSITION_Y, v_blank_start - 1);
+	// there is a DIG_UPDATE_VCOUNT_MODE and it is 0.
+
 	REG_UPDATE_3(OTG_GLOBAL_CONTROL0,
 		MASTER_UPDATE_LOCK_DB_START_X, h_blank_start - 200 - 1,
-		MASTER_UPDATE_LOCK_DB_END_X, h_blank_end,
+		MASTER_UPDATE_LOCK_DB_END_X, h_blank_start - 180,
 		MASTER_UPDATE_LOCK_DB_EN, 1);
 	REG_UPDATE(OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, 1);
+
+	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, 100,
+		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);
 }
 
 void optc3_lock_doublebuffer_disable(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
index 9748aaa044f7..14bc44b1f886 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
@@ -46,7 +46,8 @@
 void vpg3_update_generic_info_packet(
 	struct vpg *vpg,
 	uint32_t packet_index,
-	const struct dc_info_packet *info_packet)
+	const struct dc_info_packet *info_packet,
+	bool immediate_update)
 {
 	struct dcn30_vpg *vpg3 = DCN30_VPG_FROM_VPG(vpg);
 	uint32_t i;
@@ -106,69 +107,138 @@ void vpg3_update_generic_info_packet(
 	/* atomically update double-buffered GENERIC0 registers in immediate mode
 	 * (update at next block_update when block_update_lock == 0).
 	 */
-	switch (packet_index) {
-	case 0:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC0_IMMEDIATE_UPDATE, 1);
-		break;
-	case 1:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC1_IMMEDIATE_UPDATE, 1);
-		break;
-	case 2:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC2_IMMEDIATE_UPDATE, 1);
-		break;
-	case 3:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC3_IMMEDIATE_UPDATE, 1);
-		break;
-	case 4:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC4_IMMEDIATE_UPDATE, 1);
-		break;
-	case 5:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC5_IMMEDIATE_UPDATE, 1);
-		break;
-	case 6:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC6_IMMEDIATE_UPDATE, 1);
-		break;
-	case 7:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC7_IMMEDIATE_UPDATE, 1);
-		break;
-	case 8:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC8_IMMEDIATE_UPDATE, 1);
-		break;
-	case 9:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC9_IMMEDIATE_UPDATE, 1);
-		break;
-	case 10:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC10_IMMEDIATE_UPDATE, 1);
-		break;
-	case 11:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC11_IMMEDIATE_UPDATE, 1);
-		break;
-	case 12:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC12_IMMEDIATE_UPDATE, 1);
-		break;
-	case 13:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC13_IMMEDIATE_UPDATE, 1);
-		break;
-	case 14:
-		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
-				VPG_GENERIC14_IMMEDIATE_UPDATE, 1);
-		break;
-	default:
-		break;
+	if (immediate_update) {
+		switch (packet_index) {
+		case 0:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC0_IMMEDIATE_UPDATE, 1);
+			break;
+		case 1:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC1_IMMEDIATE_UPDATE, 1);
+			break;
+		case 2:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC2_IMMEDIATE_UPDATE, 1);
+			break;
+		case 3:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC3_IMMEDIATE_UPDATE, 1);
+			break;
+		case 4:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC4_IMMEDIATE_UPDATE, 1);
+			break;
+		case 5:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC5_IMMEDIATE_UPDATE, 1);
+			break;
+		case 6:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC6_IMMEDIATE_UPDATE, 1);
+			break;
+		case 7:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC7_IMMEDIATE_UPDATE, 1);
+			break;
+		case 8:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC8_IMMEDIATE_UPDATE, 1);
+			break;
+		case 9:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC9_IMMEDIATE_UPDATE, 1);
+			break;
+		case 10:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC10_IMMEDIATE_UPDATE, 1);
+			break;
+		case 11:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC11_IMMEDIATE_UPDATE, 1);
+			break;
+		case 12:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC12_IMMEDIATE_UPDATE, 1);
+			break;
+		case 13:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC13_IMMEDIATE_UPDATE, 1);
+			break;
+		case 14:
+			REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+					VPG_GENERIC14_IMMEDIATE_UPDATE, 1);
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (packet_index) {
+		case 0:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC0_FRAME_UPDATE, 1);
+			break;
+		case 1:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC1_FRAME_UPDATE, 1);
+			break;
+		case 2:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC2_FRAME_UPDATE, 1);
+			break;
+		case 3:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC3_FRAME_UPDATE, 1);
+			break;
+		case 4:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC4_FRAME_UPDATE, 1);
+			break;
+		case 5:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC5_FRAME_UPDATE, 1);
+			break;
+		case 6:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC6_FRAME_UPDATE, 1);
+			break;
+		case 7:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC7_FRAME_UPDATE, 1);
+			break;
+		case 8:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC8_FRAME_UPDATE, 1);
+			break;
+		case 9:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC9_FRAME_UPDATE, 1);
+			break;
+		case 10:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC10_FRAME_UPDATE, 1);
+			break;
+		case 11:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC11_FRAME_UPDATE, 1);
+			break;
+		case 12:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC12_FRAME_UPDATE, 1);
+			break;
+		case 13:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC13_FRAME_UPDATE, 1);
+			break;
+		case 14:
+			REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+					VPG_GENERIC14_FRAME_UPDATE, 1);
+			break;
+
+		default:
+			break;
+		}
+
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
index 96dccb2f1124..ed9a5549c389 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
@@ -138,7 +138,8 @@ struct vpg_funcs {
 	void (*update_generic_info_packet)(
 		struct vpg *vpg,
 		uint32_t packet_index,
-		const struct dc_info_packet *info_packet);
+		const struct dc_info_packet *info_packet,
+		bool immediate_update);
 
 	void (*vpg_poweron)(
 		struct vpg *vpg);
@@ -163,7 +164,8 @@ struct dcn30_vpg {
 void vpg3_update_generic_info_packet(
 	struct vpg *vpg,
 	uint32_t packet_index,
-	const struct dc_info_packet *info_packet);
+	const struct dc_info_packet *info_packet,
+	bool immediate_update);
 
 void vpg3_construct(struct dcn30_vpg *vpg3,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 25e4794eb9ad..565f12dd179a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -442,21 +442,24 @@ static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				0,  /* packetIndex */
-				&info_frame->vsc);
+				&info_frame->vsc,
+				true);
 		sdp_stream_enable = true;
 	}
 	if (info_frame->spd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				2,  /* packetIndex */
-				&info_frame->spd);
+				&info_frame->spd,
+				true);
 		sdp_stream_enable = true;
 	}
 	if (info_frame->hdrsmd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
-				&info_frame->hdrsmd);
+				&info_frame->hdrsmd,
+				true);
 		sdp_stream_enable = true;
 	}
 	/* enable/disable transmission of packet(s).
@@ -520,7 +523,8 @@ static uint32_t hpo_dp_is_gsp_enabled(
 static void dcn31_hpo_dp_stream_enc_set_dsc_pps_info_packet(
 		struct hpo_dp_stream_encoder *enc,
 		bool enable,
-		uint8_t *dsc_packed_pps)
+		uint8_t *dsc_packed_pps,
+		bool immediate_update)
 {
 	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
 
@@ -544,7 +548,8 @@ static void dcn31_hpo_dp_stream_enc_set_dsc_pps_info_packet(
 			enc3->base.vpg->funcs->update_generic_info_packet(
 							enc3->base.vpg,
 							11 + i,
-							&pps_sdp);
+							&pps_sdp,
+							immediate_update);
 		}
 
 		/* SW should make sure VBID[6] update line number is bigger
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 3cc110e13213..cb8e785a866e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -166,7 +166,7 @@ uint8_t dc_dp_initialize_scrambling_data_symbols(
 enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
-bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable);
+bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
 bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 9f03fda5b965..c88e113b94d1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -229,7 +229,8 @@ struct stream_encoder_funcs {
 
 	void (*dp_set_dsc_pps_info_packet)(struct stream_encoder *enc,
 				bool enable,
-				uint8_t *dsc_packed_pps);
+				uint8_t *dsc_packed_pps,
+				bool immediate_update);
 
 	void (*set_dynamic_metadata)(struct stream_encoder *enc,
 			bool enable,
@@ -298,7 +299,8 @@ struct hpo_dp_stream_encoder_funcs {
 	void (*dp_set_dsc_pps_info_packet)(
 			struct hpo_dp_stream_encoder *enc,
 			bool enable,
-			uint8_t *dsc_packed_pps);
+			uint8_t *dsc_packed_pps,
+			bool immediate_update);
 
 	void (*map_stream_to_link)(
 			struct hpo_dp_stream_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 42a29b712e0e..1e39aae6b1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -104,7 +104,8 @@ static void virtual_setup_stereo_sync(
 static void virtual_stream_encoder_set_dsc_pps_info_packet(
 		struct stream_encoder *enc,
 		bool enable,
-		uint8_t *dsc_packed_pps)
+		uint8_t *dsc_packed_pps,
+		bool immediate_update)
 {}
 
 static const struct stream_encoder_funcs virtual_str_enc_funcs = {
-- 
2.25.1

