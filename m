Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FF9C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B9310E0EC;
	Thu,  9 Jul 2026 21:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c3e7uM0p";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA0010E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8vTIo6qURXP3bw7BcIZnwhHKWp7WpH1ofePucDLMumIOhzXQElrYwv+z7IxVWLU3jQqIJXHN8Ii3zDaVCAgNbZ+Lf7pa4x3IYWe1dlFIqyA/TPQe18aqCOGD28nbqvcIq3j3kjubCn8wthdk7QEgRKJ9dHq8uxlyFRUFey+5M1GfU6oDSRJW1sXfjUngAAbehws0+YrK/guJjoeXsAWrs73e8oMHXV/X60dWAFDPJO//CJ47nuUw3SBinvIh16myccl/UAiSp8ZinAE5DW522fsqfB04MAmW4G47s3py3xkV+/y9V8IwPddukG0kTO+/0QM8mabf3cORP2rZ7zTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+JRw+MO4R4mzb4CqNXBc3t+glTlCAberH0N7ltT12M=;
 b=oDtKj6aPT6bjds+2B8vIg8c/EH0PYgXiRPiftymJzw1YFR4w32P/bpOo+dnzRDc7vQ1dmLOAn83hdQeOHAhbjdJ96Rv3mIlKxCXZg/Q+jM3f2PmGga8+gTttKdvZVcbhtC6AzKx7gUfzLRPlsJgsQWHQWnndzYptJLn63q3NEvERsHrpmKxUO83x2lHKC+0y4kF49s/aeYU7GCb0iUn5cjySpMxACaow2nsrWTat7lISW7EGfDkgkKYrgZDyis6aYkBVrzmOrrNEmEcCjZepc1lbPYKN/JuPAJNiFZoIJGJmCD43i3CRbUPqAalBJvzGLAeWQ9s3pGzOOytFuiFzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+JRw+MO4R4mzb4CqNXBc3t+glTlCAberH0N7ltT12M=;
 b=c3e7uM0pdpzmzBvEA/RmOPjq+8VzSABv/EFMuSpDSnWRxiBo+lJknen6/Vfi6pwHGQ8XpdoY/+MY2c9d41Bb5onqDKFh9KdjWPoHJGiOtrQpyKItxY50mUgHK/D35kcSGDauIo+Cz48K/KnJ0mayoopVBAEG99hv72k5Gqth9aA=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:42 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::4a) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:41 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:34 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 03/80] drm/amd/display: Enable CACP on Linux
Date: Thu, 9 Jul 2026 16:47:31 -0400
Message-ID: <20260709205936.5719-4-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8094c833-f8b4-4757-2cb0-08deddfd46f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 22LoBWI66Pb/vegLK1DsE5AaJUOJv7Wbj83c1s0NXBEfbjmdU/N6dSXf60nRGKiYyorWTL9i7k3A4gmfIGmp//cTnuG3EfuIoAohaUpDY34dGyRChv+FPxL7/rYGJ50znA0T00s0ObBqUMCdFfYfLLFlcsB6m341Hm59JxcAYkrpTbog6483p1LYBRPBhacMCB5kyAH4qvpV+qBBceMVZl0tr6m8eRbKJDIsqGhl1q1Faawzhc8N4VBUUa3Lb1egDxoIiEhUxbNEEXY50DYhbK4/8158TbAbutk8crv6+hRa7xDg5IenQwQ4wZ1k+cYNnqY2Wj8PutzguyOXj6JamgDDOPPgaVrOzgZMgJ86punJM0n4KMjU+lVPVm3SePm0opTO09IrXboh706xJMbVqtVsmTK7eq96YW5tYuiIUfzRHKe8i1uB7IT3Xu5Vq5YT++WZLQEqCBa/1fnbQmj7XzTSYBGxK5g6eGOn3x/upALF9ku4JT1jUcJ8kE1SbFebdGyxalDeObPNwMQeO+21gj884hfaQLwk/b9vkM6cc7rU7/CUeK1FUQ1c1IdIyXsvn82UCVGbpaasmhYLCcOfL/JxhoyecaD310jlsDq2ozCjNUtgJkgmGtolVVjiub3icUt/stK0UaXpKZkaIIveTQWDNxJhaF0xTPNkJNm63KPI0dXvDNcpUXov4ivN4/p7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BzoHkjc9gACxSV4yzASNBTshylbEWYhrNqb8urBm4RLb5UhizUJ92wzrA0rrlOkW1R7rhhYu2ZvPtLVVZodEPIcYGfJ+M4cOyGowzxPpBvgfyADHw2LjJuuKYa3zcJD8fMNNaKwfdWmAJWnDab2CyZ9qtE6wrUctnWln7P7jgX67Um2fi6E9vxdKgrx6k/0wxVdatWzFFEOneLmfDQuG4kSNUQqY+AR5nLCRwn35LL5xTawULctNRYRFkaQc0L8m8J9Go+hccX8LyEoYRtiaZzS7FOx4Lt3x3+m51fXTbRoeIiRfrmmRS0ckofpmviyFIaDE8LVzpXiHpfcndspV5dvL4evS3+FLqvfHK3t5HjD5xyD+DYLCzZp3RmcRH+2gJnYfHv/qbcpycZVPF/C6CbnuEsH+GIKavYyXoCuUksa32PMHk6DeR7FpAlFLOoFc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:41.9630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8094c833-f8b4-4757-2cb0-08deddfd46f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463
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

