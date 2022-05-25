Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDB2C43217
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B12E10E814;
	Wed, 25 May 2022 16:20:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F4510E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcgRWxx8raYsJBlbtnBCznwILijG6Oct+pNSI29s4YmDULZi+oA7OpNJV4gAF5sYYmMrDq/UMKQDH7F7FCkMpPw95FQK0Nr/Yo1t4ZwM+umn2bulNfeUaPw0xnepN8ODs0EYvqRwv8re3oPCkP9cz0nWexJSHTfBP6beA8sDVougEEnMx2qz3AW646a7oBweX95leCECQw6cuzFuhBHMXK/cs1EiUBKCCg382NrASwCIFFQLi7bsrU9EJJqfHrRH8i2yzqgV5xkWSc10hH63a9EGVzx+HL6eXQqgmhO4YmcW6z3TEFxvr7+gSyGE0Py/X0bZrKNhysXOHSdu1j1jKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHDhsMWGADGRMsqH6P1q/BMpkUrQxlcmqMei6VRN/YI=;
 b=SATF8S4uUGAoEWTI8/bMDJP5aknVDYQM1bBKi1Pny7SZfrVqx82eTWTFoKETW0zbGGZd/zCSctTJckAHqU1PfiLOOGmJ1PD23VdJFhbpQBcw87ClGL1eyFZEmb3dz16vY5awHSvH1gyzb2GRzD0Fd6HAZy+hXKOokFG9ljcUQ9WcjQ/2opn0cmzcFari/KQvEl/z6qLvTxM8weHbrvtMaBZuggwUVvzkm3SFiWFZEcm4By9hU90p+7ajOzpfwLc/K28akUWwmL5qBQV/nfFC3h/P4sKhGAEV3o4VLJ56atMo3bdx3cggNLzUvRqRETD770E73FXDjnjACyQzQoS9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHDhsMWGADGRMsqH6P1q/BMpkUrQxlcmqMei6VRN/YI=;
 b=SQFUWHdTspu27uYKSZ3U8BDeRZsw+9QVtL5QVaJEDtIX/gmXQfjp6wTGtM/TEWZvY3QGsU5yLt3/4SRfuD9sDjQ202UdDEnNLJioSfREBVue1r1F/dBWCCrRdAmGIM7PgJawRf1sLTXJHn/nO9GvXrjOW0gKc3Xfv7DiHmy9OO0=
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:20:13 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::87) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/43] drm/amd/display: Fix USBC link creation
Date: Wed, 25 May 2022 12:19:13 -0400
Message-ID: <20220525161941.2544055-15-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07418640-5993-4dbf-fcd8-08da3e6a727e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4279AD6E7BBE9A8DC8BE26D5F7D69@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk77p/K7ruFMQuQ9cNHXS0lDmJwZKD/i5elQjhey3FAyCVxPuB1OiRh268nwRg/NAjmF/dQLraweqsENIV3on3xfd/Wg4JzYLtEPmmEHKeZqAyE8bTd0N9pTv2ZQBhvFMh8d+QVPpMzzrEPB25JuHYZXXry4Ki5KkZs8tytCjG7EkfijLwOnoXWa68l8ze/j9014Y5FieAdROk7P7YAPXeYN7H+YdfwmhYZDSyzyYnUNNOfawC8t+jKbUHcmS7PuZVF3YqwP03Rkje4cJQ2zXkY3saGe7DZHKAJvSW7LtP61p10sL7yOYx0ET0HqIn8MGqhb1RnG+C1WMnsZrVRuiYTNRaiSy3wlhZKleQv6oGWpoyrycYPWQ32NBkYprWkj+pw0jbIWbS1WoDsHVWcPjYRV7uXDROmv0CS1gAR3eVl9cr1BwOws17n8QHrDPfWz8uSCtQL+VhU/AUmcaNhKj52nnX379Vr7FFoRe5qTG6puB9MBJ7mNMAuGVME/RuyP72B+5+7XNnR0LTvdvaNn+vmIZGHAe9gSE7mgJ7457E7RrQtJnQOsOv7VFc5GOuzUqlx1spXW7z4/V0v7J1EcOkzw7vXKH58P/8pAkHsDClT5i11UmtKZ0ispCHPbYvyBBzc+BG/PyzXK5b4Oy3MJ2t+ocnIFajrkGEAkP8+AtE67EjyNxHc7rAxDiWriIbNaQDE3nsY5c+F2By3Gr0N+9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(54906003)(5660300002)(6916009)(7696005)(40460700003)(26005)(82310400005)(16526019)(83380400001)(2616005)(6666004)(426003)(2906002)(36756003)(316002)(47076005)(336012)(186003)(4326008)(70586007)(70206006)(30864003)(81166007)(8676002)(36860700001)(356005)(8936002)(1076003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:13.3633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07418640-5993-4dbf-fcd8-08da3e6a727e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Description]

