Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F4E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7864710F07B;
	Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KEHornRg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DB910F07B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqeFM24G3kervNvu9uGaJgpAoIQkG1hJnbnLvXnCr8lg91UhVCHF07I7WBN/9UhWEI+07IfL4BxyD7HX0IjEEQL40eUU67FEizhr2Btsje2MFGJ5xZ8f0vLPPCD8HEsnuBspkpRdyWSmZ+jrhz1/01QNZpvMtg2qNY/NN1oVhDLR4vBs5qzS8g8MKd4hZnHHVH0EkG4vTtNcqUopqN/9Z3kXvCX287jyzHQSitF7exwrfh8aztyutrKY54GXydeUUtCKuI5Pvl1/e4O81+Zi1lHgBIuHxzzDc6aEwr0I4W+8v20oKEqRa07tpvvvgKVaolt7EDL32G/n4LtdwR5ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S/yPUK62cb/Il/ER5H9mJYJr18+16t/sY89oJTw9uI=;
 b=setsC6JJeeB64t1dJ4+YWYprAlPeIpn+nAo8BXR7Xyge+EZ9RmrlJDChfzTe3F/53VXylINONIY4hHD3fwkGeF3T2VeWatNpLKeU4XHvivbE3b9vRX5S9CqWT4RLo3EPY9EmNybB7cAaOFvbElKr5n9M+q4dZtosh/1D65HiQyWH3rBr42N1AJGsZ0ES8jkJ9/gC4+O3F6pNZsB09pazIvV/V/Tu1SdAa5vlrN4MCpSWJh3Moio3Z87A12FoGEFm+cQT+/z9S7sdqxXltZ6QcRPJluX8trpTH5t/Lb97+J9Z0EzJdwZ0Zwny6hq98gjWdtZB5kboHWjcW7s5zAvXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S/yPUK62cb/Il/ER5H9mJYJr18+16t/sY89oJTw9uI=;
 b=KEHornRgiV4vSceGSrOmagxCDbzVkhJp6yQuMaiRWXt++bKHcVGvQPRvkOTXv5HJvKDiRXXLEHxuPHtY7mSNXsVIwUPSwwR4Y42aU9c64vrNo4UgFbc8PThwU9IyC030VMojxrEQqoA/dlEmUDNq3yLKiOVFgpSL/3YBL2plCMo=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Fri, 20 Dec
 2024 21:51:17 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::cd) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 21:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:15 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:15 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Peichen
 Huang" <PeiChen.Huang@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 14/28] drm/amd/display: have pretrain for dpia
