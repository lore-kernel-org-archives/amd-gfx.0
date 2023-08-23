Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA9EE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C6910E43C;
	Wed, 23 Aug 2023 15:51:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E29F10E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPfAe/EkR8YHwAgRvlFwpYKQh7rMUxRMHq/2+/kZPnFxXaPFcYq80e54SbnGGfdAT24gYM4ZNHd7L1962UsKkkGEQ2s/7Fzv+ZXKo7aVoc7vFXkNufY95qBvX77ZzoShrYE3Pg5RjSlCKp8F9+9la6C73q2V1cVTrLX2S7qOlKKFPqUdvNfL+A1ikWkaLYb1v1gBSEYV8qnfTT5kr+ewy9TBU6N38/6wj+HjGPP/9lU8eI9uA891VDQh2PXqyqmRL63eyFoXODcOGQmGJDZB6RiLlfzs76pl8P5ubk+XScPBzE1FbZZe1N0jENK251J1SUCe+6olkhn9m9ONpKxmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XX1l6AOF8YEA/kyuSWHDOHD27emcC8zzqCRIfczFCo=;
 b=nQ9re9ZuZWrb6itzAJrP3epfb41ognq3MwQoiL1KD52RLqxwNzoMS/Y6Ic7MI4z91MgCBwzqoPQcenmp+wuEImm0kaaa3wkpyRIGtou3B6b+I5YXofnw4lc4KftO/ssQXuYMBMBwY62w1+Gg03SyWeZcPtQ6HaOnW56bIpjNhQ/YzgKFCd84TWPIlKthIiOBuZb+3uqOzZ4cY7h63oeU+7+nbT23bblxl4BTUHuNAqGu5Iou/EQld/cHI7MqY07879DH+CeE5gDEr50gnlxzYdXfhXh72gpgm2G6ONBH/dT2khHjX7MzYRCOWTQBlugTNQBiIbxQYHuZWQw3mVe/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XX1l6AOF8YEA/kyuSWHDOHD27emcC8zzqCRIfczFCo=;
 b=Cq+OeTeX3jnoSh43rtp5onNBQ14ZX/9ssx6XHsMfyXR2oz7Bob2bXpk6VqjKKMi738glh2xdt9K2G1JzSY2XBBfwybyMR+MpcaPYeF0xkkuzPcX3xBSEOWiRDXAUBwPp/cVYzTNg4314shNH4719AvWdZB/b6V+VMh8xSnNHVQo=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:09 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::5b) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/35] drm/amd/display: Update DCN10 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:18 -0400
Message-ID: <20230823155048.2526343-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: db921fd4-416a-4348-28fe-08dba3f0c4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcuF2HUAOSn+45l2vQNf49qyU4oag/u3NuU/qAqUgcSpvvovnuHsoDAImTocMV6clsc0VtR/LdOkwheSDPQOkqgmzVO1LMw8Z6BON4zXtFuear7TjFAdNPSRF3UgbIODsd0ofGSX/mB34Wm9ZROZnHwj4fMoLJvEoyf1u6/wk5Mvt/pDWmp7GDbt6uOEu/2UoMFnGWF5E5k4aYdia0TRKaO+AQsyRGSrqu27dL3nOLtxHf2sogKpfxaBihRTxfG+h/VeWqc6qSDGz2rxHOYx/QLMQy4RPAk7p2AQlEcUyDPK64b38BZeC1dfuNHncltisoEHfMQVuMucYCRoruy/PRp/eSjQOlw8Y09KIQf+uKxF7naEJd5OtqmVy0s2s9VQN2nGbH0lY+97oTrSS1v5NsUh2hUrZLGOMnZ++E2F4GyUkxKjXsfraLgE/pg/EBJtpWbQL0mPzoAM2lifx262HD4kloOtdOhqrsk0oKt8tPzOoJ7x6OJZWf/M+EZ9rZFS6Df6p6YiviPAE9CK06wqGJW8Bmv2Y8NTYevaGDuV/OFC9R5q4QGwHIjj5mIdMxh3GoUScthEoLSh9qBJ7v8D7g/qVy/6LFDagMbWKTblN2gapRSugXRJdJweJ4p7WB7jBANBc0rSUQNg6EK87s5JOuILQQhj6Q1Sm1Q3oMrQdzVMIy4tl5dJ1EBtNmK+5+scb77HBB3iPaIch1xYaN6aFml47mtLFZN82knfu+jWWIdO66f9aoC6P+E3KIlZcbJvTf4jVhpnbS1+AVEwbgmI3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(15650500001)(83380400001)(426003)(5660300002)(336012)(16526019)(7696005)(86362001)(36860700001)(26005)(47076005)(2616005)(8936002)(4326008)(70586007)(316002)(54906003)(6916009)(70206006)(82740400003)(478600001)(8676002)(356005)(81166007)(40460700003)(41300700001)(36756003)(6666004)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:09.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db921fd4-416a-4348-28fe-08dba3f0c4ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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
Update DCN10 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |  5 +++
 .../amd/display/dc/dcn10/dcn10_link_encoder.h | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 30 +++++++++++++++++
 .../display/dc/dcn10/dcn10_stream_encoder.h   | 19 +++++++++--
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index e8752077571a..adc876156d2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -196,6 +196,9 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C;\
 		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D
 