Add USBC connector ID to align with new VBIOS parsing.

Add seperate DCN321 link encoder due to different PHY version affecting
DP ALT related registers.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |   1 +
 .../drm/amd/display/dc/bios/command_table.c   |   4 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   6 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   3 +
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  15 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  20 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   2 +-
 .../dc/dcn321/dcn321_dio_link_encoder.c       | 199 ++++++++++++++++++
 .../dc/dcn321/dcn321_dio_link_encoder.h       |  42 ++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
 .../amd/display/include/bios_parser_types.h   |   3 +-
 12 files changed, 292 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index bbc0a5769e88..3540b46765fb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3224,6 +3224,7 @@ static enum bp_result update_slot_layout_info_v2(
 		break;
 
 	case CONNECTOR_ID_DISPLAY_PORT:
+	case CONNECTOR_ID_USBC:
 		if (record->mini_type == MINI_TYPE_NORMAL) {
 			slot_layout_info->connectors[i].connector_type = CONNECTOR_LAYOUT_TYPE_DP;
 			slot_layout_info->connectors[i].length = CONNECTOR_SIZE_DP;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 32efa92422e8..818a529cacc3 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -522,8 +522,8 @@ static enum bp_result transmitter_control_v2(
 		 */
 		params.acConfig.ucEncoderSel = 1;
 
-	if (CONNECTOR_ID_DISPLAY_PORT == connector_id
-		|| CONNECTOR_ID_USBC == connector_id)
+	if (CONNECTOR_ID_DISPLAY_PORT == connector_id ||
+	    CONNECTOR_ID_USBC == connector_id)
 		/* Bit4: DP connector flag
 		 * =0 connector is none-DP connector
 		 * =1 connector is DP connector
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index 663aac0a164a..773380ef4997 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -167,6 +167,7 @@ struct dcn10_link_enc_registers {
 	uint32_t DIO_LINKD_CNTL;
 	uint32_t DIO_LINKE_CNTL;
 	uint32_t DIO_LINKF_CNTL;
+	uint32_t DIG_FIFO_CTRL0;
 };
 
 #define LE_SF(reg_name, field_name, post_fix)\
@@ -472,11 +473,15 @@ struct dcn10_link_enc_registers {
 	type HPO_DP_ENC_SEL;\
 	type HPO_HDMI_ENC_SEL
 
+#define DCN32_LINK_ENCODER_REG_FIELD_LIST(type) \
+	type DIG_FIFO_OUTPUT_PIXEL_MODE
+
 struct dcn10_link_enc_shift {
 	DCN_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
+	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 };
 
 struct dcn10_link_enc_mask {
@@ -484,6 +489,7 @@ struct dcn10_link_enc_mask {
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
+	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 };
 
 struct dcn10_link_encoder {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index fa6ff540e8f2..f659aaab792e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -660,6 +660,9 @@ void enc1_stream_encoder_send_immediate_sdp_message(
 void enc1_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc);
 
+void enc1_stream_encoder_reset_fifo(
+	struct stream_encoder *enc);
+
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index 7170a9aa82a4..d6855d4f749b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -33,6 +33,7 @@
 #include "stream_encoder.h"
 #include "i2caux_interface.h"
 #include "dc_bios_types.h"
+#include "link_enc_cfg.h"
 
 #include "gpio_service_interface.h"
 
@@ -125,7 +126,7 @@ bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 
 	if (enc->features.flags.bits.DP_IS_USB_C) {
 		/* if value == 1 alt mode is disabled, otherwise it is enabled */
-		//REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+		REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
 		is_usb_c_alt_mode = (dp_alt_mode_disable == 0);
 	}
 
@@ -142,13 +143,19 @@ void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 
 	/* in usb c dp2 mode, max lane count is 2 */
 	if (enc->funcs->is_in_alt_mode && enc->funcs->is_in_alt_mode(enc)) {
-//		REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
+		REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
 		if (!is_in_usb_c_dp4_mode)
 			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
 	}
 
 }
 
+void enc32_set_dig_output_mode(struct link_encoder *enc, uint8_t pix_per_container)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, pix_per_container);
+}
+ 
 static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -179,6 +186,7 @@ static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.set_dig_output_mode = enc32_set_dig_output_mode,
 };
 
 void dcn32_link_encoder_construct(
@@ -203,6 +211,9 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
index e880b76d5f25..749a1e8cb811 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
@@ -26,7 +26,15 @@
 #ifndef __DC_LINK_ENCODER__DCN32_H__
 #define __DC_LINK_ENCODER__DCN32_H__
 
-#include "dcn30/dcn30_dio_link_encoder.h"
+#include "dcn31/dcn31_dio_link_encoder.h"
+
+#define LE_DCN32_REG_LIST(id)\
+	LE_DCN31_REG_LIST(id),\
+	SRI(DIG_FIFO_CTRL0, DIG, id)
+
+#define LINK_ENCODER_MASK_SH_LIST_DCN32(mask_sh) \
+	LINK_ENCODER_MASK_SH_LIST_DCN31(mask_sh),\
+	LE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh)
 
 void dcn32_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
