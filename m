Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6BCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA8E10E88C;
	Wed, 10 Jun 2026 09:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qk2+plSj";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0314110E88C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3bElAYvqQd4eO/uHnM8cVUgxUDMM8Oo520eyVc8R/2KrKioAq8xy6Uzja+NkjqZq9/1k+Ywdo3rj01SkIDrzFAE87niDofvxxnfhoyBd5IaZJbDhuSy3d4VisgjoUPu7PiPM2OgcWyrIk2+PL7ieVsdxxYABU6bCEJN83RjxX6aUT1H/A5cX2MM2fETm51kSOnRM6Y5YoPZrTPlLBXU3UaVkY+Qtuf/2o2SUgSPgi9L/GBbY2iDxA3kapC5CzIBCw4iibB08Bmbh+VuOSVxBdGgNn6QxDSe6xMMQG9sEslQ95n1cyJRvESBOKW2fMP3+PGekAZ7Hmr+ahYQ60PlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOwfh/Ty4NyRJ+RxqbNHQ4IPzXH1LYqvgG9p/APLZx8=;
 b=OI6zsKMaDiO87JAoPz8TtveHLXiwp8H2X6EqEwrUQvxDhPbQ8PKTK5AXs8ZA5gPLb1RMenIbYxRWmZ9nD1zffGc5lkjFqzAXvxysJ2y4w2syXxIv3t4lBjx346tIZq3UYcGKTb3Qw3n5Ow8ZT/2e9KhDL0eNBAaTNckSUJOG6V4gEoVDUjSWRHE8zlKiBPZzV8KB70z3z+1QaG0Dsq34NQV6jvbagHZOhrYfOitZGEwTEO7eayVmrnhQyboHhzCzHga6JtiPUnBWGX/D1K61hL6WtS5yD0ixiJkf8T2uTY81Rqmspv2FBYTtRMjRyRKMgtahDtqJiBNiydCATsz+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOwfh/Ty4NyRJ+RxqbNHQ4IPzXH1LYqvgG9p/APLZx8=;
 b=Qk2+plSj42uUvksukjbrj7KumJWV01JRM1oanSBIXWKqEpHWkjOG3gQEtcc6cnaRVq5OQZmJ/IfNqH+CBwBjoYXHOXgwqQJXWdn7I5q5bwosFbn7rgu/c88XBeTReQyoViASW5rS0pGBYJSGn5XFE4FtHXBkdG010LR/AlPbNuY=
