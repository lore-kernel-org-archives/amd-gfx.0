Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40B3CD98CC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A80F10E875;
	Wed, 10 Jun 2026 09:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWmiwlCK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3104110E875
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5rFjki9xpRsfnrlk5a2S2ZrS5EiOfEVyi16eD0jIcQPWH/IxbdC8QUmmxCRg60q/3yk2fyAP1ahcechAVCBIkeU2jMt3+newcJjibQ7fwCTAFHXQRgDVJZrPYMDeQbT7PSaKNjt4uFcHGwbZe8udt061XksgLAe3xHtzilFYXJTlg5JVnJTLaVubCoMuofVSPT3jn8K1ShYMcr8yhB9RPVSYgaMw/Gi0dyjcBI4YLPEQe7niDPf7c83I5KIJ+WRhfj7ptxicqHMTUjokHjb/w0gln654u0oBOgs0cUjuM6wEE3B0umCMGIq/IpW+ZvdSpsNeGFzMXaoD74r68BtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DROGuryWY8mRT6ReJb8jjSwU8gD8DaxvTx/NxmXCoo=;
 b=c0adpFenMHiE80+KpuxDHtHmlf+25Vy7AENSvOQyUep4dYkCzv1DDwYszuaIpni3P/BTmVaAHHGMvbccgkcDuigPf9ip3z6rnCVAnZQ4o3OzogBydzJwImxr6ZlW1ZeYYdNQ/iTvM2an1Ui+zvHfJdbO94i6r/a6MDKZ/yQ8l3FVXI6Ya6BGLYIPCkIUtYjXSJ8/xh6OY4GpUh4QdBBw/nqA3e97ctjHV4zuiu6JwayK2mszKOYEv9CAyU2Zh8npVbOUSmwzJkxZROI6Sl0lRu08CfO9MyCK1Lp/R+K8bYC9yy2vtAkzhJNuHKEu+47Tdr4Ex6cZ9XQtG5rHSqbFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DROGuryWY8mRT6ReJb8jjSwU8gD8DaxvTx/NxmXCoo=;
 b=NWmiwlCKNaB97eGBW0NqlKWSYAldPXpnPD1vGiStQZFHo3b40BlydU8DaCnlHyjumpBadZig4OfHgxH93q+FxFGEkRjoG2whLoML9bIjecoY12+py+F5J0CSNBq+3eJgPu4c8xdHAxR6w8cfI6uI19SN2I3o8IGbPg4jVhHcDko=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:49:04 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::4b) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:49:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:00 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:48:51 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 07/32] drm/amd/display: Extract backlight code to
 amdgpu_dm_backlight
Date: Wed, 10 Jun 2026 17:44:51 +0800
Message-ID: <20260610094639.1965367-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 96173df7-7787-4c12-b28d-08dec6d581ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|3023799007|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: vtyc11C8Nwa6eTkG5yD51kbKD4TblYEdH72iXdT0eKATmQkoQrYTUZAx/joi/5EM2VpleAqHwOyu6+33aUc9H5S6kXmvhEo519H//cHDsPFVjZ3vJFtwgpfzUW1QjXVKVyIW9oDe+R3iDDBT1UC8roxuW2EdaEZZIsaSALzxwhxtH8PCQfj5OqikxYuYE1vLryD3rLKgih4Nl4bFeYOsDADBEorMpHwCChqKO79QgzbZchB0Y3dRHlvgMoDy/2X1xF0WLTLzPpFf7xq8cDwufR7cGssS4jyjG9z91fmb62bNbta3zAR8PjpvYS7Pwj/clRDXnY7wBA6rkn99bn+scWqbYidD8ZhSILm8uhvqCXKU/2zUTMyXSGzYVP/l+7M317Y/lmNDVYEQmgB0CNbnDdAopN+VXdv/2sgSx3VYR5KoDLgCiaiJLePeCStyJ1fnHegP05TiIo+g0CyRPnPE62oE2nVTnzTYLyinQ+epSLAzFct51vtpkxjEo9xNIBqz8DnaXMlNSxW4ScPEbccavi+p71U22PlqX3uNYGx+8WQ4HdTQI8ZoqP983vMcz2GyQFTBmjjkDstvdJn98sh/m4hflrjD9VHnxbrg16SdMBho5Utbq3hVMTBtSJIc1pV/m3J6OCjjT8Gtfr/lrsXUCc30M1Dnv0YkAr+ryfIBQTAX7wWkZ9rYzpJG/tF+VBwmsuLdWXIU+ful4rk6j+F1KsnuJlel69WYUWLhraSS7DU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H00tsRpV4GI2iXrC+gcRs9nzVfmVknalPxOMLL1Th6axvUPQWFF4kEoi1beJ5fFvkDxm1SHhHSpgs6M6wZ+2VuD7Rpaxf9XmlWjTL4yUujta4zHH5JMhcFcyAtauaWi/W9WMJuvXNizHtlbsQbtRQXVyCfDWjGqlEDd4Y4FHnOGoVBK71JNGVPfhuJ0GKLmLWw+EOzb2Ukd6f0bhXlHL0W4NkvaF4CXlmmFrIxt/nGwyYRtniRnIxDm4XgP9q8eenzaaItIcEEcX/Jh8I85SqNXzomSLaz5wLhAH7+GnsdXtX1jpY4+vJMl+65NV44VcEYOr5t08uOsNOQd5yo3rEKk7WpcwHa/obpO+k1NH26ZpapfRyi0PFdIqiAYTjXYv69s0j26RsXVSkYelpPS4IJ8x0MWlue3h8tfaDn/MjNOPWs/ms6nNQsEOknEvyIuZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:49:03.8080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96173df7-7787-4c12-b28d-08dec6d581ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

