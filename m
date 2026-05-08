Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC8CD37AC
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D042210F5B6;
	Fri,  8 May 2026 18:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtuUwYuA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E6910F5AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIzP+ingjapJ1KdpioZ75LBJ/RmpjDcQawDshOZb7dZkbeznWYwsRkj3dSIj8/kU2C/qCczx6zqm9TQpIOlnPCl5mm6thBfun1CCkYTeLhLmTJK1s+l63L6NyrUeyuAhRYFL4L8Q5Ebfb4zWS8fSImLZD+3O6drbwHYR6Dx1I5AMSmlOm9KaOvcpwpGUmLMtvSZCsr3P/re2n+E3n2hs+qeAXBOJGvhNEe0YouVt1FXRWp3rMPalggCbSn/o/IdIBhyHw5BKwaYFW2HQru7aRP/ySqwgJ4tHXUOQv0r36vZfgxX+72HaKDDMOrRHB2dxVdYeExKU1pop/HohBC2dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1y3YPNokVtKxxrjRaE1RVtcnuKMc+i411wA/G0tBGk=;
 b=p3FKnViouxunhfC4FJJnNkQMwEPlEDsCGDXkqp+7gi42Ibu8xkg73QBZzLVIEJiGk2zc5sSShuwIhOO+uzuhxvc/XwhqfblGMjPG1dLlc65udd1b6ARHM0p+Ebi4gvHnVEZ8fORrp3gPvdHSkHVTZvbykKKT0gjfL3XHlCX/uTmMPpdCQwtf3qYYbL8oqLSUZ8LaXkWZiET2EYZViD9vsjgtn2qWaNd2QflFdsavh0e2UfamUE6qgLGizt3Ma4Ny8gTPNmrPxHE5Pe68kxr1rKI9pNbYidiqZPOw17M957SgLlgCD2SPgFfP6VIxLME44WQPdAb4DvjahzgOpitEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1y3YPNokVtKxxrjRaE1RVtcnuKMc+i411wA/G0tBGk=;
 b=rtuUwYuAbIkL5+sdEUNTjlxtLDNUaH8KOCFl3Qdh8/cQi4MI8mnMf6M3Bpwwu2HD1V6Rjt9UtBWiSUwKoBNlovfPRAQQrfgM9OjFnQ6qKY1RZnad4jcKC+4TYHOHA50yxZ8w+rYsq/m/Ace5XES4OE+0u+Udyf7vPYIKTe8zUYg=
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:28:19 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::c9) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 18:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Fri, 8 May 2026 18:28:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 8 May
 2026 13:28:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 May
 2026 13:28:17 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:17 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 09/14] drm/amd/display: Add support for FRL to DC core
Date: Fri, 8 May 2026 14:28:01 -0400
Message-ID: <20260508182808.520863-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: c4312f20-99e0-40e3-69cb-08dead2f93d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003|20052099010|3023799003;
X-Microsoft-Antispam-Message-Info: 7gUYNsgjmvnAzUue/yuadg2b2ULHMkleRDRVXYk3K05xh2AJ0HbGfcxisx0KOGqD4gfoYazwHoN45pI1J2mTNXDx5bdUdjKTYfZXHDb234xjAbqe6s4JFEbbaopfc9puNqhvmnyb3zswOGcvJgFWcYTw2RVdvGIIblHSA7khcMxUHc0GnVuSW0u4I4HbLChMOsGX2EgohpjtoGjFFUrSzn+By6+R0KarMrZMhJZ4SYkumvliGZQ7nDTItqiMUBX3eR2wKVNXtgA/JD+4+KsTeBgrqhwUKWvWOcGYMXlEnnvYFuIKA9LKkRphBJrB0tLt5miGvigtHq7MkZSmJd0gWdlEfelO4gWCZVm5/Fx125MfSd5eIQHpFlVN9fk5Rn9rh2vAfzr4U09j7cp32NSeQsP1OThTO/Nh66lCFWZ6KgKMH0S+io6R2SQsOOOBMmKjixTRSPDhnZAP7pkdSSIbWxs8JkWCKkoDpPSKpO0uqp2+5gw39WXl8KYRKOk+IwpD7ufZtXutNSsnynpV5So7iE2AcjEAtg9cKs5ZaZWSD18IwxGgIhESrl21JOOvK5ckgxSfYEKNitGBV+PywCTrO68SHkbGv7r5+GHJUsbcDaBhif5MbumlKqBDlCM7NUqYStn3mVYj1s7HDIE3Z+axjVvyg5E3kT1XgRavODKjKYwmz/CuUq0m3B0GHnoFKXiXqaS5a0yYtLTpuIKy7waGWPzKmakvrz/shlBYOMovRLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003)(20052099010)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N6lJNjo0d4o3glewNN1VHwZ+3zLWkI2c7Y2Do03QQVKm5ADS7UZsyqc5/dN1V3nzcnkWG31UP7QQZkUMB5umaZzmg/1mUa6bgWhItlo/bflRysyRtRtL2rZmc4ebH4euT6fkabWiO07kYAuYm07VjbeNz03a4LPbrOSg0o5k4O31CFrdlEw+9PyOX6Fo7/mO9sJo0IoWJmKjUsoGWS8k0M+we2X5utp9Thkt5NevYe2iOFh+FsJfBQk5xCbjj6ic2VaWdKFxDkUdnBt8KhaaGubUsCSr6rn665LiIeuGvD3HVM3LClgqr5JazDkphO2FadNSVsYtsA8/A1KZ42trd7zEdFs8PmSBW8283rYcW54L9YfaPLiUzyZ5fzfbd4bw0KC+9adny9s47Okf+Gh8zr/1p5vX3WUg8h2yeSHmfMz+EtvpMm5kYh9r8RWnathg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:18.7166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4312f20-99e0-40e3-69cb-08dead2f93d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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