Received: from BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29)
 by CH1PPF4C9628624.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:51:31 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9e) by BL1PR13CA0114.outlook.office365.com
 (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 09:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:30 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:22 -0500
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
Subject: [PATCH 23/32] drm/amd/display: Add KUnit tests for amdgpu_dm_crtc
Date: Wed, 10 Jun 2026 17:45:07 +0800
Message-ID: <20260610094639.1965367-24-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH1PPF4C9628624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab1ea29-27b4-40e1-3700-08dec6d5d96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 5mAVkdcAYPHzpEmGdvheTamoB1AQMygw0TZ+lrOJ456e4Bj0zY87GDypTPYGfU+atDW5t6COsYILfBcytMBkYWa32KauRMK5gdGZle6gQw3AniK9+eBIUd409DRCRwFkrK3qX1Gu1TP8ylTzq+sm6AaniBkszP40/gGq02qRMdaOqyPTl/4jQ76thWn5v6FpW0GZibIJeRAVC8NyXLcRTQqukfR/acTaLhNZKyBm3zTYjvkgxLrDjl/9o56B8BJrwf2hz5+2Xd+lPM/gUoOc4RLkUnk3jXrR9j27MbfN7r95vN9CXAQ5GJHYApYjFAF21GJU1DgnF1kTCmCJPzZfrjr6npoTS3f8scaCRkWGhqqDFy1oEN+26GydHLDs1rz+QQ6pYkIWNh00hcsVNfUhrMJTGK/dMxGruF1GjU54JE894RxKMZATpm/evnwmkOa4gBzfaGlszQRdQpYtpC8DROgl7x8rBBBmX52bPycyixYwLjA2Zs/uwBEPvS/9k2VoomHRQWKDyIrAUbfHVvLk6f/oxI0VMnKXF8rO7Lym079t5TiM4q7vGiW/0QU/vrWseP+dkzSIXpzHSBQquNCAMG6/QhVg3FqKUal+F+XQ/Ky7FPow0rLRQky5rxc0ILFGCn1P/mKE/Dyaise+757wwXDrPUIzChycYFLDB2YLV9oad/FjAvyuvINu20tWrTpThZPTJ7frXu+EAnRWAqJuKaP/3Mvh3oxecAKdyF2gZzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XW7ZR9zwE93pyBBncxwH7t570zzGo75WO+3lsS4Sl2VOir5EzruNCz116kSaK3EEiLYlSi68hsAQoOO6gYzDEEyar2nMcfxz17CG4tZVT6LUw7Yy0qxT/iKfjNYedWohXMaUsMWxMjt9OYw+kPBlxcRKp75PD6/MTO1VymbwepWZB9xgLTqdfYePC4oxgFuw3suzK0XxjoU09Y2S8I89Co3eDQCoTA0UAKxwBVkMYGI87iRsAB7veWtYZdlwNiPC55BhCCzur/EbiYvpxy8Gxgaq5drdXVHD9pTf4nTtC5uG5ZF7KB5SloUnFxJ+9Cz2L7ew4YZoa9RaKhNMXpwOLUKT4xMYhn76vv/HgCiFeEF4ki9Q6Zo3m49xFrz9TfeDTSog6WUXIoh/RYMSWayOoMxWL/8EVw9BaZUcxjTG4OgKmhK8SU0DPWmwzTWijGUj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:31.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab1ea29-27b4-40e1-3700-08dec6d5d96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624
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

Add KUnit coverage for functions in amdgpu_dm_crtc.c:
- amdgpu_dm_crtc_modeset_required: verify active+needs_modeset
  combinations (mode_changed, active_changed, connectors_changed)
- amdgpu_dm_crtc_vrr_active_irq: verify all VRR state enum values
- amdgpu_dm_crtc_vrr_active: verify all VRR state enum values
- amdgpu_dm_is_headless: null adev, no connectors, writeback-only,
  disconnected display, connected display, and mixed connector cases
- amdgpu_dm_crtc_helper_mode_fixup: verify it accepts the mode
- amdgpu_dm_crtc_set_vupdate_irq: verify the otg_inst == -1 early
  return using a DRM mock device
- idle_create_workqueue: verify the idle workqueue is allocated and
  initialized in a disabled, non-running state

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   6 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 532 ++++++++++++++++++
 4 files changed, 550 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index efb19f675b0c..c9916ed0ddc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -34,6 +34,7 @@
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "modules/inc/mod_power.h"
 
 #define HPD_DETECTION_PERIOD_uS 2000000
@@ -65,6 +66,7 @@ bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
 {
 	return crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_modeset_required);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc)
 