From: Alex Hung <alex.hung@amd.com>

Move backlight-related functions from amdgpu_dm.c into a new
amdgpu_dm_backlight.c file to improve code organization and
reduce the size of the monolithic amdgpu_dm.c.

No functional change intended.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 620 +---------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 660 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  44 ++
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   1 +
 6 files changed, 710 insertions(+), 619 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 54a93e4255b3..2953c59d85e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -41,7 +41,8 @@ AMDGPUDM = \
 	amdgpu_dm_quirks.o \
 	amdgpu_dm_wb.o \
 	amdgpu_dm_colorop.o \
-	amdgpu_dm_ism.o
+	amdgpu_dm_ism.o \
+	amdgpu_dm_backlight.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 231825249c48..100e1fb572b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -66,6 +66,7 @@
 #endif
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
+#include "amdgpu_dm_backlight.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -246,10 +247,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason);
 static void handle_hpd_rx_irq(void *param);
 
-static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
-					 int bl_idx,
-					 u32 user_brightness);
-
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -4047,74 +4044,6 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
 }
 
-static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
-{
-	const struct drm_panel_backlight_quirk *panel_backlight_quirk;
-	struct amdgpu_dm_backlight_caps *caps;
-	struct drm_connector *conn_base;
-	struct amdgpu_device *adev;
-	struct drm_luminance_range_info *luminance_range;
-	struct drm_device *drm;
-
-	if (aconnector->bl_idx == -1 ||
-	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
-		return;
-
-	conn_base = &aconnector->base;
-	drm = conn_base->dev;
-	adev = drm_to_adev(drm);
-
-	caps = &adev->dm.backlight_caps[aconnector->bl_idx];
-	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
-	caps->aux_support = false;
-
-	if (caps->ext_caps->bits.oled == 1
-	    /*
-	     * ||
-	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
-	     */)
-		caps->aux_support = true;
-
-	if (amdgpu_backlight == 0)
-		caps->aux_support = false;
-	else if (amdgpu_backlight == 1)
-		caps->aux_support = true;
-	if (caps->aux_support)
-		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
-
-	luminance_range = &conn_base->display_info.luminance_range;
-
-	if (luminance_range->max_luminance)
-		caps->aux_max_input_signal = luminance_range->max_luminance;
-	else
-		caps->aux_max_input_signal = 512;
-
-	if (luminance_range->min_luminance)
-		caps->aux_min_input_signal = luminance_range->min_luminance;
-	else
-		caps->aux_min_input_signal = 1;
-
-	panel_backlight_quirk =
-		drm_get_panel_backlight_quirk(aconnector->drm_edid);
-	if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
-		if (panel_backlight_quirk->min_brightness) {
-			caps->min_input_signal =
-				panel_backlight_quirk->min_brightness - 1;
-			drm_info(drm,
-				 "Applying panel backlight quirk, min_brightness: %d\n",
-				 caps->min_input_signal);
-		}
-		if (panel_backlight_quirk->brightness_mask) {
-			drm_info(drm,
-				 "Applying panel backlight quirk, brightness_mask: 0x%X\n",
-				 panel_backlight_quirk->brightness_mask);
-			caps->brightness_mask =
-				panel_backlight_quirk->brightness_mask;
-		}
-	}
-}
-
 DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
 
 void amdgpu_dm_update_connector_after_detect(
@@ -4240,7 +4169,7 @@ void amdgpu_dm_update_connector_after_detect(
 		}
 
 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
-		update_connector_ext_caps(aconnector);
+		amdgpu_dm_update_connector_ext_caps(aconnector);
 		dm_set_panel_type(aconnector);
 	} else {
 		hdmi_cec_unset_edid(aconnector);
@@ -5156,420 +5085,6 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
-#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
-#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
-#define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
-
-void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
-				     int bl_idx)
-{
-	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
-
-	if (caps->caps_valid)
-		return;
-
-#if defined(CONFIG_ACPI)
-	amdgpu_acpi_get_backlight_caps(caps);
-
-	/* validate the firmware value is sane */
-	if (caps->caps_valid) {
-		int spread = caps->max_input_signal - caps->min_input_signal;
-
-		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps->min_input_signal < 0 ||
-		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    spread < AMDGPU_DM_MIN_SPREAD) {
-			drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
-				      caps->min_input_signal, caps->max_input_signal);
-			caps->caps_valid = false;
-		}
-	}
-
-	if (!caps->caps_valid) {
-		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-		caps->caps_valid = true;
-	}
-#else
-	if (caps->aux_support)
-		return;
-
-	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps->caps_valid = true;
-#endif
-}
-
-static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned int *min, unsigned int *max)
-{
-	if (!caps)
-		return 0;
-
-	if (caps->aux_support) {
-		// Firmware limits are in nits, DC API wants millinits.
-		*max = 1000 * caps->aux_max_input_signal;
-		*min = 1000 * caps->aux_min_input_signal;
-	} else {
-		// Firmware limits are 8-bit, PWM control is 16-bit.
-		*max = 0x101 * caps->max_input_signal;
-		*min = 0x101 * caps->min_input_signal;
-	}
-	return 1;
-}
-
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
-{
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
-}
-
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
-static inline u32 scale_fw_to_input(int min, int max, u64 input)
-{
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
-}
-
-static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-				      unsigned int min, unsigned int max,
-				      uint32_t *user_brightness)
-{
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
-	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
-	int left, right;
-
-	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-		return;
-
-	if (!caps->data_points)
-		return;
-
-	/*
-	 * Handle the case where brightness is below the first data point
-	 * Interpolate between (0,0) and (first_signal, first_lum)
-	 */
-	if (brightness < caps->luminance_data[0].input_signal) {
-		lum = DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightness,
-					caps->luminance_data[0].input_signal);
-		goto scale;
-	}
-
-	left = 0;
-	right = caps->data_points - 1;
-	while (left <= right) {
-		int mid = left + (right - left) / 2;
-		u8 signal = caps->luminance_data[mid].input_signal;
-
-		/* Exact match found */
-		if (signal == brightness) {
-			lum = caps->luminance_data[mid].luminance;
-			goto scale;
-		}
-
-		if (signal < brightness)
-			left = mid + 1;
-		else
-			right = mid - 1;
-	}
-
-	/* verify bound */
-	if (left >= caps->data_points)
-		left = caps->data_points - 1;
-
-	/* At this point, left > right */
-	lower_signal = caps->luminance_data[right].input_signal;
-	upper_signal = caps->luminance_data[left].input_signal;
-	lower_lum = caps->luminance_data[right].luminance;
-	upper_lum = caps->luminance_data[left].luminance;
-
-	/* interpolate */
-	if (right == left || !lower_lum)
-		lum = upper_lum;
-	else
-		lum = lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
-						    (brightness - lower_signal),
-						    upper_signal - lower_signal);
-scale:
-	*user_brightness = scale_fw_to_input(min, max,
-					     DIV_ROUND_CLOSEST(lum * brightness, 101));
-}
-
-static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-					uint32_t brightness)
-{
-	unsigned int min, max;
-
-	if (!get_brightness_range(caps, &min, &max))
-		return brightness;
-
-	convert_custom_brightness(caps, min, max, &brightness);
-
-	// Rescale 0..max to min..max
-	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
-}
-
-static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
-				      uint32_t brightness)
-{
-	unsigned int min, max;
-
-	if (!get_brightness_range(caps, &min, &max))
-		return brightness;
-
-	if (brightness < min)
-		return 0;
-	// Rescale min..max to 0..max
-	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
-				 max - min);
-}
-
-static struct dc_stream_state *dm_find_stream_with_link(
-	struct amdgpu_display_manager *dm,
-	struct dc_link *link)
-{
-	struct dc_state *cur_dc_state = dm->dc->current_state;
-	struct dc_stream_state *stream = NULL;
-	int i;
-
-	for (i = 0; i < cur_dc_state->stream_count; i++) {
-		stream = cur_dc_state->streams[i];
-		if (stream->link == link)
-			return stream;
-	}
-
-	return NULL;
-}
-
-static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
-					 int bl_idx,
-					 u32 user_brightness)
-{
-	struct amdgpu_dm_backlight_caps *caps;
-	struct dc_link *link;
-	u32 brightness = 0;
-	bool rc = false, reallow_idle = false;
-	struct drm_connector *connector;
-	struct dc_stream_state *stream;
-	unsigned int min, max;
-
-	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
-		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
-
-		if (aconnector->bl_idx != bl_idx)
-			continue;
-
-		/* if connector is off, save the brightness for next time it's on */
-		if (!aconnector->base.encoder) {
-			dm->brightness[bl_idx] = user_brightness;
-			dm->actual_brightness[bl_idx] = 0;
-			return;
-		}
-	}
-
-	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	caps = &dm->backlight_caps[bl_idx];
-
-	dm->brightness[bl_idx] = user_brightness;
-	/* update scratch register */
-	if (bl_idx == 0)
-		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
-	link = (struct dc_link *)dm->backlight_link[bl_idx];
-
-	/* Apply brightness quirk */
-	if (caps->brightness_mask)
-		brightness |= caps->brightness_mask;
-
-	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
-					   user_brightness,
-					   brightness,
-					   caps->aux_support,
-					   power_supply_is_system_supplied() > 0);
-	}
-
-	stream = dm_find_stream_with_link(dm, link);
-	if (!stream)
-		return;
-
-	mutex_lock(&dm->dc_lock);
-	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
-		dc_allow_idle_optimizations(dm->dc, false);
-		reallow_idle = true;
-	}
-
-	if (caps->aux_support) {
-		rc = mod_power_set_backlight_nits(dm->power_module, stream, brightness,
-			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
-	} else {
-		/* power module uses millipercent */
-		get_brightness_range(caps, &min, &max);
-		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
-		rc = mod_power_set_backlight_percent(dm->power_module, stream,
-						     brightness, 0, false);
-	}
-
-	/*
-	 * Some kms clients create a ramped backlight transition effect
-	 * by rapidly changing the backlight. Yet we must wait on dmcub
-	 * fw to exit psr/replay before programming backlight. To
-	 * prevent lag, keep disable psr/replay and let the next atomic
-	 * flip clear the event.
-	 *
-	 * ToDo: use ISM to handle rapidly backlight change
-	 *
-	 * Rapidly backlight change is similar to rapidly cursor events,
-	 * which is now handled by ISM. ISM can delay the event until system
-	 * is really idle, so we may use ISM to handle backlight change as well.
-	 */
-	amdgpu_dm_psr_set_event(dm, stream, true,
-		psr_event_hw_programming, true);
-	amdgpu_dm_replay_set_event(dm, stream, true,
-		replay_event_hw_programming, true);
-
-	if (dm->dc->caps.ips_support && reallow_idle)
-		dc_allow_idle_optimizations(dm->dc, true);
-
-	mutex_unlock(&dm->dc_lock);
-
-	if (rc)
-		dm->actual_brightness[bl_idx] = user_brightness;
-}
-
-static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
-{
-	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
-
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (bd == dm->backlight_dev[i])
-			break;
-	}
-	if (i >= AMDGPU_DM_MAX_NUM_EDP)
-		i = 0;
-	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
-
-	return 0;
-}
-
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
-					 int bl_idx)
-{
-	int ret;
-	struct amdgpu_dm_backlight_caps caps;
-	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
-
-	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	caps = dm->backlight_caps[bl_idx];
-
-	if (caps.aux_support) {
-		u32 avg, peak;
-
-		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
-			return dm->brightness[bl_idx];
-		return convert_brightness_to_user(&caps, avg);
-	}
-
-	ret = dc_link_get_backlight_level(link);
-
-	if (ret == DC_ERROR_UNEXPECTED)
-		return dm->brightness[bl_idx];
-
-	return convert_brightness_to_user(&caps, ret);
-}
-
-static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
-{
-	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
-
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (bd == dm->backlight_dev[i])
-			break;
-	}
-	if (i >= AMDGPU_DM_MAX_NUM_EDP)
-		i = 0;
-	return amdgpu_dm_backlight_get_level(dm, i);
-}
-
-static const struct backlight_ops amdgpu_dm_backlight_ops = {
-	.options = BL_CORE_SUSPENDRESUME,
-	.get_brightness = amdgpu_dm_backlight_get_brightness,
-	.update_status	= amdgpu_dm_backlight_update_status,
-};
-
-static void
-amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
-{
-	struct drm_device *drm = aconnector->base.dev;
-	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
-	struct backlight_properties props = { 0 };
-	struct amdgpu_dm_backlight_caps *caps;
-	char bl_name[16];
-	int min, max;
-	int real_brightness;
-	int init_brightness;
-
-	if (aconnector->bl_idx == -1)
-		return;
-
-	if (!acpi_video_backlight_use_native()) {
-		drm_info(drm, "Skipping amdgpu DM backlight registration\n");
-		/* Try registering an ACPI video backlight device instead. */
-		acpi_video_register_backlight();
-		return;
-	}
-
-	caps = &dm->backlight_caps[aconnector->bl_idx];
-	if (get_brightness_range(caps, &min, &max)) {
-		if (power_supply_is_system_supplied() > 0)
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
-		else
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
-		/* min is zero, so max needs to be adjusted */
-		props.max_brightness = max - min;
-		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-			caps->ac_level, caps->dc_level);
-	} else
-		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
-
-	init_brightness = props.brightness;
-
-	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
-		drm_info(drm, "Using custom brightness curve\n");
-		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
-	} else
-		props.scale = BACKLIGHT_SCALE_LINEAR;
-	props.type = BACKLIGHT_RAW;
-
-	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-		 drm->primary->index + aconnector->bl_idx);
-
-	dm->backlight_dev[aconnector->bl_idx] =
-		backlight_device_register(bl_name, aconnector->base.kdev, dm,
-					  &amdgpu_dm_backlight_ops, &props);
-	dm->brightness[aconnector->bl_idx] = props.brightness;
-
-	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
-		drm_err(drm, "DM: Backlight registration failed!\n");
-		dm->backlight_dev[aconnector->bl_idx] = NULL;
-	} else {
-		/*
-		 * dm->brightness[x] can be inconsistent just after startup until
-		 * ops.get_brightness is called.
-		 */
-		real_brightness =
-			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
-
-		if (real_brightness != init_brightness) {
-			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
-			dm->brightness[aconnector->bl_idx] = real_brightness;
-		}
-		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
-	}
-}
-
 static int initialize_plane(struct amdgpu_display_manager *dm,
 			    struct amdgpu_mode_info *mode_info, int plane_id,
 			    enum drm_plane_type plane_type,
@@ -5611,38 +5126,6 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 }
 
 
-static void setup_backlight_device(struct amdgpu_display_manager *dm,
-				   struct amdgpu_dm_connector *aconnector)
-{
-	struct amdgpu_dm_backlight_caps *caps;
-	struct dc_link *link = aconnector->dc_link;
-	int bl_idx = dm->num_of_edps;
-
-	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
-	    link->type == dc_connection_none)
-		return;
-
-	if (dm->num_of_edps >= AMDGPU_DM_MAX_NUM_EDP) {
-		drm_warn(adev_to_drm(dm->adev), "Too much eDP connections, skipping backlight setup for additional eDPs\n");
-		return;
-	}
-
-	aconnector->bl_idx = bl_idx;
-
-	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	dm->backlight_link[bl_idx] = link;
-	dm->num_of_edps++;
-
-	update_connector_ext_caps(aconnector);
-	caps = &dm->backlight_caps[aconnector->bl_idx];
-
-	/* Only offer ABM property when non-OLED and user didn't turn off by module parameter */
-	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
-		drm_object_attach_property(&aconnector->base.base,
-					   dm->adev->mode_info.abm_level_property,
-					   ABM_SYSFS_CONTROL);
-}
-
 static void amdgpu_set_panel_orientation(struct drm_connector *connector);
 
 
