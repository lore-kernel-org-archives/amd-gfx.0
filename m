Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E8C4320A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7237460F11
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7237460F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066776E067;
	Mon, 16 Aug 2021 21:05:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4199F6E067
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 21:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aio2bgXXNai7WPBXTsWrKYqHPcQJ8yIqtjlM6lPftsoVqJDbTvYuxT83JWAv4wlesbNKk5FFf6ye33gL0C2lRhc1aGXZOv0RrE2s1nrOYA272feif7oPuymL9w5N77n0+BZRdZnPaivpZJoE2k5p+fidQ6WlmbcSEutJfzB1h9IsS4Uu/xMldk0/cXEvG4KPGomb0thE8jQzp/QvJVBRNy63rBB4eEsSv7MVzQGv/4bwfnMjEXRSPjQ6sPmBc7bi1heDIHWv5NirBNVsj8wjNHq0oBWwxxTRrVv59rsFWtnemfleiu6XadPKMpLzofE2oaI02Xi+7Kj+CiYd6MkQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgQCQuw2foRWVWXj56BVm9mGXgq/iN1bXm7YEJHasNg=;
 b=H/eoJpnekJYuyWUa//QyJ2en6R39+QJbnWIcHsjGbBth/q0Eo6gxaID1XglNSVxQTldr99PsUuouSUc2cQHPKDceKreC/et8O6qcgEibYGm2CrRsqmbvTJ9BthvhknQfFfoEMSvm0UaVJ0Lw37IET1p4ZanQ+mu2N9XhtLINBx49wWlOPYN1+gZGATH99/+wJtueIroAbUdrDS56KKuuF2vh3iQgANAo0cSPn5NFLFutOZ0xzeCBimcOO2ULWPipjuouQu29sjSTt5/r4jHaNy6i/CfUhGzQQv4DWVeu8xLZMhI7ZxPEf/Emrx/NG3LDq3HUAj3wyc2wg7IFrgW6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgQCQuw2foRWVWXj56BVm9mGXgq/iN1bXm7YEJHasNg=;
 b=tLznKJvAgtVcQjdiVFBrZGVnzT+MxtWOjcHDJIBIjr3AdZJdEhWesI3x1grv2JGk3y0FuXg9G8dglSwQpkqCsyv8oYEbksPz0WmMeUYjjSqrZU4ARQF3huId92urZINDgtI/U4HKaALd/Tsgzhj3xU+eMEe6uzf48HDlCwEMrYs=
Received: from MWHPR04CA0041.namprd04.prod.outlook.com (2603:10b6:300:ee::27)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 21:05:21 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::ec) by MWHPR04CA0041.outlook.office365.com
 (2603:10b6:300:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Mon, 16 Aug 2021 21:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 21:05:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 16:05:20 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 16 Aug 2021 16:05:19 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 5/6] drm/amd/display: Add DP 2.0 BIOS and DMUB Support