@@ -74,6 +76,7 @@ bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc)
 	       acrtc->dm_irq_params.freesync_config.state ==
 		       VRR_STATE_ACTIVE_FIXED;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_vrr_active_irq);
 
 int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 {
@@ -93,12 +96,14 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 		      acrtc->crtc_id, enable ? "en" : "dis", rc);
 	return rc;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_vupdate_irq);
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 {
 	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_vrr_active);
 
 /**
  * amdgpu_dm_crtc_set_static_screen_optimze() - Toggle static screen optimizations.
@@ -156,6 +161,7 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 	drm_connector_list_iter_end(&iter);
 	return is_headless;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_is_headless);
 
 static void amdgpu_dm_idle_worker(struct work_struct *work)
 {
@@ -207,6 +213,7 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 
 	return idle_work;
 }
+EXPORT_IF_KUNIT(idle_create_workqueue);
 
 static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
@@ -595,12 +602,13 @@ static void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 		amdgpu_dm_crtc_count_crtc_active_planes(new_crtc_state);
 }
 
-static bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
+STATIC_IFN_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+					       const struct drm_display_mode *mode,
+					       struct drm_display_mode *adjusted_mode)
 {
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_helper_mode_fixup);
 
 static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					      struct drm_atomic_state *state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index e9fb52f0e66d..d8b004f613ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -42,6 +42,12 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+				      const struct drm_display_mode *mode,
+				      struct drm_display_mode *adjusted_mode);
+#endif
+
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
 
 int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 583604914753..cde8f7748bc5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
new file mode 100644
index 000000000000..c83bd3e074f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_crtc.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_kunit_helpers.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_irq_params.h"
+
+/* Tests for amdgpu_dm_crtc_modeset_required() */
+
+/**
+ * dm_test_crtc_modeset_required_active_mode_changed - Test Crtc modeset required active mode changed
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_modeset_required_active_mode_changed(struct kunit *test)
+{
+	struct drm_crtc_state state = {};
+
+	state.active = true;
+	state.mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_crtc_modeset_required(&state, NULL, NULL));
+}
+
+/**
+ * dm_test_crtc_modeset_required_active_active_changed - Test Crtc modeset required active active changed
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_modeset_required_active_active_changed(struct kunit *test)
+{
+	struct drm_crtc_state state = {};
+
+	state.active = true;
+	state.active_changed = true;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_crtc_modeset_required(&state, NULL, NULL));
+}
+
+/**
+ * dm_test_crtc_modeset_required_active_connectors_changed - Test Crtc modeset required active connectors changed
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_modeset_required_active_connectors_changed(struct kunit *test)
+{
+	struct drm_crtc_state state = {};
+
+	state.active = true;
+	state.connectors_changed = true;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_crtc_modeset_required(&state, NULL, NULL));
+}
+
+/**
+ * dm_test_crtc_modeset_required_inactive - Test Crtc modeset required inactive
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_modeset_required_inactive(struct kunit *test)
+{
+	struct drm_crtc_state state = {};
+
+	state.active = false;
+	state.mode_changed = true;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_crtc_modeset_required(&state, NULL, NULL));
+}
+
+/**
+ * dm_test_crtc_modeset_required_no_changes - Test Crtc modeset required no changes
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_modeset_required_no_changes(struct kunit *test)
+{
+	struct drm_crtc_state state = {};
+
+	state.active = true;
+	state.mode_changed = false;
+	state.active_changed = false;
+	state.connectors_changed = false;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_crtc_modeset_required(&state, NULL, NULL));
+}
+
+/* Tests for amdgpu_dm_crtc_vrr_active_irq() */
+
+/**
+ * dm_test_crtc_vrr_active_irq_variable - Test Crtc vrr active irq variable
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_irq_variable(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_crtc_vrr_active_irq(acrtc));
+}
+
+/**
+ * dm_test_crtc_vrr_active_irq_fixed - Test Crtc vrr active irq fixed
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_irq_fixed(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_crtc_vrr_active_irq(acrtc));
+}
+
+/**
+ * dm_test_crtc_vrr_active_irq_inactive - Test Crtc vrr active irq inactive
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_irq_inactive(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_INACTIVE;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active_irq(acrtc));
+}
+
+/**
+ * dm_test_crtc_vrr_active_irq_disabled - Test Crtc vrr active irq disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_irq_disabled(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_DISABLED;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active_irq(acrtc));
+}
+
+/**
+ * dm_test_crtc_vrr_active_irq_unsupported - Test Crtc vrr active irq unsupported
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_irq_unsupported(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
+						  GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_UNSUPPORTED;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active_irq(acrtc));
+}
+
+/* Tests for amdgpu_dm_crtc_vrr_active() */
+
+/**
+ * dm_test_crtc_vrr_active_variable - Test Crtc vrr active variable
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_variable(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state = kunit_kzalloc(test,
+						       sizeof(*dm_state),
+						       GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_crtc_vrr_active(dm_state));
+}
+
+/**
+ * dm_test_crtc_vrr_active_fixed - Test Crtc vrr active fixed
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_fixed(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state = kunit_kzalloc(test,
+						       sizeof(*dm_state),
+						       GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_crtc_vrr_active(dm_state));
+}
+
+/**
+ * dm_test_crtc_vrr_active_inactive - Test Crtc vrr active inactive
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_inactive(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state = kunit_kzalloc(test,
+						       sizeof(*dm_state),
+						       GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->freesync_config.state = VRR_STATE_INACTIVE;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active(dm_state));
+}
+
+/**
+ * dm_test_crtc_vrr_active_disabled - Test Crtc vrr active disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_disabled(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state = kunit_kzalloc(test,
+						       sizeof(*dm_state),
+						       GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->freesync_config.state = VRR_STATE_DISABLED;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active(dm_state));
+}
+
+/**
+ * dm_test_crtc_vrr_active_unsupported - Test Crtc vrr active unsupported
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_vrr_active_unsupported(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state = kunit_kzalloc(test,
+						       sizeof(*dm_state),
+						       GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->freesync_config.state = VRR_STATE_UNSUPPORTED;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_vrr_active(dm_state));
+}
+
+/* Tests for amdgpu_dm_is_headless() */
+
+static void dm_test_add_connector(struct drm_device *dev,
+				  struct drm_connector *connector,
+				  int connector_type,
+				  enum drm_connector_status status)
+{
+	INIT_LIST_HEAD(&connector->head);
+	kref_init(&connector->base.refcount);
+	connector->connector_type = connector_type;
+	connector->status = status;
+	list_add_tail(&connector->head, &dev->mode_config.connector_list);
+}
+
+/**
+ * dm_test_crtc_is_headless_null_adev - Test Crtc is headless null adev
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_null_adev(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(NULL));
+}
+
+/**
+ * dm_test_crtc_is_headless_no_connectors - Test Crtc is headless no connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_no_connectors(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+	adev->dm.ddev = dev;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(adev));
+}
+
+/**
+ * dm_test_crtc_is_headless_writeback_only - Test Crtc is headless writeback only
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_writeback_only(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+	adev->dm.ddev = dev;
+
+	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
+			      connector_status_connected);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(adev));
+}
+
+/**
+ * dm_test_crtc_is_headless_disconnected_display - Test Crtc is headless disconnected display
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_disconnected_display(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+	adev->dm.ddev = dev;
+
+	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
+			      connector_status_disconnected);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(adev));
+}
+
+/**
+ * dm_test_crtc_is_headless_connected_display - Test Crtc is headless connected display
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_connected_display(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+	adev->dm.ddev = dev;
+
+	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
+			      connector_status_connected);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_headless(adev));
+}
+
+/**
+ * dm_test_crtc_is_headless_mixed_connectors - Test headless skips WB and finds display
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_is_headless_mixed_connectors(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
+	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+	adev->dm.ddev = dev;
+
+	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
+			      connector_status_connected);
+	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_DisplayPort,
+			      connector_status_connected);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_headless(adev));
+}
+
+/* Tests for amdgpu_dm_crtc_helper_mode_fixup() */
+
+/**
+ * dm_test_crtc_helper_mode_fixup_returns_true - Test mode_fixup accepts mode
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_helper_mode_fixup_returns_true(struct kunit *test)
+{
+	struct drm_display_mode mode = { 0 };
+	struct drm_display_mode adjusted_mode = { 0 };
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_crtc_helper_mode_fixup(NULL, &mode, &adjusted_mode));
+}
+
+/* Tests for amdgpu_dm_crtc_set_vupdate_irq() */
+
+/**
+ * dm_test_crtc_set_vupdate_irq_no_otg - Test vupdate irq with unassigned OTG
+ * @test: The KUnit test context
+ *
+ * When the CRTC has no OTG instance assigned (otg_inst == -1) the function
+ * must return 0 immediately without touching the DC interrupt state.
+ */
+static void dm_test_crtc_set_vupdate_irq_no_otg(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->base.dev = drm;
+	acrtc->otg_inst = -1;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true), 0);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false), 0);
+}
+
+/* Tests for idle_create_workqueue() */
+
+/**
+ * dm_test_idle_create_workqueue - Test idle workqueue creation
+ * @test: The KUnit test context
+ *
+ * Verify that idle_create_workqueue() allocates an idle workqueue tied to the
+ * device's display manager and initializes it in a disabled, non-running state.
+ */
+static void dm_test_idle_create_workqueue(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct idle_workqueue *idle_work;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	idle_work = idle_create_workqueue(adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+
+	KUNIT_EXPECT_PTR_EQ(test, idle_work->dm, &adev->dm);
+	KUNIT_EXPECT_FALSE(test, idle_work->enable);
+	KUNIT_EXPECT_FALSE(test, idle_work->running);
+
+	kfree(idle_work);
+}
+
+static struct kunit_case amdgpu_dm_crtc_tests[] = {
+	/* amdgpu_dm_crtc_modeset_required */
+	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
+	KUNIT_CASE(dm_test_crtc_modeset_required_active_active_changed),
+	KUNIT_CASE(dm_test_crtc_modeset_required_active_connectors_changed),
+	KUNIT_CASE(dm_test_crtc_modeset_required_inactive),
+	KUNIT_CASE(dm_test_crtc_modeset_required_no_changes),
+	/* amdgpu_dm_crtc_vrr_active_irq */
+	KUNIT_CASE(dm_test_crtc_vrr_active_irq_variable),
+	KUNIT_CASE(dm_test_crtc_vrr_active_irq_fixed),
+	KUNIT_CASE(dm_test_crtc_vrr_active_irq_inactive),
+	KUNIT_CASE(dm_test_crtc_vrr_active_irq_disabled),
+	KUNIT_CASE(dm_test_crtc_vrr_active_irq_unsupported),
+	/* amdgpu_dm_crtc_vrr_active */
+	KUNIT_CASE(dm_test_crtc_vrr_active_variable),
+	KUNIT_CASE(dm_test_crtc_vrr_active_fixed),
+	KUNIT_CASE(dm_test_crtc_vrr_active_inactive),
+	KUNIT_CASE(dm_test_crtc_vrr_active_disabled),
+	KUNIT_CASE(dm_test_crtc_vrr_active_unsupported),
+	/* amdgpu_dm_is_headless */
+	KUNIT_CASE(dm_test_crtc_is_headless_null_adev),
+	KUNIT_CASE(dm_test_crtc_is_headless_no_connectors),
+	KUNIT_CASE(dm_test_crtc_is_headless_writeback_only),
+	KUNIT_CASE(dm_test_crtc_is_headless_disconnected_display),
+	KUNIT_CASE(dm_test_crtc_is_headless_connected_display),
+	KUNIT_CASE(dm_test_crtc_is_headless_mixed_connectors),
+	/* amdgpu_dm_crtc_helper_mode_fixup */
+	KUNIT_CASE(dm_test_crtc_helper_mode_fixup_returns_true),
+	/* amdgpu_dm_crtc_set_vupdate_irq */
+	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_no_otg),
+	/* idle_create_workqueue */
+	KUNIT_CASE(dm_test_idle_create_workqueue),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_crtc_test_suite = {
+	.name = "amdgpu_dm_crtc",
+	.test_cases = amdgpu_dm_crtc_tests,
+};
+
+kunit_test_suite(amdgpu_dm_crtc_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_crtc");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

