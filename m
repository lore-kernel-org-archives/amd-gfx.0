Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07495CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9712F10EEC3;
	Wed, 13 May 2026 14:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LrfjdUF0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E42E10EEC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhBQVnGZSTYRcERciDvgzWIvqsGCVllnmfclO9hgpDugEMLMntbC5CnjPdUWE/Ai5WmywiuiwgXsiZOIjXEYZto5HxGKy0s5rOt/4LK3kC6WbYmSsvpNOCpW+3nZfEPvlao3m1ehv+Z+2puxP5jwP5Cex58dIs2T+6iOAjFMjMuSkGQl4OiUk9M9225tBEspw+YkpKVnBW0+c679PMhoXjDPkQZznzGVhFMpwx2uF9dROgzfaYcRwE2nDZR2+/G612eiVXn3I7QNwyiqtXmy3IoLqYVFX0XlfOSXaYXomJuei02tFnahn7CFYvtboMFiTnk0pNYz+qJDfGxY6tX/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4zTygnnBG4FtUoxAENYdTMrukkxodJwEKmXv2rp/ts=;
 b=DKjDPiCOlwkTnHIaeHpbtH5eBv7XuSsZXKOEW/gXcfQP+7P54xel/CbyXNjlrSGX+JXWwUJ4puIGL+5ZwE9EymenGM395Re4BucAFFn1F10vx46Skcly/a53YT54U9dwvk7DORFPfe05PHOO32+/Uxy0WbEqbsmeJNIVyK8DmnQHeDozvkybQ1S9ct8sIQGF9u0Yrf+oEJj9HD3EUfDxLceIgz3Ozl4ZjICbkp3riuk5bnWd172Flgl3oeRCqLK/u0nGBZ0h3Gjx5uwOGfQfk+2C9zbFojNFt/AVj4EZWz6oFQXmshek16dRkbAcMkKwvbeRmfcfh9Wy0PasmIXcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4zTygnnBG4FtUoxAENYdTMrukkxodJwEKmXv2rp/ts=;
 b=LrfjdUF0R/WdN84oLpxPbEjwUmcdoeXiLOGH0HBv07CoD9iQCFVC59Kl8I3QP1m1DMUJjnyHmOp4F/IZyG82tPFkaX1Ir96WDVzUOG/GehrSuPXBGv+vRXjyQRALtabWpktdFAavN3/ICnsKWEZdR+A8bKmBp8UOJhRfntdezCg=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:26 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::1) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:18 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Add KUnit test for HDCP process_output