@@ -5883,7 +5366,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 			if (ret) {
 				amdgpu_dm_update_connector_after_detect(aconnector);
-				setup_backlight_device(dm, aconnector);
+				amdgpu_dm_setup_backlight_device(dm, aconnector);
 
 				/* Disable PSR if Replay can be enabled */
 				if (replay_feature_enabled)
@@ -7960,103 +7443,6 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	return ret;
 }
 
-/**
- * DOC: panel power savings
- *
- * The display manager allows you to set your desired **panel power savings**
- * level (between 0-4, with 0 representing off), e.g. using the following::
- *
- *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
- *
- * Modifying this value can have implications on color accuracy, so tread
- * carefully.
- */
-
-static ssize_t panel_power_savings_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	u8 val;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	val = to_dm_connector_state(connector->state)->abm_level ==
-		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
-		to_dm_connector_state(connector->state)->abm_level;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	return sysfs_emit(buf, "%u\n", val);
-}
-
-static ssize_t panel_power_savings_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	long val;
-	int ret;
-
-	ret = kstrtol(buf, 0, &val);
-
-	if (ret)
-		return ret;
-
-	if (val < 0 || val > 4)
-		return -EINVAL;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
-		ret = -EBUSY;
-	else
-		to_dm_connector_state(connector->state)->abm_level = val ?:
-			ABM_LEVEL_IMMEDIATE_DISABLE;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	if (ret)
-		return ret;
-
-	drm_kms_helper_hotplug_event(dev);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(panel_power_savings);
-
-static struct attribute *amdgpu_attrs[] = {
-	&dev_attr_panel_power_savings.attr,
-	NULL
-};
-
-static const struct attribute_group amdgpu_group = {
-	.name = "amdgpu",
-	.attrs = amdgpu_attrs
-};
-
-static bool
-amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
-{
-	if (amdgpu_dm_abm_level >= 0)
-		return false;
-
-	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
-		return false;
-
-	/* check for OLED panels */
-	if (amdgpu_dm_connector->bl_idx >= 0) {
-		struct drm_device *drm = amdgpu_dm_connector->base.dev;
-		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
-		struct amdgpu_dm_backlight_caps *caps;
-
-		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
-		if (caps->aux_support)
-			return false;
-	}
-
-	return true;
-}
-
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7d37c1612131..01f614e6da75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1167,5 +1167,4 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
 
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
 