From: Chenyu Chen <chen-yu.chen@amd.com>

[Why]
Enable OLED panels to save more power on the Linux platform by
enabling CACP support on Linux.

[How]
Update abm_feature_support() to return ABM_CACP_SUPPORT for OLED
panels. Enable ABM property for all eDP panels including OLED to
support CACP via set_abm_level.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  23 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  53 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  73 +++++-
 .../drm/amd/display/dc/dce/dmub_abm_cacp.c    | 213 ++++++++++++++++++
 .../drm/amd/display/dc/dce/dmub_abm_cacp.h    |  20 ++
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  40 +++-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   8 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   3 +
 .../drm/amd/display/modules/inc/mod_power.h   |  11 +
 .../drm/amd/display/modules/power/power_abm.c | 126 +++++++++++
 .../amd/display/modules/power/power_helpers.h |  10 +
 15 files changed, 566 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 33f4be403a65..11d54897a894 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -559,7 +559,6 @@ EXPORT_IF_KUNIT(amdgpu_dm_update_connector_ext_caps);
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector)
 {
-	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;

@@ -579,10 +578,12 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 	dm->num_of_edps++;

 	amdgpu_dm_update_connector_ext_caps(aconnector);
-	caps = &dm->backlight_caps[aconnector->bl_idx];

-	/* Only offer ABM property when non-OLED and user didn't turn off by module parameter */
-	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
+	/* Offer ABM property when user didn't turn off by module parameter.
+	 * OLED panels are included to support CACP (Content Adaptive
+	 * Contrast and Power) feature via set_abm_level.
+	 */
+	if (amdgpu_dm_abm_level < 0)
 		drm_object_attach_property(&aconnector->base.base,
 					   dm->adev->mode_info.abm_level_property,
 					   ABM_SYSFS_CONTROL);
@@ -666,22 +667,16 @@ const struct attribute_group amdgpu_group = {
 bool
 amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 {
+	struct dc_link *link = amdgpu_dm_connector->dc_link;
+
 	if (amdgpu_dm_abm_level >= 0)
 		return false;

 	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
 		return false;

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
+	if (link->panel_type != PANEL_TYPE_LCD && !link->panel_config.cacp.cacp_supported)
+		return false;

 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 785333d9ed3b..2d10ae5e7616 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -392,32 +392,31 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 	return NULL;
 }

-static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
+static void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_display_info *display_info = &connector->display_info;
 	struct dc_link *link = aconnector->dc_link;
 	struct amdgpu_device *adev;
+	enum dc_panel_type panel_type = PANEL_TYPE_NONE;

 	adev = drm_to_adev(connector->dev);

-	link->panel_type = PANEL_TYPE_NONE;
-
 	switch (display_info->amd_vsdb.panel_type) {
 	case AMD_VSDB_PANEL_TYPE_OLED:
-		link->panel_type = PANEL_TYPE_OLED;
+		panel_type = PANEL_TYPE_OLED;
 		break;
 	case AMD_VSDB_PANEL_TYPE_MINILED:
-		link->panel_type = PANEL_TYPE_MINILED;
+		panel_type = PANEL_TYPE_MINILED;
 		break;
 	}

 	/* If VSDB didn't determine panel type, check DPCD ext caps */
-	if (link->panel_type == PANEL_TYPE_NONE) {
+	if (panel_type == PANEL_TYPE_NONE) {
 		if (link->dpcd_sink_ext_caps.bits.miniled == 1)
-			link->panel_type = PANEL_TYPE_MINILED;
+			panel_type = PANEL_TYPE_MINILED;
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
-			link->panel_type = PANEL_TYPE_OLED;
+			panel_type = PANEL_TYPE_OLED;
 	}

 	/* If VSDB and DPCD didn't determine panel type, check DID */
@@ -428,7 +427,7 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 			link->panel_type = PANEL_TYPE_OLED;
 	}

-	if (link->panel_type == PANEL_TYPE_NONE) {
+	if (panel_type == PANEL_TYPE_NONE) {
 		struct drm_amd_vsdb_info *vsdb = &display_info->amd_vsdb;
 		u32 lum1_max = vsdb->luminance_range1.max_luminance;
 		u32 lum2_max = vsdb->luminance_range2.max_luminance;
@@ -437,9 +436,14 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 		    link->local_sink->edid_caps.manufacturer_id ==
 		    DDC_MANUFACTURERNAME_SAMSUNG &&
 		    lum1_max >= ((lum2_max * 3) / 2))
-			link->panel_type = PANEL_TYPE_MINILED;
+			panel_type = PANEL_TYPE_MINILED;
 	}

+	if (panel_type != PANEL_TYPE_NONE)
+		link->panel_type = panel_type;
+	else
+		link->panel_type = PANEL_TYPE_LCD;
+
 	if (link->panel_type == PANEL_TYPE_OLED)
 		drm_object_property_set_value(&connector->base,
 		    adev_to_drm(adev)->mode_config.panel_type_property,
@@ -456,6 +460,32 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
 }

+static void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
+{
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct dc_link *link = aconnector->dc_link;
+
+	link->panel_config.cacp.cacp_supported = true;
+
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 1, 4) ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 1, 6)) {
+		link->panel_config.cacp.cacp_supported = false;
+		return;
+	}
+
+	if (link->connector_signal != SIGNAL_TYPE_EDP &&
+	    link->connector_signal != SIGNAL_TYPE_LVDS) {
+		link->panel_config.cacp.cacp_supported = false;
+		return;
+	}
+
+	if (link->panel_type == PANEL_TYPE_LCD)
+		link->panel_config.cacp.cacp_supported = false;
+
+	drm_dbg_kms(aconnector->base.dev, "cacp_supported: %d\n",
+		    link->panel_config.cacp.cacp_supported);
+}
+
 DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))

 void amdgpu_dm_update_connector_after_detect(
@@ -581,7 +611,8 @@ void amdgpu_dm_update_connector_after_detect(

 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
 		amdgpu_dm_update_connector_ext_caps(aconnector);
-		dm_set_panel_type(aconnector);
+		amdgpu_dm_set_panel_type(aconnector);
+		amdgpu_dm_update_cacp_caps(aconnector);

 		if (aconnector->hdmi_comp_auto) {
 			if (sink->sink_signal != SIGNAL_TYPE_HDMI_FRL)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 13c1f7cd9d7d..2b59a0e9ca38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -632,6 +632,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SMARTMUX_DGPU = 10,
 	VISUAL_CONFIRM_REPLAY = 12,
 	VISUAL_CONFIRM_SUBVP = 14,
+	VISUAL_CONFIRM_ABM = 15,
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 	VISUAL_CONFIRM_FAMS2 = 19,
 	VISUAL_CONFIRM_HW_CURSOR = 20,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 90dd1ae7e953..5ba7a2fffcf0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1347,6 +1347,14 @@ struct dc_panel_config {
 	struct ilr {
 		bool optimize_edp_link_rate; /* eDP ILR */
 	} ilr;
+	/* CACP*/
+	struct cacp {
+		unsigned int cacp_supported;
+		unsigned int cacp_control_mode;
+		unsigned int strscl_valid;
+		unsigned int strscl_sdr[4];
+		unsigned int strscl_hdr[4];
+	} cacp;
 	/* Adaptive VariBright*/
 	struct adaptive_vb {
 		bool disable_adaptive_vb;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 986e0e7abbc2..72bf70d89b74 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -23,14 +23,14 @@
 # Makefile for common 'dce' logic
 # HW object file under this folder follow similar pattern for HW programming
 #   - register offset and/or shift + mask stored in the dec_hw struct
-#   - register programming through common macros that look up register
+#   - register programming through common macros that look up register
 #     offset/shift/mask stored in dce_hw struct

 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
 dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dmub_abm_lcd.o dce_panel_cntl.o \
-dmub_hw_lock_mgr.o dmub_outbox.o dmub_replay.o
+dmub_hw_lock_mgr.o dmub_outbox.o dmub_replay.o dmub_abm_cacp.o

 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index c8077905ff9e..99a2c944ddad 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -25,6 +25,7 @@

 #include "dmub_abm.h"
 #include "dmub_abm_lcd.h"
+#include "dmub_abm_cacp.h"
 #include "dc.h"
 #include "core_types.h"
 #include "dmub_cmd.h"
@@ -36,6 +37,7 @@

 #define ABM_FEATURE_NO_SUPPORT	0
 #define ABM_LCD_SUPPORT			1
+#define ABM_CACP_SUPPORT		2

 static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst)
 {
@@ -52,15 +54,48 @@ static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst
 	}

 	if (i < edp_num) {
-		ret = ABM_LCD_SUPPORT;
+		if (edp_links[panel_inst]->panel_config.cacp.cacp_supported)
+			ret = ABM_CACP_SUPPORT;
+		else if ((edp_links[panel_inst]->panel_type == PANEL_TYPE_LCD) ||
+				(edp_links[panel_inst]->panel_type == PANEL_TYPE_MINILED))
+			ret = ABM_LCD_SUPPORT;
 	}

 	return ret;
 }

+static enum dc_panel_type abm_get_paneltype(struct abm *abm, unsigned int panel_inst)
+{
+	struct dc_context *dc = abm->ctx;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	unsigned int i, edp_num;
+	enum dc_panel_type ret = PANEL_TYPE_NONE;
+
+	dc_get_edp_links(dc->dc, edp_links, &edp_num);
+
+	for (i = 0; i < edp_num; i++) {
+		if (edp_links[i]->link_status.link_active
+			&& panel_inst == i)
+			break;
+	}
+
+	if (i < edp_num)
+		ret = edp_links[panel_inst]->panel_type;
+
+	return ret;
+}
+
 static void dmub_abm_init_ex(struct abm *abm, uint32_t backlight, uint32_t user_level)
 {
+	unsigned int i = 0;
+	uint8_t panel_mask = 0;
+
 	dmub_abm_init(abm, backlight, user_level);
+	for (i = 0; i < MAX_NUM_EDP; i++)
+		panel_mask |= (0x01 << i);
+
+	if (panel_mask)
+		dmub_cacp_enable_fractional_pwm(abm, panel_mask);
 }

 static unsigned int dmub_abm_get_current_backlight_ex(struct abm *abm)
@@ -82,17 +117,23 @@ static bool dmub_abm_set_level_ex(struct abm *abm, uint32_t level)
 	bool ret = false;
 	unsigned int feature_support, i;
 	uint8_t panel_mask0 = 0;
+	uint8_t panel_mask1 = 0;

 	for (i = 0; i < MAX_NUM_EDP; i++) {
 		feature_support = abm_feature_support(abm, i);

 		if (feature_support == ABM_LCD_SUPPORT)
 			panel_mask0 |= (0x01 << i);
+		else if (feature_support == ABM_CACP_SUPPORT)
+			panel_mask1 |= (0x01 << i);
 	}

 	if (panel_mask0)
 		ret = dmub_abm_set_level(abm, level, panel_mask0);

+	if (panel_mask1)
+		ret = dmub_cacp_set_level(abm, level, panel_mask1);
+
 	return ret;
 }

@@ -107,6 +148,8 @@ static bool dmub_abm_init_config_ex(struct abm *abm,

 	if (feature_support == ABM_LCD_SUPPORT)
 		dmub_abm_init_config(abm, src, bytes, inst);
+	else if (feature_support == ABM_CACP_SUPPORT)
+		dmub_cacp_init(abm, src, bytes, inst);

 	return true;
 }
@@ -120,6 +163,8 @@ static bool dmub_abm_set_pause_ex(struct abm *abm, bool pause, unsigned int pane

 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_pause(abm, pause, panel_inst, stream_inst);
+	else if (feature_support == ABM_CACP_SUPPORT)
+		ret = dmub_cacp_set_pause(abm, pause, panel_inst, stream_inst);

 	return ret;
 }
@@ -163,6 +208,25 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm,

 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
+	else if (feature_support == ABM_CACP_SUPPORT)
+		ret = dmub_cacp_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
+
+	return ret;
+}
+
+static bool dmub_abm_set_event_ex(struct abm *abm, unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable, unsigned int scaling_strength_map,
+		unsigned int panel_inst)
+{
+	bool ret = false;
+	unsigned int feature_support;
+
+	feature_support = abm_feature_support(abm, panel_inst);
+
+	if (feature_support == ABM_LCD_SUPPORT)
+		ret = dmub_abm_set_event(abm, scaling_enable, scaling_strength_map, panel_inst);
+	else if (feature_support == ABM_CACP_SUPPORT)
+		ret = dmub_cacp_set_event(abm, full_screen, trans_info, hdr_mode, scaling_enable, panel_inst);

 	return ret;
 }
@@ -176,11 +240,17 @@ static bool dmub_abm_set_backlight_level_pwm_ex(struct abm *abm,
 	(void)controller_id;
 	bool ret = false;
 	unsigned int feature_support;
+	enum dc_panel_type panel_type = PANEL_TYPE_NONE;

 	feature_support = abm_feature_support(abm, panel_inst);

 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_backlight_level(abm, backlight_pwm_u16_16, frame_ramp, panel_inst);
+	else if (feature_support == ABM_CACP_SUPPORT) {
+		panel_type = abm_get_paneltype(abm, panel_inst);
+		if (panel_type == PANEL_TYPE_MINILED)
+			ret = dmub_cacp_set_backlight_level(abm, backlight_pwm_u16_16, frame_ramp, panel_inst);
+	}

 	return ret;
 }
@@ -194,6 +264,7 @@ static const struct abm_funcs abm_funcs = {
 	.set_abm_pause = dmub_abm_set_pause_ex,
 	.save_restore = dmub_abm_save_restore_ex,
 	.set_pipe_ex = dmub_abm_set_pipe_ex,
+	.set_abm_event = dmub_abm_set_event_ex,
 	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm_ex,
 };

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
new file mode 100644
index 000000000000..9f58fa2e25fd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
@@ -0,0 +1,213 @@
+/* Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved. */
+
+#include "dmub_abm.h"
+#include "dmub_abm_cacp.h"
+#include "dce_abm.h"
+#include "dc.h"
+#include "dc_dmub_srv.h"
+#include "dmub/dmub_srv.h"
+#include "core_types.h"
+
+#define CACP_LEVEL_NUM 4
+
+void dmub_cacp_init(struct abm *abm, const char *src, unsigned int bytes, unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint8_t panel_mask = 0x01 << panel_inst;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	unsigned int i, edp_num;
+
+	// TODO: Optimize by only reading back final 4 bytes
+	dmub_srv_flush_buffer_mem(dc->dmub_srv->dmub, &dc->dmub_srv->dmub->scratch_mem_fb);
+
+	// Copy iramtable into cw7
+	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
+
+	memset(&cmd, 0, sizeof(cmd));
+	// Fw will copy from cw7 to fw_state
+	cmd.cacp_init_config.header.type = DMUB_CMD__CACP;
+	cmd.cacp_init_config.header.sub_type = DMUB_CMD__CACP_INIT_CONFIG;
+	cmd.cacp_init_config.cacp_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.cacp_init_config.cacp_init_config_data.bytes = (uint16_t)bytes;
+	cmd.cacp_init_config.cacp_init_config_data.panel_mask = panel_mask;
+	cmd.cacp_init_config.cacp_init_config_data.visual_confirm =
+		(dc->dc->debug.visual_confirm == VISUAL_CONFIRM_ABM) ? true : false;
+
+	cmd.cacp_init_config.header.payload_bytes = sizeof(struct dmub_cmd_cacp_init_config_data);
+
+	dc_get_edp_links(dc->dc, edp_links, &edp_num);
+	for (i = 0; i < edp_num; i++) {
+		if (panel_inst == i)
+			break;
+	}
+
+	if (i < edp_num) {
+		cmd.cacp_init_config.cacp_init_config_data.strscl_valid =
+			(uint8_t)edp_links[panel_inst]->panel_config.cacp.strscl_valid;
+		cmd.cacp_init_config.cacp_init_config_data.mode =
+			edp_links[panel_inst]->panel_config.cacp.cacp_control_mode ?
+			DMUB_CMD_CACP_CONTROL_MODE_1 : DMUB_CMD_CACP_CONTROL_MODE_0;
+		for (int j = 0; j < CACP_LEVEL_NUM; j++) {
+			cmd.cacp_init_config.cacp_init_config_data.strscl_sdr[j] =
+				(uint8_t)edp_links[panel_inst]->panel_config.cacp.strscl_sdr[j];
+			cmd.cacp_init_config.cacp_init_config_data.strscl_hdr[j] =
+				(uint8_t)edp_links[panel_inst]->panel_config.cacp.strscl_hdr[j];
+		}
+	}
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+bool dmub_cacp_set_level(struct abm *abm, unsigned int abm_level, unsigned char panel_mask)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_level.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_level.header.sub_type = DMUB_CMD__CACP_SET_LEVEL;
+
+	cmd.cacp_set_level.cacp_set_level_data.level = abm_level;
+	cmd.cacp_set_level.cacp_set_level_data.version = DMUB_CMD_CACP_CONTROL_VERSION_1;
+	cmd.cacp_set_level.cacp_set_level_data.panel_mask = panel_mask;
+
+	cmd.cacp_set_level.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_level_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+bool dmub_cacp_set_pipe(struct abm *abm, unsigned int otg_inst,
+		unsigned int pipe_option, unsigned int panel_inst, unsigned int pwrseq_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_pipe.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_pipe.header.sub_type = DMUB_CMD__CACP_SET_PIPE;
+
+	cmd.cacp_set_pipe.cacp_set_pipe_data.otg_inst = (uint8_t)otg_inst;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.panel_inst = (uint8_t)panel_inst;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.set_pipe_option = (uint8_t)pipe_option;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.pwrseq_inst = (uint8_t)pwrseq_inst;
+	cmd.cacp_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_pipe_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+bool dmub_cacp_set_event(struct abm *abm, unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable, unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_event.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_event.header.sub_type = DMUB_CMD__CACP_SET_EVENT;
+
+	//TODO:
+	cmd.cacp_set_event.cacp_set_event_data.full_screen_mode = (uint8_t)full_screen;
+	cmd.cacp_set_event.cacp_set_event_data.trans_info = trans_info;
+	cmd.cacp_set_event.cacp_set_event_data.hdr_mode = (uint8_t)hdr_mode;
+	cmd.cacp_set_event.cacp_set_event_data.vb_scaling_enable = (uint8_t)scaling_enable;
+	cmd.cacp_set_event.cacp_set_event_data.panel_mask = (1<<panel_inst);
+
+	cmd.cacp_set_event.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_event_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+bool dmub_cacp_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int otg_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_pause.header.type = DMUB_CMD__CACP;
+	cmd.cacp_pause.header.sub_type = DMUB_CMD__CACP_PAUSE;
+
+	cmd.cacp_pause.cacp_pause_data.panel_mask = (1<<panel_inst);
+	cmd.cacp_pause.cacp_pause_data.otg_inst = (uint8_t)otg_inst;
+	cmd.cacp_pause.cacp_pause_data.enable = pause;
+
+	cmd.cacp_pause.header.payload_bytes = sizeof(struct dmub_cmd_cacp_pause_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+bool dmub_cacp_set_backlight_level(struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_backlight.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_backlight.header.sub_type = DMUB_CMD__CACP_SET_BACKLIGHT;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.frame_ramp = frame_ramp;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.version = DMUB_CMD_CACP_CONTROL_VERSION_1;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.panel_mask = (0x01 << panel_inst);
+	cmd.cacp_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_backlight_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+void dmub_cacp_enable_fractional_pwm(struct abm *abm, uint8_t panel_mask)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_pwm_frac.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_pwm_frac.header.sub_type = DMUB_CMD__CACP_SET_PWM_FRAC;
+	cmd.cacp_set_pwm_frac.cacp_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.cacp_set_pwm_frac.cacp_set_pwm_frac_data.version = DMUB_CMD_CACP_CONTROL_VERSION_1;
+	cmd.cacp_set_pwm_frac.cacp_set_pwm_frac_data.panel_mask = panel_mask;
+	cmd.cacp_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_pwm_frac_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+bool dmub_cacp_get_histogram(
+		struct dc_context *dc,
+		unsigned int panel_inst,
+		unsigned int *histogram,
+		enum dmub_abm_histogram_type histogram_type,
+		unsigned int size)
+{
+	union dmub_rb_cmd cmd;
+
+	dmub_srv_flush_buffer_mem(dc->dmub_srv->dmub, &dc->dmub_srv->dmub->scratch_mem_fb);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_get_histogram.header.type = DMUB_CMD__CACP;
+	cmd.cacp_get_histogram.header.sub_type = DMUB_CMD__CACP_GET_HISTOGRAM;
+
+	cmd.cacp_get_histogram.dest.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.cacp_get_histogram.bytes = (uint16_t)size;
+	cmd.cacp_get_histogram.panel_inst = (uint8_t)panel_inst;
+	cmd.cacp_get_histogram.histogram_type = histogram_type;
+	cmd.cacp_get_histogram.header.payload_bytes = sizeof(struct dmub_rb_cmd_cacp_get_histogram);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	memcpy((void *)histogram, dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, size);
+
+	return true;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h
new file mode 100644
index 000000000000..3b3b712c1242
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h
@@ -0,0 +1,20 @@
+/* Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved. */
+
+#include "dmub_cmd.h"
+
+#ifndef __DMUB_ABM_CACP_H__
+#define __DMUB_ABM_CACP_H__
+
+void dmub_cacp_init(struct abm *abm, const char *src, unsigned int bytes, unsigned int panel_inst);
+bool dmub_cacp_set_level(struct abm *abm, unsigned int cacp_level, unsigned char panel_mask);
+bool dmub_cacp_set_pipe(struct abm *abm, unsigned int otg_inst, unsigned int pipe_option,
+						unsigned int panel_inst, unsigned int pwrseq_inst);
+bool dmub_cacp_set_event(struct abm *abm, unsigned int full_screen, unsigned int trans_info, unsigned int hdr_mode,
+						unsigned int scaling_enable, unsigned int panel_inst);
+bool dmub_cacp_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int otg_inst);
+bool dmub_cacp_set_backlight_level(struct abm *abm, unsigned int backlight_pwm_u16_16, unsigned int frame_ramp,
+						unsigned int panel_inst);
+void dmub_cacp_enable_fractional_pwm(struct abm *abm, uint8_t panel_mask);
+bool dmub_cacp_get_histogram(struct dc_context *dc, unsigned int panel_inst, unsigned int *histogram,
+		enum dmub_abm_histogram_type histogram_type, unsigned int size);
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 476c2112afec..2be68f8dd0fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -136,6 +136,26 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }

+bool dcn21_dmub_cacp_set_pipe(struct abm *abm, uint32_t otg_inst,
+		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_pipe.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_pipe.header.sub_type = DMUB_CMD__CACP_SET_PIPE;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.otg_inst = (uint8_t)otg_inst;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.pwrseq_inst = (uint8_t)pwrseq_inst;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.set_pipe_option = (uint8_t)option;
+	cmd.cacp_set_pipe.cacp_set_pipe_data.panel_inst = (uint8_t)panel_inst;
+	cmd.cacp_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_pipe_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
 bool dcn21_dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
@@ -181,10 +201,12 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+	struct dc_link *link = pipe_ctx->stream->link;

 	// make a short term w/a for an issue that backlight ramping unexpectedly paused in the middle,
 	// will decouple backlight from ABM and redefine DMUB interface, then this w/a could be removed
-	if (pipe_ctx->stream->abm_level == 0 || pipe_ctx->stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
+	if ((pipe_ctx->stream->abm_level == 0 || pipe_ctx->stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE)
+		&& (link && !link->panel_config.cacp.cacp_supported)) {
 		return;
 	}

@@ -197,6 +219,9 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
 					panel_cntl->inst, panel_cntl->pwrseq_inst);
+		} else if (link && link->panel_config.cacp.cacp_supported) {
+			dcn21_dmub_cacp_set_pipe(abm, otg_inst, SET_CACP_PIPE_IMMEDIATELY_DISABLE,
+						panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
 			dcn21_dmub_abm_set_pipe(abm,
 						otg_inst,
@@ -214,6 +239,7 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+	struct dc_link *link = pipe_ctx->stream->link;
 	uint32_t otg_inst;

 	if (!abm || !tg || !panel_cntl)
@@ -233,6 +259,11 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
 	} else {
+
+		if (link && link->panel_config.cacp.cacp_supported)
+			dcn21_dmub_cacp_set_pipe(abm, otg_inst, SET_CACP_PIPE_NORMAL,
+					panel_cntl->inst, panel_cntl->pwrseq_inst);
+		else
 			dcn21_dmub_abm_set_pipe(abm, otg_inst,
 				  SET_ABM_PIPE_NORMAL,
 				  panel_cntl->inst,
@@ -250,6 +281,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	uint32_t otg_inst;
 	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
 	uint32_t frame_ramp = backlight_level_params->frame_ramp;
+	struct dc_link *link = pipe_ctx->stream->link;

 	if (!abm || !tg || !panel_cntl)
 		return false;
@@ -268,6 +300,12 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
 	} else {
+		if (link && link->panel_config.cacp.cacp_supported)
+			dcn21_dmub_cacp_set_pipe(abm, otg_inst,
+					SET_CACP_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
+		else
 			dcn21_dmub_abm_set_pipe(abm,
 				  otg_inst,
 				  SET_ABM_PIPE_NORMAL,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
index f72a27ac1bf1..aae13447cfa8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
@@ -47,6 +47,8 @@ void dcn21_optimize_pwr_state(
 void dcn21_PLAT_58856_wa(struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);

+bool dcn21_dmub_cacp_set_pipe(struct abm *abm, uint32_t otg_inst,
+	uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 bool dcn21_dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 	uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 43e4edfe9182..e72e10c276de 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -54,6 +54,7 @@
 #include "dce/dce_i2c_hw.h"
 #include "dce/dmub_abm_lcd.h"
 #include "dio/dcn10/dcn10_dio.h"
+#include "dce/dmub_abm_cacp.h"

 #define DC_LOGGER_INIT(logger)

@@ -726,12 +727,19 @@ bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	uint32_t otg_inst;
+	struct dc_link *link = pipe_ctx->stream->link;

 	if (!abm || !tg || !panel_cntl)
 		return false;

 	otg_inst = tg->inst;

+	if (link && link->panel_config.cacp.cacp_supported)
+		dcn21_dmub_cacp_set_pipe(abm, otg_inst,
+			SET_CACP_PIPE_NORMAL,
+			panel_cntl->inst,
+			panel_cntl->pwrseq_inst);
+	else
 		dcn21_dmub_abm_set_pipe(abm,
 			otg_inst,
 			SET_ABM_PIPE_NORMAL,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 3f0161d64675..6ae7cf109565 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -66,6 +66,9 @@ struct abm_funcs {
 			unsigned int option,
 			unsigned int panel_inst,
 			unsigned int pwrseq_inst);
+	bool (*set_abm_event)(struct abm *abm, unsigned int full_screen, unsigned int trans_info,
+			unsigned int hdr_mode, unsigned int scaling_enable, unsigned int scaling_strength_map,
+			unsigned int panel_inst);
 };

 #endif
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index f9814cf7bbdb..02bee3b1956d 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -328,6 +328,17 @@ bool mod_power_is_abm_active(struct mod_power *mod_power,
 		const struct dc_link *link,
 		unsigned int inst);

+bool mod_power_is_abm_supported(struct mod_power *mod_power,
+		unsigned int inst);
+
+bool mod_power_abm_set_event(struct mod_power *mod_power,
+		unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable,
+		unsigned int scaling_strength_map, unsigned int inst);
+
+bool mod_power_abm_set_strength(struct mod_power *mod_power,
+		unsigned int strength,
+		unsigned int inst);

 bool mod_power_set_psr_event(struct mod_power *mod_power,
 		struct dc_stream_state *stream, bool set_event,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index b9447cb7485b..5b972f04bf7a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -1453,6 +1453,76 @@ bool mod_power_is_abm_active(struct mod_power *mod_power,
 	return is_active;
 }

+bool mod_power_is_abm_supported(struct mod_power *mod_power,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	struct dc *dc = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	dc = core_power->dc;
+
+	// It's only implemented on dmcub.
+	if (dc->ctx->dmub_srv) {
+		if (!dmub_is_abm_supported(dc->res_pool, inst))
+			return false;
+	} else
+		return false;
+
+	return true;
+}
+
+bool mod_power_abm_set_event(struct mod_power *mod_power,
+		unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable,
+		unsigned int scaling_strength_map, unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	struct dc *dc = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	dc = core_power->dc;
+
+	// It's only implemented on dmcub.
+	if (dc->ctx->dmub_srv) {
+		if (!dmub_set_abm_event(dc->res_pool, full_screen, trans_info,
+				hdr_mode, scaling_enable, scaling_strength_map, inst))
+			return false;
+	} else
+		return false;
+
+	return true;
+}
+
+bool mod_power_abm_set_strength(struct mod_power *mod_power,
+		unsigned int strength,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	struct dc *dc = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	dc = core_power->dc;
+
+	// It's only implemented on dmcub.
+	if (dc->ctx->dmub_srv) {
+		if (!dmub_set_abm_strength(dc->res_pool, strength, inst))
+			return false;
+	} else
+		return false;
+
+	return true;
+}
+
 static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
 		struct iram_table_v_2 *table)
 {
@@ -1990,6 +2060,62 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 	return result;
 }

+bool dmub_is_abm_supported(struct resource_pool *res_pool, unsigned int inst)
+{
+
+	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
+		return false;
+
+	return true;
+}
+
+bool dmub_set_abm_event(struct resource_pool *res_pool,
+		unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable, unsigned int scaling_strength_map,
+		unsigned int inst)
+{
+	bool result = false;
+
+	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
+		return false;
+
+	if (res_pool->multiple_abms[inst]) {
+		if (res_pool->multiple_abms[inst]->funcs->set_abm_event)
+			result = res_pool->multiple_abms[inst]->funcs->set_abm_event(
+				res_pool->multiple_abms[inst], full_screen, trans_info,
+					hdr_mode, scaling_enable, scaling_strength_map, inst);
+	} else {
+		if (res_pool->abm->funcs->set_abm_event)
+			result = res_pool->abm->funcs->set_abm_event(
+					res_pool->abm, full_screen, trans_info,
+					hdr_mode, scaling_enable, scaling_strength_map, inst);
+	}
+
+	return result;
+}
+
+bool dmub_set_abm_strength(struct resource_pool *res_pool,
+	unsigned int strength,
+	unsigned int inst)
+{
+	bool result = false;
+
+	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
+		return false;
+
+	if (res_pool->multiple_abms[inst]) {
+		if (res_pool->multiple_abms[inst]->funcs->set_abm_level)
+			result = res_pool->multiple_abms[inst]->funcs->set_abm_level(
+				res_pool->multiple_abms[inst], strength);
+	} else {
+		if (res_pool->abm->funcs->set_abm_level)
+			result = res_pool->abm->funcs->set_abm_level(
+					res_pool->abm, strength);
+	}
+
+	return result;
+}
+
 bool dmcu_load_iram(struct dmcu *dmcu,
 	struct dmcu_iram_parameters params)
 {
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 600da3e33126..548c8ff6ddb4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -146,6 +146,16 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		struct dmcu_iram_parameters params,
 		unsigned int inst);

+bool dmub_is_abm_supported(struct resource_pool *res_pool,
+		unsigned int inst);
+bool dmub_set_abm_event(struct resource_pool *res_pool,
+		unsigned int full_screen, unsigned int trans_info,
+		unsigned int hdr_mode, unsigned int scaling_enable,
+		unsigned int scaling_strength_map, unsigned int inst);
+bool dmub_set_abm_strength(struct resource_pool *res_pool,
+		unsigned int strength,
+		unsigned int inst);
+
 void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
--
2.55.0