Date: Wed, 13 May 2026 10:29:28 -0400
Message-ID: <20260513143213.1852892-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: ac83ec96-f487-4237-d21e-08deb0fc97a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Q1+bBDOSNPGsCaGPMBMK3b2YnEt4TS1WABGLttNvAgQx71fLqzfB6QINDzVVc/ZG5/YW895OJAaQvf1F7y7SwUMifPUA7bQ/BLjU77wyVuvblAFzpgkGCo3k/5jYCSsI7dC4DKfqAacgvS320RYXbjLLJy4ejP/1r6BrKoXncbtCBFM8jZvHv1ZMJ2VdsQ8Btl8MyG5Ewaxvz3OM76cZZ+5djokConpryCrGFMpSldqSogQwhlYsk/X6BmGL+EGxHEoCzKJbQRwQ3tVMdYD8vER7WHHw2SMvu0Zg6aby7zM1JOAD6fCglCRaR/t0S9AZRu2Npj1SgDDnOfwsVPTfiCaJVrxreqzNJx14xTf8O1swpXE5gc6lEuJz+bWaoj+xlWOAF37yyiiX49mw3R+ezQW9iXSp7XkjLSlkaC27LqWTGRgAlmqy1fo2Ms9T0QfpRTx27e5lh5w1AsD7LWhRx5wbo+WZ9nnN5URBVRKetxnEU/sCP3EWUfM9+9FHWWcH6Qg+MSUrCGWk0uOWHr9s/hpWE9d9h6XIR3xZf1Sugr9o+wHlTu84CuC1f+1GKDuCUT4kTY4JpK81uvNoDPMtcsAX/S4lY8AP0xQr7PbWuN/9TngnemitSTgfBZ2NXkjtFVv86jVYjHk7rUR1HYUTdzsURDzY5KFbKUiCq8S9ATFemg2lizfb0kxXHEg3nM1CnaTRJ7ZGZeco4yYe/kWLoaE+mBoNy6vXDZvsl55bqHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g8zgmhn17cAc72IWdn8dSU+CUsg4hsAjjjYE7V4QPTOZvbg4zUGO2ch9zNS6dd39Yq5HQ5Sho/LKj/EQLRpjh/wv4Jru5LtBUKWtYyby/MZmaxXUFdgEC0lP/rxCgr1UtCEEcQWQ8jZjBPjzhsI67s5sD/PjxzpHa6IkdMngUYrI6SmKjirrNGq9pUJwlrRJD2s8vdCN5kIxBHLnoyPA2P9dXxuWC8OT52rJZgxA7ra8lVm+5PfNA8tG/+LCOB9pCRClX7dqByhjFaAR/8m9/Icrs3FxMI5PbrEYsS2HxIdsrKbCy1RKOx6RJkeWWGyxuuQF6uY369gnfDab5FKXP1KFdEhCdnHVr3ZYP397DbplXyR/H8yRIjYPQQgU/gEjb7n6Z0iVw7Ymvu8moKjUJav6l0HI22V6NzsB1iMja6/+EL52uq4UuT0ZPoz5jT7f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:25.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac83ec96-f487-4237-d21e-08deb0fc97a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

Expose process_output() as non-static when CONFIG_DRM_AMD_DC_KUNIT_TEST
is enabled and add KUnit tests exercising its full branch logic:

- property_validate_dwork is always enqueued (delay=0)
- callback_dwork is scheduled when callback_needed is set
- callback_dwork is cancelled when callback_stop is set
- watchdog_timer_dwork is scheduled when watchdog_timer_needed is set
- watchdog_timer_dwork is cancelled when watchdog_timer_stop is set
- Both dworks are scheduled independently when both flags are set

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  13 +-
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 175 ++++++++++++++++++
 5 files changed, 196 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1e0ccf58cdb8..43056392a1f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -45,8 +45,6 @@
  * in amdgpu_dm_kms.h file
  */
 
-#define AMDGPU_DM_MAX_DISPLAY_INDEX 31
-
 #define AMDGPU_DM_MAX_CRTC 6
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a10401675f53..29e5bdb16b89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -31,6 +31,7 @@
 #include "dm_helpers.h"
 #include <drm/display/drm_hdcp_helper.h>
 #include "hdcp_psp.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 /*
  * If the SRM version being loaded is less than or equal to the
@@ -158,7 +159,8 @@ static int psp_set_srm(struct psp_context *psp,
 	return 0;
 }
 
-static void process_output(struct hdcp_workqueue *hdcp_work)
+STATIC_IFN_KUNIT
+void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
 
@@ -178,6 +180,7 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
 
 	schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
 }
+EXPORT_IF_KUNIT(process_output);
 
 static void link_lock(struct hdcp_workqueue *work, bool lock)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 4faa344f196e..4bb072cfac1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -31,12 +31,19 @@
 #include "hdcp.h"
 #include "dc.h"
 #include "dm_cp_psp.h"
-#include "amdgpu.h"
+
+/*
+ * Minimal declarations needed by this header.
+ * Full amdgpu/DM definitions come from amdgpu_dm.h included by each .c file.
+ */
+#define AMDGPU_DM_MAX_DISPLAY_INDEX 31
+struct amdgpu_dm_connector;
 
 struct mod_hdcp;
 struct mod_hdcp_link;
 struct mod_hdcp_display;
 struct cp_psp;