Here we add support for reading BIOS caps and tie FRL bits
into the rest of DC core.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  21 ++
 .../drm/amd/display/dc/bios/command_table2.c  |   6 +
 .../dce112/command_table_helper2_dce112.c     |   3 +
 .../bios/dce112/command_table_helper_dce112.c |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  26 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  36 +++
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   3 +
 .../drm/amd/display/dc/core/dc_link_exports.c |  45 ++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 233 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  35 +++
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   8 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  30 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 14 files changed, 450 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index b4dd8219b8f0..135556b8fd87 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2126,6 +2126,12 @@ static enum bp_result get_firmware_info_v3_5(
 	return BP_RESULT_OK;
 }
 
+/* TODO: Remove this temp define after atomfirmware.h is updated */
+#define ATOM_ENCODER_CAP_RECORD_HDMI_FRL_TEMP  0x200
+#define ATOM_ENCODER_CAP_RECORD_HDMI_FRL_8GbEn_TEMP 0x400        // HDMI FRL 8Gb support
+#define ATOM_ENCODER_CAP_RECORD_HDMI_FRL_10GbEn_TEMP 0x800        // HDMI FRL 10Gb support
+#define ATOM_ENCODER_CAP_RECORD_HDMI_FRL_12GbEn_TEMP 0x1000       // HDMI FRL 12Gb support
+
 static enum bp_result bios_parser_get_encoder_cap_info(
 	struct dc_bios *dcb,
 	struct graphics_object_id object_id,
@@ -2173,6 +2179,15 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 	info->DP_IS_USB_C = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_USB_C_TYPE) ? 1 : 0;
 	DC_LOG_BIOS("\t info->DP_IS_USB_C %d", info->DP_IS_USB_C);
+	info->IS_HDMI_FRL_CAPABLE = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_HDMI_FRL_TEMP) ? 1 : 0;
+	info->FRL_8G_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_HDMI_FRL_8GbEn_TEMP) ? 1 : 0;
+	info->FRL_10G_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_HDMI_FRL_10GbEn_TEMP) ? 1 : 0;
+	info->FRL_12G_EN = (record->encodercaps &
+			ATOM_ENCODER_CAP_RECORD_HDMI_FRL_12GbEn_TEMP) ? 1 : 0;
+	DC_LOG_BIOS("\t info->IS_HDMI_FRL_CAPABLE %d\n", info->IS_HDMI_FRL_CAPABLE);
 
 	return BP_RESULT_OK;
 }
