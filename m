Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD304C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63D26109E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A63D26109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA206E9CD;
	Thu, 19 Aug 2021 18:59:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE3F6E9CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 18:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1nktywPuyk4iKGME1z83m1ZioRHNQ9Cli7f6x54gGQ+GoU5Jsslk/v/zKH5R4LYnhwEsjUbT+w0n3LSkJXa2y/0T0Bv62EpuOWIngNqh/lS32ynR28Pe/b5FWCk0r6a4m7P6H4qyRKcTsfgB1i+Q1G9e6JwKjArjCVd195aeAPNj2OYqSUG3N1vqS4QdteHkcE8iGpZSw3Vpsgfm6Ry4E5eo8E5h2U7TgriEvpg8/waFagE7p1Y6qL3MLHFo7GIDw5QHMkVotcoNKvwQJ0FWw3Z18Szmxihjy5djQL1x08BXWkrsg7AlMdppd6pjzIJARyFSq6Bi+83pSSRE0zaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vog3Yc166aDKebKMD2X9RW0RHt45PkLGJpCb3g63bGw=;
 b=KtfUeYIy5QdCEdt7qI/ByMitZJx+icIHKOBsWOLhvp6LLqLQmI3A1fzItX743eBKE/AuC3Pz50jYKUEcLxGgRHHz7KEujAslph5N0Mey0O8fKGxpKOWXq+CGTaVONT/+Z0ag5QDSonzFQESGmyPyW8nXt6pw40JG2BcitDGM1AK5uX8hCAOgdF0v/fbOwGUZxqQ58PgYf31//berq8h5PmheX8nU0b8j8WZGMJUpH+ADFWs0YrRP/wfLo3/SPpZJUEYY18NfiJbjVh27UKLHngqwcByWHUFw/y2r8axvzJAu1KfM4x26Wz9Blajetgx7tb+LKr8Gv+o2NltkIcFEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vog3Yc166aDKebKMD2X9RW0RHt45PkLGJpCb3g63bGw=;
 b=0tR8DwkfCAySD2WdLK3k+KVJ7i6afwXWcZmQhCqaV2mtu2ky9imoiXsJVHH0zOUtDNyzQKpyAR186+Y7eG2I5YujnXqhP5jr9+B4wXfrZH7tytsXgwn0EcryfGWpekji8/HMg8AyT/mQbOUsLSmApJRCCUQNURFQddx240W7bPs=
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Thu, 19 Aug
 2021 18:59:09 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::33) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 18:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:59:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 13:59:09 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 19 Aug 2021 13:59:08 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 5/6] drm/amd/display: Add DP 2.0 BIOS and DMUB Support
Date: Thu, 19 Aug 2021 14:58:39 -0400
Message-ID: <20210819185840.3682559-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
References: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 325ff4a1-073b-4a3a-69c2-08d963436d54
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26556CEBD4BDED5E0802E6C4E5C09@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjOpfT70iSwz0mH70II8T5pkBXnd/4arhuOmS0e9v+FS8mAtlWEODdB4kDfUDaIH4G9+0YZad3f8wvmPpaYomwVWpIMF4Jst9LVa+kqMB0q0ulwslS2Ij2LhGZnnqMOYRBE45FcmDj5qciWPt+yDxLEY6obwaZrzQ8i5cHFS0YsAU2vAmbh08hvFkKX1FvYx4S8RiFO7Bxqbw+OzCIvHMzuwsFcRKfwpJR77+twLJ+TBAu4I/5N8yMNNPDdrFm1CMF8CpH4xYvaB/16E+T3WNt4lL/l8n5ZC85lh6DW746SAbImJZC1mL4WdlT9DC1lljQ1DVrAgmP4UiqqeWpi6j0PubFG5FssK5OEUcKhnbapJEZAz70A9NWMsB+NzIbJisKyVm8xjovf3SOVTwevqwOfetgwpjQh4/QyKCHOnnXJOwHhmZPK6cjo7ug8M8BQJmEY7n/etbMLSsZy6eUokN4xKv4Crlg5vINnk0+/EIEvUf5AlbMAbtRqs/3W78/rEz3vqCp7O6D52EvncJklo18D18fk1cYVaRMZeLoGXFgtWNcacxKFva0kIfPytRtVLiW3/c59r8W+5QdHT/PRxg7EM4Iscb7ZHG8PjbdB+X3oqWrNqR/AWvYiB1cvk0KfQckNDryxh+C8FyPZeCb5ZVLy2nhrrw1nz45ZCt/4IQ+Rb/ZrHJ5XceJ/rTfTOv5TxzLn04C7PqIgx5+09t6A4YnnVgxgk83eA61k8+J6ryo15Oct2EcFj4duazHglxMKkCqH/TxMHyegl89P1nKQjyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(356005)(26005)(34020700004)(110136005)(81166007)(8936002)(2616005)(82740400003)(86362001)(8676002)(82310400003)(83380400001)(54906003)(426003)(316002)(336012)(36756003)(5660300002)(2906002)(47076005)(6666004)(6636002)(4326008)(7696005)(70206006)(186003)(70586007)(1076003)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:59:09.6963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325ff4a1-073b-4a3a-69c2-08d963436d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c     | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c   | 10 ++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c  |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |  6 ++++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h        |  4 ++++
 .../gpu/drm/amd/display/include/bios_parser_types.h    | 10 ++++++++++
 drivers/gpu/drm/amd/include/atomfirmware.h             |  6 ++++++
 7 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6dbde74c1e06..cdb5c027411a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1604,6 +1604,16 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 			ATOM_ENCODER_CAP_RECORD_HBR3_EN) ? 1 : 0;
 	info->HDMI_6GB_EN = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN) ? 1 : 0;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	info->IS_DP2_CAPABLE = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_DP2) ? 1 : 0;
