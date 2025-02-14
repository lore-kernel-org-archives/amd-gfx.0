Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90463C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D4D10ECC8;
	Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZbnADwN3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1F810ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWCcJVgMzFxjHwVFpn3/Fx8/1DIS1ZaazaS1mzPDCHeGMRx8dz9Hjw08ixN2aKRCg74a+ivT0TuNDicdFglLMkmIp1aN1OlIT5ZTFbgeq5PKY9NYfA+885RTE5B25L87VyfeN9JFWU/q/fDazBLna7AobhP5zdZhZX3NfyaIX+MjGTHLgzirc4UklkSUHvCrCa6MAO/MvfrzncRSTKIZhMhIvBdSUKdE7TELrH8lu2YGB9CwIlS8CWnHJyNX0aiXVr1UuW/CkNsrTRKiKLlq3pQ+Mz9GRVbDI3dt1UNOvRIMJmwfTFfe+/xgBexQqv2+l3PNnlsDClsFcaaiFvPZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trUPFUjXWMkupl4pbXOBfMXrJVIG33Yrd2j/TUqOK8c=;
 b=WcFheMEwLSHemhc/iJ2wv+s8ooUx9qXb+MKaziqd5yrzDU73Cord0owImMvqJV1AA/rRkY963gpoR0HMXbrp2dEYOjV7e5tpEqgb7yW/GjepCxqFPwznBCTqcuFXb3PW9r8bKdC6bpx2woecgeVoA5nBuxh6jLwHoC3XAZGj3WLc4ouC9e9x0uIhlwEht7AI4UmGR8nQjxI8sJgsxdRvV7MDbjmhaXIvqoJURxHXLurwINe+KyJJfajWahQuXdwUPaQDrrja8PnIDsTVu29KSVZL2xSyrtZvAHUbURpa9I76Y9B+Jrmbq/vsm16Jq6yx0W36LpHNPb0NGPc8dn471A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trUPFUjXWMkupl4pbXOBfMXrJVIG33Yrd2j/TUqOK8c=;
 b=ZbnADwN3YtWUs9guf/dbbJF4CZ15WsZ9ClO06pCE6jn68w4YN8y03EwD8yYsj5XN8uMPepRJGZvRHNHCTo5wV3BZtTa/t6XS3OdreQMZepi0wRvDFe5eIDxE81SgOx8YFZ/XokSgoi08Gw69ryaYAOB3dVMZGpQ76vU+ZdGArdY=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 15:01:40 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::75) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:39 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:38 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Ilya
 Bakoulin" <Ilya.Bakoulin@amd.com>, Krunoslav Kovac <krunoslav.kovac@amd.com>, 
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH 12/16] drm/amd/display: Support BT2020 YCbCr fullrange
Date: Fri, 14 Feb 2025 10:00:29 -0500
Message-ID: <20250214150033.767978-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: d457e2fb-442b-43b3-20a4-08dd4d087ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXsoyiA0mY5ryrNAq8ZV2BKUAwtxyqOQ573Fyfk4jpMghFLfl6SzkFJRJvjT?=
 =?us-ascii?Q?FcHliQmMqVI9l67PqrnoZ+6V//YneQgTUKgLXyxd1F7126a0XezuQt/WIr4U?=
 =?us-ascii?Q?0L9XWxDnCN8vLHvnt0hfCbshc0etImzd/shAjhE7NNZvjDq7pFaezWfZGpbs?=
 =?us-ascii?Q?uEvLDzUi53hAyox0IIu/WuKekZTb0SUYHj40H5wNShlO9kjUKkb4lUinTBjX?=
 =?us-ascii?Q?LTdslneUk1ePG/w37CfxxtDxWPFZ31EHo9eRnI1fRk5lW+KSWIql3OBpArmu?=
 =?us-ascii?Q?HtJ8JTUDeHaoXCnGEVMR2hmp2a9phiYsOxaUbBvLaBhg4UWPlyY1DXNVZN5n?=
 =?us-ascii?Q?TJsV5mQ8an49Ma51R76JCT5ahAhGopgPgGwdnGwFbb+wIwtSQ72aE7G4boqa?=
 =?us-ascii?Q?7HZoynI3TmgBzhU6n74ZOeeA/m0SPnwb0JWi5KUwlpXh5I1ny4aVSGkBtsWF?=
 =?us-ascii?Q?Se5Mab5n7Qp6JVpurpQtvmIxNESgcqRL7QGqB0J3bvTOhObMp7pkFfi6S9sL?=
 =?us-ascii?Q?Os5n8pSQuM6SeVArymnUx0jAtnNXDvGGWF+3FNoLACp2bTBKNJN+CHJmMI+d?=
 =?us-ascii?Q?LPU3o+AoLSHL92tTLPIUxkd/NRA0RVg1D3lKzNQ1LoSv4EP4aQF9HmpBecoo?=
 =?us-ascii?Q?0u+rP8eC9pzWlztnS97U5PBDKoRMiUGI/+NkD+sSsNH3XHX3ES37J6APtCS6?=
 =?us-ascii?Q?7nEVcMgPeUviQuRg+5e3TUiMWZyBLnQ2v4I6megXGR96JhOtdozwnXUuigPm?=
 =?us-ascii?Q?OktoCO9XbqxGR3snQrcSHGp9jOLpflcBs3FHI6mu2/tVVusW2vazl+X87yBl?=
 =?us-ascii?Q?VH5Zu1o7gsPUTMk3qAXdMTmlvqw9a9nbA4tKQpXiO1Hp0Kn8xZ9Rwgl+bmFT?=
 =?us-ascii?Q?KBe7v87EqWqznKE2T+fRVewK9A0BjYmiZCh/oaHatXEefvVSiR/ZNDaYlgJb?=
 =?us-ascii?Q?G6V4WmRBnlo3Ko4JhHWlPh6HskiinsZ0uBwdkCoGQIS70bm1rTXuVP9ezJQr?=
 =?us-ascii?Q?CrE49GnoGtA+7V5j01Tqza5B9gCMVwaWd4uIgKUyV+TktW5Qe8GrkhyF15tI?=
 =?us-ascii?Q?YZsUDtpSPoziVKM59gDZFuoauNFcoHvL4f36R2iNdcTYR35WyA2krGrymt/S?=
 =?us-ascii?Q?ljiuOgkhZsd5+nBHXSsiJw4CvDyHPPGaQ4wl1DUpBgeLHsFbTJ2JZ93g1H7z?=
 =?us-ascii?Q?diwY51SdIFjfUtpucMYB0coK+YIqg3akLSZWoFRzcBHkFhZbi64cfQSUWcX0?=
 =?us-ascii?Q?UxQ/MSlnVyvrji4wCD/lgJUNKZGUNS4fUXXb2yxY2kTw4IPRfKwEH030dK4J?=
 =?us-ascii?Q?COaOZ7eJngKCnmH3FMRvt4f6cG2S+kZ1iiHMKexHtgKsUvaZOD93ZQQ061oO?=
 =?us-ascii?Q?0UzAASQs1tbd9KJPvTSlk6qSYxM9xfkaR1NRLmKPocWp3OO62NNLFthndJBD?=
 =?us-ascii?Q?RTwu7HeiG5s5vY6ioOqf/fq/sJ2HrNtHsw3+Jd81XfNroPvx4sPbZdClPGoq?=
 =?us-ascii?Q?8sm2HC5eI7tA3Vg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:40.2167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d457e2fb-442b-43b3-20a4-08dd4d087ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Need to add support for full-range quantization for YCbCr in BT2020