Date: Fri, 20 Dec 2024 16:48:41 -0500
Message-ID: <20241220214855.2608618-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: dab5d309-1d2a-4303-52c9-08dd21406ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CHhZPo2XikFXA+w0pTY00e+NdFl7JDAi484fNDXXoXVQz82Dc5fvCgqaNUgF?=
 =?us-ascii?Q?DFxwBYFCiy9V2VYu7vwnIBRtNqzU5LzKAPXiGYXryaPlFa/Fe72bCSHqSlVQ?=
 =?us-ascii?Q?HunW0woT+TAKGis9i2Hc0q2o9WMH79TIjLr7EwVsxl4xZN8KLPOUlSmeFxAM?=
 =?us-ascii?Q?tygS8qDAmtaVpeMXeKgJxb5P7lr2nrs3VtzD4n/W7D9dZCCFqmoYzEBWHgu5?=
 =?us-ascii?Q?eb0OqibRk7ZZH5vO9HyBs5+BGFbN7JRNy9af59ghx1/5N+AJonHCrCQhykGQ?=
 =?us-ascii?Q?vppGRhMECwG92/0u/y1wlbfZwYfgO/lGp8IMrFFTQqLfVdBjcGTzDSbMyXtt?=
 =?us-ascii?Q?dg3iWT7UAaYJklpRjOL/8NycMT8zwp1FR2kx3JTIC1ETQ4PMiH9SBTcb+bzR?=
 =?us-ascii?Q?rN6cJ0hKurse1QQIvl6tZmOl6sr9T6G9AQpIQCg2JoB/kEv/MwgBfdkOZXTt?=
 =?us-ascii?Q?qAb8c7tMgD7G3qAytj9OltAMVgX0jIs/Zq0p5p/xjkf1njvlrpnF0PMhDXXI?=
 =?us-ascii?Q?70TuPGPwcWJW8ZkncGSNQF4V75Flebtm+ClUsVnsMyXPMGWF9oCwAHSLRJfh?=
 =?us-ascii?Q?2+B60WeihhmW2O1XbhYibpRE8prlosp/FUNlRyx1VUH+Ag5Vuv6+4PH6v/tL?=
 =?us-ascii?Q?VcnrmF3Mm4sqgt/F2KeT8nWJmRtNXBINUWwJK42Y/G+DmVByZpk2GghwoztF?=
 =?us-ascii?Q?d4FBefpFY04RLcLP8Ct+jFaHsp45rO2nxU5ZJP4dfUk6AZwbnX/XWTLjRAGS?=
 =?us-ascii?Q?7NSn7gj9r+PY8oM6g3b/tMih4ew4c7zS6FJg39j9Ir8GQ04VDlLDU5TZP9NO?=
 =?us-ascii?Q?K6l/1szNtf8iouUTN++P5osJJYhZAZOgi22xKfa7yqvqBVsTR/7HcgDErbKR?=
 =?us-ascii?Q?zsRktFJNPbaBeuRs9rxRSOjAP74WzAQRMF8BnZJ023TkskYM/ZZ6CXniCN4k?=
 =?us-ascii?Q?TYF6Stsl8oR8lF6y+k/JVQOxuF/kXal5BYCF/l95XXEXnxidAUNXatKcp4AT?=
 =?us-ascii?Q?jpwcr/JqQg0hkEH3eL1mzGHLQpzv5yDYoBqic32jDxNmt8G8gbpUdZnj8Niy?=
 =?us-ascii?Q?PuLvd0WXiyXEoFpG7EXhHzdFdeP6sdaA9B0o6pxggqoGaT0LZ9AGpKPLMgCK?=
 =?us-ascii?Q?j2xB9KlTKYJWJtauZWfstH9Hwarb9W3E6Lea9x3PQ/ncb7YBuZId9LwCK8I7?=
 =?us-ascii?Q?AwpEsBqvDpJ43CDRcG/uQj8kDiy1zNK0E7RXkbnnOngFvBefUZkNOzAJTwWS?=
 =?us-ascii?Q?au6l4nmAyd0fAXP6BYPzL9JPIIL3UocTGMaZbQn+FgOAteJn58BJlcLqqGe/?=
 =?us-ascii?Q?SgH8FZhtuRHvXNp4KrEB64vQ0yXRMjCuRJnX3DscVSYMKyU/arNIfXMtKG8U?=
 =?us-ascii?Q?WtO06sjwO/uyM+L+i8ehSZao6li0/rglouQFVY4BPC9mljZqbfIervlinEyK?=
 =?us-ascii?Q?aAIQ0JG3WXojbsWADy3Fm9q6EDkRqs7vNBYKPFUSsAj9XeCCvYY2uCSkqpNP?=
 =?us-ascii?Q?ITQ0v4Ea/KxF3mg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:17.2842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab5d309-1d2a-4303-52c9-08dd21406ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
We like to have pretrain for dpia link so that dp and dp tunneling
have aligned behavior. The Main difficult for dpia pretrain is that
encoder can not get corresponded dpia port when link detection
in current implementation.