Date: Mon, 16 Aug 2021 16:59:18 -0400
Message-ID: <20210816205919.614691-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816205919.614691-1-Jerry.Zuo@amd.com>
References: <20210816205919.614691-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 949eb61d-ab15-4e2b-03f0-08d960f98f28
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009A24A0E08D69081ADC53CE5FD9@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0pP/S8Q5FWDeKDV0VBGK5kmpxo1O5VsmARRlVnsQn2W8CzMKRjnWpls+WvAm6k9DMhRjd4OaFOYjdAVFhIVTq1m1SrZ2ZZhz0HG6hyXROXqI/EsCNpcEyEgs/A41pHq7X/cL3Ihgk46DsG0Im37g0GG4eSdKB5VTJ22M2U9sv3d55ISnwai9XXiL75sGs4f+YU07RYdadb+CO1M1q9s9aVVs3JrgN6kLR6puvM1bun5wgGnbfO53exrqH2S4JQuu41o1wyCjOjlU0JhUyHT0dSx5NWqRyhqgQc7yWCE2AJrXJS1j4BQqfh+chChKPK3BxqS487SHwpLC7kbRg3/Bmyc5IwpCIDRjmJUNjCao1dUaYi84BgtZbqZhhlAUYgASmyUoMhVHsn+IJ0pbYNg8Ol41lquRqNBIaYZ/8dcTTlITM0bu1Ww7V9KxSgbHkjrJtICimbr8XxrJV5Fp28XHWd6hlIZjiw0XB9E1nkxa5HNc3rlKMf4zTDBDPU06eu/PVe9r7OHmIunUJar9ZmS7VWC0zmkbZ0IMWKJA2fc6nH+AcR1EqwqgILglqQjHyJJ32b5Y2n+cYOolgGVxAkX0P8Hg6J4/XuRVNqhHlWm4TlkroqKYcprTlFA6URU801jyRZ18QD8Q4dngsG6rFCGUjNoc/+/ejxbPfRhWGRmc3BEv9gyF8KOMN+ZXYc4I8gqr9E0PUVSPathCvVCfBmemNmj9AvYH1f5z42H3dM9s2ksLwLYO6oPhdHbajpVpGXiPSQBNzs4uhG1tLFyIUFxkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(1076003)(70206006)(34020700004)(7696005)(110136005)(70586007)(54906003)(356005)(316002)(82310400003)(5660300002)(478600001)(36756003)(2616005)(8936002)(2906002)(36860700001)(86362001)(6636002)(426003)(26005)(186003)(81166007)(47076005)(83380400001)(8676002)(4326008)(336012)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 21:05:21.2964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 949eb61d-ab15-4e2b-03f0-08d960f98f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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

Parse DP2 encoder caps and hpo instance from bios

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c      | 6 ++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h      | 4 ++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h           | 2 +-
 drivers/gpu/drm/amd/display/include/bios_parser_types.h   | 6 ++++++
 drivers/gpu/drm/amd/include/atomfirmware.h                | 4 ++++
 7 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6dbde74c1e06..3cabcd13f71c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1604,6 +1604,14 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 			ATOM_ENCODER_CAP_RECORD_HBR3_EN) ? 1 : 0;
 	info->HDMI_6GB_EN = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN) ? 1 : 0;