+#define HUBBUB_REG_FIELD_LIST_DCN35(type) \
+		type DCHUBBUB_FGCG_REP_DIS
+
 /* set field name */
 #define HUBBUB_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -381,6 +384,7 @@ struct dcn_hubbub_shift {
 	HUBBUB_HVM_REG_FIELD_LIST(uint8_t);
 	HUBBUB_RET_REG_FIELD_LIST(uint8_t);
 	HUBBUB_REG_FIELD_LIST_DCN32(uint8_t);
+	HUBBUB_REG_FIELD_LIST_DCN35(uint8_t);
 };
 
 struct dcn_hubbub_mask {
@@ -389,6 +393,7 @@ struct dcn_hubbub_mask {
 	HUBBUB_HVM_REG_FIELD_LIST(uint32_t);
 	HUBBUB_RET_REG_FIELD_LIST(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN32(uint32_t);
+	HUBBUB_REG_FIELD_LIST_DCN35(uint8_t);
 };
 
 struct dc;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index 773380ef4997..d980e6bd6c66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -168,6 +168,8 @@ struct dcn10_link_enc_registers {
 	uint32_t DIO_LINKE_CNTL;
 	uint32_t DIO_LINKF_CNTL;
 	uint32_t DIG_FIFO_CTRL0;
+	uint32_t DIO_CLK_CNTL;
+	uint32_t DIG_BE_CLK_CNTL;
 };
 
 #define LE_SF(reg_name, field_name, post_fix)\
@@ -476,12 +478,42 @@ struct dcn10_link_enc_registers {
 #define DCN32_LINK_ENCODER_REG_FIELD_LIST(type) \
 	type DIG_FIFO_OUTPUT_PIXEL_MODE
 
+#define DCN35_LINK_ENCODER_REG_FIELD_LIST(type) \
+	type DIG_BE_ENABLE;\
+	type DIG_RB_SWITCH_EN;\
+	type DIG_BE_MODE;\
+	type DIG_BE_CLK_EN;\
+	type DIG_BE_SOFT_RESET;\
+	type HDCP_SOFT_RESET;\
+	type DIG_BE_SYMCLK_G_CLOCK_ON;\
+	type DIG_BE_SYMCLK_G_HDCP_CLOCK_ON;\
+	type DIG_BE_SYMCLK_G_TMDS_CLOCK_ON;\
+	type DISPCLK_R_GATE_DIS;\
+	type DISPCLK_G_GATE_DIS;\
+	type REFCLK_R_GATE_DIS;\
+	type REFCLK_G_GATE_DIS;\
+	type SOCCLK_G_GATE_DIS;\
+	type SYMCLK_FE_R_GATE_DIS;\
+	type SYMCLK_FE_G_GATE_DIS;\
+	type SYMCLK_R_GATE_DIS;\
+	type SYMCLK_G_GATE_DIS;\
+	type DIO_FGCG_REP_DIS;\
+	type DISPCLK_G_HDCP_GATE_DIS;\
+	type SYMCLKA_G_HDCP_GATE_DIS;\
+	type SYMCLKB_G_HDCP_GATE_DIS;\
+	type SYMCLKC_G_HDCP_GATE_DIS;\
+	type SYMCLKD_G_HDCP_GATE_DIS;\
+	type SYMCLKE_G_HDCP_GATE_DIS;\
+	type SYMCLKF_G_HDCP_GATE_DIS;\
+	type SYMCLKG_G_HDCP_GATE_DIS
+
 struct dcn10_link_enc_shift {
 	DCN_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
+	DCN35_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 };
 
 struct dcn10_link_enc_mask {
@@ -490,6 +522,7 @@ struct dcn10_link_enc_mask {
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
+	DCN35_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 };
 
 struct dcn10_link_encoder {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index db766689af58..aaf6c981fd9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -189,6 +189,15 @@ struct dcn_optc_registers {
 	uint32_t OTG_M_CONST_DTO1;
 	uint32_t OTG_DRR_V_TOTAL_CHANGE;
 	uint32_t OTG_GLOBAL_CONTROL4;
+	uint32_t OTG_CRC0_WINDOWA_X_CONTROL_READBACK;
+	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL_READBACK;
+	uint32_t OTG_CRC0_WINDOWB_X_CONTROL_READBACK;
+	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL_READBACK;
+	uint32_t OTG_CRC1_WINDOWA_X_CONTROL_READBACK;
+	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL_READBACK;
+	uint32_t OTG_CRC1_WINDOWB_X_CONTROL_READBACK;
+	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL_READBACK;
+	uint32_t OPTC_CLOCK_CONTROL;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -554,14 +563,35 @@ struct dcn_optc_registers {
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
 
 
+#define TG_REG_FIELD_LIST_DCN3_5(type) \
+	type OTG_CRC0_WINDOWA_X_START_READBACK;\
+	type OTG_CRC0_WINDOWA_X_END_READBACK;\
+	type OTG_CRC0_WINDOWA_Y_START_READBACK;\
+	type OTG_CRC0_WINDOWA_Y_END_READBACK;\
+	type OTG_CRC0_WINDOWB_X_START_READBACK;\
+	type OTG_CRC0_WINDOWB_X_END_READBACK;\
+	type OTG_CRC0_WINDOWB_Y_START_READBACK;\
+	type OTG_CRC0_WINDOWB_Y_END_READBACK; \
+	type OTG_CRC1_WINDOWA_X_START_READBACK;\
+	type OTG_CRC1_WINDOWA_X_END_READBACK;\
+	type OTG_CRC1_WINDOWA_Y_START_READBACK;\
+	type OTG_CRC1_WINDOWA_Y_END_READBACK;\
+	type OTG_CRC1_WINDOWB_X_START_READBACK;\
+	type OTG_CRC1_WINDOWB_X_END_READBACK;\
+	type OTG_CRC1_WINDOWB_Y_START_READBACK;\
+	type OTG_CRC1_WINDOWB_Y_END_READBACK;\
+	type OPTC_FGCG_REP_DIS;
+
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
+	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
 };
 
 struct dcn_optc_mask {
 	TG_REG_FIELD_LIST(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint32_t)
+	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
 };
 
 struct optc {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 9d5e2a7848dd..085b269c654f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -188,6 +188,9 @@ struct dcn10_stream_enc_registers {
 	uint32_t HDMI_GENERIC_PACKET_CONTROL10;
 	uint32_t DIG_CLOCK_PATTERN;
 	uint32_t DIG_FIFO_CTRL0;
+	uint32_t DIG_FE_CLK_CNTL;
+	uint32_t DIG_FE_EN_CNTL;
+	uint32_t STREAM_MAPPER_CONTROL;
 };
 
 
@@ -576,13 +579,25 @@ struct dcn10_stream_enc_registers {
 	type DIG_FIFO_RESET;\
 	type DIG_FIFO_RESET_DONE
 
+#define SE_REG_FIELD_LIST_DCN3_5_COMMON(type) \
+	type DIG_FE_CLK_EN;\
+	type DIG_FE_MODE;\
+	type DIG_FE_SOFT_RESET;\
+	type DIG_FE_ENABLE;\
+	type DIG_FE_SYMCLK_FE_G_CLOCK_ON;\
+	type DIG_FE_DISPCLK_G_CLOCK_ON;\
+	type DIG_FE_SYMCLK_FE_G_AFMT_CLOCK_ON;\
+	type DIG_FE_SYMCLK_FE_G_TMDS_CLOCK_ON;\
+	type DIG_FE_SOCCLK_G_AFMT_CLOCK_ON;\
+	type DIG_STREAM_LINK_TARGET
+
 struct dcn10_stream_encoder_shift {
 	SE_REG_FIELD_LIST_DCN1_0(uint8_t);
 	uint8_t HDMI_ACP_SEND;
 	SE_REG_FIELD_LIST_DCN2_0(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_2(uint8_t);
-
+	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint8_t);
 };
 
 struct dcn10_stream_encoder_mask {
@@ -591,7 +606,7 @@ struct dcn10_stream_encoder_mask {
 	SE_REG_FIELD_LIST_DCN2_0(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_2(uint32_t);
-
+	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint32_t);
 };
 
 struct dcn10_stream_encoder {
-- 
2.41.0