[HOW]
1. create enable/disable dpia output functions for dcn35 encoder
and have dpia_id and other necessary info as inputs.
2. dcn35 dpia use the new functions to enable/disable output.
3. have a option to enable/disable the change.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     | 80 +++++++++++++++++++
 .../dc/dio/dcn35/dcn35_dio_link_encoder.h     | 18 +++++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 ++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 61 +++++++++++++-
 .../amd/display/dc/link/hwss/link_hwss_dpia.h |  3 +
 .../drm/amd/display/dc/link/link_detection.c  |  3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  3 +-
 10 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 96594ec6a1d6..363fbb64b1a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -472,6 +472,7 @@ struct dc_config {
 	bool disable_hbr_audio_dp2;
 	bool consolidated_dpia_dp_lt;
 	bool set_pipe_unlock_order;
+	bool enable_dpia_pre_training;
 };
 
 enum visual_confirm {
@@ -775,7 +776,8 @@ union dpia_debug_options {
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
 		uint32_t enable_consolidated_dpia_dp_lt:1; /* bit 6 */
-		uint32_t reserved:25;
+		uint32_t enable_dpia_pre_training:1; /* bit 7 */
+		uint32_t reserved:24;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index d4a3e811aa39..ea0c9a9d0bd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -28,6 +28,7 @@
 #include "link_encoder.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn35_dio_link_encoder.h"
+#include "dc_dmub_srv.h"
 #define CTX \
 	enc10->base.ctx
 #define DC_LOGGER \
@@ -159,6 +160,8 @@ static const struct link_encoder_funcs dcn35_link_enc_funcs = {
 	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.enable_dpia_output = dcn35_link_encoder_enable_dpia_output,
+	.disable_dpia_output = dcn35_link_encoder_disable_dpia_output,
 };
 
 void dcn35_link_encoder_construct(
@@ -265,3 +268,80 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 
 }
+
+/* DPIA equivalent of link_transmitter_control. */
+static bool link_dpia_control(struct dc_context *dc_ctx,
+	struct dmub_cmd_dig_dpia_control_data *dpia_control)
+{
+	union dmub_rb_cmd cmd;
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
+	dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+static void link_encoder_disable(struct dcn10_link_encoder *enc10)
+{
+	/* reset training complete */
+	REG_UPDATE(DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, 0);
+}
+
+void dcn35_link_encoder_enable_dpia_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	uint8_t dpia_id,
+	uint8_t digmode,
+	uint8_t fec_rdy)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
+
+	enc1_configure_encoder(enc10, link_settings);
+
+	dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_ENABLE;
+	dpia_control.enc_id = enc->preferred_engine;
+	dpia_control.mode_laneset.digmode = digmode;
+	dpia_control.lanenum = (uint8_t)link_settings->lane_count;
+	dpia_control.symclk_10khz = link_settings->link_rate *
+			LINK_RATE_REF_FREQ_IN_KHZ / 10;
+	/* DIG_BE_CNTL.DIG_HPD_SELECT set to 5 (hpdsel - 1) to indicate HPD pin unused by DPIA. */
+	dpia_control.hpdsel = 6;
+	dpia_control.dpia_id = dpia_id;
+	dpia_control.fec_rdy = fec_rdy;
+
+	DC_LOG_DEBUG("%s: DPIA(%d) - enc_id(%d)\n", __func__, dpia_control.dpia_id, dpia_control.enc_id);
+	link_dpia_control(enc->ctx, &dpia_control);
+}
+
+void dcn35_link_encoder_disable_dpia_output(
+	struct link_encoder *enc,
+	uint8_t dpia_id,
+	uint8_t digmode)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
+
+	if (enc->funcs->is_dig_enabled && !enc->funcs->is_dig_enabled(enc))
+		return;
+
+	dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_DISABLE;
+	dpia_control.enc_id = enc->preferred_engine;
+	dpia_control.mode_laneset.digmode = digmode;
+	dpia_control.dpia_id = dpia_id;
+
+	DC_LOG_DEBUG("%s: DPIA(%d) - enc_id(%d)\n", __func__, dpia_control.dpia_id, dpia_control.enc_id);
+	link_dpia_control(enc->ctx, &dpia_control);
+
+	link_encoder_disable(enc10);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
index d546a3676304..f9d4221f4b43 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
@@ -144,4 +144,22 @@ bool dcn35_is_dig_enabled(struct link_encoder *enc);
 enum signal_type dcn35_get_dig_mode(struct link_encoder *enc);
 void dcn35_link_encoder_setup(struct link_encoder *enc, enum signal_type signal);
 
+/*
+ * Enable DP transmitter and its encoder for dpia port.
+ */
+void dcn35_link_encoder_enable_dpia_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	uint8_t dpia_id,
+	uint8_t digmode,
+	uint8_t fec_rdy);
+
+/*
+ * Disable transmitter and its encoder for dpia port.
+ */
+void dcn35_link_encoder_disable_dpia_output(
+	struct link_encoder *enc,
+	uint8_t dpia_id,
+	uint8_t digmode);
+
 #endif /* __DC_LINK_ENCODER__DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index af9183f5d69b..08c16ba52a51 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -168,6 +168,14 @@ struct link_encoder_funcs {
 		struct link_encoder *enc,
 		enum encoder_type_select sel,
 		uint32_t hpo_inst);