+	info->IS_DP2_CAPABLE = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_DP2) ? 1 : 0;
+	info->DP_UHBR10_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR10_EN) ? 1 : 0;
+	info->DP_UHBR13_5_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN) ? 1 : 0;
+	info->DP_UHBR20_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR20_EN) ? 1 : 0;
 	info->DP_IS_USB_C = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_USB_C_TYPE) ? 1 : 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index f1f672a997d7..29197a943aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -340,6 +340,11 @@ static enum bp_result transmitter_control_v1_7(
 	const struct command_table_helper *cmd = bp->cmd_helper;
 	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {0};
 
+	uint8_t hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_0;
+
+	if (dc_is_dp_signal(cntl->signal))
+		hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_DP_0;
+
 	dig_v1_7.phyid = cmd->phy_id_to_atom(cntl->transmitter);
 	dig_v1_7.action = (uint8_t)cntl->action;
 
@@ -353,6 +358,7 @@ static enum bp_result transmitter_control_v1_7(
 	dig_v1_7.hpdsel = cmd->hpd_sel_to_atom(cntl->hpd_sel);
 	dig_v1_7.digfe_sel = cmd->dig_encoder_sel_to_atom(cntl->engine_id);
 	dig_v1_7.connobj_id = (uint8_t)cntl->connector_obj_id.id;
+	dig_v1_7.HPO_instance = hpo_instance;
 	dig_v1_7.symclk_units.symclk_10khz = cntl->pixel_clock/10;
 
 	if (cntl->action == TRANSMITTER_CONTROL_ENABLE ||
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
index 46ea39f5ef8d..6f3c2fb60790 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
@@ -192,6 +192,10 @@ void dcn30_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+		enc10->base.features.flags.bits.IS_DP2_CAPABLE = bp_cap_info.IS_DP2_CAPABLE;
+		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
+		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
+		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
 		enc10->base.features.flags.bits.DP_IS_USB_C =
 				bp_cap_info.DP_IS_USB_C;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 58db885e4d12..67b911b6d273 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -59,6 +59,10 @@ struct encoder_feature_support {
 			uint32_t IS_TPS3_CAPABLE:1;
 			uint32_t IS_TPS4_CAPABLE:1;
 			uint32_t HDMI_6GB_EN:1;
+			uint32_t IS_DP2_CAPABLE:1;
+			uint32_t IS_UHBR10_CAPABLE:1;
+			uint32_t IS_UHBR13_5_CAPABLE:1;
+			uint32_t IS_UHBR20_CAPABLE:1;
 			uint32_t DP_IS_USB_C:1;
 		} bits;
 		uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5950da7bf252..0edc72ce2bb0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -959,7 +959,7 @@ struct dmub_dig_transmitter_control_data_v1_7 {
 	uint8_t hpdsel; /**< =1: HPD1, =2: HPD2, ..., =6: HPD6, =0: HPD is not assigned */
 	uint8_t digfe_sel; /**< DIG front-end selection, bit0 means DIG0 FE is enabled */
 	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
-	uint8_t reserved0; /**< For future use */
+	uint8_t HPO_instance; /**< HPO instance (0: inst0, 1: inst1) */
 	uint8_t reserved1; /**< For future use */
 	uint8_t reserved2[3]; /**< For future use */
 	uint32_t reserved3[11]; /**< For future use */
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 76a87b682883..cf4027cc3f4c 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -152,6 +152,8 @@ struct bp_transmitter_control {
 	enum signal_type signal;
 	enum dc_color_depth color_depth; /* not used for DCE6.0 */
 	enum hpd_source_id hpd_sel; /* ucHPDSel, used for DCe6.0 */
+	enum tx_ffe_id txffe_sel; /* used for DCN3 */
+	enum engine_id hpo_engine_id; /* used for DCN3 */
 	struct graphics_object_id connector_obj_id;
 	/* symClock; in 10kHz, pixel clock, in HDMI deep color mode, it should
 	 * be pixel clock * deep_color_ratio (in KHz)
@@ -319,6 +321,10 @@ struct bp_encoder_cap_info {
 	uint32_t DP_HBR2_EN:1;
 	uint32_t DP_HBR3_EN:1;
 	uint32_t HDMI_6GB_EN:1;
+	uint32_t IS_DP2_CAPABLE:1;
+	uint32_t DP_UHBR10_EN:1;
+	uint32_t DP_UHBR13_5_EN:1;
+	uint32_t DP_UHBR20_EN:1;
 	uint32_t DP_IS_USB_C:1;
 	uint32_t RESERVED:27;
 };
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 44955458fe38..7bd763361d6e 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -768,6 +768,10 @@ enum atom_encoder_caps_def
   ATOM_ENCODER_CAP_RECORD_HBR2_EN               =0x02,         // DP1.2 HBR2 setting is qualified and HBR2 can be enabled 
   ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN          =0x04,         // HDMI2.0 6Gbps enable or not. 
   ATOM_ENCODER_CAP_RECORD_HBR3_EN               =0x08,         // DP1.3 HBR3 is supported by board. 
+  ATOM_ENCODER_CAP_RECORD_DP2                   =0x10,         // DP2 is supported by ASIC/board.
+  ATOM_ENCODER_CAP_RECORD_UHBR10_EN             =0x20,         // DP2.0 UHBR10 settings is supported by board
+  ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN           =0x40,         // DP2.0 UHBR13.5 settings is supported by board
+  ATOM_ENCODER_CAP_RECORD_UHBR20_EN             =0x80,         // DP2.0 UHBR20 settings is supported by board
   ATOM_ENCODER_CAP_RECORD_USB_C_TYPE            =0x100,        // the DP connector is a USB-C type.
 };
 
-- 
2.25.1

