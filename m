Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7948C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7923961350
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7923961350
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1605A6EB3D;
	Tue,  5 Oct 2021 07:53:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD686EB3D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml+2hWia1D403/Hr6NLqj1ORJmw0eqrCOvKd7wGkABeryoHH72UIgfjhBo27pnvSzD31keAEkUwLXlDVoNw6WXCOHA2dvLwNVXDFJ5F8QDiQhpBZeI5Ey3R5G1gdwokoXAwLUkBFwfxYYGfKgFXTblzl7JjetJmCThArl6RR3y6JasKvXytSpq6sfPNist9xBSCKlqlze/KWWRHXRr547LA/DXY5pIfyrp3JxAvqmFJsEC2bLK77KdXlhbgO47D30Rn7fKPkBdrqw1jOZl9o3sJi905Ihq7WXztVL+M9j3VVBFL0xR94qIldm2QZNitC5Qeb9u4MtErhj8uMX4y4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJjbE1ANO2low7TAAKrjFOFf9xJJn2SFLn0KOk/ga14=;
 b=k437uDnGaQzUnnI5l0f94x6ffgDmtlBFlT4XYsuHKCw5ZqY5rId4A6Wu+luzkwH3en38tFgy2MwaQRU2K31a3wFV1g/zHYjJDikJbnrjKmdK2Pe7wmhRCyPRd6Lq1oBPfGIid3Ysw9hgdzEorJTp7j8WWTUdGKX1SEv870zt5fvyWeAbJ1dYc+KERCvlzr8YP6XbzLciCLQLy8G3Tg7wUHQtYuUUN7Xe+IUBSLgJL+xksbKdFD8J4hpgMJSl0mbYGMp0IOaevJr/D3Kwsl4fn3UGXrRbEWBB0hKb4oCP+vvM4dowGHz7JwfP1mlxnj4jDefSlRyqnKZr9dA52Cd+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJjbE1ANO2low7TAAKrjFOFf9xJJn2SFLn0KOk/ga14=;
 b=lQi+Dt7Azqhde0Q4gHppv9lg5TXx5YMGGk4ut+kJPFUocY4tzN6j8cu+aebaPmLuFisfIoQbBnRdRGIZYr1lu6UaJRTQQTOAXaxb4IgbFILxkeg/PL8e7uvKPFuNDim2e3AQVwthLAgRABPLudCQmASUAtT4CVKOodVtbaaB80k=
Received: from DS7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:8:54::19) by
 CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Tue, 5 Oct 2021 07:53:37 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::70) by DS7PR06CA0038.outlook.office365.com
 (2603:10b6:8:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 07:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:53:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:53:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:53:34 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:53:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 05/23] drm/amd/display: Support USB4 for display endpoint
 control path.
Date: Tue, 5 Oct 2021 15:51:47 +0800
Message-ID: <20211005075205.3467938-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cdc5548-5f10-48c3-0300-08d987d53cd2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-Microsoft-Antispam-PRVS: <CY4PR12MB160774600C5883C8B50D705AFCAF9@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NvtCVeFWGrrN7Noex1bKWD30ivhoNRbUq6H3DblaVhUdpg0hlAj5wvDc0D+kkxFfPhkFX2R1/2voBOhqUO9vG5+2DPSpeEG8VFJhjVwVwF5ZqjgyqIRfxnFerMef/BrMEyURGiEprWufRO30g7XP1Zqyjjs+/WMCyt6s70L9m5h5eUAJptUrqdSdlvDZcLlP2/yVzFAMz2Ons99CXB0JfZ2M1quA9DT+MCW2vurOGinewL4i0j8N+gtU+yDpLGDlLsiXu09zl/jOzssVUtbuG+JaqR3/+vNdnRC2LJKOGmiRx4bgNrcXG/oMn/YCN/0a51aWHMar4WJX8mqvF1GUgk8/VImu8EjKrzriP5gZjNZIIFqMIDL3Li1B0CNIjJE9AON4W47Fn95TP1AJi0fD/hv+3zjQBGagPqoQDpQ+BM9gNKZ7edHZt6FKER6tRVkdrQgOokeNaBaR6vRF23RxAmjbOKU7MQalokFeHkTKaN9vj/9ux5BlVL1ZCXXqsUxdF7KmW+36G9dyQOMwuBg+nY6cLAhi56E2Owggd1e+hlym+Pjhl1Kynj4ABfGv30XHF5vtOqWAm1HvlWrCg7BecMSS8MhyedRGknb1BfBZNcS083cBKPPthuvJNcgwgILWz4+4+ue/lDpbOAzcurBI07AGkFk/qc+cioxkBRz+ZxNajS4ACoLGllfyIYkaKuLvZwKp3DetBrkPKI1/GseGs28V0MgL3cBJtkN3o/A/W0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(86362001)(1076003)(356005)(4326008)(47076005)(186003)(26005)(81166007)(336012)(7696005)(508600001)(6916009)(2616005)(6666004)(70206006)(36860700001)(70586007)(5660300002)(8676002)(36756003)(82310400003)(83380400001)(426003)(2906002)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:53:36.7006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdc5548-5f10-48c3-0300-08d987d53cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "79ed7354d70f drm/amd/display: Update
display endpoint control path" to support USB4 DP tunneling
feature.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  30 ++++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 118 +++++++++++++++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  41 ++++++
 3 files changed, 182 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 649a9da338a7..4df71d728319 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2312,6 +2312,23 @@ enum link_training_result dc_link_dp_perform_link_training(
 	return status;
 }
 
