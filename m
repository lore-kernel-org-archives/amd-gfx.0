Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C02C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE33B60F38
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE33B60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2616E212;
	Tue, 17 Aug 2021 17:20:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA636E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 17:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ase37Iaxj0njr5yaGekClpQES/yaBeWgmVO5fT/uptgMOGmc2plYR+uhD7/wMgkSdDcCGXxRt0xUrs72kJUPt63LHwMZtzCf06rc+XRprmxbLIg4cHtxF5bqDCTk8UOFWPIXtDq1Mo/M/+Qil6YX4BKgnsY9o5tvCPdo/UTpN9F77KrZcqhLviILkv7YOTVx8+iVmcNwrZnpEXVcOlfRA8zdr1WbmR5pidHbDTlWVUBvYUPqBdS/tiQgzGwzhOflEy9JVmWezIagGh7lY4GkSiGBM53GRWzrxTNlcz0X68dyDHdYdl80ecZ5R9wB5O/hsdEeLM51k1v09i+8dxktwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgQCQuw2foRWVWXj56BVm9mGXgq/iN1bXm7YEJHasNg=;
 b=WdCg8QglG96c+8OV4MWh4tZYyLEwimAmn6MW6zLHgN2rF6fY+Tsydpg0PZJruu/g0Uli6A1wOnim8nUOk9fJfKASgo40iPfKaLJwy5wuprNtmDiVyUcx1T9Q28/7z4qFDDqW5wqjXOJIlrtN/7vJTNt2bPmVB8FMxFNtEwANa8jp1TE0EFTeR7rLV4h3mTgJ/DmeB9yZV/bVRgVkomUAqFiPzF6RZHZfA3+KFVjTQ/t6MmWDXIhzzFJRscqVXr0D6AwSKVWXqeZYPxl0dX4QFXzYNIw0LMsqoMhGEo4zWTBYWr0ZFtghpMp7elzWhsPM3XgMadCCYtxVnOJMrOj5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgQCQuw2foRWVWXj56BVm9mGXgq/iN1bXm7YEJHasNg=;
 b=FBXv58pPV86c6R09OgLhHJLFJcF26wRc/9hLs0E/2CzCoIuSrbAO2qi3DnqklgF/67zkFaNWUC8q6CBnwlOJU2Q3KRSqzm5PIKEf4jm6RbK6xjD7uCETyA/M9b438mocRROrE0ztzpy1Ki4cqKirEPvt1Or1WP1F8o2ayHW3UTI=
Received: from DM3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:0:50::18) by
 CY4PR1201MB0152.namprd12.prod.outlook.com (2603:10b6:910:1b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 17:20:51 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::97) by DM3PR03CA0008.outlook.office365.com
 (2603:10b6:0:50::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 17 Aug 2021 17:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 17:20:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:50 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 12:20:48 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v2 5/6] drm/amd/display: Add DP 2.0 BIOS and DMUB Support
Date: Tue, 17 Aug 2021 13:20:05 -0400
Message-ID: <20210817172006.777655-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817172006.777655-1-Jerry.Zuo@amd.com>
References: <20210817172006.777655-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d15bce2-e086-4f88-1ed8-08d961a35c9e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0152:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01522162DFED10E352ACDC33E5FE9@CY4PR1201MB0152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGZUxuFP2QqhAIomWTfibQZh6TVVhV2t53HJ4B267MxWXLxo4j5KxrR1lwz6GE32IC/AeRdbAbIkDpY5a/522S+w21JMOIZIZEUvlA8GowCRfd93sufuOatpnprlPGSp9gSVgI4VdNIvUT+Sji42mnqobPNqYWZJHogcAxWbtVudVLgnxPevAG75m0mTMH4HGP/Kt2qPeDgRKz8GTvIpz2J6jylm7jRlCKKakIGeZEpuuj6hLXzZaPZkDbqQ86IghRZmxosMFcl0fUspmTHy8wySQwYLHbl+IM45s2kKQDrmV4HwMwC5AnKjBlnu9TSldTsFxQpjFFioljrV3IJhYZEOf56bGr81STQ35vngzbdUvgmoGPmpcQIeNIqhuNvV8genbyv8TXwzjg9kv0YrThuowqYLqDhiXkDqTyHLUIsHR6zno3pl/3LCZGMrR8DiBd6dwbuHWpA5LH0OBRM4zgnOkgrfYGx87F9IiPYcRwnuFBiGQEKgy5TP8ZhD2McKvScrloepy23XmDVhDi/LmH0tExhlvfngtU6zi74FzKUrkGtnMb9x+EAV8hjb7rhLw0KWZPh1B0+pThBYjZJPd14nVckQQo6w4DfaESgqsWePi6bMRG5a9qlVHkklNm3tkAsqCdpNmT8eIc9eOl2r9fo6OEzwQm4ltZpinZ7Go514KDp9n8fiYPcFBrSv4AqapbnaaSqJntfloJsIVfWTlP1gzw7OlSWsfLIfMHSpx8HWiPGH3Gs8vWpDyR5wO93YdofGEBwtfHb/iX2qCtNPwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(36860700001)(26005)(316002)(186003)(36756003)(5660300002)(508600001)(86362001)(6636002)(8676002)(2616005)(8936002)(47076005)(54906003)(70586007)(336012)(7696005)(6666004)(2906002)(70206006)(356005)(81166007)(426003)(110136005)(4326008)(83380400001)(34020700004)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 17:20:51.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d15bce2-e086-4f88-1ed8-08d961a35c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0152
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