color space.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 6 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c       | 5 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                | 4 +++-
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c     | 3 ++-
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c | 3 ++-
 .../amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c   | 3 ++-
 .../amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c  | 3 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h                 | 6 +++++-
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c   | 4 ++--
 12 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1b5f352b9aa..4ae54b3573ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5616,9 +5616,9 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 	case DRM_COLOR_YCBCR_BT2020:
 		if (full_range)
-			*color_space = COLOR_SPACE_2020_YCBCR;
+			*color_space = COLOR_SPACE_2020_YCBCR_FULL;
 		else
-			return -EINVAL;
+			*color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
 		break;
 
 	default:
@@ -6114,7 +6114,7 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB)
 			color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
 		else
-			color_space = COLOR_SPACE_2020_YCBCR;
+			color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
 		break;
 	case DRM_MODE_COLORIMETRY_DEFAULT: // ITU601
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 049046c60462..c7d13e743e6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1169,7 +1169,7 @@ static int amdgpu_current_colorspace_show(struct seq_file *m, void *data)
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
 		seq_puts(m, "BT2020_RGB");
 		break;
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 		seq_puts(m, "BT2020_YCC");
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
index b2fc4f8e6482..a51c2701da24 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
@@ -40,7 +40,8 @@ bool is_rgb_cspace(enum dc_color_space output_color_space)
 	case COLOR_SPACE_YCBCR709:
 	case COLOR_SPACE_YCBCR601_LIMITED:
 	case COLOR_SPACE_YCBCR709_LIMITED:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