@@ -2401,6 +2416,12 @@ static enum bp_result bios_parser_get_connector_speed_cap_info(
 	info->DP_UHBR10_EN = (record->connector_max_speed >= 10000) ? 1 : 0;
 	info->DP_UHBR13_5_EN = (record->connector_max_speed >= 13500) ? 1 : 0;
 	info->DP_UHBR20_EN = (record->connector_max_speed >= 20000) ? 1 : 0;
+	info->FRL_8G_EN = (record->connector_max_speed >= 8000) ? 1 : 0;
+	info->FRL_10G_EN = (record->connector_max_speed >= 10000) ? 1 : 0;
+	info->FRL_12G_EN = (record->connector_max_speed >= 12000) ? 1 : 0;
+	info->FRL_16G_EN = (record->connector_max_speed >= 16000) ? 1 : 0;
+	info->FRL_20G_EN = (record->connector_max_speed >= 20000) ? 1 : 0;
+	info->FRL_24G_EN = (record->connector_max_speed >= 24000) ? 1 : 0;
 	return BP_RESULT_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 88625daf5378..5bca5e534277 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -371,6 +371,10 @@ static enum bp_result transmitter_control_v1_7(
 	if (cntl->action == TRANSMITTER_CONTROL_ENABLE ||
 		cntl->action == TRANSMITTER_CONTROL_ACTIAVATE ||
 		cntl->action == TRANSMITTER_CONTROL_DEACTIVATE) {
+		if (dc_is_hdmi_frl_signal(cntl->signal))
+			DC_LOG_BIOS("%s:dig_v1_7.symclk_units.symclk_Hz = %d\n",
+			__func__, dig_v1_7.symclk_units.symclk_Hz);
+		else
 			DC_LOG_BIOS("%s:dig_v1_7.symclk_units.symclk_10khz = %d\n",
 			__func__, dig_v1_7.symclk_units.symclk_10khz);
 	}
@@ -395,6 +399,8 @@ static enum bp_result transmitter_control_v1_7(
 				process_phy_transition_init_params.sym_clock_10khz          = dig_v1_7.symclk_units.symclk_10khz;
 				process_phy_transition_init_params.display_port_link_rate   = link->cur_link_settings.link_rate;
 				process_phy_transition_init_params.transition_bitmask       = link->phy_transition_bitmask;
+				process_phy_transition_init_params.hdmi_frl_num_lanes       = link->frl_link_settings.frl_num_lanes;
+				process_phy_transition_init_params.hdmi_frl_link_rate       = link->frl_link_settings.frl_link_rate;
 			}
 			dig_v1_7.skip_phy_ssc_reduction = link->wa_flags.skip_phy_ssc_reduction;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
index 478465fba224..642bc52dcc40 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
@@ -49,6 +49,9 @@ static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 	case SIGNAL_TYPE_HDMI_TYPE_A:
 		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_HDMI;
 		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		atom_dig_mode = 4;
+		break;
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP_MST;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
index 6b8a87f2c49e..41d11d8410a0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
@@ -47,6 +47,9 @@ static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 	case SIGNAL_TYPE_HDMI_TYPE_A:
 		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_HDMI;
 		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		atom_dig_mode = 4;
+		break;
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP_MST;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad927e63c207..0448130fa6ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3893,17 +3893,20 @@ static void add_update_info_frame_sequence(
 {
 	bool is_hdmi_tmds;
 	bool is_dp;
+	bool is_hdmi_frl;
 
 	if (!pipe_ctx || !pipe_ctx->stream)
 		return;
 
-	if (pipe_ctx->stream_res.stream_enc == NULL)
+	if (pipe_ctx->stream_res.stream_enc == NULL &&
+			pipe_ctx->stream_res.hpo_frl_stream_enc == NULL)
 		return;
 
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
 	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
-	if (!is_hdmi_tmds && !is_dp)
+	is_hdmi_frl = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal);
+	if (!is_hdmi_tmds && !is_dp && !is_hdmi_frl)
 		return;
 
 	if (is_hdmi_tmds) {
@@ -3911,6 +3914,11 @@ static void add_update_info_frame_sequence(
 		return;
 	}
 
+	if (is_hdmi_frl) {
+		hwss_add_hpo_frl_stream_enc_update_hdmi_info_packets(seq_state, pipe_ctx);
+		return;
+	}
+
 	if (is_dp) {
 		if (dp_is_128b_132b_signal(pipe_ctx)) {
 			hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(seq_state, pipe_ctx);
@@ -7442,6 +7450,20 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 			state->dccg.symclk32_le_enable[i] = 0; /* Default: disabled */
 		}
 
+		/* Check for active HPO usage that affects symclk32_le */
+		for (unsigned int pipe_idx = 0; pipe_idx < MAX_PIPES && pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+			struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[pipe_idx];
+			if (!pipe_ctx->stream)
+				continue;
+
+			/* HPO FRL (HDMI FRL) streams use symclk32_le */
+			if (pipe_ctx->stream_res.hpo_frl_stream_enc && pipe_ctx->link_res.hpo_frl_link_enc) {
+				int hpo_le_inst = pipe_ctx->link_res.hpo_frl_link_enc->inst;
+				if (hpo_le_inst >= 0 && hpo_le_inst < 2) {
+					state->dccg.symclk32_le_enable[hpo_le_inst] = 1;
+				}
+			}
+		}
 	}
 
 	/* Capture essential DSC configuration for underflow analysis */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index bbce751b485f..deb7f419e26c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -250,6 +250,10 @@ char *dc_status_to_str(enum dc_status status)
 		return "No DSC resource";
 	case DC_FAIL_UNSUPPORTED_1:
 		return "Unsupported";
+	case DC_FAIL_HDMI_FRL_LINK_TRAINING:
+		return "HDMI frl link training failure";
+	case DC_NO_HDMI_FRL_LINK_BANDWIDTH:
+		return "No DHMI frl link bandwidth";
 	case DC_FAIL_CLK_EXCEED_MAX:
 		return "Clk exceed max failure";
 	case DC_FAIL_CLK_BELOW_MIN:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index b3a5935e3811..c0c35d6653a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1615,6 +1615,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case STREAM_ENC_UPDATE_HDMI_INFO_PACKETS:
 			hwss_stream_enc_update_hdmi_info_packets(params);
 			break;
+		case HPO_FRL_STREAM_ENC_UPDATE_HDMI_INFO_PACKETS:
+			hwss_hpo_frl_stream_enc_update_hdmi_info_packets(params);
+			break;
 		case HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM:
 			hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(params);
 			break;
@@ -3642,6 +3645,15 @@ void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *param
 			&params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.encoder_info_frame);
 }
 
+void hwss_hpo_frl_stream_enc_update_hdmi_info_packets(union block_sequence_params *params)
+{
+	if (params->hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.hpo_frl_stream_enc &&
+	    params->hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->update_hdmi_info_packets)
+		params->hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->update_hdmi_info_packets(
+			params->hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.hpo_frl_stream_enc,
+			&params->hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
 void hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params)
 {
 	if (params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.hpo_dp_stream_enc &&
@@ -4865,6 +4877,16 @@ void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *s
 	}
 }
 
+void hwss_add_hpo_frl_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HPO_FRL_STREAM_ENC_UPDATE_HDMI_INFO_PACKETS;
+		seq_state->steps[*seq_state->num_steps].params.hpo_frl_stream_enc_update_hdmi_info_packets_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
@@ -4963,6 +4985,20 @@ void hwss_add_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state
 	}
 }
 
+void hwss_add_hpo_frl_stream_enc_set_dsc_config(struct block_sequence_state *seq_state,
+		struct hpo_frl_stream_encoder *hpo_frl_stream_enc,
+		const struct dc_crtc_timing *timing,
+		uint8_t *dsc_packed_pps)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HPO_FRL_STREAM_ENC_SET_DSC_CONFIG;
+		seq_state->steps[*seq_state->num_steps].params.hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc = hpo_frl_stream_enc;
+		seq_state->steps[*seq_state->num_steps].params.hpo_frl_stream_enc_set_dsc_config_params.timing = timing;
+		seq_state->steps[*seq_state->num_steps].params.hpo_frl_stream_enc_set_dsc_config_params.dsc_packed_pps = dsc_packed_pps;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index deb23d20bca6..6c3d442587a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -45,6 +45,9 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 			 */
 			if (link_enc && ((uint32_t)stream->link->connector_signal & link_enc->output_signals)) {
 				is_dig_stream = true;
+				/* If stream is HDMI FRL, then it is not a DIG stream. */
+				if (dc_is_hdmi_frl_signal(stream->signal))
+					is_dig_stream = false;
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index f4e99ca7918f..ef9b7ab6eddf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -126,6 +126,19 @@ uint32_t dc_link_bandwidth_kbps(
 	return link->dc->link_srv->dp_link_bandwidth_kbps(link, link_settings);
 }
 
+uint32_t dc_link_frl_bandwidth_kbps(const struct dc_link *link, enum hdmi_frl_link_rate link_rate)
+{
+	return link->dc->link_srv->frl_link_bandwidth_kbps(link_rate);
+}
+
+bool dc_link_frl_margin_check_uncompressed_video(
+		const struct dc_link *link,
+		struct frl_cap_chk_params_fixed31_32 *params,
+		struct frl_cap_chk_intermediates_fixed31_32 *inter)
+{
+	return link->dc->link_srv->frl_margin_check_uncompressed_video(params, inter);
+}
+
 uint32_t dc_link_required_hblank_size_bytes(
 	const struct dc_link *link,
 	struct dp_audio_bandwidth_params *audio_params)
@@ -144,6 +157,11 @@ void dc_restore_link_res_map(const struct dc *dc, uint32_t *map)
 	dc->link_srv->restore_res_map(dc, map);
 }
 
+void dc_link_wait_for_unlocked(struct dc_link *link)
+{
+	link->dc->link_srv->wait_for_unlocked(link);
+}
+
 bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
@@ -345,6 +363,14 @@ enum dc_link_encoding_format dc_link_get_highest_encoding_format(const struct dc
 				DP_128b_132b_ENCODING)
 			return DC_LINK_ENCODING_DP_128b_132b;
 	} else if (dc_is_hdmi_signal(link->connector_signal)) {
+		const struct dc_hdmi_frl_link_settings *frl_link_settings =
+				&link->frl_verified_link_cap;
+
+		if (frl_link_settings->frl_link_rate == HDMI_FRL_LINK_RATE_DISABLE)
+			return DC_LINK_ENCODING_HDMI_TMDS;
+		else if (frl_link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_3GBPS &&
+				frl_link_settings->frl_link_rate <= HDMI_FRL_LINK_RATE_12GBPS)
+			return DC_LINK_ENCODING_HDMI_FRL;
 	}
 
 	return DC_LINK_ENCODING_UNSPECIFIED;