@@ -38,5 +46,15 @@ void dcn32_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask);
 
+void enc32_hw_init(struct link_encoder *enc);
+
+void dcn32_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source);
+
+void enc32_set_dig_output_mode(
+		struct link_encoder *enc,
+		uint8_t pix_per_container);
 
 #endif /* __DC_LINK_ENCODER__DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
index 99515cb3ed31..9b61d08700ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn321.
 
-DCN321 = dcn321_resource.o
+DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
 
 CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
new file mode 100644
index 000000000000..49682a31ecbd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+
+
+#include "reg_helper.h"
+
+#include "core_types.h"
+#include "link_encoder.h"
+#include "dcn321_dio_link_encoder.h"
+#include "dcn31/dcn31_dio_link_encoder.h"
+#include "stream_encoder.h"
+#include "i2caux_interface.h"
+#include "dc_bios_types.h"
+
+#include "gpio_service_interface.h"
+
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+
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
+
+#define AUX_REG(reg)\
+	(enc10->aux_regs->reg)
+
+#define AUX_REG_READ(reg_name) \
+		dm_read_reg(CTX, AUX_REG(reg_name))
+
+#define AUX_REG_WRITE(reg_name, val) \
+			dm_write_reg(CTX, AUX_REG(reg_name), val)
+
+static const struct link_encoder_funcs dcn321_link_enc_funcs = {
+	.read_state = link_enc2_read_state,
+	.validate_output_with_stream =
+			dcn30_link_encoder_validate_output_with_stream,
+	.hw_init = enc32_hw_init,
+	.setup = dcn10_link_encoder_setup,
+	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
+	.enable_dp_output = dcn32_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dcn10_link_encoder_enable_dp_mst_output,
+	.disable_output = dcn10_link_encoder_disable_output,
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
+	.is_dig_enabled = dcn10_is_dig_enabled,
+	.destroy = dcn10_link_encoder_destroy,
+	.fec_set_enable = enc2_fec_set_enable,
+	.fec_set_ready = enc2_fec_set_ready,
+	.fec_is_active = enc2_fec_is_active,
+	.get_dig_frontend = dcn10_get_dig_frontend,
+	.get_dig_mode = dcn10_get_dig_mode,
+	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
+	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.set_dig_output_mode = enc32_set_dig_output_mode,
+};
+
+void dcn321_link_encoder_construct(
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
+	enc10->base.funcs = &dcn321_link_enc_funcs;
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
+		FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
+		enc10->base.features.flags.bits.
+			DP_SINK_DETECT_POLL_DATA_PIN = true;*/
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
+	/* default to one to mirror Windows behavior */
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
+	} else {
+		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
+				__func__,
+				result);
+	}
+	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
+		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h
new file mode 100644
index 000000000000..2205f39b0a24
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
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
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_LINK_ENCODER__DCN321_H__
+#define __DC_LINK_ENCODER__DCN321_H__
+
+#include "dcn32/dcn32_dio_link_encoder.h"
+
+void dcn321_link_encoder_construct(
+	struct dcn20_link_encoder *enc20,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_aux_registers *aux_regs,
+	const struct dcn10_link_enc_hpd_registers *hpd_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask);
+
+
+#endif /* __DC_LINK_ENCODER__DCN321_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 6bc477a212b0..4db2cdf7c9e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -62,6 +62,7 @@
 #include "dcn31/dcn31_apg.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn32/dcn32_dio_link_encoder.h"
+#include "dcn321_dio_link_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
@@ -1253,7 +1254,7 @@ static struct link_encoder *dcn321_link_encoder_create(
 	if (!enc20)
 		return NULL;
 
-	dcn32_link_encoder_construct(enc20,
+	dcn321_link_encoder_construct(enc20,
 			enc_init_data,
 			&link_enc_feature,
 			&link_enc_regs[enc_init_data->transmitter],
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 2013a70603ae..d8433c679201 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -200,6 +200,8 @@ struct link_encoder_funcs {
 		struct link_encoder *enc,
 		enum encoder_type_select sel,
 		uint32_t hpo_inst);
+	void (*set_dig_output_mode)(
+			struct link_encoder *enc, uint8_t pix_per_container);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 83058bcbb2e8..812377d9e48f 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -342,7 +342,8 @@ struct bp_connector_speed_cap_info {
 	uint32_t DP_UHBR10_EN:1;
 	uint32_t DP_UHBR13_5_EN:1;
 	uint32_t DP_UHBR20_EN:1;
-	uint32_t RESERVED:29;
+	uint32_t DP_IS_USB_C:1;
+	uint32_t RESERVED:28;
 };
 
 #endif /*__DAL_BIOS_PARSER_TYPES_H__ */
-- 
2.35.3