+	info->DP_UHBR10_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR10_EN) ? 1 : 0;
+	info->DP_UHBR13_5_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN) ? 1 : 0;
+	info->DP_UHBR20_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_UHBR20_EN) ? 1 : 0;
+#endif
 	info->DP_IS_USB_C = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_USB_C_TYPE) ? 1 : 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index f1f672a997d7..6e333b4af7d6 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -340,6 +340,13 @@ static enum bp_result transmitter_control_v1_7(
 	const struct command_table_helper *cmd = bp->cmd_helper;
 	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {0};
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	uint8_t hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_0;
+
+	if (dc_is_dp_signal(cntl->signal))
+		hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_DP_0;
+#endif
+
 	dig_v1_7.phyid = cmd->phy_id_to_atom(cntl->transmitter);
 	dig_v1_7.action = (uint8_t)cntl->action;
 
@@ -353,6 +360,9 @@ static enum bp_result transmitter_control_v1_7(
 	dig_v1_7.hpdsel = cmd->hpd_sel_to_atom(cntl->hpd_sel);
 	dig_v1_7.digfe_sel = cmd->dig_encoder_sel_to_atom(cntl->engine_id);
 	dig_v1_7.connobj_id = (uint8_t)cntl->connector_obj_id.id;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	dig_v1_7.HPO_instance = hpo_instance;
+#endif
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
index fa3a725e11dc..b99efcf4712f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -59,6 +59,12 @@ struct encoder_feature_support {
 			uint32_t IS_TPS3_CAPABLE:1;
 			uint32_t IS_TPS4_CAPABLE:1;
 			uint32_t HDMI_6GB_EN:1;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+			uint32_t IS_DP2_CAPABLE:1;
+			uint32_t IS_UHBR10_CAPABLE:1;
+			uint32_t IS_UHBR13_5_CAPABLE:1;
+			uint32_t IS_UHBR20_CAPABLE:1;
+#endif
 			uint32_t DP_IS_USB_C:1;
 		} bits;
 		uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5950da7bf252..15c823c8ae93 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -959,7 +959,11 @@ struct dmub_dig_transmitter_control_data_v1_7 {
 	uint8_t hpdsel; /**< =1: HPD1, =2: HPD2, ..., =6: HPD6, =0: HPD is not assigned */
 	uint8_t digfe_sel; /**< DIG front-end selection, bit0 means DIG0 FE is enabled */
 	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	uint8_t HPO_instance; /**< HPO instance (0: inst0, 1: inst1) */
+#else
 	uint8_t reserved0; /**< For future use */
+#endif
 	uint8_t reserved1; /**< For future use */
 	uint8_t reserved2[3]; /**< For future use */
 	uint32_t reserved3[11]; /**< For future use */
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 76a87b682883..d2fb018d31d0 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -152,6 +152,10 @@ struct bp_transmitter_control {
 	enum signal_type signal;
 	enum dc_color_depth color_depth; /* not used for DCE6.0 */
 	enum hpd_source_id hpd_sel; /* ucHPDSel, used for DCe6.0 */
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	enum tx_ffe_id txffe_sel; /* used for DCN3 */
+	enum engine_id hpo_engine_id; /* used for DCN3 */
+#endif
 	struct graphics_object_id connector_obj_id;
 	/* symClock; in 10kHz, pixel clock, in HDMI deep color mode, it should
 	 * be pixel clock * deep_color_ratio (in KHz)
@@ -319,6 +323,12 @@ struct bp_encoder_cap_info {
 	uint32_t DP_HBR2_EN:1;
 	uint32_t DP_HBR3_EN:1;
 	uint32_t HDMI_6GB_EN:1;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	uint32_t IS_DP2_CAPABLE:1;
+	uint32_t DP_UHBR10_EN:1;
+	uint32_t DP_UHBR13_5_EN:1;
+	uint32_t DP_UHBR20_EN:1;
+#endif
 	uint32_t DP_IS_USB_C:1;
 	uint32_t RESERVED:27;
 };
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 44955458fe38..d4b245f12651 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -768,6 +768,12 @@ enum atom_encoder_caps_def
   ATOM_ENCODER_CAP_RECORD_HBR2_EN               =0x02,         // DP1.2 HBR2 setting is qualified and HBR2 can be enabled 
   ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN          =0x04,         // HDMI2.0 6Gbps enable or not. 
   ATOM_ENCODER_CAP_RECORD_HBR3_EN               =0x08,         // DP1.3 HBR3 is supported by board. 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+  ATOM_ENCODER_CAP_RECORD_DP2                   =0x10,         // DP2 is supported by ASIC/board.
+  ATOM_ENCODER_CAP_RECORD_UHBR10_EN             =0x20,         // DP2.0 UHBR10 settings is supported by board
+  ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN           =0x40,         // DP2.0 UHBR13.5 settings is supported by board
+  ATOM_ENCODER_CAP_RECORD_UHBR20_EN             =0x80,         // DP2.0 UHBR20 settings is supported by board
+#endif
   ATOM_ENCODER_CAP_RECORD_USB_C_TYPE            =0x100,        // the DP connector is a USB-C type.
 };
 
-- 
2.25.1