@@ -518,6 +544,25 @@ bool dc_link_wait_for_t12(struct dc_link *link)
 	return link->dc->link_srv->edp_wait_for_t12(link);
 }
 
+bool dc_link_frl_poll_status_flag(struct dc_link *link)
+{
+	return link->dc->link_srv->hdmi_frl_poll_status_flag(link);
+}
+
+struct dc_hdmi_frl_link_settings *dc_link_get_frl_link_cap(
+		struct dc_link *link)
+{
+	return link->dc->link_srv->hdmi_frl_get_verified_link_cap(link);
+}
+
+void dc_link_set_preferred_frl_link_settings(struct dc *dc,
+		struct dc_hdmi_frl_link_settings *link_setting,
+		struct dc_hdmi_frl_link_training_overrides *lt_overrides,
+		struct dc_link *link)
+{
+	link->dc->link_srv->hdmi_frl_set_preferred_link_settings(dc, link_setting, lt_overrides, link);
+}
+
 bool dc_link_get_hpd_state(struct dc_link *link)
 {
 	return link->dc->link_srv->get_hpd_state(link);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 19526a278b2a..2457b563e6c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -96,6 +96,8 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 #define DC_LOGGER_INIT(logger)
+#include "link/hwss/link_hwss_hpo_frl.h"
+#include "dml/dml1_frl_cap_chk.h"
 #include "dml2_0/dml2_wrapper.h"
 
 #define UNABLE_TO_SPLIT -1
@@ -497,6 +499,25 @@ bool resource_construct(
 		}
 	}
 
