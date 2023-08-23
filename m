Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD8FEE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800F310E44A;
	Wed, 23 Aug 2023 15:51:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3D810E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+i3KC5x9SEEGOvUpNFNjsUICJQOPW6dbvKOwcVlW5ltvuuyfLov2eIAjhdDXFEONKjWcrQ4b5ebQv84wUH3R1sR+7YV3GUBqr2mcjBImxGQrXF/SxoBslpvXlee9w17RiN7sjZR2U0WUAPza0K3PbxrJRkYy3fkRhpZkgEOQPHvLSWKrg3U8gvyEBUGUA6fl8D3si1RHvj4nT8gk9UwBMHFOAisQopnyBroxrzt5n4WB4nW4sSp2uoZ6L6gaP+xn7c3dO02NeGXUy5pn6YsKaK8Xe7QabbgPhcHQw5VdEW4U7ShMP1pDZ83+Wi5TMGiWtKjlnzd/IWkEP9WmULsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3nc3+Aj7/lfv4KyAehTzbDcGs2DFm6iV5xX1xAFzp0=;
 b=O0yIBNBcKSa6q6SkQIW0wgpH2oo7KrC5N/avmkwdvXTTaatqCzwob0x455YIdQRAGN/yFzeUTuVZ+1GwXB0woWM6kLuJQxjNkHyODaMV397ysCVkxCs7p0qWg2eW0WHW/dUdl95Q7wjKT2RUV2Jt6YfGyjUGYw+4Eys6P1eqtzwyWvypPzjxRUFENA0fcS/7DhKr5ZfGu9ZT/OPEWackUdTwyqyrCiBlPCKVk4NMcS6zCr49xblHAF0qwLU09+Amq4LI9yUfmDVUEy3sadHkKyV0Mw4kdRFO4bFGAk/uCXQe1cQ6p1CJREdlgwBFT/PEKcX8V7r9LnahQbhJpfip+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3nc3+Aj7/lfv4KyAehTzbDcGs2DFm6iV5xX1xAFzp0=;
 b=IjRyewQ1X+E/IYrQwZC2MFpBtWixwhnoQz0DgcDBe9+0sj/xYI0YMFMtThMENXSATyE5Jyx2bhRSL9cqVNFHESKKUZCnf8io40h+ZMvea+vUxiHOAcOjvkGXI5xvz7hxaxE/ewzWurJWIl4rKOcnZFXCUHUfOSVJdc0j8pjWaJs=
Received: from CY5PR18CA0034.namprd18.prod.outlook.com (2603:10b6:930:13::7)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:15 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::ee) by CY5PR18CA0034.outlook.office365.com
 (2603:10b6:930:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/35] drm/amd/display: Add DCN35 DIO
Date: Wed, 23 Aug 2023 11:50:28 -0400
Message-ID: <20230823155048.2526343-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 02219215-3a0c-47cf-a56d-08dba3f0c896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq0QoQAp+zFRl8+F30eNzZrNVTmPuWpmBXmEnKnE+k9v9hD7oMEWLhy62MpLZTrNPfmvzhooru1dbkEiqUKDgw0RXBSDVMohjLFtRADhopQuenQYDKBEU8tTi8yyE+1s0DJp7GpDTDDRwPbZgbjNHsw6uuccgbOdvcjzyW42DpIDEL3fO3jo9SlduQxsbdmf55LMGHZOhAOmb8W36MSGWbs3B6u98QXV107pLz9ml6VtCnp8OPyg9USg5hDEQn/lvncYgz2tc1UsA+egHPzkh4Eg3f8t1X2U4M4AmdJyZk7sO6f+FfucN1HKcW/XSCO3h12ZPz4HEEtC3rtd8Xxd98Z8c9lPmxEpFAA0dev33gknWnjI3Gu+T2fHyiont4BBBXadc/peZT4TPIFFops5FnsW/Le2q5i+qp1W7wz/wZa1MXCHkM+twaMRHIWTDPKEe773TEZdmSaC8uHcBpiwurc2MiZnhShHKU+avGbFHPz73Zaxwy4sCS3y1zsupVs4pa0X6rdQh8E2VutlMi+1cKqoniD5WJ8NCXLuzuUoTw24cV3HhR+v+c8tnNnwz46jQNfO9C5ly3zgX8cssMRY6LIh3UhWO89HuzYZVvOgvnY50mdW9jH4uo7/vqNYdd3Vp3yWB9KNGdF4SnquD9SgW9Tj4A7h4MLjtZ/p+JPOOxMPV0yuOwAW8xLCwFcEF9BYV9BZnNDxiSIyQ0+AyC2sj2vQ3/+38QSkiXdaUAR5hkBGo86omlagYITisCPAr8HiwvlaEYU9c6g94Os/Rz0DKTBhzNbTLvSktHHwPCqq2dMSbK2VxOijUIq4SKbLiHR1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:15.4757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02219215-3a0c-47cf-a56d-08dba3f0c896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DIO handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/dcn35/dcn35_dio_link_encoder.c | 267 +++++++++
 .../display/dc/dcn35/dcn35_dio_link_encoder.h | 137 +++++
 .../dc/dcn35/dcn35_dio_stream_encoder.c       | 528 ++++++++++++++++++
 .../dc/dcn35/dcn35_dio_stream_encoder.h       | 326 +++++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    |   5 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  23 +
 6 files changed, 1286 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