+/*
+ * Train DP tunneling link for USB4 DPIA display endpoint.
+ *
+ * DPIA equivalent of dc_link_dp_perfrorm_link_training.
+ */
+enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *link,
+	const struct dc_link_settings *link_setting,
+	bool skip_video_pattern)
+{
+	enum link_training_result status;
+
+	/** @todo Always fail until USB4 DPIA training implemented. */
+	status = LINK_TRAINING_CR_FAIL_LANE0;
+
+	return status;
+}
+
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
@@ -2383,10 +2400,15 @@ bool perform_link_training_with_retries(
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
 			return true;
 		} else {
-				status = dc_link_dp_perform_link_training(
-										link,
-										&current_setting,
-										skip_video_pattern);
+			if (link->is_dig_mapping_flexible)
+				status = dc_link_dpia_perform_link_training(link,
+									    link_setting,
+									    skip_video_pattern);
+			else
+				status = dc_link_dp_perform_link_training(link,
+									  &current_setting,
+									  skip_video_pattern);
+
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 616a48d72afa..f86d4446f347 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -366,11 +366,44 @@ void dcn31_link_encoder_construct_minimal(
 		SIGNAL_TYPE_EDP;
 }
 
+/* DPIA equivalent of link_transmitter_control. */
+static bool link_dpia_control(struct dc_context *dc_ctx,
+	struct dmub_cmd_dig_dpia_control_data *dpia_control)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_dmub_srv *dmub = dc_ctx->dmub_srv;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.dig1_dpia_control.header.type = DMUB_CMD__DPIA;
+	cmd.dig1_dpia_control.header.sub_type =
+			DMUB_CMD__DPIA_DIG1_DPIA_CONTROL;
+	cmd.dig1_dpia_control.header.payload_bytes =
+		sizeof(cmd.dig1_dpia_control) -
+		sizeof(cmd.dig1_dpia_control.header);
+
+	cmd.dig1_dpia_control.dpia_control = *dpia_control;
+
+	dc_dmub_srv_cmd_queue(dmub, &cmd);
+	dc_dmub_srv_cmd_execute(dmub);
+	dc_dmub_srv_wait_idle(dmub);
+
+	return false;
+}
+
+static void link_encoder_disable(struct dcn10_link_encoder *enc10)
+{
+	/* reset training complete */
+	REG_UPDATE(DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, 0);
+}
+
 void dcn31_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
 {
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
@@ -378,7 +411,30 @@ void dcn31_link_encoder_enable_dp_output(
 
 	} else {
 
-		/** @todo Handle transmitter with programmable mapping to link encoder. */
+		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
+		struct dc_link *link;
+
+		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
+
+		enc1_configure_encoder(enc10, link_settings);
+
+		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_ENABLE;
+		dpia_control.enc_id = enc->preferred_engine;
+		dpia_control.mode_laneset.digmode = 0; /* 0 for SST; 5 for MST */
+		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
+		dpia_control.symclk_10khz = link_settings->link_rate *
+				LINK_RATE_REF_FREQ_IN_KHZ / 10;
+		dpia_control.hpdsel = 5; /* Unused by DPIA */
+
+		if (link) {
+			dpia_control.dpia_id = link->ddc_hw_inst;
+		} else {
+			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+
+		link_dpia_control(enc->ctx, &dpia_control);
 	}
 }
 
@@ -387,6 +443,8 @@ void dcn31_link_encoder_enable_dp_mst_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
 {
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
@@ -394,7 +452,30 @@ void dcn31_link_encoder_enable_dp_mst_output(
 
 	} else {
 
-		/** @todo Handle transmitter with programmable mapping to link encoder. */
+		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
+		struct dc_link *link;
+
+		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
+
+		enc1_configure_encoder(enc10, link_settings);
+
+		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_ENABLE;
+		dpia_control.enc_id = enc->preferred_engine;
+		dpia_control.mode_laneset.digmode = 5; /* 0 for SST; 5 for MST */
+		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
+		dpia_control.symclk_10khz = link_settings->link_rate *
+				LINK_RATE_REF_FREQ_IN_KHZ / 10;
+		dpia_control.hpdsel = 5; /* Unused by DPIA */
+
+		if (link) {
+			dpia_control.dpia_id = link->ddc_hw_inst;
+		} else {
+			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+
+		link_dpia_control(enc->ctx, &dpia_control);
 	}
 }
 
@@ -402,6 +483,8 @@ void dcn31_link_encoder_disable_output(
 	struct link_encoder *enc,
 	enum signal_type signal)
 {
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
 	/* Disable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
@@ -409,7 +492,36 @@ void dcn31_link_encoder_disable_output(
 
 	} else {
 
-		/** @todo Handle transmitter with programmable mapping to link encoder. */
+		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
+		struct dc_link *link;
+
+		if (!dcn10_is_dig_enabled(enc))
+			return;
+
+		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
+
+		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_DISABLE;
+		dpia_control.enc_id = enc->preferred_engine;
+		if (signal == SIGNAL_TYPE_DISPLAY_PORT) {
+			dpia_control.mode_laneset.digmode = 0; /* 0 for SST; 5 for MST */
+		} else if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			dpia_control.mode_laneset.digmode = 5; /* 0 for SST; 5 for MST */
+		} else {
+			DC_LOG_ERROR("%s: USB4 DPIA only supports DisplayPort.\n", __func__);
+			BREAK_TO_DEBUGGER();
+		}
+
+		if (link) {
+			dpia_control.dpia_id = link->ddc_hw_inst;
+		} else {
+			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+
+		link_dpia_control(enc->ctx, &dpia_control);
+
+		link_encoder_disable(enc10);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a693b743f0d4..8461442b03a9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -654,6 +654,10 @@ enum dmub_cmd_type {
 	 * Command type used for all panel control commands.
 	 */
 	DMUB_CMD__PANEL_CNTL = 74,
+	/**
+	 * Command type used for interfacing with DPIA.
+	 */
+	DMUB_CMD__DPIA = 77,
 	/**
 	 * Command type used for EDID CEA parsing
 	 */
@@ -682,6 +686,11 @@ enum dmub_out_cmd_type {
 	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
+/* DMUB_CMD__DPIA command sub-types. */
+enum dmub_cmd_dpia_type {
+	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
+};
+
 #pragma pack(push, 1)
 
 /**
@@ -1001,6 +1010,34 @@ struct dmub_rb_cmd_dig1_transmitter_control {
 	union dmub_cmd_dig1_transmitter_control_data transmitter_control; /**< payload */
 };
 
+/**
+ * DPIA tunnel command parameters.
+ */
+struct dmub_cmd_dig_dpia_control_data {
+	uint8_t enc_id;         /** 0 = ENGINE_ID_DIGA, ... */
+	uint8_t action;         /** ATOM_TRANSMITER_ACTION_DISABLE/ENABLE/SETUP_VSEMPH */
+	union {
+		uint8_t digmode;    /** enum atom_encode_mode_def */
+		uint8_t dplaneset;  /** DP voltage swing and pre-emphasis value */
+	} mode_laneset;
+	uint8_t lanenum;        /** Lane number 1, 2, 4, 8 */
+	uint32_t symclk_10khz;  /** Symbol Clock in 10Khz */
+	uint8_t hpdsel;         /** =0: HPD is not assigned */
+	uint8_t digfe_sel;      /** DIG stream( front-end ) selection, bit0 - DIG0 FE */
+	uint8_t dpia_id;        /** Index of DPIA */
+	uint8_t fec_rdy : 1;
+	uint8_t reserved : 7;
+	uint32_t reserved1;
+};
+
+/**
+ * DMUB command for DPIA tunnel control.
+ */
+struct dmub_rb_cmd_dig1_dpia_control {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_dig_dpia_control_data dpia_control;
+};
+
 /**
  * struct dmub_rb_cmd_dpphy_init - DPPHY init.
  */
@@ -2442,6 +2479,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
 	 */
 	struct dmub_rb_cmd_lvtma_control lvtma_control;
+	/**
+	 * Definition of a DMUB_CMD__DPIA_DIG1_CONTROL command.
+	 */
+	struct dmub_rb_cmd_dig1_dpia_control dig1_dpia_control;
 	/**
 	 * Definition of a DMUB_CMD__EDID_CEA command.
 	 */
-- 
2.25.1