+	pool->hpo_frl_stream_enc_count = 0;
+	if (create_funcs->create_hpo_frl_stream_encoder) {
+		for (i = 0; i < (unsigned int)caps->num_hpo_frl; i++) {
+			pool->hpo_frl_stream_enc[i] = create_funcs->create_hpo_frl_stream_encoder(i+ENGINE_ID_HPO_0, ctx);
+			if (pool->hpo_frl_stream_enc[i] == NULL)
+				DC_ERR("DC: failed to create HPO FRL stream encoder!\n");
+			pool->hpo_frl_stream_enc_count++;
+
+		}
+	}
+	pool->hpo_frl_link_enc_count = 0;
+	if (create_funcs->create_hpo_frl_link_encoder) {
+		for (i = 0; i < (unsigned int)caps->num_hpo_frl; i++) {
+			pool->hpo_frl_link_enc[i] = create_funcs->create_hpo_frl_link_encoder(i+ENGINE_ID_HPO_0, ctx);
+			if (pool->hpo_frl_link_enc[i] == NULL)
+				DC_ERR("DC: failed to create HPO FRL link encoder!\n");
+			pool->hpo_frl_link_enc_count++;
+		}
+	}
 	pool->hpo_dp_stream_enc_count = 0;
 	if (create_funcs->create_hpo_dp_stream_encoder) {
 		for (i = 0; i < caps->num_hpo_dp_stream_encoder; i++) {
@@ -2648,6 +2669,164 @@ static void update_stream_engine_usage(
 	}
 }
 
+static void update_hpo_frl_stream_engine_usage(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct hpo_frl_stream_encoder *hpo_frl_stream_enc,
+		bool acquired)
+{
+	unsigned int i;
+
+	for (i = 0; i < pool->hpo_frl_stream_enc_count; i++) {
+		if (pool->hpo_frl_stream_enc[i] == hpo_frl_stream_enc)
+			res_ctx->is_hpo_frl_stream_enc_acquired[i] = acquired;
+	}
+}
+
+static struct hpo_frl_stream_encoder *find_first_free_match_hpo_frl_stream_enc_for_link(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	(void)stream;
+	unsigned int i;
+
+	for (i = 0; i < pool->hpo_frl_stream_enc_count; i++) {
+		if (!res_ctx->is_hpo_frl_stream_enc_acquired[i] &&
+				pool->hpo_frl_stream_enc[i]) {
+
+			return pool->hpo_frl_stream_enc[i];
+		}
+	}
+
+	return NULL;
+}
+
+static inline int find_acquired_hpo_frl_link_enc_for_link(
+		const struct resource_context *res_ctx,
+		const struct dc_link *link)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_frl_link_enc_to_link_idx); i++)
+		if (res_ctx->hpo_frl_link_enc_ref_cnts[i] > 0 &&
+				res_ctx->hpo_frl_link_enc_to_link_idx[i] == link->link_index)
+			return i;
+
+	return -1;
+}
+
+static inline int find_free_hpo_frl_link_enc(const struct resource_context *res_ctx,
+		const struct resource_pool *pool)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_frl_link_enc_ref_cnts); i++)
+		if (res_ctx->hpo_frl_link_enc_ref_cnts[i] == 0)
+			break;
+
+	return (i < ARRAY_SIZE(res_ctx->hpo_frl_link_enc_ref_cnts) &&
+			i < pool->hpo_frl_link_enc_count) ? (int)i : -1;
+}
+
+static inline void acquire_hpo_frl_link_enc(
+		struct resource_context *res_ctx,
+		unsigned int link_index,
+		int enc_index)
+{
+	res_ctx->hpo_frl_link_enc_to_link_idx[enc_index] = link_index;
+	res_ctx->hpo_frl_link_enc_ref_cnts[enc_index] = 1;
+}
+
+static inline void retain_hpo_frl_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	res_ctx->hpo_frl_link_enc_ref_cnts[enc_index]++;
+}
+
+static inline void release_hpo_frl_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	ASSERT(res_ctx->hpo_frl_link_enc_ref_cnts[enc_index] > 0);
+	res_ctx->hpo_frl_link_enc_ref_cnts[enc_index]--;
+}
+
+static bool add_hpo_frl_link_enc_to_ctx(struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_frl_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		retain_hpo_frl_link_enc(res_ctx, enc_index);
+	} else {
+		enc_index = find_free_hpo_frl_link_enc(res_ctx, pool);
+		if (enc_index >= 0)
+			acquire_hpo_frl_link_enc(res_ctx, stream->link->link_index, enc_index);
+	}
+
+	if (enc_index >= 0)
+		pipe_ctx->link_res.hpo_frl_link_enc = pool->hpo_frl_link_enc[enc_index];
+
+	return pipe_ctx->link_res.hpo_frl_link_enc != NULL;
+}
+
+static void remove_hpo_frl_link_enc_from_ctx(struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_frl_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		release_hpo_frl_link_enc(res_ctx, enc_index);
+		pipe_ctx->link_res.hpo_frl_link_enc = NULL;
+	}
+}
+
+static struct hpo_frl_link_encoder *get_temp_hpo_frl_link_enc(
+		const struct resource_context *res_ctx,
+		const struct resource_pool *const pool,
+		const struct dc_link *link)
+{
+	struct hpo_frl_link_encoder *hpo_frl_link_enc = NULL;
+	int enc_index;
+
+	enc_index = find_acquired_hpo_frl_link_enc_for_link(res_ctx, link);
+
+	if (enc_index < 0)
+		enc_index = find_free_hpo_frl_link_enc(res_ctx, pool);
+
+	if (enc_index >= 0)
+		hpo_frl_link_enc = pool->hpo_frl_link_enc[enc_index];
+
+	return hpo_frl_link_enc;
+}
+
+bool get_temp_frl_link_res(struct dc_link *link,
+		struct link_resource *link_res)
+{
+	const struct dc *dc  = link->dc;
+	const struct resource_context *res_ctx = &dc->current_state->res_ctx;
+
+	memset(link_res, 0, sizeof(*link_res));
+	link_res->hpo_frl_link_enc = get_temp_hpo_frl_link_enc(res_ctx, dc->res_pool, link);
+	if (!link_res->hpo_frl_link_enc)
+		return false;
+
+	link_res->dio_link_enc = get_temp_dio_link_enc(res_ctx,
+			dc->res_pool, link);
+	if (!link_res->dio_link_enc)
+		return false;
+
+	return true;
+}
 static void update_hpo_dp_stream_engine_usage(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -2969,6 +3148,15 @@ void resource_remove_otg_master_for_stream_output(struct dc_state *context,
 			otg_master->stream_res.stream_enc,
 			false);
 
+	if (dc_is_hdmi_frl_signal(stream->signal)) {
+		update_hpo_frl_stream_engine_usage(
+			&context->res_ctx, pool,
+			otg_master->stream_res.hpo_frl_stream_enc,
+			false);
+		remove_hpo_frl_link_enc_from_ctx(
+			&context->res_ctx, otg_master, stream);
+		remove_dio_link_enc_from_ctx(&context->res_ctx, otg_master, stream);
+	}
 	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master)) {
 		update_hpo_dp_stream_engine_usage(
 			&context->res_ctx, pool,
@@ -4016,6 +4204,33 @@ enum dc_status resource_map_pool_resources(
 		pipe_ctx->stream_res.stream_enc,
 		true);
 
+	if (dc_is_hdmi_frl_signal(stream->signal)) {
+		is_dio_encoder = false;
+		pipe_ctx->stream_res.hpo_frl_stream_enc =
+			find_first_free_match_hpo_frl_stream_enc_for_link(
+				&context->res_ctx, pool, stream);
+
+		if (!pipe_ctx->stream_res.hpo_frl_stream_enc)
+			if (stream->timing.pix_clk_100hz < 6000000)
+				stream->signal = SIGNAL_TYPE_HDMI_TYPE_A;
+			else
+				return DC_NO_STREAM_ENC_RESOURCE;
+		else {
+			update_hpo_frl_stream_engine_usage(
+				&context->res_ctx, pool,
+				pipe_ctx->stream_res.hpo_frl_stream_enc,
+				true);
+			pipe_ctx->link_res.hpo_frl_link_enc =
+				pipe_ctx->stream->link->hpo_frl_link_enc;
+			if (!pipe_ctx->link_res.hpo_frl_link_enc) {
+				if (!add_hpo_frl_link_enc_to_ctx(&context->res_ctx, pool, pipe_ctx, stream))
+					return DC_NO_LINK_ENC_RESOURCE;
+			}
+			if (!add_dio_link_enc_to_ctx(dc, context, pool, pipe_ctx, stream))
+				return DC_NO_LINK_ENC_RESOURCE;
+		}
+	}
+
 	/* Allocate DP HPO Stream Encoder based on signal, hw capabilities
 	 * and link settings
 	 */
@@ -4081,6 +4296,8 @@ enum dc_status resource_map_pool_resources(
 		if (context->streams[i] == stream) {
 			context->stream_status[i].primary_otg_inst = pipe_ctx->stream_res.tg->inst;
 			context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.stream_enc->stream_enc_inst;
+			if (pipe_ctx->stream_res.hpo_frl_stream_enc != NULL)
+				context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.hpo_frl_stream_enc->stream_enc_inst;
 			context->stream_status[i].audio_inst =
 				pipe_ctx->stream_res.audio ? pipe_ctx->stream_res.audio->inst : -1;
 
@@ -4923,6 +5140,9 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 
 		set_hdr_static_info_packet(&info->hdrsmd, pipe_ctx->stream);
 
+		if (dc_is_hdmi_frl_signal(signal)) {
+			/* TODO: additional packets for HDMI 2.1 */
+		}
 	} else if (dc_is_dp_signal(signal)) {
 		set_vsc_info_packet(&info->vsc, pipe_ctx->stream);
 
@@ -5020,6 +5240,8 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.dsc != pipe_ctx->stream_res.dsc)
 		return true;
 
+	if (pipe_ctx_old->stream_res.hpo_frl_stream_enc != pipe_ctx->stream_res.hpo_frl_stream_enc)
+		return true;
 	if (pipe_ctx_old->stream_res.hpo_dp_stream_enc != pipe_ctx->stream_res.hpo_dp_stream_enc)
 		return true;
 	if (pipe_ctx_old->link_res.hpo_dp_link_enc != pipe_ctx->link_res.hpo_dp_link_enc)
@@ -5282,10 +5504,13 @@ void get_audio_check(struct audio_info *aud_modes,
 		audio_chk->audio_packet_type = 0x2;/*audio sample packet AP = .25 for layout0, 1 for layout1*/
 
 		audio_chk->max_audiosample_rate = 0;
+		audio_chk->max_channel_count = 0;
 		for (i = 0; i < aud_modes->mode_count; i++) {
 			max_sample_rate = get_max_audio_sample_rate(&aud_modes->modes[i]);
 			if (audio_chk->max_audiosample_rate < max_sample_rate)
 				audio_chk->max_audiosample_rate = max_sample_rate;
+			if (audio_chk->max_channel_count < aud_modes->modes[i].channel_count)
+				audio_chk->max_channel_count = aud_modes->modes[i].channel_count;
 			/*dts takes the same as type 2: AP = 0.25*/
 		}
 		/*check which one take more bandwidth*/
@@ -5497,6 +5722,8 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 		 */
 		return (requires_fixed_vs_pe_retimer_hpo_link_hwss(link) ?
 				get_hpo_fixed_vs_pe_retimer_dp_link_hwss() : get_hpo_dp_link_hwss());
+	else if (can_use_hpo_frl_link_hwss(link, link_res))
+		return get_hpo_frl_link_hwss();
 	else if (can_use_dpia_link_hwss(link, link_res))
 		return get_dpia_link_hwss();
 	else if (can_use_dio_link_hwss(link, link_res))
@@ -5724,5 +5951,11 @@ bool resource_is_hpo_acquired(struct dc_state *context)
 		}
 	}
 
+	for (i = 0; i < MAX_HDMI_FRL_ENCODERS; i++) {
+		if (context->res_ctx.is_hpo_frl_stream_enc_acquired[i]) {
+			return true;
+		}
+	}
+
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9c1d721011ca..f694c6ad6e98 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -54,6 +54,7 @@
  ******************************************************************************/
 void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink)
 {
+	unsigned int pix_clk;
 	if (sink->sink_signal == SIGNAL_TYPE_NONE)
 		stream->signal = stream->link->connector_signal;
 	else
@@ -67,6 +68,40 @@ void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink)
 		else
 			stream->signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
 	}