new file mode 100644
index 000000000000..f91e08895275
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "reg_helper.h"
+
+#include "core_types.h"
+#include "link_encoder.h"
+#include "dcn31/dcn31_dio_link_encoder.h"
+#include "dcn35_dio_link_encoder.h"
+#define CTX \
+	enc10->base.ctx
+#define DC_LOGGER \
+	enc10->base.ctx->logger
+
+#define REG(reg)\
+	(enc10->link_regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc10->link_shift->field_name, enc10->link_mask->field_name
+/*
+ * @brief
+ * Trigger Source Select
+ * ASIC-dependent, actual values for register programming
+ */
+#define DCN35_DIG_FE_SOURCE_SELECT_INVALID 0x0
+#define DCN35_DIG_FE_SOURCE_SELECT_DIGA 0x1
+#define DCN35_DIG_FE_SOURCE_SELECT_DIGB 0x2
+#define DCN35_DIG_FE_SOURCE_SELECT_DIGC 0x4
+#define DCN35_DIG_FE_SOURCE_SELECT_DIGD 0x08
+#define DCN35_DIG_FE_SOURCE_SELECT_DIGE 0x10
+
+
+bool dcn35_is_dig_enabled(struct link_encoder *enc)
+{
+	uint32_t enabled;
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	REG_GET(DIG_BE_CLK_CNTL, DIG_BE_CLK_EN, &enabled);
+	return (enabled == 1);
+}
+
+enum signal_type dcn35_get_dig_mode(
+	struct link_encoder *enc)
+{
+	uint32_t value;
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	REG_GET(DIG_BE_CLK_CNTL, DIG_BE_MODE, &value);
+	switch (value) {
+	case 0:
+		return SIGNAL_TYPE_DISPLAY_PORT;
+	case 2:
+		return SIGNAL_TYPE_DVI_SINGLE_LINK;
+	case 3:
+		return SIGNAL_TYPE_HDMI_TYPE_A;
+	case 5:
+		return SIGNAL_TYPE_DISPLAY_PORT_MST;
+	default:
+		return SIGNAL_TYPE_NONE;
+	}
+	return SIGNAL_TYPE_NONE;
+}
+
+void dcn35_link_encoder_setup(
+	struct link_encoder *enc,
+	enum signal_type signal)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	switch (signal) {
+	case SIGNAL_TYPE_EDP:
+	case SIGNAL_TYPE_DISPLAY_PORT:
+		/* DP SST */
+		REG_UPDATE(DIG_BE_CLK_CNTL, DIG_BE_MODE, 0);
+		break;
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+		/* TMDS-DVI */
+		REG_UPDATE(DIG_BE_CLK_CNTL, DIG_BE_MODE, 2);
+		break;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		/* TMDS-HDMI */
+		REG_UPDATE(DIG_BE_CLK_CNTL, DIG_BE_MODE, 3);
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		/* DP MST */
+		REG_UPDATE(DIG_BE_CLK_CNTL, DIG_BE_MODE, 5);
+		break;
+	default:
+		ASSERT_CRITICAL(false);
+		/* invalid mode ! */
+		break;
+	}
+	REG_UPDATE(DIG_BE_CLK_CNTL, DIG_BE_CLK_EN, 1);
+
+}
+
+void dcn35_link_encoder_init(struct link_encoder *enc)
+{
+	enc32_hw_init(enc);
+	dcn35_link_encoder_set_fgcg(enc, enc->ctx->dc->debug.enable_fine_grain_clock_gating.bits.dio);
+}
+
+void dcn35_link_encoder_set_fgcg(struct link_encoder *enc, bool enable)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	REG_UPDATE(DIO_CLK_CNTL, DIO_FGCG_REP_DIS, !enable);
+}
+
+static const struct link_encoder_funcs dcn35_link_enc_funcs = {
+	.read_state = link_enc2_read_state,
+	.validate_output_with_stream =
+			dcn30_link_encoder_validate_output_with_stream,
+	.hw_init = dcn35_link_encoder_init,
+	.setup = dcn35_link_encoder_setup,
+	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
+	.enable_dp_output = dcn31_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dcn31_link_encoder_enable_dp_mst_output,
+	.disable_output = dcn31_link_encoder_disable_output,
+	.dp_set_lane_settings = dcn10_link_encoder_dp_set_lane_settings,
+	.dp_set_phy_pattern = dcn10_link_encoder_dp_set_phy_pattern,
+	.update_mst_stream_allocation_table =
+		dcn10_link_encoder_update_mst_stream_allocation_table,
+	.psr_program_dp_dphy_fast_training =
+			dcn10_psr_program_dp_dphy_fast_training,
+	.psr_program_secondary_packet = dcn10_psr_program_secondary_packet,
+	.connect_dig_be_to_fe = dcn10_link_encoder_connect_dig_be_to_fe,
+	.enable_hpd = dcn10_link_encoder_enable_hpd,
+	.disable_hpd = dcn10_link_encoder_disable_hpd,
+	.is_dig_enabled = dcn35_is_dig_enabled,
+	.destroy = dcn10_link_encoder_destroy,
+	.fec_set_enable = enc2_fec_set_enable,
+	.fec_set_ready = enc2_fec_set_ready,
+	.fec_is_active = enc2_fec_is_active,
+	.get_dig_frontend = dcn10_get_dig_frontend,
+	.get_dig_mode = dcn35_get_dig_mode,
+	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
+	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
+	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+};
+
+void dcn35_link_encoder_construct(
+	struct dcn20_link_encoder *enc20,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_aux_registers *aux_regs,
+	const struct dcn10_link_enc_hpd_registers *hpd_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask)
+{
+	struct bp_connector_speed_cap_info bp_cap_info = {0};
+	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
+	enum bp_result result = BP_RESULT_OK;
+	struct dcn10_link_encoder *enc10 = &enc20->enc10;
+
+	enc10->base.funcs = &dcn35_link_enc_funcs;
+	enc10->base.ctx = init_data->ctx;
+	enc10->base.id = init_data->encoder;
+
+	enc10->base.hpd_source = init_data->hpd_source;
+	enc10->base.connector = init_data->connector;
+
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
+	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
+
+	enc10->base.features = *enc_features;
+
+	enc10->base.transmitter = init_data->transmitter;
+
+	/* set the flag to indicate whether driver poll the I2C data pin
+	 * while doing the DP sink detect
+	 */
+
+/*	if (dal_adapter_service_is_feature_supported(as,
+ *		FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
+ *		enc10->base.features.flags.bits.
+ *			DP_SINK_DETECT_POLL_DATA_PIN = true;
+ */
+
+	enc10->base.output_signals =
+		SIGNAL_TYPE_DVI_SINGLE_LINK |
+		SIGNAL_TYPE_DVI_DUAL_LINK |
+		SIGNAL_TYPE_LVDS |
+		SIGNAL_TYPE_DISPLAY_PORT |
+		SIGNAL_TYPE_DISPLAY_PORT_MST |
+		SIGNAL_TYPE_EDP |
+		SIGNAL_TYPE_HDMI_TYPE_A;
+
+	enc10->link_regs = link_regs;
+	enc10->aux_regs = aux_regs;
+	enc10->hpd_regs = hpd_regs;
+	enc10->link_shift = link_shift;
+	enc10->link_mask = link_mask;
+
+	switch (enc10->base.transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		enc10->base.preferred_engine = ENGINE_ID_DIGA;
+	break;
+	case TRANSMITTER_UNIPHY_B:
+		enc10->base.preferred_engine = ENGINE_ID_DIGB;
+	break;
+	case TRANSMITTER_UNIPHY_C:
+		enc10->base.preferred_engine = ENGINE_ID_DIGC;
+	break;
+	case TRANSMITTER_UNIPHY_D:
+		enc10->base.preferred_engine = ENGINE_ID_DIGD;
+	break;
+	case TRANSMITTER_UNIPHY_E:
+		enc10->base.preferred_engine = ENGINE_ID_DIGE;
+	break;
+	default:
+		ASSERT_CRITICAL(false);
+		enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	}
+
+	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
+
+	if (bp_funcs->get_connector_speed_cap_info)
+		result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,
+						enc10->base.connector, &bp_cap_info);
+
+	/* Override features with DCE-specific values */
+	if (result == BP_RESULT_OK) {
+		enc10->base.features.flags.bits.IS_HBR2_CAPABLE =
+				bp_cap_info.DP_HBR2_EN;
+		enc10->base.features.flags.bits.IS_HBR3_CAPABLE =
+				bp_cap_info.DP_HBR3_EN;
+		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+		enc10->base.features.flags.bits.IS_DP2_CAPABLE = 1;
+		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
+		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
+		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+
+	} else {
+		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
+				__func__,
+				result);
+	}
+	if (enc10->base.ctx->dc->debug.hdmi20_disable)
+		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
new file mode 100644
index 000000000000..e1e560732a9d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __DC_LINK_ENCODER__DCN35_H__
+#define __DC_LINK_ENCODER__DCN35_H__
+
+#include "dcn32/dcn32_dio_link_encoder.h"
+#include "dcn30/dcn30_dio_link_encoder.h"
+#include "dcn31/dcn31_dio_link_encoder.h"
+
+#define LINK_ENCODER_MASK_SH_LIST_DCN35(mask_sh) \
+	LE_SF(DIG0_DIG_BE_EN_CNTL, DIG_BE_ENABLE, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_RB_SWITCH_EN, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_HPD_SELECT, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_MODE, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_CLK_EN, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SOFT_RESET, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_TMDS_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
+	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_BYPASS, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE0, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE1, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE2, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE3, mask_sh),\
+	LE_SF(DP0_DP_DPHY_PRBS_CNTL, DPHY_PRBS_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_PRBS_CNTL, DPHY_PRBS_SEL, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM1, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM2, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM3, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM4, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM5, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM6, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM2, DPHY_SYM7, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM2, DPHY_SYM8, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_BS_COUNT, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_ADVANCE, mask_sh),\
+	LE_SF(DP0_DP_DPHY_FAST_TRAINING, DPHY_RX_FAST_TRAINING_CAPABLE, mask_sh),\
+	LE_SF(DP0_DP_DPHY_BS_SR_SWAP_CNTL, DPHY_LOAD_BS_COUNT, mask_sh),\
+	LE_SF(DP0_DP_DPHY_TRAINING_PATTERN_SEL, DPHY_TRAINING_PATTERN_SEL, mask_sh),\
+	LE_SF(DP0_DP_DPHY_HBR2_PATTERN_CONTROL, DP_DPHY_HBR2_PATTERN_CONTROL, mask_sh),\
+	LE_SF(DP0_DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_IDLE_BS_INTERVAL, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_VBID_DISABLE, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_VID_ENHANCED_FRAME_MODE, mask_sh),\
+	LE_SF(DP0_DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, mask_sh),\
+	LE_SF(DP0_DP_CONFIG, DP_UDI_LANES, mask_sh),\
+	LE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP0_LINE_NUM, mask_sh),\
+	LE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP0_PRIORITY, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SRC0, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SRC1, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SLOT_COUNT0, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SLOT_COUNT1, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SRC2, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SRC3, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SLOT_COUNT2, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SLOT_COUNT3, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT_UPDATE, DP_MSE_SAT_UPDATE, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT_UPDATE, DP_MSE_16_MTP_KEEPOUT, mask_sh),\
+	LE_SF(DP_AUX0_AUX_CONTROL, AUX_HPD_SEL, mask_sh),\
+	LE_SF(DP_AUX0_AUX_CONTROL, AUX_LS_READ_EN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_RECEIVE_WINDOW, mask_sh),\
+	LE_SF(HPD0_DC_HPD_CONTROL, DC_HPD_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_READY_SHADOW, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_ACTIVE_STATUS, mask_sh),\
+	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_START_WINDOW, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_HALF_SYM_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_TRANSITION_FILTER_EN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_PHASE_DETECT, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_START, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_STOP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_PHASE_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_DETECTION_THRESHOLD, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_SYMBOLS, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_MODE_DET_CHECK_DELAY, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_PRECHARGE_SKIP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN_MUL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, ENC_TYPE_SEL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, HPO_DP_ENC_SEL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, HPO_HDMI_ENC_SEL, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, REFCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, REFCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SOCCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_FE_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_FE_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DIO_FGCG_REP_DIS, mask_sh)
+
+
+void dcn35_link_encoder_construct(
+	struct dcn20_link_encoder *enc20,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_aux_registers *aux_regs,
+	const struct dcn10_link_enc_hpd_registers *hpd_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask);
+
+void dcn35_link_encoder_init(struct link_encoder *enc);
+void dcn35_link_encoder_set_fgcg(struct link_encoder *enc, bool enabled);
+bool dcn35_is_dig_enabled(struct link_encoder *enc);
+
+enum signal_type dcn35_get_dig_mode(struct link_encoder *enc);
+void dcn35_link_encoder_setup(struct link_encoder *enc, enum signal_type signal);
+
+#endif /* __DC_LINK_ENCODER__DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
new file mode 100644
index 000000000000..001f9eb66920
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -0,0 +1,528 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+
+#include "dc_bios_types.h"
+#include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn314/dcn314_dio_stream_encoder.h"
+#include "dcn32/dcn32_dio_stream_encoder.h"
+#include "dcn35_dio_stream_encoder.h"
+#include "reg_helper.h"
+#include "hw_shared.h"
+#include "link.h"
+#include "dpcd_defs.h"
+
+#define DC_LOGGER \
+		enc1->base.ctx->logger
+
+#define REG(reg)\
+	(enc1->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc1->se_shift->field_name, enc1->se_mask->field_name
+
+#define VBI_LINE_0 0
+#define HDMI_CLOCK_CHANNEL_RATE_MORE_340M 340000
+
+#define CTX \
+	enc1->base.ctx
+/* setup stream encoder in dvi mode */
+static void enc35_stream_encoder_dvi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	bool is_dual_link)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	if (!enc->ctx->dc->debug.avoid_vbios_exec_table) {
+		struct bp_encoder_control cntl = {0};
+
+		cntl.action = ENCODER_CONTROL_SETUP;
+		cntl.engine_id = enc1->base.id;
+		cntl.signal = is_dual_link ?
+			SIGNAL_TYPE_DVI_DUAL_LINK : SIGNAL_TYPE_DVI_SINGLE_LINK;
+		cntl.enable_dp_audio = false;
+		cntl.pixel_clock = crtc_timing->pix_clk_100hz / 10;
+		cntl.lanes_number = (is_dual_link) ? LANE_COUNT_EIGHT : LANE_COUNT_FOUR;
+
+		if (enc1->base.bp->funcs->encoder_control(
+				enc1->base.bp, &cntl) != BP_RESULT_OK)
+			return;
+
+	} else {
+
+		//Set pattern for clock channel, default vlue 0x63 does not work
+		REG_UPDATE(DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, 0x1F);
+
+		//DIG_BE_TMDS_DVI_MODE : TMDS-DVI mode is already set in link_encoder_setup
+
+		//DIG_SOURCE_SELECT is already set in dig_connect_to_otg
+
+		/* DIG_START is removed from the register spec */
+	}
+
+	ASSERT(crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB);
+	ASSERT(crtc_timing->display_color_depth == COLOR_DEPTH_888);
+	enc1_stream_encoder_set_stream_attribute_helper(enc1, crtc_timing);
+}
+/* setup stream encoder in hdmi mode */
+static void enc35_stream_encoder_hdmi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	int actual_pix_clk_khz,
+	bool enable_audio)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	if (!enc->ctx->dc->debug.avoid_vbios_exec_table) {
+		struct bp_encoder_control cntl = {0};
+
+		cntl.action = ENCODER_CONTROL_SETUP;
+		cntl.engine_id = enc1->base.id;
+		cntl.signal = SIGNAL_TYPE_HDMI_TYPE_A;
+		cntl.enable_dp_audio = enable_audio;
+		cntl.pixel_clock = actual_pix_clk_khz;
+		cntl.lanes_number = LANE_COUNT_FOUR;
+
+		if (enc1->base.bp->funcs->encoder_control(
+				enc1->base.bp, &cntl) != BP_RESULT_OK)
+			return;
+
+	} else {
+
+		//Set pattern for clock channel, default vlue 0x63 does not work
+		REG_UPDATE(DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, 0x1F);
+
+		//DIG_BE_TMDS_HDMI_MODE : TMDS-HDMI mode is already set in link_encoder_setup
+
+		//DIG_SOURCE_SELECT is already set in dig_connect_to_otg
+
+		/* DIG_START is removed from the register spec */
+		enc314_enable_fifo(enc);
+	}
+
+	/* Configure pixel encoding */
+	enc1_stream_encoder_set_stream_attribute_helper(enc1, crtc_timing);
+
+	/* setup HDMI engine */
+	REG_UPDATE_6(HDMI_CONTROL,
+		HDMI_PACKET_GEN_VERSION, 1,
+		HDMI_KEEPOUT_MODE, 1,
+		HDMI_DEEP_COLOR_ENABLE, 0,
+		HDMI_DATA_SCRAMBLE_EN, 0,
+		HDMI_NO_EXTRA_NULL_PACKET_FILLED, 1,
+		HDMI_CLOCK_CHANNEL_RATE, 0);
+
+	/* Configure color depth */
+	switch (crtc_timing->display_color_depth) {
+	case COLOR_DEPTH_888:
+		REG_UPDATE(HDMI_CONTROL, HDMI_DEEP_COLOR_DEPTH, 0);
+		break;
+	case COLOR_DEPTH_101010:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_CONTROL,
+					HDMI_DEEP_COLOR_DEPTH, 1,
+					HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_CONTROL,
+					HDMI_DEEP_COLOR_DEPTH, 1,
+					HDMI_DEEP_COLOR_ENABLE, 1);
+			}
+		break;
+	case COLOR_DEPTH_121212:
+		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			REG_UPDATE_2(HDMI_CONTROL,
+					HDMI_DEEP_COLOR_DEPTH, 2,
+					HDMI_DEEP_COLOR_ENABLE, 0);
+		} else {
+			REG_UPDATE_2(HDMI_CONTROL,
+					HDMI_DEEP_COLOR_DEPTH, 2,
+					HDMI_DEEP_COLOR_ENABLE, 1);
+			}
+		break;
+	case COLOR_DEPTH_161616:
+		REG_UPDATE_2(HDMI_CONTROL,
+				HDMI_DEEP_COLOR_DEPTH, 3,
+				HDMI_DEEP_COLOR_ENABLE, 1);
+		break;
+	default:
+		break;
+	}
+
+	if (actual_pix_clk_khz >= HDMI_CLOCK_CHANNEL_RATE_MORE_340M) {
+		/* enable HDMI data scrambler
+		 * HDMI_CLOCK_CHANNEL_RATE_MORE_340M
+		 * Clock channel frequency is 1/4 of character rate.
+		 */
+		REG_UPDATE_2(HDMI_CONTROL,
+			HDMI_DATA_SCRAMBLE_EN, 1,
+			HDMI_CLOCK_CHANNEL_RATE, 1);
+	} else if (crtc_timing->flags.LTE_340MCSC_SCRAMBLE) {
+
+		/* TODO: New feature for DCE11, still need to implement */
+
+		/* enable HDMI data scrambler
+		 * HDMI_CLOCK_CHANNEL_FREQ_EQUAL_TO_CHAR_RATE
+		 * Clock channel frequency is the same
+		 * as character rate
+		 */
+		REG_UPDATE_2(HDMI_CONTROL,
+			HDMI_DATA_SCRAMBLE_EN, 1,
+			HDMI_CLOCK_CHANNEL_RATE, 0);
+	}
+
+
+	/* Enable transmission of General Control packet on every frame */
+	REG_UPDATE_3(HDMI_VBI_PACKET_CONTROL,
+		HDMI_GC_CONT, 1,
+		HDMI_GC_SEND, 1,
+		HDMI_NULL_SEND, 1);
+
+	/* Disable Audio Content Protection packet transmission */
+	REG_UPDATE(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, 0);
+
+	/* following belongs to audio */
+	/* Enable Audio InfoFrame packet transmission. */
+	REG_UPDATE(HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
+
+	/* update double-buffered AUDIO_INFO registers immediately */
+	ASSERT(enc->afmt);
+	enc->afmt->funcs->audio_info_immediate_update(enc->afmt);
+
+	/* Select line number on which to send Audio InfoFrame packets */
+	REG_UPDATE(HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE,
+				VBI_LINE_0 + 2);
+
+	/* set HDMI GC AVMUTE */
+	REG_UPDATE(HDMI_GC, HDMI_GC_AVMUTE, 0);
+	switch (crtc_timing->pixel_encoding) {
+	case PIXEL_ENCODING_YCBCR422:
+		REG_UPDATE(HDMI_CONTROL, TMDS_PIXEL_ENCODING, 1);
+	break;
+	default:
+		REG_UPDATE(HDMI_CONTROL, TMDS_PIXEL_ENCODING, 0);
+	break;
+	}
+	REG_UPDATE(HDMI_CONTROL, TMDS_COLOR_FORMAT, 0);
+}
+
+
+
+static void enc35_stream_encoder_enable(
+	struct stream_encoder *enc,
+	enum signal_type signal,
+	bool enable)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	if (enable) {
+		switch (signal) {
+		case SIGNAL_TYPE_DVI_SINGLE_LINK:
+		case SIGNAL_TYPE_DVI_DUAL_LINK:
+			/* TMDS-DVI */
+			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 2);
+			break;
+		case SIGNAL_TYPE_HDMI_TYPE_A:
+			/* TMDS-HDMI */
+			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 3);
+			break;
+		case SIGNAL_TYPE_DISPLAY_PORT_MST:
+			/* DP MST */
+			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 5);
+			break;
+		case SIGNAL_TYPE_EDP:
+		case SIGNAL_TYPE_DISPLAY_PORT:
+			/* DP SST */
+			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 0);
+			break;
+		default:
+			/* invalid mode ! */
+			ASSERT_CRITICAL(false);
+		}
+
+		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 1);
+		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 1);
+	} else {
+		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 0);
+		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
+	}
+}
+
+static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
+{
+	bool two_pix = timing->pixel_encoding == PIXEL_ENCODING_YCBCR420;
+
+	two_pix = two_pix || (timing->flags.DSC && timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+			&& !timing->dsc_cfg.ycbcr422_simple);
+	return two_pix;
+}
+
+static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
+{
+	/* math borrowed from function of same name in inc/resource
+	 * checks if h_timing is divisible by 2
+	 */
+
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (timing) {
+		h_blank_start = timing->h_total - timing->h_front_porch;
+		h_blank_end = h_blank_start - timing->h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (timing->h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(timing->h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
+
+static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
+{
+	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
+	return is_h_timing_divisible_by_2(timing) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy;
+}
+
+static void enc35_stream_encoder_dp_unblank(
+		struct dc_link *link,
+		struct stream_encoder *enc,
+		const struct encoder_unblank_param *param)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	struct dc *dc = enc->ctx->dc;
+
+	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
+		uint32_t n_vid = 0x8000;
+		uint32_t m_vid;
+		uint32_t n_multiply = 0;
+		uint32_t pix_per_cycle = 0;
+		uint64_t m_vid_l = n_vid;
+
+		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
+		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
+			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
+			/*this logic should be the same in get_pixel_clock_parameters() */
+			n_multiply = 1;
+			pix_per_cycle = 1;
+		}
+		/* M / N = Fstream / Flink
+		 * m_vid / n_vid = pixel rate / link rate
+		 */
+
+		m_vid_l *= param->timing.pix_clk_100hz / 10;
+		m_vid_l = div_u64(m_vid_l,
+			param->link_settings.link_rate
+				* LINK_RATE_REF_FREQ_IN_KHZ);
+
+		m_vid = (uint32_t) m_vid_l;
+
+		/* enable auto measurement */
+
+		REG_UPDATE(DP_VID_TIMING, DP_VID_M_N_GEN_EN, 0);
+
+		/* auto measurement need 1 full 0x8000 symbol cycle to kick in,
+		 * therefore program initial value for Mvid and Nvid
+		 */
+
+		REG_UPDATE(DP_VID_N, DP_VID_N, n_vid);
+
+		REG_UPDATE(DP_VID_M, DP_VID_M, m_vid);
+
+		REG_UPDATE_2(DP_VID_TIMING,
+				DP_VID_M_N_GEN_EN, 1,
+				DP_VID_N_MUL, n_multiply);
+
+		REG_UPDATE(DP_PIXEL_FORMAT,
+				DP_PIXEL_PER_CYCLE_PROCESSING_MODE,
+				pix_per_cycle);
+	}
+
+	/* make sure stream is disabled before resetting steer fifo */
+	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, false);
+	REG_WAIT(DP_VID_STREAM_CNTL, DP_VID_STREAM_STATUS, 0, 10, 5000);
+
+	/* DIG_START is removed from the register spec */
+
+	/* switch DP encoder to CRTC data, but reset it the fifo first. It may happen
+	 * that it overflows during mode transition, and sometimes doesn't recover.
+	 */
+	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 1);
+	udelay(10);
+
+	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 0);
+
+	/* wait 100us for DIG/DP logic to prime
+	 * (i.e. a few video lines)
+	 */
+	udelay(100);
+
+	/* the hardware would start sending video at the start of the next DP
+	 * frame (i.e. rising edge of the vblank).
+	 * NOTE: We used to program DP_VID_STREAM_DIS_DEFER = 2 here, but this
+	 * register has no effect on enable transition! HW always makes sure
+	 * VID_STREAM enable at start of next frame, and this is not
+	 * programmable
+	 */
+
+	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, true);
+
+	/*
+	 * DIG Resync FIFO now needs to be explicitly enabled.
+	 * This should come after DP_VID_STREAM_ENABLE per HW docs.
+	 */
+	enc314_enable_fifo(enc);
+
+	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM);
+}
+
+static void enc35_stream_encoder_map_to_link(
+		struct stream_encoder *enc,
+		uint32_t stream_enc_inst,
+		uint32_t link_enc_inst)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	ASSERT(stream_enc_inst < 5 && link_enc_inst < 5);
+	REG_UPDATE(STREAM_MAPPER_CONTROL,
+				DIG_STREAM_LINK_TARGET, link_enc_inst);
+}
+
+static void enc35_reset_fifo(struct stream_encoder *enc, bool reset)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t reset_val = reset ? 1 : 0;
+	uint32_t is_symclk_on;
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, reset_val);
+	REG_GET(DIG_FE_CLK_CNTL, DIG_FE_SYMCLK_FE_G_CLOCK_ON, &is_symclk_on);
+
+	if (is_symclk_on)
+		REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, reset_val, 10, 5000);
+	else
+		udelay(10);
+}
+
+static void enc35_disable_fifo(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
+}
+
+static void enc35_enable_fifo(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+
+	enc35_reset_fifo(enc, true);
+	enc35_reset_fifo(enc, false);
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
+}
+
+static const struct stream_encoder_funcs dcn35_str_enc_funcs = {
+	.dp_set_odm_combine =
+		enc314_dp_set_odm_combine,
+	.dp_set_stream_attribute =
+		enc2_stream_encoder_dp_set_stream_attribute,
+	.hdmi_set_stream_attribute =
+		enc35_stream_encoder_hdmi_set_stream_attribute,
+	.dvi_set_stream_attribute =
+		enc35_stream_encoder_dvi_set_stream_attribute,
+	.set_throttled_vcp_size =
+		enc1_stream_encoder_set_throttled_vcp_size,
+	.update_hdmi_info_packets =
+		enc3_stream_encoder_update_hdmi_info_packets,
+	.stop_hdmi_info_packets =
+		enc3_stream_encoder_stop_hdmi_info_packets,
+	.update_dp_info_packets_sdp_line_num =
+		enc3_stream_encoder_update_dp_info_packets_sdp_line_num,
+	.update_dp_info_packets =
+		enc3_stream_encoder_update_dp_info_packets,
+	.stop_dp_info_packets =
+		enc1_stream_encoder_stop_dp_info_packets,
+	.dp_blank =
+		enc314_stream_encoder_dp_blank,
+	.dp_unblank =
+		enc35_stream_encoder_dp_unblank,
+	.audio_mute_control = enc3_audio_mute_control,
+
+	.dp_audio_setup = enc3_se_dp_audio_setup,
+	.dp_audio_enable = enc3_se_dp_audio_enable,
+	.dp_audio_disable = enc1_se_dp_audio_disable,
+
+	.hdmi_audio_setup = enc3_se_hdmi_audio_setup,
+	.hdmi_audio_disable = enc1_se_hdmi_audio_disable,
+	.setup_stereo_sync  = enc1_setup_stereo_sync,
+	.set_avmute = enc1_stream_encoder_set_avmute,
+	.dig_connect_to_otg = enc1_dig_connect_to_otg,
+	.dig_source_otg = enc1_dig_source_otg,
+
+	.dp_get_pixel_format  = enc1_stream_encoder_dp_get_pixel_format,
+
+	.enc_read_state = enc314_read_state,
+	.dp_set_dsc_config = enc314_dp_set_dsc_config,
+	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
+	.set_dynamic_metadata = enc2_set_dynamic_metadata,
+	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
+	.dig_stream_enable = enc35_stream_encoder_enable,
+
+	.set_input_mode = enc314_set_dig_input_mode,
+	.enable_fifo = enc35_enable_fifo,
+	.disable_fifo = enc35_disable_fifo,
+	.map_stream_to_link = enc35_stream_encoder_map_to_link,
+};
+
+void dcn35_dio_stream_encoder_construct(
+	struct dcn10_stream_encoder *enc1,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn10_stream_enc_registers *regs,
+	const struct dcn10_stream_encoder_shift *se_shift,
+	const struct dcn10_stream_encoder_mask *se_mask)
+{
+	enc1->base.funcs = &dcn35_str_enc_funcs;
+	enc1->base.ctx = ctx;
+	enc1->base.id = eng_id;
+	enc1->base.bp = bp;
+	enc1->base.vpg = vpg;
+	enc1->base.afmt = afmt;
+	enc1->regs = regs;
+	enc1->se_shift = se_shift;
+	enc1->se_mask = se_mask;
+	enc1->base.stream_enc_inst = vpg->inst;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
new file mode 100644
index 000000000000..1212fcee38f2
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __DC_DIO_STREAM_ENCODER_DCN35_H__
+#define __DC_DIO_STREAM_ENCODER_DCN35_H__
+
+#include "dcn30/dcn30_vpg.h"
+#include "dcn30/dcn30_afmt.h"
+#include "stream_encoder.h"
+#include "dcn20/dcn20_stream_encoder.h"
+
+/* Register bit field name change */
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_GATE_DIS__SHIFT                                        0x8
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_EN__SHIFT                                              0x9
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_CLOCK_ON__SHIFT                                        0xa
+#define DPCSTX0_DPCSTX_TX_CNTL__DPCS_TX_DATA_SWAP__SHIFT                                                      0xe
+#define DPCSTX0_DPCSTX_TX_CNTL__DPCS_TX_DATA_ORDER_INVERT__SHIFT                                              0xf
+
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_GATE_DIS_MASK                                          0x00000100L
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_EN_MASK                                                0x00000200L
+#define RDPCSTX0_RDPCSTX_CLOCK_CNTL__RDPCS_SYMCLK_DIV2_CLOCK_ON_MASK                                          0x00000400L
+#define DPCSTX0_DPCSTX_TX_CNTL__DPCS_TX_DATA_SWAP_MASK                                                        0x00004000L
+#define DPCSTX0_DPCSTX_TX_CNTL__DPCS_TX_DATA_ORDER_INVERT_MASK                                                0x00008000L
+
+
+#define SE_DCN35_REG_LIST(id)\
+	SRI(AFMT_CNTL, DIG, id), \
+	SRI(DIG_FE_CNTL, DIG, id), \
+	SRI(HDMI_CONTROL, DIG, id), \
+	SRI(HDMI_DB_CONTROL, DIG, id), \
+	SRI(HDMI_GC, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL0, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL1, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL2, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL3, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL4, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL5, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL6, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL7, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL8, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL9, DIG, id), \
+	SRI(HDMI_GENERIC_PACKET_CONTROL10, DIG, id), \
+	SRI(HDMI_INFOFRAME_CONTROL0, DIG, id), \
+	SRI(HDMI_INFOFRAME_CONTROL1, DIG, id), \
+	SRI(HDMI_VBI_PACKET_CONTROL, DIG, id), \
+	SRI(HDMI_AUDIO_PACKET_CONTROL, DIG, id),\
+	SRI(HDMI_ACR_PACKET_CONTROL, DIG, id),\
+	SRI(HDMI_ACR_32_0, DIG, id),\
+	SRI(HDMI_ACR_32_1, DIG, id),\
+	SRI(HDMI_ACR_44_0, DIG, id),\
+	SRI(HDMI_ACR_44_1, DIG, id),\
+	SRI(HDMI_ACR_48_0, DIG, id),\
+	SRI(HDMI_ACR_48_1, DIG, id),\
+	SRI(DP_DB_CNTL, DP, id), \
+	SRI(DP_MSA_MISC, DP, id), \
+	SRI(DP_MSA_VBID_MISC, DP, id), \
+	SRI(DP_MSA_COLORIMETRY, DP, id), \
+	SRI(DP_MSA_TIMING_PARAM1, DP, id), \
+	SRI(DP_MSA_TIMING_PARAM2, DP, id), \
+	SRI(DP_MSA_TIMING_PARAM3, DP, id), \
+	SRI(DP_MSA_TIMING_PARAM4, DP, id), \
+	SRI(DP_MSE_RATE_CNTL, DP, id), \
+	SRI(DP_MSE_RATE_UPDATE, DP, id), \
+	SRI(DP_PIXEL_FORMAT, DP, id), \
+	SRI(DP_SEC_CNTL, DP, id), \
+	SRI(DP_SEC_CNTL1, DP, id), \
+	SRI(DP_SEC_CNTL2, DP, id), \
+	SRI(DP_SEC_CNTL5, DP, id), \
+	SRI(DP_SEC_CNTL6, DP, id), \
+	SRI(DP_STEER_FIFO, DP, id), \
+	SRI(DP_VID_M, DP, id), \
+	SRI(DP_VID_N, DP, id), \
+	SRI(DP_VID_STREAM_CNTL, DP, id), \
+	SRI(DP_VID_TIMING, DP, id), \
+	SRI(DP_SEC_AUD_N, DP, id), \
+	SRI(DP_SEC_TIMESTAMP, DP, id), \
+	SRI(DP_DSC_CNTL, DP, id), \
+	SRI(DP_SEC_METADATA_TRANSMISSION, DP, id), \
+	SRI(HDMI_METADATA_PACKET_CONTROL, DIG, id), \
+	SRI(DP_SEC_FRAMING4, DP, id), \
+	SRI(DP_GSP11_CNTL, DP, id), \
+	SRI(DME_CONTROL, DME, id),\
+	SRI(DP_SEC_METADATA_TRANSMISSION, DP, id), \
+	SRI(HDMI_METADATA_PACKET_CONTROL, DIG, id), \
+	SRI(DIG_FE_CNTL, DIG, id), \
+	SRI(DIG_FE_EN_CNTL, DIG, id), \
+	SRI(DIG_FE_CLK_CNTL, DIG, id), \
+	SRI(DIG_CLOCK_PATTERN, DIG, id), \
+	SRI(DIG_FIFO_CTRL0, DIG, id),\
+	SRI(STREAM_MAPPER_CONTROL, DIG, id)
+
+
+#define SE_COMMON_MASK_SH_LIST_DCN35(mask_sh)\
+	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_ENCODING, mask_sh),\
+	SE_SF(DP0_DP_PIXEL_FORMAT, DP_COMPONENT_DEPTH, mask_sh),\
+	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_PACKET_GEN_VERSION, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_KEEPOUT_MODE, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_DEEP_COLOR_ENABLE, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_DEEP_COLOR_DEPTH, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_DATA_SCRAMBLE_EN, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_NO_EXTRA_NULL_PACKET_FILLED, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GC, HDMI_GC_AVMUTE, mask_sh),\
+	SE_SF(DP0_DP_MSE_RATE_CNTL, DP_MSE_RATE_X, mask_sh),\
+	SE_SF(DP0_DP_MSE_RATE_CNTL, DP_MSE_RATE_Y, mask_sh),\
+	SE_SF(DP0_DP_MSE_RATE_UPDATE, DP_MSE_RATE_UPDATE_PENDING, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP0_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_STREAM_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP1_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP2_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP3_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_MPG_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP5_LINE_REFERENCE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP4_SEND, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP4_SEND_PENDING, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL4, DP_SEC_GSP4_LINE_NUM, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL5, DP_SEC_GSP5_LINE_NUM, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP4_SEND_ANY_LINE, mask_sh),\
+	SE_SF(DP0_DP_VID_STREAM_CNTL, DP_VID_STREAM_DIS_DEFER, mask_sh),\
+	SE_SF(DP0_DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_VID_STREAM_CNTL, DP_VID_STREAM_STATUS, mask_sh),\
+	SE_SF(DP0_DP_STEER_FIFO, DP_STEER_FIFO_RESET, mask_sh),\
+	SE_SF(DP0_DP_VID_TIMING, DP_VID_M_N_GEN_EN, mask_sh),\
+	SE_SF(DP0_DP_VID_N, DP_VID_N, mask_sh),\
+	SE_SF(DP0_DP_VID_M, DP_VID_M, mask_sh),\
+	SE_SF(DIG0_HDMI_AUDIO_PACKET_CONTROL, HDMI_AUDIO_DELAY_EN, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUDIO_PRIORITY, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_32_0, HDMI_ACR_CTS_32, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_32_1, HDMI_ACR_N_32, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_44_0, HDMI_ACR_CTS_44, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_44_1, HDMI_ACR_N_44, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_48_0, HDMI_ACR_CTS_48, mask_sh),\
+	SE_SF(DIG0_HDMI_ACR_48_1, HDMI_ACR_N_48, mask_sh),\
+	SE_SF(DP0_DP_SEC_AUD_N, DP_SEC_AUD_N, mask_sh),\
+	SE_SF(DP0_DP_SEC_TIMESTAMP, DP_SEC_TIMESTAMP_MODE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ASP_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ATP_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_AIP_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ACM_ENABLE, mask_sh),\
+	SE_SF(DIG0_AFMT_CNTL, AFMT_AUDIO_CLOCK_EN, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, HDMI_CLOCK_CHANNEL_RATE, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, TMDS_PIXEL_ENCODING, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, TMDS_COLOR_FORMAT, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_SELECT, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_GATE_EN, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP4_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP5_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP6_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP7_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP7_SEND, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL6, DP_SEC_GSP7_LINE_NUM, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL2, DP_SEC_GSP11_PPS, mask_sh),\
+	SE_SF(DP0_DP_GSP11_CNTL, DP_SEC_GSP11_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_GSP11_CNTL, DP_SEC_GSP11_LINE_NUM, mask_sh),\
+	SE_SF(DP0_DP_DB_CNTL, DP_DB_DISABLE, mask_sh),\
+	SE_SF(DP0_DP_MSA_COLORIMETRY, DP_MSA_MISC0, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM1, DP_MSA_HTOTAL, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM1, DP_MSA_VTOTAL, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM2, DP_MSA_HSTART, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM2, DP_MSA_VSTART, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM3, DP_MSA_HSYNCWIDTH, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM3, DP_MSA_HSYNCPOLARITY, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM3, DP_MSA_VSYNCWIDTH, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM3, DP_MSA_VSYNCPOLARITY, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM4, DP_MSA_HWIDTH, mask_sh),\
+	SE_SF(DP0_DP_MSA_TIMING_PARAM4, DP_MSA_VHEIGHT, mask_sh),\
+	SE_SF(DIG0_HDMI_DB_CONTROL, HDMI_DB_DISABLE, mask_sh),\
+	SE_SF(DP0_DP_VID_TIMING, DP_VID_N_MUL, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CNTL, DIG_SOURCE_SELECT, mask_sh), \
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC1_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC2_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC3_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC4_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC5_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC6_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC7_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC8_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC8_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC9_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC9_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC10_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC10_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC11_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC11_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC12_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC12_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC13_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC13_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC14_CONT, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL6, HDMI_GENERIC14_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL1, HDMI_GENERIC0_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL1, HDMI_GENERIC1_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL2, HDMI_GENERIC2_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL2, HDMI_GENERIC3_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL3, HDMI_GENERIC4_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL3, HDMI_GENERIC5_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL4, HDMI_GENERIC6_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL4, HDMI_GENERIC7_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL7, HDMI_GENERIC8_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL7, HDMI_GENERIC9_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL8, HDMI_GENERIC10_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL8, HDMI_GENERIC11_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL9, HDMI_GENERIC12_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL9, HDMI_GENERIC13_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL10, HDMI_GENERIC14_LINE, mask_sh),\
+	SE_SF(DP0_DP_DSC_CNTL, DP_DSC_MODE, mask_sh),\
+	SE_SF(DP0_DP_MSA_VBID_MISC, DP_VBID6_LINE_REFERENCE, mask_sh),\
+	SE_SF(DP0_DP_MSA_VBID_MISC, DP_VBID6_LINE_NUM, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_ENGINE_EN, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_HUBP_REQUESTOR_ID, mask_sh),\
+	SE_SF(DME0_DME_CONTROL, METADATA_STREAM_TYPE, mask_sh),\
+	SE_SF(DP0_DP_SEC_METADATA_TRANSMISSION, DP_SEC_METADATA_PACKET_ENABLE, mask_sh),\
+	SE_SF(DP0_DP_SEC_METADATA_TRANSMISSION, DP_SEC_METADATA_PACKET_LINE_REFERENCE, mask_sh),\
+	SE_SF(DP0_DP_SEC_METADATA_TRANSMISSION, DP_SEC_METADATA_PACKET_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_ENABLE, mask_sh),\
+	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE_REFERENCE, mask_sh),\
+	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mask_sh),\
+	SE_SF(DIG0_HDMI_CONTROL, DOLBY_VISION_EN, mask_sh),\
+	SE_SF(DIG0_DIG_FE_EN_CNTL, DIG_FE_ENABLE, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_MODE, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_SOFT_RESET, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_DISPCLK_G_CLOCK_ON, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_SYMCLK_FE_G_CLOCK_ON, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_SYMCLK_FE_G_AFMT_CLOCK_ON, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_SYMCLK_FE_G_TMDS_CLOCK_ON, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CLK_CNTL, DIG_FE_SOCCLK_G_AFMT_CLOCK_ON, mask_sh),\
+	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh),\
+	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh),\
+	SE_SF(DIG0_STREAM_MAPPER_CONTROL, DIG_STREAM_LINK_TARGET, mask_sh),
+
+void dcn35_dio_stream_encoder_construct(
+	struct dcn10_stream_encoder *enc1,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id,
+	struct vpg *vpg,
+	struct afmt *afmt,
+	const struct dcn10_stream_enc_registers *regs,
+	const struct dcn10_stream_encoder_shift *se_shift,
+	const struct dcn10_stream_encoder_mask *se_mask);
+
+void enc3_stream_encoder_update_hdmi_info_packets(
+	struct stream_encoder *enc,
+	const struct encoder_info_frame *info_frame);
+
+void enc3_stream_encoder_stop_hdmi_info_packets(
+	struct stream_encoder *enc);
+
+void enc3_stream_encoder_update_dp_info_packets_sdp_line_num(
+		struct stream_encoder *enc,
+		struct encoder_info_frame *info_frame);
+
+void enc3_stream_encoder_update_dp_info_packets(
+	struct stream_encoder *enc,
+	const struct encoder_info_frame *info_frame);
+
+void enc3_audio_mute_control(
+	struct stream_encoder *enc,
+	bool mute);
+
+void enc3_se_dp_audio_setup(
+	struct stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info);
+
+void enc3_se_dp_audio_enable(
+	struct stream_encoder *enc);
+
+void enc3_se_hdmi_audio_setup(
+	struct stream_encoder *enc,
+	unsigned int az_inst,
+	struct audio_info *info,
+	struct audio_crtc_info *audio_crtc_info);
+
+void enc3_dp_set_dsc_pps_info_packet(
+	struct stream_encoder *enc,
+	bool enable,
+	uint8_t *dsc_packed_pps,
+	bool immediate_update);
+
+
+#endif /* __DC_DIO_STREAM_ENCODER_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index a6dedf3c7d74..a15efadb9183 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -226,6 +226,11 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc,
 		int tg_inst);
 