+	void (*enable_dpia_output)(struct link_encoder *enc,
+		const struct dc_link_settings *link_settings,
+		uint8_t dpia_id,
+		uint8_t digmode,
+		uint8_t fec_rdy);
+	void (*disable_dpia_output)(struct link_encoder *link_enc,
+		uint8_t dpia_id,
+		uint8_t digmode);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 3e47a6735912..06faa461067b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -164,7 +164,9 @@ void disable_dio_link_output(struct dc_link *link,
 {
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
 
-	link_enc->funcs->disable_output(link_enc, signal);
+	if (link_enc != NULL)
+		link_enc->funcs->disable_output(link_enc, signal);
+
 	link->dc->link_srv->dp_trace_source_sequence(link,
 			DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 6499807af72a..36adf95744fe 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -77,17 +77,74 @@ static void set_dio_dpia_lane_settings(struct dc_link *link,
 {
 }
 
+static void enable_dpia_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (link_enc != NULL) {
+		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->enable_dpia_output) {
+			uint8_t fec_rdy = link->dc->link_srv->dp_should_enable_fec(link);
+			uint8_t digmode = dc_is_dp_sst_signal(signal) ? DIG_SST_MODE : DIG_MST_MODE;
+
+			link_enc->funcs->enable_dpia_output(
+					link_enc,
+					link_settings,
+					link->ddc_hw_inst,
+					digmode,
+					fec_rdy);
+		} else {
+			if (dc_is_dp_sst_signal(signal))
+				link_enc->funcs->enable_dp_output(
+						link_enc,
+						link_settings,
+						clock_source);
+			else
+				link_enc->funcs->enable_dp_mst_output(
+						link_enc,
+						link_settings,
+						clock_source);
+		}
+
+	}
+
+	link->dc->link_srv->dp_trace_source_sequence(link,
+			DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
+}
+
+static void disable_dpia_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (link_enc != NULL) {
+		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->disable_dpia_output) {
+			uint8_t digmode = dc_is_dp_sst_signal(signal) ? DIG_SST_MODE : DIG_MST_MODE;
+
+			link_enc->funcs->disable_dpia_output(link_enc, link->ddc_hw_inst, digmode);
+		} else
+			link_enc->funcs->disable_output(link_enc, signal);
+	}
+
+	link->dc->link_srv->dp_trace_source_sequence(link,
+			DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
+
 static const struct link_hwss dpia_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
-	.disable_link_output = disable_dio_link_output,
+	.disable_link_output = disable_dpia_link_output,
 	.setup_audio_output = setup_dio_audio_output,
 	.enable_audio_packet = enable_dio_audio_packet,
 	.disable_audio_packet = disable_dio_audio_packet,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
-		.enable_dp_link_output = enable_dio_dp_link_output,
+		.enable_dp_link_output = enable_dpia_link_output,
 		.set_dp_link_test_pattern = set_dio_dpia_link_test_pattern,
 		.set_dp_lane_settings = set_dio_dpia_lane_settings,
 		.update_stream_allocation_table = update_dpia_stream_allocation_table,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.h
index ad16ec5d9bb7..259e0f4775e1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.h
@@ -27,6 +27,9 @@
 
 #include "link_hwss.h"
 
+#define DIG_SST_MODE    0
+#define DIG_MST_MODE    5
+
 const struct link_hwss *get_dpia_link_hwss(void);
 bool can_use_dpia_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index e026c728042a..550e1a098fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -829,7 +829,8 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 
 		if (link->dc->debug.skip_detection_link_training ||
 				dc_is_embedded_signal(link->local_sink->sink_signal) ||
-				link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+				(link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+				!link->dc->config.enable_dpia_pre_training)) {
 			destrictive = false;
 		} else if (link_dp_get_encoding_format(&max_link_cap) ==
 				DP_8b_10b_ENCODING) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 60e64e0138a3..6f3e7e182145 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2043,7 +2043,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	/* Train with fallback when enabling DPIA link. Conventional links are
 	 * trained with fallback during sink detection.
 	 */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+			!link->dc->config.enable_dpia_pre_training)
 		do_fallback = true;
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 017fbc476d51..ae47bb5975af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -410,7 +410,8 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 
 	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		// Workaround for DP 1.4a LL Compliance CTS as USB4 has to share encoders unlike DP and USBC
-		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+				!link->dc->config.enable_dpia_pre_training)
 			link->skip_fallback_on_link_loss = true;
 
 		device_service_clear.bits.AUTOMATED_TEST = 1;
-- 
2.34.1