-void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
new file mode 100644
index 000000000000..3770e8dafdbf
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -0,0 +1,660 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ */
+
+#include "dc.h"
+#include "dc/dc_dmub_srv.h"
+#include "dc/dc_state.h"
+#include "dc/dc_stat.h"
+
+#include "amdgpu.h"
+#include "amdgpu_display.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_backlight.h"
+#include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
+#include "amdgpu_atombios.h"
+
+#include "modules/inc/mod_power.h"
+
+#include <linux/backlight.h>
+#include <linux/power_supply.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_utils.h>
+
+#include <acpi/video.h>
+
+#include "amdgpu_dm_trace.h"
+#include "amd_shared.h"
+
+#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
+#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
+#define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
+
+void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+				     int bl_idx)
+{
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
+
+	if (caps->caps_valid)
+		return;
+
+#if defined(CONFIG_ACPI)
+	amdgpu_acpi_get_backlight_caps(caps);
+
+	/* validate the firmware value is sane */
+	if (caps->caps_valid) {
+		int spread = caps->max_input_signal - caps->min_input_signal;
+
+		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    caps->min_input_signal < 0 ||
+		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    spread < AMDGPU_DM_MIN_SPREAD) {
+			drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
+				      caps->min_input_signal, caps->max_input_signal);
+			caps->caps_valid = false;
+		}
+	}
+
+	if (!caps->caps_valid) {
+		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+		caps->caps_valid = true;
+	}
+#else
+	if (caps->aux_support)
+		return;
+
+	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->caps_valid = true;
+#endif
+}
+
+static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
+				unsigned int *min, unsigned int *max)
+{
+	if (!caps)
+		return 0;
+
+	if (caps->aux_support) {
+		/* Firmware limits are in nits, DC API wants millinits. */
+		*max = 1000 * caps->aux_max_input_signal;
+		*min = 1000 * caps->aux_min_input_signal;
+	} else {
+		/* Firmware limits are 8-bit, PWM control is 16-bit. */
+		*max = 0x101 * caps->max_input_signal;
+		*min = 0x101 * caps->min_input_signal;
+	}
+	return 1;
+}
+
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
+static inline u32 scale_input_to_fw(int min, int max, u64 input)
+{
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+}
+
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
+static inline u32 scale_fw_to_input(int min, int max, u64 input)
+{
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
+}
+
+static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
+				      unsigned int min, unsigned int max,
+				      uint32_t *user_brightness)
+{
+	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
+	int left, right;
+
+	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+		return;
+
+	if (!caps->data_points)
+		return;
+
+	/*
+	 * Handle the case where brightness is below the first data point
+	 * Interpolate between (0,0) and (first_signal, first_lum)
+	 */
+	if (brightness < caps->luminance_data[0].input_signal) {
+		lum = DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightness,
+					caps->luminance_data[0].input_signal);
+		goto scale;
+	}
+
+	left = 0;
+	right = caps->data_points - 1;
+	while (left <= right) {
+		int mid = left + (right - left) / 2;
+		u8 signal = caps->luminance_data[mid].input_signal;
+
+		/* Exact match found */
+		if (signal == brightness) {
+			lum = caps->luminance_data[mid].luminance;
+			goto scale;
+		}
+
+		if (signal < brightness)
+			left = mid + 1;
+		else
+			right = mid - 1;
+	}
+
+	/* verify bound */
+	if (left >= caps->data_points)
+		left = caps->data_points - 1;
+
+	/* At this point, left > right */
+	lower_signal = caps->luminance_data[right].input_signal;
+	upper_signal = caps->luminance_data[left].input_signal;
+	lower_lum = caps->luminance_data[right].luminance;
+	upper_lum = caps->luminance_data[left].luminance;
+
+	/* interpolate */
+	if (right == left || !lower_lum)
+		lum = upper_lum;
+	else
+		lum = lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
+						    (brightness - lower_signal),
+						    upper_signal - lower_signal);
+scale:
+	*user_brightness = scale_fw_to_input(min, max,
+					     DIV_ROUND_CLOSEST(lum * brightness, 101));
+}
+
+static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
+					uint32_t brightness)
+{
+	unsigned int min, max;
+
+	if (!get_brightness_range(caps, &min, &max))
+		return brightness;
+
+	convert_custom_brightness(caps, min, max, &brightness);
+
+	/* Rescale 0..max to min..max */
+	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
+}
+
+static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
+				      uint32_t brightness)
+{
+	unsigned int min, max;
+
+	if (!get_brightness_range(caps, &min, &max))
+		return brightness;
+
+	if (brightness < min)
+		return 0;
+	/* Rescale min..max to 0..max */
+	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
+				 max - min);
+}
+
+static struct dc_stream_state *dm_find_stream_with_link(
+	struct amdgpu_display_manager *dm,
+	struct dc_link *link)
+{
+	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_stream_state *stream = NULL;
+	int i;
+
+	for (i = 0; i < cur_dc_state->stream_count; i++) {
+		stream = cur_dc_state->streams[i];
+		if (stream->link == link)
+			return stream;
+	}
+
+	return NULL;
+}
+
+void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+				   int bl_idx,
+				   u32 user_brightness)
+{
+	struct amdgpu_dm_backlight_caps *caps;
+	struct dc_link *link;
+	u32 brightness = 0;
+	bool rc = false, reallow_idle = false;
+	struct drm_connector *connector;
+	struct dc_stream_state *stream;
+	unsigned int min, max;
+
+	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		if (aconnector->bl_idx != bl_idx)
+			continue;
+
+		/* if connector is off, save the brightness for next time it's on */
+		if (!aconnector->base.encoder) {
+			dm->brightness[bl_idx] = user_brightness;
+			dm->actual_brightness[bl_idx] = 0;
+			return;
+		}
+	}
+
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = &dm->backlight_caps[bl_idx];
+
+	dm->brightness[bl_idx] = user_brightness;
+	/* update scratch register */
+	if (bl_idx == 0)
+		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
+	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
+	link = (struct dc_link *)dm->backlight_link[bl_idx];
+
+	/* Apply brightness quirk */
+	if (caps->brightness_mask)
+		brightness |= caps->brightness_mask;
+
+	if (trace_amdgpu_dm_brightness_enabled()) {
+		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+					   user_brightness,
+					   brightness,
+					   caps->aux_support,
+					   power_supply_is_system_supplied() > 0);
+	}
+
+	stream = dm_find_stream_with_link(dm, link);
+	if (!stream)
+		return;
+
+	mutex_lock(&dm->dc_lock);
+	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
+		dc_allow_idle_optimizations(dm->dc, false);
+		reallow_idle = true;
+	}
+
+	if (caps->aux_support) {
+		rc = mod_power_set_backlight_nits(dm->power_module, stream, brightness,
+			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
+	} else {
+		/* power module uses millipercent */
+		get_brightness_range(caps, &min, &max);
+		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
+		rc = mod_power_set_backlight_percent(dm->power_module, stream,
+						     brightness, 0, false);
+	}
+
+	/*
+	 * Some kms clients create a ramped backlight transition effect
+	 * by rapidly changing the backlight. Yet we must wait on dmcub
+	 * fw to exit psr/replay before programming backlight. To
+	 * prevent lag, keep disable psr/replay and let the next atomic
+	 * flip clear the event.
+	 *
+	 * ToDo: use ISM to handle rapidly backlight change
+	 *
+	 * Rapidly backlight change is similar to rapidly cursor events,
+	 * which is now handled by ISM. ISM can delay the event until system
+	 * is really idle, so we may use ISM to handle backlight change as well.
+	 */
+	amdgpu_dm_psr_set_event(dm, stream, true,
+		psr_event_hw_programming, true);
+	amdgpu_dm_replay_set_event(dm, stream, true,
+		replay_event_hw_programming, true);
+
+	if (dm->dc->caps.ips_support && reallow_idle)
+		dc_allow_idle_optimizations(dm->dc, true);
+
+	mutex_unlock(&dm->dc_lock);
+
+	if (rc)
+		dm->actual_brightness[bl_idx] = user_brightness;
+}
+
+static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
+{
+	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
+
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
+
+	return 0;
+}
+
+static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+					 int bl_idx)
+{
+	int ret;
+	struct amdgpu_dm_backlight_caps caps;
+	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
+
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = dm->backlight_caps[bl_idx];
+
+	if (caps.aux_support) {
+		u32 avg, peak;
+
+		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
+			return dm->brightness[bl_idx];
+		return convert_brightness_to_user(&caps, avg);
+	}
+
+	ret = dc_link_get_backlight_level(link);
+
+	if (ret == DC_ERROR_UNEXPECTED)
+		return dm->brightness[bl_idx];
+
+	return convert_brightness_to_user(&caps, ret);
+}
+
+static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
+{
+	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
+
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	return amdgpu_dm_backlight_get_level(dm, i);
+}
+
+static const struct backlight_ops amdgpu_dm_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.get_brightness = amdgpu_dm_backlight_get_brightness,
+	.update_status	= amdgpu_dm_backlight_update_status,
+};
+
+void
+amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_device *drm = aconnector->base.dev;
+	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
+	char bl_name[16];
+	int min, max;
+	int real_brightness;
+	int init_brightness;
+
+	if (aconnector->bl_idx == -1)
+		return;
+
+	if (!acpi_video_backlight_use_native()) {
+		drm_info(drm, "Skipping amdgpu DM backlight registration\n");
+		/* Try registering an ACPI video backlight device instead. */
+		acpi_video_register_backlight();
+		return;
+	}
+
+	caps = &dm->backlight_caps[aconnector->bl_idx];
+	if (get_brightness_range(caps, &min, &max)) {
+		if (power_supply_is_system_supplied() > 0)
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
+		else
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
+		/* min is zero, so max needs to be adjusted */
+		props.max_brightness = max - min;
+		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
+			caps->ac_level, caps->dc_level);
+	} else
+		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
+
+	init_brightness = props.brightness;
+
+	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
+		drm_info(drm, "Using custom brightness curve\n");
+		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
+	} else
+		props.scale = BACKLIGHT_SCALE_LINEAR;
+	props.type = BACKLIGHT_RAW;
+
+	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
+		 drm->primary->index + aconnector->bl_idx);
+
+	dm->backlight_dev[aconnector->bl_idx] =
+		backlight_device_register(bl_name, aconnector->base.kdev, dm,
+					  &amdgpu_dm_backlight_ops, &props);
+	dm->brightness[aconnector->bl_idx] = props.brightness;
+
+	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
+		drm_err(drm, "DM: Backlight registration failed!\n");
+		dm->backlight_dev[aconnector->bl_idx] = NULL;
+	} else {
+		/*
+		 * dm->brightness[x] can be inconsistent just after startup until
+		 * ops.get_brightness is called.
+		 */
+		real_brightness =
+			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+
+		if (real_brightness != init_brightness) {
+			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
+			dm->brightness[aconnector->bl_idx] = real_brightness;
+		}
+		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+	}
+}
+
+void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
+{
+	const struct drm_panel_backlight_quirk *panel_backlight_quirk;
+	struct amdgpu_dm_backlight_caps *caps;
+	struct drm_connector *conn_base;
+	struct amdgpu_device *adev;
+	struct drm_luminance_range_info *luminance_range;
+	struct drm_device *drm;
+
+	if (aconnector->bl_idx == -1 ||
+	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
+		return;
+
+	conn_base = &aconnector->base;
+	drm = conn_base->dev;
+	adev = drm_to_adev(drm);
+
+	caps = &adev->dm.backlight_caps[aconnector->bl_idx];
+	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
+	caps->aux_support = false;
+
+	if (caps->ext_caps->bits.oled == 1
+	    /*
+	     * ||
+	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
+	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
+	     */)
+		caps->aux_support = true;
+
+	if (amdgpu_backlight == 0)
+		caps->aux_support = false;
+	else if (amdgpu_backlight == 1)
+		caps->aux_support = true;
+	if (caps->aux_support)
+		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+
+	luminance_range = &conn_base->display_info.luminance_range;
+
+	if (luminance_range->max_luminance)
+		caps->aux_max_input_signal = luminance_range->max_luminance;
+	else
+		caps->aux_max_input_signal = 512;
+
+	if (luminance_range->min_luminance)
+		caps->aux_min_input_signal = luminance_range->min_luminance;
+	else
+		caps->aux_min_input_signal = 1;
+
+	panel_backlight_quirk =
+		drm_get_panel_backlight_quirk(aconnector->drm_edid);
+	if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
+		if (panel_backlight_quirk->min_brightness) {
+			caps->min_input_signal =
+				panel_backlight_quirk->min_brightness - 1;
+			drm_info(drm,
+				 "Applying panel backlight quirk, min_brightness: %d\n",
+				 caps->min_input_signal);
+		}
+		if (panel_backlight_quirk->brightness_mask) {
+			drm_info(drm,
+				 "Applying panel backlight quirk, brightness_mask: 0x%X\n",
+				 panel_backlight_quirk->brightness_mask);
+			caps->brightness_mask =
+				panel_backlight_quirk->brightness_mask;
+		}
+	}
+}
+
+void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
+			    struct amdgpu_dm_connector *aconnector)
+{
+	struct amdgpu_dm_backlight_caps *caps;
+	struct dc_link *link = aconnector->dc_link;
+	int bl_idx = dm->num_of_edps;
+
+	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
+	    link->type == dc_connection_none)
+		return;
+
+	if (dm->num_of_edps >= AMDGPU_DM_MAX_NUM_EDP) {
+		drm_warn(adev_to_drm(dm->adev), "Too much eDP connections, skipping backlight setup for additional eDPs\n");
+		return;
+	}
+
+	aconnector->bl_idx = bl_idx;
+
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	dm->backlight_link[bl_idx] = link;
+	dm->num_of_edps++;
+
+	amdgpu_dm_update_connector_ext_caps(aconnector);
+	caps = &dm->backlight_caps[aconnector->bl_idx];
+
+	/* Only offer ABM property when non-OLED and user didn't turn off by module parameter */
+	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
+		drm_object_attach_property(&aconnector->base.base,
+					   dm->adev->mode_info.abm_level_property,
+					   ABM_SYSFS_CONTROL);
+}
+
+/**
+ * DOC: panel power savings
+ *
+ * The display manager allows you to set your desired **panel power savings**
+ * level (between 0-4, with 0 representing off), e.g. using the following::
+ *
+ *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
+ *
+ * Modifying this value can have implications on color accuracy, so tread
+ * carefully.
+ */
+
+static ssize_t panel_power_savings_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct drm_connector *connector = dev_get_drvdata(device);
+	struct drm_device *dev = connector->dev;
+	u8 val;
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+	val = to_dm_connector_state(connector->state)->abm_level ==
+		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
+		to_dm_connector_state(connector->state)->abm_level;
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t panel_power_savings_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct drm_connector *connector = dev_get_drvdata(device);
+	struct drm_device *dev = connector->dev;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 4)
+		return -EINVAL;
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
+		ret = -EBUSY;
+	else
+		to_dm_connector_state(connector->state)->abm_level = val ?:
+			ABM_LEVEL_IMMEDIATE_DISABLE;
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	if (ret)
+		return ret;
+
+	drm_kms_helper_hotplug_event(dev);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(panel_power_savings);
+
+static struct attribute *amdgpu_attrs[] = {
+	&dev_attr_panel_power_savings.attr,
+	NULL
+};
+
+const struct attribute_group amdgpu_group = {
+	.name = "amdgpu",
+	.attrs = amdgpu_attrs
+};
+
+bool
+amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
+{
+	if (amdgpu_dm_abm_level >= 0)
+		return false;
+
+	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
+		return false;
+
+	/* check for OLED panels */
+	if (amdgpu_dm_connector->bl_idx >= 0) {
+		struct drm_device *drm = amdgpu_dm_connector->base.dev;
+		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
+		struct amdgpu_dm_backlight_caps *caps;
+
+		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
+		if (caps->aux_support)
+			return false;
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
new file mode 100644
index 000000000000..acff23f9feef
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __AMDGPU_DM_BACKLIGHT_H__
+#define __AMDGPU_DM_BACKLIGHT_H__
+
+struct amdgpu_display_manager;
+struct amdgpu_dm_connector;
+struct drm_connector;
+struct attribute_group;
+
+void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+				     int bl_idx);
+void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+				   int bl_idx, u32 user_brightness);
+void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
+			    struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
+
+extern const struct attribute_group amdgpu_group;
+
+#endif /* __AMDGPU_DM_BACKLIGHT_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 84dcb573d98f..0fdcf70256cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -32,6 +32,7 @@
 #include "dm_services.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_backlight.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_trace.h"
-- 
2.43.0