+struct amdgpu_device;
 
 struct hdcp_workqueue {
 	struct work_struct cpirq_work;
@@ -87,4 +94,8 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
 
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
 
+#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+void process_output(struct hdcp_workqueue *hdcp_work);
+#endif
+
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 1238d8832fa3..9669ea79a666 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -3,5 +3,10 @@
 # Makefile for amdgpu_dm KUnit tests.
 
 ccflags-y += -I$(src)/..
+ccflags-y += -I$(src)/../..
+ccflags-y += -I$(src)/../../include
+ccflags-y += -I$(src)/../../modules/inc
+ccflags-y += -I$(src)/../../dc
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
new file mode 100644
index 000000000000..d03b606d27bc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_hdcp.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <linux/workqueue.h>
+
+#include "amdgpu_dm_hdcp.h"
+
+static void dummy_work_fn(struct work_struct *work) {}
+
+/* Tests for process_output() */
+
+/*
+ * Helper: allocate and initialise a minimal hdcp_workqueue sufficient for
+ * process_output() testing.  Only the three delayed works accessed by
+ * process_output() are initialised; everything else is zeroed.
+ */
+static struct hdcp_workqueue *alloc_test_workqueue(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_DELAYED_WORK(&work->callback_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->watchdog_timer_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+
+	return work;
+}
+
+/*
+ * process_output() always schedules property_validate_dwork with delay=0,
+ * which queues the work item directly (bypassing the timer).  Use
+ * work_pending() rather than delayed_work_pending() to detect this.
+ */
+static void dm_test_process_output_property_validate_always_scheduled(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	/* No flags set: only property_validate_dwork should be enqueued */
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->property_validate_dwork.work));
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->callback_dwork));
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/*
+ * output.callback_needed=true must schedule callback_dwork.
+ */
+static void dm_test_process_output_callback_needed(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	work->output.callback_needed = true;
+	work->output.callback_delay = 500;
+
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/*
+ * output.callback_stop=true must cancel a previously scheduled callback_dwork.
+ */
+static void dm_test_process_output_callback_stop(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	/* Pre-schedule callback_dwork with a long delay so it won't fire. */
+	schedule_delayed_work(&work->callback_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	work->output.callback_stop = true;
+
+	process_output(work);
+
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->callback_dwork));
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/*
+ * output.watchdog_timer_needed=true must schedule watchdog_timer_dwork.
+ */
+static void dm_test_process_output_watchdog_needed(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	work->output.watchdog_timer_needed = true;
+	work->output.watchdog_timer_delay = 1000;
+
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/*
+ * output.watchdog_timer_stop=true must cancel a previously scheduled
+ * watchdog_timer_dwork.
+ */
+static void dm_test_process_output_watchdog_stop(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	/* Pre-schedule watchdog_timer_dwork with a long delay. */
+	schedule_delayed_work(&work->watchdog_timer_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	work->output.watchdog_timer_stop = true;
+
+	process_output(work);
+
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/*
+ * Both callback_needed and watchdog_timer_needed set: both dworks are
+ * scheduled independently.
+ */
+static void dm_test_process_output_callback_and_watchdog_needed(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	work->output.callback_needed = true;
+	work->output.callback_delay = 200;
+	work->output.watchdog_timer_needed = true;
+	work->output.watchdog_timer_delay = 800;
+
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+/* End of tests for process_output() */
+
+static struct kunit_case dm_hdcp_test_cases[] = {
+	KUNIT_CASE(dm_test_process_output_property_validate_always_scheduled),
+	KUNIT_CASE(dm_test_process_output_callback_needed),
+	KUNIT_CASE(dm_test_process_output_callback_stop),
+	KUNIT_CASE(dm_test_process_output_watchdog_needed),
+	KUNIT_CASE(dm_test_process_output_watchdog_stop),
+	KUNIT_CASE(dm_test_process_output_callback_and_watchdog_needed),
+	{}
+};
+
+static struct kunit_suite dm_hdcp_test_suite = {
+	.name = "amdgpu_dm_hdcp",
+	.test_cases = dm_hdcp_test_cases,
+};
+
+kunit_test_suite(dm_hdcp_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_hdcp");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