+	case COLOR_SPACE_2020_YCBCR_FULL:
 		return false;
 	default:
 		/* Add a case to switch */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 6eb9bae3af91..6b514fd03f16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -176,7 +176,7 @@ static bool is_ycbcr2020_type(
 {
 	bool ret = false;
 
-	if (color_space == COLOR_SPACE_2020_YCBCR)
+	if (color_space == COLOR_SPACE_2020_YCBCR_LIMITED || color_space == COLOR_SPACE_2020_YCBCR_FULL)
 		ret = true;
 	return ret;
 }
@@ -247,7 +247,8 @@ void color_space_to_black_color(
 	case COLOR_SPACE_YCBCR709_BLACK:
 	case COLOR_SPACE_YCBCR601_LIMITED:
 	case COLOR_SPACE_YCBCR709_LIMITED:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
+	case COLOR_SPACE_2020_YCBCR_FULL:
 		*black_color = black_color_format[BLACK_COLOR_FORMAT_YUV_CV];
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e6bc479497e8..7eb91612b60d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4488,7 +4488,7 @@ static void set_avi_info_frame(
 		break;
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 		hdmi_info.bits.EC0_EC2 = COLORIMETRYEX_BT2020RGBYCBCR;
 		hdmi_info.bits.C0_C1   = COLORIMETRY_EXTENDED;
 		break;
@@ -4502,7 +4502,7 @@ static void set_avi_info_frame(
 		break;
 	}
 
-	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR &&
+	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR_LIMITED &&
 			stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 		hdmi_info.bits.EC0_EC2 = 0;
 		hdmi_info.bits.C0_C1 = COLORIMETRY_ITU709;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 5ac55601a6da..9f3dd8824ed5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -653,7 +653,8 @@ enum dc_color_space {
 	COLOR_SPACE_YCBCR709_LIMITED,
 	COLOR_SPACE_2020_RGB_FULLRANGE,
 	COLOR_SPACE_2020_RGB_LIMITEDRANGE,
-	COLOR_SPACE_2020_YCBCR,
+	COLOR_SPACE_2020_YCBCR_LIMITED,
+	COLOR_SPACE_2020_YCBCR_FULL,
 	COLOR_SPACE_ADOBERGB,
 	COLOR_SPACE_DCIP3,
 	COLOR_SPACE_DISPLAYNATIVE,
@@ -661,6 +662,7 @@ enum dc_color_space {
 	COLOR_SPACE_APPCTRL,
 	COLOR_SPACE_CUSTOMPOINTS,
 	COLOR_SPACE_YCBCR709_BLACK,
+	COLOR_SPACE_2020_YCBCR = COLOR_SPACE_2020_YCBCR_LIMITED,
 };
 
 enum dc_dither_option {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index d199e4ed2e59..1130d7619b26 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -418,7 +418,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 			dynamic_range_rgb = 1; /*limited range*/
 			break;
 		case COLOR_SPACE_2020_RGB_FULLRANGE:
-		case COLOR_SPACE_2020_YCBCR:
+		case COLOR_SPACE_2020_YCBCR_LIMITED:
 		case COLOR_SPACE_XR_RGB:
 		case COLOR_SPACE_MSREF_SCRGB:
 		case COLOR_SPACE_ADOBERGB:
@@ -430,6 +430,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		case COLOR_SPACE_APPCTRL:
 		case COLOR_SPACE_CUSTOMPOINTS:
 		case COLOR_SPACE_UNKNOWN:
+		default:
 			/* do nothing */
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
index d01a8b8f9595..22e66b375a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
@@ -391,7 +391,7 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 	case COLOR_SPACE_XR_RGB:
 	case COLOR_SPACE_MSREF_SCRGB:
 	case COLOR_SPACE_ADOBERGB:
@@ -404,6 +404,7 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	case COLOR_SPACE_CUSTOMPOINTS:
 	case COLOR_SPACE_UNKNOWN:
 	case COLOR_SPACE_YCBCR709_BLACK:
+	default:
 		/* do nothing */
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 334fb5e2c003..4bab180e1938 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -632,7 +632,7 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 	case COLOR_SPACE_XR_RGB:
 	case COLOR_SPACE_MSREF_SCRGB:
 	case COLOR_SPACE_ADOBERGB:
@@ -645,6 +645,7 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 	case COLOR_SPACE_CUSTOMPOINTS:
 	case COLOR_SPACE_UNKNOWN:
 	case COLOR_SPACE_YCBCR709_BLACK:
+	default:
 		/* do nothing */
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
index 678db949cfe3..759b453385c4 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -323,7 +323,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-	case COLOR_SPACE_2020_YCBCR:
+	case COLOR_SPACE_2020_YCBCR_LIMITED:
 	case COLOR_SPACE_XR_RGB:
 	case COLOR_SPACE_MSREF_SCRGB:
 	case COLOR_SPACE_ADOBERGB:
@@ -336,6 +336,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 	case COLOR_SPACE_CUSTOMPOINTS:
 	case COLOR_SPACE_UNKNOWN:
 	case COLOR_SPACE_YCBCR709_BLACK:
+	default:
 		/* do nothing */
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 0150f2581ee4..0c5675d1c593 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -119,10 +119,14 @@ static const struct dpp_input_csc_matrix __maybe_unused dpp_input_csc_matrix[] =
 		{ 0x39a6, 0x2568, 0,      0xe0d6,
 		  0xeedd, 0x2568, 0xf925, 0x9a8,
 		  0,      0x2568, 0x43ee, 0xdbb2 } },
-	{ COLOR_SPACE_2020_YCBCR,
+	{ COLOR_SPACE_2020_YCBCR_FULL,
 		{ 0x2F30, 0x2000, 0,      0xE869,
 		  0xEDB7, 0x2000, 0xFABC, 0xBC6,
 		  0,      0x2000, 0x3C34, 0xE1E6 } },
+	{ COLOR_SPACE_2020_YCBCR_LIMITED,
+		{ 0x35B9, 0x2543, 0,      0xE2B2,
+		  0xEB2F, 0x2543, 0xFA01, 0x0B1F,
+		  0,      0x2543, 0x4489, 0xDB42 } },
 	{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 		{ 0x35E0, 0x255F, 0,      0xE2B3,
 		  0xEB20, 0x255F, 0xF9FD, 0xB1E,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index a344e2e49b0e..b3d55cac3569 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -383,10 +383,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			else if (cs == COLOR_SPACE_ADOBERGB)
 				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
-			else if (cs == COLOR_SPACE_2020_YCBCR)
+			else if (cs == COLOR_SPACE_2020_YCBCR_LIMITED)
 				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
 
-			if (cs == COLOR_SPACE_2020_YCBCR && tf == TRANSFER_FUNC_GAMMA_22)
+			if (cs == COLOR_SPACE_2020_YCBCR_LIMITED && tf == TRANSFER_FUNC_GAMMA_22)
 				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			break;
 
-- 
2.34.1

