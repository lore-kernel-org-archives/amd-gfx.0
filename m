Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196CFCD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BEB10EB6A;
	Tue, 12 May 2026 14:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVl8GSH6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EDD10EB6B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMvNS8IFy+6mMtVw3WTiY14ro6BoLZDNO3hjtG8I3BwcOE6ChR+fC8R1LLN6Mwupc8oqnVXeLBtTlIBnIn7YdSjxjuDXedV0btM0vTIhXx+SNLfH+jud2vZq88pzqMF5kvtfWLG03PXsiL7bExkQYzP34U+fQr6EWGcdjt0efwbeUTLNfSIbjjHHgvKLIZK9wVgFz0BRFttuiM+YEblC8oiUxxmaMmhQ6AgKHEHoI9jGTlrwHFpVTh/8/0DZmvkpATxuRMF5hE2NF/xhNJ7dRHZkfpfVdXwVjfG7HLr58uGT6z91H+q7Mi6jUwES4hCx6EknsnyhzW1BdjdrnIF68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kE9R7fhROvA78X3R+/mlMI40us/OpssK8H0nf/78xOg=;
 b=N5FIUWB/KUCI/Rw0odkh5dANu0nRwVRYEynYtMiM/cErX/gcF/AwxrFSGP1JkahiEHGBzZr1nzPjqa5iTspn0KdPv0R2Tov2MonLnXlZygG0i2fp4dzkfoUGpQSaqqwgwRYil5Fxd/zhxgRDf1mlWph/0Wylj5NuMWi7MFocaCkuvZ9/ZvkSRdtfT50dh6t2pfTi1L8/E3+zimr8EAvhLTYt7YrJ12S21eoqcC6yTRX8Yt4VE3SqkaUvxQe0DW7gjFi8Ps9BgFurw0M8idmAVFSyb8RlU8CkFvqzyh26cPg4lRIczhJsla/UQ7P6KRHC97TLhu9oFBDF5Qyfwy3Tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE9R7fhROvA78X3R+/mlMI40us/OpssK8H0nf/78xOg=;
 b=FVl8GSH61pOU90ojUUh3dxZnrQ+K/rZSSYa6X/Z2djmlaYyLIY/bpu1ZZhvHy5QQzB3VA8RzmAbfPu1N0ScUQ8VEHLq/eZgXva4GfSzpArqceMDUyBzHPXthqRYknlH4qRfHniQPBeAkepbFNVDhjCoMIORpUugF6/9IHJuBaMc=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 14:23:32 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::91) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 14:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:23:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:23:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:23:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 09:23:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v4 09/13] drm/amd/display: Add support for FRL to DC core