+	void (*dig_stream_enable)(
+		struct stream_encoder *enc,
+		enum signal_type signal,
+		bool enable);
+
 	void (*hdmi_reset_stream_attribute)(
 		struct stream_encoder *enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 28cb1f5a504d..cd9dd270b05f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2353,6 +2353,14 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	if (vpg && vpg->funcs->vpg_powerdown)
 		vpg->funcs->vpg_powerdown(vpg);
+
+	/* for psp not exist case */
+	if (link->connector_signal == SIGNAL_TYPE_EDP && dc->debug.psp_disabled_wa) {
+		/* reset internal save state to default since eDP is  off */
+		enum dp_panel_mode panel_mode = dp_get_panel_mode(pipe_ctx->stream->link);
+		/* since current psp not loaded, we need to reset it to default*/
+		link->panel_mode = panel_mode;
+	}
 }
 
 void link_set_dpms_on(
@@ -2394,10 +2402,17 @@ void link_set_dpms_on(
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
 			&& !dp_is_128b_132b_signal(pipe_ctx)) {
+		struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+
 		if (link_enc)
 			link_enc->funcs->setup(
 				link_enc,
 				pipe_ctx->stream->signal);
+
+		if (stream_enc && stream_enc->funcs->dig_stream_enable)
+			stream_enc->funcs->dig_stream_enable(
+				stream_enc,
+				pipe_ctx->stream->signal, 1);
 	}
 
 	pipe_ctx->stream->link->link_state_valid = true;
@@ -2498,10 +2513,18 @@ void link_set_dpms_on(
 	 */
 	if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {
+			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+
 			if (link_enc)
 				link_enc->funcs->setup(
 					link_enc,
 					pipe_ctx->stream->signal);
+
+			if (stream_enc && stream_enc->funcs->dig_stream_enable)
+				stream_enc->funcs->dig_stream_enable(
+					stream_enc,
+					pipe_ctx->stream->signal, 1);
+
 		}
 
 	dc->hwss.enable_stream(pipe_ctx);
-- 
2.41.0