+	if (dc_is_hdmi_frl_signal(stream->signal)) {
+		pix_clk = stream->timing.pix_clk_100hz / 10;
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			pix_clk /= 2;
+
+		// YCbCr422 to use assume 12-bit interface always, clock stays the same
+		if (stream->timing.pixel_encoding != PIXEL_ENCODING_YCBCR422) {
+			switch (stream->timing.display_color_depth) {
+			case COLOR_DEPTH_666:
+			case COLOR_DEPTH_888:
+				break;
+			case COLOR_DEPTH_101010:
+				pix_clk = pix_clk * 10 / 8;
+				break;
+			case COLOR_DEPTH_121212:
+				pix_clk = pix_clk * 12 / 8;
+				break;
+			default:
+				break;
+			}
+		}
+		if (pix_clk != 0 && pix_clk < HDMI2_TMDS_MAX_PIXEL_CLOCK)
+			stream->signal = SIGNAL_TYPE_HDMI_TYPE_A;
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420 &&
+				stream->timing.h_addressable > 4096)
+			stream->signal = SIGNAL_TYPE_HDMI_FRL;
+		if (stream->timing.rid != 0)
+			stream->signal = SIGNAL_TYPE_HDMI_FRL;
+
+		if (stream->link->frl_flags.force_frl_always ||
+				stream->link->frl_flags.force_frl_max
+				)
+			stream->signal = SIGNAL_TYPE_HDMI_FRL;
+	}
 }
 
 bool dc_stream_construct(struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 8af8e2c17134..239ba2b352a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -535,6 +535,7 @@ static void check_audio_bandwidth(
 {
 	switch (signal) {
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 		check_audio_bandwidth_hdmi(
 			crtc_info, channel_count, sample_rates);
 		break;
@@ -738,6 +739,7 @@ void dce_aud_az_configure(
 	/* set audio for output signal */
 	switch (signal) {
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 		set_reg_field_value(value,
 			1,
 			AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER,
@@ -798,6 +800,12 @@ void dce_aud_az_configure(
 			/* adjust specific properties */
 			switch (audio_format_code) {
 			case AUDIO_FORMAT_CODE_LINEARPCM: {
+				if (signal == SIGNAL_TYPE_HDMI_FRL
+						&& channel_count > 2
+						&& crtc_info != NULL
+						&& crtc_info->v_active <= 576) {
+					channel_count = 2;
+				}
 
 				check_audio_bandwidth(
 					crtc_info,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index b97b4cd23eaa..7a0caace1604 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -981,7 +981,9 @@ static bool dcn31_program_pix_clk(
 		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
-	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
+	if (dc_is_hdmi_frl_signal(pix_clk_params->signal_type) ||
+			dc_is_virtual_signal(pix_clk_params->signal_type) ||
+			dc_is_dp_signal(pix_clk_params->signal_type)) {
 		if (e) {
 			/* Set DTO values: phase = target clock, modulo = reference clock*/
 			REG_WRITE(PHASE[inst], e->target_pixel_rate_khz * e->mult_factor);
@@ -997,6 +999,10 @@ static bool dcn31_program_pix_clk(
 				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
 						DP_DTO0_ENABLE, 1,
 						PIPE0_DTO_SRC_SEL, 2);
+			else if (dc_is_hdmi_frl_signal(pix_clk_params->signal_type) || encoding == DP_128b_132b_ENCODING)
+				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+						DP_DTO0_ENABLE, 0,
+						PIPE0_DTO_SRC_SEL, 2);
 			else
 				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
 						DP_DTO0_ENABLE, 1,
@@ -1084,8 +1090,14 @@ static bool dcn401_program_pix_clk(
 	if (!dc_is_tmds_signal(pix_clk_params->signal_type)) {
 		long long dtbclk_p_src_clk_khz;
 
-		dtbclk_p_src_clk_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
-		dto_params.clk_src = DPREFCLK;
+		/* if signal is HDMI FRL dtbclk_p_src is DTBCLK else DPREFCLK */
+		if (dc_is_hdmi_frl_signal(pix_clk_params->signal_type)) {
+			dtbclk_p_src_clk_khz = clock_source->ctx->dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(clock_source->ctx->dc->clk_mgr);
+			dto_params.clk_src = DTBCLK0;
+		} else {
+			dtbclk_p_src_clk_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+			dto_params.clk_src = DPREFCLK;
+		}
 
 		if (e) {
 			dto_params.pixclk_hz = e->target_pixel_rate_khz;
@@ -1103,7 +1115,15 @@ static bool dcn401_program_pix_clk(
 		clock_source->ctx->dc->res_pool->dccg->funcs->set_dp_dto(
 				clock_source->ctx->dc->res_pool->dccg,
 				&dto_params);
-
+		if (clock_source->ctx->dc->caps.is_apu &&
+			pix_clk_params->requested_pix_clk_100hz &&
+			dc_is_hdmi_frl_signal(pix_clk_params->signal_type)) {
+			/*need hdmistreamclk before vpg block register access*/
+			clock_source->ctx->dc->res_pool->dccg->funcs->set_hdmistreamclk(
+				clock_source->ctx->dc->res_pool->dccg,
+				DTBCLK0,
+				pix_clk_params->controller_id - 1);
+		}
 	} else {
 		if (pll_settings->actual_pix_clk_100hz > 6000000UL)
 			return false;
@@ -1335,7 +1355,7 @@ static bool dcn3_program_pix_clk(
 			look_up_in_video_optimized_rate_tlb(pix_clk_params->requested_pix_clk_100hz / 10);
 
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
-	if (dc_is_dp_signal(pix_clk_params->signal_type)) {
+	if ((pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_FRL) || dc_is_dp_signal(pix_clk_params->signal_type)) {
 		if (e) {
 			/* Set DTO values: phase = target clock, modulo = reference clock*/
 			REG_WRITE(PHASE[inst], e->target_pixel_rate_khz * e->mult_factor);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fe9431cea3e5..29986ee3fd2b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2898,16 +2898,19 @@ struct dmub_dig_transmitter_control_data_v1_7 {
 	union {
 		uint8_t digmode; /**< enum atom_encode_mode_def */
 		uint8_t dplaneset; /**< DP voltage swing and pre-emphasis value, "DP_LANE_SET__xDB_y_zV" */
+		uint8_t txffe; /**< TxFFE settings for HDMI 2.1 */
 	} mode_laneset;
 	uint8_t lanenum; /**< Number of lanes */
 	union {
 		uint32_t symclk_10khz; /**< Symbol Clock in 10Khz */
+		uint32_t symclk_Hz; /**< Symbol clock in Hz for FRL */
 	} symclk_units;
 	uint8_t hpdsel; /**< =1: HPD1, =2: HPD2, ..., =6: HPD6, =0: HPD is not assigned */
 	uint8_t digfe_sel; /**< DIG front-end selection, bit0 means DIG0 FE is enabled */
 	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
 	uint8_t HPO_instance; /**< HPO instance (0: inst0, 1: inst1) */
-	uint8_t reserved1; /**< For future use */
+	uint8_t TxFFELaneSel; /**< TxFFE lane select [3:0]
+				(bit0: lane0, bit1: lane1, bit2: lane3, bit3: lane3) */
 	uint8_t skip_phy_ssc_reduction;
 	uint8_t reserved2[2]; /**< For future use */
 	uint32_t reserved3[11]; /**< For future use */
-- 
2.54.0