Date: Tue, 12 May 2026 10:23:03 -0400
Message-ID: <20260512142308.131260-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512142308.131260-1-harry.wentland@amd.com>
References: <20260512142308.131260-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ab57be-c3f1-4249-f425-08deb0320b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|3023799003|56012099003|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: QMriJRFgzFWbY6OQxP96b3ePI4r9k/CRaENV5gIyCb6iB5I4AE92+fRgA1siVpLJNg730rsI1EHbgkpCET4v3oumkGMWExLNq+mAq3xH1Ww/3u5Z4S9vSJ+GS2dxJZhJggLD6n5VzfNfmPw2CuCJZXs08JfhncjX5uerNnfVaAABBplB0ZV2xFROARVabUKyVkkBi1yFooC4LtbZcPO23wxrGWm3wmq05Vpn0AcZnyxLP5RRopmMWle0JhrUyziUHJ3w6ONXNq3BMVFGPWIgHqUtLdWMAZoGtwko47/nzJ+j6hdnxVgXD6XwemSqoFkxoX5En8icq5/h1PISq85DlRlXfZMt5+LGzq4QLPvQ17XXtenoQ+stKSfUWkD9YhNgdUe5Gxt+njIwYb0CaVKcrDX3qXepqabUTNH29oPAYj3OxZQ1rg/i5BDrtXHWk4P9Xx8P5UphJ9SnFDDODOdMONiCPU8h2nQgxHACJTv6APbeeRHRdyaMH1Qy1Wkd2IFCkTE6EhCRCgXsti0LKDDdBm26K24F+XZmBapCt58g7UbJ9Nc/qWF1c+sqJmqldlO6+f5OIEg5UQhBUbXWgGrKD8mceRokaP5TKSSdaXof9pKw48YgWhy6USLVGpI894hzIIjH4wSAHBBbgaBAVOW1WupRjpeuXNCTKrumx0xM0ccrHNlj3WdGXASM1ipYvGsWjrkB4AuhOPUWqwlTchI6e6RtyaD+E/boVVOS9p4JpL0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tP6Qw4uNAyrf+U7JT2alKJeISvJ0dMQrZAfegEHN6snh96BzRGSu66bHlyXmraoLg6+Nb3hPqzQgJWLtEcZY9vCvRbKBKiDUZZMG31jSsit+N4eGu+pj8ztq7byPx8MYO6nSzwkgxsq6C0mLnquSMgiL/uK4PQz2GVzfy7K6cTE5uR0H0enf76IAY8+Iy9E8q2wsQgEQyZ76aQud8MHVlfXmvyX5K4MVpuishBt60Nfs1Kc50JX/vp+TcKkLLLQYjPlOcjk4q/GfK8ZmOfv27o8e9sZxoms/PB7eqwFrIizQJnGsTn+g8HERAM9oOr/Q5E1vq22bfNREtQvdr9+oj4WTSkUcAsAd+CZ7KaP1oh1R3A8ocOFrYf+Bmsd0ACm4YV3yxqbHKT0dxbKxbNWE7BjCQf5HevEGZ1hoMzXVXrwRRnMJ+sT3awUqMsr5mYG9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:23:32.1475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ab57be-c3f1-4249-f425-08deb0320b97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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
index 48d32adb9eb3..af0e5ca48abb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3921,17 +3921,20 @@ static void add_update_info_frame_sequence(
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
@@ -3939,6 +3942,11 @@ static void add_update_info_frame_sequence(
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
@@ -7473,6 +7481,20 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
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
index 1916aa3ebaea..97380cda9eb4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1614,6 +1614,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case STREAM_ENC_UPDATE_HDMI_INFO_PACKETS:
 			hwss_stream_enc_update_hdmi_info_packets(params);
 			break;
+		case HPO_FRL_STREAM_ENC_UPDATE_HDMI_INFO_PACKETS:
+			hwss_hpo_frl_stream_enc_update_hdmi_info_packets(params);
+			break;
 		case HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM:
 			hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(params);
 			break;
@@ -3641,6 +3644,15 @@ void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *param
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
@@ -4864,6 +4876,16 @@ void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *s
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
@@ -4962,6 +4984,20 @@ void hwss_add_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state
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
index afdf9f8b16d7..d2a5e0648fc2 100644
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
index 5ac5ad86bd01..f25d4b3e11ac 100644
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
index f57e9d85563e..09235ae5055e 100644
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
 		for (i = 0; i < (unsigned int)caps->num_hpo_dp_stream_encoder; i++) {
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
@@ -2970,6 +3149,15 @@ void resource_remove_otg_master_for_stream_output(struct dc_state *context,
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
@@ -4017,6 +4205,33 @@ enum dc_status resource_map_pool_resources(
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
@@ -4082,6 +4297,8 @@ enum dc_status resource_map_pool_resources(
 		if (context->streams[i] == stream) {
 			context->stream_status[i].primary_otg_inst = pipe_ctx->stream_res.tg->inst;
 			context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.stream_enc->stream_enc_inst;
+			if (pipe_ctx->stream_res.hpo_frl_stream_enc != NULL)
+				context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.hpo_frl_stream_enc->stream_enc_inst;
 			context->stream_status[i].audio_inst =
 				pipe_ctx->stream_res.audio ? pipe_ctx->stream_res.audio->inst : -1;
 
@@ -4926,6 +5143,9 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 
 		set_hdr_static_info_packet(&info->hdrsmd, pipe_ctx->stream);
 
+		if (dc_is_hdmi_frl_signal(signal)) {
+			/* TODO: additional packets for HDMI 2.1 */
+		}
 	} else if (dc_is_dp_signal(signal)) {
 		set_vsc_info_packet(&info->vsc, pipe_ctx->stream);
 
@@ -5023,6 +5243,8 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.dsc != pipe_ctx->stream_res.dsc)
 		return true;
 
+	if (pipe_ctx_old->stream_res.hpo_frl_stream_enc != pipe_ctx->stream_res.hpo_frl_stream_enc)
+		return true;
 	if (pipe_ctx_old->stream_res.hpo_dp_stream_enc != pipe_ctx->stream_res.hpo_dp_stream_enc)
 		return true;
 	if (pipe_ctx_old->link_res.hpo_dp_link_enc != pipe_ctx->link_res.hpo_dp_link_enc)
@@ -5291,10 +5513,13 @@ void get_audio_check(struct audio_info *aud_modes,
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
@@ -5506,6 +5731,8 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 		 */
 		return (requires_fixed_vs_pe_retimer_hpo_link_hwss(link) ?
 				get_hpo_fixed_vs_pe_retimer_dp_link_hwss() : get_hpo_dp_link_hwss());
+	else if (can_use_hpo_frl_link_hwss(link, link_res))
+		return get_hpo_frl_link_hwss();
 	else if (can_use_dpia_link_hwss(link, link_res))
 		return get_dpia_link_hwss();
 	else if (can_use_dio_link_hwss(link, link_res))
@@ -5733,5 +5960,11 @@ bool resource_is_hpo_acquired(struct dc_state *context)
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
index d4c32c945606..42b2a88d2d52 100644
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
index c1becd664cb9..09b67d120b0a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2944,16 +2944,19 @@ struct dmub_dig_transmitter_control_data_v1_7 {
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

